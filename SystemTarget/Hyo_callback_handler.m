% ==============================================================================================
%       Hyowinner's Simulink School Cource: Hardware Support Package
%       Development
% ==============================================================================================
%
% Copyright (C) 2016 Hyowinner. All Rights Reserved.
%
% ==========================================================================
%
% History
% Date        Ver   Description
% 2016-6-28   0.1    first version
% 2016-9-02          Set custom file process tlc file;
%                    Do not permit edit template file cgt.
%
% ==========================================================================

function Hyo_callback_handler(hDlg, hSrc)
% This file is the callback function for configuration options when choose Hyo.tlc
% Do not generate sample main.c
slConfigUISetVal(hDlg, hSrc, 'GenerateSampleERTMain', 'off');
slConfigUISetEnabled(hDlg, hSrc, 'GenerateSampleERTMain', false);

% Do not generate makefile
slConfigUISetVal(hDlg, hSrc, 'GenerateMakefile', 'off');                    % maybe on when using PIL toolchain
slConfigUISetEnabled(hDlg, hSrc, 'GenerateMakefile', true);

% Hyo_file_process.tlc not yet defined completely
slConfigUISetVal(hDlg, hSrc, 'ERTCustomFileTemplate', 'example_file_process.tlc');
slConfigUISetEnabled(hDlg, hSrc, 'ERTCustomFileTemplate', true);

% Set Hardware device type
slConfigUISetVal(hDlg, hSrc, 'ProdHWDeviceType','CYPRESS->ARM Cortex-R5');  %choose the self defined target
slConfigUISetEnabled(hDlg, hSrc, 'ProdHWDeviceType', true);

% Emulation hardware option
slConfigUISetVal(hDlg, hSrc, 'ProdEqTarget', 'on');
slConfigUISetEnabled(hDlg, hSrc, 'ProdEqTarget', false);

% Inline parameters to simplify code
slConfigUISetVal(hDlg, hSrc, 'InlineParams', 'on');                         %Inline Parameters on
slConfigUISetEnabled(hDlg, hSrc, 'InlineParams', false);

% generate code only nowdays modified after toolchain developped
slConfigUISetVal(hDlg, hSrc, 'GenCodeOnly', 'on');                          %only generate code
slConfigUISetEnabled(hDlg, hSrc, 'GenCodeOnly' , false);

% Fixed step is necessary
slConfigUISetVal(hDlg, hSrc, 'SolverType', 'Fixed-step');
slConfigUISetEnabled(hDlg, hSrc, 'SolverType', false);

% choose disctete fixed step
slConfigUISetVal(hDlg, hSrc, 'Solver', 'FixedStepDiscrete');
slConfigUISetEnabled(hDlg, hSrc, 'Solver', true);

% fixed step can be configged by user
slConfigUISetVal(hDlg, hSrc, 'FixedStep' , '1e-3');
slConfigUISetEnabled(hDlg, hSrc, 'FixedStep', true);

% generate report after code generation
slConfigUISetVal(hDlg, hSrc, 'GenerateReport' ,'on');
slConfigUISetEnabled(hDlg, hSrc, 'GenerateReport', true);

% report automatically lauched
slConfigUISetVal(hDlg, hSrc, 'LaunchReport', 'on');
slConfigUISetEnabled(hDlg, hSrc, 'LaunchReport' ,true);

% enable hyperlink: code to model
slConfigUISetVal(hDlg, hSrc, 'IncludeHyperlinkInReport', 'on');
slConfigUISetEnabled(hDlg, hSrc, 'IncludeHyperlinkInReport', true);

% make command option
slConfigUISetVal(hDlg, hSrc, 'MakeCommand', 'off');
%slconfigUISetEnabled(hDlg, hSrc, 'MakeCommand', true);

% do not need first time ,set ERTFirstTimeCompliant on
slConfigUISetVal(hDlg, hSrc, 'ERTFirstTimeCompliant', 'on');
slConfigUISetEnabled(hDlg, hSrc, 'ERTFirstTimeCompliant', true);

% exclude terminate funciton
slConfigUISetVal(hDlg, hSrc, 'IncludeMdlTerminateFcn','off')
slConfigUISetEnabled(hDlg, hSrc, 'IncludeMdlTerminateFcn', true);

% set code template file
slConfigUISetVal(hDlg, hSrc, 'ERTSrcFileBannerTemplate', 'Hyo_code_template.cgt');
slConfigUISetEnabled(hDlg, hSrc, 'ERTSrcFileBannerTemplate', false);

slConfigUISetVal(hDlg, hSrc, 'ERTHdrFileBannerTemplate', 'Hyo_code_template.cgt');
slConfigUISetEnabled(hDlg, hSrc, 'ERTHdrFileBannerTemplate', false);

slConfigUISetVal(hDlg, hSrc, 'ERTDataSrcFileTemplate', 'Hyo_code_template.cgt');
slConfigUISetEnabled(hDlg, hSrc, 'ERTHdrFileBannerTemplate', false);

slConfigUISetVal(hDlg, hSrc, 'ERTDataHdrFileTemplate', 'Hyo_code_template.cgt');
slConfigUISetEnabled(hDlg, hSrc, 'ERTHdrFileBannerTemplate', false);

% set custom file processing tlc file
slConfigUISetVal(hDlg, hSrc, 'ERTCustomFileTemplate', 'Hyo_file_process.tlc');
slConfigUISetEnabled(hDlg, hSrc, 'ERTHdrFileBannerTemplate', false);
% set Custom tlc varialbe
%     slConfigUISetVal(hDlg, hSrc, 't_instpath', 'User do not want to start toolchain');
%     slConfigUISetEnabled(hDlg,hSrc, 't_save_setting',false);
%     slConfigUISetVal(hDlg,hSrc, 't_save_setting', 'off');
%     slConfigUISetEnabled(hDlg,hSrc, 't_setting_path',false);
%     slConfigUISetVal(hDlg, hSrc, 't_setting_path', '');
%
% set the Replace data type names in the generated code
slConfigUISetVal(hDlg,hSrc, 'EnableUserReplacementTypes', 'on');
struc = slConfigUIGetVal(hDlg,hSrc, 'ReplacementTypes');
% typedef, replace Simulink Coder datatype with s6j3200io_basetypes
struc.uint32 = 'uint_io32_t';
struc.uint16 = 'uint_io16_t';
struc.uint8 = 'uint_io8_t';
slConfigUISetVal(hDlg,hSrc, 'ReplacementTypes',struc);
% Define Repalcement data type
Hyo_customization();
% set callback function for PreloadFcn, when opening a model
% FM4_customization will be executed
set_param(bdroot(gcs), 'PreloadFcn','Hyo_customization');
end