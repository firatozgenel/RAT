        clear
close
    tic;
         %dimensions&source position - user defined%
        x1=20;
        y1=25;
        z1=6;
        xs=5;
        ys=2;
        zs=2;
        xr=10;
        yr=20;
        zr=1.5;
        x2=14;
        x3=14;
        z2=8;
        y2=14-9.3;
        abs_surface1=[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        abs_surface2=[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        abs_surface3=[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        abs_surface4=[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        abs_surface5=[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        abs_surface6=[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
        abs_surface7=[0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3];
        abs_surface8=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8];
        fileinput='library\classic.wav';
        fileoutput='voiceaconcrete.wav';
        srcpow=97.8;
        loopn=5;
        room_type='shoebox';
        filename='import_files\astanaabstacted.stl';
        file_format='stl';
        recR=2;
        ray_no=1000;
        impulse_length=3000;
tic;
        %data arrangement
        src=[xs,ys,zs];
        rec=[xr yr zr];
        abs=[abs_surface1;abs_surface2;abs_surface3;abs_surface4;abs_surface5;abs_surface6];
        tic; 
        %functions%
        [ normal,c,surface,V,surface_area,pt,t,tnorm ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);

        [ RTEyring,RTSabine,R ] = RTanalysis( surface_area,V,abs);
% 
%     %     if V==0
%     %         error('source or receiver is not inside the geometry')
%     %     end
% %         [ wavdata,nbit,fs ] = prewav( fileinput );
% 
% 
% 
    [ pp,dist ] = imgen3( src,normal,c,loopn,abs,rec,surface,srcpow,pt,t,tnorm);
% pp=[];
% dist=[];
[ impulse_distance, impulse_pressure] = raytracing( src,rec,recR,ray_no,normal,surface,impulse_length,abs,srcpow );
    pp=[pp;impulse_pressure];
    dist=[dist;impulse_distance];
    [ pval,Ppa,pres,t] = RIR2( dist,pp,V,surface_area );
%     [ RT ] = energycalculation3( t,pres )
%     [ en,SPL,ts,RT,tdc,d50,c80,ITDG,~ ] = energycalculation2( Ppa,t,pres,RTEyring,V,surface_area );
% [ RT,eee,tt ] = energycalculation2( Ppa,t,RTEyring );
% 
% 
% %         [ S ] = wavproc( wavdata,fs,t,Ppa );
%     %     wavwrite(S,fs,nbit,fileoutput);
%     %     figure;
%     %     bar(T,P);
% % 
% ode=[2.05	0.99	0.59	0.41	0.30	0.23	0.18	0.14];
% 
% %   plot([ode;RT;RTEyring]');
%   beep
        toc;
%         
%       
clearvars -except Ppa RTSabine RTEyring pres t
