function [ reflectedPoint ] = reflectPoint( surfaceVerticesReflection, surfaceNormalReflection, sourcePoint )
% reflectPoint

    surfaceVerticesReflection=surfaceVerticesReflection(1:3,:);
    surfaceNormalReflection=surfaceNormalReflection./norm(surfaceNormalReflection);
    sourcePoint=[sourcePoint ones(length(sourcePoint(:,1)),1)];
    gamma=acos(dot(surfaceNormalReflection,[0 0 1]));

    translation=makehgtform('translate', -surfaceVerticesReflection(1,:));  
    translationInv=makehgtform('translate', surfaceVerticesReflection(1,:));



    reflectionMatrix=[1 0 0 0;0 1 0 0;0 0 -1 0; 0 0 0 1];

    axis=cross(surfaceNormalReflection,[0 0 1]);
    axis=axis/norm(axis);

    if gamma==0 || sum(isnan(axis))==3
        rotMatrix=eye(4);
        rotMatrixInv=eye(4);
    else
    [ rotMatrix ] = makehgtform('axisrotate', axis,gamma);
    [ rotMatrixInv ] =makehgtform('axisrotate', axis,-gamma);
    end

    reflectedPoint=translationInv*rotMatrixInv*reflectionMatrix*rotMatrix*translation*sourcePoint';
    reflectedPoint=reflectedPoint(1:3,:)';

end

