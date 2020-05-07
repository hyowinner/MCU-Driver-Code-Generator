function memMap()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function generate Memory Map for MCU. User can change the scope with
% input address.
% Hyowinner
% @2016/7/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mmap = {
    '00000000', 'TCRAM 8MB@Max(or Reserved)';
  '00800000', 'TCFLASH 8MB@Max(or Reserved)';
  '01000000', 'AXI FLASH 16MB@Max';
  '02000000', 'System RAM 8MB@Max(or Reserved)';
  '02800000', 'Exclusive Access Memory';
  '02801000', 'Reserved';
  '04000000', 'AXI SLAVE CORE0';
  '06000000', 'Reserved';
  '0E000000', 'Work FLASH 3M@Max(or Reserved)';
  '0E800000', 'BACKUP RAM 8K(Backup RAM power supply domain:PD4 0)';
  '0E802000', 'BACKUP RAM 8K(Backup RAM power supply domain:PD4 1)';
  '0E804000', 'Reserved';
  '40000000', 'Memory for DDRHSSPI/Hyper Bus ch.1/ch.2';
  '50000000', '2MB VRAM';
  '50200000', '2D Graphics Core Subsystem control';
  '50200400', '2D Graphics core(Blit,Drawing,Capture,Display,CmdSeq)';
  '50210C00', 'MPU AXI(Capture Controller)';
  '50211000', 'MPU AXI(Blit Engine)';
  '50211400', 'MPU AXI(Drawing Engine)';
  '50211800', 'Reserved';
  '50212000', 'DDRHSSPI configuration';
  '50212400', 'Reserved';
  '50214400', 'AXI Interconnect(Error Monitor)';
  '50214800', 'Reserved';
  '50215000', 'MPU AXI (3D Graphics Core Write Port A)';
  '50215400', 'MPU AXI (3D Graphics Core Write Port B)';
  '50215800', 'MPU AXI (3D Graphics Core Write Port C)';
  '50215C00', 'Reserved';
  '50280000', 'Hyper Bus ch.1 Control Register';
  '50281000', 'Hyper Bus ch.2 Control Register';
  '50282000', 'Reserved';
  '50300000', '3D Graphics Core';
  '50310000', 'Reserved';
  '50400000', 'High Performance Bus Matrix';
  '50500000', 'Reserved';
  '80000000', 'DDRHSSPI for CPU area';
  '90000000', 'Memory for Hyper Bus ch.0';
  'A0000000', 'Reserved';
  'B0000000', 'Peri area';
  'B4900000', 'CAN FD ch.0';
  'B4910000', 'CAN FD ch.1';
  'B4920000', 'Reserved';
  'B5000000', 'AppS #0 (16MB)';
  'B6000000', 'AppS #1 (16MB)';
  'B8000000', 'Expansion area';
  'B8028800', 'Reserved';
  'FFFEE000', 'ERRCFG';
  'FFFF0000', 'BootROM';
  'FFFFFFFF', '';
};
% calculate the vector
increase = [0; diff(hex2dec(mmap(:,1)))];
barcoldata = [increase, increase]';

% draw memory map with bar, data should be multiple columns.
scrsize = get(0, 'ScreenSize');
figpos = [3/8 * scrsize(3) scrsize(4)/6 scrsize(3)/3 2/3 * scrsize(4)];
figure('Name','MemoryMap','NumberTitle','off','Menubar','None',...
    'Position', figpos, 'WindowStyle','Modal');
b = bar(barcoldata, 'stacked'); 
box off;
colorset = get(gcf, 'Color');
set(gca, 'Color', colorset);
title('S6J3200 MCU Memory Map');
set(gca, 'XLim', [0.5 1.5]);            % only show the first column 
set(gca, 'YTick', hex2dec(mmap(:,1)));      % tick on the seperator line
set(gca, 'YTickLabel', mmap(:,1));      % tick on the seperator line
set(gca, 'XTick', []);
for ii = 1:length(b) - 1
    set(b(ii), 'BarWidth', 1);
    % set Section name onto Memory Map.
    text(0.58, hex2dec(mmap(ii, 1)) + (hex2dec(mmap(ii + 1, 1)) - hex2dec(mmap(ii, 1)))/2, mmap(ii,2));
end
st = uicontrol('Units', 'Normalized','Position',[0.02 0.05 0.3 0.03],...
    'Style','Edit','String','00000000','TooltipString','Pleas input the start address');
ed = uicontrol('Units', 'Normalized','Position',[0.62 0.05 0.3 0.03],...
    'Style','Edit','String','FFFFFFFF','TooltipString','Pleas input the end address');
uicontrol('Units', 'Normalized','Position',[0.35 0.05 0.25 0.03],...
    'Style','pushbutton','String','Memory Scope','TooltipString','Pleas press to update display scope',...
    'Callback',{@updateScope, st, ed, gca});

function updateScope(~, ~, startHandle, endHandle, axesHandle)
% This function update MemoryMap display Scope according to User input.
startAddr = get(startHandle, 'String');
endAddr = get(endHandle, 'String');
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';
if hex2dec(startAddr) >= hex2dec(endAddr)
    msgbox('Start Address must less than End Address!', CreateStruct);
    return;
end
set(axesHandle, 'YLim', [hex2dec(startAddr) hex2dec(endAddr)]);            % only show the first column 
