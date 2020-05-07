function ret = coderead(periname, ftype, section)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function read source file and transfer to block tlc through ret.
% Then delete the read file.
% periname -- 'CRC'
% ftype -- '_Init'|'_Step'|'_read'
% section -- 'definitin'|'prototype'|'call'
% Hyowinner @2016/6/27
% Modify the way to get temp code stored folder.
% Hyowinner @2016/6/30

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
targetfolder = get_tarfolder();
filename = fullfile(targetfolder, [periname ftype '_' section '_temp.dat']);
if exist(filename, 'file')
    fid = fopen(filename, 'r');
    ret = fread(fid, '*char')';
    fclose(fid);
    %delete(filename);      
else
    error([filename ' does not exist!']);
end


end