/*
 * QUARC_simlink.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "QUARC_simlink".
 *
 * Model version              : 15.19
 * Simulink Coder version : 9.9 (R2023a) 19-Nov-2022
 * C source code generated on : Fri Jun 28 16:25:51 2024
 *
 * Target selection: quarc_win64.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "QUARC_simlink.h"
#include "rtwtypes.h"
#include <math.h>
#include "QUARC_simlink_private.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "QUARC_simlink_dt.h"

/* Named constants for MATLAB Function: '<Root>/MATLAB Function' */
#define QUARC_simlink_CALL_EVENT       (-1)

/* Block signals (default storage) */
B_QUARC_simlink_T QUARC_simlink_B;

/* Block states (default storage) */
DW_QUARC_simlink_T QUARC_simlink_DW;

/* Real-time model */
static RT_MODEL_QUARC_simlink_T QUARC_simlink_M_;
RT_MODEL_QUARC_simlink_T *const QUARC_simlink_M = &QUARC_simlink_M_;

/* Model output function */
void QUARC_simlink_output(void)
{
  real_T rtb_Gain;

  /* S-Function (hil_read_encoder_block): '<Root>/HIL Read Encoder' */

  /* S-Function Block: QUARC_simlink/HIL Read Encoder (hil_read_encoder_block) */
  {
    t_error result = hil_read_encoder(QUARC_simlink_DW.HILInitialize_Card,
      QUARC_simlink_P.HILReadEncoder_channels, 2,
      &QUARC_simlink_DW.HILReadEncoder_Buffer[0]);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
    } else {
      QUARC_simlink_B.HILReadEncoder_o1 =
        QUARC_simlink_DW.HILReadEncoder_Buffer[0];
      QUARC_simlink_B.HILReadEncoder_o2 =
        QUARC_simlink_DW.HILReadEncoder_Buffer[1];
    }
  }

  /* MATLAB Function: '<Root>/MATLAB Function1' */
  QUARC_simlink_DW.sfEvent_c = QUARC_simlink_CALL_EVENT;

  /* MATLAB Function 'MATLAB Function1': '<S2>:1' */
  rtb_Gain = QUARC_simlink_B.HILReadEncoder_o2;

  /* '<S2>:1:11' */
  if (QUARC_simlink_B.HILReadEncoder_o2 > 2.147483648E+9) {
    rtb_Gain = QUARC_simlink_B.HILReadEncoder_o2 - 4.294967296E+9;
  }

  /* '<S2>:1:14' */
  QUARC_simlink_B.otpt = rtb_Gain * 360.0 / 4096.0;

  /* End of MATLAB Function: '<Root>/MATLAB Function1' */

  /* MATLAB Function: '<Root>/MATLAB Function' */
  QUARC_simlink_DW.sfEvent_h = QUARC_simlink_CALL_EVENT;

  /* MATLAB Function 'MATLAB Function': '<S1>:1' */
  rtb_Gain = QUARC_simlink_B.HILReadEncoder_o1;

  /* '<S1>:1:11' */
  if (QUARC_simlink_B.HILReadEncoder_o1 > 2.147483648E+9) {
    rtb_Gain = QUARC_simlink_B.HILReadEncoder_o1 - 4.294967296E+9;
  }

  /* Sum: '<Root>/Add' incorporates:
   *  Constant: '<Root>/Constant'
   *  MATLAB Function: '<Root>/MATLAB Function'
   */
  /* '<S1>:1:14' */
  QUARC_simlink_B.Add = rtb_Gain * 360.0 / 4096.0 -
    QUARC_simlink_P.Constant_Value;

  /* MATLAB Function: '<Root>/MATLAB Function2' */
  QUARC_simlink_DW.sfEvent = QUARC_simlink_CALL_EVENT;

  /* MATLAB Function 'MATLAB Function2': '<S3>:1' */
  /* '<S3>:1:8' */
  QUARC_simlink_B.status = true;
  if (fabs(QUARC_simlink_B.Add) < 20.0) {
    /* '<S3>:1:11' */
    /* '<S3>:1:23' */
    /* '<S3>:1:24' */
    /* '<S3>:1:25' */
    /* '<S3>:1:26' */
    /* '<S3>:1:27' */
    /* '<S3>:1:28' */
    /* '<S3>:1:29' */
    /* '<S3>:1:32' */
    QUARC_simlink_DW.i1 += (QUARC_simlink_DW.previous_arm1_inpt +
      QUARC_simlink_B.otpt) * 0.002 / 2.0;

    /* '<S3>:1:33' */
    QUARC_simlink_DW.i2 += (QUARC_simlink_DW.previous_arm2_inpt +
      QUARC_simlink_B.Add) * 0.002 / 2.0;

    /* '<S3>:1:36' */
    /* '<S3>:1:37' */
    /* '<S3>:1:40' */
    QUARC_simlink_B.P1 = (QUARC_simlink_DW.previous_arm1_inpt -
                          QUARC_simlink_B.otpt) / 0.002 * 0.0 +
      (QUARC_simlink_B.otpt * 2.047 + 0.9 * QUARC_simlink_DW.i1);

    /* '<S3>:1:41' */
    rtb_Gain = (QUARC_simlink_DW.previous_arm2_inpt - QUARC_simlink_B.Add) /
      0.002 * 0.0 + (QUARC_simlink_B.Add * 10.47 + 2.4532925 *
                     QUARC_simlink_DW.i2);

    /* '<S3>:1:42' */
    QUARC_simlink_B.otpt_v = rtb_Gain;

    /* '<S3>:1:45' */
    QUARC_simlink_DW.previous_arm1_inpt = QUARC_simlink_B.otpt;

    /* '<S3>:1:46' */
    QUARC_simlink_DW.previous_arm2_inpt = QUARC_simlink_B.Add;
  } else {
    /* '<S3>:1:48' */
    QUARC_simlink_B.otpt_v = 0.0;

    /* '<S3>:1:49' */
    QUARC_simlink_B.status = false;

    /* '<S3>:1:50' */
    QUARC_simlink_B.P1 = 0.0;

    /* '<S3>:1:51' */
    rtb_Gain = 0.0;
  }

  QUARC_simlink_B.P2 = rtb_Gain;

  /* End of MATLAB Function: '<Root>/MATLAB Function2' */

  /* Gain: '<Root>/Gain' */
  rtb_Gain = QUARC_simlink_P.Gain_Gain * QUARC_simlink_B.otpt_v;

  /* S-Function (hil_write_analog_block): '<Root>/HIL Write Analog' */

  /* S-Function Block: QUARC_simlink/HIL Write Analog (hil_write_analog_block) */
  {
    t_error result;
    result = hil_write_analog(QUARC_simlink_DW.HILInitialize_Card,
      &QUARC_simlink_P.HILWriteAnalog_channels, 1, &rtb_Gain);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
    }
  }
}

/* Model update function */
void QUARC_simlink_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++QUARC_simlink_M->Timing.clockTick0)) {
    ++QUARC_simlink_M->Timing.clockTickH0;
  }

  QUARC_simlink_M->Timing.t[0] = QUARC_simlink_M->Timing.clockTick0 *
    QUARC_simlink_M->Timing.stepSize0 + QUARC_simlink_M->Timing.clockTickH0 *
    QUARC_simlink_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void QUARC_simlink_initialize(void)
{
  /* Start for S-Function (hil_initialize_block): '<Root>/HIL Initialize' */

  /* S-Function Block: QUARC_simlink/HIL Initialize (hil_initialize_block) */
  {
    t_int result;
    t_boolean is_switching;
    result = hil_open("ni_usb_6211", "0", &QUARC_simlink_DW.HILInitialize_Card);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
      return;
    }

    is_switching = false;
    result = hil_set_card_specific_options(QUARC_simlink_DW.HILInitialize_Card,
      " ", 2);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
      return;
    }

    result = hil_watchdog_clear(QUARC_simlink_DW.HILInitialize_Card);
    if (result < 0 && result != -QERR_HIL_WATCHDOG_CLEAR) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
      return;
    }

    if ((QUARC_simlink_P.HILInitialize_EIPStart && !is_switching) ||
        (QUARC_simlink_P.HILInitialize_EIPEnter && is_switching)) {
      QUARC_simlink_DW.HILInitialize_QuadratureModes[0] =
        QUARC_simlink_P.HILInitialize_EIQuadrature;
      QUARC_simlink_DW.HILInitialize_QuadratureModes[1] =
        QUARC_simlink_P.HILInitialize_EIQuadrature;
      result = hil_set_encoder_quadrature_mode
        (QUARC_simlink_DW.HILInitialize_Card,
         QUARC_simlink_P.HILInitialize_EIChannels, 2U,
         (t_encoder_quadrature_mode *)
         &QUARC_simlink_DW.HILInitialize_QuadratureModes[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
        return;
      }
    }

    if ((QUARC_simlink_P.HILInitialize_EIStart && !is_switching) ||
        (QUARC_simlink_P.HILInitialize_EIEnter && is_switching)) {
      QUARC_simlink_DW.HILInitialize_InitialEICounts[0] =
        QUARC_simlink_P.HILInitialize_EIInitial;
      QUARC_simlink_DW.HILInitialize_InitialEICounts[1] =
        QUARC_simlink_P.HILInitialize_EIInitial;
      result = hil_set_encoder_counts(QUARC_simlink_DW.HILInitialize_Card,
        QUARC_simlink_P.HILInitialize_EIChannels, 2U,
        &QUARC_simlink_DW.HILInitialize_InitialEICounts[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(QUARC_simlink_M, _rt_error_message);
        return;
      }
    }
  }

  /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function1' */
  QUARC_simlink_DW.sfEvent_c = QUARC_simlink_CALL_EVENT;
  QUARC_simlink_DW.is_active_c1_QUARC_simlink = 0U;

  /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function' */
  QUARC_simlink_DW.sfEvent_h = QUARC_simlink_CALL_EVENT;
  QUARC_simlink_DW.is_active_c2_QUARC_simlink = 0U;

  /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function2' */
  QUARC_simlink_DW.sfEvent = QUARC_simlink_CALL_EVENT;
  QUARC_simlink_DW.is_active_c3_QUARC_simlink = 0U;
  QUARC_simlink_DW.previous_arm1_inpt = 0.0;
  QUARC_simlink_DW.previous_arm1_inpt_not_empty = true;
  QUARC_simlink_DW.previous_arm2_inpt = 0.0;
  QUARC_simlink_DW.previous_arm2_inpt_not_empty = true;
  QUARC_simlink_DW.i1 = 0.0;
  QUARC_simlink_DW.i1_not_empty = true;
  QUARC_simlink_DW.i2 = 0.0;
  QUARC_simlink_DW.i2_not_empty = true;
}

/* Model terminate function */
void QUARC_simlink_terminate(void)
{
  /* Terminate for S-Function (hil_initialize_block): '<Root>/HIL Initialize' */

  /* S-Function Block: QUARC_simlink/HIL Initialize (hil_initialize_block) */
  {
    hil_task_stop_all(QUARC_simlink_DW.HILInitialize_Card);
    hil_monitor_stop_all(QUARC_simlink_DW.HILInitialize_Card);
    hil_task_delete_all(QUARC_simlink_DW.HILInitialize_Card);
    hil_monitor_delete_all(QUARC_simlink_DW.HILInitialize_Card);
    hil_close(QUARC_simlink_DW.HILInitialize_Card);
    QUARC_simlink_DW.HILInitialize_Card = NULL;
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  QUARC_simlink_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  QUARC_simlink_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  QUARC_simlink_initialize();
}

void MdlTerminate(void)
{
  QUARC_simlink_terminate();
}

/* Registration function */
RT_MODEL_QUARC_simlink_T *QUARC_simlink(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)QUARC_simlink_M, 0,
                sizeof(RT_MODEL_QUARC_simlink_T));

  /* Initialize timing info */
  {
    int_T *mdlTsMap = QUARC_simlink_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "QUARC_simlink_M points to
       static memory which is guaranteed to be non-NULL" */
    QUARC_simlink_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    QUARC_simlink_M->Timing.sampleTimes =
      (&QUARC_simlink_M->Timing.sampleTimesArray[0]);
    QUARC_simlink_M->Timing.offsetTimes =
      (&QUARC_simlink_M->Timing.offsetTimesArray[0]);

    /* task periods */
    QUARC_simlink_M->Timing.sampleTimes[0] = (0.002);

    /* task offsets */
    QUARC_simlink_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(QUARC_simlink_M, &QUARC_simlink_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = QUARC_simlink_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    QUARC_simlink_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(QUARC_simlink_M, -1);
  QUARC_simlink_M->Timing.stepSize0 = 0.002;

  /* External mode info */
  QUARC_simlink_M->Sizes.checksums[0] = (3066231934U);
  QUARC_simlink_M->Sizes.checksums[1] = (3483435170U);
  QUARC_simlink_M->Sizes.checksums[2] = (1576280819U);
  QUARC_simlink_M->Sizes.checksums[3] = (2503208956U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[4];
    QUARC_simlink_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(QUARC_simlink_M->extModeInfo,
      &QUARC_simlink_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(QUARC_simlink_M->extModeInfo,
                        QUARC_simlink_M->Sizes.checksums);
    rteiSetTPtr(QUARC_simlink_M->extModeInfo, rtmGetTPtr(QUARC_simlink_M));
  }

  QUARC_simlink_M->solverInfoPtr = (&QUARC_simlink_M->solverInfo);
  QUARC_simlink_M->Timing.stepSize = (0.002);
  rtsiSetFixedStepSize(&QUARC_simlink_M->solverInfo, 0.002);
  rtsiSetSolverMode(&QUARC_simlink_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  QUARC_simlink_M->blockIO = ((void *) &QUARC_simlink_B);
  (void) memset(((void *) &QUARC_simlink_B), 0,
                sizeof(B_QUARC_simlink_T));

  /* parameters */
  QUARC_simlink_M->defaultParam = ((real_T *)&QUARC_simlink_P);

  /* states (dwork) */
  QUARC_simlink_M->dwork = ((void *) &QUARC_simlink_DW);
  (void) memset((void *)&QUARC_simlink_DW, 0,
                sizeof(DW_QUARC_simlink_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    QUARC_simlink_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 20;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  QUARC_simlink_M->Sizes.numContStates = (0);/* Number of continuous states */
  QUARC_simlink_M->Sizes.numY = (0);   /* Number of model outputs */
  QUARC_simlink_M->Sizes.numU = (0);   /* Number of model inputs */
  QUARC_simlink_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  QUARC_simlink_M->Sizes.numSampTimes = (1);/* Number of sample times */
  QUARC_simlink_M->Sizes.numBlocks = (19);/* Number of blocks */
  QUARC_simlink_M->Sizes.numBlockIO = (9);/* Number of block outputs */
  QUARC_simlink_M->Sizes.numBlockPrms = (59);/* Sum of parameter "widths" */
  return QUARC_simlink_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
