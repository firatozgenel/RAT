function varargout = auralization(varargin)
% AURALIZATION M-file for auralization.fig
%      AURALIZATION, by itself, creates a new AURALIZATION or raises the existing
%      singleton*.
%
%      H = AURALIZATION returns the handle to a new AURALIZATION or the handle to
%      the existing singleton*.
%
%      AURALIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AURALIZATION.M with the given input arguments.
%
%      AURALIZATION('Property','Value',...) creates a new AURALIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before auralization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to auralization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help auralization

% Last Modified by GUIDE v2.5 03-Feb-2012 16:42:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @auralization_OpeningFcn, ...
                   'gui_OutputFcn',  @auralization_OutputFcn, ...
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


% --- Executes just before auralization is made visible.
function auralization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to auralization (see VARARGIN)

% Choose default command line output for auralization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
aural = guidata(gcbo);
wavdata=aural.wavdata;
S=aural.s;
fs=aural.fs;
nbit=aural.nbit;
p=audioplayer(S,fs,nbit);
po=audioplayer(wavdata,fs,nbit);
play(p)
set(handles.play,'enable','off');
setappdata(handles.save,'S',S);
setappdata(handles.save,'wavdata',wavdata);
setappdata(handles.save,'fs',fs);
setappdata(handles.save,'nbit',nbit);
setappdata(handles.save,'p',p);
setappdata(handles.save,'pp',1);
setappdata(handles.save,'po',po);
setappdata(handles.save,'ppo',0);
axes(handles.axes1);
imshow('library/logo.jpg');
% UIWAIT makes auralization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = auralization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=getappdata(handles.save,'p');
po=getappdata(handles.save,'po');
play(p)
stop(po)
set(handles.stop,'enable','on');
set(handles.stopo,'enable','off');
set(handles.playo,'enable','on');
set(handles.play,'enable','off');
setappdata(handles.save,'pp',1);

% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=getappdata(handles.save,'p');
pp=getappdata(handles.save,'pp');
if pp==1
pause(p)
setappdata(handles.save,'pp',0);
else resume(p)
    setappdata(handles.save,'pp',1);
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=getappdata(handles.save,'p');
stop(p)
set(handles.play,'enable','on');
set(handles.stop,'enable','off');
setappdata(handles.save,'pp',0);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileoutput,PathName] = uiputfile('*.wav','Save Auralization Output');
        if fileoutput==0
            errordlg('Please select a valid filename for the auralization output','File Error')
        else
            wav_output=strcat(PathName, fileoutput);
            S=getappdata(handles.save,'S');
            fs=getappdata(handles.save,'fs');
            nbit=getappdata(handles.save,'nbit');
            wavwrite(S,fs,nbit,wav_output);
        end


% --- Executes on button press in playo.
function playo_Callback(hObject, eventdata, handles)
% hObject    handle to playo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
po=getappdata(handles.save,'po');
p=getappdata(handles.save,'p');
play(po)
stop(p)
set(handles.stopo,'enable','on');
set(handles.stop,'enable','off');
set(handles.playo,'enable','off');
set(handles.play,'enable','on');
setappdata(handles.save,'ppo',1);

% --- Executes on button press in pauso.
function pauso_Callback(hObject, eventdata, handles)
% hObject    handle to pauso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
po=getappdata(handles.save,'po');
ppo=getappdata(handles.save,'ppo');
if ppo==1
pause(po)
setappdata(handles.save,'ppo',0);
else resume(po)
    setappdata(handles.save,'ppo',1);
end

% --- Executes on button press in stopo.
function stopo_Callback(hObject, eventdata, handles)
% hObject    handle to stopo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
po=getappdata(handles.save,'po');
stop(po)
set(handles.playo,'enable','on');
set(handles.stopo,'enable','off');
setappdata(handles.save,'ppo',0);