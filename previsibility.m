function [ surf_trans,ref_rotate,ref_vector,surface ] = previsibility( surface,tnorm,c,pt,t )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

surf_tri=NaN(length(surface(:,1))-2,length(surface(1,:)));
surf_tri(1,(1:3))=t(1,:);
    k=0;
    j=2;
for i=2:length(tnorm(:,1))
    if sqrt((tnorm(i,1)-tnorm(i-1,1))^2)<0.0001 && sqrt((tnorm(i,2)-tnorm((i-1),2))^2)<0.0001 && sqrt((tnorm(i,3)-tnorm((i-1),3))^2)<0.0001
       surf_tri(j,(3*k+(1:3)))=t(i,:);
       j=j+1;
    else surf_tri(1,(3*(k+1)+(1:3)))=t(i,:);
        j=2;
        k=k+1;
    end
    
end
t_rev=NaN(length(surface(:,1)),length(surface(1,:))/3);
for i=1:length(c(:,1))
   tt=surf_tri(:,3*(i-1)+(1:3));
   [ tind ] = closepoly( tt );
   t_rev((1:length(tind)),i)=tind;
end


for i=1:length(c(:,1))
    aa=t_rev(:,i);
    aa(isnan(aa))=[];
   surface((1:length(aa(:,1))),(3*(i-1)+(1:3)))=pt(aa(:,1),:); 
end
surface=round(surface./0.001)*0.001;
ref_vector=[];
ref_rotate=[];
surf_trans=[];
for i=1:length(c(:,1))
    pq=surface(:,3*(i-1)+(1:3));
    [ ptrans,ref_vect,ref_rot ] = transform( pq );
    surf_trans=[surf_trans,ptrans];
    ref_rotate=[ref_rotate,ref_rot];
    ref_vector=[ref_vector,ref_vect];   
end

for i=1:length(surf_trans(:,1))
    for j=1:length(surf_trans(1,:))
        surf_trans(i,j)=round(surf_trans(i,j)/0.01)*0.01;
    end
end

end

