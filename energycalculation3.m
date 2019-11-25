function [ RT ] = energycalculation3( t,pres )
    ITDG=1000*(t(2)-t(1));
clear abs
    for k=1:8
    index=find(isnan(pres(:,k))==0);
    eee=pres(index,k);
    tt=t(index);
     f = fittype('poly1');
    options = fitoptions('poly1');
    options.Lower = [-Inf pres(1,k)]; 
    options.Upper = [0 pres(1,k)]; 
    g = fit(tt,eee(:,1),f,options);
    RT(1,k)=-60/g.p1;
    coefrt(k,1)=g.p1;
    coefrt(k,2)=g.p2;
    end
end

