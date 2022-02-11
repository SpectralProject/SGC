#version 450

// LAYOUT VERTEX DATA IN
layout(location = 0) in vec3 position;
layout(location = 1) in vec2 tc;
layout(location = 2) in vec3 normal;
layout(location = 3) in vec3 tangent;
layout(location = 4) in vec3 bitangent;

layout(binding = 0) uniform MVP {
    mat4 model; mat4 view; mat4 projection;
} mvp;

void main() {
    // OUTPUT = MODEL * VIEW * PROJ * POS

}