/*
 *  HyoCG block C-MEX S-function 
 *                  
 *  Copyright 2016-2017 Hyowinner.
 *  Date: 10-Jul-2016
 *
 */

/*=====================================*
 * Required setup for C MEX S-Function *
 *=====================================*/
/**** S_FUNCTION_NAME ****/
#define S_FUNCTION_NAME  rtc

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
     /* Set and Check parameter count  */
    //int notSizesOnlyCall = ( ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY );
    ssSetNumSFcnParams(S, NUM_PARAMS);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) return;
    
    if (!ssSetNumInputPorts(S, 0)) {
        return;
    }    
    
    if (!ssSetNumOutputPorts(S, 0)) {
        return;
    }
    
    /***** Set SFcn Param Untunable ****/
    ssSetSFcnParamNotTunable(S, 0);
     
    /* sample times */
    ssSetNumSampleTimes(S, 1);
    
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
