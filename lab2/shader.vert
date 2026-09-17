#version 150

//in vec3 in_Color;
in vec3 in_Position;
in vec3 in_Normal;
in vec2 in_TexCoord;
uniform mat4 matrix;
uniform mat4 boneRotationMatrix;
uniform vec3 boneLocation;

out vec4 g_color;
const vec3 lightDir = normalize(vec3(0.3, 0.5, 1.0));

// Uppgift 3: Soft-skinning på GPU
//
// Flytta över din implementation av soft skinning från CPU-sidan
// till vertexshadern. Mer info finns p hemsidan.

void main(void)
{
	// transformera resultatet med ModelView- och Projection-matriserna
	// gl_Position = matrix * vec4(in_Position, 1.0);

    vec3 original = in_Position;
    vec3 rotated = original;

    rotated = rotated - boneLocation;
    rotated = (boneRotationMatrix * vec4(rotated, 1.0)).xyz;
    rotated = rotated + boneLocation;

    vec3 result = in_TexCoord.x * original + in_TexCoord.y * rotated;
    gl_Position = matrix * vec4(result, 1.0);

	// sätt röd+grön färgkanal till vertex Weights
	vec4 color = vec4(in_TexCoord.x, in_TexCoord.y, 0.0, 1.0);

	// Lägg på en enkel ljussättning på vertexarna 	
	float intensity = dot(in_Normal, lightDir);
	color.xyz *= intensity;

	g_color = color;
}

