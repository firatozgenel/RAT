function [ reflectionIndex ] = indexLister( numberOfSurface, loopCountUser,maxLoopCount )

%ind=temporary index memory
%index=unculled index (before validity test) per order of reflection
%reflectionIndex=total index after validity test

%initialization of parameters
%loopCount == initiliazation of loop count number


%% determination of maximum order of reflection
surfaceIndex=(1:numberOfSurface);
loopCount=0;
if loopCountUser>maxLoopCount;
    loopCountUser=maxLoopCount;
    fprintf('Maximum permitted reflection order is %d. Change options if required',maxLoopCount)
    fprintf('\n')
end
[user, system]=memory;
requiredMemory=0;
while requiredMemory<system.PhysicalMemory.Available- 2.1475e+09
    loopCount=loopCount+1;
    requiredMemory=sum(numberOfSurface.^(1:loopCount))*loopCount*8;
    
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


%% list of reflections from surfaces (Index)
ind=surfaceIndex';
reflectionIndex=NaN(sum(numberOfSurface.^(1:loopCount)),loopCount);
reflectionIndex(1:numberOfSurface,1)=surfaceIndex;
for i=2:loopCount
    clearvars index
    index=NaN((length(ind)*numberOfSurface),i);
    index(:,1:(i-1))=repmat(ind,numberOfSurface,1);
        for j=1:numberOfSurface
            index((j-1)*(length(index(:,1))/numberOfSurface)+1:j*(length(index(:,1))/numberOfSurface),i)=j;
        end
        
    ind=index;
    reflectionIndex(sum(numberOfSurface.^(1:i-1))+1:sum(numberOfSurface.^(1:i)),1:i)=index;
end
clearvars index ind

%% validity test
for i=1:loopCount-1
    cullIndex=find((reflectionIndex(:,i)==reflectionIndex(:,i+1)));
    reflectionIndex(cullIndex,:)=[];        
    
end
clearvars cullIndex


end

