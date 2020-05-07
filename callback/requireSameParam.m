function requireSameParam(hdl, evnt, target_block, target_param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This callback check whether current control hold the same value with
% target_param on target_block. If not then change to the same param and disable.
% If target_param of target_block does not exists, tips "Target block not
% existed".
% eg. {@requireSameWith,'ProgrammableCRC Init', 'chklen'}
% Hyowinner @2016/6/26
% Modify method to find targetblock, they may be in different layer of
% subsystem. @2016/6/28
% Judge type of hdl, process accordingly for "text" and "popup"
% Hyowinner @2016/7/12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag = 0;               % not found target_block
targetblks = find_system(bdroot(gcs), 'IncludeCommented', 'on', 'Blocktype','S-Function');
for ii = 1:length(targetblks)
    if ~isempty(regexp(targetblks{ii}, target_block))
        % find which one match target_block
        flag = 1;
        targetfullname = targetblks{ii};
        break;
    end
end
if 0 == flag         % if current model has no target
    set(hdl, 'String', ['Required target block "' target_block '" does not exists!']);
    return;
end
targetparams = get_param(targetfullname, 'g_pv');           % take pv from target block
searched_pv = regexp(targetparams, [target_param ',.+?;'], 'match');      %lazy search
targetval = strrep(searched_pv, target_param, '');
targetval = regexprep(targetval, '[,;]', '');       % need only value
if isempty(targetval)
    set(hdl, 'String', ['Required target block "' target_block '" does not hold the parameter "' target_param  '"!']);
    return; 
end
% found target parameter successfully

% process according to Style
prop = get(hdl);
if strcmpi(prop.Style, 'popupmenu')
    index = find(ismember(prop.String, targetval));
    set(hdl, 'Value', index);
elseif strcmpi(prop.Style, 'text')
    set(hdl, 'String', targetval);
end
end
