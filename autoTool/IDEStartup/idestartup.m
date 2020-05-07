function idestartup(idename)
% This function start ide installed in windows PC.
% idename means the identifier that can indicate the IDE. For example,
% "ghs" means Green Hills multi.
% This program searches mprojmgr.exe in a specified path under each root disk.
% if existed then startup it in windows way.
% 2016/9/2
switch idename
    case 'ghs'
        specified_path = ':\ghs\multi_614\mprojmgr.exe';   
    otherwise
        error('[IDE Startup]: Not support IDE type!');    
end
rootdisk = char(65:90);     % Disk name array [A:Z]
for ii = 1:length(rootdisk)
    target_path = strcat(rootdisk(ii), specified_path);
    if exist(target_path, 'file')   % ~= 0
        winopen(target_path);
        disp(['[IDE Startup]: ' target_path ' is being started up.']);
    end
end
end