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
% 2016-6-29          add model storing path check, make sure model store and code generated
% files are stored in demo.
% 2016-7-6           modify the third argument of "codesecgen"
% 2016-7-16          Add branch for REGREAD|REGWRITE block, they need
% argument of blockhandle.
% 2016-9-2    0.2    Add IDE startup function in "after_tlc" stage.
%
% ==========================================================================

function Hyo_make_rtw_hook(hookMethod, modelName, rtwroot, templateMakefile, buildOpts, buildArgs)
% this file is the hook file to do the extra operation for code generation
% at diffrent stage

switch hookMethod
    case 'error'
        % Only trigger by error
    case 'entry'
        % check model save and codegen path right or not
        [modelpath, ~, ~] = fileparts(which(modelName));
        if isempty(strfind(modelpath, [filesep 'HyoCG' filesep 'demo']))&&~isempty(modelpath)
            error('Entry Error: Path Forbidden! Please store your model in path "..\HyoCG\demo"');
        end
        
    case 'before_tlc'
        blkhdls = findPSLblk(modelName);
        if isempty(blkhdls)
            error('Error: No S6J3200 Peipheral blocks are found!');
        end
        for ii = 1:length(blkhdls)
            configfilename = upper(get_param(blkhdls(ii), 'FunctionName'));
            % REGREAD|REGWRITE need argument of blockhandle as
            % input to their configure file. 
            if strcmp(configfilename, 'REGREAD')||strcmp(configfilename, 'REGWRITE')
                configfile = eval([configfilename, '(blkhdls(ii))']);
            else
                configfile = eval(configfilename);               
            end
            % generate code section to currentpath\tempcode folder, not
            % implemented.  
            codesecgen(blkhdls(ii), configfile, repvar(blkhdls(ii), configfile(1).funcpostname), 'include', configfile(1).arg, configfile(1).ret);
            codesecgen(blkhdls(ii), configfile, repvar(blkhdls(ii), configfile(1).funcpostname), 'prototype', configfile(1).arg, configfile(1).ret);
            codesecgen(blkhdls(ii), configfile, repvar(blkhdls(ii), configfile(1).funcpostname), 'definition', configfile(1).arg, configfile(1).ret);
            codesecgen(blkhdls(ii), configfile, repvar(blkhdls(ii), configfile(1).funcpostname), 'call',  configfile(1).arg, configfile(1).ret);
        end
        
    case 'after_tlc'
        % disp('### This stage is after_tlc!');
        try
            idestartup_val = get_param(gcs, 't_idestartup');
        catch
            error('[Error] Please select "Hyo.tlc" for system file!');
        end
        if strcmp(idestartup_val, 'on')
           idestartup('ghs');           % if user selected ide startup. 
        end
    case 'before_make'
        % disp('### This stage is before_make');
        
    case 'after_make'
        % disp('### This stage is after_make');
    case 'exit'
        targetfolder = get_tarfolder();
        rmdir(targetfolder, 's');
        % modified 2016/7/9
        disp('### Building done!');
      
end
