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

// UNROLLED DATA MATRIX: Flawless cross-platform device compilation stability
uniform vec4 uEntity0; 
uniform vec4 uEntity1; 
uniform vec4 uEntity2; 
uniform vec4 uEntity3; 
uniform vec4 uEntity4; 
uniform vec4 uEntity5; 

// HARDWARE SYSTEM EFFECTS: [ScanSpeed, ScanIntensity, TeleportGlitchTrigger, NoiseDensity]
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

    // ✅ FIXED: Corrected broken validation comparison logic
    if (entityLife  1.0) {
        return vec4(0.0);
    }

    float localDist = length(universalUV - entityCoordinates) * enforcedScale;
    float particlePulse = smoothstep(0.06, 0.0, localDist);
    
    // Cybernetic accent color for auxiliary entity dots
    vec3 accentColor = vec3(0.0, 1.0, 0.7); 
    float alphaOutput = particlePulse * entityLife * 0.75;
    
    return vec4(accentColor * alphaOutput, alphaOutput);
}

// =========================================================================
// SYSTEM MAIN EXECUTABLE ENVIRONMENT
// =========================================================================
void main() {
    // Standardize fragment mapping metrics
    vec2 universalUV = gl_FragCoord.xy / uViewportDimensions;

    // Unpack system configuration structures
    vec2 hologramOrigin  = uHologramStats.xy;
    float coreGlow       = uHologramStats.z;
    float hologramScale  = uHologramStats.w;

    float scanSpeed      = uHoloSystemFX.x;
    float scanIntensity  = uHoloSystemFX.y;
    float jumpIntensity  = uHoloSystemFX.z;
    float noiseDensity   = uHoloSystemFX.w;

    // Generate local runtime calculations
    float randomNoise    = generateHoloNoise(universalUV + vec2(uTimelineDelta));

    // Dynamic Dislocation Interference (Teleport Matrix Glitch Animation)
    if (jumpIntensity > 0.90) {
        float waveRip = sin(universalUV.y * 30.0 + uTimelineDelta * 50.0) * noiseDensity * jumpIntensity * 5.0;
        universalUV.x += (randomNoise - 0.5) * (noiseDensity * 12.0 * jumpIntensity) + waveRip;
    }

    // Map local space vectors for the primary parent avatar structure
    vec2 localSpaceUV = (universalUV - hologramOrigin) * hologramScale;
    vec2 bodyUV = localSpaceUV + vec2(0.0, 0.5); // Align anatomy height mapping arrays

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

    // Compile absolute anatomy channels branchlessly
    anatomyMask = (isHead * headMask) + (isNeck * neckMask) + (isTorso * torsoMask) + (isLegs * legsMask) + (isFeet * feetMask);
    skeletalGlow = (isHead * headGlow) + (isTorso * torsoGlow) + (isLegs * legsGlow);

    float isInsideBody = step(0.001, anatomyMask);
    float scanlines = sin(bodyUV.y * 120.0) * 0.15 + 0.85;
    float initialVolume = isInsideBody * (anatomyMask * 0.5 * scanlines);
    float totalHologramDensity = clamp(initialVolume + skeletalGlow + (coreGlow * isInsideBody), 0.0, 1.0);

    // Traveling electronic laser scan bar tracking
    float scanBarY = fract(uTimelineDelta * scanSpeed);
    float scanBarLine = smoothstep(0.02, 0.0, abs(universalUV.y - scanBarY));
    totalHologramDensity += scanBarLine * scanIntensity * isInsideBody;

    // Dematerialization alpha drop if teleporting
    totalHologramDensity *= mix(1.0, 0.15, jumpIntensity);

    vec3 hologramBaseColor = vec3(0.0, 0.85, 1.0); // Cybernetic Neon Cyan
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

    // Enforce pre-multiplied alpha layout validation for Skia/Impeller hardware performance stability
    fragColor = vec4(blendedRGB * blendedAlpha, blendedAlpha);
}
