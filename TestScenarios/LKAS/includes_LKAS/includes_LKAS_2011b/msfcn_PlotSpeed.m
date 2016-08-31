function msfcn_PlotSpeed(block)
setup(block);
%endfunction



function setup( block )

%% define number of input and output ports
block.NumInputPorts  = 11;   %need to add Input Port Steering Angle
block.NumOutputPorts = 1;
block.NumDialogPrms =2;


%% port properties
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.InputPort(1).Complexity = 'real'; % Engine velocity
block.InputPort(1).DataTypeId = 0; %real
block.InputPort(1).SamplingMode = 'Sample';
block.InputPort(1).Dimensions = 1;

block.InputPort(2).Complexity = 'real'; % Vehicle velocity
block.InputPort(2).DataTypeId = 0; %real
block.InputPort(2).SamplingMode = 'Sample';
block.InputPort(2).Dimensions = 1;

block.InputPort(3).Complexity = 'real'; % Brake
block.InputPort(3).DataTypeId = 0; %real
block.InputPort(3).SamplingMode = 'Sample';

block.InputPort(4).Complexity = 'real'; % Throttle
block.InputPort(4).DataTypeId = 0; %real
block.InputPort(4).SamplingMode = 'Sample';

block.InputPort(5).Complexity = 'real'; % Warning sign left
block.InputPort(5).DataTypeId = -1; %logical
block.InputPort(5).SamplingMode = 'Sample';

block.InputPort(6).Complexity = 'real'; % Warning sign right
block.InputPort(6).DataTypeId = -1; %logical
block.InputPort(6).SamplingMode = 'Sample';

block.InputPort(7).Complexity = 'real'; % LDW sign
block.InputPort(7).DataTypeId = -1; %logical
block.InputPort(7).SamplingMode = 'Sample';

block.InputPort(8).Complexity = 'real'; % Initial system
block.InputPort(8).DataTypeId = 0; %real
block.InputPort(8).SamplingMode = 'Sample';
block.InputPort(8).Dimensions = 1;

block.InputPort(9).Complexity = 'real'; % Steer
block.InputPort(9).SamplingMode = 'Sample';

block.InputPort(10).Complexity = 'real'; % Clock
block.InputPort(10).SamplingMode = 'Sample';

block.InputPort(11).Complexity = 'real'; % LKA sign
block.InputPort(11).DataTypeId = -1; %logical
block.InputPort(11).SamplingMode = 'Sample';


block.OutputPort(1).Complexity = 'real'; % LDW button
block.OutputPort(1).DataTypeId = 0; %real
block.OutputPort(1).SamplingMode = 'Sample';

%% register methods
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);

%% Block runs on TLC in accelerator mode.
block.SetAccelRunOnTLC(true);
%endfunction

function Start(block)
if block.DialogPrm(1).Data
    try%#ok<TRYNC>
        close (PlotSpeed);   %name of figure
    end
    h_dlg               = PlotSpeed;      %name of figure
    h_Vehicle_velocity  = findobj(h_dlg, 'Tag', 'text_Vehicle_speed');
    h_Engine_velocity   = findobj(h_dlg, 'Tag', 'text_Engine_speed');
    h_Brake             = findobj(h_dlg, 'Tag', 'text_Brake');
    h_Warning           = findobj(h_dlg, 'Tag', 'text_Warning');
    h_WarningBlock      = findobj(h_dlg, 'Tag', 'Warning');
    h_Warning2          = findobj(h_dlg, 'Tag', 'text_Warning2');
    h_WarningBlock2     = findobj(h_dlg, 'Tag', 'Warning2');
    h_text_LDW          = findobj(h_dlg, 'Tag', 'text_LDW');
    h_Active            = findobj(h_dlg, 'Tag', 'Active');
    
    h_LDW1 = findobj(h_dlg, 'Tag', 'LDW1');
    h_LDW2 = findobj(h_dlg, 'Tag', 'LDW2');
    h_LDW3 = findobj(h_dlg, 'Tag', 'LDW3');
    
    %For LKA%
    h               = findobj(h_dlg, 'Tag', 'text_LKA');
    h_text_LKA      = h;
    h1              = findobj(h_dlg, 'Tag', 'LKA_System');
    h_Active_LKA    = h1;
    h_Steer_Left    = findobj(h_dlg, 'Tag', 'Steer_Left');
    h_Steer_Right   = findobj(h_dlg, 'Tag', 'Steer_Right');
    
    handles = [h_dlg h_Vehicle_velocity h_Engine_velocity h_Brake h_Warning h_WarningBlock h_Warning2 h_WarningBlock2 h_text_LDW h_Active h_LDW1 h_LDW2 h_LDW3 h_text_LKA h_Active_LKA h_Steer_Left h_Steer_Right];
    set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');
end
%endfunction Start

function Outputs(block)
handles = get_param(block.BlockHandle, 'UserData');

h_Engine_velocity   = handles(3);
h_Vehicle_velocity  = handles(2);
h_Brake             = handles(4);
h_Warning           = handles(5);
h_WarningBlock      = handles(6);
h_Warning2          = handles(7);
h_WarningBlock2     = handles(8);
h_text_LDW          = handles(9);
h_Active            = handles(10);
h_LDW1              = handles(11);
h_LDW2              = handles(12);
h_LDW3              = handles(13);

%For LKA%
h_text_LKA      = handles(14);
h_Active_LKA    = handles(15);
h_Steer_Left    = handles(16);
h_Steer_Right   = handles(17);

set(h_Engine_velocity,'String',num2str(block.InputPort(1).Data));
set(h_Vehicle_velocity,'String',num2str(block.InputPort(2).Data));
set(h_Brake,'String',num2str(block.InputPort(3).Data));

if block.InputPort(10).Data <= block.DialogPrm(2).Data
    switch block.InputPort(8).Data
        case 1 % LDW
            set(h_LDW1,'Value',0);
            set(h_LDW2,'Value',1);
            set(h_LDW3,'Value',0);
        case 2 % LKA Guide
            set(h_LDW1,'Value',0);
            set(h_LDW2,'Value',0);
            set(h_LDW3,'Value',1);
        otherwise % System off
            set(h_LDW1,'Value',1);
            set(h_LDW2,'Value',0);
            set(h_LDW3,'Value',0);
    end
end

if logical(block.InputPort(5).Data)
    TextColor = [1 0 0];
    BorderColor = [1 0 0];
else
    TextColor = [0.9 0.9 0.9];
    BorderColor = [0.5 0.5 0.5];
end

if logical(block.InputPort(6).Data)
    TextColor2 = [1 0 0];
    BorderColor2 = [1 0 0];
else
    TextColor2 = [0.9 0.9 0.9];
    BorderColor2 = [0.5 0.5 0.5];
end

if logical(block.InputPort(7).Data)
    TextColor3 = [0 1 0];
    BorderColor3 = [0 1 0];
else
    TextColor3 = [0.9 0.9 0.9];
    BorderColor3 = [0.5 0.5 0.5];
end

if logical(block.InputPort(11).Data)
    TextColor4 = [0 1 0];
    BorderColor4 = [0 1 0];
    
    if (sign(block.InputPort(9).Data) == 1)
        %For Axes - Plotting Rectangle%
        axes(h_Steer_Right);
        cla;
        axes(h_Steer_Left);
        cla;
        rectangle('Position',[100.0-(abs(block.InputPort(9).Data) - 0.1),0.0,100.0,5], 'FaceColor','r');
        
    else
        %For Axes - Plotting Rectangle%
        axes(h_Steer_Left);
        cla;
        axes(h_Steer_Right);
        cla;
        rectangle('Position',[0.0,0.0,abs(block.InputPort(9).Data)+0.1,5], 'FaceColor','r');
    end
else
    TextColor4 = [0.9 0.9 0.9];
    BorderColor4 = [0.5 0.5 0.5];
end

set(h_Warning,'String','Warning','ForegroundColor',TextColor);
set(h_WarningBlock,'HighlightColor',BorderColor,'ShadowColor',BorderColor);

set(h_Warning2,'String','Warning','ForegroundColor',TextColor2);
set(h_WarningBlock2,'HighlightColor',BorderColor2,'ShadowColor',BorderColor2);

set(h_text_LDW,'String','Active','ForegroundColor',TextColor3);
set(h_Active,'HighlightColor',BorderColor3,'ShadowColor',BorderColor3);

%For LKA %
set(h_text_LKA,'string','Active','foregroundcolor',TextColor4);
set(h_Active_LKA,'HighlightColor',BorderColor4,'ShadowColor',BorderColor4);

% drawnow
block.OutputPort(1).Data = get(h_LDW1,'Value')+get(h_LDW2,'Value')*2+get(h_LDW3,'Value')*3;
%endfunction Outputs
