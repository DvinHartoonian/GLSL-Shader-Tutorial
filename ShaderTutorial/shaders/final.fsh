#version 120

varying vec4 texcoord;

uniform sampler2D gcolor;

void Vignette(inout vec3 color) {

  float dist = distance(texcoord.st, vec2(0.5)) * 2.0;
  dist /= 1.5142f;

  dist = pow(dist, 1.1f);

  color.rgb *= (1.0f - dist) / 0.5;
}

vec3 converToHDR(in vec3 color) {

  vec3 HDRImage;

  vec3 overExposed = color * 1.2f;

  vec3 underExposed = color / 1.0f;

  HDRImage = mix(underExposed, overExposed, color);

  return HDRImage;
}


void main() {

  vec3 color = texture2D(gcolor, texcoord.st).rgb;

  color = converToHDR(color);

  Vignette(color);


  gl_FragColor = vec4(pow(color.rgb, vec3(1 / 2.2)), 1.0f);
}
