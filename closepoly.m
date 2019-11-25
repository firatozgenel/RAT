function [ tind ] = closepoly( tt )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
l=length(tt(:,1));
tind=NaN(l,1);
tt(isnan(tt))=[];
tt=reshape(tt,[],3);
A=unique(tt);
for i=1:length(A)
    l(i)=length(find(A(i)==tt));
end
tind(1)=A(find(l==min(l), 1 ));
[r,c]=find(tt==tind(1));
q=setxor(tt(r,:),tind(1));
tind(2)=q(1);
tt(r,c)=0;

for i=2:length(A)-1
    [r,c]=find(tt==tind(i));
for j=1:length(r)
    tt(r(j),c(j))=0;
end

    a=unique(tt(r,:));
    for j=1:length(a)
        l(j)=length(find(a(j)==tt(r,:)));
    end
    tind(i+1)=a(find(l==min(l), 1 ));
end

end

