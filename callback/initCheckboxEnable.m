function enableStr = initCheckboxEnable(blockhandle, depend_var)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is to init checkbox enable staus according to the specified
% control value that is stored in Peripheral Block.
% Hyowinner @2016/7/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
assert(nargin == 2, 'Error: Number of argument must be 2!');
enableStr = get_param_pv(blockhandle, depend_var);                 % gcbh will cause a error if focus is not on "SWFG Init block"
if isempty(enableStr)
    error(['CB Err: ' depend_var ' can not be found in current block!']);
end
end