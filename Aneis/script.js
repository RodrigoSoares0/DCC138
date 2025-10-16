import * as THREE from "https://threejs.org/build/three.module.js";

var camera, scene, renderer, mesh;

init();

async function init()
{
	const vert = await (await fetch("vert.glsl")).text();
	const frag = await (await fetch("frag.glsl")).text();

	scene = new THREE.Scene();

	// Encontrei sobre a ortographic camera e ela seria melhor para
	// o meu objetivo de ocupar a tela inteira com o efeito.
	const aspect = window.innerWidth / window.innerHeight;
	camera = new THREE.OrthographicCamera(-1, 1, 1, -1, 0.1, 10);
	camera.position.z = 1;

	const geometry = new THREE.PlaneGeometry(2, 2); 
	
	const material = new THREE.ShaderMaterial(
	{
		uniforms:
		{
			time: {value: 0},
			u_resolution: {value: new THREE.Vector2(window.innerWidth, window.innerHeight)},
		},
		vertexShader: vert,
		fragmentShader: frag
	});

	mesh = new THREE.Mesh(geometry, material);
	scene.add(mesh);

	renderer = new THREE.WebGLRenderer({ antialias: true });
	renderer.setClearColor(0x000000, 1);
	renderer.setPixelRatio(window.devicePixelRatio);
	renderer.setSize(window.innerWidth, window.innerHeight);
	renderer.setAnimationLoop(animate);
	document.body.appendChild(renderer.domElement);

	window.addEventListener("resize", onWindowResize);
}

function onWindowResize()
{
	renderer.setSize(window.innerWidth, window.innerHeight);
	mesh.material.uniforms.u_resolution.value.set(window.innerWidth, window.innerHeight);
}

function animate(elapsedTime)
{
	mesh.material.uniforms.time.value = elapsedTime / 1000.0;
	renderer.render(scene, camera);
}