% ==============================================================================================
%       Hyowinner's Simulink School Cource: Hardware Support Package
%       Development
% ==============================================================================================
%
% Copyright (C) 2016 Hyowinner. All Rights Reserved.
%
% ==========================================================================
%
% History
% Date        Ver   Description
% 2016-6-28   0.1   first version
% 2016-9-02         Add checkbox to startup IDE.
%
% ==========================================================================

function rtwoptions = Hyo_getrtwoptions(rtwoptions)
  Idx = 1;

  rtwoptions(Idx).prompt        = 'Hyo Customization';
  rtwoptions(Idx).type          = 'Category';
  rtwoptions(Idx).enable        = 'on';  
  rtwoptions(Idx).default       = 3;
  rtwoptions(Idx).popupstrings  = '';
  rtwoptions(Idx).tlcvariable   = '';
  rtwoptions(Idx).tooltip       = '';
  rtwoptions(Idx).callback      = '';
  rtwoptions(Idx).makevariable  = '';

  Idx = Idx + 1;

  rtwoptions(Idx).prompt        = 'Target Device';
  rtwoptions(Idx).type          = 'Popup';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).popupstrings  = 'S6J3280K|S6J3280L|S6J32E0K|S6J32E0L|S6J32G0K|S6J32G0L|S6J32G0M';
  rtwoptions(Idx).default       = '';
  rtwoptions(Idx).tlcvariable   = 't_mcutype';
  rtwoptions(Idx).tooltip       = '';
  rtwoptions(Idx).callback      = '';
  rtwoptions(Idx).makevariable  = '';

  Idx = Idx + 1;
  
  rtwoptions(Idx).prompt        = 'MCU Looker';
  rtwoptions(Idx).type          = 'Pushbutton';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).tlcvariable   = '';
  rtwoptions(Idx).tooltip       = '';
  rtwoptions(Idx).callback      = 'drawMCU';
  rtwoptions(Idx).makevariable  = '';

  Idx = Idx + 1;
  
  rtwoptions(Idx).prompt        = 'IE path';
  rtwoptions(Idx).type          = 'NonUI';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).default       = 'C:\Program Files\Internet Explorer\iexplore.exe';
  rtwoptions(Idx).tlcvariable   = 't_ieaddr';
  rtwoptions(Idx).tooltip       = '';
  rtwoptions(Idx).callback      = '';
  rtwoptions(Idx).makevariable  = '';
  
  Idx = Idx + 1;
  
  rtwoptions(Idx).prompt        = 'Memory Map';
  rtwoptions(Idx).type          = 'Pushbutton';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).tooltip       = 'Display the Memory Map';
  rtwoptions(Idx).callback      = 'memMap';
  rtwoptions(Idx).makevariable  = '';
  
  Idx = Idx + 1;
  rtwoptions(Idx).prompt        = 'Target Netpage';
  rtwoptions(Idx).type          = 'NonUI';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).tlcvariable   = 't_tarnet';
  rtwoptions(Idx).default       = 'http://www.chuanke.com/s3570260.html';
  
  Idx = Idx + 1;
  rtwoptions(Idx).prompt        = 'Hyowinner Simulink School';
  rtwoptions(Idx).type          = 'Pushbutton';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).tlcvariable   = '';
  rtwoptions(Idx).tooltip       = '';
  rtwoptions(Idx).callback      = 'system([''start "C:\Program Files\Internet Explorer\iexplore.exe" "http://www.chuanke.com/s3570260.html"'']);';
  rtwoptions(Idx).makevariable  = '';

  Idx = Idx + 1;
  
  rtwoptions(Idx).prompt        = 'IDE Startup';
  rtwoptions(Idx).type          = 'Checkbox';
  rtwoptions(Idx).enable        = 'on';
  rtwoptions(Idx).tooltip       = 'Select whether to startup the specified IDE after code generation.';
  rtwoptions(Idx).callback      = '';
  rtwoptions(Idx).tlcvariable  = 't_idestartup';
  rtwoptions(Idx).makevariable  = '';

 

