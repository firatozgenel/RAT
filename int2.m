function varargout = int2(varargin)
% INT2 M-file for int2.fig
%      INT2, by itself, creates a new INT2 or raises the existing
%      singleton*.
%
%      H = INT2 returns the handle to a new INT2 or the handle to
%      the existing singleton*.
%
%      INT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INT2.M with the given input arguments.
%
%      INT2('Property','Value',...) creates a new INT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before int2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to int2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help int2

% Last Modified by GUIDE v2.5 11-Feb-2012 16:23:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @int2_OpeningFcn, ...
                   'gui_OutputFcn',  @int2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT


% --- Executes just before int2 is made visible.
function int2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to int2 (see VARARGIN)

% Choose default command line output for int2
handles.output = hObject;
guidata(hObject, handles);
% Update handles structure

axes(handles.logo);
imshow('library/logo.jpg');
setappdata(handles.roomselection,'room_type','shoebox');
file_format=[];
filename=[];
room_type='shoebox';
x1=17;
y1=28;
z1=12;
set(handles.x1,'String',num2str(x1));
set(handles.y1,'String',num2str(y1));
set(handles.z1,'String',num2str(z1));
src=[2 3 2];
rec=[14 15 3];
x2=[];
x3=[];
y2=[];
z2=[];
set(handles.xs,'String',num2str(src(1,1)));
set(handles.ys,'String',num2str(src(1,2)));
set(handles.zs,'String',num2str(src(1,3)));
set(handles.xr,'String',num2str(rec(1,1)));
set(handles.yr,'String',num2str(rec(1,2)));
set(handles.zr,'String',num2str(rec(1,3)));

set(handles.legendside,'visible','off');
axes(handles.legendtop);
imshow('library\boxxyz.jpg');
axes(handles.materialplot);
[ normal,c,surface,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
Vdisp=round(V); set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
rotate3d(handles.materialplot);
xlabel('x-axis(m)');
ylabel('y-axis(m)');
zlabel('z-axis(m)');
data=blanks(6)';
data=cellstr(data);
data=[data data cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
material=importdata('library\material.mat');
materiallist=material.name';
set(handles.mattable,'ColumnFormat', {materiallist});
set(handles.mattable,'ColumnWidth',{200 120 80});
setappdata(handles.datastr,'surface',surface);
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'plane_coeff',c);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'normal',normal);
setappdata(handles.datastr,'surface_points',surface);
setappdata(handles.datastr,'volume',V);
setappdata(handles.datastr,'surface_area',surface_area);
setappdata(handles.datastr,'wav_filename',0);
setappdata(handles.datastr,'srcpow',94);
setappdata(handles.datastr,'x1',x1);
setappdata(handles.datastr,'x2',x2);
setappdata(handles.datastr,'x3',x3);
setappdata(handles.datastr,'y1',y1);
setappdata(handles.datastr,'y2',y2);
setappdata(handles.datastr,'z1',z1);
setappdata(handles.datastr,'z2',z2);
setappdata(handles.datastr,'src',src);
setappdata(handles.datastr,'rec',rec);
setappdata(handles.datastr,'room_type',room_type);
setappdata(handles.datastr,'filename',filename);
setappdata(handles.datastr,'file_format',file_format);
setappdata(handles.datastr,'~','~');
setappdata(handles.datastr,'purpose',1);




% UIWAIT makes int2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = int2_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
run tutorial

% --- Executes when selected object is changed in uipanel12.
function uipanel12_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel12 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'concert'
        setappdata(handles.datastr,'purpose',1);
    case 'conference'
        setappdata(handles.datastr,'purpose',2);
    case 'multi'
        setappdata(handles.datastr,'purpose',3);
end
% --- Executes when selected object is changed in roomselection.
function roomselection_SelectionChangeFcn(~, eventdata, handles)
% hObject    handle to the selected object in roomselection 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
% set(eventdata.NewValue,'Tag')

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'Shoebox'      
        set(handles.x1,'enable','on')
        set(handles.y1,'enable','on')
        set(handles.z1,'enable','on')
        set(handles.x2,'enable','off')
        set(handles.y2,'enable','off')
        set(handles.z2,'enable','off')
        set(handles.x3,'enable','off')
        set(handles.Browse,'enable','off')  
        value='shoebox';
        setappdata(handles.datastr,'room_type',value);
        cla(handles.materialplot);
        axes(handles.materialplot);
        [ ~,c,surface,V,surface_area,p,t,~,~ ] = geoanalysis( value,[],17,0,0,28,0,12,0,[4 5 3],[12 18 2],[]);
        Vdisp=round(V);
        set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
        data=blanks(6)';
        data=cellstr(data);
        data=[data data cellstr(num2str(surface_area'))];
        set(handles.mattable,'Data',data);
        set(handles.mattable,'RowName',(1:length(c))); 
        set(handles.mattable,'ColumnWidth',{200 120 80});
        set(handles.x1,'String',num2str(17));
        set(handles.y1,'String',num2str(28));
        set(handles.z1,'String',num2str(12));
        set(handles.xs,'String',num2str(4));
        set(handles.ys,'String',num2str(5));
        set(handles.zs,'String',num2str(3));
        set(handles.xr,'String',num2str(12));
        set(handles.yr,'String',num2str(18));
        set(handles.zr,'String',num2str(2));
        cla(handles.legendside);
        axes(handles.legendside);
        set(handles.legendside,'visible','off');
        axes(handles.legendtop);
        k=imshow('library\boxxyz.jpg');
        handles.legendside=k;
        setappdata(handles.roomselection,'showk',k);
        setappdata(handles.datastr,'x1',17);
        setappdata(handles.datastr,'x2',0);
        setappdata(handles.datastr,'x3',0);
        setappdata(handles.datastr,'y1',28);
        setappdata(handles.datastr,'y2',0);
        setappdata(handles.datastr,'z1',12);
        setappdata(handles.datastr,'z2',0);
        setappdata(handles.datastr,'src',[4 5 3]);
        setappdata(handles.datastr,'rec',[12 18 2]);
        setappdata(handles.datastr,'room_type',value);
        setappdata(handles.datastr,'surface',surface);
        setappdata(handles.datastr,'points',p);
        setappdata(handles.datastr,'plane_coeff',c);
        setappdata(handles.datastr,'tri',t);
        setappdata(handles.datastr,'~','~');

       

    case 'Fan'
        set(handles.x1,'enable','on')
        set(handles.y1,'enable','on')
        set(handles.z1,'enable','on')
        set(handles.x2,'enable','on')
        set(handles.y2,'enable','on')
        set(handles.z2,'enable','on')
        set(handles.x3,'enable','on')
        set(handles.Browse,'enable','off')
        value='fanshaped';
        setappdata(handles.datastr,'room_type',value);
        cla(handles.materialplot);
        axes(handles.materialplot);
        [ ~,c,surface,V,surface_area,p,t,~,~ ] = geoanalysis( value,[],6,12,8,10,6,6,3,[6 2 3],[6 15 5],[]);
        Vdisp=round(V);
        set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
        data=blanks(8)';
        data=cellstr(data);
        data=[data data cellstr(num2str(surface_area'))];
        set(handles.mattable,'Data',data);
        set(handles.mattable,'RowName',(1:length(c))); 
        set(handles.mattable,'ColumnWidth',{200 120 80});
        set(handles.x1,'String',num2str(6));
        set(handles.y1,'String',num2str(10));
        set(handles.z1,'String',num2str(6));
        set(handles.x2,'String',num2str(12));
        set(handles.y2,'String',num2str(6));
        set(handles.z2,'String',num2str(3));
        set(handles.x3,'String',num2str(8));
        set(handles.xs,'String',num2str(6));
        set(handles.ys,'String',num2str(2));
        set(handles.zs,'String',num2str(3));
        set(handles.xr,'String',num2str(6));
        set(handles.yr,'String',num2str(15));
        set(handles.zr,'String',num2str(5));
        axes(handles.legendtop);
        l=imshow('library\fanxy.jpg');
        handles.legendtop=l;
        axes(handles.legendside);
        k=imshow('library\fanyz.jpg');
        handles.legendside=k;
        setappdata(handles.roomselection,'showk',k);
        setappdata(handles.roomselection,'showl',l);
        setappdata(handles.datastr,'x1',6);
        setappdata(handles.datastr,'x2',12);
        setappdata(handles.datastr,'x3',8);
        setappdata(handles.datastr,'y1',10);
        setappdata(handles.datastr,'y2',6);
        setappdata(handles.datastr,'z1',6);
        setappdata(handles.datastr,'z2',3);
        setappdata(handles.datastr,'src',[6 2 3]);
        setappdata(handles.datastr,'rec',[6 15 5]);
        setappdata(handles.datastr,'room_type',value);
        setappdata(handles.datastr,'surface',surface);
        setappdata(handles.datastr,'points',p);
        setappdata(handles.datastr,'plane_coeff',c);
        setappdata(handles.datastr,'tri',t);
        setappdata(handles.datastr,'~','~');

        
 
    case 'Arena'
        set(handles.x1,'enable','on')
        set(handles.y1,'enable','on')
        set(handles.z1,'enable','on')
        set(handles.x2,'enable','on')
        set(handles.y2,'enable','on')
        set(handles.z2,'enable','on')
        set(handles.x3,'enable','off')
        set(handles.Browse,'enable','off')
        value='arena';
        setappdata(handles.datastr,'room_type',value);
        cla(handles.materialplot);
        axes(handles.materialplot);
        [ ~,c,surface,V,surface_area,p,t,~,~ ] = geoanalysis( value,[],6,20,0,6,20,8,5,[10 10 2],[14 14 9],[]);
        Vdisp=round(V);
        set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
        data=blanks(10)';
        data=cellstr(data);
        data=[data data cellstr(num2str(surface_area'))];
        set(handles.mattable,'Data',data);
        set(handles.mattable,'RowName',(1:length(c))); 
        set(handles.mattable,'ColumnWidth',{185 120 80});
        set(handles.x1,'String',num2str(6));
        set(handles.y1,'String',num2str(6));
        set(handles.z1,'String',num2str(8));
        set(handles.x2,'String',num2str(20));
        set(handles.y2,'String',num2str(20));
        set(handles.z2,'String',num2str(5));
        set(handles.xs,'String',num2str(10));
        set(handles.ys,'String',num2str(10));
        set(handles.zs,'String',num2str(2));
        set(handles.xr,'String',num2str(14));
        set(handles.yr,'String',num2str(14));
        set(handles.zr,'String',num2str(9));
        axes(handles.legendtop);
        l=imshow('library\arenaxy.jpg');
        handles.legentop=l;
        axes(handles.legendside);
        k=imshow('library\arenaxz.jpg');
        handles.legendside=k;
        setappdata(handles.roomselection,'showk',k);
        setappdata(handles.roomselection,'showl',l);
        setappdata(handles.datastr,'x1',6);
        setappdata(handles.datastr,'x2',20);
        setappdata(handles.datastr,'x3',0);
        setappdata(handles.datastr,'y1',6);
        setappdata(handles.datastr,'y2',20);
        setappdata(handles.datastr,'z1',8);
        setappdata(handles.datastr,'z2',5);
        setappdata(handles.datastr,'src',[10 10 2]);
        setappdata(handles.datastr,'rec',[14 14 9]);
        setappdata(handles.datastr,'room_type',value);
        setappdata(handles.datastr,'surface',surface);
        setappdata(handles.datastr,'points',p);
        setappdata(handles.datastr,'plane_coeff',c);
        setappdata(handles.datastr,'tri',t);
        setappdata(handles.datastr,'~','~');

        

    case 'Custom'
        set(handles.x1,'enable','off')
        set(handles.y1,'enable','off')
        set(handles.z1,'enable','off')
        set(handles.x2,'enable','off')
        set(handles.y2,'enable','off')
        set(handles.z2,'enable','off')
        set(handles.x3,'enable','off')
        set(handles.Browse,'enable','on')
        value='custom';
        setappdata(handles.datastr,'room_type',value);
        cla(handles.legendtop);
        cla(handles.legendside);
        cla(handles.materialplot);
        set(handles.legendtop,'visible','off');
        set(handles.legendside,'visible','off');
        data=blanks(6)';
        data=cellstr(data);
        data=[data data data];
        set(handles.mattable,'Data',data);
        set(handles.mattable,'ColumnWidth',{200 120 80});
        warndlg( 'Sound source coordinates and sound receiver coordinates are determined according to predetermined geometries. Before proceeding please enter source and receiver coordinates inside the custom geometry. You can check whether the points are inside the geometry or not by pressing "Visualize Room" button' );
        setappdata(handles.datastr,'room_type',value);

        
    otherwise
        % Code for when there is no match.
end

% --- Executes when selected object is changed in viewchange.
function viewchange_SelectionChangeFcn(~, eventdata, handles)
% hObject    handle to the selected object in viewchange 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'topview' 
        axes(handles.materialplot)
        view(0,90)
        rotate3d off
    case 'sideview'
        axes(handles.materialplot)
        view(90,0)
        rotate3d off
    case 'frontview'
        axes(handles.materialplot)
        view(0,0)
        rotate3d off
    case 'perspview'
        axes(handles.materialplot)
        view(-45,45)
        rotate3d(handles.materialplot);
end

function x1_Callback(hObject, ~, handles) %#ok<DEFNU>
% hObject    handle to x1static (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1static as text
%        str2double(get(hObject,'String')) returns contents of x1static as a double
x1=str2double(get(hObject,'String'));
setappdata(handles.datastr,'x1',x1);
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
data= get(handles.mattable,'Data');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
Vdisp=round(V);
set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');




function y1_Callback(hObject, ~, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y1 as text
%        str2double(get(hObject,'String')) returns contents of y1 as a double
y1=str2double(get(hObject,'String'));
setappdata(handles.datastr,'y1',y1);
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
x1=getappdata(handles.datastr,'x1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
data= get(handles.mattable,'Data');
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');



function z1_Callback(hObject, ~, handles)
% hObject    handle to z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z1 as text
%        str2double(get(hObject,'String')) returns contents of z1 as a double
z1=str2double(get(hObject,'String'));
setappdata(handles.datastr,'z1',z1);
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
x1=getappdata(handles.datastr,'x1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
data= get(handles.mattable,'Data');
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function x2_Callback(hObject, ~, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2 as text
%        str2double(get(hObject,'String')) returns contents of x2 as a double
x2=str2double(get(hObject,'String'));
setappdata(handles.datastr,'x2',x2);
x1=getappdata(handles.datastr,'x1');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
data= get(handles.mattable,'Data');
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function y2_Callback(hObject, ~, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y2 as text
%        str2double(get(hObject,'String')) returns contents of y2 as a double
y2=str2double(get(hObject,'String'));
setappdata(handles.datastr,'y2',y2);
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
x1=getappdata(handles.datastr,'x1');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
data= get(handles.mattable,'Data');
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function z2_Callback(hObject, ~, handles)
% hObject    handle to z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z2 as text
%        str2double(get(hObject,'String')) returns contents of z2 as a double
z2=str2double(get(hObject,'String'));
setappdata(handles.datastr,'z2',z2);
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
x1=getappdata(handles.datastr,'x1');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
data= get(handles.mattable,'Data');
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');



function x3_Callback(hObject, ~, handles)
% hObject    handle to x3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x3 as text
%        str2double(get(hObject,'String')) returns contents of x3 as a double
x3=str2double(get(hObject,'String'));
setappdata(handles.datastr,'x3',x3);
x2=getappdata(handles.datastr,'x2');
x1=getappdata(handles.datastr,'x1');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
data= get(handles.mattable,'Data');
[ ~,~,~,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
data=[data(:,1) data(:,2) cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function srcpow_Callback(hObject, ~, handles)
% hObject    handle to srcpow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of srcpow as text
%        str2double(get(hObject,'String')) returns contents of srcpow as a double
srcpow=str2double(get(hObject,'String'));
setappdata(handles.datastr,'srcpow',srcpow);

% -- Executes on button press in Browse.
function Browse_Callback(~, ~, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,~] = uigetfile({'*.dae;*.stl'},'Locate COLLADA or STL File');
filename=strcat(PathName,'\', FileName);
setappdata(handles.datastr,'filename',filename);
dotindex=findstr(FileName,'.');
ext=FileName((dotindex+1):length(FileName));
setappdata(handles.datastr,'file_format',ext);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,c,surface,V,surface_area,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,ext);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
data=blanks(length(c))';
data=cellstr(data);
data=[data data cellstr(num2str(surface_area'))];
set(handles.mattable,'Data',data);
set(handles.mattable,'RowName',(1:length(c))); 

setappdata(handles.datastr,'surface',surface);
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'plane_coeff',c);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function xr_Callback(hObject, ~, handles)
% hObject    handle to xr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xr as text
%        str2double(get(hObject,'String')) returns contents of xr as a double
xr=str2double(get(hObject,'String'));
rec=getappdata(handles.datastr,'rec');
rec=[xr rec(1,2) rec(1,3)];
setappdata(handles.datastr,'rec',rec);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,~,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');



function yr_Callback(hObject, ~, handles)
% hObject    handle to yr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yr as text
%        str2double(get(hObject,'String')) returns contents of yr as a double
yr=str2double(get(hObject,'String'));
rec=getappdata(handles.datastr,'rec');
rec=[rec(1,1) yr rec(1,3)];
setappdata(handles.datastr,'rec',rec);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,~,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function zr_Callback(hObject, ~, handles)
% hObject    handle to zr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zr as text
%        str2double(get(hObject,'String')) returns contents of zr as a double
zr=str2double(get(hObject,'String'));
rec=getappdata(handles.datastr,'rec');
rec=[rec(1,1) rec(1,2) zr];
setappdata(handles.datastr,'rec',rec);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
src=getappdata(handles.datastr,'src');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,~,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');



function xs_Callback(hObject, ~, handles)
% hObject    handle to xs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xs as text
%        str2double(get(hObject,'String')) returns contents of xs as a double
xs=str2double(get(hObject,'String'));
src=getappdata(handles.datastr,'src');
src=[xs src(1,2) src(1,3)];
setappdata(handles.datastr,'src',src);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,~,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function ys_Callback(hObject, ~, handles)
% hObject    handle to ys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ys as text
%        str2double(get(hObject,'String')) returns contents of ys as a double
ys=str2double(get(hObject,'String'));
src=getappdata(handles.datastr,'src');
src=[src(1,1) ys src(1,3)];
setappdata(handles.datastr,'src',src);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,~,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


function zs_Callback(hObject, ~, handles)
% hObject    handle to zs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zs as text
%        str2double(get(hObject,'String')) returns contents of zs as a double
zs=str2double(get(hObject,'String'));
src=getappdata(handles.datastr,'src');
src=[src(1,1) src(1,2) zs];
setappdata(handles.datastr,'src',src);
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
rec=getappdata(handles.datastr,'rec');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
file_format=getappdata(handles.datastr,'file_format');
cla(handles.materialplot);
axes(handles.materialplot);
[ ~,~,~,V,~,p,t,~,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
setappdata(handles.datastr,'points',p);
setappdata(handles.datastr,'tri',t);
setappdata(handles.datastr,'~','~');


% --- Executes on button press in Visualize.
function Visualize_Callback(~, ~, handles)
% hObject    handle to Visualize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');


if strcmp(room_type,'custom') && isempty(filename)
   errordlg('File not found Please specify a *dae or *stl file from Browse Button','File Error')
end

file_format=getappdata(handles.datastr,'file_format');
file_format=lower(file_format);
if strcmp(room_type,'shoebox')
if x1==0  || y1==0 || z1==0 
  errordlg('Active parameters can not have a value of zero. Please enter a nonzero value.','Input Error')
end   
end
if strcmp(room_type,'arena')
if x1==0  || x2==0  || y1==0 || y2==0 || z1==0 || z2==0
  errordlg('Active parameters can not have a value of zero. Please enter a nonzero value.','Input Error')
end  
if x1>=x2 
  errordlg('x1 can not be bigger than x2. Please enter a valid value.','Input Error')
end  
if y1>=y2 
  errordlg('y1 can not be bigger than y2. Please enter a valid value.','Input Error')
end 
end
if strcmp(room_type,'fanshaped')
if x1==0  || x2==0 || x3==0 || y1==0 || y2==0 || z1==0 || z2==0
  errordlg('Active parameters can not have a value of zero. Please enter a nonzero value.','Input Error')
end  
if x1>=x2 || x3>=x2
  errordlg('x1 and x3 can not be bigger than x2. Please enter a valid value.','Input Error')
end    
end

[ V,p,t ] = geoanalysisvisual( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
        Vdisp=round(V);         set(handles.volume,'String',strcat(num2str(Vdisp),' m3'));
data = guihandles(handles.Visualize); 

data.p = p; 
data.t=t;
data.src=src;
data.rec=rec;
guidata(handles.Visualize,data) 
run roomvisual;

% --- Executes when selected cell(s) is changed in mattable.
function mattable_CellSelectionCallback(~, eventdata, handles)
% hObject    handle to mattable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)+-------
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

sel = eventdata.Indices; 
if size(sel)~=0

src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
get(handles.mattable,'RowName');  
data=get(handles.mattable,'Data');
material=importdata('library\material.mat');
materiallist=material.name';
set(handles.mattable,'ColumnFormat', {materiallist});                                 

p=getappdata(handles.datastr,'points');
t=getappdata(handles.datastr,'tri');
%=getappdata(handles.datastr,'~');

cla(handles.materialplot)
limmax=max(p);
limmin=min(p);
axes(handles.materialplot);
handles.materialplot=trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','none','edgecolor','k');
xlim([min(limmin) max(limmax)])
ylim([min(limmin) max(limmax)])
zlim([min(limmin) max(limmax)])
set(gca,'XDir','reverse', 'YDir','reverse')
hold on


for i=1:length(data(:,1))
    if strcmp(data{i,1},' ')==1
        data{i,1}=[];
    end
l=isempty(data{i,1});
if l==0 
    surface_name = i;
    t_surf=~(:,3*(surface_name-1)+(1:3));
    l=length(t_surf(isnan(t_surf(:,1))==0));
    t_surf=t_surf(1:l,:);  
    trisurf(t_surf,p(:,1),p(:,2),p(:,3),'facecolor','k','edgecolor','w');
end
end

surface_name = sel(:,1);
t_surf=~(:,3*(surface_name-1)+(1:3));
l=length(t_surf(isnan(t_surf(:,1))==0));
t_surf=t_surf(1:l,:);  
trisurf(t_surf,p(:,1),p(:,2),p(:,3),'facecolor','k','edgecolor',[0.92 0.6 0],'LineWidth',2);
plot3(src(:,1),src(:,2),src(:,3), '-or', 'MarkerSize', 10)
plot3(rec(:,1),rec(:,2),rec(:,3), '-pg', 'MarkerSize', 10)
end


    





% --- Executes on button press in matdata.
function matdata_Callback(~, ~, ~)
% hObject    handle to matdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run matdatabase;

% --- Executes on button press in run.
function run_Callback(~, ~, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% h = warndlg('Please wait while RAT runs the geometry');
data=get(handles.mattable,'Data');
l=[];
for i=1:length(data);
    k=isempty(data{i,1});
    l=[l;k];
end
tf=sum(l);
if tf>0
 errordlg('Please specify a material for each of the surfaces','Material Error'); 
else
    
material=importdata('library\material.mat');
materiallist=material.name;

abs=NaN(length(data),8);
for i=1:length(data)
    l=[];
    k=strcmp(data(i,1),materiallist);
    l=[l;k];
    ind= l==1; 
    if isempty(material.value{ind,1})==1
        errordlg('Please specify a material for each of the surfaces','Material Error'); 
    else
    abs(i,:)=material.value{ind,1};
    end
end

end
src=getappdata(handles.datastr,'src');
rec=getappdata(handles.datastr,'rec');
x1=getappdata(handles.datastr,'x1');
x2=getappdata(handles.datastr,'x2');
x3=getappdata(handles.datastr,'x3');
y1=getappdata(handles.datastr,'y1');
y2=getappdata(handles.datastr,'y2');
z1=getappdata(handles.datastr,'z1');
z2=getappdata(handles.datastr,'z2');
room_type=getappdata(handles.datastr,'room_type');
filename=getappdata(handles.datastr,'filename');
if strcmp(room_type,'custom') && isempty(filename)
   errordlg('File not found Please specify a *dae or *stl file from Browse Button','File Error')
end
file_format=getappdata(handles.datastr,'file_format');
file_format=lower(file_format);
if strcmp(room_type,'shoebox')
if x1==0  || y1==0 || z1==0 
  errordlg('Active parameters can not have a value of zero. Please enter a nonzero value.','Input Error')
    close(h)
  h=warndlg('Computation Failed');
end   
end
if strcmp(room_type,'arena')
if x1==0  || x2==0  || y1==0 || y2==0 || z1==0 || z2==0
  errordlg('Active parameters can not have a value of zero. Please enter a nonzero value.','Input Error')
    close(h)
  h=warndlg('Computation Failed');
end  
if x1>=x2 
  errordlg('x1 can not be bigger than x2. Please enter a valid value.','Input Error')
    close(h)
  h=warndlg('Computation Failed');
end  
if y1>=y2 
  errordlg('y1 can not be bigger than y2. Please enter a valid value.','Input Error')
    close(h)
  h=warndlg('Computation Failed');
end 
end
if strcmp(room_type,'fanshaped')
if x1==0  || x2==0 || x3==0 || y1==0 || y2==0 || z1==0 || z2==0
  errordlg('Active parameters can not have a value of zero. Please enter a nonzero value.','Input Error')
    close(h)
  h=warndlg('Computation Failed');
end  
if x1>=x2 || x3>=x2
  errordlg('x1 and x3 can not be bigger than x2. Please enter a valid value.','Input Error')
    close(h)
  h=warndlg('Computation Failed');
end    
end
axes(handles.materialplot);
 [normal,c,surface,V,surface_area,p,t,tnorm,~ ] = geoanalysis( room_type,filename,x1,x2,x3,y1,y2,z1,z2,src,rec,file_format);
if V==0
  errordlg('Sound source or sound receiver is outside the geometry. Please enter a valid value.','Input Error')
  close(h)
  h=warndlg('Computation Failed');
else
 [ RTEyring,RTSabine,R ] = RTanalysis( surface_area,V,abs);
srcpow=getappdata(handles.datastr,'srcpow');

h = waitbar(100,'Please wait...','Name','Calculating Room Response');
hw=findobj(h,'Type','Patch');
set(hw,'EdgeColor',[0.92 0.6 0],'FaceColor',[0.92 0.6 0])
    waitbar(10 / 100)
[ pp,dist ] = imgen3( src,normal,c,5,abs,rec,surface,srcpow,p,t,tnorm );
    waitbar(70 / 100)
 [ pval,Ppa,pres,t] = RIR2( dist,pp,V,surface_area );
    waitbar(90 / 100)
 [ en,SPL,ts,RT,tdc,d50,c80,ITDG,~ ] = energycalculation2( Ppa,t,pres,RTEyring,V,surface_area );
 purpose=getappdata(handles.datastr,'purpose');

setappdata(handles.datastr,'pres',pres);
setappdata(handles.datastr,'Ppa',Ppa);
setappdata(handles.datastr,'time',t);
setappdata(handles.datastr,'RTSabine',RTSabine);
setappdata(handles.datastr,'rteyring',RTEyring);
setappdata(handles.datastr,'spl',SPL);
setappdata(handles.datastr,'ts',ts);
setappdata(handles.datastr,'RT',RT);
setappdata(handles.datastr,'tdc',tdc);
setappdata(handles.datastr,'d50',d50);
setappdata(handles.datastr,'c80',c80);
setappdata(handles.datastr,'itdg',ITDG);
setappdata(handles.datastr,'pval',pval);
setappdata(handles.datastr,'pp',pp);
setappdata(handles.datastr,'dist',dist);
setappdata(handles.datastr,'edc',en);
advanced = guihandles(handles.Advanced); 
advanced.Ppa=Ppa;
advanced.pres=pres;
advanced.t=t;
advanced.RTSabine=RTSabine;
advanced.RTEyring=RTEyring;
advanced.purpose=purpose;
advanced.SPL=SPL;
advanced.ts=ts;
advanced.RT=RT;
advanced.tdc=tdc;
advanced.d50=d50;
advanced.c80=c80;
advanced.ITDG=ITDG;
advanced.pval=pval;
advanced.edc=en;

waitbar(100 / 100)

close(h) 


guidata(handles.Visualize,advanced) 

run advancedanalysis
if max(t)<2*min(RT)/3
    warndlg('Impulse response length is not sufficient for calculation of parameters. Parameters are calculated by using statistical methods and can be underestimated.','Impulse Response Length','modal');
end
  
end




% --- Executes on selection change in soundfile.
function soundfile_Callback(hObject, ~, handles)
% hObject    handle to soundfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns soundfile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from soundfile
ind=get(hObject,'Value');
if ind==1
    filename=0;
    setappdata(handles.datastr,'wav_filename',filename);
elseif ind==2
    filename='library\speech.wav';
    setappdata(handles.datastr,'wav_filename',filename);
elseif ind==3
    filename='library\church.wav';
    setappdata(handles.datastr,'wav_filename',filename);
elseif ind==4
    filename='library\jazz.wav';
    setappdata(handles.datastr,'wav_filename',filename);
elseif ind==5
    filename='library\classic.wav';
    setappdata(handles.datastr,'wav_filename',filename);
elseif ind==6
    filename='library\pop.wav';
    setappdata(handles.datastr,'wav_filename',filename);
elseif ind==7
    [FileName,PathName,~] = uigetfile({'*.wav'},'Locate *.wav file');
    value=strcat(PathName, FileName);
    setappdata(handles.datastr,'wav_filename',value);
end

% --- Executes on button press in Aural.
function Aural_Callback(~, ~, handles)
% hObject    handle to Aural (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileinput=getappdata(handles.datastr,'wav_filename');
t=getappdata(handles.datastr,'time');
Ppa=getappdata(handles.datastr,'Ppa');

if fileinput==0
     errordlg('Please select a file to auralize from the list or browse custom *.wav file','File Error')
else 
    h = warndlg('Please wait while RAT processes the *.wav file');  
    [ wavdata,nbit,fs,dat ] = prewav( fileinput );
    [ S ] = wavproc( wavdata,fs,t,Ppa,dat );
    aural = guihandles(handles.Aural); 
    aural.s=S;
    aural.fs=fs;
    aural.nbit=nbit;
    aural.wavdata=dat;
    guidata(handles.Visualize,aural) 
    run auralization
    close(h)
end

% --- Executes on button press in Advanced.
function Advanced_Callback(~, ~, handles)
% hObject    handle to Advanced (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ppa=getappdata(handles.datastr,'Ppa');
pres=getappdata(handles.datastr,'pres');
time=getappdata(handles.datastr,'time');
RTSabine=getappdata(handles.datastr,'RTSabine');
RTEyring=getappdata(handles.datastr,'rteyring');
SPL=getappdata(handles.datastr,'spl');
ts=getappdata(handles.datastr,'ts');
RT=getappdata(handles.datastr,'RT');
tdc=getappdata(handles.datastr,'tdc');
d50=getappdata(handles.datastr,'d50');
c80=getappdata(handles.datastr,'c80');
ITDG=getappdata(handles.datastr,'itdg');
pval=getappdata(handles.datastr,'pval');
pp=getappdata(handles.datastr,'pp');
dist=getappdata(handles.datastr,'dist');
edc=getappdata(handles.datastr,'edc');
purpose=getappdata(handles.datastr,'purpose');
if isempty(pres)==1
    errordlg('Please Run the geometry first','Flow Error')
else
advanced = guihandles(handles.Advanced); 
advanced.Ppa=Ppa;
advanced.pres=pres;
advanced.t=time;
advanced.RTSabine=RTSabine;
advanced.RTEyring=RTEyring;

advanced.SPL=SPL;
advanced.ts=ts;
advanced.RT=RT;
advanced.edc=edc;
advanced.tdc=tdc;
advanced.d50=d50;
advanced.c80=c80;
advanced.ITDG=ITDG;
advanced.pval=pval;
advanced.pp=pp;
advanced.dist=dist;
advanced.purpose=purpose;

guidata(handles.Visualize,advanced) 
run advancedanalysis

end



% --- Executes on button press in help.
function help_Callback(~, ~, ~) %#ok<*DEFNU>
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run tutorial
