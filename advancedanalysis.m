function varargout = advancedanalysis(varargin)
% ADVANCEDANALYSIS M-file for advancedanalysis.fig
%      ADVANCEDANALYSIS, by itself, creates a new ADVANCEDANALYSIS or raises the existing
%      singleton*.
%
%      H = ADVANCEDANALYSIS returns the handle to a new ADVANCEDANALYSIS or the handle to
%      the existing singleton*.
%
%      ADVANCEDANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADVANCEDANALYSIS.M with the given input arguments.
%
%      ADVANCEDANALYSIS('Property','Value',...) creates a new ADVANCEDANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before advancedanalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to advancedanalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help advancedanalysis

% Last Modified by GUIDE v2.5 19-Oct-2011 11:29:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @advancedanalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @advancedanalysis_OutputFcn, ...
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


% --- Executes just before advancedanalysis is made visible.
function advancedanalysis_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to advancedanalysis (see VARARGIN)

% Choose default command line output for advancedanalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
imshow('library/selectfreq.jpg')
freq=[63 125 250 500 1000 2000 4000 8000]';
set(handles.freqselection,'Data',freq);
advanced = guidata(gcbo);
Ppa=advanced.Ppa;
pres=advanced.pres;
time=advanced.t;
RTSabine=advanced.RTSabine;
RTEyring=advanced.RTEyring;
purpose=advanced.purpose;
SPL=advanced.SPL;
ts=advanced.ts;
RT=advanced.RT;
tdc=advanced.tdc;
d50=advanced.d50;
c80=advanced.c80;
ITDG=round(1000.*advanced.ts);
edc=advanced.edc;
RTeval=NaN(1,8);
d50eval=NaN(1,8);
c80eval=NaN(1,8);
itdgeval=NaN(1,8);

if purpose==1 || purpose==3


for i=1:8
    data{1,i}=num2str(RTSabine(1,i));
    data{2,i}=num2str(RTEyring(1,i));
    data{3,i}=num2str(RT(1,i));
  if RT(i)>2.2 || RT(i)<1.8
      data{4,i}=('NA!');
  else data{4,i}=('OK');
  end
  data{5,i}=num2str(c80(1,i));
  if c80(1,i)>4 || c80(1,i)<-4
      data{6,i}='NA!';
  else data{6,i}='OK';
  end
  data{7,i}=num2str(d50(1,i));
  if d50(i)>0.6 || d50(i)<0.45
      data{8,i}='NA!';
  else data{8,i}='OK';
  end
  data{9,i}=num2str(ITDG(1,i));
  if ITDG(i)>140
      data{10,i}='NA!';
  else data{10,i}='OK';
  end  
end
data{1,9}='1.8<RT<2.2';
data{2,9}='1.8<RT<2.2';
data{3,9}='1.8<RT<2.2';
data{4,9}='1.8<RT<2.2';
data{5,9}='-4<C80z<4';
data{6,9}='-4<C80z<4';
data{7,9}='0.45<D50<0.6';
data{8,9}='0.45<D50<0.6';
data{9,9}='TS<140';
data{10,9}='TS<140';

elseif purpose==2

for i=1:8
    data{1,i}=num2str(RTSabine(1,i));
    data{2,i}=num2str(RTEyring(1,i));
    data{3,i}=num2str(RT(1,i));
  if RT(i)>1.3 || RT(i)<0.85
      data{4,i}=('NA!');
  else data{4,i}=('OK');
  end
  data{5,i}=num2str(c80(1,i));
  if c80(1,i)>4 || c80(1,i)<-4
      data{6,i}='NA!';
  else data{6,i}='OK';
  end
  data{7,i}=num2str(d50(1,i));
  if  d50(i)<0.65
      data{8,i}='NA!';
  else data{8,i}='OK';
  end
  data{9,i}=num2str(ITDG(1,i));
  if ITDG(i)>140
      data{10,i}='NA!';
  else data{10,i}='OK';
  end  
end
data{1,9}='0.85<RT<1.3';
data{2,9}='0.85<RT<1.3';
data{3,9}='0.85<RT<1.3';
data{4,9}='0.85<RT<1.3';
data{5,9}='-4<C80z<4';
data{6,9}='-4<C80z<4';
data{7,9}='0.65<D50';
data{8,9}='0.65<D50';
data{9,9}='TS<140';
data{10,9}='TS<140';

end

set(handles.advancedtable,'Data',data);
set(handles.advancedtable, 'Rowname',{'RT Sabine(s)','RT Eyring (s)','RT Calculated(s)','RT Evaluation','C80','C80 Evaluation','D50','D50 Evaluation','TS','TS Evaluation'});
setappdata(handles.freqselection,'Pdb',pres);
setappdata(handles.freqselection,'rtsabine',RTSabine);
setappdata(handles.freqselection,'rteyring',RTEyring);
setappdata(handles.freqselection,'rt',RT);
setappdata(handles.freqselection,'Ppa',Ppa)
setappdata(handles.freqselection,'T',time);
setappdata(handles.graphtype,'type','ppa')
setappdata(handles.freqselection,'purpose',purpose);

setappdata(handles.freqselection,'tdc',tdc);
setappdata(handles.freqselection,'edc',edc);
set(handles.advancedtable,'BackgroundColor',[1 1 1;0.92 0.6 0]);
set(handles.desc,'FontSize',12);
set(handles.text2,'ForegroundColor',[0.92 0.6 0]);
xlabel('Time(s)');
ylabel('Pressure(Pa)');



% UIWAIT makes advancedanalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = advancedanalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in graphtype.
function graphtype_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in graphtype 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
RTSabine=getappdata(handles.freqselection,'rtsabine');
RT=getappdata(handles.freqselection,'rt');
RTEyring=getappdata(handles.freqselection,'rteyring');
cla(handles.echogram);
switch get(eventdata.NewValue,'Tag')
    case 'ppa'
        setappdata(handles.graphtype,'type','ppa');       
        legend('off')
        xlabel('Time(s)');
        ylabel('Pressure(Pa)');
        set(handles.freqselection, 'enable', 'on');
        imshow('library/selectfreq.jpg')
    case 'pdb'
        setappdata(handles.graphtype,'type','pdb');
        legend('off')
        xlabel('Time(s)');
        ylabel('Pressure(dB)');
        set(handles.freqselection, 'enable', 'on');
        imshow('library/selectfreq.jpg')
    case 'rt'
        setappdata(handles.graphtype,'type','rt');
        RTcomp=[RTSabine;RT;RTEyring];
        reset(handles.echogram);
        k=plot(RTcomp');
        legend(k,'RT Sabine','RT Calculated','RTEyring')
        xlabel('Frequency(Hz)');
        ylabel('Time(s)');
        set(handles.freqselection, 'enable', 'off');
    case 'energy'
        setappdata(handles.graphtype,'type','energy');
        legend('off')
        xlabel('Time(s)');
        ylabel('Pressure(dB)');
        set(handles.freqselection, 'enable', 'on');
        imshow('library/selectfreq.jpg')
    otherwise
end

% --- Executes when selected cell(s) is changed in freqselection.
function freqselection_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to freqselection (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

sel = eventdata.Indices;
Ppa=getappdata(handles.freqselection,'Ppa');
t=getappdata(handles.freqselection,'T');
Pdb=getappdata(handles.freqselection,'Pdb');

tdc=getappdata(handles.freqselection,'tdc');
edc=getappdata(handles.freqselection,'edc');
type=getappdata(handles.graphtype,'type');
if strcmp(type,'ppa')
    reset(handles.echogram);
    handles.echogram=bar(t,Ppa(:,sel(1,1)));
    xlabel('Time(s)');
    ylabel('Pressure(Pa)');
elseif strcmp(type,'pdb')
    reset(handles.echogram);
    handles.echogram=bar(t,Pdb(:,sel(1,1)));
    xlabel('Time(s)');
    ylabel('Pressure(dB)');
elseif strcmp(type, 'energy')
    reset(handles.echogram);
    handles.echogram=plot(tdc(:,sel(1,1)),edc(:,sel(1,1)));
    xlabel('Time(s)');
    ylabel('Pressure(dB)');
end
    

% --- Executes when selected cell(s) is changed in advancedtable.
function advancedtable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to advancedtable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.advancedtable,'data');
sel = eventdata.Indices; 
purpose=getappdata(handles.freqselection,'purpose');
if purpose==1 || purpose==3
    if length(sel(:,1))>1
    set(handles.desc,'String','Please select only one cell');
    else
    if sel(1,2)==9
    set(handles.desc,'String','Please select a value to see the description');
    elseif sel(1,1)<=4 && str2num(data{3,sel(1,2)})<1.8
    set(handles.desc,'String','Reverberation time is not sufficient. Consider increasing volume or selecting materials with lower absorption coefficients.');
    elseif sel(1,1)<=4 && str2num(data{3,sel(1,2)})>= 1.8 && str2num(data{3,sel(1,2)})<= 2.2
    set(handles.desc,'String','Reverberation time is in acceptable range.');
    elseif sel(1,1)<=4 && str2num(data{3,sel(1,2)})>2.2
    set(handles.desc,'String','Reverberation time is longer than acceptable range. Consider decreasing volume or selecting materials with higher absorption coefficients.');
    elseif sel(1,1)>4 && sel(1,1)<7 && str2num(data{5,sel(1,2)})<-4
    set(handles.desc,'String','C80 value is less than acceptable range. Consider increasing volume,increasing sound power level or selecting materials with lower absorption coefficients');  
    elseif sel(1,1)>4 && sel(1,1)<7 && str2num(data{5,sel(1,2)})>4
    set(handles.desc,'String','C80 value is more than acceptable range. Consider decreasing volume,decreasing sound power level or selecting materials with higher absorption coefficients.');
    elseif sel(1,1)>4 && sel(1,1)<7 && str2num(data{5,sel(1,2)})>= -4 && str2num(data{5,sel(1,2)})<= 4
    set(handles.desc,'String','C80 value is in acceptable range.');    
    elseif sel(1,1)>6 && sel(1,1)<9 && str2num(data{7,sel(1,2)})<0.45
    set(handles.desc,'String','D50 value is less than acceptable range. Consider increasing volume, increasing sound power level or selecting materials with lower absorption coefficients');  
    elseif sel(1,1)>6 && sel(1,1)<9 && str2num(data{7,sel(1,2)})>0.6
    set(handles.desc,'String','D50 value is more than acceptable range. Consider decreasing volume,decreasing sound power level or selecting materials with higher absorption coefficients.');
    elseif sel(1,1)>6 && sel(1,1)<9 && str2num(data{7,sel(1,2)})>= 0.45 && str2num(data{7,sel(1,2)})<= 0.6
    set(handles.desc,'String','D50 value is in acceptable range.');    
    elseif sel(1,1)>8  && str2num(data{9,sel(1,2)})>140
    set(handles.desc,'String','TS value is higher than acceptable range. Consider decreasing volume,decreasing sound power level or selecting materials with higher absorption coefficients.');  
    elseif sel(1,1)>8  && str2num(data{9,sel(1,2)})<= 140
    set(handles.desc,'String','TS value is in acceptable range.');  
    end
    end
    
elseif purpose==2
    
    if length(sel(:,1))>1
    set(handles.desc,'String','Please select only one cell');
    else
    if sel(1,2)==9
    set(handles.desc,'String','Please select a value to see the description');
    elseif sel(1,1)<=4 && str2num(data{3,sel(1,2)})<0.85
    set(handles.desc,'String','Reverberation time is not sufficient. Consider increasing volume or selecting materials with lower absorption coefficients.');
    elseif sel(1,1)<=4 && str2num(data{3,sel(1,2)})>= 0.85 && str2num(data{3,sel(1,2)})<= 1.3
    set(handles.desc,'String','Reverberation time is in acceptable range.');
    elseif sel(1,1)<=4 && str2num(data{3,sel(1,2)})>1.3
    set(handles.desc,'String','Reverberation time is longer than acceptable range. Consider decreasing volume or selecting materials with higher absorption coefficients.');
    elseif sel(1,1)>4 && sel(1,1)<7 && str2num(data{5,sel(1,2)})<-4
    set(handles.desc,'String','C80 value is less than acceptable range. Consider increasing volume,increasing sound power level or selecting materials with lower absorption coefficients');  
    elseif sel(1,1)>4 && sel(1,1)<7 && str2num(data{5,sel(1,2)})>4
    set(handles.desc,'String','C80 value is more than acceptable range. Consider decreasing volume,decreasing sound power level or selecting materials with higher absorption coefficients.');
    elseif sel(1,1)>4 && sel(1,1)<7 && str2num(data{5,sel(1,2)})>= -4 && str2num(data{5,sel(1,2)})<= 4
    set(handles.desc,'String','C80 value is in acceptable range.');    
    elseif sel(1,1)>6 && sel(1,1)<9 && str2num(data{7,sel(1,2)})<0.65
    set(handles.desc,'String','D50 value is less than acceptable range. Consider increasing volume, increasing sound power level or selecting materials with lower absorption coefficients');  
    elseif sel(1,1)>6 && sel(1,1)<9 && str2num(data{7,sel(1,2)})>= 0.65
    set(handles.desc,'String','D50 value is in acceptable range.');    
    elseif sel(1,1)>8  && str2num(data{9,sel(1,2)})>140
    set(handles.desc,'String','TS value is higher than acceptable range. Consider decreasing volume,decreasing sound power level or selecting materials with higher absorption coefficients.');  
    elseif sel(1,1)>8  && str2num(data{9,sel(1,2)})<= 140
    set(handles.desc,'String','TS value is in acceptable range.');  
    end
    end
end
