#version 330

uniform mat4 matVP;
uniform mat4 matGeo;

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normal;

out vec4 color;
uniform mat4 viewProjection; 

mat4 rotateX(float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, c, -s, 0.0,
        0.0, s, c, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}

mat4 rotateZ(float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return mat4(
        c, -s, 0.0, 0.0,
        s, c, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}

mat4 rotateY(float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return mat4(
        c, 0.0, -s, 0.0,
        0.0, 1.0, 0.0, 0.0,
        s, 0.0, c, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}

mat4 translate(vec3 offset) {
    return mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        offset.x, offset.y, offset.z, 1.0
    );
}

mat4 scale(vec3 scaleFactor) {
    return mat4(
        scaleFactor.x, 0.0, 0.0, 0.0,
        0.0, scaleFactor.y, 0.0, 0.0,
        0.0, 0.0, scaleFactor.z, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}
void main() {
    // Calculate the angle based on the instance ID
    float angle = radians(float(gl_InstanceID) * 360.0 / float(50));

    // Use the helper functions to create transformation matrices
    mat4 rotateTransform = rotateY(angle);
    //mat4 translateTransform = translate(vec3(10.0 * cos(angle), 0.0, 10.0 * sin(angle)));  // Adjust the scale factor for a larger separation
	mat4 translateTransform = translate(vec3(10.0 * cos(angle), 0.0, 10.0 * sin(angle)));

    // Combine transformations
    mat4 transform = translateTransform * rotateTransform;



   color = vec4(abs(normal), 1.0);
   gl_Position = matVP * matGeo * transform* vec4(pos, 1);
   
}