shader_type canvas_item;

uniform vec4 blend_color: source_color = vec4(1.0);

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	if (pixel_color.a > 0.1){
		COLOR = mix(pixel_color, blend_color, 0.5);
	}
}