function [ normal,c,surface,V,surface_area,p,t,tnorm  ] = fanshaped( x1,x2,x3,y1,y2,z1,z2,src,rec )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here


z3=y2*((z1-z2)/(y1+y2))+z2;

points=[(x2-x1)/2 0 0;
   (x2-x1)/2 0 z1;
   (x2+x1)/2 0 0;
   (x2+x1)/2 0 z1;
   0 y1 z1-z3;
   0 y1 z1;
   x2 y1 z1-z3;
   x2 y1 z1;
   (x2-x3)/2 y1+y2 z1-z2;
   (x2-x3)/2 y1+y2 z1;
   (x2+x3)/2 y1+y2 z1-z2;
   (x2+x3)/2 y1+y2 z1];
t=[3 2 1 4 2 3 7 6 5 7 8 6 10 9 11 11 12 10 15 16 13 13 16 14 17 20 19 18 20 17 23 24 21 24 22 21 30 29 28 30 28 27 30 27 26 30 26 25 31 32 33 31 33 34 31 34 35 31 35 36];
tri_index=t';
p=[points(1,:);points(2,:);points(3,:);points(4,:);points(3,:);points(4,:);points(7,:);points(8,:);points(7,:);points(8,:);points(11,:);points(12,:);points(11,:);points(12,:);
    points(9,:);points(10,:);points(5,:);points(6,:);points(9,:);points(10,:);points(5,:);points(6,:);points(1,:);points(2,:);points(3,:);points(7,:);points(11,:);points(9,:);
    points(5,:);points(1,:);points(2,:);points(4,:);points(8,:);points(12,:);points(10,:);points(6,:)];
n1=cross((p(3,:)-p(2,:)),(p(2,:)-p(1,:)));
n1=n1/norm(n1);
n2=cross((p(7,:)-p(6,:)),(p(6,:)-p(5,:)));
n2=n2/norm(n2);
n3=cross((p(10,:)-p(9,:)),(p(9,:)-p(11,:)));
n3=n3/norm(n3);
n4=cross((p(15,:)-p(16,:)),(p(16,:)-p(13,:)));
n4=n4/norm(n4);
n5=cross((p(17,:)-p(20,:)),(p(20,:)-p(19,:)));
n5=n5/norm(n5);
n6=cross((p(23,:)-p(24,:)),(p(24,:)-p(21,:)));
n6=n6/norm(n6);
n7=cross((p(30,:)-p(29,:)),(p(29,:)-p(28,:)));
n7=n7/norm(n7);
n8=cross((p(31,:)-p(32,:)),(p(32,:)-p(33,:)));
n8=n8/norm(n8);
normal=[n1;n2;n3;n4;n5;n6;n7;n8];
for i=1:4
v(i,:)=normal(1);
end
for i=5:8
v(i,:)=normal(2);
end
for i=9:12
v(i,:)=normal(3);
end
for i=13:16
v(i,:)=normal(4);
end
for i=17:20
v(i,:)=normal(5);
end
for i=21:24
v(i,:)=normal(6);
end
for i=25:30
v(i,:)=normal(7);
end
for i=31:36
v(i,:)=normal(8);
end


e=[4 4 4 4 4 4 6 6];


surface=NaN(max(e),3*length(e));
 k=1;
for i=1:length(e)
    surface(1:e(i),3*(i-1)+1)=p(k:k+e(i)-1,1);
    surface(1:e(i),3*(i-1)+2)=p(k:k+e(i)-1,2);
    surface(1:e(i),3*(i-1)+3)=p(k:k+e(i)-1,3);
    k=sum(e(1:i))+1;
end

k=[];
for i=1:length(normal(:,1))
  l=surface(1,3*(i-1)+(1:3));
  k=[k;l];  
end



d=zeros(1,length(normal))';
for i=1:length(normal(:,1))
   d(i,:)=-sum(normal(i,:).*k(i,:),2);
end
c=[normal,d];
normal=-normal;
c=-c;

for i=1:length(tri_index)
    tri(i,:)=p(tri_index(i),:);
end

area=[];
tnorm=[];
for i=1:length(tri(:,1))/3
    pt1=tri(3*(i-1)+1,:);
    pt2=tri(3*(i-1)+2,:);
    pt3=tri(3*(i-1)+3,:);
    u=pt2-pt1;
    v=pt3-pt2;
    crss=cross(u,v);
    normal_tri=crss/norm(crss);
    sing_area=norm(crss)/2;
    area=[area;sing_area];
    tnorm=[tnorm;normal_tri];
end
A=sum(area);

ind=e-2;
surface_area(1)=sum(area(1:2));
for i=2:length(ind)
    surface_area(i)=sum(area(sum(ind(1:(i-1)))+1:sum(ind(1:i))));
end

tri_index=tri_index';
tri_index = reshape(tri_index(1,:),3,length(tri_index(1,:))/3);
t=tri_index';

insrc=InPolyedron(p,t,tnorm,src);
inrec=InPolyedron(p,t,tnorm,rec);
qp=[];
for i=1:length(area)
    qpi=area(i)*tnorm(i,:);
    qp=[qp;qpi];
end

sumqp= sum(qp,1);
if sumqp(1)<0.001 && sumqp(2)<0.001 && sumqp(3)<0.001 
    val=1;
else val=0;
end
if insrc==1 && inrec==1 &&val==1
    V=SurfaceVolume(p,t,tnorm);
else V=0;
end

end

