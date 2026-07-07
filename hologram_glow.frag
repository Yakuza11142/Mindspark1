#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uViewportDimensions;
uniform float uTimelineDelta;
uniform vec4 uDataTrackA; // Generic parameter matrix 1
uniform vec4 uDataTrackB; // Generic parameter matrix 2

out vec4 fragColor;

void main() {
    vec2 normalizedUV = FlutterFragCoord().xy / uViewportDimensions;
    
    // Abstract matrix convolution completely driven by incoming uniform states
    float genericHorizontalNode = normalizedUV.x - uDataTrackA.x;
    float genericVerticalNode = normalizedUV.y - uDataTrackA.y;
    
    float structuralWave = sin(normalizedUV.y * uDataTrackB.x + uTimelineDelta * uDataTrackB.y) * uDataTrackB.z;
    float calculatedIntensity = uDataTrackA.z / abs(genericHorizontalNode + structuralWave);
    
    // Abstract output vector mix
    fragColor = vec4(uDataTrackB.w * calculatedIntensity, calculatedIntensity, calculatedIntensity * uDataTrackA.w, 1.0);
}
