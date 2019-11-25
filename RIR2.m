function [ pval,Ppa,pres,t] = RIR2( dist,pp,V,surface_area )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
time=dist./343;
time=floor(time.*1000)./1000;
% dist=time*343;
airab=[0,0,0,0,0.0042,0.0094,0.0294,0.1039];
% airab=zeros(1,8);

t=unique(time);
pres=[];
for j=1:8
 p=[];  
 d=0;
e=1;
while e<=length(length(pp(:,1)))
    for i=1:length(t)
    a=find(time==t(i));
    b=max(pp(a,j));
    p=[p;b];
    c=length(a);
    d=c+d;
    e=d+1;
    end
end
pres=[pres,p];
end


pval=NaN(length(pres(:,1)),8);
for i=1:length(pres(:,1))
    for j=1:8
        pval(i,j)=10*log10(pres(i,j)./10^-12)+10*log10(1./(4*pi*(343*t(i,1)).^2));
    end
end



pres=[];
for i=1:8
   for j=1:length(pval(:,1)) 
    pres(j,i)=pval(j,i)-(t(j,1)*343*airab(1,i));
   end
end
for i=1:8
pres(pres(:,i)<0,i)=0;
end
for i=1:8
    for j=1:length(pres(:,1))
        if pres(j,i)<=0
           pres(j,i)=NaN; 
        end
    end
end

% pres=10*log10(pres./(2*10^-5).^2);
Ppa=2*10^-5.*10.^(pres./20);



end



