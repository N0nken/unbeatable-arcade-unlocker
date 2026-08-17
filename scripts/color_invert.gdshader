shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture;
uniform bool enabled = false;


void fragment() {
	COLOR.a = 0.0;
	
	if (enabled) {
		vec4 screen_color = texture(screen_texture, UV);
		COLOR = vec4(vec3(1.0, 1.0, 1.0) - screen_color.rgb, screen_color.a);
	}
}
