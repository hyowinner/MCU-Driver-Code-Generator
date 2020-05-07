% ==========================================================================
%  
% History
% Date        Ver   Description
% 2016/6/25   0.1   Firstblock added.
% 
% ==========================================================================

function blkStruct = slblocks  
 
%SLBLOCKS Defines a block library.  
 
% Library's name. The name appears in the Library Browser's  
% contents pane.  
 
blkStruct.Name = ['S6J3200' sprintf('\n') 'Peripheral Simulink Library'];  
 
% Information for "Blocksets and Toolboxes" subsystem

blkStruct.OpenFcn = ' ';
blkStruct.MaskDisplay = 'disp(''Cortex R5 Peripheral Simulink Library developped by Hyowinner @MATLAB 2014b'')';

% Information for Simulink Library Browser
Browser(1).Library = 'periblklib';
Browser(1).Name    = 'S6J3200 Peripheral Simulink Library';
Browser(1).IsFlat  = 0;

blkStruct.Browser = Browser;
