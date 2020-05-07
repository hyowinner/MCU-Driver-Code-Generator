function uiobj = RTCRESET
% This is the config file for generate UI for RTC reset HH/MM/SS Sub-Seconed counter.
% short for : rtcupdate
% This block can be multiple called but have the unique definition.
sfnName = 'rtcreset';

index = 1;
% first element is the display string.  pername|headerfile|funcpostname
% will be stored in S-Function block.
uiobj(index).prompt = ['This block reset the Second/Minute/Hour Sub-Seconed counter.'];
uiobj(index).headerfile = 's6j3200_RTC.h';
uiobj(index).periname = 'RTC';
uiobj(index).funcpostname = '_Reset';                   
uiobj(index).arg = 'void';                                  % seperate with ";" if multiple argument
uiobj(index).ret = 'void ';                                 % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Reset the Hour/Minute/Second Sub-Second counters.';
uiobj(index).tabname = '';
uiobj(index).var = 'noparam';
uiobj(index).type = 'Text';
uiobj(index).val = '';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).regio = '';                                                    % For control that is not popup or edit or checkbox. No regio when no need to generate code for some register. but can generate precode and postcode.
uiobj(index).helptip = 'used to reset the time count value.';
uiobj(index).precode = ['RTC_WTCR_ST = 0;' char(10) 'while(RTC_WTSR_RUN = 0);'];                  % first added for code before and after regio = XX; @2016/7/12
uiobj(index).postcode = ['RTC_WTCR_ST = 1;'];

% last two are Cancel and OK button, no var, do not store in s-function.
index = index + 1;
uiobj(index).prompt = 'Cancel';
uiobj(index).helptip = 'Cancel this configuration and close UI.';
uiobj(index).Callback = 'close(gcf)';

index = index + 1;
uiobj(index).prompt = 'OK';
uiobj(index).Callback = {@okbuttoncb, uiobj, sfnName};
uiobj(index).type = 'pushbutton';
uiobj(index).helptip = 'Confirm this configuration and close UI.';


