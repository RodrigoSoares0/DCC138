uniform float time;
uniform vec2 u_resolution;

varying vec2 vUv;

void main()
{
    // Centraliza a animação e preenche a tela utilizando UV
    vec2 uv = vUv * 2.0 - 1.0;
    uv.x *= u_resolution.x / u_resolution.y;

    float d = length(uv);

    // Animação... aqui eu consigo alterar a velocidade com a qual os circulos são desenhados mudando o multiplicador
    float speed = time + pow(time, 1.5) * 0.8;

    // Cria os anéis repetidos
    float mult = 0.5;
    float ring_wave = fract(d * mult - speed);

    //float ring_wave = fract(d * (mult + time * 1.0) - speed);

    // A espessura base para os anéis
    float base_thickness = 1.5;

    // A espessura final
    float thickness = base_thickness + d * 0.05;

    float intensity = smoothstep(1.0 - thickness, 1.0, ring_wave);
    
    // Cor utilizando tempo linear
    vec3 green  = vec3(0.0, 1.0, 0.0);
    vec3 red    = vec3(1.0, 0.0, 0.0);
    vec3 yellow = vec3(1.0, 1.0, 0.0);
    vec3 white  = vec3(1.0, 1.0, 1.0);
    
    vec3 color = green;
    
    float duration = 7.0;
    
    if (time < duration) 
    {
        float progress = time / duration;
        color = mix(green, red, progress);
    }
    else if (time < duration * 2.0) 
    {
        float progress = (time - duration) / duration;
        color = mix(red, yellow, progress);
    }
    else if (time < duration * 3.0) 
    {
        float progress = (time - (duration * 2.0)) / duration;
        color = mix(yellow, white, progress);
    }
    else 
    {
        color = white;
    }

    gl_FragColor = vec4(color * intensity, 1.0);
}