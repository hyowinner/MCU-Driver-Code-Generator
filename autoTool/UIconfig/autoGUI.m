function f = autoGUI(configfile, titlename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can generate GUI according to config file automatically
% configfile -- a file that contains peripheral UI config struct.
% titlename -- will display as the title of the figure
% f -- return the handle of UI.
% 2016/6/25 Hyowinner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obj = configfile;  % get current ui config struct.
ctrlnum = length(obj);
% UI property setting begin
colorset = ones(1,3) * 0.903;
Fontsize = 10;
% UI property setting end
invisib_cnt = 0;     % record how many uicontrol are invisible
upper_cnt = 0;    %record how many uicontrol should be in upper position
% Need to count the total number of invisible control to draw GUI compact.
for ii = 1:ctrlnum
    if strcmp(obj(ii).visible, 'off')
        invisib_cnt = invisib_cnt + 1;
    end
end
% generate UI in the center on the right.
screensize = get(0, 'ScreenSize');
screenlen = screensize(3);
screenhight = screensize(4);
assert(ctrlnum > 0, 'Config File must contain more than one control infomation!');
% create a modal figure to avoid multiple instances.
f = figure('Name',titlename,'Menubar','None','Color',colorset,...
    'Position', [screenlen/2.6 screenhight/3 screenlen/2.3 (ctrlnum - invisib_cnt - 1) * 35],...  
    'resize','on','Numbertitle','off','WindowStyle','normal');
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
ctrlcmbparam = 0.85;
% display information setting end
for ii = 2: ctrlnum - 2
    % if invisible, no draw
    if strcmp(obj(ii).visible, 'off')
        upper_cnt = upper_cnt + 1;
        continue;
    end
    uicontrol(f, 'Style','Text',...
        'String',obj(ii).prompt,...
        'Units','Normalized',...               % -1 means last two pushbutton ocupy one line      % -1 means the first obj is display string
        'Position',[0.05, 0.98 - displayh - ctrlcmbparam/(ctrlnum - invisib_cnt - 1) * (ii - 1 - upper_cnt)  0.2 0.8/(ctrlnum - invisib_cnt)],...
        'BackGroundColor',colorset,...
        'HorizontalAlignment','left',...
        'Visible',obj(ii).visible,...
        'FontSize',Fontsize);
    ctrl = uicontrol(f, 'Style', obj(ii).type,...
        'String',obj(ii).val,...
        'Units','Normalized',...                % -1 means last two pushbutton ocupy one line
        'Position', [0.3 1 - displayh - ctrlcmbparam/(ctrlnum - invisib_cnt- 1) * (ii - 1 - upper_cnt)  0.65 0.65/(ctrlnum - invisib_cnt)],...
        'BackGroundColor',colorset,...
        'Enable',obj(ii).enable,...
        'Visible',obj(ii).visible,...
        'Tag', obj(ii).var,...                  % var store here as tag, to communicate with S-Function
        'TooltipString', obj(ii).helptip,...
        'FontSize',Fontsize);
    ctrlprop = get(ctrl);
    % set members for popupmenu
    if strcmpi(ctrlprop.Style, 'popupmenu')
        set(ctrl, 'String', obj(ii).members);
        set(ctrl, 'BackgroundColor', 'white');  % background return to white
        try
            validx = find(ismember(cell2mat(obj(ii).members),obj(ii).val));  % both memebers and val are string type
        catch  % for non-digital cell, cell2mat is NG
            validx = find(ismember(obj(ii).members,obj(ii).val));
        end
        if isempty(validx)
            if isa(obj(ii).val, 'cell')
                validx = find(ismember(obj(ii).members,obj(ii).val));  % memebers and val are cell type
            elseif isa(obj(ii).val, 'char')
                validx = find(ismember(obj(ii).members,str2double(obj(ii).val)));  % both memebers and val are number type
            else
                error('Error: Non-support type for element of popumenu!');
            end
        end
        assert(~isempty(validx), 'val must is a element of memebers for popup!');
        assert(isequal(size(2), [1 1]), 'val must be unique in members for popup!');
        set(ctrl, 'Value', validx);
    end
    % set backgroundcolor for edit
    if strcmpi(ctrlprop.Style, 'Edit')
        set(ctrl, 'BackgroundColor', 'white');
    end
    % set checkbox check on/off
    if strcmpi(ctrlprop.Style, 'checkbox')
        set(ctrl, 'Value', strcmpi(obj(ii).val, 'on'), 'String', obj(ii).prompt); % checkbox displays prompt on control's both sides
    end
     % set pushbutton string
    if strcmpi(ctrlprop.Style, 'pushbutton')
        set(ctrl, 'String',obj(ii).val);
    end
    % set Callback for controls
    if isfield(obj(ii), 'Callback')
       set(ctrl, 'Callback', obj(ii).Callback);
    end
     if isfield(obj(ii), 'ButtonDownFcn')
       set(ctrl, 'ButtonDownFcn', obj(ii).ButtonDownFcn);
    end
end
% Last two control are Cancel and OK button and position them in one line.
for ii = ctrlnum - 1: ctrlnum
   uicontrol(f, 'Style','Pushbutton',...
        'String',obj(ii).prompt,...
        'Units','Normalized',...                                    
        'Position',[0.5 + 0.25 * (ctrlnum - ii)  1 - displayh - ctrlcmbparam/(ctrlnum - invisib_cnt) *(ctrlnum - 1 - upper_cnt)  0.2 0.8/(ctrlnum - invisib_cnt)],...
        'BackGroundColor',colorset,...
        'HorizontalAlignment','left',...
        'Visible', 'on',...
        'Enable', 'on',...
        'Callback',obj(ii).Callback,...
        'FontSize',Fontsize); 
end
% END of creating all uicontrols
end
