% ==============================================================================================
%                               TSP Project for FM4 Family 
% ==============================================================================================
% 
% Copyright (C) 2013 Spansion LLC. All Rights Reserved. 
% 
% This software is owned and published by: 
% Spansion LLC, 915 DeGuigne Dr. Sunnyvale, CA  94088-3453 ("Spansion").
% 
% BY DOWNLOADING, INSTALLING OR USING THIS SOFTWARE, YOU AGREE TO BE BOUND 
% BY ALL THE TERMS AND CONDITIONS OF THIS AGREEMENT.
% 
% This software contains source code for use with Spansion 
% components. This software is licensed by Spansion to be adapted only 
% for use in systems utilizing Spansion components. Spansion shall not be 
% responsible for misuse or illegal use of this software for devices not 
% supported herein.  Spansion is providing this software "AS IS" and will 
% not be responsible for issues arising from incorrect user implementation 
% of the software.  
% 
% SPANSION MAKES NO WARRANTY, EXPRESS OR IMPLIED, ARISING BY LAW OR OTHERWISE,
% REGARDING THE SOFTWARE (INCLUDING ANY ACOOMPANYING WRITTEN MATERIALS), 
% ITS PERFORMANCE OR SUITABILITY FOR YOUR INTENDED USE, INCLUDING, 
% WITHOUT LIMITATION, THE IMPLIED WARRANTY OF MERCHANTABILITY, THE IMPLIED 
% WARRANTY OF FITNESS FOR A PARTICULAR PURPOSE OR USE, AND THE IMPLIED 
% WARRANTY OF NONINFRINGEMENT.  
% SPANSION SHALL HAVE NO LIABILITY (WHETHER IN CONTRACT, WARRANTY, TORT, 
% NEGLIGENCE OR OTHERWISE) FOR ANY DAMAGES WHATSOEVER (INCLUDING, WITHOUT 
% LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, 
% LOSS OF BUSINESS INFORMATION, OR OTHER PECUNIARY LOSS) ARISING FROM USE OR 
% INABILITY TO USE THE SOFTWARE, INCLUDING, WITHOUT LIMITATION, ANY DIRECT, 
% INDIRECT, INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES OR LOSS OF DATA, 
% SAVINGS OR PROFITS, 
% EVEN IF SPANSION HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. 
% YOU ASSUME ALL RESPONSIBILITIES FOR SELECTION OF THE SOFTWARE TO ACHIEVE YOUR
% INTENDED RESULTS, AND FOR THE INSTALLATION OF, USE OF, AND RESULTS OBTAINED 
% FROM, THE SOFTWARE.  
% 
% This software may be replicated in part or whole for the licensed use, 
% with the restriction that this Disclaimer and Copyright notice must be 
% included with each copy of this software, whether used in part or whole, 
% at all times.                                                                                         
%                                                                                                                                                    
% ==========================================================================
%  
% History
% Date        Ver   Description
% 2013-12-18  0.1   first version (alpha release)
% 2014-03-14  1.0   first website version
% 2014-05-22  1.1   add function of restoring preference for each IDE
% 
% ==========================================================================

function FM4_get_IDE_path(hDlg, hSrc)
% This function is the callback of ToolChain popupmenu.
% When one kind of IDE is selected, the path of it will
% be displayed on FM4 options tab automatically.
% get the OS info of user's PC and give warning info if it is not win32.
% archstr = computer('arch');
% if ~strcmp(archstr, 'win32')
%     disp('Your PC is not using a Windows 32bit OS, maybe IDE installed path can not be detected rightly.');
% end

% get the toolchain user selected and find its install path
archstr = computer('arch');
IDEname = slConfigUIGetVal(hDlg,hSrc, 't_toolchain');
slConfigUISetEnabled(hDlg,hSrc, 't_save_setting',true);
set_user_setting_path(hDlg, hSrc, IDEname);
switch IDEname
    case 'MDK_ARM'      
        if strcmp(archstr, 'win32')
            try
                IDEpath = winqueryreg('HKEY_LOCAL_MACHINE','SOFTWARE\Keil\Products\MDK', 'Path');
            catch
                IDEpath = '';
                warndlg('MDK-ARM Keil has not been installed or not registered!');
                disable_user_setting(hDlg, hSrc, 0);
            end
        elseif strcmp(archstr, 'win64')
            try
                IDEpath = winqueryreg('HKEY_LOCAL_MACHINE','SOFTWARE\Wow6432Node\Keil\Products\MDK', 'Path');
            catch
                IDEpath = '';
                warndlg('MDK-ARM Keil has not been installed or not registered!');
                disable_user_setting(hDlg, hSrc, 0);
            end            
        end        
    case 'EWARM'
        if strcmp(archstr, 'win32')
            try
                IDEpath = winqueryreg('HKEY_LOCAL_MACHINE','SOFTWARE\IAR Systems\Embedded Workbench\5.0', 'LastInstallPath');
            catch
                IDEpath = '';
                warndlg('EWARM has not been installed or not registered!');
                disable_user_setting(hDlg, hSrc, 0);
            end
        elseif strcmp(archstr, 'win64')
            try
                IDEpath = winqueryreg('HKEY_LOCAL_MACHINE','SOFTWARE\Wow6432Node\IAR Systems\Embedded Workbench\5.0', 'LastInstallPath');
            catch
                IDEpath = '';
                warndlg('EWARM has not been installed or not registered!');
                disable_user_setting(hDlg, hSrc, 0);
            end
        end
        %warndlg('EWARM IAR is not supported yet!');
    case 'Do not start IDE'
        IDEpath = 'User do not want to start toolchain';
        slConfigUISetEnabled(hDlg,hSrc, 't_save_setting',false);
    otherwise
        IDEpath = ('Unknown toolchain selected!');
        warndlg('Unknown toolchain selected!');
        slConfigUISetEnabled(hDlg,hSrc, 't_save_setting',false);
end
% set the IDEpath found onto the FM4 option tab.
slConfigUISetVal(hDlg, hSrc, 't_instpath', IDEpath);
end

function set_user_setting_path(hDlg, hSrc, IDEname)
% set the user setting path in edit when user choose the IDE
    switch IDEname
        case 'MDK_ARM'
            if ispref('FM4_TSP_get_config', 'mdkarm_template_setting')
                save_setting = getpref('FM4_TSP_get_config', 'mdkarm_template_setting');
            else
                save_setting = 'off';
            end            
            if strcmp(save_setting, 'on') && ispref('FM4_TSP_get_config', 'mdkarm_template_flie')
                % the MDK_ARM preference is created
                template_flie_proj = getpref('FM4_TSP_get_config', 'mdkarm_template_flie');
                [template_path, template_flie, ~] = fileparts(template_flie_proj);
                template_flie_opt = fullfile(template_path, [template_flie '.uvopt']);
                if exist(template_flie_proj, 'file') == 2 && exist(template_flie_opt, 'file') == 2
                    slConfigUISetVal(hDlg,hSrc, 't_save_setting', 'on');
                    slConfigUISetEnabled(hDlg,hSrc, 't_setting_path',true);
                    slConfigUISetVal(hDlg,hSrc, 't_setting_path', template_flie_proj);
                else
                    disable_user_setting(hDlg, hSrc);
                end
            else
                disable_user_setting(hDlg, hSrc);
            end 
        case 'EWARM'
            if ispref('FM4_TSP_get_config', 'ewarm_template_setting')
                save_setting = getpref('FM4_TSP_get_config', 'ewarm_template_setting');
            else
                save_setting = 'off';
            end            
            if strcmp(save_setting, 'on') && ispref('FM4_TSP_get_config', 'ewarm_template_flie')
                % the MDK_ARM preference is crearted
                template_flie_ewp = getpref('FM4_TSP_get_config', 'ewarm_template_flie');
                [template_path, template_flie, ~] = fileparts(template_flie_ewp);
                template_flie_ewd = fullfile(template_path, [template_flie '.ewd']);
                if exist(template_flie_ewp, 'file') == 2 && exist(template_flie_ewd, 'file') == 2
                    slConfigUISetVal(hDlg,hSrc, 't_save_setting', 'on');
                    slConfigUISetEnabled(hDlg,hSrc, 't_setting_path',true);
                    slConfigUISetVal(hDlg,hSrc, 't_setting_path', template_flie_ewp);
                else
                    disable_user_setting(hDlg, hSrc);
                end
            else
                disable_user_setting(hDlg, hSrc);
            end
        otherwise
            disable_user_setting(hDlg, hSrc);
    end
end

function disable_user_setting(hDlg, hSrc, ~)
% set the user setting path with none and disable
    if nargin > 2
        slConfigUISetEnabled(hDlg,hSrc, 't_save_setting',false);
    end
    slConfigUISetVal(hDlg,hSrc, 't_save_setting', 'off');
    slConfigUISetEnabled(hDlg,hSrc, 't_setting_path',false);
    slConfigUISetVal(hDlg, hSrc, 't_setting_path', '');
end
