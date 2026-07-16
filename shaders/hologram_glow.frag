#version 320 es
precision mediump float;
#include <flutter/runtime_effect.glsl>

// =========================================================================
// UNIVERSAL UNIFORM BINDING MATRIX
// =========================================================================
uniform vec2 uViewportDimensions; 
uniform float uTimelineDelta;     

uniform vec4 uHologramStats; 

// UNROLLED DATA MATRIX: Flawless cross-platform device compilation stability
uniform vec4 uEntity0; 
uniform vec4 uEntity1; 
uniform vec4 uEntity2; 
uniform vec4 uEntity3; 
uniform vec4 uEntity4; 
uniform vec4 uEntity5; 

uniform vec4 uHoloSystemFX;

out vec4 fragColor;

// =========================================================================
// PIPELINE OPTIMIZATION: PSEUDO-RANDOM NOISE GENERATOR
// =========================================================================
float generateHoloNoise(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

// =========================================================================
// SUB-ROUTINE: EVALUATE INDEPENDENT ARTIFACT NODE TRACKS
// =========================================================================
vec4 processChildEntity(vec2 universalUV, vec4 entityTrack) {
    vec2 entityCoordinates = vec2(entityTrack.x, entityTrack.y);
    float enforcedScale = entityTrack.z;
    float entityLife = entityTrack.w;

    if (entityLife <= 0.0 || enforcedScale <= 0.0) {
        return vec4(0.0);
    }

    vec2 localEntityUV = (universalUV - entityCoordinates) / enforcedScale;
    float centerDistance = length(localEntityUV);

    vec2 boxBounds = smoothstep(vec2(0.12), vec2(0.10), abs(localEntityUV));
    float structuralMask = boxBounds.x * boxBounds.y;

    float corePulse = smoothstep(0.05, 0.0, centerDistance);
    float combinedMask = clamp(structuralMask + corePulse, 0.0, 1.0) * entityLife;

    vec3 entityColor = vec3(0.0, 1.0, 0.5);

    return vec4(entityColor * combinedMask, combinedMask);
}

void main() {
    vec2 globalCoord = FlutterFragCoord().xy;
    globalCoord.y = uViewportDimensions.y - globalCoord.y; 
    vec2 universalUV = globalCoord / uViewportDimensions;  

    float scanSpeed = uHoloSystemFX.x;
    float scanIntensity = uHoloSystemFX.y;
    float glitchTrigger = uHoloSystemFX.z;
    float noiseDensity = uHoloSystemFX.w;

    float hologramScale = uHologramStats.w;
    float baseThickness = uHologramStats.z;
    vec2 hologramOrigin = vec2(uHologramStats.x, uHologramStats.y);

    vec2 localSpaceUV = (universalUV - hologramOrigin) * hologramScale;
    vec2 bodyUV = localSpaceUV + vec2(0.0, 0.5); 

    float anatomyMask = 0.0;
    float skeletalGlow = 0.0;

    // REGION 1: HEAD & FACE
    float isHead = step(0.85, bodyUV.y) * step(bodyUV.y, 1.0);
    vec2 headUV = bodyUV - vec2(0.0, 0.925);
    float headMask = smoothstep(0.14, 0.0, length(headUV * vec2(1.0, 1.25)));
    vec2 leftEye = headUV - vec2(-0.045, 0.02);
    vec2 rightEye = headUV - vec2(0.045, 0.02);
    float eyes = smoothstep(0.015, 0.0, length(leftEye)) + smoothstep(0.015, 0.0, length(rightEye));
    float mouth = smoothstep(0.008, 0.0, abs(headUV.y + 0.03 + (headUV.x * headUV.x * 2.5))) * smoothstep(0.05, 0.0, abs(headUV.x));
    float headGlow = (eyes * 0.8) + (mouth * 0.9);

    // REGION 2: NECK
    float isNeck = step(0.80, bodyUV.y) * step(bodyUV.y, 0.85);
    float neckMask = smoothstep(0.05, 0.0, abs(bodyUV.x));

    // REGION 3: TORSO
    float isTorso = step(0.45, bodyUV.y) * step(bodyUV.y, 0.80);
    float torsoHeightFactor = (bodyUV.y - 0.45) / 0.35;
    float dynamicShoulderWidth = mix(0.12, 0.22, smoothstep(0.0, 0.8, torsoHeightFactor));
    float waistTaper = mix(0.0, 0.04, sin(torsoHeightFactor * 3.14159));
    float calculatedTorsoWidth = dynamicShoulderWidth - waistTaper;
    float torsoMask = smoothstep(calculatedTorsoWidth, 0.0, abs(bodyUV.x));
    float torsoGlow = smoothstep(0.02, 0.0, abs(bodyUV.x)) * 0.4;

    // REGION 4: LOWER EXTENSIONS / LEGS
    float isLegs = step(0.05, bodyUV.y) * step(bodyUV.y, 0.45);
    float legSpacing = 0.07;
    float activeLegAxis = min(abs(bodyUV.x - legSpacing), abs(bodyUV.x + legSpacing));
    float legHeightFactor = (bodyUV.y - 0.05) / 0.40;
    float dynamicLegThick = mix(0.04, 0.055, sin(legHeightFactor * 3.14159 + 0.5));
    float legsMask = smoothstep(dynamicLegThick, 0.0, activeLegAxis);
    float legsGlow = smoothstep(0.008, 0.0, activeLegAxis) * 0.3;

    // REGION 5: STABILITY BASE / FEET
    float isFeet = step(0.0, bodyUV.y) * step(bodyUV.y, 0.05);
    float footSpread = mix(0.12, 0.06, bodyUV.y / 0.05);
    float feetMask = smoothstep(footSpread, 0.0, abs(bodyUV.x));

    anatomyMask = (isHead * headMask) + (isNeck * neckMask) + (isTorso * torsoMask) + (isLegs * legsMask) + (isFeet * feetMask);
    skeletalGlow = (isHead * headGlow) + (isTorso * torsoGlow) + (isLegs * legsGlow);

    float isInsideBody = step(0.001, anatomyMask);
    float scanlines = sin(bodyUV.y * 120.0) * 0.15 + 0.85;
    float initialVolume = isInsideBody * (anatomyMask * 0.5 * scanlines);
    float totalHologramDensity = clamp(initialVolume + skeletalGlow, 0.0, 1.0);

    // Procedural laser scanning bar traveling down the 6-foot projection axis
    float scanBarY = fract(uTimelineDelta * scanSpeed);
    float scanBarLine = smoothstep(0.02, 0.0, abs(universalUV.y - scanBarY));
    totalHologramDensity += scanBarLine * scanIntensity * isInsideBody;

    // Camera feedback glitch pipeline
    float randomNoise = generateHoloNoise(vec2(uTimelineDelta, universalUV.y));
    if (randomNoise < glitchTrigger) {
        universalUV.x += (randomNoise - 0.5) * noiseDensity;
    }

    vec3 hologramBaseColor = vec3(0.0, 0.85, 1.0); 
    vec4 finalParentFrame = vec4(hologramBaseColor * totalHologramDensity, totalHologramDensity);

    // =========================================================================
    // LAYER B: EXPLICIT UNROLLED BLENDING (Ensures Cross-Platform Security)
    // =========================================================================
    vec4 childAccumulator = vec4(0.0);
    childAccumulator += processChildEntity(universalUV, uEntity0);
    childAccumulator += processChildEntity(universalUV, uEntity1);
    childAccumulator += processChildEntity(universalUV, uEntity2);
    childAccumulator += processChildEntity(universalUV, uEntity3);
    childAccumulator += processChildEntity(universalUV, uEntity4);
    childAccumulator += processChildEntity(universalUV, uEntity5);

    vec3 blendedRGB = mix(finalParentFrame.rgb, childAccumulator.rgb, childAccumulator.a);
    float blendedAlpha = clamp(finalParentFrame.a + childAccumulator.a, 0.0, 0.95);

    fragColor = vec4(blendedRGB * blendedAlpha, blendedAlpha);
}
