// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
//
//
// Octavian perlin noise algorithm
float octavian(vec3 s)
{
  // configurables
  int octaves = 10;
  float frequency = 3;
  float amplitude = 1;
  float persistance = 0.1;

  float max_val = 0;
  float total = 0;

  for (int i = 0; i < octaves; i++) {
    total += improved_perlin_noise(s*frequency)*amplitude;
    max_val += amplitude;
    amplitude *= persistance;
    frequency *= 2;
  }
  return total/max_val;
}


float bump_height(vec3 s)
{
  float waviness = 4;
  float bump_amplitude = 20;
  float constant_offset = 10;
  float perlin_factor = 2;

  float perlin = perlin_factor*octavian(s);
  float noise = constant_offset + bump_amplitude * sin(waviness * M_PI * (s.x + perlin));
  return noise;
  /////////////////////////////////////////////////////////////////////////////
}
