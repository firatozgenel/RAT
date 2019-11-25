%% initialization
clear
numberofSurface=6;
surfaceName=(1:numberofSurface);
loopCount=0;
loopCountUser=9;    
tic

%% function
%ind=temporary index memory
%index=unculled index (before validity test) per order of reflection
%indexExtended=total index after visibility test
[user, system]=memory;
requiredMemory=0;
while requiredMemory<system.PhysicalMemory.Available- 2.1475e+09
    loopCount=loopCount+1;
    requiredMemory=sum(numberofSurface.^(1:loopCount))*loopCount*8;
    
end

loopCount=loopCount-1;
if loopCount>loopCountUser
    loopCount=loopCountUser;
    fprintf('Reflections upto %d order is being calculated',loopCountUser)
    fprintf('\n')
else
    fprintf('Due to computational limitations reflections upto %d order is being calculated',loopCount)
    fprintf('\n')
end

ind=surfaceName';
indexExtended=NaN(sum(numberofSurface.^(1:loopCount)),loopCount);
indexExtended(1:numberofSurface,1)=surfaceName;
for i=2:loopCount
    clearvars index
    index=NaN((length(ind)*numberofSurface),i);
    index(:,1:(i-1))=repmat(ind,numberofSurface,1);
        for j=1:numberofSurface
            index((j-1)*(length(index(:,1))/numberofSurface)+1:j*(length(index(:,1))/numberofSurface),i)=j;
        end
        
    ind=index;
    indexExtended(sum(numberofSurface.^(1:i-1))+1:sum(numberofSurface.^(1:i)),1:i)=index;
end
clearvars index ind
for i=1:loopCount-1
    cullIndex=find((indexExtended(:,i)==indexExtended(:,i+1)));
    indexExtended(cullIndex,:)=[];        
    
end
clearvars cullIndex
toc




