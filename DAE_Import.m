function [ normal,c,surface,V,surface_area,p,t,tnorm] = DAE_Import( filename,src,rec )
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here



s = parseXML(filename);
s=s.Children;
i=1;
while i<=length(s)
  if strcmp(s(1,i).Name,'asset')
     s_unit=s(1,i).Children;
     i=length(s);
  else i=i+1;
  end
end
i=1;
while i<=length(s_unit)
  if strcmp(s_unit(1,i).Name,'unit')
     s_unit=s_unit(1,i).Attributes;
     i=length(s_unit);
  else i=i+1;
  end
end
for i=1:length(s_unit)
  if strcmp(s_unit(1,i).Name,'meter')
     conv_factor=str2double(s_unit(1,i).Value);
  end
end
i=1;
while i<=length(s)
  if strcmp(s(1,i).Name,'library_geometries')
     s=s(1,i).Children;
     i=length(s);
  else i=i+1;
  end
end

for i=1:length(s)
  if strcmp(s(1,i).Name,'geometry')
     s=s(1,i).Children;
  end
end
 
for i=1:length(s)
  if strcmp(s(1,i).Name,'mesh')
     s=s(1,i).Children;
  end
end

for i=1:length(s)
  if strcmp(s(1,i).Name,'triangles')
     stri=s(1,i).Children;
  end
end

for i=1:length(stri)
  if strcmp(stri(1,i).Name,'p')
     stridat=stri(1,i).Children.Data;
  end
end

tri_index=str2num(stridat)';
tri_index=tri_index+1;
l=[];
for i=1:length(s)
k=strcmp(s(1,i).Name,'source');
l=[l;k];
end
index=find(l==1);
val=[];
for i=1:length(index)
    s1=s(1,index(i)).Children;
    for l=1:length(s1)
        if strcmp(s1(1,l).Name,'float_array')
            s3=s1(1,l).Children.Data;
            vert=str2num(s3);
        else vert=[];
        end
     val=[val;vert];   
    end  
end


p = reshape(val(1,:),3,length(val(1,:))/3);
p=p';
p=p*conv_factor;

v=reshape(val(2,:),3,length(val(2,:))/3);
v=v';

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

if insrc==1 && inrec==1 && val==1
    V=SurfaceVolume(p,t,tnorm);
else V=0;
end



surf_area=NaN(length(t(:,1)),length(surface(1,:))/3);

length_surf=0;
mint=0;
for i=1:length(surf_area(1,:))
    surfq=surface(:,3*(i-1)+1);
    surfq(isnan(surfq(:,1)),:)=[];
    length_surf=length_surf+length(surfq(:,1));
    for j=1:length(t(:,1))
    
 
    k=find(max(t(j,:))<=length_surf && min(t(j,:))>mint);
   if k==1
       surf_area(j,i)=area(j);
   end
 
    end
     mint=mint+length(surfq(:,1)); 
end
surface_area=NaN(1,length(surf_area(1,:)));
for i=1:length(surf_area(1,:))
    k=surf_area(:,i);
    k(isnan(k(:,1)),:)=[];
    surface_area(i)=sum(k);
end



end

