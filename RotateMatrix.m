function [ RotMatrix ] = RotateMatrix( n, degree )

axis=cross(n,[0 0 1]);
axis=axis/norm(axis);
c=cos(degree);
s=sin(degree);
C=1-c;
x=axis(1);
y=axis(2);
z=axis(3);


RotMatrix=[x*x*C+c x*y*C-z*s x*z*C+y*s 0;
    y*x*C+z*s y*y*C+c y*z*C-x*s 0;
    z*x*C-y*s z*y*C+x*s z*z*C+c 0;
    0 0 0 1];

end

