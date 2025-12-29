shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : hint_screen_texture;
uniform float levels : hint_range(0.0, 100.0, 0.1);
uniform vec2 gamma;

void vertex() {
	POSITION = vec4(VERTEX.xy,1.0,1.0);
}

void fragment() {
	vec4 color = texture(screen_texture,SCREEN_UV);
	
	color.rgb = pow(color.rgb,vec3(gamma.x));
	
	float grayscale = max(color.r,max(color.g,color.b));
	float lower = floor(grayscale * levels) / levels;
	float higher = ceil(grayscale * levels) / levels;
	
	float lower_diff = abs(lower - grayscale);
	float higher_diff = abs(higher - grayscale);
	
	float level = lower_diff < higher_diff ? lower : higher;
	float adjustment = level / grayscale;
	
	color.rgb *= adjustment;
	color.rgb = pow(color.rgb,vec3(gamma.y));
	
	ALBEDO = color.rgb;
	ALPHA = color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
