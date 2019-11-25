function [ en,SPL,ts,RT,tdc,d50,c80,ITDG,eee ] = energycalculation2( Ppa,t,pres,RTSabine,V,surface_area )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
    ITDG=1000*(t(2)-t(1));
clear abs

    t=t-t(1);
    t=t(2:length(t));
    pres=pres(2:length(pres(:,1)),:);
    Ppa=Ppa(2:length(Ppa(:,1)),:);
    
t=t(2:length(t));
Ppa=Ppa(2:length(t)+1,:);
    for j=1:8
    for i=1:length(t)-1
        
        ep(i,j)=((abs(Ppa(i,j).^2-Ppa(i+1,j).^2)/2+min(Ppa(i,j).^2,Ppa(i+1,j).^2)).*(t(i+1)-t(i)));
    end
    end

    for j=1:8
    for i=1:length(t)-1
         eeep(i,j)=10*log10(sum(ep(i:length(t)-1,j))./sum(ep(:,j)));
         SPL(1,j)=10*log10(sum(10.^(pres(:,j)./10)));
       
    end
    end

for i=1:length(t)-1
    tt(i,1)=(t(i+1)-t(i))/2+t(i);
end
t=tt;
% eee=eee(1:length(eee(:,1))-1,:);

    coefrt=[];
    for k=1:8

    eee=eeep;
    tt=t;
%     for i=1:length(t)
%         if eeep(i,k)>=(-60/(RTSabine(1,k)))*t(i)-6  &&  eeep(i,k)<=(-60/(RTSabine(1,k)))*t(i)+6
%             tt=[tt;t(i)];
%             eee=[eee;eeep(i,k)];
%         end
%     end
% eee=[0;eee;-60];
% tt=[0;tt;RTSabine(1,k)];
%     t5cor=abs(eee(:,1)-eee(1,1)+5);
%     t5in=t5cor==min(t5cor);
%     t5=find(t5in==1);
%     t35cor=abs(eee(:,1)-eee(1,1)+35);
%     t35in=t35cor==min(t35cor);
%     t35=find(t35in==1);
%     if isempty(t35)
%         t35=tt(length(tt));
%     end
    index=find(isnan(eee(:,k))==0);
    eee=eee(index,k);
    tt=tt(index);
     f = fittype('poly1');
    options = fitoptions('poly1');
    options.Lower = [-Inf eee(1,1)]; 
    options.Upper = [0 eee(1,1)]; 
%     if size(tt(t5:t35))<2
    g = fit(tt,eee(:,1),f,options);
    RT(1,k)=(eee(1,1)-60-g.p2)/g.p1;
%     else
%     g = fit(tt(t5:t35),eee(t5:t35,1),f,options);
%     RT(1,k)=(eee(1,1)-60-g.p2)/g.p1;
%     end
  
%     RT(1,k)=(eee(1,k)-60-g.p2)/g.p1;
    coefrt(k,1)=g.p1;
    coefrt(k,2)=g.p2;
    end
for i=1:8
   if RT (1,i)==-Inf
       RT(1,i)=0;
   end
end
    
   

tdc=NaN(floor(max(RT)/0.001+1),8);
en=zeros(length(tdc(:,1)),8);
for i=1:8
tdc((1:floor(RT(1,i)/0.001)+1),i)=(0:0.001:RT(1,i))';
tdc(:,i)=floor(tdc(:,i)/0.001)*0.001;
en(:,i)=coefrt(i,1).*tdc(:,i)+SPL(1,i);
eeep(:,i)=eeep(:,i)+(SPL(1,i)-eeep(1,i));
end

for i=1:length(eeep(:,1))
    a=find(t(i)==tdc(:,8));
    if size(a)==1
    en(a,:)=eeep(i,:); 
    end

end
   
EE=10.^(en./20).*2*10^-5;

for i=1:8
    a=EE(:,i);
    a(isnan(a)==1)=[];
    a=length(a);

    if a>80
    c80(1,i)=10*log10(sum(EE((1:81),i).^2)/sum(EE((82:a),i).^2));
    d50(1,i)=sum(EE((1:51),i).^2)/sum(EE((1:a),i).^2);

    elseif a<80 && a>50
        d50(1,i)=sum(EE((1:51),i).^2)/sum(EE((1:a),i).^2);
    else
        c80(1,i)=Inf;
        d50(1,i)=1;
    end
    ts(1,i)=sum(tdc((1:a),i).*EE((1:a),i).^2)/sum(EE((1:a),i).^2);
end
end

