// O Three.js preenche o atributo uv automaticamente para a PlaneGeometry.
varying vec2 vUv;

void main()
{
	// Passa a coordenada UV para o Fragment Shader.
	vUv = uv;

	// O cálculo da posição final continua o mesmo.
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}