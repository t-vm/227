shader_type canvas_item;
uniform int ke_s:hint_range(0, 32) = 1;
uniform sampler2D aa: hint_screen_texture,filter_linear_mipmap;
void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 tx = texture(aa,uv);
	vec4 sum = vec4(0);
	int cnt = 0;
	for(int y = -ke_s;y<=ke_s;y+=1){
		for(int x = -ke_s;x<=ke_s;x+=1){
			sum+=texture(aa,uv+vec2(float(x),float(y))*SCREEN_PIXEL_SIZE);
			cnt ++;
		}
	}
	sum /= float(cnt);
	COLOR = vec4(sum.xyz,tx.a);
}