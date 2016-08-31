function msfcn_V2x_TC_GUI(block)
setup(block);
%endfunction



function setup( block )


%% define number of input and output ports
block.NumInputPorts  = 14;
block.NumOutputPorts = 6;


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
block.InputPort(3).Dimensions = 1;

block.InputPort(4).Complexity = 'real'; % Throttle
block.InputPort(4).DataTypeId = 0; %real
block.InputPort(4).SamplingMode = 'Sample';
block.InputPort(4).Dimensions = 1;

block.InputPort(5).Complexity = 'real'; % data
block.InputPort(5).DataTypeId = 0;
block.InputPort(5).SamplingMode = 'Sample';
block.InputPort(5).Dimensions = 1;

block.InputPort(6).Complexity = 'real'; % change
block.InputPort(6).DataTypeId = 0;
block.InputPort(6).SamplingMode = 'Sample';
block.InputPort(6).Dimensions = 1;

block.InputPort(7).Complexity = 'real'; % warning
block.InputPort(7).DataTypeId = 0;
block.InputPort(7).SamplingMode = 'Sample';
block.InputPort(7).Dimensions = 1;

block.InputPort(8).Complexity = 'real'; % last sign flag input
%block.InputPort(8).DataTypeId = 0;
block.InputPort(8).SamplingMode = 'Sample';
%block.InputPort(8).Dimensions = 1;

block.InputPort(9).Complexity = 'real'; % time
block.InputPort(9).DataTypeId = 0;
block.InputPort(9).SamplingMode = 'Sample';
block.InputPort(9).Dimensions = 1;

block.InputPort(10).Complexity = 'real'; % last sign time1
block.InputPort(10).DataTypeId = 0;
block.InputPort(10).SamplingMode = 'Sample';
block.InputPort(10).Dimensions = 1;

block.InputPort(11).Complexity = 'real'; % last sign time2
block.InputPort(11).DataTypeId = 0;
block.InputPort(11).SamplingMode = 'Sample';
block.InputPort(11).Dimensions = 1;

block.InputPort(12).Complexity = 'real'; % last sign time3
block.InputPort(12).DataTypeId = 0;
block.InputPort(12).SamplingMode = 'Sample';
block.InputPort(12).Dimensions = 1;

block.InputPort(13).Complexity = 'real'; % last sign flag input2
%block.InputPort(13).DataTypeId = 0;
block.InputPort(13).SamplingMode = 'Sample';
%block.InputPort(13).Dimensions = 1;

block.InputPort(14).Complexity = 'real'; % last sign flag input3
%block.InputPort(14).DataTypeId = 0;
block.InputPort(14).SamplingMode = 'Sample';
%block.InputPort(14).Dimensions = 1;

block.OutputPort(1).Complexity = 'real'; % last sign flag
block.OutputPort(1).DataTypeId = 0;
%block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).SamplingMode = 'Sample';

block.OutputPort(2).Complexity = 'real'; % last time out1
block.OutputPort(2).DataTypeId = 0;
%block.OutputPort(2).Dimensions = 1;
block.OutputPort(2).SamplingMode = 'Sample';

block.OutputPort(3).Complexity = 'real'; % last time out2
block.OutputPort(3).DataTypeId = 0;
%block.OutputPort(3).Dimensions = 1;
block.OutputPort(3).SamplingMode = 'Sample';

block.OutputPort(4).Complexity = 'real'; % last time out3
block.OutputPort(4).DataTypeId = 0;
%block.OutputPort(4).Dimensions = 1;
block.OutputPort(4).SamplingMode = 'Sample';

block.OutputPort(5).Complexity = 'real'; % last sign flag2
block.OutputPort(5).DataTypeId = 0;
%block.OutputPort(5).Dimensions = 1;
block.OutputPort(5).SamplingMode = 'Sample';

block.OutputPort(6).Complexity = 'real'; % last sign flag3
block.OutputPort(6).DataTypeId = 0;
%block.OutputPort(6).Dimensions = 1;
block.OutputPort(6).SamplingMode = 'Sample';


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
    close (V2x_TC_GUI)
end
h_dlg = V2x_TC_GUI;
%h_Velocity_image = findobj(h_dlg, 'Tag', 'Speed_image');
h_Vehicle_velocity = findobj(h_dlg, 'Tag', 'text_Vehicle_speed');
h_Engine_velocity = findobj(h_dlg, 'Tag', 'text_Engine_speed');
h_Brake = findobj(h_dlg, 'Tag', 'text_Brake');
h_Throttle = findobj(h_dlg, 'Tag', 'text_Throttle');
V2x_sign = findobj(h_dlg, 'Tag', 'V2x_sign');
V2x_sign2 = findobj(h_dlg, 'Tag', 'V2x_sign2');
V2x_sign3 = findobj(h_dlg, 'Tag', 'V2x_sign3');
h_WarningBlock = findobj(h_dlg, 'Tag', 'Warning');
handles = [h_dlg h_Vehicle_velocity h_Engine_velocity h_Brake h_Throttle V2x_sign h_WarningBlock V2x_sign2 V2x_sign3];
set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');

%endfunction Start

function Outputs(block)
handles = get_param(block.BlockHandle, 'UserData');

h_Engine_velocity = handles(3);
h_Vehicle_velocity = handles(2);
h_Brake = handles(4);
h_Throttle = handles(5);
V2x_sign = handles(6);
h_WarningBlock = handles(7);
V2x_sign2 = handles(8);
V2x_sign3 = handles(9);

set(h_Engine_velocity,'String',num2str(block.InputPort(1).Data));
set(h_Vehicle_velocity,'String',num2str(block.InputPort(2).Data));
set(h_Brake,'String',num2str(block.InputPort(3).Data));
set(h_Throttle,'String',num2str(block.InputPort(4).Data));

if any(logical(block.InputPort(7).Data))
    BorderColor = [1 0 0];
else
    BorderColor = [0.5 0.5 0.5];
end
set(h_WarningBlock,'HighlightColor',BorderColor,'ShadowColor',BorderColor, 'ForegroundColor', BorderColor);

% Inputs
warning  = block.InputPort(7).Data;
change   = block.InputPort(6).Data;
message   = block.InputPort(5).Data;
time   = block.InputPort(9).Data;
last_time1   = block.InputPort(10).Data;
last_time2   = block.InputPort(11).Data;
last_time3   = block.InputPort(12).Data;

if message == 1060
    if block.InputPort(8).data == 0;
        axes(V2x_sign3);      % focus on slot SlotNum
        cla reset;
        [img, map, alpha] = imread('Models\A01060','png');
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
        block.OutputPort(2).data = time;
    end
elseif time - last_time1 <=5
else
    axes(V2x_sign3);     %#ok<*LAXES> % focus on slot
    set(V2x_sign3, 'Visible', 'Off');
    cla;                    % remove the sign
    block.OutputPort(1).Data = 0;
end

if message == 2
    if block.InputPort(13).data == 0;
        axes(V2x_sign);      % focus on slot SlotNum
        cla reset;
        [img, map, alpha] = imread('Models\z123','png');
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
        block.OutputPort(5).data = 1;
        block.OutputPort(3).data = time;
    end
elseif time - last_time2 <=5
else
    axes(V2x_sign);     %#ok<*LAXES> % focus on slot
    set(V2x_sign, 'Visible', 'Off');
    cla;                    % remove the sign
    block.OutputPort(5).Data = 0;
end

if message == 1
    if block.InputPort(14).data == 0;
        axes(V2x_sign2);      % focus on slot SlotNum
        cla reset;
        [img, map, alpha] = imread('Models\z531-20','png');
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
        block.OutputPort(6).data = 1;
        block.OutputPort(4).data = time;
    end
elseif time - last_time3 <=5
else
    axes(V2x_sign2);     %#ok<*LAXES> % focus on slot
    set(V2x_sign2, 'Visible', 'Off');
    cla;                    % remove the sign
    block.OutputPort(6).Data = 0;
end
%endfunction Outputs

