// Vertex Shader (Main(VS))
#version 330

layout (location = 0) in vec2 pos;
out vec3 vertexColor; // Output variable for vertex color
uniform float uTime; // Uniform to pass time from JavaScript
uniform vec2 uResolution; // Uniform to pass screen resolution

void main() {
    // Define vertex positions
    vec2 vertex1 = vec2(0.0, 0.2);    // Top vertex
    vec2 vertex2 = vec2(-0.2, -0.2);  // Bottom-left vertex
    vec2 vertex3 = vec2(0.2, -0.2);   // Bottom-right vertex

    // Define vertex colors
    vec3 color1 = vec3(1.0, 0.0, 0.0);  // Red for top vertex
    vec3 color2 = vec3(0.0, 1.0, 0.0);  // Green for bottom-left vertex
    vec3 color3 = vec3(0.0, 0.0, 1.0);  // Blue for bottom-right vertex


    // Calculate the aspect ratio of the screen
    float aspectRatio = uResolution.x / uResolution.y;

    // Calculate the scale factor based on the screen size
    float scale = 0.2 * aspectRatio; // Adjust the scale factor as needed

    // Create oscillating motions in both x and y directions
    float displacementX = sin(uTime) * 0.1; // Adjust for horizontal motion range
    float displacementY = cos(uTime) * 0.1; // Adjust for vertical motion range

    // Combine the custom vertices with the displacements and scale
    vec2 newPosition = scale * (vec2(vertex1.x + displacementX, vertex1.y + displacementY) + pos);

    // Interpolate vertex colors using gl_VertexID
    if (gl_VertexID == 0) {
        vertexColor = color1;
    } else if (gl_VertexID == 1) {
        vertexColor = color2;
    } else if (gl_VertexID == 2) {
        vertexColor = color3;
    }

    // Set the final position
    gl_Position = vec4(newPosition, 0.0, 1.0);
}
