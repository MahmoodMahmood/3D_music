// Add (hard code) an orbiting (point or directional) light to the scene. Light
// the scene using the Blinn-Phong Lighting Model.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
out vec3 color;
// expects: PI, blinn_phong
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  float theta = 0.2*M_PI*animation_seconds;

  vec3 ka = is_moon ? vec3(0.1,0.1,0.1) : vec3(0,0,0.2);
  vec3 kd = is_moon ? vec3(0.5,0.5,0.5) : vec3(0,0,1);
  vec3 ks = vec3(0.3,0.3,0.3);
  float p = 100;
  vec3 n = normalize(normal_fs_in);
  vec3 v = -normalize(view_pos_fs_in.xyz); 
  vec3 l = normalize(vec3(sin(theta), 1, cos(theta)));
  color = blinn_phong(ka,kd,ks,p,n,v,l);
  /////////////////////////////////////////////////////////////////////////////
}
