/*
 * motor_test.c
 *
 * Code generation for model "motor_test".
 *
 * Model version              : 1.14
 * Simulink Coder version : 8.8 (R2015a) 09-Feb-2015
 * C source code generated on : Thu Oct 04 12:07:12 2018
 *
 * Target selection: rtwin.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86/Pentium
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor_test.h"
#include "motor_test_private.h"
#include "motor_test_dt.h"

/* options for Simulink Desktop Real-Time board 0 */
static double RTWinBoardOptions0[] = {
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
};

/* list of Simulink Desktop Real-Time timers */
const int RTWinTimerCount = 1;
const double RTWinTimers[2] = {
  0.001, 0.0,
};

/* list of Simulink Desktop Real-Time boards */
const int RTWinBoardCount = 1;
RTWINBOARD RTWinBoards[1] = {
  { "National_Instruments/PCI-MIO-16E-4", 4294967295U, 6, RTWinBoardOptions0 },
};

/* Block signals (auto storage) */
B_motor_test_T motor_test_B;

/* Block states (auto storage) */
DW_motor_test_T motor_test_DW;

/* Real-time model */
RT_MODEL_motor_test_T motor_test_M_;
RT_MODEL_motor_test_T *const motor_test_M = &motor_test_M_;

/* Model output function */
void motor_test_output(void)
{
  /* local block i/o variables */
  real_T rtb_Clock;
  real_T currentTime;

  /* Step: '<S1>/Step' */
  currentTime = motor_test_M->Timing.t[0];

  /* Clock: '<S1>/Clock' */
  rtb_Clock = motor_test_M->Timing.t[0];

  /* Step: '<S1>/Step' */
  if (currentTime < motor_test_P.Ramp_start) {
    currentTime = motor_test_P.Step_Y0;
  } else {
    currentTime = motor_test_P.Ramp_slope;
  }

  /* Sum: '<S1>/Output' incorporates:
   *  Constant: '<S1>/Constant'
   *  Constant: '<S1>/Constant1'
   *  Product: '<S1>/Product'
   *  Sum: '<S1>/Sum'
   */
  motor_test_B.Output = (rtb_Clock - motor_test_P.Ramp_start) * currentTime +
    motor_test_P.Ramp_X0;

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_test_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_test_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor_test_P.AnalogOutput_Channels, &motor_test_B.Output,
                     &parm);
    }
  }

  /* S-Function Block: <Root>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE) motor_test_P.AnalogInput_RangeMode;
    parm.rangeidx = motor_test_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2, motor_test_P.AnalogInput_Channels,
                   &motor_test_B.AnalogInput[0], &parm);
  }
}

/* Model update function */
void motor_test_update(void)
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
  if (!(++motor_test_M->Timing.clockTick0)) {
    ++motor_test_M->Timing.clockTickH0;
  }

  motor_test_M->Timing.t[0] = motor_test_M->Timing.clockTick0 *
    motor_test_M->Timing.stepSize0 + motor_test_M->Timing.clockTickH0 *
    motor_test_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++motor_test_M->Timing.clockTick1)) {
      ++motor_test_M->Timing.clockTickH1;
    }

    motor_test_M->Timing.t[1] = motor_test_M->Timing.clockTick1 *
      motor_test_M->Timing.stepSize1 + motor_test_M->Timing.clockTickH1 *
      motor_test_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Model initialize function */
void motor_test_initialize(void)
{
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_test_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_test_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor_test_P.AnalogOutput_Channels,
                     &motor_test_P.AnalogOutput_InitialValue, &parm);
    }
  }
}

/* Model terminate function */
void motor_test_terminate(void)
{
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_test_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_test_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor_test_P.AnalogOutput_Channels,
                     &motor_test_P.AnalogOutput_FinalValue, &parm);
    }
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  motor_test_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  motor_test_update();
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
  motor_test_initialize();
}

void MdlTerminate(void)
{
  motor_test_terminate();
}

/* Registration function */
RT_MODEL_motor_test_T *motor_test(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)motor_test_M, 0,
                sizeof(RT_MODEL_motor_test_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&motor_test_M->solverInfo,
                          &motor_test_M->Timing.simTimeStep);
    rtsiSetTPtr(&motor_test_M->solverInfo, &rtmGetTPtr(motor_test_M));
    rtsiSetStepSizePtr(&motor_test_M->solverInfo,
                       &motor_test_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&motor_test_M->solverInfo, (&rtmGetErrorStatus
      (motor_test_M)));
    rtsiSetRTModelPtr(&motor_test_M->solverInfo, motor_test_M);
  }

  rtsiSetSimTimeStep(&motor_test_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&motor_test_M->solverInfo,"FixedStepDiscrete");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = motor_test_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    motor_test_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    motor_test_M->Timing.sampleTimes = (&motor_test_M->Timing.sampleTimesArray[0]);
    motor_test_M->Timing.offsetTimes = (&motor_test_M->Timing.offsetTimesArray[0]);

    /* task periods */
    motor_test_M->Timing.sampleTimes[0] = (0.0);
    motor_test_M->Timing.sampleTimes[1] = (0.001);

    /* task offsets */
    motor_test_M->Timing.offsetTimes[0] = (0.0);
    motor_test_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(motor_test_M, &motor_test_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = motor_test_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    motor_test_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(motor_test_M, 10.0);
  motor_test_M->Timing.stepSize0 = 0.001;
  motor_test_M->Timing.stepSize1 = 0.001;

  /* External mode info */
  motor_test_M->Sizes.checksums[0] = (423841011U);
  motor_test_M->Sizes.checksums[1] = (675832933U);
  motor_test_M->Sizes.checksums[2] = (1037015103U);
  motor_test_M->Sizes.checksums[3] = (1476996338U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    motor_test_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor_test_M->extModeInfo,
      &motor_test_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor_test_M->extModeInfo, motor_test_M->Sizes.checksums);
    rteiSetTPtr(motor_test_M->extModeInfo, rtmGetTPtr(motor_test_M));
  }

  motor_test_M->solverInfoPtr = (&motor_test_M->solverInfo);
  motor_test_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&motor_test_M->solverInfo, 0.001);
  rtsiSetSolverMode(&motor_test_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor_test_M->ModelData.blockIO = ((void *) &motor_test_B);
  (void) memset(((void *) &motor_test_B), 0,
                sizeof(B_motor_test_T));

  /* parameters */
  motor_test_M->ModelData.defaultParam = ((real_T *)&motor_test_P);

  /* states (dwork) */
  motor_test_M->ModelData.dwork = ((void *) &motor_test_DW);
  (void) memset((void *)&motor_test_DW, 0,
                sizeof(DW_motor_test_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    motor_test_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.B = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor_test_M->Sizes.numContStates = (0);/* Number of continuous states */
  motor_test_M->Sizes.numY = (0);      /* Number of model outputs */
  motor_test_M->Sizes.numU = (0);      /* Number of model inputs */
  motor_test_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  motor_test_M->Sizes.numSampTimes = (2);/* Number of sample times */
  motor_test_M->Sizes.numBlocks = (11);/* Number of blocks */
  motor_test_M->Sizes.numBlockIO = (2);/* Number of block outputs */
  motor_test_M->Sizes.numBlockPrms = (17);/* Sum of parameter "widths" */
  return motor_test_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
