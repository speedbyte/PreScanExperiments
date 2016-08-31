function msfcn_GLOSA_PlotSpeed(block)
setup(block);
%endfunction



function setup( block )


%% define number of input and output ports
block.NumInputPorts  = 25;
block.NumOutputPorts = 25;


%% port properties
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

%input
%BMW_X5_1
block.InputPort(1).Complexity = 'real'; % BMW_X5_1 GPS Noise
block.InputPort(1).DataTypeId = 0; %real
block.InputPort(1).SamplingMode = 'Sample';
block.InputPort(1).Dimensions = 1;

block.InputPort(2).Complexity = 'real'; % BMW_X5_1 MUR
block.InputPort(2).DataTypeId = 0; %real
block.InputPort(2).SamplingMode = 'Sample';
block.InputPort(2).Dimensions = 1;

block.InputPort(3).Complexity = 'real'; % BMW_X5_1 NOMM
block.InputPort(3).DataTypeId = 0; %real
block.InputPort(3).SamplingMode = 'Sample';
block.InputPort(3).Dimensions = 1;

block.InputPort(4).Complexity = 'real'; % BMW_X5_1 TD
block.InputPort(4).DataTypeId = 0; %real
block.InputPort(4).SamplingMode = 'Sample';
block.InputPort(4).Dimensions = 1;

%BMW_Z3_1
block.InputPort(5).Complexity = 'real'; % BMW_Z3_1 GPS Noise
block.InputPort(5).DataTypeId = 0; %real
block.InputPort(5).SamplingMode = 'Sample';
block.InputPort(5).Dimensions = 1;

block.InputPort(6).Complexity = 'real'; % BMW_Z3_1 MUR
block.InputPort(6).DataTypeId = 0; %real
block.InputPort(6).SamplingMode = 'Sample';
block.InputPort(6).Dimensions = 1;

block.InputPort(7).Complexity = 'real'; % BMW_Z3_1 NOMM
block.InputPort(7).DataTypeId = 0; %real
block.InputPort(7).SamplingMode = 'Sample';
block.InputPort(7).Dimensions = 1;

block.InputPort(8).Complexity = 'real'; % BMW_Z3_1 TD
block.InputPort(8).DataTypeId = 0; %real
block.InputPort(8).SamplingMode = 'Sample';
block.InputPort(8).Dimensions = 1;

%Toyota Yaris_1
block.InputPort(9).Complexity = 'real'; % Toyota Yaris_1 GPS Noise
block.InputPort(9).DataTypeId = 0; %real
block.InputPort(9).SamplingMode = 'Sample';
block.InputPort(9).Dimensions = 1;

block.InputPort(10).Complexity = 'real'; % Toyota Yaris_1 MUR
block.InputPort(10).DataTypeId = 0; %real
block.InputPort(10).SamplingMode = 'Sample';
block.InputPort(10).Dimensions = 1;

block.InputPort(11).Complexity = 'real'; % Toyota Yaris_1 NOMM
block.InputPort(11).DataTypeId = 0; %real
block.InputPort(11).SamplingMode = 'Sample';
block.InputPort(11).Dimensions = 1;

block.InputPort(12).Complexity = 'real'; % Toyota Yaris_1 TD
block.InputPort(12).DataTypeId = 0; %real
block.InputPort(12).SamplingMode = 'Sample';
block.InputPort(12).Dimensions = 1;

%Mazda RX8_1
block.InputPort(13).Complexity = 'real'; % Mazda RX8_1 GPS Noise
block.InputPort(13).DataTypeId = 0; %real
block.InputPort(13).SamplingMode = 'Sample';
block.InputPort(13).Dimensions = 1;

block.InputPort(14).Complexity = 'real'; % Mazda RX8_1 MUR
block.InputPort(14).DataTypeId = 0; %real
block.InputPort(14).SamplingMode = 'Sample';
block.InputPort(14).Dimensions = 1;

block.InputPort(15).Complexity = 'real'; % Mazda RX8_1 NOMM
block.InputPort(15).DataTypeId = 0; %real
block.InputPort(15).SamplingMode = 'Sample';
block.InputPort(15).Dimensions = 1;

block.InputPort(16).Complexity = 'real'; % Mazda RX8_1 TD
block.InputPort(16).DataTypeId = 0; %real
block.InputPort(16).SamplingMode = 'Sample';
block.InputPort(16).Dimensions = 1;

%Toyota Previa_1
block.InputPort(17).Complexity = 'real'; % Toyota Previa_1 GPS Noise
block.InputPort(17).DataTypeId = 0; %real
block.InputPort(17).SamplingMode = 'Sample';
block.InputPort(17).Dimensions = 1;

block.InputPort(18).Complexity = 'real'; % Toyota Previa_1 MUR
block.InputPort(18).DataTypeId = 0; %real
block.InputPort(18).SamplingMode = 'Sample';
block.InputPort(18).Dimensions = 1;

block.InputPort(19).Complexity = 'real'; % Toyota Previa_1 NOMM
block.InputPort(19).DataTypeId = 0; %real
block.InputPort(19).SamplingMode = 'Sample';
block.InputPort(19).Dimensions = 1;

block.InputPort(20).Complexity = 'real'; % Toyota Previa_1 TD
block.InputPort(20).DataTypeId = 0; %real
block.InputPort(20).SamplingMode = 'Sample';
block.InputPort(20).Dimensions = 1;

%Ford Fiesta_1
block.InputPort(21).Complexity = 'real'; % Ford Fiesta_1 GPS Noise
block.InputPort(21).DataTypeId = 0; %real
block.InputPort(21).SamplingMode = 'Sample';
block.InputPort(21).Dimensions = 1;

block.InputPort(22).Complexity = 'real'; % Ford Fiesta_1 MUR
block.InputPort(22).DataTypeId = 0; %real
block.InputPort(22).SamplingMode = 'Sample';
block.InputPort(22).Dimensions = 1;

block.InputPort(23).Complexity = 'real'; % Ford Fiesta_1 NOMM
block.InputPort(23).DataTypeId = 0; %real
block.InputPort(23).SamplingMode = 'Sample';
block.InputPort(23).Dimensions = 1;

block.InputPort(24).Complexity = 'real'; % Ford Fiesta_1 TD
block.InputPort(24).DataTypeId = 0; %real
block.InputPort(24).SamplingMode = 'Sample';
block.InputPort(24).Dimensions = 1;

%tmp
block.InputPort(25).Complexity = 'real'; % Ford Fiesta_1 MC
block.InputPort(25).DataTypeId = 0; %real
block.InputPort(25).SamplingMode = 'Sample';
block.InputPort(25).Dimensions = 1;

%output
%BMW_X5_1
block.OutputPort(1).Complexity = 'real'; % BMW_X5_1 GPS Noise
block.OutputPort(1).DataTypeId = 0; %real
block.OutputPort(1).SamplingMode = 'Sample';
%block.OutputPort(1).Dimensions = 1;

block.OutputPort(2).Complexity = 'real'; % BMW_X5_1 MUR
block.OutputPort(2).DataTypeId = 0; %real
block.OutputPort(2).SamplingMode = 'Sample';
%block.OutputPort(2).Dimensions = 1;

block.OutputPort(3).Complexity = 'real'; % BMW_X5_1 NOMM
block.OutputPort(3).DataTypeId = 0; %real
block.OutputPort(3).SamplingMode = 'Sample';
%block.OutputPort(3).Dimensions = 1;

block.OutputPort(4).Complexity = 'real'; % BMW_X5_1 TD
block.OutputPort(4).DataTypeId = 0; %real
block.OutputPort(4).SamplingMode = 'Sample';
%block.OutputPort(4).Dimensions = 1;

%BMW_Z3_1
block.OutputPort(5).Complexity = 'real'; % BMW_Z3_1 GPS Noise
block.OutputPort(5).DataTypeId = 0; %real
block.OutputPort(5).SamplingMode = 'Sample';
%block.OutputPort(5).Dimensions = 1;

block.OutputPort(6).Complexity = 'real'; % BMW_Z3_1 MUR
block.OutputPort(6).DataTypeId = 0; %real
block.OutputPort(6).SamplingMode = 'Sample';
%block.OutputPort(6).Dimensions = 1;

block.OutputPort(7).Complexity = 'real'; % BMW_Z3_1 NOMM
block.OutputPort(7).DataTypeId = 0; %real
block.OutputPort(7).SamplingMode = 'Sample';
%block.OutputPort(7).Dimensions = 1;

block.OutputPort(8).Complexity = 'real'; % BMW_Z3_1 TD
block.OutputPort(8).DataTypeId = 0; %real
block.OutputPort(8).SamplingMode = 'Sample';
%block.OutputPort(8).Dimensions = 1;

%Toyota Yaris_1
block.OutputPort(9).Complexity = 'real'; % Toyota Yaris_1 GPS Noise
block.OutputPort(9).DataTypeId = 0; %real
block.OutputPort(9).SamplingMode = 'Sample';
%block.OutputPort(9).Dimensions = 1;

block.OutputPort(10).Complexity = 'real'; % Toyota Yaris_1 MUR
block.OutputPort(10).DataTypeId = 0; %real
block.OutputPort(10).SamplingMode = 'Sample';
%block.OutputPort(10).Dimensions = 1;

block.OutputPort(11).Complexity = 'real'; % Toyota Yaris_1 NOMM
block.OutputPort(11).DataTypeId = 0; %real
block.OutputPort(11).SamplingMode = 'Sample';
%block.OutputPort(11).Dimensions = 1;

block.OutputPort(12).Complexity = 'real'; % Toyota Yaris_1 TD
block.OutputPort(12).DataTypeId = 0; %real
block.OutputPort(12).SamplingMode = 'Sample';
%block.OutputPort(12).Dimensions = 1;

%Mazda RX8_1
block.OutputPort(13).Complexity = 'real'; % Mazda RX8_1 GPS Noise
block.OutputPort(13).DataTypeId = 0; %real
block.OutputPort(13).SamplingMode = 'Sample';
%block.OutputPort(13).Dimensions = 1;

block.OutputPort(14).Complexity = 'real'; % Mazda RX8_1 MUR
block.OutputPort(14).DataTypeId = 0; %real
block.OutputPort(14).SamplingMode = 'Sample';
%block.OutputPort(14).Dimensions = 1;

block.OutputPort(15).Complexity = 'real'; % Mazda RX8_1 NOMM
block.OutputPort(15).DataTypeId = 0; %real
block.OutputPort(15).SamplingMode = 'Sample';
%block.OutputPort(15).Dimensions = 1;

block.OutputPort(16).Complexity = 'real'; % Mazda RX8_1 TD
block.OutputPort(16).DataTypeId = 0; %real
block.OutputPort(16).SamplingMode = 'Sample';
%block.OutputPort(16).Dimensions = 1;

%Toyota Previa_1
block.OutputPort(17).Complexity = 'real'; % Toyota Previa_1 GPS Noise
block.OutputPort(17).DataTypeId = 0; %real
block.OutputPort(17).SamplingMode = 'Sample';
%block.OutputPort(17).Dimensions = 1;

block.OutputPort(18).Complexity = 'real'; % Toyota Previa_1 MUR
block.OutputPort(18).DataTypeId = 0; %real
block.OutputPort(18).SamplingMode = 'Sample';
%block.OutputPort(18).Dimensions = 1;

block.OutputPort(19).Complexity = 'real'; % Toyota Previa_1 NOMM
block.OutputPort(19).DataTypeId = 0; %real
block.OutputPort(19).SamplingMode = 'Sample';
%block.OutputPort(19).Dimensions = 1;

block.OutputPort(20).Complexity = 'real'; % Toyota Previa_1 TD
block.OutputPort(20).DataTypeId = 0; %real
block.OutputPort(20).SamplingMode = 'Sample';
%block.OutputPort(20).Dimensions = 1;

%Ford Fiesta_1
block.OutputPort(21).Complexity = 'real'; % Ford Fiesta_1 GPS Noise
block.OutputPort(21).DataTypeId = 0; %real
block.OutputPort(21).SamplingMode = 'Sample';
%block.OutputPort(21).Dimensions = 1;

block.OutputPort(22).Complexity = 'real'; % Ford Fiesta_1 MUR
block.OutputPort(22).DataTypeId = 0; %real
block.OutputPort(22).SamplingMode = 'Sample';
%block.OutputPort(22).Dimensions = 1;

block.OutputPort(23).Complexity = 'real'; % Ford Fiesta_1 NOMM
block.OutputPort(23).DataTypeId = 0; %real
block.OutputPort(23).SamplingMode = 'Sample';
%block.OutputPort(23).Dimensions = 1;

block.OutputPort(24).Complexity = 'real'; % Ford Fiesta_1 TD
block.OutputPort(24).DataTypeId = 0; %real
block.OutputPort(24).SamplingMode = 'Sample';
%block.OutputPort(24).Dimensions = 1;

%tmp
block.OutputPort(25).Complexity = 'real'; % Ford Fiesta_1 MC
block.OutputPort(25).DataTypeId = 0; %real
block.OutputPort(25).SamplingMode = 'Sample';
%block.OutputPort(25).Dimensions = 1;


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
    close (GLOSA_PlotSpeed)
end
h_dlg = GLOSA_PlotSpeed;
h_GPS_Noise = findobj(h_dlg, 'Tag', 'GPS_Noise_out');
h_MUR_out = findobj(h_dlg, 'Tag', 'MUR_out');
h_Nomm_out = findobj(h_dlg, 'Tag', 'Nomm_out');
h_Td_out = findobj(h_dlg, 'Tag', 'Td_out');
h_BMW_X5 = findobj(h_dlg, 'Tag', 'BMW_X5');
h_BMW_Z3 = findobj(h_dlg, 'Tag', 'BMW_Z3');
h_Toyota_Yaris = findobj(h_dlg, 'Tag', 'Toyota_Yaris');
h_Mazda_RX8 = findobj(h_dlg, 'Tag', 'Mazda_RX8');
h_Toyota_Previa = findobj(h_dlg, 'Tag', 'Toyota_Previa');
h_Ford_Fiesta = findobj(h_dlg, 'Tag', 'Ford_Fiesta');
handles = [h_dlg h_GPS_Noise h_MUR_out h_Nomm_out h_Td_out h_BMW_X5 h_BMW_Z3 h_Toyota_Yaris h_Mazda_RX8 h_Toyota_Previa h_Ford_Fiesta];
set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');
%endfunction Start
        
function Outputs(block)
	handles = get_param(block.BlockHandle, 'UserData');
	
    h_GPS_Noise = handles(2);
    h_MUR_out = handles(3);
    h_Nomm_out = handles(4);
    h_Td_out = handles(5);
    h_BMW_X5 = handles(6);
    h_BMW_Z3 = handles(7);
    h_Toyota_Yaris = handles(8);
    h_Mazda_RX8 = handles(9);
    h_Toyota_Previa = handles(10);
    h_Ford_Fiesta = handles(11);
    tmp = block.InputPort(25).Data;
    i =0;
    if (get(h_BMW_X5,'Value') == 1)
        i = 0;
        if (tmp ~=1)
            set(h_GPS_Noise,'Value', block.InputPort(i+1).Data);
            set(h_MUR_out,'Value', block.InputPort(i+2).Data)
            set(h_Nomm_out,'Value', block.InputPort(i+3).Data)
            set(h_Td_out,'Value', block.InputPort(i+4).Data)
            tmp = 1;
        end
    elseif (get(h_BMW_Z3,'Value') == 1)
        i = 4;
        if (tmp ~=2)
            set(h_GPS_Noise,'Value', block.InputPort(i+1).Data);
            set(h_MUR_out,'Value', block.InputPort(i+2).Data)
            set(h_Nomm_out,'Value', block.InputPort(i+3).Data)
            set(h_Td_out,'Value', block.InputPort(i+4).Data)
            tmp = 2;
        end
    elseif (get(h_Toyota_Yaris,'Value') == 1)
        i = 8;
        if (tmp ~=3)
            set(h_GPS_Noise,'Value', block.InputPort(i+1).Data);
            set(h_MUR_out,'Value', block.InputPort(i+2).Data)
            set(h_Nomm_out,'Value', block.InputPort(i+3).Data)
            set(h_Td_out,'Value', block.InputPort(i+4).Data)
            tmp = 3;
        end
    elseif (get(h_Mazda_RX8,'Value') == 1)
        i = 12;
        if (tmp ~=4)
            set(h_GPS_Noise,'Value', block.InputPort(i+1).Data);
            set(h_MUR_out,'Value', block.InputPort(i+2).Data)
            set(h_Nomm_out,'Value', block.InputPort(i+3).Data)
            set(h_Td_out,'Value', block.InputPort(i+4).Data)
            tmp = 4;
        end
    elseif (get(h_Toyota_Previa,'Value') == 1)
        i = 16;
        if (tmp ~=5)
            set(h_GPS_Noise,'Value', block.InputPort(i+1).Data);
            set(h_MUR_out,'Value', block.InputPort(i+2).Data)
            set(h_Nomm_out,'Value', block.InputPort(i+3).Data)
            set(h_Td_out,'Value', block.InputPort(i+4).Data)
            tmp = 5;
        end
    elseif (get(h_Ford_Fiesta,'Value') == 1)
        i = 20;
        if (tmp ~=6)
            set(h_GPS_Noise,'Value', block.InputPort(i+1).Data);
            set(h_MUR_out,'Value', block.InputPort(i+2).Data)
            set(h_Nomm_out,'Value', block.InputPort(i+3).Data)
            set(h_Td_out,'Value', block.InputPort(i+4).Data)
            tmp = 6;
        end
    end
    
    block.OutputPort(1).Data = block.InputPort(1).Data;
    block.OutputPort(2).Data = block.InputPort(2).Data;
    block.OutputPort(3).Data = block.InputPort(3).Data;
    block.OutputPort(4).Data = block.InputPort(4).Data;
    block.OutputPort(5).Data = block.InputPort(5).Data;
    block.OutputPort(6).Data = block.InputPort(6).Data;
    block.OutputPort(7).Data = block.InputPort(7).Data;
    block.OutputPort(8).Data = block.InputPort(8).Data;
    block.OutputPort(9).Data = block.InputPort(9).Data;
    block.OutputPort(10).Data = block.InputPort(10).Data;
    block.OutputPort(11).Data = block.InputPort(11).Data;
    block.OutputPort(12).Data = block.InputPort(12).Data;
    block.OutputPort(13).Data = block.InputPort(13).Data;
    block.OutputPort(14).Data = block.InputPort(14).Data;
    block.OutputPort(15).Data = block.InputPort(15).Data;
    block.OutputPort(16).Data = block.InputPort(16).Data;
    block.OutputPort(17).Data = block.InputPort(17).Data;
    block.OutputPort(18).Data = block.InputPort(18).Data;
    block.OutputPort(19).Data = block.InputPort(19).Data;
    block.OutputPort(20).Data = block.InputPort(20).Data;
    block.OutputPort(21).Data = block.InputPort(21).Data;
    block.OutputPort(22).Data = block.InputPort(22).Data;
    block.OutputPort(23).Data = block.InputPort(23).Data;
    block.OutputPort(24).Data = block.InputPort(24).Data;

    block.OutputPort(25).Data = tmp;

    block.OutputPort(i+1).Data = get(h_GPS_Noise,'Value');
    block.OutputPort(i+2).Data = get(h_MUR_out,'Value');
    block.OutputPort(i+3).Data = get(h_Nomm_out,'Value');
    block.OutputPort(i+4).Data = get(h_Td_out,'Value');
    
%% Remove outdated displays


%endfunction Outputs
