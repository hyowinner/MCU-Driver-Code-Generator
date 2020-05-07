function requireParamEnDisCond(hdl, ~, targetparam, onval, offval, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function set target param "enable" to "on"/"off" according to 
% its value in the same UI.
% What's more, check if value of current control is member of onval
% Hyowinner @2016/7/6
% eg. {@requireParamEnDisCond, 'pcmoffset',{'low-pass filter';'simplified H-bridge'},...
% 'full H-bridge','deadtimeval','full H-bridge',{'low-pass filter';'simplified H-bridge'}};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';     % modal msgbox option
if nargin > 6
   if mod((nargin - 5), 3) ~= 0         %  varargin{ii}, varargin{ii+1}, varargin{ii+2} make one group of {targetparam, onval, offval}
       msgbox('Error: Input argument''s number is not grouped!', CreateStruct);
       return;
   end
else
    msgbox('Error: Input argument''s number is not enough!', CreateStruct);
    return;
end
type = get(hdl, 'Style');
if strcmp(type, 'popupmenu')            % for different control different get methods should be used.
    strs = get(hdl, 'String');
    value = get(hdl, 'Value');
    val = strs{value};
else
    val = [];                           % other control type should be added later.
end
parent = get(hdl, 'Parent');            % only find the tab not the root figure
while ~isempty(parent.Parent)           % find the UI figure obj 
    parent = get(parent, 'Parent');
end
targetobj = findobj(parent, 'Tag', targetparam);
if ismember(val, onval)
    setval = 'on';
elseif ismember(val, offval)
    setval = 'off';
else
    msgbox('Error: Input value is out of provided parameters.',CreateStruct);
end
set(targetobj, 'Enable', setval);
% process varargin that start with the 6th parameter.
for ii = 1:3:length(varargin)
    targetobj = findobj(parent, 'Tag', varargin{ii});
    onval = varargin{ii + 1};           %  varargin{ii}, varargin{ii+1}, varargin{ii+2} make one group of {targetparam, onval, offval}
    offval = varargin{ii + 2};
    if ismember(val, onval)
        setval = 'on';
    elseif ismember(val, offval)
        setval = 'off';
    else
        msgbox('Error: Input value is out of provided parameters.',CreateStruct);
    end
    set(targetobj, 'Enable', setval);
end
end