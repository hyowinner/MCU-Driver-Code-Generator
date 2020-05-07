/*
 *  HyoCG block C-MEX S-function
 *
 *  Copyright 2016-2017 Hyowinner.
 *  Date: 15-Jul-2016
 *
 */

/*=====================================*
 * Required setup for C MEX S-Function *
 *=====================================*/
/**** S_FUNCTION_NAME ****/
#define S_FUNCTION_NAME  regwrite

#define S_FUNCTION_LEVEL 2

/* define error messages */
#define ERR_INVALID_SET_INPUT_DTYPE_CALL  \
"Invalid call to mdlSetInputPortDataType"
        
#define ERR_INVALID_SET_OUTPUT_DTYPE_CALL \
        "Invalid call to mdlSetOutputPortDataType"
        
#define ERR_INVALID_DTYPE     "Invalid input or output port data type"
        
        
        /*========================*
         * General Defines/macros *
         *========================*/
        /**** General Defines/macros ****/
        enum {
    g_pv = 0,
    NUM_PARAMS = 1
};

#define PV(S) (ssGetSFcnParam(S,g_pv))

/*
 * Need to include simstruc.h for the definition of the SimStruct and
 * its associated macro definitions.
 */
#include "simstruc.h"

/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *   Initialize the sizes array
 */
static void mdlInitializeSizes(SimStruct *S)
{
    /* To adapt C++ Compiler, declaration are defined before execution.  */
    char c_pv[200];
    char str[200];
    int st = 0;
    int ed = 0;
    char *stri = (char_T *)malloc(mxGetNumberOfElements(PV(S)));
    int i;
    /* Set and Check parameter count  */
    ssSetNumSFcnParams(S, NUM_PARAMS);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) return;
    
    if (!ssSetNumInputPorts(S, 1)) {
        return;
    }
    ssSetInputPortWidth(S, 0, 1);
    /* get string from g_pv of UI          */
    
    mxGetString(PV(S), c_pv, sizeof(c_pv));
    c_pv[sizeof(c_pv)/sizeof(char) - 1] = '\0';     /*  Add one end charactor after c_pv  */
    strcpy(str, c_pv);
    /* get sub-string of "n-bit"          */
    
    for(i = 0; i < strlen(str); i++)
    {
        if (str[i] ==',')
        {
            st = i + 1;
        }
        if (str[i] == ';')
        {
            ed = i;
        }
    }
    
    strncpy(stri, str + st , ed - st);
    if (!strcmp(stri, "unsigned char")||strcmp(stri, "unsigned char") > 0)
    {
        ssSetInputPortDataType(S, 0, SS_BOOLEAN);
    }
    else if (!strcmp(stri, "uint_io8_t")||strcmp(stri, "uint_io8_t") > 0)
    {
        ssSetInputPortDataType(S, 0, SS_UINT8);
    }
    else if (!strcmp(stri, "uint_io16_t")||strcmp(stri, "uint_io16_t") > 0)
    {
        ssSetInputPortDataType(S, 0, SS_UINT16);
    }
    else if (!strcmp(stri, "uint_io32_t")||strcmp(stri, "uint_io32_t") > 0)
    {
        ssSetInputPortDataType(S, 0, SS_UINT32);
    }
    ssSetInputPortDirectFeedThrough(S, 0, 1);
    if (!ssSetNumOutputPorts(S, 0)) {
        return;
    }
    
    /***** Set SFcn Param Untunable ****/
    ssSetSFcnParamNotTunable(S, 0);
    
    //ssSetInputPortDirectFeedThrough(S, 0, 1);
    /* options */
    ssSetOptions(S, (SS_OPTION_EXCEPTION_FREE_CODE |
            SS_OPTION_DISALLOW_CONSTANT_SAMPLE_TIME));
} /* end mdlInitializeSizes */


/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    Initialize the sample times array.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, INHERITED_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);
    ssSetModelReferenceSampleTimeDefaultInheritance(S);
} /* end mdlInitializeSampleTimes */


/* Function: mdlOutputs =======================================================
 * Abstract:
 *   Compute the outputs of the S-function.
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{
    
} /* end mdlOutputs */


/* Function: mdlTerminate =====================================================
 * Abstract:
 *    Called when the simulation is terminated.
 */
static void mdlTerminate(SimStruct *S)
{
} /* end mdlTerminate */

#define MDL_RTW
#if defined(MDL_RTW) && (defined(MATLAB_MEX_FILE) || defined(NRT))
static void mdlRTW(SimStruct *S)
{
    /**** s_function parameters define ****/
    char_T  *c_pv = (char_T *)malloc(mxGetNumberOfElements(PV(S)) + 1);
    boolean_T c_pv_flag = mxGetString(PV(S), c_pv, mxGetNumberOfElements(PV(S)) + 1 );
    
    /**** write out rtw parameters ****/
    if (!ssWriteRTWParamSettings(S, 1,
            SSWRITE_VALUE_STR,"r_pv",c_pv))
    {
        return; /* An error occurred which will be reported by SL */
    }
    
}
#endif

#ifdef    MATLAB_MEX_FILE  /* Is this file being compiled as a MEX-file?    */
# include "simulink.c"     /* MEX-file interface mechanism                  */
//# include "fixedpoint.c"   /* needed when it is configured with fixdt data type */
#else                      /* Prevent usage by RTW if TLC file is not found */
#include "cg_sfun.h"       /* Code generation registration function */
#endif
