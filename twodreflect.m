
clear

matrixBase=eye(4);

a=[0,0,0];
b=[10,0,0];
c=[10,0,10];
s=[10;10;10;1];
n=[0 1 0];
n=n./norm(n);

gamma=acos(dot(n,[0 0 1]));

translation=eye(4);  
translation(1:3,4)=-a';
translationInv=eye(4);
translationInv(1:3,4)=a';


ref=[1 0 0 0;0 1 0 0;0 0 -1 0; 0 0 0 1];


[ RotMatrix ] = RotateMatrix( n, gamma );
[ RotMatrixInv ] = RotateMatrix( n, -gamma);
Result=translationInv*RotMatrixInv*ref*RotMatrix*translation*s








