function [ ptrans,ref_vector,ref_rot ] = transform( p )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

d=NaN(length(p(:,1)),1);
d(1)=0;
theta=NaN(length(p(:,1)),1);
theta(1)=0;
theta(2)=2;
ref_vector=[(p(2,1)-p(1,1)),(p(2,2)-p(1,2)),(p(2,3)-p(1,3))];
ref2_vector=[(p(3,1)-p(1,1)),(p(3,2)-p(1,2)),(p(3,3)-p(1,3))];
r = vrrotvec(ref_vector,ref2_vector);
ref_rot=r(1,(1:3));
for i=2:length(p(:,1))
    d(i)=sqrt((p(i,1)-p(1,1))^2+(p(i,2)-p(1,2))^2+(p(i,3)-p(1,3))^2);
    v=[(p(i,1)-p(1,1)),(p(i,2)-p(1,2)),(p(i,3)-p(1,3))];
    r = vrrotvec(ref_vector,v);
    if sum(ref_rot==r(1,(1:3)))==3
    theta(i)=r(1,4);
    else theta(i)=2*pi-r(1,4);
    end
end

ptrans=[0,0];

for i=2:length(p(:,1))
    ptrans(i,:)=[d(i)*cos(theta(i)),d(i)*sin(theta(i))];
end


end

