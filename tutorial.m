function varargout = tutorial(varargin)
% TUTORIAL M-file for tutorial.fig
%      TUTORIAL, by itself, creates a new TUTORIAL or raises the existing
%      singleton*.
%
%      H = TUTORIAL returns the handle to a new TUTORIAL or the handle to
%      the existing singleton*.
%
%      TUTORIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUTORIAL.M with the given input arguments.
%
%      TUTORIAL('Property','Value',...) creates a new TUTORIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tutorial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tutorial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tutorial

% Last Modified by GUIDE v2.5 18-Dec-2011 11:01:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tutorial_OpeningFcn, ...
                   'gui_OutputFcn',  @tutorial_OutputFcn, ...
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


% --- Executes just before tutorial is made visible.
function tutorial_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tutorial (see VARARGIN)

% Choose default command line output for tutorial
handles.output = hObject;
% tutorial=importdata('library/tutorial.mat');
% Update handles structure
guidata(hObject, handles);
imshow('library/tutorial.jpg');
pageno=1;
setappdata(handles.next,'pgno',pageno);
set(handles.next,'enable','on');
set(handles.start,'enable','off');
set(handles.back,'enable','off');

% UIWAIT makes tutorial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tutorial_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in next.
function next_Callback(~, ~, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pgno=getappdata(handles.next,'pgno');
if pgno==1
    imshow('library/tutorial2.jpg');
    set(handles.next,'enable','on');
    set(handles.start,'enable','off');
    set(handles.back,'enable','on');
    setappdata(handles.next,'pgno',pgno+1);
elseif pgno==2
    imshow('library/tutorial3.jpg');
    set(handles.next,'enable','off');
    set(handles.start,'enable','on');
    set(handles.back,'enable','on');
    setappdata(handles.next,'pgno',pgno+1);
end
    


% --- Executes on button press in start.
function start_Callback(~, ~, ~)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes on button press in back.
function back_Callback(~, ~, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pgno=getappdata(handles.next,'pgno');
if pgno==2
    imshow('library/tutorial.jpg');
    set(handles.next,'enable','on');
    set(handles.start,'enable','off');
    set(handles.back,'enable','off');
    setappdata(handles.next,'pgno',pgno-1);
elseif pgno==3
    imshow('library/tutorial2.jpg');
    set(handles.next,'enable','on');
    set(handles.start,'enable','off');
    set(handles.back,'enable','on');
    setappdata(handles.next,'pgno',pgno-1);
end
