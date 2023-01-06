#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(binding = 1) uniform sampler2D source;

layout(std140, binding = 0) uniform buf
{
    mat4 qt_Matrix;
    float qt_Opacity;
    vec4 targetColor;
    int radial;
    int samples;
    vec2 center;
    float strength;
};

void main()
{
    float softness = 0.6;
    if (radial == 0)
    {
        float radius = 3.0 / 100.0 * strength;
        float twoPi = 6.28318530718; // Pi*2
        float quality = 4.0;

        vec2 uv = qt_TexCoord0;
        vec4 texColor = vec4(0.0);

        for(float d = 0.0; d < twoPi; d += twoPi / samples)
        {
            for(float i = 1.0 / quality; i <= 1.0; i += 1.0 / quality)
            {
                 texColor += texture(source, uv + vec2(cos(d), sin(d)) * radius * i);
            }
        }

        texColor /= quality * samples - 15.0;

        float vignette = smoothstep(radius, radius - softness, 0.33);
        texColor.rgb = mix(texColor.rgb, texColor.rgb * vignette, 0.5);
        fragColor = vec4(texColor.rgb * targetColor.rgb, texColor.a * 0.5) * qt_Opacity;
    }
    else
    {
       float radius = 0.75;
       float blurStart = 1;

       vec2 uv = qt_TexCoord0;
       uv -= center;

       vec4 texColor = vec4(0.0);

       float precompute = strength * (1.0 / float(samples - 1));

       for(int i = 0; i < samples; i++)
       {
          float scale = blurStart + (float(i) * precompute);
          texColor += texture(source, uv * scale + center);
       }

       texColor /= float(samples);

       float vignette = smoothstep(radius, radius - softness, 0.33);
       texColor.rgb = mix(texColor.rgb, texColor.rgb * vignette, 0.5);
       fragColor = vec4(texColor.rgb * targetColor.rgb, texColor.a * 0.75) * qt_Opacity;
    }
}
