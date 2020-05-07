function f = autoGUI_multitab(configfile, titlename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can generate GUI according to config file automatically
% configfile -- a file that contains peripheral UI config struct.
% titlename -- will display as the title of the figure
% f -- return the handle of UI.
% 2016/6/25 Hyowinner
% for P3_22 formatin popupmenu with character, should not be cell2mat|str2double-ed
% Add a branch to process this situation.
% 2016/7/7 Hyowinner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning on;
obj = configfile;  % get current ui config struct.
ctrlnum = length(obj);
tabnum = 0;         % init number of tabs
tabcont = {};
% UI property setting begin
colorset = ones(1,3) * 0.903;
Fontsize = 10;
% UI property setting end
invisib_cnt = 0;     % record how many uicontrol are invisible
upper_cnt = 0;    %record how many uicontrol should be in upper position
% count the total tab number
for ii = 2:ctrlnum - 2
    tabcont{end + 1} = obj(ii).tabname;
end
tabnames = unique(tabcont);
tabnum = length(tabnames);      % number of tabs
if (tabnum == 1)&&(isempty(tabnames{1}))  % if only one tab or it is empty string
    f = autoGUI(configfile, titlename);   % No tab
    return;
end
warning off;        % off the undocumented uitabgroup/uitab warning.
% create empty group variables to store obj seperately. Name:
% groupn, n = 1,2,3
for ii = 1:tabnum
    eval(['group',num2str(ii) ,' = [];']);
end
% group all controls to each tab
for ii = 2:ctrlnum - 2
    for jj = 1:tabnum
        if strcmpi(obj(ii).tabname, tabnames(jj))  % if matched group fill it in
            eval(['group',num2str(jj) ,' = [group',num2str(jj) ,',obj(',num2str(ii),')];']);
        end
    end
end
% generate UI in the center on the right.
screensize = get(0, 'ScreenSize');
screenlen = screensize(3);
screenhight = screensize(4);
assert(ctrlnum > 0, 'Config File must contain more than one control infomation!');
% create a modal figure to avoid multiple instances.
f = figure('Name',titlename,'Menubar','None','Color',colorset,...
    'Position', [screenlen/2.6 screenhight/3 screenlen/3.3 (ctrlnum - invisib_cnt - 1) * 25],...
    'resize','on','Numbertitle','off','WindowStyle','normal');

% create tabs group position
h = uitabgroup(f, 'Units','Normalized',...
    'Position',[0.05 0.12 0.9 0.67]);
tabh = zeros(1,tabnum);      % handle vector for tab
for ii = 1:tabnum
    tabh(ii) = uitab(h, 'title', tabnames{ii}, 'BackgroundColor', colorset);        % add colorset to each tab.
    % 'Units','Normalized',...
    % 'Position', [0.05 0.05 0.9 0.75]);
end

% set a panel/text to display infomation about this UI
displayh = 0.2;
disppos = [.05 .8 .9 .195];
disptextpos(1) = disppos(1) + 0.03;
disptextpos(2) = disppos(2) + 0.02;
disptextpos(3) = disppos(3) * 0.95;
disptextpos(4) = disppos(4) * 0.79;% text should not cover uipanel.
uipanel('Parent',f,'Title','','FontSize',Fontsize,...
    'BackgroundColor',colorset,...
    'Units','Normalized',...
    'Position',disppos);
uicontrol(f, 'Fontsize',Fontsize,...
    'Style','text',...
    'BackgroundColor', colorset,...
    'Units','Normalized',...
    'Position',disptextpos,...
    'HorizontalAlignment','left',...
    'String',obj(1).prompt);
% control combinition parameter
ctrlcmbparam = 0.75;
% display information setting end
for ii = 1:tabnum
    upper_cnt = 0;
    % another layer of loop for idx
    ctrlnumtab = eval(['length(group',num2str(ii),')']);  % current group elements number
    for jj = 1:ctrlnumtab 
        uicontrol(tabh(ii), 'Style','Text',...
            'String',eval(['group',num2str(ii),'(',num2str(jj),').prompt']),...
            'Units','Normalized',...               % -1 means last two pushbutton ocupy one line      % -1 means the first obj is display string
            'Position',[0.05 0.97 - ctrlcmbparam/(ctrlnumtab) * (jj)  0.2 0.67/(ctrlnumtab)],...
            'BackGroundColor',colorset,...
            'HorizontalAlignment','left',...
            'Visible',eval(['group',num2str(ii),'(',num2str(jj),').visible']),...
            'FontSize',Fontsize);
        ctrl = uicontrol(tabh(ii), 'Style',eval(['group',num2str(ii),'(',num2str(jj),').type']),...
            'String',eval(['group',num2str(ii),'(',num2str(jj),').val']),...
            'Units','Normalized',...                % -1 means last two pushbutton ocupy one line
            'Position', [0.3 0.99 - ctrlcmbparam/(ctrlnumtab) * (jj)  0.65 0.67/(ctrlnumtab)],...
            'BackGroundColor',colorset,...
            'Enable',eval(['group',num2str(ii),'(',num2str(jj),').enable']),...
            'Visible',eval(['group',num2str(ii),'(',num2str(jj),').visible']),...
            'tag', eval(['group',num2str(ii),'(',num2str(jj),').var']),...                      % var store here as tag, to communicate with S-Function
            'TooltipString', eval(['group',num2str(ii),'(',num2str(jj),').helptip']),...
            'FontSize',Fontsize);
        ctrlprop = get(ctrl);
        % set members for popupmenu
        if strcmpi(ctrlprop.Style, 'popupmenu')
            set(ctrl, 'String', eval(['group',num2str(ii),'(',num2str(jj),').members']));
            set(ctrl, 'BackgroundColor', 'white');  % background return to white
            try
                validx = find(ismember(cell2mat(eval(['group',num2str(ii),'(',num2str(jj),').members'])),eval(['group',num2str(ii),'(',num2str(jj),').val'])));  % both memebers and val are string type
            catch  % for non-digital cell, cell2mat is NG
                validx = find(ismember(eval(['group',num2str(ii),'(',num2str(jj),').members']),eval(['group',num2str(ii),'(',num2str(jj),').val'])));
            end
            if ~isequal(size(validx), [1 1])        % for P3_22 format in popupmenu
                validx = find(ismember(eval(['group',num2str(ii),'(',num2str(jj),').members']),eval(['group',num2str(ii),'(',num2str(jj),').val'])));  % members are cell, val is string type
            end
            if isempty(validx)
                validx = find(ismember(eval(['group',num2str(ii),'(',num2str(jj),').members']),str2double(eval(['group',num2str(ii),'(',num2str(jj),').val']))));  % both memebers and val are number type
            end  
            assert(~isempty(validx), [ctrlprop.TooltipString 'ERROR: val must is a element of memebers for popup!']);
            assert(isequal(size(validx), [1 1]), 'val must be unique in members for popup!');
            set(ctrl, 'Value', validx);
        end
        % set backgroundcolor for edit
        if strcmpi(ctrlprop.Style, 'Edit')
            set(ctrl, 'BackgroundColor', 'white');
        end
        % set checkbox check on/off
        if strcmpi(ctrlprop.Style, 'checkbox')
            set(ctrl, 'Value', strcmpi(eval(['group',num2str(ii),'(',num2str(jj),').val']), 'on'), 'String', eval(['group',num2str(ii),'(',num2str(jj),').prompt'])); % checkbox displays prompt on control's both sides
        end
        % set Callback for all controls if exist
        if isfield(eval(['group',num2str(ii),'(',num2str(jj),')']), 'Callback')
            set(ctrl, 'Callback', eval(['group',num2str(ii),'(',num2str(jj),').Callback']));
        end
        % set string for Pushbutton
        if strcmpi(ctrlprop.Style, 'pushbutton')
            set(ctrl, 'String',eval(['group',num2str(ii),'(',num2str(jj),').prompt']));
        end
    end
end

% Last two control are Cancel and OK button and position them in one line.
for ii = ctrlnum - 1: ctrlnum
    uicontrol(f, 'Style','Pushbutton',...
        'String',obj(ii).prompt,...
        'Units','Normalized',...
        'Position',[0.5 + 0.25 * (ctrlnum - ii) 0.06 0.23 0.08],...
        'BackGroundColor',colorset,...
        'HorizontalAlignment','left',...
        'Visible', 'on',...
        'Enable', 'on',...
        'Callback',obj(ii).Callback,...
        'FontSize',Fontsize);
end
% END of creating all uicontrols
end
