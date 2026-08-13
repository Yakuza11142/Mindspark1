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
