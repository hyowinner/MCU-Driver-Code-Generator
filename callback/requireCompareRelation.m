function requireCompareRelation(hdl, evnt, target_block, target_param, relStr)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This callback check whether current control hold the value meet the relationship with
% target_param on target_block. If not then tips with modal msgbox. 
% If target_param of target_block does not exists, tips "Target block not
% existed".
% eg. {@requireCompareRelation,'PCMPWM Init', 'cntperiod', '<'};
% Hyowinner @2016/7/3
% Input number value should be an integer. @2016/7/6
% Add different process for get value for edit|popupmenu @2016/7/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';                     % modal msgbox option
errMsg = [];
targetblks = find_system(bdroot(gcs), 'IncludeCommented', 'on', 'Name', target_block);
if isempty(targetblks)
    errMsg = [errMsg 'Required target block "' target_block '" should exists in model!' char(10)];
end
targetparams = get_param(targetblks, 'g_pv');           % take pv from target block
searched_pv = regexp(targetparams, [target_param ',.+?;'], 'match');      %lazy search
if isa(searched_pv, 'cell')
    searched_pv = searched_pv{:};
end
targetval = strrep(searched_pv, target_param, '');
targetval = regexprep(targetval, '[,;]', '');       % need only value
if isempty(targetval)
    errMsg = [errMsg 'Required target block "' target_block '" does not hold the parameter "' target_param  '"!' char(10)];
end
curvalstr = get(hdl, 'String');
% need to differ char vec catch for different control type.
if isa(curvalstr, 'char')                  % for edit
    curval = curvalstr;
    need2execStr = [curval relStr targetval];                           % eg.   23 < 55
elseif isa(curvalstr, 'cell')              % for popupmenu
    curindex = get(hdl, 'Value');
    curval = curvalstr{curindex};
    need2execStr = cell2mat([curval relStr targetval]);                 % eg.   1000ms > 500ms
end

if isa(need2execStr, 'cell')
    need2execStr = cell2mat(need2execStr);
end
if isa(targetval, 'cell')
    targetval = cell2mat(targetval);
end
if ~eval(need2execStr)      
    errMsg = [errMsg 'Current input should ' relStr ' ' target_param '(' targetval ')'];
end
if ~isempty(errMsg)
    msgbox(errMsg, CreateStruct);
end
    
    
 
