function PlotFcn_figure()
% double-click function of PlotFcn_msfun block:
% create a new figure

FigureVisibility = get_param(gcb, 'FigureVisibility');

if strcmp(FigureVisibility,'on')
    set_param(gcb, 'MaskEnables',{'on','on','on','on','on','on','on','off','off','off','off'});
else
    set_param(gcb, 'MaskEnables',{'on','off','off','off','off','off','off','off','off','off','on'});
end
