function msfcn_V2X_PlotSpeed(block)
setup(block);
%endfunction



function setup( block )


%% define number of input and output ports
block.NumInputPorts  = 0;
block.NumOutputPorts = 4;


%% port properties
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.OutputPort(1).Complexity = 'real'; % GPS Noise output
block.OutputPort(1).DataTypeId = 0; %real
block.OutputPort(1).SamplingMode = 'Sample';
%block.OutputPort(1).Dimensions   = 1;

block.OutputPort(2).Complexity = 'real'; % Message Update Rate out
block.OutputPort(2).DataTypeId = 0; %real
block.OutputPort(2).SamplingMode = 'Sample';
%block.OutputPort(2).Dimensions   = 1;

block.OutputPort(3).Complexity = 'real'; % No. of missed messages out
block.OutputPort(3).DataTypeId = 0; %real
block.OutputPort(3).SamplingMode = 'Sample';
%block.OutputPort(3).Dimensions   = 1;

block.OutputPort(4).Complexity = 'real'; % Transmission delay
block.OutputPort(4).DataTypeId = 0; %real
block.OutputPort(4).SamplingMode = 'Sample';
%block.OutputPort(4).Dimensions   = 1;



%% Register parameters
dfreq = 100;

%% block sample time
block.SampleTimes = [1/dfreq 0];

%% register methods
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);

%% Block runs on TLC in accelerator mode.
block.SetAccelRunOnTLC(true);
%endfunction

function Start(block)

try%#ok<TRYNC>
    close (V2X_PlotSpeed)
end
h_dlg = V2X_PlotSpeed;
h_GPS_Noise = findobj(h_dlg, 'Tag', 'GPS_Noise_out');
h_MUR_out = findobj(h_dlg, 'Tag', 'MUR_out');
h_Nomm_out = findobj(h_dlg, 'Tag', 'Nomm_out');
h_Td_out = findobj(h_dlg, 'Tag', 'Td_out');
handles = [h_dlg h_GPS_Noise h_MUR_out h_Nomm_out h_Td_out];
set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');
%endfunction Start
        
function Outputs(block)
    handles = get_param(block.BlockHandle, 'UserData');
    h_GPS_Noise = handles(2);
    h_MUR_out = handles(3);
    h_Nomm_out = handles(4);
    h_Td_out = handles(5);

    block.OutputPort(1).Data = get(h_GPS_Noise,'Value');
    block.OutputPort(2).Data = get(h_MUR_out,'Value');
    block.OutputPort(3).Data = get(h_Nomm_out,'Value');
    block.OutputPort(4).Data = get(h_Td_out,'Value');
  
    
%% Remove outdated displays


%endfunction Outputs
