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
% 2014-06-18  1.0   first version
%
% 
% ==========================================================================

function flag = FM4_check_user_path(toolchain, settings_path, reuse_flag, error_type)
% error_type:  0. fprintf	1. errordlg     2. nothing 
    flag = 0;
    error_msg = '';
    if strcmp(reuse_flag, 'on')
        switch toolchain
            case 'MDK_ARM'
                % get the path of template flie
                [path, name, ext] = fileparts(settings_path);
                opt_path = fullfile(path, [name '.uvopt']);
                if isempty(settings_path)
                    flag = 1;
                    error_msg = 'The user setting file path is empty!';
                elseif isempty(name)
                    flag = 1;
                    error_msg = 'The user setting file path is not a file!';
                elseif ~strcmp(ext, '.uvproj')
                    flag = 1;
                    error_msg = ['The user setting file ''' name ''' is not an uvproj file!'];
                elseif exist(settings_path, 'file') ~= 2
                    flag = 1;
                    error_msg = ['The user setting file ''' name ext ''' can not be found!'];                    
                elseif exist(opt_path, 'file') ~= 2
                    flag = 1;
                    error_msg = ['The user setting file ''' name ext ''' matched file ''' name '.uvopt'' can not be found!'];
                end
            case 'EWARM'
                % get the path of template flie
                [path, name, ext] = fileparts(settings_path);
                ewd_path = fullfile(path, [name '.ewd']);
                if isempty(settings_path)
                    flag = 1;
                    error_msg = 'The user setting file path is empty!';
                elseif isempty(name)
                    flag = 1;
                    error_msg = 'The user setting file path is not a file!';
                elseif ~strcmp(ext, '.ewp')
                    flag = 1;
                    error_msg = ['The user setting file ''' name ''' is not an ewp file!'];
                elseif exist(settings_path, 'file') ~= 2
                    flag = 1;
                    error_msg = ['The user setting file ''' name ext ''' can not be found!'];
                elseif exist(ewd_path, 'file') ~= 2
                    flag = 1;
                    error_msg = ['The user setting file ''' name ext ''' matched file ''' name '.ewd'' can not be found!'];
                end
            otherwise
        end        
    end
    if ~isempty(error_msg)
        if error_type == 1
            errordlg(error_msg);
        elseif error_type == 0
            fprintf(2, [error_msg '\n']);
        end
    end
end