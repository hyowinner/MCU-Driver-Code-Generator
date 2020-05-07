function blockhandle = find_system_unique(blockname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function find specified block handle from current model that belongs 
% to  HyoCG lib. If multiple or nothing found error tips and return corresponding result.
% Hyowinner
% 2016/7/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msg = [];
blkhdls = findPSLblk(gcs);
blknames = get(blkhdls, 'Name');
match_res = regexp(blknames, blockname);
if isa(match_res, 'cell')   
    index = find(~cellfun(@isempty, match_res));
elseif isa(match_res, 'double')
    index = match_res;              % should be 1
else 
    msg = 'Not support datatype!';
end
if isempty(index)
    msg = ['Target block "' blockname '" not found!'];
    blockhandle = [];
elseif length(index) > 1
    msg = ['Target block "' blockname '" has multiple copies!'];
    blockhandle = blkhdls(1);
else
    blockhandle = blkhdls(index);
end
if ~isempty(msg)
    error(msg);
end