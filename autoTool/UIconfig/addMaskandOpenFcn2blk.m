function tspBlockCreate(blkhdl, titlename, sfcnname)
% eg. addMaskandOpenFcn2blk(gcbh, 'CRC Write')
% configfile can be got by S-Function
% Hyowinner @2016/6/28
% Add block size config and FunctionName/Parameter list automatically input
% Hyowinner @2016/7/4
% Integrate Compile mex file generate and TLC generate into this function
% Rename to tspBlockCreate
% Hyowinner @2016/7/11
maskObj = Simulink.Mask.get(blkhdl);
if ~isempty(maskObj)
    maskObj.delete;                             % Before mask, make sure it is non-masked.
end
maskObj = Simulink.Mask.create(blkhdl);
maskObj.addParameter('Type','edit','Name','g_pv','Value','0','Evaluate','off');

% openfcn(gcbh, eval(upper(get_param(gcbh, 'FunctionName'))), 'CRC Engine Status');
set_param(blkhdl, 'OpenFcn', ['openfcn(gcbh, eval(upper(get_param(gcbh, ''FunctionName''))),  ''' titlename ''');']);

% set position of the blkhdl length:125 width:70
pos = get_param(blkhdl, 'Position');
set_param(blkhdl, 'Position', [pos(1) pos(2) pos(1) + 125 pos(2) + 70]);

% Compile mex for S-function
SFcnGen(blkhdl, sfcnname, true);
tlcGen('crcwr', now, '_Write', 'CRC', 'definition', 'prototype', 'include', 'toReg')

% set FunctionName and Parameter g_pv
% set g_pv into SFcn block
set_param(blkhdl, 'Parameters', 'g_pv', 'FunctionName', sfcnname);