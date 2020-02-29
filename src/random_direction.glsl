// Generate a pseudorandom unit 3D vector
// 
// Inputs:
//   seed  3D seed
// Returns psuedorandom, unit 3D vector drawn from uniform distribution over
// the unit sphere (assuming random2 is uniform over [0,1]²).
//
// expects: random2.glsl, PI.glsl
vec3 random_direction( vec3 seed)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  vec2 r = random2(seed); // use this to generate theta and phi
  
  float theta = acos(r.x*2-1);
  float phi = 2*r.y*M_PI;
  
  float ct = cos(theta);
  float st = sin(theta);
  float cp = cos(phi);
  float sp = sin(phi);

  return vec3(st*cp, st*sp, ct); // spherical coords equation
  /////////////////////////////////////////////////////////////////////////////
}
