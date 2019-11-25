function [ S ] = wavproc( wavdata,fs,t,Ppa,dat )

% determine time resolution
ttt=0:1/fs:max(t);
fir=zeros(length(ttt),8);
% replace IR data in time resolution
for j=1:8
    for i=1:length(t(:,1))
        e=abs(ttt-t(i));
        a=find(min(e)==e);
        fir(a,j)=Ppa(i,j);
    end
end
% convolution in octave band
for i=1:8
    wavout(:,i)=freq_conv(wavdata(:,i),fir(:,i));
end
% sum for wav output
S = sum(wavout,2);

% normalization
a=mean(real(S));
S=S-a;
coeff=max(dat)./max(S);
S=coeff.*S;

end

