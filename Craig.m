function A = Craig( DH_Vector )
%UNTÝTLED10 Summary of this function goes here
% Return Transformation from the past fram 
% current frame 


alpha = DH_Vector(1);
a     = DH_Vector(2);
d     = DH_Vector(3);
theta = DH_Vector(4);


c0 =  cos(theta);  s0 =  sin(theta);
ca =  cos(alpha);  sa =  sin(alpha);

A1 = [ c0     -s0     0    a ];
A2 = [ s0*ca  c0*ca -sa -sa*d]; 
A3 = [ s0*sa  c0*sa  ca  ca*d]; 
A4 = [ 0        0      0    1];

 A = [A1;A2;A3;A4];


end

