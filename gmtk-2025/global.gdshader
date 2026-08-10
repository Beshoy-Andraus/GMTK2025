shader_type canvas_item;

uniform float blur_amount = 2.0;

void fragment() {
    vec4 sum = vec4(0.0);
    vec2 size = SCREEN_PIXEL_SIZE * blur_amount;
    
    sum += texture(TEXTURE, UV - size);
    sum += texture(TEXTURE, UV + size);
    sum += texture(TEXTURE, UV + vec2(size.x, -size.y));
    sum += texture(TEXTURE, UV + vec2(-size.x, size.y));
    sum += texture(TEXTURE, UV);

    COLOR = sum / 5.0;
}
