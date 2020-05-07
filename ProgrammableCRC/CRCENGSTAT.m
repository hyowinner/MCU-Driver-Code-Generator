function uiobj = CRCENGSTAT
% This is the config file for generate UI for CRC Engine Status
% short for : crcengstat
sfnName = 'crcengstat';                 % Configfile is the upper of s-function name.

index = 1;
% first element is the display string and function prototype. headerfile and periname are stored in S-function
uiobj(index).prompt = ['Return one bit to indicate CRC engine is ready(0) or busy(1).'];
uiobj(index).headerfile = 's6j3200_PRGCRC.h';
uiobj(index).periname = 'CRC';
uiobj(index).funcpostname = '_EngStat';
uiobj(index).arg = 'void';
uiobj(index).ret = 'unsigned char ';             % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'This block has no tunable parameter.';
uiobj(index).tabname = '';
uiobj(index).var = 'noparam';   % only for no param block
uiobj(index).type = 'text';
uiobj(index).val = 'noparam';   % only for no param block
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'This block has no tunable parameter.';
uiobj(index).regio = 'CRC0_CFG_LOCK';

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


