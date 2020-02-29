// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   is_moon  whether we're looking at the moon or centre planet
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
float bump_height(bool is_moon, vec3 s)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  float perlin = improved_perlin_noise(s*(is_moon?6:2));
  if (!is_moon) perlin = smooth_heaviside(perlin, 2);
  float x = s.x*perlin;
  float y = s.y*perlin;
  float z = s.z*perlin;

  return (x+y+z)*0.1;
  /////////////////////////////////////////////////////////////////////////////
}
