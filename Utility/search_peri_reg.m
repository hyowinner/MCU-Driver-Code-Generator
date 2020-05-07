function [regs, acslen] = search_peri_reg(periname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function identify all registers' macro from regheader file that
% selected by periname.
% periname must be upper capital -- DMA, RTC, CRC, LCDC .eg
% return list
% reg -- all registers macro drawn from the header file.
% acslen -- access length of corresponding register
% Temp var list
% comps{ii}(2) -- register macros split from header file
% comps{ii}(3) -- struct field access split from header file
% Hyowinner @2016/7/14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = ['s6j3200_' periname '.h'];
fid = fopen(filename, 'r');
assert(fid ~= -1, ['Error: file ' filename ' can not be opened!']);
fcont = fread(fid, '*char')';
fclose(fid);
macros = regexp(fcont, '\<#define \w+\s*\(\w+\.\w+\.\w+\.\w+\)\s*', 'match');
comps = regexp(macros, '\s' ,'split');
regs = cell(1, length(comps));
acslen = cell(1, length(comps));
for ii = 1:length(comps)
    regs{ii} = cell2mat(comps{ii}(2));                      % regs hold each element as a char.
    stccomps = regexp(comps{ii}(3), '\.', 'split');
    %regexp(stccomps{:}(4), '\d+', 'match');
    acslen{ii} = regexp(stccomps{:}(4), '\d+', 'match');
    acslen{ii} = cell2mat(acslen{ii}{:});                   % transform to string without cell
end

