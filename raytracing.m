
function [ impulse_distance, impulse_pressure] = raytracing( src,rec,recR,ray_no,normal,surface,impulse_length,abs,srcpow )
srcw=(10^-12)*10^(srcpow/10);
Lwd=ones(1,8);

po = reshape(surface(1,:),3,length(surface(1,:))/3);
po=po';
impulse_distance=[];
impulse_pressure=[];
n=normal;
% identification of maximum distance due to maximum IR length
max_dist=343.2*impulse_length/1000;

% ray vector generation
v=random('unif',-1,1,ray_no,3 );
vnorm=NaN(ray_no+1,3);
for i=1:ray_no
vnorm(i,:)=v(i,:)./norm(v(i,:));
end
clear i


% loop start
for j=1:ray_no;
    ray_boolean=0;
    dist=0;
    reflection_order=0;
    d=[];
    lo=src;
    vray=vnorm(j,:);
    p=[];
    vn=[];
    pressure=Lwd;
%     && min(pressure)>(2*10^-5)
while ray_boolean==0 && dist<max_dist 
    
    for i=1:6
        %find intersection point and distance
        p(i,:) = intersectplaneline( lo,vray,po(i,:),n(i,:));
        d(i,:)=pdist([p(i,:);lo]);
        % find directional vector
        vn(i,:)=p(i,:)-lo;
        vn(i,:)=vn(i,:)./norm(vn(i,:));
        
        % check directional vector is equal to ray vector (ray_boolean)
            if sum(bsxfun(@eq,round(1000.*(vn(i,:)))./1000,round(1000.*vray)./1000))==3
                b(i,1)=1;
            else b(i,1)=0;
            end
    end
    
% select the correct vector
refindexq1=find(b==1);
refindexq2=find(d(refindexq1)==min(d(refindexq1)));
refindex=refindexq1(refindexq2);
    if length(refindex)>1
        refindex=refindex(1);
    end
    
%determine whether ray hits receiver or not
[ ray_boolean, point ] = hitreceiver( lo,vray,rec,recR );
pres=pressure.*(1-abs(refindex,:));
%find total distance
dist=dist+d(refindex,1);
    if ray_boolean==0
        % reflect the ray vector and normalize
        vray=vray-2.*(dot(vray,n(refindex,:)).*n(refindex,:));
        vray=vray./norm(vray);
        % determine new ray start point
        lo=p(refindex,:);
        pressure=pres;
    else dist=dist+min(sum((bsxfun(@minus,point,lo).^2),2));
        impulse_distance=[impulse_distance;dist];
        impulse_pressure=[impulse_pressure;pres];
    end
reflection_order=reflection_order+1;

end

end
% loop end



end

