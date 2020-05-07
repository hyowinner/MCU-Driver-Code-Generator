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
% 2014-05-29  1.0   first version
% 
% 
% ==========================================================================
function FM4_browser_settings_path(hDlg, hSrc)
% display the user setting path in edit
    default_path = '';
    flag = slConfigUIGetVal(hDlg,hSrc, 't_save_setting');
    toolchain = slConfigUIGetVal(hDlg,hSrc, 't_toolchain');
    if strcmp(flag, 'on') % the checkbox of reuse user setting is on        
        switch toolchain
            case 'MDK_ARM'
                if ispref('FM4_TSP_get_config', 'mdkarm_template_flie')
                    default_path = fileparts(getpref('FM4_TSP_get_config', 'mdkarm_template_flie'));                    
                end
                [name, path] = uigetfile({'*.uvproj'}, 'Choose the template file', default_path);
                if ischar(path) && ischar(name)% user select a *.uvproj file 
                    [~, filename, ext] = fileparts(name);
                    if ~strcmp(ext, '.uvproj')
                        errordlg('The file of user setting is invalid!');
                        return;
                    elseif exist(fullfile(path, [filename '.uvopt']), 'file') ~= 2
                        errordlg(['The user setting file ''' name ''' matched file ''' filename '.uvopt'' can not be found!']);
                        return;
                    end
                    template_file = fullfile(path, name);
                    % set the user setting path to edit
                    slConfigUISetVal(hDlg,hSrc, 't_setting_path', template_file);
                    slConfigUISetEnabled(hDlg,hSrc, 't_setting_path',true);
                end
            case 'EWARM'
                if ispref('FM4_TSP_get_config', 'ewarm_template_flie')
                    default_path = fileparts(getpref('FM4_TSP_get_config', 'ewarm_template_flie'));
                end
                [name, path] = uigetfile({'*.ewp'}, 'Choose the template file', default_path);
                if ischar(path) && ischar(name)% user select a *.ewp file 
                    [~, filename, ext] = fileparts(name);
                    if ~strcmp(ext, '.ewp')
                        errordlg('The file of user setting is invalid!');
                        return;
                    elseif exist(fullfile(path, [filename '.ewd']), 'file') ~= 2
                        errordlg(['The user setting file ''' name ''' matched file ''' filename '.ewd'' can not be found!']);
                        return;
                    end
                    template_file = fullfile(path, name);  
                    % set the user setting path to edit
                    slConfigUISetVal(hDlg,hSrc, 't_setting_path', template_file);
                    slConfigUISetEnabled(hDlg,hSrc, 't_setting_path',true);
                end           
            otherwise                
        end
    else
         switch toolchain
             case 'MDK_ARM'
                 if isempty(slConfigUIGetVal(hDlg,hSrc, 't_instpath'))
                     errordlg('MDK-ARM Keil has not been installed or not registered!');
                 else
                     errordlg('Please check on the reuse user settings!');
                 end
             case 'EWARM'
                 if isempty(slConfigUIGetVal(hDlg,hSrc, 't_instpath'))
                     errordlg('EWARM has not been installed or not registered!');
                 else
                     errordlg('Please check on the reuse user settings!');
                 end
             case 'Do not start IDE'
                 errordlg('No IDE selected so no files should be selected!');
         end
    end
end
