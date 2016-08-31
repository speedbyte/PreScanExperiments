function msfcn_V2x_GLOSA_GUI(block)
setup(block);
%endfunction



function setup( block )


%% define number of input and output ports
block.NumInputPorts  = 6;
block.NumOutputPorts = 2;


%% port properties
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.InputPort(1).Complexity = 'real'; % Vehicle velocity
block.InputPort(1).DataTypeId = 0; %real
block.InputPort(1).SamplingMode = 'Sample';
block.InputPort(1).Dimensions = 1;

block.InputPort(2).Complexity = 'real'; % lightsColor
block.InputPort(2).DataTypeId = 0;
block.InputPort(2).SamplingMode = 'Sample';
block.InputPort(2).Dimensions = 1;

block.InputPort(3).Complexity = 'real'; % lightsTime
block.InputPort(3).DataTypeId = 0;
block.InputPort(3).SamplingMode = 'Sample';
block.InputPort(3).Dimensions = 1;

block.InputPort(4).Complexity = 'real'; % suggestedVelocity
block.InputPort(4).DataTypeId = 0;
block.InputPort(4).SamplingMode = 'Sample';
block.InputPort(4).Dimensions = 1;

block.InputPort(5).Complexity = 'real'; % sign flag
block.InputPort(5).DataTypeId = 0;
block.InputPort(5).SamplingMode = 'Sample';
block.InputPort(5).Dimensions = 1;

block.InputPort(6).Complexity = 'real'; % sign flag
block.InputPort(6).DataTypeId = 0;
block.InputPort(6).SamplingMode = 'Sample';
block.InputPort(6).Dimensions = 1;

block.OutputPort(1).Complexity = 'real'; % last sign flag
block.OutputPort(1).DataTypeId = 0;
%block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).SamplingMode = 'Sample';

block.OutputPort(2).Complexity = 'real'; % last sign flag
block.OutputPort(2).DataTypeId = 0;
%block.OutputPort(2).Dimensions = 1;
block.OutputPort(2).SamplingMode = 'Sample';

%% Register parameters
block.NumDialogPrms     = 0;

% %% block sample time
% block.SampleTimes = [1/dfreq 0];

%% register methods
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);

%% Block runs on TLC in accelerator mode.
block.SetAccelRunOnTLC(true);
%endfunction

function Start(block)

try%#ok<TRYNC>
    close (V2x_GLOSA_GUI)
end
h_dlg = V2x_GLOSA_GUI;
%h_Velocity_image = findobj(h_dlg, 'Tag', 'Speed_image');
h_Vehicle_velocity = findobj(h_dlg, 'Tag', 'text_Vehicle_speed');
V2x_sign = findobj(h_dlg, 'Tag', 'V2x_sign');
h_WarningBlock = findobj(h_dlg, 'Tag', 'Warning');
h_time = findobj(h_dlg, 'Tag', 'text_time');
h_sVelocity = findobj(h_dlg, 'Tag', 'text_suggested_velocity');
h_lightPanel = findobj(h_dlg, 'Tag', 'lightPanel');
handles = [h_dlg h_Vehicle_velocity V2x_sign h_WarningBlock h_time h_sVelocity h_lightPanel];

set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');

%endfunction Start

function Outputs(block)
handles = get_param(block.BlockHandle, 'UserData');

h_Vehicle_velocity = handles(2);
V2x_sign = handles(3);
h_WarningBlock = handles(4);
h_time = handles(5);
h_sVelocity = handles(6);
h_lightPanel = handles(7);

set(h_Vehicle_velocity,'String',num2str(block.InputPort(1).Data));
set(h_time,'String',num2str(block.InputPort(3).Data));
set(h_sVelocity,'String',num2str(block.InputPort(4).Data));

% Warning
if block.InputPort(2).Data == 1
    BorderColor = [1 0 0];
else
    BorderColor = [0.5 0.5 0.5];
end
set(h_WarningBlock,'HighlightColor',BorderColor,'ShadowColor',BorderColor);

if block.InputPort(2).Data == 1
    BorderColor1 = [1 0 0];
    textColor1 = [1 0 0];
elseif block.InputPort(2).Data == 2
    BorderColor1 = [0.9 0.9 0];
    textColor1 = [0.9 0.9 0];
elseif block.InputPort(2).Data == 3
    BorderColor1 = [0 1 0];
    textColor1 = [0 1 0];
else
     BorderColor1 = [0.5 0.5 0.5];
     textColor1 = [0.9 0.9 0.9];
end
set(h_lightPanel,'HighlightColor',BorderColor1,'ShadowColor',BorderColor1);
set(h_time,'ForegroundColor',textColor1);


% Inputs

% Display lights
if block.InputPort(2).Data == 1
    if block.InputPort(5).Data == 0
        axes(V2x_sign);      % focus on slot SlotNum
        cla reset;
        [img, map, alpha] = imread('Pictures\J32','png');
        sizeAlpha = size(alpha);
        for i = 1 : sizeAlpha(1)
            for j = 1 : sizeAlpha(2)
                if alpha(i, j) == 0
                    img(i, j, 1: 3) = [240, 240, 240];
                end
            end
        end
        imshow(img);
        axis image
        block.OutputPort(1).data = 1;
        block.OutputPort(2).data = 0;
    end
else
    if block.InputPort(6).Data == 0
        axes(V2x_sign);     %#ok<*LAXES> % focus on slot
        set(V2x_sign, 'Visible', 'Off');
        cla;                    % remove the sign
        block.OutputPort(1).data = 0;
        block.OutputPort(2).data = 1;
    end
end
%endfunction Outputs
