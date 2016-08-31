function msfcn_AEBS_radar_graph(block)

setup(block);
end
%endfunction

function setup( block)

%% define number of input and output ports
block.NumInputPorts  = 7;
block.NumOutputPorts = 0;
% block.NumOutputPorts = 3;

block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

%% Register parameters
block.NumDialogPrms = 5;
dfreq       = block.DialogPrm(1).Data;
TISdet      = block.DialogPrm(2).Data;
%TISMaxRange = block.DialogPrm(3).Data;
%TISMaxTheta = block.DialogPrm(4).Data;

%% Input ports properties
block.InputPort(1).Complexity = 'real'; % TIS1 Range
block.InputPort(1).DataTypeId = 0; %real
block.InputPort(1).SamplingMode = 'Sample';
block.InputPort(1).Dimensions = TISdet(1);

block.InputPort(2).Complexity = 'real'; % TIS1 Theta
block.InputPort(2).DataTypeId = 0; %real
block.InputPort(2).SamplingMode = 'Sample';
block.InputPort(2).Dimensions = TISdet(1);

block.InputPort(3).Complexity = 'real'; % TIS2 Range
block.InputPort(3).DataTypeId = 0; %real
block.InputPort(3).SamplingMode = 'Sample';
block.InputPort(3).Dimensions = TISdet(2);

block.InputPort(4).Complexity = 'real'; % TIS2 Theta
block.InputPort(4).DataTypeId = 0; %real
block.InputPort(4).SamplingMode = 'Sample';
block.InputPort(4).Dimensions = TISdet(2);

block.InputPort(5).Complexity = 'real'; % all flags 1.6
block.InputPort(5).DataTypeId = 0; %real
block.InputPort(5).SamplingMode = 'Sample';
block.InputPort(5).Dimensions = TISdet(1);

block.InputPort(6).Complexity = 'real'; % all flags 2.6
block.InputPort(6).DataTypeId = 0; %real
block.InputPort(6).SamplingMode = 'Sample';
block.InputPort(6).Dimensions = TISdet(1);

block.InputPort(7).Complexity = 'real'; % all flags 0.6
block.InputPort(7).DataTypeId = 0; %real
block.InputPort(7).SamplingMode = 'Sample';
block.InputPort(7).Dimensions = TISdet(2);

%% block sample time
block.SampleTimes = [1/dfreq 0];

%% register methods
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);

%% Block runs on TLC in accelerator mode.
block.SetAccelRunOnTLC(true);

end
%endfunction

function Start(block)

if block.DialogPrm(5).Data      % Radar Switch ON / OFF
    
    try %#ok<TRYNC>
        close (AEBS_radar_graph)
    end
    
    % Params
    TISMaxRange = block.DialogPrm(3).Data;
    TISMaxTheta = block.DialogPrm(4).Data;
    TISMaxTheta = pi/180 * TISMaxTheta;
    
    % Useful handles
    h_Rdlg = AEBS_radar_graph;
    set(h_Rdlg, 'Name', 'AEBS Radar');
    h_axes = findobj(h_Rdlg, 'Tag', 'radar_axes');
    
    % Auxiliary variables for resizing
    scale = 0.65;
    kx = 423/70*scale;    % horizontally, meters per pixel
    ky = 308/51*scale;    % vertically,   meters per pixel
    hleg = 60;            % pixels for legend
    
    maxX = max(TISMaxRange .* sin(TISMaxTheta/2))+ 8;  % Max horizontal distance in meters plus some offset
    maxY = max(TISMaxRange .* cos(TISMaxTheta/2))+12;  % Max vertical distance in meters plus some offset 
    
    % Set window size
    set(h_Rdlg,'Units','Pixels');           % make sure pixels are used as units
    position = get(h_Rdlg, 'Position');     % get old settings
    position(3) = 2*maxX*kx;                % set width (horizontally)
    position(4) =   maxY*ky;           % set width (vertically)
    set(h_Rdlg,'Position',position + [0 0 0 hleg]);        % update
    
    % Set plot size
    plot_position = get(h_axes, 'Position');
    plot_position(3:4) = position(3:4);
    %plot_position(4) = plot_position(4) - hleg;
    %set(h_axes,'Position',plot_position);
    plot_position(2) = plot_position(2) + hleg;
    set(h_axes,'Position',plot_position);
    
    % Prepare plots legend
    set(h_axes,'NextPlot', 'add');  % hold on
    VarMarkerSize = 6;
    x1d = plot(h_axes, 0, 0, 'b*', 'MarkerSize', VarMarkerSize);
    x2d = plot(h_axes, 0, 0, 'r*', 'MarkerSize', VarMarkerSize);
    x3d = plot(h_axes, 0, 0, 'o', 'LineWidth', 3, 'MarkerEdgeColor', [1.0 0.7 0.0], 'MarkerSize', VarMarkerSize);
    x4d = plot(h_axes, 0, 0, 'or', 'MarkerFaceColor', 'r', 'MarkerSize', VarMarkerSize);
    set(h_axes,'NextPlot','replace');   % hold off
    h_leg = legend([x1d,x2d,x3d,x4d],'Detected objects','Warning phase','Pre-braking phase','Full auto-braking','Location','best');
    set(h_leg, 'FontSize', 8, 'Units', 'pixels', 'Position',[0 0 position(3)+1 hleg], 'ButtonDownFcn',[])
    
    % Set plot axis
    cla(h_axes);
    set(h_axes,'XLim', [ -maxX maxX],'YLim',[-8, max(TISMaxRange)+4]);
    set(h_axes,'XGrid','on','YGrid','on');
    set(h_axes,'XTickLabel',[],'YTicklabel',[]);
    set(h_axes,'XTick',10*floor(-maxX/10) : 10 : 10*ceil(maxX/10));
    set(h_axes,'YTick',-10 : 10 : 10*ceil((maxY+4)/10) )
    
	handles = [ h_Rdlg h_axes x1d x2d x3d x4d ];
	set_param(block.BlockHandle,'UserData',handles,'UserDataPersistent','on');
    
end
end
% End of Start function

function Outputs(block)
handles     = get_param(block.BlockHandle,'UserData');
h_axes = handles(2);

TISdet      = block.DialogPrm(2).Data;
TISMaxRange = block.DialogPrm(3).Data;
TISMaxTheta = block.DialogPrm(4).Data;  % in degrees
TISMaxTheta = pi/180 * TISMaxTheta;     % in radians

TIS1range = block.InputPort(1).Data;
TIS1theta = block.InputPort(2).Data;
TIS2range = block.InputPort(3).Data;
TIS2theta = block.InputPort(4).Data;
Flags_16  = block.InputPort(5).Data;
Flags_26  = block.InputPort(6).Data;
Flags_06  = block.InputPort(7).Data;

xs1 = TIS1range .* sin(-TIS1theta);
ys1 = TIS1range .* cos(-TIS1theta);

xs2 = TIS2range .* sin(-TIS2theta);
ys2 = TIS2range .* cos(-TIS2theta);

% Clear axes
cla(h_axes);

% Hold on
set(h_axes,'NextPlot', 'add');

% Draw detected objects for TIS1
for ii = 1 : TISdet(1)
    if TIS1range(ii)~=0 && TIS1range(ii)~=TISMaxRange(1)
        plot(h_axes, xs1(ii),   ys1(ii), '*', 'HandleVisibility','on');
        if Flags_26(ii) > 0
            plot(h_axes, xs1(ii),    ys1(ii),'r*','MarkerSize',10,'LineWidth',2);
            h_text = text(xs1(ii)+2, ys1(ii),[num2str(xs1(ii),'%5.1f'),'  ',num2str(ys1(ii),'%5.1f')],'BackgroundColor',[.7 .9 .7],'FontSize',6, 'Parent', h_axes); %#ok<NASGU>
            if Flags_16(ii) > 0
                plot(h_axes, xs1(ii),ys1(ii),'o','MarkerSize',14,'LineWidth',3,'MarkerEdgeColor',[1.0 0.7 0.0]);
            end
        else
            h_text = text(xs1(ii)+2, ys1(ii), [num2str(xs1(ii),'%5.1f'),' ',num2str(ys1(ii),'%5.1f')],'FontSize',6, 'Parent', h_axes);
        end
    end
end

% Reasign variables ( ! )
TISMaxTheta = TISMaxTheta / 2;

% % Draw detected objects for TIS2
for ii = 1 : TISdet(2)
    if TIS2range(ii)>0 && TIS2range(ii)<5*TISMaxRange(2)
        if abs(TIS2theta(ii)) > TISMaxTheta(1)/2    % if an object is not in TIS1 beam
            plot(h_axes, xs2(ii),   ys2(ii), '*', 'HandleVisibility','on');
            h_text = text(xs2(ii)+2, ys2(ii), [num2str(xs2(ii),'%5.1f'),' ',num2str(ys2(ii),'%5.1f')],'FontSize',6, 'Parent', h_axes);
        end
        if Flags_06(ii) > 0
            plot(h_axes, xs2(ii),ys2(ii),'or','MarkerSize',10,'MarkerFaceColor','r');
            plot(h_axes, xs2(ii),ys2(ii),'*','HandleVisibility','on');
            if ~exist('h_text','var')
                text((xs2(ii)+2), ys2(ii),[num2str(xs2(ii),'%5.1f'),' ',num2str(ys2(ii),'%5.1f')],'FontSize',6, 'Parent', h_axes);
            end
        end
    end
end

% Draw TIS1 boundaries
xr1=[0 -TISMaxRange(1) .* sin(TISMaxTheta(1)) ];
xr2=[0  TISMaxRange(1) .* sin(TISMaxTheta(1)) ];
yr1=[0  TISMaxRange(1) .* cos(TISMaxTheta(1)) ];
plot(h_axes,xr1,yr1,'b-');
plot(h_axes,xr2,yr1,'b-');
xcircle1 = TISMaxRange(1) .* sin( -TISMaxTheta(1) : 0.0016 : TISMaxTheta(1) );
ycircle1 = TISMaxRange(1) .* cos( -TISMaxTheta(1) : 0.0016 : TISMaxTheta(1) );
plot(h_axes, xcircle1, ycircle1, 'b-');

% Draw TIS2 boundaries
xr1=[0 -TISMaxRange(2) .* sin(TISMaxTheta(2)) ];
xr2=[0  TISMaxRange(2) .* sin(TISMaxTheta(2))];
yr1=[0  TISMaxRange(2) .* cos(TISMaxTheta(2))];
plot(h_axes,xr1,yr1,'m-');
plot(h_axes,xr2,yr1,'m-');
xcircle1 = TISMaxRange(2) .* sin( -TISMaxTheta(2) : 0.0016 : TISMaxTheta(2) );
ycircle1 = TISMaxRange(2) .* cos( -TISMaxTheta(2) : 0.0016 : TISMaxTheta(2) );
plot(h_axes, xcircle1, ycircle1, 'm-');

% Draw a car
rectangle('Position',[-1,-4,2,4],'EdgeColor','k','LineWidth',2,'Parent',h_axes);

% Draw TIS signs
angle = pi/2+TISMaxTheta(1);
wek = [cos(angle) -sin(angle); sin(angle) cos(angle)] * [TISMaxRange(1); 2];
text(wek(1), wek(2), 'LRR', 'Parent', h_axes, 'Rotation', 180/pi*TISMaxTheta(1)-90, 'Color', 'k')
angle = pi/2+TISMaxTheta(2);
wek = [cos(angle) -sin(angle); sin(angle) cos(angle)] * [TISMaxRange(2); 2];
text(wek(1), wek(2), 'SRR', 'Parent', h_axes, 'Rotation', 180/pi*TISMaxTheta(2)-90, 'Color', 'k')

% Hold off
set(h_axes,'NextPlot','replace');

end
% endfunction Outputs