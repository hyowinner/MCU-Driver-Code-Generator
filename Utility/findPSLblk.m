function blkhdls = findPSLblk(modelhandle)
% This function find all S6J3200 PSL blocks' handles.
% Hyowinner @2016/6/28

blkhdls = find_system(modelhandle, 'findall', 'on', 'RegExp', 'on',...
    'ReferenceBlock', 'periblklib/.*');
end