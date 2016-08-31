function varargout = V2x_GLOSA_GUI(varargin)
%V2X_GLOSA_GUI M-file for V2x_GLOSA_GUI.fig
%      V2X_GLOSA_GUI, by itself, creates a new V2X_GLOSA_GUI or raises the existing
%      singleton*.
%
%      H = V2X_GLOSA_GUI returns the handle to a new V2X_GLOSA_GUI or the handle to
%      the existing singleton*.
%
%      V2X_GLOSA_GUI('Property','Value',...) creates a new V2X_GLOSA_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to V2x_GLOSA_GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      V2X_GLOSA_GUI('CALLBACK') and V2X_GLOSA_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in V2X_GLOSA_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help V2x_GLOSA_GUI

% Last Modified by GUIDE v2.5 21-Aug-2014 14:18:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @V2x_GLOSA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @V2x_GLOSA_GUI_OutputFcn, ...
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


% --- Executes just before V2x_GLOSA_GUI is made visible.
function V2x_GLOSA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for V2x_GLOSA_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes V2x_GLOSA_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = V2x_GLOSA_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
