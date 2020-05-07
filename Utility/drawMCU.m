function drawMCU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function draw the MCU look for user to check pinnum,
% and pin functions.
% Make figure modal
% Hyowinner @ 2016/7/7
% start figure
% Delete WindowButtonMotionFcn for each pin because it is too slow.
% Change to add helptip for each pin for disp pin functions.
% Hyowinner @2016/7/8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
framemode = 3;  % 1: frame ,2: uibuttongroup, 3: uipanel, 4: uitabgroup
len = 500;  % figure size
hight = 500;
scrSize = get(0,'ScreenSize');
mcuview = figure('Name','MCU Looker by Hyowinner', 'Menubar', 'None',...
    'Position', [scrSize(3)/2 - len/2, scrSize(4)/2 - hight/2, len, hight],...
    'NumberTitle','off', 'WindowStyle', 'Modal');
if isequal(framemode, 1)
    exfrm = uicontrol(mcuview, 'Style', 'Frame',...
        'Units', 'Normalized', ...
        'Position', [0.1 0.1 0.8 0.8]);
    infrm = uicontrol(mcuview, 'Style', 'Frame',...
        'Units', 'Normalized', ...
        'Position', [0.15 0.15 0.7 0.7]);
elseif isequal(framemode, 2)
    exfrm = uibuttongroup(mcuview, ...
        'Units', 'Normalized', ...
        'Position', [0.1 0.1 0.8 0.8]);
    infrm = uibuttongroup(mcuview, ...
        'Units', 'Normalized', ...
        'Position', [0.15 0.15 0.7 0.7]);
elseif isequal(framemode, 3)
    exfrm = uipanel(mcuview, ...
        'Units', 'Normalized', ...
        'Position', [0.1 0.1 0.8 0.8]);
    infrm = uipanel(mcuview, ...
        'Units', 'Normalized', ...
        'Position', [0.15 0.15 0.7 0.7]);
elseif isequal(framemode, 4)
     exfrm = uitabgroup(mcuview, ...
        'Units', 'Normalized', ...
        'Position', [0.1 0.1 0.8 0.8]);
    infrm = uitabgroup(mcuview, ...
        'Units', 'Normalized', ...
        'Position', [0.15 0.15 0.7 0.7]);
end
cirlftup = plotCircle(0.15, 0.7, 0.05);  % located bottom now
% draw pins
horiMode = 1;
VertiMode = 2;
% This function should be called by Model Configuration Parameters UI.
Product = get_param(gcs, 't_mcutype');
type = Product(end);
switch type
    case 'K'
        pinnum = 208;
    case 'L'
        pinnum = 216;
    case 'M'
        pinnum = 256;
    otherwise
        error('Error: Not support Pin number!');
end
sidepinnum = pinnum/4;          % each pin size should be plotted for one side of mcuview
pinTotalwidth = 0.8/sidepinnum;
pinWidth = pinTotalwidth * 0.6;
pinHight = 0.06;
pinhdl = zeros(1,pinnum);       %initialize pinhdl 
% draw hori from left to right while draw vertical from bottom to top. So
% top side and left size is the inversed order with MCU
pinhdl(pinnum:-1:pinnum/4*3 + 1) = drawPinEachSide(mcuview, sidepinnum, pinTotalwidth, pinWidth, pinHight, [0.102, 0.9], horiMode); % plot top side  
pinhdl(pinnum/4 + 1:pinnum/2) = drawPinEachSide(mcuview, sidepinnum, pinTotalwidth, pinWidth, pinHight, [0.102 0.1 - pinHight], horiMode); % plot bottom side
pinhdl(pinnum/4:-1:1) = drawPinEachSide(mcuview, sidepinnum, pinTotalwidth, pinWidth, pinHight, [0.1 - pinHight, 0.1], VertiMode); % plot left side
pinhdl(pinnum/2 + 1:pinnum/4*3) = drawPinEachSide(mcuview, sidepinnum, pinTotalwidth, pinWidth, pinHight, [0.9, 0.1], VertiMode); % plot right side
% bound pinfunc to each pin helptip
pininfo = get_pin_func(gcs);
for ii = 1:length(pinhdl)
   set(pinhdl(ii), 'TooltipString', pininfo(ii)); 
end
% disp text
mcuinfo = uicontrol(infrm, 'style', 'text', ...
    'Units', 'Normalized', ...
    'Position',[0.3 0.5 0.4 0.15],...
    'String', ['    Pin Number:', num2str(pinnum), ...
    char(10), '   MCU Type:', Product, char(10),'Developped By Hyowinner']); % located bottom now
% WindowButtonMotionFcn can dynamically display pin functions for each pin
% that mouse stays but it is too slow when pin number is larget.
% set(mcuview, 'WindowButtonMotionFcn',{@within_pin, pinhdl, infrm});