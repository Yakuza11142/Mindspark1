#version 320 es
precision mediump float;
#include <flutter/runtime_effect.glsl>

uniform vec2 uViewportDimensions;
uniform float uTimelineDelta;

// [CentroidX, CentroidY + VerticalShift, CoreIntensity, LocalScaleFactor]
uniform vec4 uDataTrackA; 

// [ScanlineDensity, FrequencyDrift, WaveMagnitude, RedColorBalance]
uniform vec4 uDataTrackB; 

out vec4 fragColor;

void main() {
    // 1. Calculate standard viewport coordinates
    vec2 normalizedUV = FlutterFragCoord().xy / uViewportDimensions;

    // 2. Extract operational parameters injected from the QuantumNexus layer
    float localScaleFactor = uDataTrackA.w;
    float baseThickness = uDataTrackA.z;

    // 3. Translate coordinate arrays into scale-invariant local space
    vec2 localSpaceUV = (normalizedUV - vec2(uDataTrackA.x, uDataTrackA.y)) * localScaleFactor;

    // 4. Map the vertical y-axis origin tracking points (0.0 = Ground, 1.0 = Crown)
    vec2 bodyUV = localSpaceUV + vec2(0.0, 0.5);

    // 5. Initialize dynamic anatomy constraint variables
    float anatomicalWidthMask = 0.0;
    float skeletalCoreGlow = 0.0;
    float softInternalVolume = 0.0;

    // =========================================================================
    // BRANCHLESS VECTOR LOGIC: CALCULATE ALL LAYERS SIMULTANEOUSLY VIA MATRICES
    // =========================================================================
    
    // LAYER A: HEAD & FACE REGION (0.85 to 1.0)
    float isHead = step(0.85, bodyUV.y) * step(bodyUV.y, 1.0);
    vec2 headUV = bodyUV - vec2(0.0, 0.925);
    float headMask = smoothstep(0.14, 0.0, length(headUV * vec2(1.0, 1.25)));
    vec2 leftEye = headUV - vec2(-0.045, 0.02);
    vec2 rightEye = headUV - vec2(0.045, 0.02);
    float eyes = smoothstep(0.015, 0.0, length(leftEye)) + smoothstep(0.015, 0.0, length(rightEye));
    float mouth = smoothstep(0.008, 0.0, abs(headUV.y + 0.03 + (headUV.x * headUV.x * 2.5))) * smoothstep(0.05, 0.0, abs(headUV.x));
    float headGlow = (eyes * 0.8) + (mouth * 0.9);

    // LAYER B: NECK REGION (0.80 to 0.85)
    float isNeck = step(0.80, bodyUV.y) * step(bodyUV.y, 0.85);
    float neckMask = smoothstep(0.05, 0.0, abs(bodyUV.x));

    // LAYER C: TORSO & ARMS REGION (0.45 to 0.80)
    float isTorso = step(0.45, bodyUV.y) * step(bodyUV.y, 0.80);
    float torsoHeightFactor = (bodyUV.y - 0.45) / 0.35;
    float dynamicShoulderWidth = mix(0.12, 0.22, smoothstep(0.0, 0.8, torsoHeightFactor));
    float waistTaper = mix(0.0, 0.04, sin(torsoHeightFactor * 3.1415));
    float calculatedTorsoWidth = dynamicShoulderWidth - waistTaper;
    float torsoMask = smoothstep(calculatedTorsoWidth, 0.0, abs(bodyUV.x));
    float torsoGlow = smoothstep(0.02, 0.0, abs(bodyUV.x)) * 0.4;

    // LAYER D: THIGHS & CALVES REGION (0.05 to 0.45)
    float isLegs = step(0.05, bodyUV.y) * step(bodyUV.y, 0.45);
    float legSpacing = 0.07;
    float activeLegAxis = min(abs(bodyUV.x - legSpacing), abs(bodyUV.x + legSpacing));
    float legHeightFactor = (bodyUV.y - 0.05) / 0.40;
    float dynamicLegThick = mix(0.04, 0.055, sin(legHeightFactor * 3.1415 + 0.5));
    float legsMask = smoothstep(dynamicLegThick, 0.0, activeLegAxis);
    float legsGlow = smoothstep(0.008, 0.0, activeLegAxis) * 0.3;

    // LAYER E: FEET & BASE REGION (0.0 to 0.05)
    float isFeet = step(0.0, bodyUV.y) * step(bodyUV.y, 0.05);
    float footSpread = mix(0.12, 0.06, bodyUV.y / 0.05);
    float feetMask = smoothstep(footSpread, 0.0, abs(bodyUV.x));

    // =========================================================================
    // LAYER F: MATRIX BACKGROUND CONVOLUTION LOGIC
    // =========================================================================
    float structuralWave = sin(localSpaceUV.y * uDataTrackB.x + uTimelineDelta * uDataTrackB.y) * uDataTrackB.z;
    float backgroundIntensity = (baseThickness / localScaleFactor) / abs(localSpaceUV.x + structuralWave);

    // Condense masks and glow profiles without running a standard conditional branching route
    anatomicalWidthMask = (isHead * headMask) + (isNeck * neckMask) + (isTorso * torsoMask) + (isLegs * legsMask) + (isFeet * feetMask);
    skeletalCoreGlow = (isHead * headGlow) + (isTorso * torsoGlow) + (isLegs * legsGlow);

    // Apply clean internal volume calculation metrics using step logic flags
    float isInsideBody = step(0.001, anatomicalWidthMask);
    float scanlines = sin(bodyUV.y * uDataTrackB.x * 1.5) * 0.15 + 0.85;
    softInternalVolume = isInsideBody * (anatomicalWidthMask * 0.5 * scanlines);

    // Combine all anatomical mapping layers together
    float totalSparkComposition = clamp(softInternalVolume + skeletalCoreGlow, 0.0, 1.0);

    // =========================================================================
    // LAYER G: COMPOSITE COLOR MIX & BLIT OUTPUT
    // =========================================================================
    vec3 backgroundGridColor = vec3(uDataTrackB.w * backgroundIntensity, backgroundIntensity, backgroundIntensity * baseThickness);
    vec3 sparkCharacterColor = vec3(0.0, 0.85, 1.0); // Radiant Neon Cyan Vector Engine Profile

    // Smoothly blend the full-body character structure into the environmental grid lanes
    vec3 finalColorOutput = mix(backgroundGridColor, sparkCharacterColor, totalSparkComposition);

    // Manage scale-invariant transparency profiles cleanly across the viewport boundary
    float isSparkAlpha = step(0.001, totalSparkComposition);
    float finalAlpha = mix(clamp(backgroundIntensity, 0.0, 0.85), 0.95, isSparkAlpha);

    fragColor = vec4(finalColorOutput, finalAlpha);
}
