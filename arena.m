function [ normal,c,surface,V,surface_area,p,t,tnorm ] = arena( x1,x2,y1,y2,z1,z2,src,rec )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

points=[0 0 z1;
        0 0 z1+z2;
        x2 0 z1;
        x2 0 z1+z2;
        0 y2 z1;
        0 y2 z1+z2;
        x2 y2 z1;
        x2 y2 z1+z2;
        (x2-x1)/2 (y2-y1)/2 0;
        (x2-x1)/2 (y2+y1)/2 0;
        (x2+x1)/2 (y2+y1)/2 0;
        (x2+x1)/2 (y2-y1)/2 0];
t=[3 2 1 3 4 2 7 6 5 7 8 6 11 10 9 11 12 10 15 14 13 15 16 14 17 18 19 17 19 20 21 22 23 21 23 24 25 28 27 25 27 26 31 32 30 31 30 29 33 34 35 33 35 36 37 39 40 38 39 37];
tri_index=t';
p=[points(1,:);points(2,:);points(3,:);points(4,:);points(3,:);points(4,:);points(7,:);points(8,:);points(7,:);points(8,:);points(5,:);points(6,:);points(5,:);points(6,:);
    points(1,:);points(2,:);points(1,:);points(9,:);points(12,:);points(3,:);points(12,:);points(11,:);points(7,:);points(3,:);points(10,:);points(11,:);points(7,:);
    points(5,:);points(9,:);points(10,:);points(1,:);points(5,:);points(9,:);points(10,:);points(11,:);points(12,:);points(2,:);points(4,:);points(8,:);points(6,:);];
n1=cross((p(3,:)-p(2,:)),(p(2,:)-p(1,:)));
n1=n1/norm(n1);
n2=cross((p(7,:)-p(6,:)),(p(6,:)-p(5,:)));
n2=n2/norm(n2);
n3=cross((p(11,:)-p(10,:)),(p(10,:)-p(9,:)));
n3=n3/norm(n3);
n4=cross((p(15,:)-p(14,:)),(p(14,:)-p(13,:)));
n4=n4/norm(n4);
n5=cross((p(17,:)-p(18,:)),(p(18,:)-p(19,:)));
n5=n5/norm(n5);
n6=cross((p(21,:)-p(22,:)),(p(22,:)-p(23,:)));
n6=n6/norm(n6);
n7=cross((p(25,:)-p(28,:)),(p(28,:)-p(27,:)));
n7=n7/norm(n7);
n8=cross((p(31,:)-p(32,:)),(p(32,:)-p(30,:)));
n8=n8/norm(n8);
n9=cross((p(33,:)-p(34,:)),(p(34,:)-p(35,:)));
n9=n9/norm(n9);
n10=cross((p(37,:)-p(39,:)),(p(39,:)-p(40,:)));
n10=n10/norm(n10);
normal=[n1;n2;n3;n4;n5;n6;n7;n8;n9;n10];
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
for i=25:28
v(i,:)=normal(7);
end
for i=29:32
v(i,:)=normal(8);
end
for i=33:36
v(i,:)=normal(9);
end
for i=37:40
v(i,:)=normal(10);
end

e=[4 4 4 4 4 4 4 4 4 4];


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

