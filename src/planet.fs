// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
out vec3 color;
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  float tf = 0.0001;
  vec3 T,B;
  tangent(normalize(sphere_fs_in), T, B);
  vec3 x = bump_position(sphere_fs_in);
  vec3 x1 = bump_position(sphere_fs_in+T*tf);
  vec3 x2 = bump_position(sphere_fs_in+B*tf);

  vec3 delta1 = x-x1;
  vec3 delta2 = x-x2;

  vec3 normal = normalize(cross(delta1,delta2));
  if (dot(normal,sphere_fs_in) < 0) normal *= -1;

  normal = (inverse(transpose(view*model(animation_seconds))) * vec4(normal, 1.0)).xyz;

  //float_theta = 1.5*M_PI*animation_seconds;
  float theta = 1.183244057322245;
  float perlin = improved_perlin_noise(sphere_fs_in);
  float stripex = 2*sin(normal_fs_in.x*perlin*7.599954044117647*M_PI)+1;
  float stripey = 2*sin(normal_fs_in.x*perlin*1.8999885110294117*M_PI)+1;
  float r = (stripex+stripey)/2;

  vec3 ka = vec3(0.1,0.1,0.1);
  vec3 kd = vec3(1.5/r,0,0.0662419330276322);
  vec3 ks = vec3(0.3,0.3,0.3);
  float p = 100;
  vec3 n = normalize(normal);
  vec3 v = -normalize(view_pos_fs_in.xyz); 
  vec3 l = normalize(vec3(sin(theta), 0.5, cos(theta)));

  //color = 0.5+0.5*n;
  color = blinn_phong(ka,kd,ks,p,n,v,l);
  /////////////////////////////////////////////////////////////////////////////
} 
