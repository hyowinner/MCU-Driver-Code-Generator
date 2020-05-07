function uiobj = RTCUPDATE
% This is the config file for generate UI for RTC UPDATE HH/MM/SS value.
% short for : rtcupdate
% This block can be multiple called but have the unique definition.
sfnName = 'rtcupdate';

index = 1;
% first element is the display string.  pername|headerfile|funcpostname
% will be stored in S-Function block.
uiobj(index).prompt = ['This block set the Second/Minute/Hour register values are written to the Second/Minute/Hour counters respectively.'];
uiobj(index).headerfile = 's6j3200_RTC.h';
uiobj(index).periname = 'RTC';
uiobj(index).funcpostname = '_Update';                   
uiobj(index).arg = 'void';                                  % seperate with ";" if multiple argument
uiobj(index).ret = 'void ';                                 % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Update the Hour/Minute/Second counters.';
uiobj(index).tabname = '';
uiobj(index).var = 'noparam';   
uiobj(index).type = 'Popupmenu';   
uiobj(index).members = {'Update'};    
uiobj(index).val = {'Update'};
uiobj(index).codegenstr = {'1'}; 
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'used to update the time value.';
uiobj(index).regio = 'RTC_WTCR_UPDT';


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


