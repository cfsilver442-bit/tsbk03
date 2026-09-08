#version 150

in vec2 outTexCoord;

uniform sampler2D texUnit;
uniform float texSize;

out vec4 out_Color;

void main(void)
{
    float offset = 1.0 / texSize;

    vec4 c = texture(texUnit, outTexCoord);
    vec4 l = texture(texUnit, outTexCoord + vec2(offset, 0.0));
    vec4 r = texture(texUnit, outTexCoord + vec2(-offset, 0.0));

    out_Color = (l + c + c + r) * 0.25;
}