function [ imageSourceLocation,reflectionIndex ] = imageCalculator( reflectionIndex, surfaceVertices, surfaceNormal,sourcePoint,receiverPoint)
%Function calculates image source locations with respect to reflectionIndex
%by using surface vertices and normals
% function uses matrix transformations by using reflectPoint function


%Preallocation of imageSourceLocations
imageSourceLocation=repmat(sourcePoint,length(reflectionIndex(:,1)),1);

%for each loop function tests whether the points are reflected from each
%surface, reflects them from this surface and overwrites to the
%respective imageSourceLocation index. 
%Total operation cost=numberOfSurface*loopCount
for i=1:length(reflectionIndex(1,:))
    for j=1:length(surfaceNormal(1,1,:))
        index=find(reflectionIndex(:,i)==j);
       
        imageSourceLocation(index,:)=reflectPoint( surfaceVertices(:,:,j), surfaceNormal(:,:,j), imageSourceLocation(index,:) );
        
        [ IN, ON ] = visibilityTest( imageSourceLocation,index,surfaceVertices,surfaceNormal,j,receiverPoint ); 
        cullOutIndex=index(IN+ON==0);
        reflectionIndex(cullOutIndex,:)=[];
        imageSourceLocation(cullOutIndex,:)=[];  
     end
end

end

