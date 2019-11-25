function varargout = roomvisual(varargin)
% ROOMVISUAL M-file for roomvisual.fig
%      ROOMVISUAL, by itself, creates a new ROOMVISUAL or raises the existing
%      singleton*.
%
%      H = ROOMVISUAL returns the handle to a new ROOMVISUAL or the handle to
%      the existing singleton*.
%
%      ROOMVISUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROOMVISUAL.M with the given input arguments.
%
%      ROOMVISUAL('Property','Value',...) creates a new ROOMVISUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before roomvisual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to roomvisual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help roomvisual

% Last Modified by GUIDE v2.5 31-Jul-2011 01:05:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @roomvisual_OpeningFcn, ...
                   'gui_OutputFcn',  @roomvisual_OutputFcn, ...
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


% --- Executes just before roomvisual is made visible.
function roomvisual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to roomvisual (see VARARGIN)

% Choose default command line output for roomvisual
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
cla(handles.top,'reset')
cla(handles.side,'reset')
cla(handles.front,'reset')
cla(handles.per,'reset')
data = guidata(gcbo);
p=data.p;
t=data.t;
src=data.src;
rec=data.rec;
rotate3d(handles.per);
set(gcf,'CurrentAxes',handles.per)
limp=max(p);
limn=min(p);
k=trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','none','edgecolor','b');
hold on
plot3(src(:,1),src(:,2),src(:,3), '-or', 'MarkerSize', 10)
plot3(rec(:,1),rec(:,2),rec(:,3), '-pg', 'MarkerSize', 10)
xlim([min(limn) max(limp)])
ylim([min(limn) max(limp)])
zlim([min(limn) max(limp)])
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Perspective View')
set(gca,'XDir','reverse', 'YDir','reverse')
set(gcf,'CurrentAxes',handles.top)
lim=max(p);
k=trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','none','edgecolor','b');
hold on
plot3(src(:,1),src(:,2),src(:,3), '-or', 'MarkerSize', 10)
plot3(rec(:,1),rec(:,2),rec(:,3), '-pg', 'MarkerSize', 10)
xlim([min(limn) max(limp)])
ylim([min(limn) max(limp)])
zlim([min(limn) max(limp)])
view(0,90)
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Top View')
set(gcf,'CurrentAxes',handles.side)
lim=max(p);
k=trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','none','edgecolor','b');
hold on
plot3(src(:,1),src(:,2),src(:,3), '-or', 'MarkerSize', 10)
plot3(rec(:,1),rec(:,2),rec(:,3), '-pg', 'MarkerSize', 10)
xlim([min(limn) max(limp)])
ylim([min(limn) max(limp)])
zlim([min(limn) max(limp)])
view(90,0)
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Side View')
set(gcf,'CurrentAxes',handles.front)
lim=max(p);
k=trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','none','edgecolor','b');
hold on
plot3(src(:,1),src(:,2),src(:,3), '-or', 'MarkerSize', 10)
plot3(rec(:,1),rec(:,2),rec(:,3), '-pg', 'MarkerSize', 10)
xlim([min(limn) max(limp)])
ylim([min(limn) max(limp)])
zlim([min(limn) max(limp)])
view(0,0)
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Front View')



% UIWAIT makes roomvisual wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = roomvisual_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
