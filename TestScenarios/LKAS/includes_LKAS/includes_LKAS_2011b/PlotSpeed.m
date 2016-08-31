function varargout = PlotSpeed(varargin)
%PLOTSPEED M-file for PlotSpeed.fig
%      PLOTSPEED, by itself, creates a new PLOTSPEED or raises the existing
%      singleton*.
%
%      H = PLOTSPEED returns the handle to a new PLOTSPEED or the handle to
%      the existing singleton*.
%
%      PLOTSPEED('Property','Value',...) creates a new PLOTSPEED using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PlotSpeed_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PLOTSPEED('CALLBACK') and PLOTSPEED('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PLOTSPEED.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotSpeed

% Last Modified by GUIDE v2.5 03-Aug-2012 13:05:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotSpeed_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotSpeed_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before PlotSpeed is made visible.
function PlotSpeed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PlotSpeed
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PlotSpeed wait for user response (see UIRESUME)
% uiwait(handles.LDW_GUI_1);


% --- Outputs from this function are returned to the command line.
function varargout = PlotSpeed_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when LDW_GUI_1 is resized.
function LDW_GUI_1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to LDW_GUI_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text_Brake_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_Brake (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_Throttle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_Throttle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function LKA_System_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to LKA_System (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Active_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Active (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_LDW.
function text_LDW_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_LDW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_LKA.
function text_LKA_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_LKA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
