function uiobj = PRGCRC
% This is the config file for generate UI for programmableCRC
% and it also serves to generate driver code section.
% short for : prgcrc
sfnName = 'prgcrc';                         % must be the upper of file name

index = 1;
% first element is the display string. do not store in S-function
% first element also define the io register header file and peripheral name for code generation
uiobj(index).prompt = ['The Programmable CRC is a software configurable module.',...
    ' It will generate code according to configuration here. ',...
    'Following standard are support: CRC-32-IEEE-802.3/CRC-16-CCITT/CRC-8-CCITT/',...
    'CRC-5-USB/CRC-XMODEM/12-bit CRC/10-bit CRC/8-bit CRC '];
uiobj(index).headerfile = 's6j3200_PRGCRC.h';
uiobj(index).periname = 'CRC';
uiobj(index).funcpostname = '_Init';
uiobj(index).arg = 'void';
uiobj(index).ret = 'void ';                 % with a blank after
% from second element control begins
index = index + 1;
uiobj(index).prompt = 'polynomial value(Hex)';
uiobj(index).tabname = '';
uiobj(index).var = 'polyval';               % obj.var used to save value in S-function, lower spelling
uiobj(index).type = 'Edit';
% uiobj(index).members ={'a','b','c'};      % members are only for popup, must be cell 
uiobj(index).val = '0x04C11DB7';            % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'The CRC Polynomial Register (CRCn_POLY) defines the polynomial value for the CRC checksum calculation.';
uiobj(index).regio = 'CRC0_POLY';

index = index + 1;
uiobj(index).prompt = 'CRC Seed(Hex)';
uiobj(index).tabname = '';
uiobj(index).var = 'crcseed';
uiobj(index).type = 'Edit';
uiobj(index).val = '0xFFFFFFFF';            % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'The CRC Seed Register (CRCn_SEED) defines the initial value for the CRC checksum calculation.';
uiobj(index).regio = 'CRC0_SEED';

index = index + 1;
uiobj(index).prompt = 'XOR Data(Hex)';
uiobj(index).tabname = '';
uiobj(index).var = 'xordata';
uiobj(index).type = 'Edit';
uiobj(index).val = '0xFFFFFFFF';            % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'The CRC Final XOR register (CRCn_FXOR) contains the values to be XOR¡¯ed with the preliminary checksum to finalize the CRC calculation';
uiobj(index).regio = 'CRC0_FXOR';

index = index + 1;
uiobj(index).prompt = 'Enable DMA Request';
uiobj(index).tabname = '';
uiobj(index).var = 'endma';
uiobj(index).type = 'Checkbox';
uiobj(index).val = 'off';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Check on this checkbox to enable DMA Request';
uiobj(index).regio = 'CRC0_CFG_CDEN';

index = index + 1;
uiobj(index).prompt = 'Enable CRC Interrupt';
uiobj(index).tabname = '';
uiobj(index).var = 'encrcint';
uiobj(index).type = 'Checkbox';
uiobj(index).val = 'off';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Check on this checkbox to enable CRC Interrupt';
uiobj(index).regio = 'CRC0_CFG_CIEN';

index = index + 1;
uiobj(index).prompt = 'Input Data Size';
uiobj(index).tabname = '';
uiobj(index).var = 'indatasize';
uiobj(index).type = 'popupmenu';
uiobj(index).members ={'8_bit';'16_bit';'24_bit';'32_bit'}; 
uiobj(index).val = '32_bit';   % default value
uiobj(index).codegenstr = cellfun(@num2str, num2cell(1:4)', 'UniformOutput', false);%{'1';'2';'3';'4'};                % only popupmenu has codegenstr field
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Configure the input data size.';
uiobj(index).regio = 'CRC0_CFG_SZ';

index = index + 1;
uiobj(index).prompt = 'Checksum length(degree)';
uiobj(index).tabname = '';
uiobj(index).var = 'chklen';
uiobj(index).type = 'popupmenu';
uiobj(index).members = cellfun(@num2str, num2cell(32:-1:2')', 'UniformOutput', false); %cell2mat(num2cell([32:-1:2])); 
uiobj(index).val = '32';   % default value
uiobj(index).codegenstr = cellfun(@num2str, num2cell(32:-1:2')', 'UniformOutput', false);
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'configure the length (degree) of CRC polynomial/checksum.';
uiobj(index).regio = 'CRC0_CFG_LEN';

index = index + 1;
uiobj(index).prompt = 'Enable Input Bit Reflection';
uiobj(index).tabname = '';
uiobj(index).var = 'eninbits';                          % var can not be the same with other controls
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Disable/Enable input byte reflection (swapping).';
uiobj(index).regio = 'CRC0_CFG_RIBIT';

index = index + 1;
uiobj(index).prompt = 'Enable Input Byte Reflection';
uiobj(index).tabname = '';
uiobj(index).var = 'eninbytes';
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Disable/Enable input byte reflection (swapping).';
uiobj(index).regio = 'CRC0_CFG_RIBYT';

index = index + 1;
uiobj(index).prompt = 'Enable Output Bit Reflection';
uiobj(index).tabname = '';
uiobj(index).var = 'enoutbits';
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Disable/Enable Output Bits.';
uiobj(index).regio = 'CRC0_CFG_ROBIT';

index = index + 1;
uiobj(index).prompt = 'Enable Output Byte Reflection';
uiobj(index).tabname = '';
uiobj(index).var = 'enoutbytes';
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';   % default value
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Disable/Enable output byte reflection (swapping).';
uiobj(index).regio = 'CRC0_CFG_ROBYT';

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


