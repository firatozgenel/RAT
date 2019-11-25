function [ normal,c,surface,V,surface_area,p,t,tnorm ] = shoebox( x1,y1,z1,src,rec )

%point, triangle index and face normal determination for shoebox
p=str2num('1  1  0  0  0  0  0  1  0  1  0  0  1  0  1  0  0  0  1  0  0  0  0  1  0  1  1  0  0  0  0  0  1  0  1  0  0  1  1  1  1  0  0  1  0  1  1  1  1  1  0  1  0  1  1  0  0  1  1  1  1  0  1  0  1  1  0  0  1  1  1  1');
p = reshape(p(1,:),3,length(p(1,:))/3);
p=p';
t=str2num('1   2   3   2   1   4   5   6   7   6   5   8   9  10  11  10   9  12  13  14  15  14  13  16  17  18  19  18  17  20  21  22  23  22  21  24');
tri_index=t';
t=t';
v=str2num('0  0 -1  0  0 -1  0  0 -1  0  0 -1  0 -1  0  0 -1  0  0 -1  0  0 -1  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  0  1  0  0  1  0  0  1  0  0  1  0  1  0  0  1  0  0  1  0  0  1  0  0  0  0  1  0  0  1  0  0  1  0  0  1');
v = reshape(v(1,:),3,length(v(1,:))/3);
v=v';

% adapting dimensional inputs to shoebox model
p=[x1*p(:,1),y1*p(:,2),z1*p(:,3)];
% determination of surface normals
normal=v(1,:);
for i=2:length(v(:,1))-1
    if v(i,:)==v(i-1,:)
        point=[];
    else point=v(i,:);
    end
    normal=[normal;point]; 
end

e=ones(1,length(normal(:,1)));
  i=1;
for j=1:length(normal(:,1))
 
 while i<=length(v(:,1))-1
     if isequal(v(i,:),v(i+1,:))
         e(1,j)=e(1,j)+1;
         i=i+1;
     else i=length(v(:,1));
     end
 end
 i=sum(e(1:j))+1;
end


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
    v=pt3-pt1;
    crss=cross(u,v);
    normal_tri=crss/norm(crss);
    sing_area=norm(crss)/2;
    area=[area;sing_area];
    tnorm=[tnorm;normal_tri];
end
A=sum(area);

tri_index=tri_index';
tri_index = reshape(tri_index(1,:),3,length(tri_index(1,:))/3);
t=tri_index';

surface_area=area';
surface_area=reshape(surface_area(1,:),2,length(tri_index(1,:))/2);
surface_area=sum(surface_area,1);

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

