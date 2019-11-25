function [ pp,dist ] = imgen3( src,normal,c,loopn,abs,rec,surface,srcpow,pt,t,tnorm)
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here
 [ surf_trans,ref_rotate,ref_vector,surface ] = previsibility( surface,tnorm,c,pt,t );
srcw=(10^-12)*10^(srcpow/10);
p=[];


parpt=src;
Lwd=ones(1,8);
lparpt=Lwd;

  p=[];
lp=[];
for k=1:5
points=[];   
lpoints=[];
pk=[];
lpk=[];
   for j=1:length(parpt(:,1))
    pj=[];
    pjpar=[];
    lpj=[];
    lpjpar=[];

        for i=1:length(normal(:,1))
        
            D=(c(i,1)*parpt(j,1)+c(i,2)*parpt(j,2)+c(i,3)*parpt(j,3)+c(i,4))/(c(i,1)^2+c(i,2)^2+c(i,3)^2);
            chpt=parpt(j,:)-2*D*c(i,1:3);  
            dist1=sqrt((parpt(j,1)-rec(1))^2+(parpt(j,2)-rec(2))^2+(parpt(j,3)-rec(3))^2);
            dist2=sqrt((chpt(1)-rec(1))^2+(chpt(2)-rec(2))^2+(chpt(3)-rec(3))^2);
             
            if dist1<dist2
                ppar=chpt;

               
                 lchpt(1,:)=lparpt(j,:).*(1-(abs(i,:)));

                lppar=lchpt;
                Pdif=[(ppar(1,1)-rec(1,1)),(ppar(1,2)-rec(1,2)),(ppar(1,3)-rec(1,3))];
                slope=(c(i,1)*rec(1,1)+c(i,2)*rec(1,2)+c(i,3)*rec(1,3)+c(i,4))/(c(i,1)*(-Pdif(1,1))+c(i,2)*(-Pdif(1,2))+c(i,3)*(-Pdif(1,3)));
                pvis=rec+slope*Pdif(1,:);
                ref_pt=surface(1,3*(i-1)+(1:3));
                dpvis=sqrt((pvis(1,1)-ref_pt(1,1))^2+(pvis(1,2)-ref_pt(1,2))^2+(pvis(1,3)-ref_pt(1,3))^2);
                v=[(pvis(1,1)-ref_pt(1,1)),(pvis(1,2)-ref_pt(1,2)),(pvis(1,3)-ref_pt(1,3))];
                r = vrrotvec(ref_vector(1,3*(i-1)+(1:3)),v);
                r(1,1:3)=round(r(1,1:3)/0.01)*0.01;
                thetapvis=r(1,4);
                if sum(ref_rotate(1,3*(i-1)+(1:3))==r(1,(1:3)))~=3
                    thetapvis=2*pi-thetapvis;
                end
                ptransvis=[dpvis*cos(thetapvis),dpvis*sin(thetapvis)];
                [IN ON] = inpolygon(ptransvis(1,1),ptransvis(1,2),surf_trans(:,2*(i-1)+1),surf_trans(:,2*(i-1)+2));
                if IN+ON==0
                    chpt=[]; 
                    lchpt=[];
                end
            else  chpt=[]; 
                ppar=[];
                lchpt=[];
                lppar=[];            
            end
            pj=[pj;chpt];
            pjpar=[pjpar;ppar];
            lpj=[lpj;lchpt];
            lpjpar=[lpjpar;lppar];
        end 
        points=[points;pj];
        pk=[pk;pjpar];
        lpoints=[lpoints;lpj];
        lpk=[lpk;lpjpar];
   end
   p=[p;points];
   parpt=pk;
   lp=[lp;lpoints];
   lparpt=lpk;
end



dist=zeros(1,length(p))';
for z=1:length(p)
    dist(z,1)=sqrt((p(z,1)-rec(1,1))^2+(p(z,2)-rec(1,2))^2+(p(z,3)-rec(1,3))^2);
end


    pp=[Lwd;lp];
    dsdist=sqrt((src(1)-rec(1))^2+(src(2)-rec(2))^2+(src(3)-rec(3))^2);
    dist=[dsdist;dist];

end

