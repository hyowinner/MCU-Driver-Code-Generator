function val = get_param_headerfile(blockhandle)
% This function get value of headerfile from g_pv of PSL block
% Hyowinner @2016/6/27
targetparams = get_param(blockhandle, 'g_pv');                      % take pv from target block
searched = regexp(targetparams,  's6j3200.+?,', 'match');           % lazy mode
searched = regexprep(searched, ',', '');
if isa(searched, 'cell')
    val = cell2mat(searched);
end

end