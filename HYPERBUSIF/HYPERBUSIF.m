function uiobj = HYPERBUSIF
% This is the config file for generate UI for HYPERBUSIF
% short for : hyperbusif
sfnName = 'hyperbusif';

index = 1;
% first element is the display string. headerfile, periname, funcpostname
% are stored in g_pv of S-function block.
uiobj(index).prompt = 'The HYPERBUSI module provides function and operation for interfacing to the HyperBus memory devices.  achieves both high speed read/write throughput by double data rate interface and low pin counts.';
uiobj(index).headerfile = 's6j3200_PCMPWM.h';
uiobj(index).periname = 'HYPERBUSIF';               % folder name of the upper layer.
uiobj(index).funcpostname = '_Init';
uiobj(index).arg = 'void';
uiobj(index).ret = 'void ';             % with a blank after
% from second element control begins

index = index + 1;
uiobj(index).prompt = 'Dead Timer Value';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'deadtimeval';   
uiobj(index).type = 'edit';
uiobj(index).val = '0';
uiobj(index).visible = 'on';
uiobj(index).enable = 'off';                                                          % init as disable for "opmpd" is not "Full H-bridge".
uiobj(index).helptip = 'Configure the dead timer value.';
uiobj(index).Callback =  {@requireCompareRelation,'PCMPWM Init', 'cntperiod', '<'};   % for requirement between parameters
uiobj(index).regio = 'PCMPWM0_CONTROL_DTVAL';

index = index + 1;
uiobj(index).prompt = 'FIFO Empty Space Threshold';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'fifoempnum';   
uiobj(index).type = 'edit';               
uiobj(index).val = '0';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {@numberCheck, 1, 2^5 - 1};
uiobj(index).helptip = 'defines the number of empty entries in the FIFO buffer.If this field is set to a value greater than 23, a data request is never generated.';
uiobj(index).regio = 'PCMPWM0_CONTROL_FEST';

index = index + 1;
uiobj(index).prompt = 'Enable Double Mode';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'doublemode';   
uiobj(index).type = 'checkbox';               
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'operation in single or double mode.';
uiobj(index).regio = 'PCMPWM0_CONTROL_DOUBLE';

index = index + 1;
uiobj(index).prompt = 'Operation Mode';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'opmpd';   
uiobj(index).type = 'popupmenu';      
uiobj(index).members = {'low-pass filter';'simplified H-bridge';'full H-bridge'}; 
uiobj(index).val = 'low-pass filter'; 
uiobj(index).codegenstr = {'0';'1';'2'}; 
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {@requireParamEnDisCond, 'pcmoffset',{'low-pass filter';'simplified H-bridge'},'full H-bridge','deadtimeval','full H-bridge',{'low-pass filter';'simplified H-bridge'}};
uiobj(index).helptip = 'defines the module''s mode of operation.';
uiobj(index).regio = 'PCMPWM0_CONTROL_MODE';

index = index + 1;
uiobj(index).prompt = 'Stereo Mode';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'stereomode';   
uiobj(index).type = 'popupmenu';      
uiobj(index).members = {'mono mode';'stereo mode'}; 
uiobj(index).val = 'mono mode';   
uiobj(index).codegenstr = {'0';'1'}; 
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enables operation in mono or stereo mode.';
uiobj(index).regio = 'PCMPWM0_CONTROL_STEREO';

index = index + 1;
uiobj(index).prompt = 'Debug Mode';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'debugmode';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enables then Generate silence when CPU enters debug mode.';
uiobj(index).regio = 'PCMPWM0_CONTROL_DBGEN';


index = index + 1;
uiobj(index).prompt = 'Enable DMA Interface';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'dmamode';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'controls the module''s DMA interface.';
uiobj(index).regio = 'PCMPWM0_CONTROL_DMAEN';

index = index + 1;
uiobj(index).prompt = 'Enable Silence Mode';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'silencemode';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'triggers the Silence Mode of the PCMPWM module.';
uiobj(index).regio = 'PCMPWM0_CONTROL_SILENCE';

index = index + 1;
uiobj(index).prompt = 'Output Level Select Ch1';
uiobj(index).tabname = 'Output Control';
uiobj(index).var = 'outlvlselch1';   
uiobj(index).type = 'popupmenu';    
uiobj(index).members = {'PCMPWM_1_AH/BH are low-active and PCMPWM_1_AL/BL are high-active';'PCMPWM_1_AH/BH are high-active and PCMPWM_1_AL/BL are low-active'};    
uiobj(index).val = {'PCMPWM_1_AH/BH are low-active and PCMPWM_1_AL/BL are high-active'};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).codegenstr = {'0';'1'}; 
uiobj(index).helptip = 'selects the output polarity of channel #1.';
uiobj(index).regio = 'PCMPWM0_OCTRL_LEVL1';

index = index + 1;
uiobj(index).prompt = 'Output Level Select Ch0';
uiobj(index).tabname = 'Output Control';
uiobj(index).var = 'outlvlselch0';   
uiobj(index).type = 'popupmenu';    
uiobj(index).members = {'PCMPWM_0_AH/BH are low-active and PCMPWM_0_AL/BL are high-active';'PCMPWM_0_AH/BH are high-active and PCMPWM_0_AL/BL are low-active'};    
uiobj(index).val = {'PCMPWM_0_AH/BH are high-active and PCMPWM_0_AL/BL are low-active'};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).codegenstr = {'0';'1'}; 
uiobj(index).helptip = 'selects the output polarity of channel #0.';
uiobj(index).regio = 'PCMPWM0_OCTRL_LEVL0';

index = index + 1;
uiobj(index).prompt = 'Output Enable Ch1';
uiobj(index).tabname = 'Output Control';
uiobj(index).var = 'outputench1';   
uiobj(index).type = 'popupmenu';    
uiobj(index).members = {'PCMPWM_1_AH/BH/AL/BL are set to the inactive value';'The PWM signal is enabled on channel #1'};    
uiobj(index).val = 'PCMPWM_1_AH/BH/AL/BL are set to the inactive value';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).codegenstr = {'0';'1'}; 
uiobj(index).helptip = 'enables or disables PWM signal generation on channel #1.';
uiobj(index).regio = 'PCMPWM0_OCTRL_EN1';

index = index + 1;
uiobj(index).prompt = 'Output Enable Ch0';
uiobj(index).tabname = 'Output Control';
uiobj(index).var = 'outputench0';   
uiobj(index).type = 'popupmenu';    
uiobj(index).members = {'PCMPWM_0_AH/BH/AL/BL are set to the inactive value';'The PWM signal is enabled on channel #0'};    
uiobj(index).val = 'PCMPWM_0_AH/BH/AL/BL are set to the inactive value';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).codegenstr = {'0';'1'}; 
uiobj(index).helptip = 'enables or disables PWM signal generation on channel #0.';
uiobj(index).regio = 'PCMPWM0_OCTRL_EN0';

index = index + 1;
uiobj(index).prompt = 'Clock Select';
uiobj(index).tabname = 'Clock/Peiod/Offset';
uiobj(index).var = 'clksel';   
uiobj(index).type = 'popupmenu';    
uiobj(index).members = {'Divide by 1: Conversion counter clock = PWM_CLK';'Divide by 2: Conversion counter clock = PWM_CLK/2';'Divide by 4: Conversion counter clock = PWM_CLK/4';'Divide by 8: Conversion counter clock = PWM_CLK/8'};    
uiobj(index).val = 'Divide by 1: Conversion counter clock = PWM_CLK';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).codegenstr = {'0';'1';'2';'3'};  
uiobj(index).helptip = 'selects the PCMPWM conversion counter clock.';
uiobj(index).regio = 'PCMPWM0_CLKSEL_CLK_SEL';

index = index + 1;
uiobj(index).prompt = 'Counter Period';
uiobj(index).tabname = 'Clock/Peiod/Offset';
uiobj(index).var = 'cntperiod';   
uiobj(index).type = 'edit';    
uiobj(index).val = '257';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).Callback = {@numberCheck, 1, 2^16 - 1};
uiobj(index).helptip = 'defines the value of the PCMPWM conversion counter after which it continues to count from 0.';
uiobj(index).regio = 'PCMPWM0_CLKSEL_CLK_SEL';

index = index + 1;
uiobj(index).prompt = 'PCM Offset';
uiobj(index).tabname = 'Clock/Peiod/Offset';
uiobj(index).var = 'pcmoffset';   
uiobj(index).type = 'edit';    
uiobj(index).val = '257';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'defines the offset value used in the PCM signed to unsigned conversion in low-pass filter and simplified H-bridge mode.';
uiobj(index).regio = 'PCMPWM0_PCMOFFS_PCM_OFFS';

index = index + 1;
uiobj(index).prompt = 'Enable DMA Block Error Interrupt';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'dmablkerrorint';   
uiobj(index).type = 'checkbox';    
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enables or disables the DMA block error interrupt.';
uiobj(index).regio = 'PCMPWM0_INTREN_DMA_ERR';

index = index + 1;
uiobj(index).prompt = 'Enable FIFO Under-run Error Interrupt';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'fifoundrunerr';   
uiobj(index).type = 'checkbox';    
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enables or disables the FIFO under-run error interrupt.';
uiobj(index).regio = 'PCMPWM0_INTREN_UDRN';

index = index + 1;
uiobj(index).prompt = 'Enable FIFO Overflow Error Interrupt';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'fifoovflerr';   
uiobj(index).type = 'checkbox';    
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enables or disables the FIFO overflow error interrupt.';
uiobj(index).regio = 'PCMPWM0_INTREN_OVFL';

index = index + 1;
uiobj(index).prompt = 'Enable Data Request Interrupt';
uiobj(index).tabname = 'Interrupt';
uiobj(index).var = 'datareqerr';   
uiobj(index).type = 'checkbox';    
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'enables or disables the data request interrupt.';
uiobj(index).regio = 'PCMPWM0_INTREN_DREQ';

index = index + 1;
uiobj(index).prompt = 'Enable PCMPWM';
uiobj(index).tabname = 'Global Config';
uiobj(index).var = 'enpcmpwm';   
uiobj(index).type = 'checkbox';      
uiobj(index).val = 'off';   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'Globally enables or disables the PCMPWM module. This bit must not be set before the module''s configuration has been completed.';
uiobj(index).Callback = {@disableControl,'PCMPWM Init', 'deadtimeval', 'fifoempnum', 'doublemode', 'opmpd', 'stereomode','debugmode','dmamode','silencemode'};
uiobj(index).regio = 'PCMPWM0_CONTROL_EN';

index = index + 1;
uiobj(index).prompt = 'AN0(AL0)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'an0al0';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.0 output pin';

index = index + 1;
uiobj(index).prompt = 'AN1(AL1)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'an1al1';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.1 output pin';

index = index + 1;
uiobj(index).prompt = 'AP0(AH0)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'ap0ah0';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.0 output pin';

index = index + 1;
uiobj(index).prompt = 'AP1(AH1)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'ap1ah1';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.1 output pin';

index = index + 1;
uiobj(index).prompt = 'BN0(BL0)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'bn0bl0';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.0 output pin';

index = index + 1;
uiobj(index).prompt = 'BN1(BL1)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'bn1bl1';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.1 output pin';

index = index + 1;
uiobj(index).prompt = 'BP0(BH0)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'bp0bh0';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.0 output pin';

index = index + 1;
uiobj(index).prompt = 'BP1(BH1)';
uiobj(index).tabname = 'Port Setting';  
uiobj(index).var = 'bp1bh1';   
uiobj(index).type = 'popupmenu';  
uiobj(index).members = getpinfor(uiobj(index).prompt, get_pin_func(gcs));
uiobj(index).val = uiobj(index).members{1};   
uiobj(index).visible = 'on';
uiobj(index).enable = 'on';
uiobj(index).helptip = 'PCM PWM ch.1 output pin';
% last two are Cancel and OK button, no var, do not store in s-function.
index = index + 1;
uiobj(index).prompt = 'Cancel';
uiobj(index).helptip = 'Cancel this configuration and close UI.';
uiobj(index).Callback = 'close(gcf)';

index = index + 1;
uiobj(index).prompt = 'OK';
uiobj(index).Callback = {@okbuttoncb, uiobj, sfnName};
uiobj(index).type = 'pushbutton';
uiobj(index).helptip = 'OK this configuration and close UI.';


