function tlcGen(sfcname, create_time, ftype, periname, section1, section2, section3, mode)
% This function generate block tlc file automatically
% mode -- initReg|fromReg|toReg
% Hyowinner @2016/6/30
% eg. tlcGen('crcwr', now, '_Write', 'CRC', 'definition', 'prototype', 'include', 'toReg')
if strcmp(mode, 'initReg')
    template = 'templateTLC_init.tlc';
elseif strcmp(mode, 'fromReg')
    template = 'templateTLC_in.tlc';
elseif strcmp(mode, 'toReg')
    template = 'templateTLC_out.tlc';
else
    error('Error: Unsupport mode!');
end
fid = fopen(template, 'r');
tlccont = fread(fid, '*char')';
fclose(fid);
tlccont = regexprep(tlccont, '%<sfcname>', sfcname);
tlccont = regexprep(tlccont, '%<create_time>', datestr(create_time, 'yyyy/mm/dd'));
tlccont = regexprep(tlccont, '%<ftype>', ftype);
tlccont = regexprep(tlccont, '%<periname>', periname);
tlccont = regexprep(tlccont, '%<section1>', section1);
tlccont = regexprep(tlccont, '%<section2>', section2);
tlccont = regexprep(tlccont, '%<section3>', section3);
fid = fopen([sfcname,'.tlc'], 'w');
fprintf(fid, '%s\n', tlccont);
fclose(fid);
disp([sfcname '.tlc generated sucessfully!']);
end



