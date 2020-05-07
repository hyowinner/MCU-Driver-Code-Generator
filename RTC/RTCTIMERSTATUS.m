function uiobj = RTCTIMERSTATUS
% This is the config file for generate UI for RTC Timer Status Register.
% short for : rtctimerstatus
% This block can be multiple.
sfnName = 'rtctimerstatus';

index = 1;
% first element is the display string.  pername|headerfile|funcpostname
% will be stored in S-Function block.
uiobj(index).prompt = ['This block configs to get various status bits for the RTC.'];
uiobj(index).headerfile = 's6j3200_RTC.h';
uiobj(index).periname = 'RTC';
uiobj(index).funcpostname = '_Status_%<regbit>';          % %<> means this is a multiple periblock. It will generate multiple function definition and call.               
uiobj(index).arg = 'void';                         % seperate with ";" if multiple argument
uiobj(index).ret = 'unsigned char ';               % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Get status of';
uiobj(index).tabname = '';
uiobj(index).var = 'regbit';   
uiobj(index).type = 'popupmenu';                            
uiobj(index).members = {'RUNC';'CLK_STS';'CSF';'RUN'}; 
uiobj(index).val = 'RUNC';
uiobj(index).codegenstr = {};                   % popupmenu must have field called "codegenstr"
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'used to start/stop the RTC.';
uiobj(index).regio = 'RTC_WTSR_%<regbit>';

% last two are Cancel and OK button, no var, do not store in s-function.
index = index + 1;
uiobj(index).prompt = 'Cancel';
uiobj(index).helptip = 'Cancel this configuration and close UI.';
uiobj(index).Callback = 'close(gcf)';

index = index + 1;
uiobj(index).prompt = 'OK';
uiobj(index).Callback = {@okbuttoncb, uiobj, sfnName};
uiobj(index).type = 'pushbutton';
uiobj(index).helptip = 'OK this configuration and close UI.';


