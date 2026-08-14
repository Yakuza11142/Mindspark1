package com.mindspark.mindspark1

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import io.github.sceneview.ar.ArSceneView
import io.github.sceneview.ar.node.ArModelNode
import com.google.ar.core.TrackingState
import java.nio.ByteBuffer
import java.nio.ByteOrder

class ArLabNativeView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String, Any>?
) : PlatformView {

    private val sceneView: ArSceneView = ArSceneView(context)
    private val eventChannel = MethodChannel(messenger, "com.mindspark.mindspark1/arlab_sync_$id")
    
    // Core Engine Structural Memory Allocation Pools
    private var primaryHologramCore: ArModelNode? = null
    private val subEntitiesArray = ArrayList<ArModelNode>(6)
    
    // Pre-allocated flat buffer memory layer to prevent Garbage Collection overhead at 60 FPS
    private val nativeMatrixPayload = FloatArray(28) // [pX, pY, pScale, coreGlow, ... 6 entities * 4 floats]

    init {
        configureEngineHardware()
        
        // Zero-allocation high-frequency rendering loop execution engine
        sceneView.onFrame = { _ ->
            val activeCamera = sceneView.arSession?.camera
            if (activeCamera != null && activeCamera.trackingState == TrackingState.TRACKING) {
                executeSIMDSpatialProjection()
            }
        }

        eventChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "allocateCoreHologram" -> {
                    instantiateCoreNode(context)
                    result.success(true)
                }
                "injectDynamicSubNode" -> {
                    val x = (call.argument<Double>("x") ?: 0.0).toFloat()
                    val z = (call.argument<Double>("z") ?: 0.0).toFloat()
                    instantiateSubNode(context, x, z)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun configureEngineHardware() {
        sceneView.apply {
            planeRenderer.isEnabled = true
            isDepthOcclusionEnabled = true
            // Maximize hardware execution performance metrics
            keepScreenOn = true
        }
    }

    private fun instantiateCoreNode(context: Context) {
        primaryHologramCore = ArModelNode(sceneView.engine).apply {
            loadModelGlbAsync(context, "models/anatomy_core.glb")
            isPositionEditable = true
            isRotationEditable = true
        }
        sceneView.addChild(primaryHologramCore!!)
    }

    private fun instantiateSubNode(context: Context, offsetX: Float, offsetZ: Float) {
        if (subEntitiesArray.size >= 6) return
        val entityNode = ArModelNode(sceneView.engine).apply {
            loadModelGlbAsync(context, "models/particle_node.glb")
            position = io.github.sceneview.math.Position(offsetX, 0.0f, offsetZ)
        }
        sceneView.addChild(entityNode)
        subEntitiesArray.add(entityNode)
    }

    private fun executeSIMDSpatialProjection() {
        val coreNode = primaryHologramCore ?: return
        val viewMatrix = sceneView.cameraNode.viewMatrix
        val projectionMatrix = sceneView.cameraNode.projectionMatrix

        // 1. Transform parent entity spatial anchor vectors
        val parentScreen = project3DToNormalizedUV(coreNode.worldPosition, viewMatrix, projectionMatrix)
        nativeMatrixPayload[0] = parentScreen[0] // CentroidX
        nativeMatrixPayload[1] = parentScreen[1] // CentroidY
        nativeMatrixPayload[2] = coreNode.worldScale.x // LocalScaleFactor
        nativeMatrixPayload[3] = 0.35f // CoreGlow Base Emission Constant

        // 2. Loop through tracking registers using a single contiguous memory block
        for (index in 0 until 6) {
            val registerOffset = 4 + (index * 4)
            if (index < subEntitiesArray.size) {
                val node = subEntitiesArray[index]
                val screenPos = project3DToNormalizedUV(node.worldPosition, viewMatrix, projectionMatrix)
                
                nativeMatrixPayload[registerOffset]     = screenPos[0] // Entity.x (UV)
                nativeMatrixPayload[registerOffset + 1] = screenPos[1] // Entity.y (UV)
                nativeMatrixPayload[registerOffset + 2] = node.worldScale.x // Entity Scale
                nativeMatrixPayload[registerOffset + 3] = if (node.isVisible) 1.0f else 0.0f // Life State
            } else {
                // Clear unused memory registers to prevent data bleeding
                nativeMatrixPayload[registerOffset]     = 0.0f
                nativeMatrixPayload[registerOffset + 1] = 0.0f
                nativeMatrixPayload[registerOffset + 2] = 0.0f
                nativeMatrixPayload[registerOffset + 3] = -1.0f // Explicitly deactivates the element within the GPU
            }
        }

        // Fast path data pass via continuous binary stream buffer
        val byteBuffer = ByteBuffer.allocateDirect(nativeMatrixPayload.size * 4).apply {
            order(ByteOrder.nativeOrder())
            asFloatBuffer().put(nativeMatrixPayload)
            rewind()
        }

        activity?.runOnUiThread {
            eventChannel.invokeMethod("onMatrixBufferSync", byteBuffer.array())
        }
    }

    private fun project3DToNormalizedUV(
        worldPos: io.github.sceneview.math.Position,
        viewMatrix: io.github.sceneview.math.Mat4,
        projectionMatrix: io.github.sceneview.math.Mat4
    ): FloatArray {
        // High-performance perspective transformation matrix multiplication line
        val clipSpace = projectionMatrix * (viewMatrix * io.github.sceneview.math.Vector4(worldPos.x, worldPos.y, worldPos.z, 1.0f))
        if (clipSpace.w == 0.0f) return floatArrayOf(0.5f, 0.5f)

        // Perform standard perspective homogeneous division steps
        val ndcX = clipSpace.x / clipSpace.w
        val ndcY = clipSpace.y / clipSpace.w

        // Convert Normalized Device Coordinates smoothly to the 0.0 - 1.0 sampling space
        return floatArrayOf((ndcX + 1.0f) * 0.5f, (1.0f - ndcY) * 0.5f)
    }

    override fun getView(): View = sceneView

    override fun dispose() {
        eventChannel.setMethodCallHandler(null)
        sceneView.destroy()
    }
}
#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

// =========================================================================
// UNIVERSAL BINDING MATRIX (FLUTTER RECOGNIZED REGISTERS)
// =========================================================================
uniform vec2 uViewportDimensions; 
uniform float uTimelineDelta;     

// HOLOGRAM STATS MATRIX: [CentroidX, CentroidY, CoreGlow, LocalScaleFactor]
uniform vec4 uHologramStats;      

// HARDWARE SYSTEM EFFECTS: [ScanSpeed, ScanIntensity, TeleportGlitchTrigger, NoiseDensity]
uniform vec4 uHoloSystemFX;       

// UNROLLED DATA MATRIX: Sequential user-defined entity track arrays
uniform vec4 uEntity0; 
uniform vec4 uEntity1; 
uniform vec4 uEntity2; 
uniform vec4 uEntity3; 
uniform vec4 uEntity4; 
uniform vec4 uEntity5; 

layout(location = 0) out vec4 o_FragColor;

// TEMPORALLY STABLE NOISE GENERATOR
float generateHoloNoise(vec2 co) {
    float dotProduct = dot(co, vec2(12.9898, 78.233));
    return fract(sin(mod(dotProduct, 3.141592653589793)) * 43758.5453);
}

// BRANCHLESS CHILD ENTITY EVALUATION
vec4 processChildEntity(vec2 universalUV, vec4 entityTrack, float globalScale) {
    vec2 entityCoordinates = vec2(entityTrack.x, entityTrack.y);

    // Scale-adaptive entity distance check
    float enforcedScale = entityTrack.z * globalScale;
    float entityLife = entityTrack.w;

    float operationalMask = step(0.001, entityLife) * step(entityLife, 1.0);

    float localDist = length(universalUV - entityCoordinates) * enforcedScale;
    float particlePulse = smoothstep(0.06, 0.0, localDist);

    vec3 accentColor = vec3(0.0, 1.0, 0.7); 
    float alphaOutput = particlePulse * entityLife * 0.75 * operationalMask;

    return vec4(accentColor * alphaOutput, alphaOutput);
}

void main() {
    // Screen UV Space
    vec2 universalUV = FlutterFragCoord().xy / uViewportDimensions.xy;

    // Unpack parameters
    vec2 hologramOrigin  = uHologramStats.xy;
    float coreGlow       = uHologramStats.z;

    // Dynamic Logarithmic Scaling Factor passed from Dart
    float hologramScale  = max(uHologramStats.w, 0.000001);

    float scanSpeed      = uHoloSystemFX.x;
    float scanIntensity  = uHoloSystemFX.y;
    float jumpIntensity  = uHoloSystemFX.z;
    float noiseDensity   = uHoloSystemFX.w;

    float boundedTime = mod(uTimelineDelta, 100.0);
    float randomNoise = generateHoloNoise(universalUV + vec2(boundedTime));

    // Glitch Offset
    float glitchMask = step(0.90, jumpIntensity);
    float waveRip = sin(universalUV.y * 30.0 + boundedTime * 50.0) * noiseDensity * jumpIntensity * 5.0;
    float xOffset = ((randomNoise - 0.5) * (noiseDensity * 12.0 * jumpIntensity) + waveRip) * glitchMask;
    universalUV.x += xOffset;

    // =========================================================================
    // INFINITE SCALE COORDINATE TRANSFORMATION
    // =========================================================================
    // Dynamic UV scaling relative to centroid origin
    vec2 localSpaceUV = (universalUV - hologramOrigin) * hologramScale;
    vec2 bodyUV = localSpaceUV + vec2(0.0, 0.5); 

    // ANATOMY MAPPING (Scale Independent)
    float anatomyMask = 0.0;
    float skeletalGlow = 0.0;

    // Head
    float isHead = step(0.85, bodyUV.y) * step(bodyUV.y, 1.0);
    vec2 headUV = bodyUV - vec2(0.0, 0.925);
    float headMask = smoothstep(0.14, 0.0, length(headUV * vec2(1.0, 1.25)));
    vec2 leftEye = headUV - vec2(-0.045, 0.02);
    vec2 rightEye = headUV - vec2(0.045, 0.02);
    float eyes = smoothstep(0.015, 0.0, length(leftEye)) + smoothstep(0.015, 0.0, length(rightEye));
    float headGlow = eyes * 0.8;

    // Neck
    float isNeck = step(0.80, bodyUV.y) * step(bodyUV.y, 0.85);
    float neckMask = smoothstep(0.05, 0.0, abs(bodyUV.x));

    // Torso
    float isTorso = step(0.45, bodyUV.y) * step(bodyUV.y, 0.80);
    float torsoHeightFactor = (bodyUV.y - 0.45) / 0.35;
    float dynamicShoulderWidth = mix(0.12, 0.22, smoothstep(0.0, 0.8, torsoHeightFactor));
    float torsoMask = smoothstep(dynamicShoulderWidth, 0.0, abs(bodyUV.x));
    float torsoGlow = smoothstep(0.02, 0.0, abs(bodyUV.x)) * 0.4;

    // Legs
    float isLegs = step(0.05, bodyUV.y) * step(bodyUV.y, 0.45);
    float activeLegAxis = min(abs(bodyUV.x - 0.07), abs(bodyUV.x + 0.07));
    float legsMask = smoothstep(0.05, 0.0, activeLegAxis);

    // Feet
    float isFeet = step(0.0, bodyUV.y) * step(bodyUV.y, 0.05);
    float feetMask = smoothstep(0.1, 0.0, abs(bodyUV.x));

    anatomyMask = (isHead * headMask) + (isNeck * neckMask) + (isTorso * torsoMask) + (isLegs * legsMask) + (isFeet * feetMask);
    skeletalGlow = (isHead * headGlow) + (isTorso * torsoGlow);

    float isInsideBody = step(0.001, anatomyMask);

    // =========================================================================
    // DYNAMIC SCALE-ADAPTIVE SCANLINES
    // =========================================================================
    // Modulates frequency based on hologramScale so pattern stays crisp at infinite zoom
    float dynamicFrequency = mix(120.0, 120.0 * log2(hologramScale + 1.0), step(1.0, hologramScale));
    float scanlines = sin(bodyUV.y * dynamicFrequency) * 0.15 + 0.85;

    float initialVolume = isInsideBody * (anatomyMask * 0.5 * scanlines);
    float totalHologramDensity = clamp(initialVolume + skeletalGlow + (coreGlow * isInsideBody), 0.0, 1.0);

    // Dynamic laser scan bar
    float scanBarY = fract(boundedTime * scanSpeed);
    float scanBarLine = smoothstep(0.02, 0.0, abs(universalUV.y - scanBarY));
    totalHologramDensity += scanBarLine * scanIntensity * isInsideBody;

    vec3 hologramBaseColor = vec3(0.0, 0.85, 1.0); // Cybernetic Cyan
    vec4 finalParentFrame = vec4(hologramBaseColor * totalHologramDensity, totalHologramDensity);

    // Child entity layer accumulation
    vec4 childAccumulator = vec4(0.0);
    childAccumulator += processChildEntity(universalUV, uEntity0, hologramScale);
    childAccumulator += processChildEntity(universalUV, uEntity1, hologramScale);
    childAccumulator += processChildEntity(universalUV, uEntity2, hologramScale);
    childAccumulator += processChildEntity(universalUV, uEntity3, hologramScale);
    childAccumulator += processChildEntity(universalUV, uEntity4, hologramScale);
    childAccumulator += processChildEntity(universalUV, uEntity5, hologramScale);

    vec3 blendedRGB = finalParentFrame.rgb + childAccumulator.rgb * (1.0 - finalParentFrame.a);
    float blendedAlpha = clamp(finalParentFrame.a + childAccumulator.a * (1.0 - finalParentFrame.a), 0.0, 0.95);

    o_FragColor = vec4(blendedRGB, blendedAlpha);
}