function [ RTEyring,RTSabine,alpha,R ] = RTanalysis( surface_area,V,abs)
%UNT�TLED2 Summary of this function goes here
%   Detailed explanation goes here
% airab=zeros(1,8);
airab=[0,0.0005,0.0010,0.0026,0.0042,0.0094,0.0294,0.1039];
alpha=NaN(length(abs(:,1)),length(abs(1,:)));
k=nthroot(V,3)./sqrt(sum(surface_area));
    for i=1:length(abs(:,1))
    alpha(i,:)=abs(i,:).*surface_area(i); 
    
    end

    alpha=sum(alpha,1);

    for i=1:length(alpha)
    RTSabine(i)=0.163*V/(alpha(i)+airab(i)*V);  
    abst(i)=alpha(i)/sum(surface_area);
    R(i)=(alpha(i)+airab(i).*V)/(1-abst(i));  
    RTEyring(i)=0.163*V/(-log(1-abst(i))*sum(surface_area)+airab(i)*V);  
    end

    for i=1:length(alpha)
    
    end
    

end

