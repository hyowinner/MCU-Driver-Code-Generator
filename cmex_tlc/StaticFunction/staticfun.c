/*
 *  HyoCG block C-MEX S-function
 *
 *  Copyright 2016-2017 Hyowinner.
 *  Date: 26-Jun-2016
 *
 */

/*=====================================*
 * Required setup for C MEX S-Function *
 *=====================================*/
/**** S_FUNCTION_NAME ****/
#define S_FUNCTION_NAME  staticfun

#define S_FUNCTION_LEVEL 2

#define NUM_PARAMS  1
#define NUM_INPUT_PORTS  0
#define NUM_OUTPUT_PORTS  1

#define FCNNAME(S) (ssGetSFcnParam(S, 0))

/* define error messages */
#define ERR_INVALID_SET_INPUT_DTYPE_CALL  \
"Invalid call to mdlSetInputPortDataType"
        
#define ERR_INVALID_SET_OUTPUT_DTYPE_CALL \
        "Invalid call to mdlSetOutputPortDataType"
        
#define ERR_INVALID_DTYPE     "Invalid input or output port data type"
        
#include "simstruc.h"
        
        /* Function: mdlInitializeSizes ===============================================
         * Abstract:
         *   Initialize the sizes array
         */
static void mdlInitializeSizes(SimStruct *S)
{
    /* Set and Check parameter count  */
    //int notSizesOnlyCall = ( ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY );
    ssSetNumSFcnParams(S, NUM_PARAMS);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) return;
    
    if (!ssSetNumInputPorts(S, NUM_INPUT_PORTS)) {
        return;
    }
    
    
    if (!ssSetNumOutputPorts(S, NUM_OUTPUT_PORTS)) {
        return;
    }
    ssSetOutputPortWidth(S, 0, 1);
    ssSetOutputPortDataType(S, 0, SS_FCN_CALL);
    
    ssSetSFcnParamNotTunable(S, 0);
    /* sample times */
    ssSetNumSampleTimes(S, 1);
    
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
    ssSetCallSystemOutput(S, 0);  /* call on first element */
    ssSetModelReferenceSampleTimeDefaultInheritance(S);
} /* end mdlInitializeSampleTimes */


/* Function: mdlOutputs =======================================================
 * Abstract:
 *   Compute the outputs of the S-function.
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{
    if (!ssCallSystemWithTid(S, 0, tid)) {
        /* Error occurred which will be reported by Simulink */
        return;
    }
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
    char_T  *c_fcnname = (char_T *)malloc(mxGetNumberOfElements(FCNNAME(S)) + 1);
    boolean_T c_fcnname_flag = mxGetString(FCNNAME(S), c_fcnname, mxGetNumberOfElements(FCNNAME(S)) + 1 );

	/**** write out rtw parameters ****/
    if (!ssWriteRTWParamSettings(S, NUM_PARAMS,
                                SSWRITE_VALUE_STR,"r_fcnname",c_fcnname))
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
