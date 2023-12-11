#version 330

uniform vec3 uCameraPosition;
in vec3 vFragPos;
in vec3 vNormal;
out vec4 FragColor;

const vec3 uAmbientLightColor = vec3(0.1, 0.1, 0.1);
const vec3 ambientReflectivity = vec3(0.3, 0.3, 0.3);

const vec3 uDirectionalLightColor = vec3(1.0, 1.0, 1.0);
const vec3 directionalLightDirection = normalize(vec3(-1.0, -1.0, -1.0));
const vec3 diffuseReflectivity = vec3(0.7, 0.7, 0.7);

const vec3 specularReflectivity = vec3(1.0, 1.0, 1.0);
const float shininess = 32.0;

// Point Light definitions
const vec3 uPointLightPosition = vec3(0.0, 0.0, 0.0); // Example position
const vec3 uPointLightColor = vec3(1.0, 1.0, 1.0); // Example color
const float uPointLightIntensity = 50.0; // Adjust for desired intensity

void main() {
    // Ambient
    vec3 ambient = uAmbientLightColor * ambientReflectivity;

    // Diffuse (Directional light)
    vec3 norm = normalize(vNormal);
    float diff = max(dot(norm, directionalLightDirection), 0.0);
    vec3 diffuseDirectional = diff * uDirectionalLightColor * diffuseReflectivity;

    // Specular (Blinn-Phong - Directional light)
    vec3 viewDir = normalize(uCameraPosition - vFragPos);
    vec3 halfDir = normalize(directionalLightDirection + viewDir);
    float spec = pow(max(dot(norm, halfDir), 0.0), shininess);
    vec3 specularDirectional = spec * uDirectionalLightColor * specularReflectivity;

    // Point Light calculations
    vec3 lightDir = normalize(uPointLightPosition - vFragPos);
    float pointDiff = max(dot(norm, lightDir), 0.0);
    vec3 diffusePoint = pointDiff * uPointLightColor * diffuseReflectivity;

    vec3 halfDirPoint = normalize(lightDir + viewDir);
    float specPoint = pow(max(dot(norm, halfDirPoint), 0.0), shininess);
    vec3 specularPoint = specPoint * uPointLightColor * specularReflectivity;

    // Intensity scaling for point light
    float distanceToPoint = distance(uPointLightPosition, vFragPos);
    float attenuation = uPointLightIntensity / (distanceToPoint * distanceToPoint);
    diffusePoint *= attenuation;
    specularPoint *= attenuation;

    vec3 result = ambient + diffuseDirectional + specularDirectional + diffusePoint + specularPoint;
    FragColor = vec4(result, 1.0);
}
