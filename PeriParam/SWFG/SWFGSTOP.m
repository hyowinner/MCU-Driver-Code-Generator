function uiobj = SWFGSTOP
% This is the config file for generate UI for SWFG Start sound source generation.
% short for : swfgstart
% This block can be multiple.
sfnName = 'swfgstop';

index = 1;
% first element is the display string.  pername|headerfile|funcpostname
% will be stored in S-Function block.
uiobj(index).prompt = ['This block configs to stop sound source generation.' char(10) '- Sound source generation stopped can be resumed by performing startup control on the same bit(WGCHEN).'];
uiobj(index).headerfile = 's6j3200_SWFG.h';
uiobj(index).periname = 'SWFG';
uiobj(index).funcpostname = '_Ch%<ch>_Stop';                % %<> means this is a multiple periblock. It will generate multiple function definition and call.               
uiobj(index).arg = 'void';                                  % seperate with ";" if multiple argument
uiobj(index).ret = 'void ';                                 % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Channel select';
uiobj(index).tabname = '';
uiobj(index).var = 'ch';   
uiobj(index).type = 'popupmenu';                            
uiobj(index).members = {'0';'1';'2';'3';'4'}; 
uiobj(index).val = '0';   
uiobj(index).codegenstr = {'1';'1';'1';'1';'1'};            % Generate 1 no matter which channel is selected.  
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'used to select channel to stop sound source generation. It can be resumed by performing startup control on the same bit';
uiobj(index).regio = 'SWFG_WGCHEN_CH%<ch>EN';

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


