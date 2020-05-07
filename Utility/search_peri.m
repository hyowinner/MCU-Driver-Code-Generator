function perinames = search_peri
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function identify all peripheral name from regheader folder.
% return list
% perinames -- all peripheral names drawn from the header file.
% Hyowinner @2016/7/14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curfile = mfilename('fullpath');
pos = strfind(curfile, filesep);
targetfolder = fullfile(curfile(1:pos(end - 1)), 'regheader', 's6j3200');
filelist = dir(targetfolder);
perinames = cell(1, length(filelist));
for ii = 1:length(filelist)
    if (~filelist(ii).isdir)&&(~ismember(filelist(ii).name, {'s6j3200io'}))
        perinames{ii} = regexprep(filelist(ii).name, 's6j3200_|\.h', '');
        % add one process to replace s6j3200io
        if ~isempty(regexp(perinames{ii}, 's6j3200io','match'))
            perinames{ii} = '';
        end
    end
end
% delete those are empty cells
perinames(cellfun('isempty', perinames)) = '';

