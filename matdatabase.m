function varargout = matdatabase(varargin)
% MATDATABASE M-file for matdatabase.fig
%      MATDATABASE, by itself, creates a new MATDATABASE or raises the existing
%      singleton*.
%
%      H = MATDATABASE returns the handle to a new MATDATABASE or the handle to
%      the existing singleton*.
%
%      MATDATABASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATDATABASE.M with the given input arguments.
%
%      MATDATABASE('Property','Value',...) creates a new MATDATABASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matdatabase_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matdatabase_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matdatabase

% Last Modified by GUIDE v2.5 18-Dec-2011 11:37:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matdatabase_OpeningFcn, ...
                   'gui_OutputFcn',  @matdatabase_OutputFcn, ...
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


% --- Executes just before matdatabase is made visible.
function matdatabase_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matdatabase (see VARARGIN)

% Choose default command line output for matdatabase
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
material=importdata('library\material.mat');

materiallist=material.name(2:length(material.name))';
materialval=material.value(2:length(material.name));
set(handles.matlistbox,'String',materiallist);
data=blanks(2)';
data=cellstr(data);
data=[data data];
set(handles.hybridtable,'Data',data);
set(handles.hybridtable,'ColumnFormat', {materiallist});
fq=[63 125 250 500 1000 2000 4000 8000];

k=plot(fq,materialval{1,1});
xlim([0 8000])
ylim([0 1.2])
set(gca,'XScale','log')
set(gca,'XTickLabel',{'63';'125';'250';'500';'1000';'2000';'4000';'8000'});
set(gca,'XTick',[63 125 250 500 1000 2000 4000 8000]);
xlabel('Frequency')
ylabel('Absorption Coefficient')
handles.matplot=k;
material.name=materiallist;
material.value=materialval;
setappdata(handles.matlistbox,'material',material);
set(handles.coeftable,'data',material.value{1,1}');
set(handles.custommatcoef,'data',zeros(1,8));

% UIWAIT makes matdatabase wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = matdatabase_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
k=getappdata(handles.matlistbox,'material');
handles.output=k;
varargout{1} = handles.output;


% --- Executes on selection change in matlistbox.
function matlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to matlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns matlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from matlistbox
ind=get(hObject,'Value');
material=getappdata(handles.matlistbox,'material');

fq=[63 125 250 500 1000 2000 4000 8000];
k=plot(fq,material.value{ind,1});
xlim([63 8000])
ylim([0 1.2])
set(gca,'XTickLabel',{'63';'125';'250';'500';'1000';'2000';'4000';'8000'});
set(gca,'XTick',[63 125 250 500 1000 2000 4000 8000]);
set(gca,'XScale','log')
xlabel('Frequency')
ylabel('Absorption Coefficient')
handles.matplot=k;
setappdata(handles.matlistbox,'index',ind);
set(handles.coeftable,'data',material.value{ind,1}');




function custommatname_Callback(hObject, eventdata, handles)
% hObject    handle to custommatname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of custommatname as text
%        str2double(get(hObject,'String')) returns contents of custommatname as a double
matname=get(hObject,'String');
setappdata(handles.custommatname,'name',matname);



% --- Executes on button press in createmat.
function createmat_Callback(hObject, eventdata, handles)
% hObject    handle to createmat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matname=getappdata(handles.custommatname,'name');
matvalue=get(handles.custommatcoef,'data');

if isempty(matname)
errordlg('Please specify a name for custom material','Material Name Error');
end

if length(matvalue(1,:))~=8
 errordlg('Please enter 8 absorption coefficient values for custom material','Material Value Error');   
end
material=importdata('library\material.mat');
l=length(material.name);
material.name{l+1,1}=matname;
material.value{l+1,1}=matvalue;
save('library\material.mat','-struct', 'material');
materiallist=material.name(2:length(material.name))';
materialval=material.value(2:length(material.name));
material.name=materiallist;
material.value=materialval;
setappdata(handles.matlistbox,'material',material);
set(handles.matlistbox,'String',materiallist);
set(handles.custommatcoef,'data',zeros(1,8));


 



function patchnumber_Callback(hObject, eventdata, handles)
% hObject    handle to patchnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patchnumber as text
%        str2double(get(hObject,'String')) returns contents of patchnumber as a double
c=str2double(get(hObject,'String'));
if c<2 || isnan(c)
    errordlg('Please enter a numerical value more than 2','Patch Number Error'); 
end
material=importdata('library\material.mat');
materiallist=material.name(2:length(material.name))';
set(handles.matlistbox,'String',materiallist);
data=blanks(c)';
data=cellstr(data);
data=[data data];
set(handles.hybridtable,'Data',data);
set(handles.hybridtable,'ColumnFormat',{materiallist});




function patchmatname_Callback(hObject, eventdata, handles)
% hObject    handle to patchmatname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patchmatname as text
%        str2double(get(hObject,'String')) returns contents of patchmatname as a double
patchmatname=get(hObject,'String');
setappdata(handles.patchmatname,'name',patchmatname);


% --- Executes on button press in createpatchmat.
function createpatchmat_Callback(hObject, eventdata, handles)
% hObject    handle to createpatchmat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=get(handles.hybridtable,'data');
material=importdata('library\material.mat');
materiallist=material.name;
abs=NaN(length(data(:,1)),8);
for i=1:length(data(:,1))
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
for i=1:length(data(:,1))
   k=str2double(data(i,2));
   if isempty(k)|| k<=0
     errordlg('Please enter a valid postive numerical area value for each patch','Area Error'); 
   else 
     area(i,1)=k;  
   end      
end
set(handles.uitable5,'data',area);

for i=1:length(abs(:,1))
    for j=1:8
        abst(i,j)=abs(i,j)*area(i,2); 
    end
end

for i=1:8
    absav(1,i)=sum(abst(:,i))/sum(area(:,2));
end
fq=[63 125 250 500 1000 2000 4000 8000];
k=plot(fq,absav);
xlim([63 8000])
ylim([0 1.2])
set(gca,'XTickLabel',{'63';'125';'250';'500';'1000';'2000';'4000';'8000'});
set(gca,'XTick',[63 125 250 500 1000 2000 4000 8000]);
set(gca,'XScale','log')
xlabel('Frequency')
ylabel('Absorption Coefficient')
handles.matplot=k;
set(handles.coeftable,'data',absav');

patchmatname=getappdata(handles.patchmatname,'name');
if isempty(patchmatname)
errordlg('Please specify a name for custom material','Material Name Error');
end
l=length(material.name);
material.name{l+1,1}=patchmatname;
material.value{l+1,1}=absav;
save('library\material.mat','-struct', 'material');
materiallist=material.name(2:length(material.name))';
materialval=material.value(2:length(material.name));
material.name=materiallist;
material.value=materialval;
setappdata(handles.matlistbox,'material',material);
set(handles.matlistbox,'String',materiallist);


% --- Executes on button press in preview.
function preview_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.hybridtable,'data');
material=importdata('library\material.mat');
materiallist=material.name;
abs=NaN(length(data(:,1)),8);
for i=1:length(data(:,1))
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
for i=1:length(data(:,1))
   k=str2double(data(i,2));
   if isempty(k)|| k<=0
     errordlg('Please enter a valid postive numerical area value for each patch','Area Error'); 
   else 
     area(i,1)=k;  
   end      
end
for i=1:length(abs(:,1))
    for j=1:8
        abst(i,j)=abs(i,j)*area(i); 
    end
end

for i=1:8
    absav(1,i)=sum(abst(:,i))/sum(area);
end
fq=[63 125 250 500 1000 2000 4000 8000];
cla(handles.matplot)
handles.matplot=plot(fq,absav);
xlim([63 8000])
ylim([0 1.2])
set(gca,'XTickLabel',{'63';'125';'250';'500';'1000';'2000';'4000';'8000'});
set(gca,'XTick',[63 125 250 500 1000 2000 4000 8000]);
set(gca,'XScale','log')
xlabel('Frequency')
ylabel('Absorption Coefficient')
set(handles.coeftable,'data',absav');


% % --- Executes when figure1 is resized.
% function figure1_ResizeFcn(hObject, eventdata, handles)
% % hObject    handle to figure1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% up = findobj('Tag','uipanel1');
% uf=findobj('Tag','figure1');
% figure1 = gcbo;
% old_units = get(figure1,'Units');
% set(figure1,'Units','pixels');
% tpos=get(handles.custommatcoef,'Position');
% upos=get(handles.uipanel1,'Position');
% 
% set(handles.custommatcoef,'ColumnWidth', {upos(3)/8});
% 
% set(figure1,'Units',old_units);
