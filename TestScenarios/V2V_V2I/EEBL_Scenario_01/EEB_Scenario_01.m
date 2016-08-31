function varargout = EEB_Scenario_01(varargin)
%EEB_SCENARIO_01 M-file for EEB_Scenario_01.fig
%      EEB_SCENARIO_01, by itself, creates a new EEB_SCENARIO_01 or raises the existing
%      singleton*.
%
%      H = EEB_SCENARIO_01 returns the handle to a new EEB_SCENARIO_01 or the handle to
%      the existing singleton*.
%
%      EEB_SCENARIO_01('Property','Value',...) creates a new EEB_SCENARIO_01 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to EEB_Scenario_01_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      EEB_SCENARIO_01('CALLBACK') and EEB_SCENARIO_01('CALLBACK',hObject,...) call the
%      local function named CALLBACK in EEB_SCENARIO_01.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EEB_Scenario_01

% Last Modified by GUIDE v2.5 03-Jan-2014 14:25:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EEB_Scenario_01_OpeningFcn, ...
                   'gui_OutputFcn',  @EEB_Scenario_01_OutputFcn, ...
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


% --- Executes just before EEB_Scenario_01 is made visible.
function EEB_Scenario_01_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for EEB_Scenario_01
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EEB_Scenario_01 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EEB_Scenario_01_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function deceleration_Callback(hObject, eventdata, handles)
% hObject    handle to deceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function deceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
