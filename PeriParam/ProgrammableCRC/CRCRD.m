function uiobj = CRCRD
% This is the config file for generate UI for CRCread
% short for : crcrd
sfnName = 'crcrd';

index = 1;
% first element is the display string|headerfile|periname|funcpostname|arg|ret. 
uiobj(index).prompt = ['The CRC Read block outputs the result (final checksum) of the CRC calculation after post-processing'];
uiobj(index).headerfile = 's6j3200_PRGCRC.h';
uiobj(index).periname = 'CRC';
uiobj(index).funcpostname = '_Read_len%<chklen>';
uiobj(index).arg = 'void';
uiobj(index).ret = 'uint_io32_t ';                                         % with a white_space after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Checksum length(degree)';
uiobj(index).tabname = '';
uiobj(index).var = 'chklen';
uiobj(index).type = 'text'; 
uiobj(index).val = '32';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'indicate the length (degree) of CRC polynomial/checksum.';
uiobj(index).ButtonDownFcn =  {@requireSameParam,'ProgrammableCRC Init', 'chklen'};   % for requirement between blocks
%%%% regio has to be hanged in valid obj
uiobj(index).regio = 'CRC0_RD';

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


