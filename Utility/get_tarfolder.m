function targetfolder = get_tarfolder()
% This function create tempcode folder in specified path.
% Hyowinner @2016/6/30
pathstr = which(mfilename);
filesepvec = strfind(pathstr, filesep);
targetfolder = fullfile(pathstr(1:filesepvec(end - 1)), 'demo', 'tempcode');
if ~exist(targetfolder, 'dir')
    mkdir(targetfolder);
    disp(['### Create folder ' targetfolder ' to store temp code.']);
end
end