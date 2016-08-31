function msfcn_V2x_TC_GUI(block)
setup(block);
%endfunction



function setup( block )


%% define number of input and output ports
block.NumInputPorts  = 8;
block.NumOutputPorts = 1;


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

block.InputPort(5).Complexity = 'real'; % data
block.InputPort(5).DataTypeId = 0;
block.InputPort(5).SamplingMode = 'Sample';

block.InputPort(6).Complexity = 'real'; % change
block.InputPort(6).DataTypeId = 0;
block.InputPort(6).SamplingMode = 'Sample';

block.InputPort(7).Complexity = 'real'; % warning
block.InputPort(7).DataTypeId = 0;
block.InputPort(7).SamplingMode = 'Sample';

block.InputPort(8).Complexity = 'real'; % last sign time3
block.InputPort(8).DataTypeId = 0;
block.InputPort(8).SamplingMode = 'Sample';
block.InputPort(8).Dimensions = 1;

block.OutputPort(1).Complexity = 'real'; % last sign flag
block.OutputPort(1).DataTypeId = 0;
%block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).SamplingMode = 'Sample';

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
h_WarningBlock = findobj(h_dlg, 'Tag', 'Warning');
handles = [h_dlg h_Vehicle_velocity h_Engine_velocity h_Brake h_Throttle V2x_sign h_WarningBlock];
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

set(h_Engine_velocity,'String',num2str(block.InputPort(1).Data));
set(h_Vehicle_velocity,'String',num2str(block.InputPort(2).Data));
set(h_Brake,'String',num2str(block.InputPort(3).Data));
set(h_Throttle,'String',num2str(block.InputPort(4).Data));

if logical(block.InputPort(7).Data)
    BorderColor = [1 0 0];
else
    BorderColor = [0.5 0.5 0.5];
end
set(h_WarningBlock,'HighlightColor',BorderColor,'ShadowColor',BorderColor);

% Inputs
message  = block.InputPort(5).Data;
change   = block.InputPort(6).Data;

% Display
if change
    switch message
        case 0  % clear
            if block.InputPort(8).data ~= 0;
                axes(V2x_sign);     %#ok<*LAXES> % focus on slot
                set(V2x_sign, 'Visible', 'Off');
                cla;                    % remove the sign
                block.OutputPort(1).Data = 0;
            end
        case 901
            if block.InputPort(8).data ~= 901;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\F8','png');
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
                block.OutputPort(1).Data = 901;
            end
        case 902
            if block.InputPort(8).data ~= 902;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\J3','png');
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
                block.OutputPort(1).Data = 902;
            end
        case 903
            if block.InputPort(8).data ~= 903;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\C1','png');
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
                block.OutputPort(1).Data = 903;
            end
        case 904
            if block.InputPort(8).data ~= 904;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\J2','png');
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
                block.OutputPort(1).Data = 904;
            end
        case 905
            if block.InputPort(8).data ~= 905;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\J8','png');
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
                block.OutputPort(1).Data = 905;
            end
        case 1050
            if block.InputPort(8).data ~= 1050;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\A01050','png');
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
                block.OutputPort(1).Data = 1050;
            end
        case 1080
            if block.InputPort(8).data ~= 1080;
                axes(V2x_sign);      % focus on slot SlotNum
                cla reset;
                [img, map, alpha] = imread('Models\A01080','png');
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
                block.OutputPort(1).Data = 1080;
            end
    end
end
%endfunction Outputs
