function uiobj = RTCMANUALTRIG
% This is the config file for generate UI for RTC MANUAL TRIGGER for
% Calibration.
% short for : rtcmanualtrig
sfnName = 'rtcmanualtrig';

index = 1;
% first element is the display string|headerfile|periname|funcpostname|arg|ret. 
uiobj(index).prompt = ['This block is used to trigger a software calibration cycle under Manual Calibration Mode.'];
uiobj(index).headerfile = 's6j3200_RTC.h';
uiobj(index).periname = 'RTC';
uiobj(index).funcpostname = '_MalTrig';
uiobj(index).arg = 'void';
uiobj(index).ret = 'void ';                                         % with a white_space after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Automatic calibration';
uiobj(index).tabname = '';
uiobj(index).var = 'autocal';
uiobj(index).type = 'popupmenu'; 
uiobj(index).members = {'on'; 'off'};
uiobj(index).val = 'off';
uiobj(index).codegenstr = {'0';'1'}; 
uiobj(index).visible = 'on';
uiobj(index).enable = 'off';
uiobj(index).helptip = 'indicate enable/disable Automatic Calibration mode.';
uiobj(index).ButtonDownFcn =  {@requireSameParam,'RTC Init', 'autocal'};   % for requirement between blocks
%%%% regio has to be hanged in valid obj
uiobj(index).regio = 'RTC_WTCR_MTRG';


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


