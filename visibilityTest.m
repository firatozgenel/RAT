function [ IN, ON ] = visibilityTest( imageSourceLocation,index,surfaceVertices,surfaceNormal,j,receiverPoint )
%visibility test
        
        % find intersection point
        u = imageSourceLocation(index,:)-repmat(receiverPoint,length(index(:,1)),1);
        reflectedPoint=imageSourceLocation(index,:);
        intersectPoint=NaN(size(u));
        for k=1:length(u(:,1))
            w = reflectedPoint(k,:) - surfaceVertices(1,:,j);
            D = dot(surfaceNormal(1,:,j),u(k,:));
            N = -dot(surfaceNormal(1,:,j),w);
            sI = N / D;
            intersectPoint(k,:) = reflectedPoint(k,:)+ sI.*u(k,:);  
        end
            
            
        gamma=acos(dot(surfaceNormal(1,:,j),[0 0 1]));                      % calculates angle between surface normal and z axis
        if gamma==0 || gamma==pi                                            %if angle is 0 or 360 omits z axis value and treats as projected
                projectedIntersectionPoint=intersectPoint(:,1:2);
                projectedSurfaceVertices=surfaceVertices(:,1:2,j);
        else                                                                %if angle ~= 0 || 360 rotates space to xy plane and treats as projected
        %project space 3d=>2d
            intersectPoint=[intersectPoint ones(length(intersectPoint(:,1)),1)];
            testSurfaceVertices=[surfaceVertices(:,:,j) ones(length(surfaceVertices(:,1,j)),1)];
            axis=cross(surfaceNormal(1,:,j),[0 0 1]);
            axis=axis/norm(axis);
        
            [ rotMatrix ] = makehgtform('axisrotate', axis,gamma);

            projectedIntersectionPoint=rotMatrix*intersectPoint';
            projectedIntersectionPoint=projectedIntersectionPoint(1:3,:)';
            projectedSurfaceVertices=rotMatrix*testSurfaceVertices';
            projectedSurfaceVertices=projectedSurfaceVertices(1:3,:)';
        end
        
        %point in polygon check// if false cull out reflectionIndex and
        [IN, ON] = inpolygon(projectedIntersectionPoint(:,1),projectedIntersectionPoint(:,2),projectedSurfaceVertices(:,1),projectedSurfaceVertices(:,2));



end

