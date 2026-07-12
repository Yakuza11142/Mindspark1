#version 320 es
precision mediump float;
#include <flutter/runtime_effect.glsl>

// =========================================================================
// UNIVERSAL UNIFORM BINDING MATRIX
// =========================================================================
uniform vec2 uViewportDimensions; // Adapts automatically to ANY camera screen resolution
uniform float uTimelineDelta;     // Scaled system timeline delta tracking

// HOLOGRAM STATS MATRIX: [CentroidX, CentroidY, CoreGlow, LocalScaleFactor]
uniform vec4 uHologramStats; 

// SOURCE-AGNOSTIC GENERATED ENTITY COORDINATES MAP (Parent-Child Tracking)
// Format per track: [CurrentCoordX, CurrentCoordY, SourceEnforcedScale, ObjectLifespan]
uniform vec4 uGeneratedEntityA;
uniform vec4 uGeneratedEntityB;
uniform vec4 uGeneratedEntityC;
uniform vec4 uGeneratedEntityD;

out vec4 fragColor;

// =========================================================================
// SUB-ROUTINE: EVALUATE INDEPENDENT DECOUPLED CHILD GENERATIONS
// =========================================================================
vec4 processChildEntity(vec2 universalUV, vec4 entityTrack) {
    vec2 entityCoordinates = vec2(entityTrack.x, entityTrack.y);
    float enforcedScale = entityTrack.z;
    float entityLife = entityTrack.w;

    // Fast-path branchless cutoff for empty or dead entity slots
    if (entityLife <= 0.0 || enforcedScale <= 0.0) {
        return vec4(0.0);
    }

    // Map local tracking matrix relative to the camera source constraints
    vec2 localEntityUV = (universalUV - entityCoordinates) / enforcedScale;
    float centerDistance = length(localEntityUV);

    // Geometry Generation: Render a high-contrast procedural bounded asset box
    vec2 boxBounds = smoothstep(vec2(0.12), vec2(0.10), abs(localEntityUV));
    float structuralMask = boxBounds.x * boxBounds.y;

    // Dynamic core core pulse relative to its own independent tracking variables
    float corePulse = smoothstep(0.05, 0.0, centerDistance);
    float combinedMask = clamp(structuralMask + corePulse, 0.0, 1.0) * entityLife;

    // Saturated emerald tracking vector color space
    vec3 entityColor = vec3(0.0, 1.0, 0.5);

    return vec4(entityColor * combinedMask, combinedMask);
}

// =========================================================================
// MAIN PIPELINE EXECUTION
// =========================================================================
void main() {
    // 1. Force scale-invariant canvas mapping across any connecting device
    vec2 globalCoord = FlutterFragCoord().xy;
    globalCoord.y = uViewportDimensions.y - globalCoord.y; // Keep alignment upright
    vec2 universalUV = globalCoord / uViewportDimensions;

    // 2. Extract rigid parameters from the independent 6ft Hologram Stats layer
    float hologramScale = uHologramStats.w;
    float baseThickness = uHologramStats.z;
    vec2 hologramOrigin = vec2(uHologramStats.x, uHologramStats.y);

    // Map local space vectors for the primary parent avatar structure
    vec2 localSpaceUV = (universalUV - hologramOrigin) * hologramScale;
    vec2 bodyUV = localSpaceUV + vec2(0.0, 0.5); // Align anatomy height mapping arrays

    // Initialize layout buffers for the parent character trace
    float anatomyMask = 0.0;
    float skeletalGlow = 0.0;

    // =========================================================================
    // LAYER A: PARENT HOLOGRAM BLUEPRINT ANATOMY MATRIX
    // =========================================================================
    
    // REGION 1: HEAD & FACE (0.85 to 1.0)
    float isHead = step(0.85, bodyUV.y) * step(bodyUV.y, 1.0);
    vec2 headUV = bodyUV - vec2(0.0, 0.925);
    float headMask = smoothstep(0.14, 0.0, length(headUV * vec2(1.0, 1.25)));
    vec2 leftEye = headUV - vec2(-0.045, 0.02);
    vec2 rightEye = headUV - vec2(0.045, 0.02);
    float eyes = smoothstep(0.015, 0.0, length(leftEye)) + smoothstep(0.015, 0.0, length(rightEye));
    float mouth = smoothstep(0.008, 0.0, abs(headUV.y + 0.03 + (headUV.x * headUV.x * 2.5))) * smoothstep(0.05, 0.0, abs(headUV.x));
    float headGlow = (eyes * 0.8) + (mouth * 0.9);

    // REGION 2: NECK (0.80 to 0.85)
    float isNeck = step(0.80, bodyUV.y) * step(bodyUV.y, 0.85);
    float neckMask = smoothstep(0.05, 0.0, abs(bodyUV.x));

    // REGION 3: TORSO (0.45 to 0.80)
    float isTorso = step(0.45, bodyUV.y) * step(bodyUV.y, 0.80);
    float torsoHeightFactor = (bodyUV.y - 0.45) / 0.35;
    float dynamicShoulderWidth = mix(0.12, 0.22, smoothstep(0.0, 0.8, torsoHeightFactor));
    float waistTaper = mix(0.0, 0.04, sin(torsoHeightFactor * 3.14159));
    float calculatedTorsoWidth = dynamicShoulderWidth - waistTaper;
    float torsoMask = smoothstep(calculatedTorsoWidth, 0.0, abs(bodyUV.x));
    float torsoGlow = smoothstep(0.02, 0.0, abs(bodyUV.x)) * 0.4;

    // REGION 4: LOWER EXTENSIONS / LEGS (0.05 to 0.45)
    float isLegs = step(0.05, bodyUV.y) * step(bodyUV.y, 0.45);
    float legSpacing = 0.07;
    float activeLegAxis = min(abs(bodyUV.x - legSpacing), abs(bodyUV.x + legSpacing));
    float legHeightFactor = (bodyUV.y - 0.05) / 0.40;
    float dynamicLegThick = mix(0.04, 0.055, sin(legHeightFactor * 3.14159 + 0.5));
    float legsMask = smoothstep(dynamicLegThick, 0.0, activeLegAxis);
    float legsGlow = smoothstep(0.008, 0.0, activeLegAxis) * 0.3;

    // REGION 5: STABILITY BASE / FEET (0.0 to 0.05)
    float isFeet = step(0.0, bodyUV.y) * step(bodyUV.y, 0.05);
    float footSpread = mix(0.12, 0.06, bodyUV.y / 0.05);
    float feetMask = smoothstep(footSpread, 0.0, abs(bodyUV.x));

    // Compile absolute anatomy channels branchlessly
    anatomyMask = (isHead * headMask) + (isNeck * neckMask) + (isTorso * torsoMask) + (isLegs * legsMask) + (isFeet * feetMask);
    skeletalGlow = (isHead * headGlow) + (isTorso * torsoGlow) + (isLegs * legsGlow);

    // Compute internal scanned volume metrics
    float isInsideBody = step(0.001, anatomyMask);
    float scanlines = sin(bodyUV.y * 120.0) * 0.15 + 0.85;
    float initialVolume = isInsideBody * (anatomyMask * 0.5 * scanlines);
    float totalHologramDensity = clamp(initialVolume + skeletalGlow, 0.0, 1.0);

    // Core vector profile color for the parent avatar character
    vec3 hologramBaseColor = vec3(0.0, 0.85, 1.0); // Neon Cyan Cybernetic Core
    vec4 finalParentFrame = vec4(hologramBaseColor * totalHologramDensity, totalHologramDensity);

    // =========================================================================
    // LAYER B: INDEPENDENT CHILD GENERATED ASSET ARRAYS
    // =========================================================================
    vec4 childAccumulator = vec4(0.0);
    childAccumulator += processChildEntity(universalUV, uGeneratedEntityA);
    childAccumulator += processChildEntity(universalUV, uGeneratedEntityB);
    childAccumulator += processChildEntity(universalUV, uGeneratedEntityC);
    childAccumulator += processChildEntity(universalUV, uGeneratedEntityD);

    // =========================================================================
    // LAYER C: COMPOSITE MATTE BLIT AND ALPHA PRE-MULTIPLICATION
    // =========================================================================
    // Cleanly blend independent child items on top of the standalone parent model
    vec3 blendedRGB = mix(finalParentFrame.rgb, childAccumulator.rgb, childAccumulator.a);
    float blendedAlpha = clamp(finalParentFrame.a + childAccumulator.a, 0.0, 0.95);

    // Enforce pre-multiplied structural validation output for Flutter/Skia/Impeller pipeline stability
    fragColor = vec4(blendedRGB * blendedAlpha, blendedAlpha);
}
