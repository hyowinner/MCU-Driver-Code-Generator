%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function help to S-function code auto generate.(Apply to zero input and zero output S-function)
% Read the parameters config from masked block.
%
% Example: SFcnGen(gcbh,true/false) when selecting target block
% 
% Hyowinner @ 2016/6/25
%
% Add argument "sfnName" @2016/7/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SFcnGen(blockhandle, sfnName, mexflag)
if nargin < 2
    error('Error: At least 2 argument are needed.');
elseif(2 == nargin)
    if mexflag == false;
        disp('No mex file generated.');
    end
elseif (nargin > 3)
    error('Error: Too many variables !');
end
% prepare fixed parameter for this code generation
maskName = 'g_pv';
mask_len = 1;
mask_styles = 'edit';
DataType = {'char'};
% sfnName = get_param(blockhandle, 'FunctionName');
VectOrNum = {'Str'};                       % parameters store as a vector : Vect|Str|Num
%Get mask names and saved as cell format
fidTemplate = fopen('SFcnTemplate.c','r');      %Get S-function template file
fidCode = fopen([sfnName '.c'],'w');                   %Create current model S-function file
for index = 1:mask_len
    if check_control_valid(mask_styles, index)
        %Get macros names: PARAMETERE
        ParaStr = upper(maskName(3:end));
        ParaDefine(index) = {ParaStr};
        %Get C S-function parameter names: c_parameter
        ParaStr = strcat('c_',maskName(3:end));
        ParaC(index) = {ParaStr};
        %Get C S-function parameter datatype: int8_T
        TypeStr = strcat(DataType{index},'_T');
        DataTypeC(index) = {TypeStr};
        %Get Rtw parameter names: r_parameter
        ParaStr = strcat('r_',maskName(3:end));
        ParaRtw(index) = {ParaStr};
        %Get RTW parameter datatype: SS_INT8
        TypeStr = upper(strcat('SS_',DataType{index}));
        if isequal(DataType{index},'real')
            TypeStr = 'SS_DOUBLE';
        elseif isequal(DataType{index},'real32')
            TypeStr = 'SS_SINGLE';
        end
        DataTypeRtw(index) = {TypeStr};
    end
end

while ~feof(fidTemplate) % Whether in the end of file
    tline=fgetl(fidTemplate); % Read one line of file
    fprintf(fidCode,'%s\r\n',tline);%Copy the template content to the S-function file
    switch tline
        %Write date info when executed.
        case ' *  Copyright 2016-2017 Hyowinner.'
            Sfunction_Time(fidCode);
            %Write the parat of "S_FUNCTION_NAME"
        case '/**** S_FUNCTION_NAME ****/'
            Sfunction_Name(fidCode,sfnName);
            %Write the parat of "General Defines/macros"
        case '/**** General Defines/macros ****/'
            General_Defines_Macros(fidCode,maskName,mask_len,ParaDefine,VectOrNum, mask_styles);
            %Write the parat of "Set SFcn Param Untunable"
        case '    /***** Set SFcn Param Untunable ****/'
            Set_SFcn_Param_Untunable(fidCode,mask_len, mask_styles);
            %Write the parat of "s_function parameters define"
        case '	/**** s_function parameters define ****/'
            Sfunction_Parameters_Define(fidCode,mask_len,ParaC,ParaDefine,DataTypeC,VectOrNum, mask_styles);
            %Write the parat of "write out rtw parameters"
        case '	/**** write out rtw parameters ****/'
            Write_Out_Rtw_Parameters(fidCode,mask_len,ParaC,ParaRtw,DataTypeRtw,VectOrNum,ParaDefine, mask_styles);
    end
end
fclose(fidTemplate); %Close template file
fclose(fidCode); %Close S-function file

%Generate mexw32 or mexw64, it depends on the OS
if(true == mexflag)
    cmdStr = ['mex ' sfnName '.c;'];
    eval(cmdStr);
    clear cmdStr
end
% print OK info
disp('C S-function Generate Compelete!');
end


%{
    format for time is like below when SFcnGen:
    *  Date: 23-Aug-2013 13:48:51
%}
function Sfunction_Time(fidCode)
CodeStr = [' *  Date: ' datestr(date)];
fprintf(fidCode, '%s\r\n', CodeStr);
end


%{
The format of "S_FUNCTION_NAME" part:
    #define S_FUNCTION_NAME BlkName
%}
function Sfunction_Name(fidCode,BlkName)
CodeStr = ['#define S_FUNCTION_NAME  ' BlkName];
fprintf(fidCode,'%s\r\n',CodeStr);
end

%{
The format of "General Defines/macros" part:
    enum {
    g_Para0 = 0,
    g_Para1 = 1,
    ...
    g_ParaN = len - 1,
    NUM_PARAMS = len
    };

    #define PRAR0(S) (mxGetScalar(ssGetSFcnParam(S, g_Para0)))
    #define PARA1(S)   (mxGetScalar(ssGetSFcnParam(S, g_Para1)))
    ...
    #define PARAN(S)    (mxGetScalar(ssGetSFcnParam(S, g_ParaN)))
%}
function General_Defines_Macros(fidCode,maskName,len,ParaDefine,VectOrNum, mask_styles)
CodeStr = 'enum {';
fprintf(fidCode,'%s\r\n',CodeStr);
ii = 0;
for index = 1:len
    if check_control_valid(mask_styles, index)
        CodeStr = ['    ' maskName ' = ' num2str(ii) ','];
        fprintf(fidCode,'%s\r\n',CodeStr);
        ii = ii + 1;
    end
end
CodeStr = ['    NUM_PARAMS = ' num2str(ii)];
fprintf(fidCode,'%s\r\n',CodeStr);
CodeStr = '};';
fprintf(fidCode,'%s\r\n\r\n',CodeStr);
for index = 1:len
    if check_control_valid(mask_styles, index)
        CodeStr = ['#define ' ParaDefine{index} '(S) (mxGetScalar(ssGetSFcnParam(S,' maskName ')))'];
        if isequal(VectOrNum{index},'Vect')
            CodeStr = ['#define ' ParaDefine{index} '(S) (ssGetSFcnParam(S,' maskName '))'];
            %*******************Add Str type**********************%
        elseif isequal(VectOrNum{index},'Str')
            CodeStr = ['#define ' ParaDefine{index} '(S) (ssGetSFcnParam(S,' maskName '))'];
        end
        %*******************Add Str Type end here**************%
        fprintf(fidCode,'%s\r\n',CodeStr);
    end
end
end

%{
The format of  "Set SFcn Param Untunable" part:
    ssSetSFcnParamNotTunable(S, 0);
    ssSetSFcnParamNotTunable(S, 1);
    ...
    ssSetSFcnParamNotTunable(S, len-1);
%}
function Set_SFcn_Param_Untunable(fidCode,len, mask_styles)
ii = 0;
for index = 1:len
    if check_control_valid(mask_styles, index)
        CodeStr = ['    ssSetSFcnParamNotTunable(S, ' num2str(ii) ');'];
        fprintf(fidCode,'%s\r\n',CodeStr);
        ii = ii + 1;
    end
end
end

%{
The format of "s_function parameters define" part:
    int8_T   c_Para0 = PARA0(S);
    int8_T   c_Para1 = PARA1(S);
    ...
    int32_T  c_ParaM = PARAM(S);
    ...
    int8_T   c_ParaN = PARAN(S);
%}
function Sfunction_Parameters_Define(fidCode,len,ParaC,ParaDefine,DataTypeC,VectOrNum, mask_styles)
for index = 1:len
    if check_control_valid(mask_styles, index)
        CodeStr = ['    ' DataTypeC{index} '  ' ParaC{index} ' = ' ParaDefine{index} '(S);'];
        if isequal(VectOrNum{index},'Vect')
            CodeStr = ['    ' DataTypeC{index} '  *' ParaC{index} ' = mxGetData(' ParaDefine{index} '(S));'];
        end
        %******************Add Str Type here******************************%
        if isequal(VectOrNum{index},'Str')
            CodeStr = ['    ' DataTypeC{index} '  *' ParaC{index} ' = (' DataTypeC{index} ' *)malloc(mxGetNumberOfElements(' ParaDefine{index} '(S)) + 1);'];
            CodeStr = [CodeStr, char(10) '    boolean_T ' ParaC{index} '_flag = mxGetString(' ParaDefine{index} '(S), ' ParaC{index} ', mxGetNumberOfElements(' ParaDefine{index} '(S)) + 1 );'];
        end
        %******************Add Str Type end here**************************%
        fprintf(fidCode,'%s\r\n',CodeStr);
    end
end
end

%{
The format of "write out rtw parameters" part:
    if (!ssWriteRTWParamSettings(S, len,
                                 SSWRITE_VALUE_DTYPE_NUM,"r_Para0",&c_Para0,DTINFO(SS_INT8, COMPLEX_NO),
                                 SSWRITE_VALUE_DTYPE_NUM,"r_Para1",&c_Para1,DTINFO(SS_INT8, COMPLEX_NO),
                                 ...
                                 SSWRITE_VALUE_DTYPE_NUM,"r_ParaM",&c_ParaM,DTINFO(SS_INT32, COMPLEX_NO),
                                 ...
                                 SSWRITE_VALUE_DTYPE_NUM,"r_ParaN",&c_ParaN,DTINFO(SS_INT8, COMPLEX_NO)))
       {
        return; /* An error occurred which will be reported by SL */
       }
%}
function Write_Out_Rtw_Parameters(fidCode,len,ParaC,ParaRtw,DataTypeRtw,VectOrNum,ParaDefine, mask_styles)
control_num = get_control_num(mask_styles, len);
CodeStr = ['    if (!ssWriteRTWParamSettings(S, ' num2str(control_num) ','];
fprintf(fidCode,'%s\r\n',CodeStr);
ii = 0;
for index = 1:len
    if check_control_valid(mask_styles, index)
        if isequal(VectOrNum{index},'Vect')
            CodeStr = ['                                SSWRITE_VALUE_VECT,"' ParaRtw{index} ...
                '",' ParaC{index} ',mxGetNumberOfElements(' ParaDefine{index} '(S))'];
        elseif isequal(VectOrNum{index}, 'Str')
            %***********************add Str Type here*********************%
            CodeStr = ['                                SSWRITE_VALUE_STR,"' ParaRtw{index} ...
                '",' ParaC{index}];
        elseif isequal(VectOrNum{index}, 'Num')
            CodeStr = ['                                SSWRITE_VALUE_DTYPE_NUM,"' ParaRtw{index} ...
                '",&' ParaC{index} ',DTINFO(' DataTypeRtw{index} ', COMPLEX_NO)'];
        end
        ii = ii + 1;
        if (ii == control_num)
            CodeStr = [CodeStr '))'];
        else
            CodeStr = [CodeStr ','];
        end
        fprintf(fidCode,'%s\r\n',CodeStr);
    end
end

CodeStr = '    {';
fprintf(fidCode,'%s\r\n',CodeStr);
CodeStr = '        return; /* An error occurred which will be reported by SL */';
fprintf(fidCode,'%s\r\n',CodeStr);
CodeStr = '    }';
fprintf(fidCode,'%s\r\n',CodeStr);
end

function num = get_control_num(mask_styles, len)
num = 0;
for index = 1:len
    styles = mask_styles;
    if strcmp(styles, 'radiobutton') || strcmp(styles, 'checkbox') || strcmp(styles, 'edit') || strcmp(styles, 'popup')
        num = num + 1;
    end
end
end

function valid = check_control_valid(mask_styles, index)
valid = false;
if isa(mask_styles, 'cell')
    styles = mask_styles{index};
elseif isa(mask_styles, 'char')
    styles = mask_styles;
end
if strcmp(styles, 'radiobutton') || strcmp(styles, 'checkbox') || strcmp(styles, 'edit') || strcmp(styles, 'popup')
    valid = true;
end
end
