function setEnablewithPopup(hdl, ~, val, tartag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function set Enable/Disable for tartag in tartab according to current value in
% current control.
% 2016/7/10
curval = get(hdl, 'Value');
parent = get(hdl, 'Parent');
parent = get(parent, 'Parent');             % current figure
tarobj = findobj(parent, 'Tag', tartag);            % find target in the root figure
assert(numel(tarobj) == 1, 'Error: Multiple obj/No obj with the same tag found!');
if curval == val
    set(tarobj, 'Enable', 'off');
else
    set(tarobj, 'Enable', 'on');
end