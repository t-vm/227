shader_type canvas_item;
uniform int ke_s:hint_range(0, 32) = 20;
uniform sampler2D aa: hint_screen_texture,filter_linear_mipmap;
void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 tx = texture(aa,uv);
	vec3 L = vec3(tx.r*3.5,tx.g*3.5,tx.b*3.5);
	COLOR = vec4(L.xyz,1);
}