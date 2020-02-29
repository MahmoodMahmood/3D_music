// Given a 3d position as a seed, compute an even smoother procedural noise
// value. "Improving Noise" [Perlin 2002].
//
// Inputs:
//   st  3D seed
// Values between  -½ and ½ ?
//
// expects: random_direction, improved_smooth_step
float improved_perlin_noise( vec3 st) 
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
 // sources: https://en.wikipedia.org/wiki/Perlin_noise
  //          https://www.scratchapixel.com/lessons/procedural-generation-virtual-worlds/perlin-noise-part-2
 
  // grid cell coordinates
  vec3 a = floor(vec3(st)); // min corner of cube

  // vectors from point 'st' to all corners of current cube
  vec3 d000 = a-st;
  vec3 d001 = a+vec3(0,0,1)-st;
  vec3 d010 = a+vec3(0,1,0)-st;
  vec3 d011 = a+vec3(0,1,1)-st;
  vec3 d100 = a+vec3(1,0,0)-st;
  vec3 d101 = a+vec3(1,0,1)-st;
  vec3 d110 = a+vec3(1,1,0)-st;
  vec3 d111 = a+vec3(1,1,1)-st;

  // dot product of distance to corner and pseudo random gradient at corner
  float r000 = dot(random_direction(a),d000);
  float r001 = dot(random_direction(a+vec3(0,0,1)),d001);
  float r010 = dot(random_direction(a+vec3(0,1,0)),d010);
  float r011 = dot(random_direction(a+vec3(0,1,1)),d011);
  float r100 = dot(random_direction(a+vec3(1,0,0)),d100);
  float r101 = dot(random_direction(a+vec3(1,0,1)),d101);
  float r110 = dot(random_direction(a+vec3(1,1,0)),d110);
  float r111 = dot(random_direction(a+vec3(1,1,1)),d111);

  // get 3 interpolation factors based on fraction of f
  vec3 factor = improved_smooth_step(fract(st));

  // interpolate everything!
  float i1 = mix(r000,r100,factor.x);
  float i2 = mix(r010,r110,factor.x);
  float i3 = mix(r001,r101,factor.x);
  float i4 = mix(r011,r111,factor.x);

  float i5 = mix(i1,i2,factor.y);
  float i6 = mix(i3,i4,factor.y);
 
  float i7 = mix(i5,i6,factor.z);

  return 2*i7-1; // do this so that we go from range [0,1] to [-1,1]
  /////////////////////////////////////////////////////////////////////////////
}

