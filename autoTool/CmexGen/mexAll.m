function mexAll(path)
% This function mex all c-mex s-function to mex file in current path.
% Hyowinner @2016/6/28
% Modify to adapt recursion to find and compile all sub folders for mex files.
% Hyowinner @2016/7/4
files = dir(path);
for ii = 1: length(files)
    if strcmp(files(ii).name, '.')||strcmp(files(ii).name, '..')
        continue;
    end
    if files(ii).isdir
        nextfolder = fullfile(path, files(ii).name);
        mexAll(nextfolder);
    end
    [~, ~, ext] = fileparts(files(ii).name);
    if strcmp(ext, '.c')
        fulname = fullfile(path, files(ii).name);
        cd(path);       % go to each folder to generate mex there.
        mex(fulname);
        fprintf('%s is mexed sucessfully.\n', fulname);
    end
end