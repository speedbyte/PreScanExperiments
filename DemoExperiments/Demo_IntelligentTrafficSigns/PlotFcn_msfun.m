function PlotFcn_msfun(block)
% Level-2 M file S-Function for system identification using
% Least Mean Squares (LMS).
%   Copyright 1990-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $

setup(block);
%endfunction

function setup(block)

%% Register dialog parameter: LMS step size
block.NumDialogPrms = 10;
block.DialogPrmsTunable = {'Tunable','Tunable','Tunable','Tunable','Tunable','Tunable','Tunable','Tunable','Tunable','Tunable'};

%% Regieste number of input and output ports
block.NumInputPorts  = 6;
block.NumOutputPorts = 0;

%% Setup functional port properties to dynamically
%% inherited.
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.InputPort(1).Complexity   = 'Real'; % x-value
block.InputPort(1).DataTypeId   = 0;
block.InputPort(1).SamplingMode = 'Sample';

block.InputPort(2).Complexity   = 'Real'; % y-value
block.InputPort(2).DataTypeId   = 0;
block.InputPort(2).SamplingMode = 'Sample';

block.InputPort(3).Complexity   = 'Real'; % Alert-ID
block.InputPort(3).DataTypeId   = 0;
block.InputPort(3).SamplingMode = 'Sample';

block.InputPort(4).Complexity   = 'Real'; % Intervene SPEED
block.InputPort(4).DataTypeId   = 0;
block.InputPort(4).SamplingMode = 'Sample';

block.InputPort(5).Complexity   = 'Real'; % Actual SPEED
block.InputPort(5).DataTypeId   = 0;
block.InputPort(5).SamplingMode = 'Sample';

block.InputPort(6).Complexity   = 'Real'; % Advise SPEED
block.InputPort(6).DataTypeId   = 0;
block.InputPort(6).SamplingMode = 'Sample';

%block.SampleTimes = [-1 0];
%block.SampleTimes = [1/20 0];
block.SampleTimes = [1/block.DialogPrm(9).Data 0];

%% Register methods
block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
block.RegBlockMethod('Start',                   @Start);
block.RegBlockMethod('Outputs',                 @Outputs);

%% Block runs on TLC in accelerator mode.
block.SetAccelRunOnTLC(false)
%endfunction

function DoPostPropSetup(block)
block.NumDworks             = 2;

block.Dwork(1).Name         = 'counter';
block.Dwork(1).Dimensions   = 1;
block.Dwork(1).DatatypeID   = 0;
block.Dwork(1).Complexity   = 'Real';

block.Dwork(2).Name         = 'picdim';
block.Dwork(2).Dimensions   = 2;
block.Dwork(2).DatatypeID   = 0;
block.Dwork(2).Complexity   = 'Real';
%endfunction


function Start(block)
if strcmp(get_param(block.DialogPrm(10).Data,'FigureVisibility'), 'on')

   % hFig = str2double(get_param(block.DialogPrm(10).Data,'FigureHandle'));
    try
        close Display_IntelligentTrafficSigns
    end
    h_Fig=figure(Display_IntelligentTrafficSigns);
    h_Topview=findobj(h_Fig,'Tag','axes_Topview');
    h_TrafficSign=findobj(h_Fig,'Tag','axes_TrafficSign');
    h_SafeCurvatureSpeed=findobj(h_Fig,'Tag','text_Advise_Speed');
    h_SpeedLimit=findobj(h_Fig,'Tag','text_Allowed_Speed');
    h_ActualSpeed=findobj(h_Fig,'Tag','text_Actual_Speed');
    
    handles = [h_Fig h_Topview h_TrafficSign h_SafeCurvatureSpeed h_SpeedLimit h_ActualSpeed];
    set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');
    block.Dwork(1).Data = 0;
    
    h_Fig_xpos=0;
    h_Fig_ypos=0;
    set(h_Fig,'Position',[h_Fig_xpos h_Fig_ypos 124.4 41.846])
    
    CDAT=imread(eval(block.DialogPrm(7).Data)); %load BackgroundFile
    block.Dwork(2).Data=[size(CDAT,2) size(CDAT,1)];
    
    
    ClearFigure = get_param(block.DialogPrm(10).Data, 'ClearFigure');
    %if strcmp(ClearFigure,'on')
        %cla reset
        image(CDAT,'Parent',h_Topview);
    %end

    set(h_Fig,'CurrentAxes',h_Topview);
    hold on, xlabel('x'), ylabel('y'), grid on
    axis('off'), axis equal
 
    if strcmp(get_param(block.DialogPrm(10).Data,'SaveResults'), 'on')
        %create directory for output
        dirout = sprintf('Results/Results_%04.0f%02.0f%02.0f_%02.0f%02.0f%02.0f',clock);
        mkdir(dirout);
        set_param(block.DialogPrm(10).Data,'TempOutputDir',dirout);%%%%
    end

    set(h_Fig,'CurrentAxes',h_TrafficSign);
    axis off; axis equal

end
%endfunction Start

function Outputs(block)
if strcmp(get_param(block.DialogPrm(10).Data,'FigureVisibility'), 'on')
    handles     = get_param(block.BlockHandle,'UserData');
    h_Fig= handles(1);
    h_Topview = handles(2);
    h_TrafficSign = handles(3);
    h_SafeCurvatureSpeed = handles(4);
    h_SpeedLimit = handles(5);
    h_ActualSpeed = handles(6); 
    
    Alert_ID=block.InputPort(3).Data;
    %Intervene_v=block.InputPort(4).Data;
    
    if block.InputPort(5).Data>1.01*block.InputPort(4).Data %actual speed > max speed
        BorderColor=[1 0 0];
    elseif block.InputPort(5).Data>1.01*block.InputPort(6).Data %actual speed > advise speed
        BorderColor=[1 0.5 0];
    elseif block.InputPort(5).Data<0.99*block.InputPort(6).Data %actual speed < max speed
        BorderColor=[0 1 0];
    else
        BorderColor=[0 0 0];
    end

    set(h_SpeedLimit,'String',num2str(block.InputPort(4).Data));
    set(h_ActualSpeed,'String',num2str(block.InputPort(5).Data),'ForegroundColor',BorderColor);
    if block.InputPort(6).Data==999
        set(h_SafeCurvatureSpeed,'String','--');    
    else
        set(h_SafeCurvatureSpeed,'String',num2str(block.InputPort(6).Data));    
    end

    
    if Alert_ID==6 || Alert_ID==20 || Alert_ID==33  
        TrafficSign='TS_50';
    elseif Alert_ID== 7 || Alert_ID== 34  || Alert_ID== 38
        TrafficSign='TS_80';
    elseif Alert_ID== 23 || Alert_ID== 29 || Alert_ID== 30 || Alert_ID== 32 
        TrafficSign='TS_CurveWarningLeft';
    elseif Alert_ID== 24 || Alert_ID== 26 || Alert_ID== 27 ||  Alert_ID== 31
        TrafficSign='TS_CurveWarningRight';
    elseif Alert_ID== 8 || Alert_ID== 25
        TrafficSign='TS_EndRestrictions';
    elseif Alert_ID== 22
        TrafficSign='TS_noEntry';
    elseif Alert_ID==111 || Alert_ID==112 || Alert_ID== 19
        TrafficSign='TS_Crossing';
    else
        TrafficSign='TS_None';
    end
    image(imread(['Pictures/',TrafficSign,'.png']),'Parent',h_TrafficSign);
    axis off; axis equal;

    
    Marker=[eval(block.DialogPrm(5).Data),eval(block.DialogPrm(6).Data)]; %Marker=[MarkerColor,MarkerType]
    
    AxisLim=block.DialogPrm(1).Data; % xmin=AxisLim(1); xmax=AxisLim(2); ymin=AxisLim(3); ymax=AxisLim(4);
    % block.Dwork(3).Data(1); % # of pixels in x-direction (horizontal)
    % block.Dwork(3).Data(2); % # of pixels in y-direction (vertical)
    
    xScalingFac=(block.Dwork(2).Data(1))/(AxisLim(2)-AxisLim(1)); % scales plotdata to picture in x-direction (horizontal)
    yScalingFac=(block.Dwork(2).Data(2))/(AxisLim(4)-AxisLim(3)); % scales plotdata to picture in y-direction (vertical)
    
    x0=(0-AxisLim(1))*xScalingFac;
    y0=(0-AxisLim(3))*yScalingFac;
    %plot to picture scaled data
    plot(h_Topview,x0+block.InputPort(1).Data*xScalingFac,block.Dwork(2).Data(2)-(y0+block.InputPort(2).Data*yScalingFac),Marker)
    
    if strcmp(get_param(block.DialogPrm(10).Data,'SaveResults'), 'on')
        
        frame = getframe(h_Fig);
        dirout = get_param(block.DialogPrm(10).Data,'TempOutputDir');
        outfile = sprintf('%s/%s_%05.0f.png',dirout,get_param(block.DialogPrm(10).Data,'name'),block.Dwork(1).Data);
        imwrite(frame.cdata, outfile);
        
        block.Dwork(1).Data = block.Dwork(1).Data + 1;
    end
end
%endfunction Outputs
