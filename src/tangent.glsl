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
  T = vec3(N.x,-0.5*N.y,0.5*N.z);
  B = cross(N,T);
  /////////////////////////////////////////////////////////////////////////////
}
