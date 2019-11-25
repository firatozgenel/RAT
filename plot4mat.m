function [ output_args ] = plot4mat( p,t )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
lim=max(p);
trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','none','edgecolor','b');
xlim([0 max(lim)])
ylim([0 max(lim)])
zlim([0 max(lim)])
set(gca,'XDir','reverse', 'YDir','reverse')

end

