function uiobj = RTC
% This is the config file for generate UI for RTC
% short for : rtc
% Updated @2016/7/11
% Add precode field for "Day bit" because it is the first control of
% RTC_Init(). @2016/7/12
sfnName = 'rtc';

index = 1;
% first element is the display string. headerfile, periname, funcpostname
% are stored in g_pv of S-function block.
uiobj(index).prompt = 'The Real Time Clock (RTC) Timer module provides the current real time (HH/MM/SS) and the Calibration module calibrates Sub clock or Slow RC clock with respect to the Main oscillator clock.';
uiobj(index).headerfile = 's6j3200_RTC.h';
uiobj(index).periname = 'RTC';               % folder name of the upper layer.
uiobj(index).funcpostname = '_Init';
uiobj(index).arg = 'void';
uiobj(index).ret = 'void ';             % with a blank after
% from second element control begins
index = index + 1;
uiobj(index).prompt = 'Day Bit';
uiobj(index).tabname = 'Time Info';
uiobj(index).var = 'daybit';              
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                    
uiobj(index).Callback = {@numberCheck, 0, 2^16 - 1};
uiobj(index).helptip = 'Stores the count value of the day of the real time clock.';  
uiobj(index).regio = 'RTC_RTR1_WTDR';
uiobj(index).precode = ['RTC_WTCR_ST = 1;' char(10) 'RTC_WTCR_ST = 0;   /*  Resets the Sub-second counter to "0"  */'];

index = index + 1;
uiobj(index).prompt = 'Hour';
uiobj(index).tabname = 'Time Info';
uiobj(index).var = 'hour';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Set the RTC Hour counter value.';
uiobj(index).Callback =  {@numberCheck, 0, 2^5 - 1};   
uiobj(index).regio = 'RTC_WRT_WTHR';

index = index + 1;
uiobj(index).prompt = 'Minute';
uiobj(index).tabname = 'Time Info';
uiobj(index).var = 'minute';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Set the RTC Minute counter value.'; 
uiobj(index).Callback =  {@numberCheck, 0, 2^6 - 1};  
uiobj(index).regio = 'RTC_WRT_WTMR';

index = index + 1;
uiobj(index).prompt = 'Second';
uiobj(index).tabname = 'Time Info';
uiobj(index).var = 'second';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Set the RTC Second counter value.';
uiobj(index).Callback =  {@numberCheck, 0, 2^6 - 1};   
uiobj(index).regio = 'RTC_WRT_WTSR';

index = index + 1;
uiobj(index).prompt = 'Sub-Second';
uiobj(index).tabname = 'Time Info';
uiobj(index).var = 'subsec';                % if subsecond then get_param_pv will get double value for "second", so one tag should be not the sub string of other control  
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';               
uiobj(index).Callback = {@numberCheck, 0, 2^24 - 1};
uiobj(index).helptip = 'Stores the reload value for the Sub-second counter that divides the CLKRTC to generate the RTC''s time base.';  
uiobj(index).regio = 'RTC_WTBR_WTBR';

index = index + 1;
uiobj(index).prompt = 'Scale calibrated value';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'scalecalval';   
uiobj(index).type = 'popupmenu';
uiobj(index).members = {'No Change';'Multiply by 2';'Multiply by 4';'Multiply by 8';'Multiply by 16'};
uiobj(index).val = {'No Change'};
uiobj(index).codegenstr = {'0';'1';'2';'3';'4'};
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {@setDuration, 'caldur'};
uiobj(index).helptip = 'Scale the Calibration value.';  
uiobj(index).regio = 'RTC_WTCR_SCAL';

index = index + 1;
uiobj(index).prompt = 'Clock select for calibration';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'clkselcali';   
uiobj(index).type = 'popupmenu';
uiobj(index).members = {'Sub clock (CLK_SUB)';'Slow RC clock (CLKSRC)'};
uiobj(index).val = {'Sub clock (CLK_SUB)'};
uiobj(index).codegenstr = {'0';'1'};
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {};
uiobj(index).helptip = 'select the Calibration clock';  
uiobj(index).regio = 'RTC_WTCR_CCKSEL';

index = index + 1;
uiobj(index).prompt = 'Enable calibration value update';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'encalvalupdt';   
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                     % only support Manual Trigger
uiobj(index).helptip = 'enable/disable the transfer of the calibration value in Calibration Clock Counter Register (RTC_CNTCAL) to the RTC Sub-Second Register (RTC_WTBR) after the completion of a calibration cycle.';  
uiobj(index).regio = 'RTC_WTCR_ENUP';

index = index + 1;
uiobj(index).prompt = 'Automatic calibration';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'autocal';   
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                     
uiobj(index).helptip = 'enable/disable Automatic Calibration mode.';  
uiobj(index).Callback = {@enableControl, 'encalvalupdt'};
uiobj(index).regio = 'RTC_WTCR_ACAL';

index = index + 1;
uiobj(index).prompt = 'Calibration clock period';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'calclkprd';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                     
uiobj(index).helptip = 'The value to be loaded to the Calibration clock period counter before a calibration cycle is set.';  
uiobj(index).Callback = {@numberCheck, 0, 2^24 - 1};   
uiobj(index).regio = 'RTC_CNTPCAL_CNTPCAL';

index = index + 1;
uiobj(index).prompt = 'Calibration duration';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'caldur';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'off';                % This control is set according SCAL             
uiobj(index).helptip = 'the reload value of the Calibration duration counter.';  
uiobj(index).Callback = {@numberCheck, 0, 2^24 - 1};   
uiobj(index).regio = 'RTC_DURMW_DURMW';

index = index + 1;
uiobj(index).prompt = 'Calibration trigger counter value';
uiobj(index).tabname = 'Calibration';
uiobj(index).var = 'caltrigcntval';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                     
uiobj(index).helptip = 'the reload value of the 12-bit programmable Calibration trigger counter.';  
uiobj(index).Callback = {@numberCheck, 0, 2^12 - 1};   
uiobj(index).regio = 'RTC_CALTRG_CALTRG';

index = index + 1;
uiobj(index).prompt = 'Debug Mode enable';
uiobj(index).tabname = 'Debug';
uiobj(index).var = 'debug';   
uiobj(index).type = 'checkbox';
uiobj(index).val = 'off';
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';                     
uiobj(index).helptip = 'set to "on" and the processor is in the debug state.';  
uiobj(index).regio = 'RTC_DEBUG_DBGEN';

index = index + 1;
uiobj(index).prompt = 'Clock select for RTC';
uiobj(index).tabname = 'RTC Config';
uiobj(index).var = 'clksel4rtc';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = {'Main clock (CLK_MAIN/2)';'Sub clock (CLK_SUB/2)';'Slow RC clock (CLK_SRC/2)'};
uiobj(index).val = {'Main clock (CLK_MAIN/2)'};   
uiobj(index).codegenstr = {'0';'1';'2'};
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'select the input clock for the RTC.';
uiobj(index).regio = 'RTC_WTCR_RCKSEL';
uiobj(index).precode = 'while(RTC_WTSR_CLK_STS == 1);    /*  When CLK_STS is 1, the writing value is ignored.   */';             

index = index + 1;
uiobj(index).prompt = 'Clock switching mode';
uiobj(index).tabname = 'RTC Config';
uiobj(index).var = 'clcswmode';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = {'Precise switch';'Immediate switch'};
uiobj(index).val = {'Precise switch'};   
uiobj(index).codegenstr = {'0';'1'};
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'configure the clock switching mode when RTC_WTCR:RCKSEL is changed.';
uiobj(index).regio = 'RTC_WTCR_CSM';
uiobj(index).precode = 'while(RTC_WTSR_CLK_STS == 1);    /*  When CLK_STS is 1, the writing value is ignored.   */';     

index = index + 1;
uiobj(index).prompt = 'Calibration done interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'caldoneinten';   
uiobj(index).type = 'checkbox';    
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'used to enable interrupt requests at Calibration done.';
uiobj(index).regio = 'RTC_WINE_CALD';

index = index + 1;
uiobj(index).prompt = 'Calibration failure detection interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'calfaildetinten';   
uiobj(index).type = 'checkbox';    
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enable interrupt requests at Calibration Failure Detection.';
uiobj(index).regio = 'RTC_WINE_CFDE';

index = index + 1;
uiobj(index).prompt = 'Output enable';
uiobj(index).tabname = 'RTC Config';
uiobj(index).var = 'outputen';   
uiobj(index).type = 'popupmenu';    
uiobj(index).members = {'used as a General-purpose I/O or for another peripheral block';'used as output for Sub-second counter'};
uiobj(index).val = {'used as a General-purpose I/O or for another peripheral block'};    
uiobj(index).codegenstr = {'0';'1'};
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {@setEnablewithPopup, 1, 'wot'};
uiobj(index).helptip = 'used to enable/disable the WOT external pin.';
uiobj(index).regio = 'RTC_WTCR_OE';

index = index + 1;
uiobj(index).prompt = 'Day interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'dayinten';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Enable interrupt requests at one-day (24 hour) intervals.';
uiobj(index).regio = 'RTC_WINE_DAYE';

index = index + 1;
uiobj(index).prompt = 'Hour interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'hourinten';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Enable interrupt requests at one-hour intervals.';
uiobj(index).regio = 'RTC_WINE_HOURE';

index = index + 1;
uiobj(index).prompt = 'Minute interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'mininten';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Enable interrupt requests at one-minute intervals.';
uiobj(index).regio = 'RTC_WINE_MINE';

index = index + 1;
uiobj(index).prompt = 'Second interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'secinten';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Enable interrupt requests at one-second intervals.';
uiobj(index).regio = 'RTC_WINE_SECE';

index = index + 1;
uiobj(index).prompt = 'Sub-Second interrupt enable';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'subsecinten';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Enable interrupt requests at a half-second intervals.';
uiobj(index).regio = 'RTC_WINE_SUBSECE';
% Port
index = index + 1;
uiobj(index).prompt = 'WOT';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'wot';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};  
uiobj(index).codegenstr = {'/*  PORT CONFIG CODE SECTION HERE TO BE IMPLEMENTED  */'};
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'serves as the output for the Sub-second counter';

index = index + 1;
uiobj(index).prompt = 'Cancel';
uiobj(index).helptip = 'Cancel this configuration and close UI.';
uiobj(index).Callback = 'close(gcf)';

index = index + 1;
uiobj(index).prompt = 'OK';
uiobj(index).Callback = {@okbuttoncb, uiobj, sfnName};
uiobj(index).type = 'pushbutton';
uiobj(index).helptip = 'OK this configuration and close UI.';


function setDuration(hdl, ~, duratag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the cb of SCAL in RTC to set val for DURWM
% It is not a common cb function
% Hyowinner @2016/7/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
duration = {'0x0F4240';'0x07A120';'0x03D090';'0x01E848';'0x00F424'};
val = get(hdl, 'Value');
tab = get(hdl, 'Parent');
fig = get(tab, 'Parent');
target = findobj(fig, 'tag', duratag);
set(target, 'String', duration{val});
