function uiobj = CRCWR
% This is the config file for generate UI for programmableCRC
% short for : crcwrite
sfnName = 'crcwr';

index = 1;
% first element is the display string. do not store in S-function
uiobj(index).prompt = ['Input data size. Please right-click "Input Data Size" to update input data size according to programmableCRC.'];
uiobj(index).headerfile = 's6j3200_PRGCRC.h';
uiobj(index).periname = 'CRC';
uiobj(index).funcpostname = '_Write_%<indatasize>';
uiobj(index).arg = 'uint_io32_t data';
uiobj(index).ret = 'void ';             % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Input Data Size';
uiobj(index).tabname = '';
uiobj(index).var = 'indatasize';   
uiobj(index).type = 'text';                 %togglebutton does not trigger callback while pushed
uiobj(index).val = '32-bit';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Configure the input data size.';
uiobj(index).ButtonDownFcn =  {@requireSameParam,'ProgrammableCRC Init', 'indatasize'};   % for requirement between blocks
%%%% regio has to be hanged in valid obj
uiobj(index).regio = 'CRC0_WR';

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


