function en_disPanel(hdl, ~, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the cb of some control(checkbox) to be the inversed status of a group of controls
% that are all in one tabgroup.
% Hyowinner @2016/7/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
assert(nargin >= 3, 'Error: No target control is specified.');
val = get(hdl, 'Value');
if val == 0
    setval = 'off';
else
    setval = 'on';
end
panel = get(hdl, 'Parent');             % find current tab object.
fig = get(panel, 'Parent');             % find current fig object.
for ii = 1: nargin - 2                  % varargin exclude hdl and event(~)
    targettab = findobj(fig, 'Title', varargin{ii});
    for jj = 1:length(targettab)
        controls = findobj(targettab(jj), 'Type', 'UIControl');
        set(controls, 'Enable', setval);
    end
end
end