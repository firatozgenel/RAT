function [ intersection_point ] = intersectplaneline( lo,v,po,n )
line=[lo v];
plane=[po n];

tol = 1e-14;
% unify sizes of data
nLines  = size(line, 1);
nPlanes = size(plane, 1);

% N planes and M lines not allowed 
if nLines ~= nPlanes && min(nLines, nPlanes) > 1
    error('MatGeom:geom3d:intersectLinePlane', ...
        'Input must have same number of rows, or one must be 1');
end

% plane normal
n = plane(4:6);

% difference between origins of plane and line
dp = bsxfun(@minus, plane(:, 1:3), line(:, 1:3));

% dot product of line direction with plane normal
denom = sum(bsxfun(@times, n, line(:,4:6)), 2);

% relative position of intersection point on line (can be inf in case of a
% line parallel to the plane)
t = sum(bsxfun(@times, n, dp),2) ./ denom;

% compute coord of intersection point
point = bsxfun(@plus, line(:,1:3),  bsxfun(@times, [t t t], line(:,4:6)));

% set indices of line and plane which are parallel to NaN
par = abs(denom) < tol;
point(par,:) = NaN;

intersection_point=point;

end

