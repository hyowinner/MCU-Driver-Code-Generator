function uiobj = PCMWR
% This is the config file for generate UI for PCMPWM Data write.
% short for : pcmwr
% This block can be multiple.
sfnName = 'pcmwr';

index = 1;
% first element is the display string. do not store in S-function
uiobj(index).prompt = ['This block configs to write PCM data samples to the PCMPWM module.'];
uiobj(index).headerfile = 's6j3200_PCMPWM.h';
uiobj(index).periname = 'PCMPWM';
uiobj(index).funcpostname = '_Write_%<datregnum>';          % %<> means this is a multiple periblock. It will generate multiple function definition and call.          
uiobj(index).arg = {'uint_io16_t data1'; 'uint_io16_t data0'};          % seperate with ";"
uiobj(index).ret = 'void ';                                 % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Data Register Number';
uiobj(index).tabname = '';
uiobj(index).var = 'datregnum';   
uiobj(index).type = 'popupmenu';                            
uiobj(index).members = cellfun(@num2str, num2cell(0:15)', 'UniformOutput', false); 
uiobj(index).val = '0';   
uiobj(index).codegenstr = cellfun(@num2str, num2cell(0:15)', 'UniformOutput', false);  
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Data Register used to write PCM data samples to the PCMPWM module.';
uiobj(index).regio = 'NoReg';                       % New Added@2016/7/12ÅCIt means no definition when code gen.

index = index + 1;
uiobj(index).prompt = 'Stereo/Mono Mode';
uiobj(index).tabname = '';
uiobj(index).var = 'stereomode';
uiobj(index).type = 'text';                            
uiobj(index).val = 'mono mode';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Gets operation in mono or stereo mode.';
uiobj(index).ButtonDownFcn =  {@requireSameParam,'PCMPWM Init', 'stereomode'};   % for requirement between blocks
% this regio is for next control, for write block, its regio should be with
% non-checkbox and non-popupmenu
uiobj(index).regio = {'PCMPWM0_DATA%<datregnum>_DATA1';'PCMPWM0_DATA%<datregnum>_DATA0'};         % multiple regio, dynamically according to user setting on latest control

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


