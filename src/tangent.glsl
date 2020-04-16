// Input:
//   N  3D unit normal vector
// Outputs:
//   T  3D unit tangent vector
//   B  3D unit bitangent vector
void tangent(in vec3 N, out vec3 T, out vec3 B)
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code 
  // two random orthogonal vectors (dot product zero with each other)
  T = (vec4(N,1) * rotate_about_y(M_PI/4)).xyz;
  B = cross(N,T);
  /////////////////////////////////////////////////////////////////////////////
}
