function [ normal,c,surface,V,surface_area,p,t,tnorm ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format)
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(room_type,'shoebox')
     [ normal,c,surface,V,surface_area,p,t,tnorm ] = shoebox( x1,y1,z1,src,rec );
elseif strcmp(room_type,'fanshaped')
    [ normal,c,surface,V,surface_area,p,t,tnorm  ] = fanshaped( x1,x2,x3,y1,y2,z1,z2,src,rec );
elseif strcmp(room_type,'arena')
    [ normal,c,surface,V,surface_area,p,t,tnorm ] = arena( x1,x2,y1,y2,z1,z2,src,rec );
elseif strcmp(room_type,'custom')
    if strcmp(file_format,'dae')
      [ normal,c,surface,V,surface_area,p,t,tnorm] = DAE_Import( filename,src,rec ); 
    elseif strcmp(file_format,'stl')
      [ normal,c,surface,V,surface_area,p,t,tnorm] = STL( filename,src,rec );
    end
end

end

