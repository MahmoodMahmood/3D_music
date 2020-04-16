// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
float bump_height(vec3 s)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  float perlin = improved_perlin_noise(s)*0.1;
  float x = s.x*perlin;
  float y = s.y*perlin;
  float z = s.z*perlin;

  return smooth_heaviside(x+y+z, 0);
  /////////////////////////////////////////////////////////////////////////////
}
