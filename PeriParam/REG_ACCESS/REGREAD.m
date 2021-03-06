function uiobj = REGREAD(varargin)
% This is the config file for generate UI for Register read block
% short for : regread
% Updated @2016/7/14
% Update members get methods for "peri" and "reg". @2016/7/15
sfnName = 'regread';
% when called by make_hook, blockhanlde argument is a must;
% when called by block OpenFcn, blockhandle is gcbh. @2016/7/16
if nargin > 0
    blockhandle = varargin{1};
else
    blockhandle = gcbh;
end
index = 1;
% first element is the display string. headerfile, periname, funcpostname
% are stored in g_pv of S-function block.
uiobj(index).prompt = 'The block supplies user the function of using the value reading from specified register bit(s).';
uiobj(index).headerfile = 's6j3200io.h';
uiobj(index).periname = 'REGISTER';              
uiobj(index).funcpostname = '_Read_%<reg>';
uiobj(index).arg = 'void';
uiobj(index).ret = '%<invisiblecontrol> ';                                          % with a blank after, need to be updated by "reg" after it is selected.
% from second element control begins

index = index + 1;
peris = search_peri();
uiobj(index).prompt = 'Peripheral';
uiobj(index).tabname = '';
uiobj(index).var = 'peri';
uiobj(index).type = 'popupmenu';
uiobj(index).members = peris;       
uiobj(index).val = get_param_pv(blockhandle, 'peri');                              % get S-Function stored value to set it in UI.
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                    
uiobj(index).Callback = {@peri_cb, 'reg'};
uiobj(index).helptip = 'Select the Peripheral need to access.';  

index = index + 1;
uiobj(index).prompt = 'Register';
uiobj(index).tabname = '';
uiobj(index).var = 'reg';   
uiobj(index).type = 'popupmenu';
% [regs, ~] = search_peri_reg(get_param_pv(gcbh, 'peri'));
[regs, ~] = search_peri_reg(uiobj(index - 1).val); 
uiobj(index).members = regs;
uiobj(index).val = get_param_pv(blockhandle, 'reg');        % It will be updated by selecting popup. gcbh will be a bug source. Because when build, gcbh only be one block that will not be switched.
uiobj(index).codegenstr = '';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {@reg_cb, 'peri', uiobj, 'invisiblecontrol'};
uiobj(index).helptip = 'Select the target register you want to access.';   
uiobj(index).regio = '%<reg>';                      % Register fullname

index = index + 1;
uiobj(index).prompt = 'DataType';
uiobj(index).tabname = '';
uiobj(index).var = 'invisiblecontrol';   
uiobj(index).type = 'text';
[~, dtlen] = search_peri_reg(get_param_pv(blockhandle, 'peri'));
uiobj(index).val = dtlen;                                                   % It will be supplied value for uiobj(1).ret to replace.
uiobj(index).helptip = 'Indicate the datatype of register that user selected.';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';   

index = index + 1;
uiobj(index).prompt = 'Cancel';
uiobj(index).helptip = 'Cancel this configuration and close UI.';
uiobj(index).Callback = 'close(gcf)';

index = index + 1;
uiobj(index).prompt = 'OK';
uiobj(index).Callback = {@okbuttoncb, uiobj, sfnName};
uiobj(index).type = 'pushbutton';
uiobj(index).helptip = 'OK this configuration and close UI.';

function peri_cb(hdl, ~, targettag)
% This function is the cb of "peri"
parent = get(hdl, 'Parent');
tarobj = findobj(parent, 'tag', targettag);
peristrs = get(hdl, 'String');
val = get(hdl, 'Value');
periname = peristrs{val};
[regs, ~] = search_peri_reg(periname);
set(tarobj, 'String', regs);
set(tarobj, 'Value', 1);
set(tarobj, 'Enable', 'on');

function reg_cb(hdl, ~, targettag, uiobj, targettag2)
% This function is the cb of "reg"
regidx = get(hdl, 'Value');
parent = get(hdl, 'Parent');
tarobj = findobj(parent, 'tag', targettag);
tarobj2 = findobj(parent, 'tag', targettag2);
peristrs = get(tarobj, 'String');
val = get(tarobj, 'Value');
periname = peristrs{val};
% Update the ret data type for code gen.
[~, len] = search_peri_reg(periname);
accesslen = str2double(cell2mat(len(regidx)));              % transform from cell{char} to double
if accesslen <= 1
    rettype = 'unsigned char ';
elseif accesslen <= 8
    rettype = 'uint_io8_t ';
elseif accesslen <=16
    rettype = 'uint_io16_t ';
elseif accesslen <= 32
    rettype = 'uint_io32_t ';
else
    error('Error: Unexpected data length!');
end
% Update ret datatype that function generated.
set(tarobj2, 'String', rettype);
% Update uiobj(1) by reg control selection callback
uiobj(1).ret = rettype;
uiobj(1).periname = periname;
uiobj(1).headerfile = ['S6J3200_' periname '.h'];
