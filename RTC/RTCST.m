function uiobj = RTCST
% This is the config file for generate UI for RTC Start/Stop write.
% short for : rtcst
% This block can be multiple.
sfnName = 'rtcst';

index = 1;
% first element is the display string.  pername|headerfile|funcpostname
% will be stored in S-Function block.
uiobj(index).prompt = ['This block configs to used to start/stop the RTC. 0 - stop operation; 1 - start to operate.'];
uiobj(index).headerfile = 's6j3200_RTC.h';
uiobj(index).periname = 'RTC';
uiobj(index).funcpostname = '_%<start>';          % %<> means this is a multiple periblock. It will generate multiple function definition and call.               
uiobj(index).arg = 'void';                                  % seperate with ";" if multiple argument
uiobj(index).ret = 'void ';                                 % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Start or Stop';
uiobj(index).tabname = '';
uiobj(index).var = 'start';   
uiobj(index).type = 'popupmenu';                            
uiobj(index).members = {'Stop';'Start'}; 
uiobj(index).val = 'Stop';   
uiobj(index).codegenstr = {'0';'1'};  
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'used to start/stop the RTC.';
uiobj(index).regio = 'RTC_WTCR_ST';

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


