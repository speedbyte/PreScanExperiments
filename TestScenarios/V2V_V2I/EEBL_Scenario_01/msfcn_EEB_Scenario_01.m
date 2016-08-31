function msfcn_EEB_Scenario_01(block)
setup(block);
%endfunction



function setup( block )


%% define number of input and output ports
block.NumInputPorts  = 0;
block.NumOutputPorts = 1;


%% port properties
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.OutputPort(1).Complexity = 'real'; % GPS Noise output
block.OutputPort(1).DataTypeId = 0; %real
block.OutputPort(1).SamplingMode = 'Sample';
%block.OutputPort(1).Dimensions   = 1;



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

try
    close (EEB_Scenario_01)
end
h_dlg = EEB_Scenario_01;
h_deceleration = findobj(h_dlg, 'Tag', 'deceleration');
handles = [h_dlg h_deceleration];
set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');

%endfunction Start
        
function Outputs(block)
	handles = get_param(block.BlockHandle, 'UserData');
    h_deceleration = handles(2);
    block.OutputPort(1).Data = get(h_deceleration,'Value');

    
%% Remove outdated displays


%endfunction Outputs
