function val = get_param_pv(blockhandle, param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% This function get value of param from g_pv of PSL block
% get_param_pv(gcbh, '') to get all parameters from current block
% val is a char type.
% Hyowinner @2016/6/27
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
targetparams = get_param(blockhandle, 'g_pv');                      % take pv from target block
searched_pv = regexp(targetparams, [param ',.+?;'], 'match');       %lazy search
targetval = strrep(searched_pv, param, '');
val = regexprep(targetval, '[,;]', '');                             % need only value
if isempty(val)
    warning('Warning: current param return a empty value.'); 
end
if isa(val, 'cell')
    val = cell2mat(val);
end
end