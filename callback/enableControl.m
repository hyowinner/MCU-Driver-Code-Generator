function enableControl(hdl, event, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the cb of some control(s) to be the inversed status of other controls.
% Hyowinner @2016/7/10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
assert(nargin >= 3, 'Error: No target control is specified.');
val = get(hdl, 'Value');
if val == 0
    setval = 'on';
else
    setval = 'off';
end
parent = get(hdl, 'Parent');            % find current tab object.
for ii = 1: nargin - 2                  % varargin exclude hdl and event
    targetobj = findobj(parent, 'tag', varargin{ii});
    set(targetobj, 'Enable', setval);
end
end