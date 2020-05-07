function repstr = repvar(blockhandle, instr)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function replace the variable %<> to its ui valuestr
% Hyowinner @2016/7/5
% If block funcpostname has no %<>, return instr without change.
% Hyowinner @2016/7/6
% When there are multiple %<> in one sentence, support to replace them
% Hyowinner @2016/7/25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tbrep = cell2mat(regexp(instr, '%<.*>', 'match'));
if isempty(tbrep)
    repstr = instr;
else
    if isa(tbrep, 'char')
        varname = regexprep(tbrep, '[%<>]','');
        varval = get_param_pv(blockhandle, varname);                % replace with block pv val. It should be ui val
        repstr = strrep(instr, tbrep, varval);
    elseif isa(tbrep, 'cell')
        for ii = 1:length(tbrep)
            varname = regexprep(tbrep{ii}, '[%<>]','');
            varval = get_param_pv(blockhandle, varname);                % replace with block pv val. It should be ui val
            repstr = strrep(instr, tbrep{ii}, varval);
        end
    end
end