function okbuttoncb(hdl, event, configfile, sfnName)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the callback of OK button on block UI.
% It stores all controlvariable - controlvalue pairs into the S-func blk.
% Hyowinner @ 2016/6/25
% add (funcpostname) to pv @2016/7/6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gcbh2 = gcbh;
fig = get(hdl, 'Parent');               % hdl means OK button.
% Mask info
maskName = 'g_pv';

% read configfile and draw pv pairs
g_pv = [];
obj = configfile;
% store headerfile and periname into "g_pv"         @2016/6/27
% add replace for postfuncname @2016/7/6
tbrep = cell2mat(regexp(obj(1).funcpostname, '%<.*>', 'match'));
if ~isempty(tbrep)
    varname = regexprep(tbrep, '[%<>]','');
    curval = get_param_ui(fig, varname);
    repfuncpstnm = strrep(obj(1).funcpostname, tbrep, curval);
else
    repfuncpstnm = obj(1).funcpostname;             % for funpostname without %<>, no replace
end
g_pv = [g_pv obj(1).headerfile ',' obj(1).periname ',' repfuncpstnm,  ';'];    %  add funcpostname
for ii = 2 : length(obj) - 2                                % attention here, should not get value from configfile but current GUI.
    g_pv = [g_pv obj(ii).var ',' get_param_ui(fig, obj(ii).var) ';'];          % ...;obj(ii).var, obj(ii).val;obj(ii+1).var,obj(ii+1).val;...
end

% set content of g_pv into block
prop = get(gcbh2);
assert(isfield(prop, maskName), ['Error: Current block' sfnName 'has no parameter "g_pv"!']);
set_param(gcbh2, maskName, g_pv);
% close UI
close(fig);
end

function uival = get_param_ui(figure, tagname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function get value 'uival' to specified control 'tagname'
% in UI 'figure'.
% Hyowinner @ 2016/6/25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
target = findobj(figure, 'tag', tagname);
assert(~isempty(target), 'Error: specified tag does not exist.');
if strcmpi(target.Style, 'edit')
    uival = get(target, 'string');
elseif strcmpi(target.Style, 'checkbox')
    if isequal(1, get(target, 'Value'))
        uival = 'on';
    else
        uival = 'off';
    end
elseif strcmp(target.Style,'popupmenu')
    strcont = get(target, 'string');
    strval = get(target, 'Value');
    if isa(strcont, 'cell')
        uival = strcont{strval};
    else
        uival = strcont(strval,:);
    end
else
    uival = get(target, 'string');              % if new type occur modify then
end
if isa(uival, 'cell')
    uival = cell2mat(uival);
end
end