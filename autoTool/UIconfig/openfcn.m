function openfcn(blkhdl, configfile, funcname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function defines action when double-click one block.
% It read all controlvariable - controlvalue pairs in the S-func blk to create
% GUI with stored value.
% Hyowinner @ 2016/6/25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prop = get(blkhdl);
assert(isfield(prop, 'g_pv'), ['Error: Current block' lower(funcname) 'has no parameter "g_pv"!']);
pv = get_param(blkhdl, 'g_pv');
if strcmp(pv, '0')                                      % initial state when this block first made
    autoGUI_multitab(configfile, funcname);
else                                                    % store value to GUI
    f = autoGUI_multitab(configfile, funcname);
    pv_pair = regexp(pv, ';', 'split');                 % cell, "obj.var,obj.val"
    for ii = 2: length(pv_pair) - 1                     % last pair is empty, first pair is [headerfile, funpostname]
        p_v = regexp(pv_pair{ii}, ',', 'split');        % cell, obj(ii).var,obj(ii).val
        set_param_ui(f, p_v{1}, p_v{2});                % set value from block to UI.
    end
end
end


function set_param_ui(figure, tagname, strval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function set value 'strval' to specified control 'tagname'
% in UI 'figure'.
% Hyowinner @ 2016/6/25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
target = findobj(figure, 'tag', tagname);
assert(~isempty(target), 'Error: specified tag does not exist.');
if strcmpi(target.Style, 'Edit')
    set(target, 'string', strval);
elseif strcmpi(target.Style, 'checkbox')
    if strcmpi(strval, 'on')
        setval = 1;
    else
        setval = 0;
    end
    set(target, 'Value', setval);
elseif strcmp(target.Style,'popupmenu')
    strcont = get(target, 'string');
    setidx = find(ismember(strcont, strval), 1, 'first');
    set(target, 'Value', setidx);
else
    set(target, 'string', strval);              % if new type occur modify then
end
end