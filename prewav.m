function [ wavdata,nbit,fs,h ] = prewav( fileinput )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

[h,fs,nbit] = wavread(fileinput);
l=length(h);

if mod(l,2)==1
    h=[h;0];
    l=l+1;
end

f=linspace(0,fs/2,l/2);

%preanalysis of the filters%
L=[44 89 178 355 710 1420 2840 5680];
low_cut=[44 88 177 355 710 1420 2840 5680];
over_dist=3;
tau=f(2)-f(1);
factor=1/tau;


L=floor(L*factor);
low_cut=floor(low_cut*factor);
over_dist=floor(over_dist*factor);
if mod(over_dist,2)==1
    over_dist=over_dist+1;
end
 for i=2:length(L);
     low_cut(i)=low_cut(i-1)+L(i-1);
 end
 t=linspace(0,1,over_dist);

window_l=0.50-0.50*cos(pi*t/1)';
window_r=flipud(window_l);


w=[];
for i=2:length(L)-1
  one=ones(L(i)-over_dist,1);
  window_firat=[window_l;one;window_r];
  wl=zeros((low_cut(i)-over_dist+1),1);
  window_firat=[wl;window_firat];
  wr=zeros((length(f)-length(window_firat)),1);
  window_firat=[window_firat;wr];
  w=[w,window_firat];
end

wf=[ones(low_cut(2)-over_dist+1,1);window_r];
wfzer=zeros(length(f)-length(wf),1);
wf=[wf;wfzer];


wl=[window_l;ones(length(f)-low_cut(8)-1,1)];
wlzer=zeros(length(f)-length(wl),1);
wl=[wlzer;wl];

ww=[wf,w,wl];


%fft algorithm%
a=ifftshift(h);
a=fft(a);
H=fftshift(a);

K=H(1:l/2);
L=H(l/2+1:l);
K=flipud(K);
K_filtered=[];
L_filtered=[];
for i=1:length(ww(1,:))
 K_fil=K.*ww(:,i);
 L_fil=L.*ww(:,i);
 K_filtered=[K_filtered,K_fil];
 L_filtered=[L_filtered,L_fil];
end
K_filtered=flipud(K_filtered);
H2=[K_filtered;L_filtered];


%ifft algorithm%

b=ifftshift(H2);
b=ifft(b);
wavdata=fftshift(b);


end

