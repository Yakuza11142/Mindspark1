#version 460 core
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
    // This allows Spark to scale smoothly without breaking geometry proportions
    vec2 localSpaceUV = (normalizedUV - vec2(uDataTrackA.x, uDataTrackA.y)) * localScaleFactor;

    // 4. Map the vertical y-axis origin tracking points (0.0 = Ground, 1.0 = Crown)
    // Shift coordinate space so the model sits symmetrically inside the vector field
    vec2 bodyUV = localSpaceUV + vec2(0.0, 0.5);

    // 5. Initialize dynamic anatomy constraint variables
    float anatomicalWidthMask = 0.0;
    float skeletalCoreGlow = 0.0;
    float softInternalVolume = 0.0;

    // =========================================================================
    // LAYER A: HEAD & FACE REGION (UV.y from 0.85 to 1.0)
    // =========================================================================
    if (bodyUV.y >= 0.85 && bodyUV.y <= 1.0) {
        vec2 headUV = bodyUV - vec2(0.0, 0.925);
        anatomicalWidthMask = smoothstep(0.14, 0.0, length(headUV * vec2(1.0, 1.25)));
        
        // Model friendly, soft-glowing eye nodes
        vec2 leftEye = headUV - vec2(-0.045, 0.02);
        vec2 rightEye = headUV - vec2(0.045, 0.02);
        float eyes = smoothstep(0.015, 0.0, length(leftEye)) + smoothstep(0.015, 0.0, length(rightEye));
        
        // Model a welcoming, smiling mouth vector curve
        float mouth = smoothstep(0.008, 0.0, abs(headUV.y + 0.03 + (headUV.x * headUV.x * 2.5))) 
                      * smoothstep(0.05, 0.0, abs(headUV.x));
                      
        skeletalCoreGlow = (eyes * 0.8) + (mouth * 0.9);
    }
    
    // =========================================================================
    // LAYER B: NECK REGION (UV.y from 0.80 to 0.85)
    // =========================================================================
    else if (bodyUV.y >= 0.80 && bodyUV.y < 0.85) {
        // Choke the glowing width tightly inward to form a thin neck pillar
        anatomicalWidthMask = smoothstep(0.05, 0.0, abs(bodyUV.x));
    }
    
    // =========================================================================
    // LAYER C: TORSO & ARMS REGION (UV.y from 0.45 to 0.80)
    // =========================================================================
    else if (bodyUV.y >= 0.45 && bodyUV.y < 0.80) {
        float torsoHeightFactor = (bodyUV.y - 0.45) / 0.35; // Normalized torso range
        
        // Model broad shoulders that taper down cleanly into a masculine waistline
        float dynamicShoulderWidth = mix(0.12, 0.22, smoothstep(0.0, 0.8, torsoHeightFactor));
        float waistTaper = mix(0.0, 0.04, sin(torsoHeightFactor * 3.1415));
        float calculatedTorsoWidth = dynamicShoulderWidth - waistTaper;
        
        anatomicalWidthMask = smoothstep(calculatedTorsoWidth, 0.0, abs(bodyUV.x));
        
        // Render a soft central chest/spine core illumination ridge
        skeletalCoreGlow = smoothstep(0.02, 0.0, abs(bodyUV.x)) * 0.4;
    }
    
    // =========================================================================
    // LAYER D: THIGHS & CALVES REGION (UV.y from 0.05 to 0.45)
    // =========================================================================
    else if (bodyUV.y >= 0.05 && bodyUV.y < 0.45) {
        // Split the single trunk calculation into two symmetric leg paths
        float legSpacing = 0.07;
        float leftLeg = abs(bodyUV.x - legSpacing);
        float rightLeg = abs(bodyUV.x + legSpacing);
        float activeLegAxis = min(leftLeg, rightLeg);
        
        float legHeightFactor = (bodyUV.y - 0.05) / 0.40;
        // Shape the natural muscle swelling and tapering of human calves and thighs
        float dynamicLegThick = mix(0.04, 0.055, sin(legHeightFactor * 3.1415 + 0.5));
        
        anatomicalWidthMask = smoothstep(dynamicLegThick, 0.0, activeLegAxis);
        skeletalCoreGlow = smoothstep(0.008, 0.0, activeLegAxis) * 0.3;
    }
    
    // =========================================================================
    // LAYER E: FEET & BASE REGION (UV.y from 0.0 to 0.05)
    // =========================================================================
    else if (bodyUV.y >= 0.0 && bodyUV.y < 0.05) {
        // Flatten and widen the tracking paths outward to anchor his feet firmly to the floor
        float footSpread = mix(0.12, 0.06, bodyUV.y / 0.05);
        anatomicalWidthMask = smoothstep(footSpread, 0.0, abs(bodyUV.x));
    }

    // =========================================================================
    // LAYER F: MATRIX BACKGROUND CONVOLUTION LOGIC
    // =========================================================================
    // Your exact mathematical matrix wave equation, processing flawlessly in background space
    float structuralWave = sin(localSpaceUV.y * uDataTrackB.x + uTimelineDelta * uDataTrackB.y) * uDataTrackB.z;
    float backgroundIntensity = (baseThickness / localScaleFactor) / abs(localSpaceUV.x + structuralWave);

    // Generate internal volumetric particle glow bound cleanly inside Spark's skin shell
    if (anatomicalWidthMask > 0.0) {
        // Generate micro-frequency scanline grids across the body surface
        float scanlines = sin(bodyUV.y * uDataTrackB.x * 1.5) * 0.15 + 0.85;
        softInternalVolume = anatomicalWidthMask * 0.5 * scanlines;
    }

    // Combine all anatomical mapping layers together
    float totalSparkComposition = clamp(softInternalVolume + skeletalCoreGlow, 0.0, 1.0);

    // =========================================================================
    // LAYER G: COMPOSITE COLOR MIX & BLIT OUTPUT
    // =========================================================================
    // Mix your input parameters directly into the final vector composition loop
    vec3 backgroundGridColor = vec3(uDataTrackB.w * backgroundIntensity, backgroundIntensity, backgroundIntensity * baseThickness);
    vec3 sparkCharacterColor = vec3(0.0, 0.85, 1.0); // Radiant Neon Cyan Vector Engine Profile

    // Smoothly blend the full-body character structure into the environmental grid lanes
    vec3 finalColorOutput = mix(backgroundGridColor, sparkCharacterColor, totalSparkComposition);
    
    // Manage scale-invariant transparency profiles cleanly across the viewport boundary
    float finalAlpha = totalSparkComposition > 0.0 ? 0.95 : clamp(backgroundIntensity, 0.0, 0.85);

    fragColor = vec4(finalColorOutput, finalAlpha);
}
