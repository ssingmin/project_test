/* Automation Studio generated header file */
/* Do not edit ! */
/* StCom 5.07.0 */

#ifndef _STCOM_
#define _STCOM_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _StCom_VERSION
#define _StCom_VERSION 5.07.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "runtime.h"
		#include "AsIecCon.h"
		#include "AsBrStr.h"
		#include "standard.h"
		#include "ArEventLog.h"
		#include "SuperTrak.h"
#endif
#ifdef _SG4
		#include "runtime.h"
		#include "AsIecCon.h"
		#include "AsBrStr.h"
		#include "standard.h"
		#include "ArEventLog.h"
		#include "SuperTrak.h"
#endif
#ifdef _SGC
		#include "runtime.h"
		#include "AsIecCon.h"
		#include "AsBrStr.h"
		#include "standard.h"
		#include "ArEventLog.h"
		#include "SuperTrak.h"
#endif


/* Constants */
#ifdef _REPLACE_CONST
 #define stCOM_CONFIG_VERSION "V5.07.0"
 #define stCOM_WRN_SUPERTRAK_SYS (-1610547099)
 #define stCOM_WRN_SUPERTRAK_SEC (-1610547098)
 #define stCOM_WRN_ENABLE_SIGNAL_SOURCE (-1610547097)
 #define stCOM_WRN_SYS_RESERVED0 (-1610481664)
 #define stCOM_WRN_SYS_APPLICATION (-1610481663)
 #define stCOM_WRN_SYS_RESERVED2 (-1610481662)
 #define stCOM_WRN_SYS_RESERVED3 (-1610481661)
 #define stCOM_WRN_SYS_TEMP_SENSOR (-1610481660)
 #define stCOM_WRN_SYS_HIGH_TEMP (-1610481659)
 #define stCOM_WRN_SYS_RESERVED6 (-1610481658)
 #define stCOM_WRN_SYS_GATEWAY_NETWORK (-1610481657)
 #define stCOM_WRN_SYS_COIL_CURRENT_I2T (-1610481656)
 #define stCOM_WRN_SYS_COIL_RESPONSE (-1610481655)
 #define stCOM_WRN_SYS_RESERVED10 (-1610481654)
 #define stCOM_WRN_SYS_PALLET_POS_CORR (-1610481653)
 #define stCOM_WRN_SYS_PALLET_ID_TAG (-1610481652)
 #define stCOM_WRN_SYS_DUPLICATE_PALLET (-1610481651)
 #define stCOM_WRN_SYS_RESERVED14 (-1610481650)
 #define stCOM_WRN_SYS_ENCOD_COUNTS (-1610481649)
 #define stCOM_WRN_SYS_ENCOD_READINGS (-1610481648)
 #define stCOM_WRN_SYS_INVALID_REGION (-1610481647)
 #define stCOM_WRN_SYS_INVALID_PARAMETER (-1610481646)
 #define stCOM_WRN_SYS_COMMAND_FAILED (-1610481645)
 #define stCOM_WRN_SYS_INVALID_SYNC_ZONE (-1610481644)
 #define stCOM_WRN_SYS_ENCOD_READ (-1610481643)
 #define stCOM_WRN_SYS_COIL_DRIVER (-1610481642)
 #define stCOM_WRN_SYS_PARAM_SAVE_REQ (-1610481641)
 #define stCOM_WRN_SYS_DESTINATION_UPDATE (-1610481640)
 #define stCOM_WRN_SYS_ENCOD_COMM (-1610481639)
 #define stCOM_WRN_SYS_DISABLED_PALLET (-1610481638)
 #define stCOM_WRN_SYS_TOO_MANY_PALLETS (-1610481637)
 #define stCOM_WRN_SYS_RESET_REQUIRED (-1610481636)
 #define stCOM_WRN_SYS_PALLET_SETTLING (-1610481635)
 #define stCOM_WRN_SYS_CTRLR_HEALTH (-1610481634)
 #define stCOM_WRN_SYS_ABNORMAL_CONDITION (-1610481633)
 #define stCOM_WRN_SEC_RESERVED0 (-1610350592)
 #define stCOM_WRN_SEC_APPLICATION (-1610350591)
 #define stCOM_WRN_SEC_MISSING_LICENSE (-1610350590)
 #define stCOM_WRN_SEC_RESERVED3 (-1610350589)
 #define stCOM_WRN_SEC_TEMP_SENSOR (-1610350588)
 #define stCOM_WRN_SEC_HIGH_TEMP (-1610350587)
 #define stCOM_WRN_SEC_UNCERTAIN_POSITION (-1610350586)
 #define stCOM_WRN_SEC_GATEWAY_NETWORK (-1610350585)
 #define stCOM_WRN_SEC_COIL_CURRENT_I2T (-1610350584)
 #define stCOM_WRN_SEC_COIL_RESPONSE (-1610350583)
 #define stCOM_WRN_SEC_RESERVED10 (-1610350582)
 #define stCOM_WRN_SEC_PALLET_POS_CORR (-1610350581)
 #define stCOM_WRN_SEC_PALLET_ID_TAG (-1610350580)
 #define stCOM_WRN_SEC_DUPLICATE_PALLET (-1610350579)
 #define stCOM_WRN_SEC_PALLET_DEADLOCK (-1610350578)
 #define stCOM_WRN_SEC_ENCOD_COUNTS (-1610350577)
 #define stCOM_WRN_SEC_ENCOD_READINGS (-1610350576)
 #define stCOM_WRN_SEC_INVALID_REGION (-1610350575)
 #define stCOM_WRN_SEC_INVALID_PARAMETER (-1610350574)
 #define stCOM_WRN_SEC_COMMAND_FAILED (-1610350573)
 #define stCOM_WRN_SEC_INVALID_SYNC_ZONE (-1610350572)
 #define stCOM_WRN_SEC_ENCOD_READ (-1610350571)
 #define stCOM_WRN_SEC_COIL_DRIVER (-1610350570)
 #define stCOM_WRN_SEC_PARAM_SAVE_REQ (-1610350569)
 #define stCOM_WRN_SEC_DESTINATION_UPDATE (-1610350568)
 #define stCOM_WRN_SEC_ENCOD_COMM (-1610350567)
 #define stCOM_WRN_SEC_DISABLED_PALLET (-1610350566)
 #define stCOM_WRN_SEC_TOO_MANY_PALLETS (-1610350565)
 #define stCOM_WRN_SEC_RESET_REQUIRED (-1610350564)
 #define stCOM_WRN_SEC_PALLET_SETTLING (-1610350563)
 #define stCOM_WRN_SEC_CTRLR_HEALTH (-1610350562)
 #define stCOM_WRN_SEC_ABNORMAL_CONDITION (-1610350561)
 #define stCOM_ERR_FB_INSTANCE_REG (-536805375)
 #define stCOM_ERR_WRONG_PARAMETER (-536805373)
 #define stCOM_ERR_COMMUNICAITON_TIME_OUT (-536805372)
 #define stCOM_ERR_NO_STCONTROL_REG (-536805371)
 #define stCOM_ERR_SUPERTRAK_SYS (-536805370)
 #define stCOM_ERR_WRONG_CONFIG (-536805369)
 #define stCOM_ERR_CMD_NOT_EXECUTED (-536805368)
 #define stCOM_ERR_SUPERTRAK_SEC (-536805367)
 #define stCOM_ERR_SERVICE_CHANNEL_FAULT (-536805366)
 #define stCOM_ERR_CMD_HANDSHAKE (-536805365)
 #define stCOM_ERR_SYS_MOTOR_SUPPLY (-536739840)
 #define stCOM_ERR_SYS_RESERVED1 (-536739839)
 #define stCOM_ERR_SYS_RESERVED2 (-536739838)
 #define stCOM_ERR_SYS_RESERVED3 (-536739837)
 #define stCOM_ERR_SYS_COIL_CURRENT (-536739836)
 #define stCOM_ERR_SYS_HIGH_TEMP (-536739835)
 #define stCOM_ERR_SYS_RESERVED6 (-536739834)
 #define stCOM_ERR_SYS_GATEWAY_NETWORK (-536739833)
 #define stCOM_ERR_SYS_COIL_CURRENT_I2T (-536739832)
 #define stCOM_ERR_SYS_COIL_RESPONSE (-536739831)
 #define stCOM_ERR_SYS_RESERVED10 (-536739830)
 #define stCOM_ERR_SYS_COIL_DRIVER_OFF (-536739829)
 #define stCOM_ERR_SYS_RESERVED12 (-536739828)
 #define stCOM_ERR_SYS_RESERVED13 (-536739827)
 #define stCOM_ERR_SYS_ENCOD_CALIBRATION (-536739826)
 #define stCOM_ERR_SYS_PALLET_LAG_ERROR (-536739825)
 #define stCOM_ERR_SYS_PALLET_DETECTION (-536739824)
 #define stCOM_ERR_SYS_RESERVED17 (-536739823)
 #define stCOM_ERR_SYS_RESERVED18 (-536739822)
 #define stCOM_ERR_SYS_COLLISION_DEADLOCK (-536739821)
 #define stCOM_ERR_SYS_LOST_FEEDBACK (-536739820)
 #define stCOM_ERR_SYS_ENCOD_READ_ERROR (-536739819)
 #define stCOM_ERR_SYS_COIL_DRIVER_ERROR (-536739818)
 #define stCOM_ERR_SYS_CONFLICTING_PALLET (-536739817)
 #define stCOM_ERR_SYS_COMM_TIMEOUT (-536739816)
 #define stCOM_ERR_SYS_ENCOD_COMM_ERROR (-536739815)
 #define stCOM_ERR_SYS_DISABLED_PALLET (-536739814)
 #define stCOM_ERR_SYS_ABNORMAL_CONDITION (-536739813)
 #define stCOM_ERR_SYS_SECTION_DISABLED (-536739812)
 #define stCOM_ERR_SYS_RESERVED29 (-536739811)
 #define stCOM_ERR_SYS_HARDWARE_INIT (-536739810)
 #define stCOM_ERR_SYS_FATAL_CONDITION (-536739809)
 #define stCOM_ERR_SEC_MOTOR_SUPPLY (-536608768)
 #define stCOM_ERR_SEC_RESERVED1 (-536608767)
 #define stCOM_ERR_SEC_MISSING_LICENSE (-536608766)
 #define stCOM_ERR_SEC_RESERVED3 (-536608765)
 #define stCOM_ERR_SEC_COIL_CURRENT (-536608764)
 #define stCOM_ERR_SEC_HIGH_TEMP (-536608763)
 #define stCOM_ERR_SEC_RESERVED6 (-536608762)
 #define stCOM_ERR_SEC_GATEWAY_NETWORK (-536608761)
 #define stCOM_ERR_SEC_COIL_CURRENT_I2T (-536608760)
 #define stCOM_ERR_SEC_COIL_RESPONSE (-536608759)
 #define stCOM_ERR_SEC_RESERVED10 (-536608758)
 #define stCOM_ERR_SEC_COIL_DRIVER_OFF (-536608757)
 #define stCOM_ERR_SEC_RESERVED12 (-536608756)
 #define stCOM_ERR_SEC_RESERVED13 (-536608755)
 #define stCOM_ERR_SEC_ENCOD_CALIBRATION (-536608754)
 #define stCOM_ERR_SEC_PALLET_LAG_ERROR (-536608753)
 #define stCOM_ERR_SEC_PALLET_DETECTION (-536608752)
 #define stCOM_ERR_SEC_RESERVED17 (-536608751)
 #define stCOM_ERR_SEC_RESERVED18 (-536608750)
 #define stCOM_ERR_SEC_COLLISION_DEADLOCK (-536608749)
 #define stCOM_ERR_SEC_LOST_FEEDBACK (-536608748)
 #define stCOM_ERR_SEC_ENCOD_READ_ERROR (-536608747)
 #define stCOM_ERR_SEC_COIL_DRIVER_ERROR (-536608746)
 #define stCOM_ERR_SEC_CONFLICTING_PALLET (-536608745)
 #define stCOM_ERR_SEC_COMM_TIMEOUT (-536608744)
 #define stCOM_ERR_SEC_ENCOD_COMM_ERROR (-536608743)
 #define stCOM_ERR_SEC_DISABLED_PALLET (-536608742)
 #define stCOM_ERR_SEC_ABNORMAL_CONDITION (-536608741)
 #define stCOM_ERR_SEC_SECTION_DISABLED (-536608740)
 #define stCOM_ERR_SEC_TOO_MANY_PALLETS (-536608739)
 #define stCOM_ERR_SEC_HARDWARE_INIT (-536608738)
 #define stCOM_ERR_SEC_FATAL_CONDITION (-536608737)
 #define stCOM_CONFIG_MIN_OFFSETCENTER (-174.0f)
 #define stCOM_CONFIG_MIN_TARGETOFFSET (-500.0f)
 #define stCOM_CONFIG_MIN_INCREMENTOFFSET (-500.0f)
 #define stCOM_RELEASE_TO_TARGET_INCR_MIN (-32.0f)
 #define stCOM_CONFIG_MIN_FILTERSTAT 0.0f
 #define stCOM_NO_ERROR 0
 #define stCOM_SC_CODE_SUCCESS 0U
 #define stCOM_CONFIG_MIN_FILTERMOVING 0.0f
 #define stCOM_CONFIG_MAX_FILTERSTAT 1.0f
 #define stCOM_SC_CODE_WRONG_SECTION_ID 1U
 #define stCOM_CONFIG_MAX_FILTERMOVING 1.0f
 #define stCOM_SC_CODE_WRONG_PAR_ID 2U
 #define stCOM_CONFIG_FB_ID_STCONTROL 4096U
 #define stCOM_CONFIG_FB_ID_STTARGET 8192U
 #define stCOM_CONFIG_FB_ID_STPALLET 12288U
 #define stCOM_CONFIG_FB_ID_STSECTION 16384U
 #define stCOM_CONFIG_FB_ID_STREADPAR 20480U
 #define stCOM_CONFIG_FB_ID_STWRITEPAR 24576U
 #define stCOM_CONFIG_FB_ID_STADVCMD 28672U
 #define stCOM_SC_CODE_WRONG_TASK 3U
 #define stCOM_CONFIG_CMD_IF_BYTE_STRUCT 4U
 #define stCOM_SC_CODE_TASK_UNAVAILABLE 4U
 #define stCOM_CONFIG_SERV_CH_TASK_READ 5U
 #define stCOM_SC_CODE_WRONG_PAR_IDX 6U
 #define stCOM_CONFIG_SERV_CH_TASK_WRITE 6U
 #define stCOM_SC_CODE_WRONG_PAR_VALUE 7U
 #define stCOM_SC_CODE_WRONG_PAR_COUNT 8U
 #define stCOM_SC_CODE_TIMEOUT 10U
 #define stCOM_SC_CODE_NOT_AUTHORIZED 13U
 #define stCOM_SC_CODE_INVALID_PACKET 14U
 #define stCOM_CONFIG_MAX_CONTROLGAINIDX 15U
 #define stCOM_SC_CODE_INTERNAL_ERROR 15U
 #define stCOM_RELEASE_TO_TARGET_INCR_MAX 32.0f
 #define stCOM_CONFIG_MAX_NR_OF_COMMANDS 64U
 #define stCOM_CONFIG_NR_OF_SECTIONS 64U
 #define stCOM_CONFIG_MIN_SHELF_WIDTH 152.0f
 #define stCOM_CONFIG_MAX_MOVECONFIGIDX 243.0f
 #define stCOM_CONFIG_SIZE_OF_LOG_DATA 250U
 #define stCOM_CONFIG_MAX_NR_OF_PALLETS 255U
 #define stCOM_CONFIG_MAX_NR_OF_TARGETS 252U
 #define stCOM_CONFIG_MAX_INCREMENTOFFSET 500.0f
 #define stCOM_CONFIG_MAX_OFFSETCENTER 174.0f
 #define stCOM_CONFIG_MAX_TARGETOFFSET 500.0f
 #define stCOM_CONFIG_MAX_SHELF_WIDTH 500.0f
 #define stCOM_SC_SAVE_PARAMTER_CODE 971U
 #define stCOM_CONFIG_SERV_CH_MAX_DATA 1024U
 #define stCOM_CONFIG_MAX_NR_OF_FBS 1024U
 #define stCOM_PNU_SYSTEM_NAME 1053U
 #define stCOM_PNU_ENABLE_CONTROL 1057U
 #define stCOM_PNU_SECTION_COUNT 1080U
 #define stCOM_PNU_CMD_IF_OPTIONS 1430U
 #define stCOM_PNU_CMD_IF_SECTIONS 1432U
 #define stCOM_PNU_CMD_IF_TARGETS 1434U
 #define stCOM_PNU_CMD_IF_COMMANDS 1436U
 #define stCOM_CONFIG_MIN_PALLET_VEL 10.0f
 #define stCOM_CONFIG_MAX_PALLET_VEL 4000.0f
 #define stCOM_SC_SAVE_PARAMTER_CMD 60030U
 #define stCOM_CONFIG_MIN_PALLET_ACC 1000.0f
 #define stCOM_CONFIG_MAX_PALLET_ACC 60000.0f
 #define stCOM_SUCC_FB_REGISTRATION 536936749
 #define stCOM_SUCC_PARAM_VALID 536936750
 #define stCOM_INFO_COMM_STRUCT_TOO_BIG 1610678473
 #define stCOM_EXT_LOGGING_ENABLE 0
 #define stCOM_CONFIG_COMMANDS_MINUS_ONE 63U
 #define stCOM_CONFIG_FBS_MINUS_ONE 1023U
 #define stCOM_CONFIG_PALLETS_MINUS_ONE 254U
 #define stCOM_CONFIG_TARGETS_MINUS_ONE 251U
 #define stCOM_CONFIG_SECTIONS_MINUS_ONE 63U
 #define stCOM_CONFIG_SERV_CH_MAX_DATA_M1 1023U
 #define stCOM_CONFIG_COMM_TIME_OUT 60000
#else
 _GLOBAL_CONST plcstring stCOM_CONFIG_VERSION[9];
 _GLOBAL_CONST signed long stCOM_WRN_SUPERTRAK_SYS;
 _GLOBAL_CONST signed long stCOM_WRN_SUPERTRAK_SEC;
 _GLOBAL_CONST signed long stCOM_WRN_ENABLE_SIGNAL_SOURCE;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESERVED0;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_APPLICATION;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESERVED2;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESERVED3;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_TEMP_SENSOR;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_HIGH_TEMP;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESERVED6;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_GATEWAY_NETWORK;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_COIL_CURRENT_I2T;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_COIL_RESPONSE;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESERVED10;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_PALLET_POS_CORR;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_PALLET_ID_TAG;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_DUPLICATE_PALLET;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESERVED14;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_ENCOD_COUNTS;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_ENCOD_READINGS;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_INVALID_REGION;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_INVALID_PARAMETER;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_COMMAND_FAILED;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_INVALID_SYNC_ZONE;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_ENCOD_READ;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_COIL_DRIVER;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_PARAM_SAVE_REQ;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_DESTINATION_UPDATE;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_ENCOD_COMM;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_DISABLED_PALLET;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_TOO_MANY_PALLETS;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_RESET_REQUIRED;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_PALLET_SETTLING;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_CTRLR_HEALTH;
 _GLOBAL_CONST signed long stCOM_WRN_SYS_ABNORMAL_CONDITION;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_RESERVED0;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_APPLICATION;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_MISSING_LICENSE;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_RESERVED3;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_TEMP_SENSOR;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_HIGH_TEMP;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_UNCERTAIN_POSITION;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_GATEWAY_NETWORK;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_COIL_CURRENT_I2T;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_COIL_RESPONSE;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_RESERVED10;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_PALLET_POS_CORR;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_PALLET_ID_TAG;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_DUPLICATE_PALLET;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_PALLET_DEADLOCK;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_ENCOD_COUNTS;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_ENCOD_READINGS;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_INVALID_REGION;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_INVALID_PARAMETER;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_COMMAND_FAILED;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_INVALID_SYNC_ZONE;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_ENCOD_READ;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_COIL_DRIVER;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_PARAM_SAVE_REQ;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_DESTINATION_UPDATE;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_ENCOD_COMM;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_DISABLED_PALLET;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_TOO_MANY_PALLETS;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_RESET_REQUIRED;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_PALLET_SETTLING;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_CTRLR_HEALTH;
 _GLOBAL_CONST signed long stCOM_WRN_SEC_ABNORMAL_CONDITION;
 _GLOBAL_CONST signed long stCOM_ERR_FB_INSTANCE_REG;
 _GLOBAL_CONST signed long stCOM_ERR_WRONG_PARAMETER;
 _GLOBAL_CONST signed long stCOM_ERR_COMMUNICAITON_TIME_OUT;
 _GLOBAL_CONST signed long stCOM_ERR_NO_STCONTROL_REG;
 _GLOBAL_CONST signed long stCOM_ERR_SUPERTRAK_SYS;
 _GLOBAL_CONST signed long stCOM_ERR_WRONG_CONFIG;
 _GLOBAL_CONST signed long stCOM_ERR_CMD_NOT_EXECUTED;
 _GLOBAL_CONST signed long stCOM_ERR_SUPERTRAK_SEC;
 _GLOBAL_CONST signed long stCOM_ERR_SERVICE_CHANNEL_FAULT;
 _GLOBAL_CONST signed long stCOM_ERR_CMD_HANDSHAKE;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_MOTOR_SUPPLY;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED1;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED2;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED3;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COIL_CURRENT;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_HIGH_TEMP;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED6;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_GATEWAY_NETWORK;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COIL_CURRENT_I2T;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COIL_RESPONSE;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED10;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COIL_DRIVER_OFF;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED12;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED13;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_ENCOD_CALIBRATION;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_PALLET_LAG_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_PALLET_DETECTION;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED17;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED18;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COLLISION_DEADLOCK;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_LOST_FEEDBACK;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_ENCOD_READ_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COIL_DRIVER_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_CONFLICTING_PALLET;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_COMM_TIMEOUT;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_ENCOD_COMM_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_DISABLED_PALLET;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_ABNORMAL_CONDITION;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_SECTION_DISABLED;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_RESERVED29;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_HARDWARE_INIT;
 _GLOBAL_CONST signed long stCOM_ERR_SYS_FATAL_CONDITION;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_MOTOR_SUPPLY;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED1;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_MISSING_LICENSE;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED3;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COIL_CURRENT;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_HIGH_TEMP;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED6;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_GATEWAY_NETWORK;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COIL_CURRENT_I2T;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COIL_RESPONSE;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED10;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COIL_DRIVER_OFF;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED12;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED13;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_ENCOD_CALIBRATION;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_PALLET_LAG_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_PALLET_DETECTION;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED17;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_RESERVED18;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COLLISION_DEADLOCK;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_LOST_FEEDBACK;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_ENCOD_READ_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COIL_DRIVER_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_CONFLICTING_PALLET;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_COMM_TIMEOUT;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_ENCOD_COMM_ERROR;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_DISABLED_PALLET;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_ABNORMAL_CONDITION;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_SECTION_DISABLED;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_TOO_MANY_PALLETS;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_HARDWARE_INIT;
 _GLOBAL_CONST signed long stCOM_ERR_SEC_FATAL_CONDITION;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_OFFSETCENTER;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_TARGETOFFSET;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_INCREMENTOFFSET;
 _GLOBAL_CONST float stCOM_RELEASE_TO_TARGET_INCR_MIN;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_FILTERSTAT;
 _GLOBAL_CONST signed long stCOM_NO_ERROR;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_SUCCESS;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_FILTERMOVING;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_FILTERSTAT;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_WRONG_SECTION_ID;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_FILTERMOVING;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_WRONG_PAR_ID;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STCONTROL;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STTARGET;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STPALLET;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STSECTION;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STREADPAR;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STWRITEPAR;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FB_ID_STADVCMD;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_WRONG_TASK;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_CMD_IF_BYTE_STRUCT;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_TASK_UNAVAILABLE;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_SERV_CH_TASK_READ;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_WRONG_PAR_IDX;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_SERV_CH_TASK_WRITE;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_WRONG_PAR_VALUE;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_WRONG_PAR_COUNT;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_TIMEOUT;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_NOT_AUTHORIZED;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_INVALID_PACKET;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_MAX_CONTROLGAINIDX;
 _GLOBAL_CONST unsigned char stCOM_SC_CODE_INTERNAL_ERROR;
 _GLOBAL_CONST float stCOM_RELEASE_TO_TARGET_INCR_MAX;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_MAX_NR_OF_COMMANDS;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_NR_OF_SECTIONS;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_SHELF_WIDTH;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_MOVECONFIGIDX;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_SIZE_OF_LOG_DATA;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_MAX_NR_OF_PALLETS;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_MAX_NR_OF_TARGETS;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_INCREMENTOFFSET;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_OFFSETCENTER;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_TARGETOFFSET;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_SHELF_WIDTH;
 _GLOBAL_CONST unsigned short stCOM_SC_SAVE_PARAMTER_CODE;
 _GLOBAL_CONST unsigned long stCOM_CONFIG_SERV_CH_MAX_DATA;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_MAX_NR_OF_FBS;
 _GLOBAL_CONST unsigned short stCOM_PNU_SYSTEM_NAME;
 _GLOBAL_CONST unsigned short stCOM_PNU_ENABLE_CONTROL;
 _GLOBAL_CONST unsigned short stCOM_PNU_SECTION_COUNT;
 _GLOBAL_CONST unsigned short stCOM_PNU_CMD_IF_OPTIONS;
 _GLOBAL_CONST unsigned short stCOM_PNU_CMD_IF_SECTIONS;
 _GLOBAL_CONST unsigned short stCOM_PNU_CMD_IF_TARGETS;
 _GLOBAL_CONST unsigned short stCOM_PNU_CMD_IF_COMMANDS;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_PALLET_VEL;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_PALLET_VEL;
 _GLOBAL_CONST unsigned long stCOM_SC_SAVE_PARAMTER_CMD;
 _GLOBAL_CONST float stCOM_CONFIG_MIN_PALLET_ACC;
 _GLOBAL_CONST float stCOM_CONFIG_MAX_PALLET_ACC;
 _GLOBAL_CONST signed long stCOM_SUCC_FB_REGISTRATION;
 _GLOBAL_CONST signed long stCOM_SUCC_PARAM_VALID;
 _GLOBAL_CONST signed long stCOM_INFO_COMM_STRUCT_TOO_BIG;
 _GLOBAL_CONST plcbit stCOM_EXT_LOGGING_ENABLE;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_COMMANDS_MINUS_ONE;
 _GLOBAL_CONST unsigned short stCOM_CONFIG_FBS_MINUS_ONE;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_PALLETS_MINUS_ONE;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_TARGETS_MINUS_ONE;
 _GLOBAL_CONST unsigned char stCOM_CONFIG_SECTIONS_MINUS_ONE;
 _GLOBAL_CONST unsigned long stCOM_CONFIG_SERV_CH_MAX_DATA_M1;
 _GLOBAL_CONST plctime stCOM_CONFIG_COMM_TIME_OUT;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum StParamAdvReleaseConfigDirEnum
{	stCOM_DIR_LEFT = 0,
	stCOM_DIR_RIGHT = 1
} StParamAdvReleaseConfigDirEnum;

typedef enum StParamReleaseConfigEnum
{	stCOM_RELEASE_CONFIG_1 = 0,
	stCOM_RELEASE_CONFIG_2 = 1,
	stCOM_RELEASE_CONFIG_3 = 2
} StParamReleaseConfigEnum;

typedef enum StControlStepEnum
{	ST_CTRL_STATE_INIT = 0,
	ST_CTRL_STATE_INIT_CHECK_CONFIG = 1,
	ST_CTRL_STATE_CREATE_LOGBOOK = 2,
	ST_CTRL_STATE_REGISTER_FB = 3,
	ST_CTRL_STATE_INIT_CHECK_PAR = 4,
	ST_CTRL_STATE_READ_NR_SECTIONS = 5,
	ST_CTRL_STATE_READ_SYS_NAME = 6,
	ST_CTRL_STATE_READ_ENABLE_CTRL = 7,
	ST_CTRL_STATE_ENABLE_CTRL_IF = 8,
	ST_CTRL_STATE_UPDATE_COM_STRUCT = 9,
	ST_CTRL_STATE_OPERATION = 10,
	ST_CTRL_STATE_ERROR = 255
} StControlStepEnum;

typedef enum StControlUpdateComStructEnum
{	ST_CTRL_STATE_WRITE_NR_SECTIONS = 0,
	ST_CTRL_STATE_WRITE_NR_TARGETS = 1,
	ST_CTRL_STATE_WRITE_NR_COMMANDS = 2,
	ST_CTRL_STATE_WRITE_NR_IOS = 3,
	ST_CTRL_STATE_SAVE_ST_PARAMETERS = 4,
	ST_CTRL_STATE_WRITE_DONE = 5
} StControlUpdateComStructEnum;

typedef enum StCtrlServChannelStepEnum
{	ST_CTRL_SERV_CH_STATE_WAIT_CMD = 0,
	ST_CTRL_SERV_CH_STATE_REQ = 1,
	ST_CTRL_SERV_CH_STATE_WAIT_RES = 2,
	ST_CTRL_SERV_CH_STATE_CPY_RES = 3
} StCtrlServChannelStepEnum;

typedef enum StControlInfoStEnableSourceEnum
{	stCOM_SECTION_CONTROL = 0,
	stCOM_SYSTEM_CONTROL = 1,
	stCOM_SERVICE_CHANNEL_CONTROL = 2,
	stCOM_INFORMATION_NOT_VALID = 255
} StControlInfoStEnableSourceEnum;

typedef enum StTargetStepEnum
{	ST_TARG_STATE_INIT = 0,
	ST_TARG_STATE_INIT_CHECK_CONFIG = 1,
	ST_TARG_STATE_INIT_REG_FB = 2,
	ST_TARG_STATE_INIT_CHECK_PAR = 3,
	ST_TARG_STATE_OPERATION = 4,
	ST_TARG_STATE_ERROR = 255
} StTargetStepEnum;

typedef enum StTargetExtStepEnum
{	ST_TRGX_STATE_INIT = 0,
	ST_TRGX_STATE_INIT_CHECK_CONFIG = 1,
	ST_TRGX_STATE_INIT_REG_FB = 3,
	ST_TRGX_STATE_INIT_CHECK_PAR = 4,
	ST_TRGX_STATE_OPERATION = 5,
	ST_TRGX_STATE_ERROR = 255
} StTargetExtStepEnum;

typedef enum StTargetExtSubStepEnum
{	ST_TRGX_SUB_WAIT_CMD = 0,
	ST_TRGX_SUB_RELEASE_PALLET = 1,
	ST_TRGX_SUB_RELEASE_TO_TARGET = 2,
	ST_TRGX_SUB_RELEASE_TO_OFFSET = 3,
	ST_TRGX_SUB_INCREMENT_OFFSET = 4,
	ST_TRGX_SUB_SET_PALLET_ID = 5,
	ST_TRGX_SUB_SET_PALLET_MOTION = 6,
	ST_TRGX_SUB_SET_PALLET_SHELF = 7,
	ST_TRGX_SUB_SET_PALLET_GAIN = 8
} StTargetExtSubStepEnum;

typedef enum StPalletStepEnum
{	ST_PALL_STATE_INIT = 0,
	ST_PALL_STATE_INIT_CHECK_CONFIG = 1,
	ST_PALL_STATE_INIT_REG_FB = 3,
	ST_PALL_STATE_INIT_CHECK_PAR = 4,
	ST_PALL_STATE_OPERATION = 5,
	ST_PALL_STATE_ERROR = 255
} StPalletStepEnum;

typedef enum StPalletSubStepEnum
{	ST_PALL_SUB_WAIT_CMD = 0,
	ST_PALL_SUB_RELEASE_TO_TARGET = 2,
	ST_PALL_SUB_RELEASE_TO_OFFSET = 3,
	ST_PALL_SUB_INCREMENT_OFFSET = 4,
	ST_PALL_SUB_SET_PALLET_MOTION = 6,
	ST_PALL_SUB_SET_PALLET_SHELF = 7,
	ST_PALL_SUB_SET_PALLET_GAIN = 8
} StPalletSubStepEnum;

typedef enum StSectionStepEnum
{	ST_SECT_STATE_INIT = 0,
	ST_SECT_STATE_INIT_CHECK_CONFIG = 1,
	ST_SECT_STATE_INIT_REG_FB = 2,
	ST_SECT_STATE_INIT_CHECK_PAR = 3,
	ST_SECT_STATE_OPERATION = 4,
	ST_SECT_STATE_ERROR = 255
} StSectionStepEnum;

typedef enum StReadPnuStepEnum
{	ST_RPAR_STATE_INIT = 0,
	ST_RPAR_STATE_INIT_CHECK_CONFIG = 1,
	ST_RPAR_STATE_INIT_REG_FB = 2,
	ST_RPAR_STATE_INIT_CHECK_PAR = 3,
	ST_RPAR_STATE_OPERATION = 4,
	ST_RPAR_STATE_ERROR = 255
} StReadPnuStepEnum;

typedef enum StWritePnuStepEnum
{	ST_WPAR_STATE_INIT = 0,
	ST_WPAR_STATE_INIT_CHECK_CONFIG = 1,
	ST_WPAR_STATE_INIT_REG_FB = 2,
	ST_WPAR_STATE_INIT_CHECK_PAR = 3,
	ST_WPAR_STATE_OPERATION = 4,
	ST_WPAR_STATE_ERROR = 255
} StWritePnuStepEnum;

typedef enum StAdvCmdStepEnum
{	ST_ACMD_STATE_INIT = 0,
	ST_ACMD_STATE_INIT_CHECK_CONFIG = 1,
	ST_ACMD_STATE_INIT_REG_FB = 2,
	ST_ACMD_STATE_INIT_CHECK_PAR = 3,
	ST_ACMD_STATE_OPERATION = 4,
	ST_ACMD_STATE_ERROR = 255
} StAdvCmdStepEnum;

typedef enum StAdvCmdSubStepEnum
{	ST_ACMD_SUB_WAIT_CMD = 0,
	ST_ACMD_SUB_EXECUTE_CMD = 1
} StAdvCmdSubStepEnum;

typedef struct StLinkCmdPalletType
{	unsigned char Advanced[8];
} StLinkCmdPalletType;

typedef struct StLinkCmdTargetType
{	unsigned char Simple;
	unsigned char Advanced[8];
} StLinkCmdTargetType;

typedef struct StLinkCmdSectionType
{	plcbit Enable;
	plcbit Acknowledge;
} StLinkCmdSectionType;

typedef struct StLinkServChMessageType
{	unsigned short DataLength;
	unsigned char Task;
	unsigned short ParameterID;
	unsigned char SectionID;
	unsigned long StartIndex;
	unsigned short Count;
	unsigned long Data[1024];
} StLinkServChMessageType;

typedef struct StLinkCmdServChType
{	plcbit RequestOccupied;
	plcbit RequestAccepted;
	plcbit NewRequest;
	struct StLinkServChMessageType Request;
} StLinkCmdServChType;

typedef struct StLinkCmdCustomType
{	unsigned char Advanced[8];
} StLinkCmdCustomType;

typedef struct StLinkCommandType
{	struct StLinkCmdPalletType Pallet[255];
	struct StLinkCmdTargetType Target[252];
	struct StLinkCmdSectionType Section[64];
	struct StLinkCmdServChType ServiceChannel;
	struct StLinkCmdCustomType Custom[64];
} StLinkCommandType;

typedef struct StLinkStatusSystemType
{	plcbit Warning;
	plcbit Fault;
	plcbit HeartbeatOutput;
	unsigned short TotalPallets;
	enum StControlInfoStEnableSourceEnum EnableSignalSource;
} StLinkStatusSystemType;

typedef struct StLinkStatusTargetType
{	plcbit PalletPresent;
	plcbit PalletInPosition;
	plcbit PalletPreArrival;
	plcbit PalletOverTarget;
	plcbit ReleaseCommandError;
	unsigned char PalletID;
	unsigned char ActOffsetTableIndex;
	plcbit CmdCommunicationActive;
	unsigned char CmdBufferIdx;
	plcbit CommandComplete;
	plcbit CommandSuccess;
} StLinkStatusTargetType;

typedef struct StLinkStatusPalletType
{	plcbit CmdCommunicationActive;
	unsigned char CmdBufferIdx;
	plcbit CommandComplete;
	plcbit CommandSuccess;
} StLinkStatusPalletType;

typedef struct StLinkStatusSectionType
{	plcbit Enabled;
	plcbit UnrecognizedPallets;
	plcbit MotorPowerOn;
	plcbit PalletsRecovering;
	plcbit LocatingPallets;
	plcbit DisabledExternally;
	plcbit Warning;
	plcbit Fault;
} StLinkStatusSectionType;

typedef struct StLinkStatusServChType
{	unsigned long MaxRequestDataSize;
	unsigned long MaxResponseDataSize;
	plcbit ResponseAvailable;
	struct StLinkServChMessageType Response;
} StLinkStatusServChType;

typedef struct StLinkStatusCustomType
{	plcbit CmdCommunicationActive;
	unsigned char CmdBufferIdx;
	plcbit CommandComplete;
	plcbit CommandSuccess;
} StLinkStatusCustomType;

typedef struct StLinkStatusType
{	plcbit StatusValid;
	struct StLinkStatusSystemType System;
	struct StLinkStatusTargetType Target[252];
	struct StLinkStatusPalletType Pallet[255];
	struct StLinkStatusSectionType Section[64];
	struct StLinkStatusServChType ServiceChannel;
	struct StLinkStatusCustomType Custom[64];
} StLinkStatusType;

typedef struct StLinkLibStatSimType
{	plcbit PalletsCreated;
	unsigned short SimPalletReference[255];
} StLinkLibStatSimType;

typedef struct StLinkLibStatusType
{	ArEventLogIdentType LogBookIdent;
	unsigned short FbID[1024];
	struct StLinkLibStatSimType Simulation;
} StLinkLibStatusType;

typedef struct StLinkType
{	struct StLinkCommandType SuperTrakCommand;
	struct StLinkStatusType SuperTrakStatus;
	struct StLinkLibStatusType LibraryStatus;
} StLinkType;

typedef struct StParamAdvReleaseConfigType
{	enum StParamAdvReleaseConfigDirEnum Direction;
	unsigned char DestinationTarget;
	unsigned char MoveConfigIdx;
	unsigned char TargetOffsetIdx;
	float TargetOffset;
	float IncrementalOffset;
} StParamAdvReleaseConfigType;

typedef struct StParamPalletMotionConfigType
{	unsigned short Velocity;
	unsigned short Acceleration;
} StParamPalletMotionConfigType;

typedef struct StParamPalletShelfConfigType
{	float ShelfWidth;
	float OffsetFromCenter;
} StParamPalletShelfConfigType;

typedef struct StParamPalletCtrlConfigType
{	unsigned char ControlGainSetIdx;
	float FilterWeightMoving;
	float FilterWeightStationary;
} StParamPalletCtrlConfigType;

typedef struct StControlParType
{	unsigned char NrOfSections;
	unsigned char NrOfTargets;
	unsigned char NrOfPallets;
	unsigned char NrOfCommands;
} StControlParType;

typedef struct StControlInfoSuperTrakType
{	plcstring SystemName[33];
	unsigned short NrOfPallets;
	unsigned short NrOfSections;
	enum StControlInfoStEnableSourceEnum EnableSignalSource;
	plcbit SystemFaultActive;
	unsigned long SystemFaultBits;
	plcbit SystemWarningActive;
	unsigned long SystemWarningBits;
} StControlInfoSuperTrakType;

typedef struct StControlInfoLibraryType
{	plcstring Version[9];
	unsigned long StCtrlDataSize;
	unsigned long StStatDataSize;
	unsigned char RegisteredTargetFbs;
	unsigned char RegisteredPalletFbs;
	unsigned char RegisteredSectionFbs;
} StControlInfoLibraryType;

typedef struct StControlInfoType
{	struct StControlInfoSuperTrakType SuperTrak;
	struct StControlInfoLibraryType Library;
} StControlInfoType;

typedef struct StCtrlIntStCtrlOffsetType
{	unsigned long SystemControl;
	unsigned long SectionControl;
	unsigned long TargetRelease;
	unsigned long CommandTrigger;
	unsigned long Command;
	unsigned long VirtualInput;
	unsigned long End;
} StCtrlIntStCtrlOffsetType;

typedef struct StCtrlIntStStatOffsetType
{	unsigned long SystemStatus;
	unsigned long TotalPallets;
	unsigned long SectionStatus;
	unsigned long TargetStatus;
	unsigned long CommandComplete;
	unsigned long CommandSuccess;
	unsigned long VirtualOutput;
	unsigned long End;
} StCtrlIntStStatOffsetType;

typedef struct StControlInternalParCheckType
{	struct StCtrlIntStCtrlOffsetType ControlOffset;
	struct StCtrlIntStStatOffsetType StatusOffset;
} StControlInternalParCheckType;

typedef struct StControlInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit LogBookCreated;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	plcbit InitParCheckDone;
	plcbit ComStructUpdated;
	plcbit WarningActive;
	plcbit ErrorActive;
	plcbit FaultMsgRead;
	plcbit WarningMsgRead;
} StControlInternalStatusType;

typedef struct StControlInternalStCtrlSubType
{	unsigned char u1[8];
} StControlInternalStCtrlSubType;

typedef struct StControlInternalStCtrlType
{	unsigned short SystemControl;
	unsigned char SectionControl[64];
	unsigned char TargetRelease[65];
	unsigned char CommandTrigger[32];
	struct StControlInternalStCtrlSubType Command[64];
	unsigned char VirtualInput[16];
	struct StCtrlIntStCtrlOffsetType Offset;
} StControlInternalStCtrlType;

typedef struct StControlInternalStStatSubType
{	unsigned char Status;
	unsigned char PalletID;
	unsigned char OffsetIndex;
} StControlInternalStStatSubType;

typedef struct StControlInternalStStatType
{	unsigned short SystemStatus;
	unsigned short TotalPallets;
	unsigned char SectionStatus[64];
	struct StControlInternalStStatSubType TargetStatus[256];
	unsigned char CommandComplete[32];
	unsigned char CommandSuccess[32];
	unsigned char VirtualOutput[16];
	struct StCtrlIntStStatOffsetType Offset;
	unsigned short NrOfSections;
	unsigned char EnableSignalSource;
	unsigned long SystemFaults;
	unsigned long SystemWarnings;
	plcstring SystemName[33];
} StControlInternalStStatType;

typedef struct StCtrlInternalServChMsgType
{	unsigned short Length;
	unsigned char Sequence;
	unsigned char Task;
	unsigned short ParameterID;
	unsigned char SectionID;
	unsigned char Reserved0;
	unsigned long StartIndex;
	unsigned short Reserved1;
	unsigned short Count;
	unsigned long Data[1024];
} StCtrlInternalServChMsgType;

typedef struct StReadPnuParType
{	unsigned short ParameterNumber;
	unsigned char SectionID;
	unsigned long StartParameterIndex;
	unsigned short ParameterValueCount;
} StReadPnuParType;

typedef struct StWritePnuParType
{	unsigned long ValidDataSize;
	unsigned short ParameterNumber;
	unsigned char SectionID;
	unsigned long StartParameterIndex;
	unsigned short ParameterValueCount;
} StWritePnuParType;

typedef struct StControlInternalServChType
{	enum StCtrlServChannelStepEnum Step;
	struct StCtrlInternalServChMsgType RequestData;
	struct StCtrlInternalServChMsgType ResponseData;
	struct StReadPnuParType ReadParameters;
	struct StWritePnuParType WriteParameters;
	plcbit CmdReadParameter;
	plcbit CmdWriteParameter;
	plcbit CmdSaveParameter;
	plcbit CommActive;
	plcbit ParameterRead;
	plcbit ParameterWritten;
	plcbit ParameterSaved;
	unsigned long ReadData[1024];
	unsigned long WriteData[1024];
	unsigned long ValidReadDataSize;
} StControlInternalServChType;

typedef struct StControlInternalType
{	enum StControlStepEnum Step;
	enum StControlUpdateComStructEnum UpdateComStructStep;
	struct StControlParType ParametersUsed;
	struct StControlInternalParCheckType ParameterCheck;
	plcbit UpdateComStruct;
	unsigned long Index;
	unsigned long Index2;
	struct StControlInternalStatusType Status;
	plcstring AddErrorInfo[251];
	ArEventLogRecordIDType LastLogEntryID;
	struct ArEventLogCreate ArEventLogCreate;
	struct ArEventLogGetIdent ArEventLogGetIdent;
	struct ArEventLogWrite ArEventLogWrite;
	struct TON CommunicationWatchdog;
	struct StControlInternalStCtrlType SuperTrakControl;
	struct StControlInternalStStatType SuperTrakStatus;
	struct StControlInternalServChType ServiceChannel;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit EnableAllSectionsOld;
	struct TON ErrorTimer;
	plcbit ErrorRead[32];
	plcbit WarningRead[32];
} StControlInternalType;

typedef struct StTargetParType
{	enum StParamReleaseConfigEnum ReleaseConfig;
} StTargetParType;

typedef struct StTargetInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
} StTargetInternalStatusType;

typedef struct StTargetInternalType
{	enum StTargetStepEnum Step;
	struct StTargetParType ParametersUsed;
	unsigned long Index;
	struct StTargetInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit ReleasePalletOld;
	unsigned char TargetOld;
	plcbit IgnoreResetParameter;
	plcbit CheckNewParID;
} StTargetInternalType;

typedef struct StTargetExtParPalletConfigType
{	unsigned char ID;
	struct StParamPalletMotionConfigType Motion;
	struct StParamPalletShelfConfigType Shelf;
	struct StParamPalletCtrlConfigType Controller;
} StTargetExtParPalletConfigType;

typedef struct StTargetExtParType
{	struct StParamAdvReleaseConfigType AdvancedReleaseConfig;
	enum StParamReleaseConfigEnum SimpleReleaseConfig;
	struct StTargetExtParPalletConfigType PalletConfig;
} StTargetExtParType;

typedef struct StTargetExtInternalParamCalcType
{	signed long IncrementalOffsetLarge;
	signed short IncrementalOffsetSmall;
	signed long TargetOffsetLarge;
	unsigned short Velocity;
	unsigned short Acceleration;
	unsigned short ShelfWidth;
	signed short OffsetFromCenter;
	unsigned char ControlGain;
	unsigned char ControlFilterMoving;
	unsigned char ControlFilterStationary;
} StTargetExtInternalParamCalcType;

typedef struct StTargetExtInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
} StTargetExtInternalStatusType;

typedef struct StTargetExtInternalType
{	enum StTargetExtStepEnum Step;
	enum StTargetExtSubStepEnum SubStep;
	struct StTargetExtParType ParametersUsed;
	struct StTargetExtInternalParamCalcType ParametersUsedCalc;
	unsigned long Index;
	struct StTargetExtInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit ReleasePalletOld;
	plcbit ReleaseToTargetOld;
	plcbit ReleaseToOffsetOld;
	plcbit IncrementOffsetOld;
	plcbit SetPalletIdOld;
	plcbit SetPalletMotionParOld;
	plcbit SetPalletShelfOld;
	plcbit SetPalletGainOld;
	unsigned char TargetOld;
	plcbit IgnoreResetParameter;
	plcbit CheckNewParID;
} StTargetExtInternalType;

typedef struct StPalletParPalletConfigType
{	struct StParamPalletMotionConfigType Motion;
	struct StParamPalletShelfConfigType Shelf;
	struct StParamPalletCtrlConfigType Controller;
} StPalletParPalletConfigType;

typedef struct StPalletParType
{	struct StParamAdvReleaseConfigType AdvancedReleaseConfig;
	struct StPalletParPalletConfigType PalletConfig;
} StPalletParType;

typedef struct StPalletInternalParamCalcType
{	signed long IncrementalOffsetLarge;
	signed short IncrementalOffsetSmall;
	signed long TargetOffsetLarge;
	unsigned short Velocity;
	unsigned short Acceleration;
	unsigned short ShelfWidth;
	signed short OffsetFromCenter;
	unsigned char ControlGain;
	unsigned char ControlFilterMoving;
	unsigned char ControlFilterStationary;
} StPalletInternalParamCalcType;

typedef struct StPalletInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
} StPalletInternalStatusType;

typedef struct StPalletInternalType
{	enum StPalletStepEnum Step;
	enum StPalletSubStepEnum SubStep;
	struct StPalletParType ParametersUsed;
	struct StPalletInternalParamCalcType ParametersUsedCalc;
	unsigned long Index;
	struct StPalletInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit ReleasePalletOld;
	plcbit ReleaseToTargetOld;
	plcbit ReleaseToOffsetOld;
	plcbit IncrementOffsetOld;
	plcbit SetPalletMotionParOld;
	plcbit SetPalletShelfOld;
	plcbit SetPalletGainOld;
	unsigned char PalletIdOld;
	plcbit IgnoreResetParameter;
	plcbit CheckNewParID;
} StPalletInternalType;

typedef struct StSectionParType
{	plcbit Reserved;
} StSectionParType;

typedef struct StSectionInfoSuperTrakType
{	plcbit SectionFaultActive;
	unsigned long SectionFaultBits;
	plcbit SectionWarningActive;
	unsigned long SectionWarningBits;
} StSectionInfoSuperTrakType;

typedef struct StSectionInfoType
{	struct StSectionInfoSuperTrakType SuperTrak;
} StSectionInfoType;

typedef struct StSectionInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
	plcbit WarningActive;
	plcbit ErrorActive;
	plcbit FaultMsgRead;
	plcbit WarningMsgRead;
} StSectionInternalStatusType;

typedef struct StSectionInternalServChType
{	struct StCtrlInternalServChMsgType RequestData;
	struct StCtrlInternalServChMsgType ResponseData;
	struct StReadPnuParType ReadParameters;
	struct StWritePnuParType WriteParameters;
	plcbit CmdReadParameter;
	plcbit CmdWriteParameter;
	plcbit CmdSaveParameter;
	plcbit CommActive;
	plcbit ParameterRead;
	plcbit ParameterWritten;
	plcbit ParameterSaved;
	unsigned long ReadData[1024];
	unsigned long WriteData[1024];
	unsigned long ValidReadDataSize;
} StSectionInternalServChType;

typedef struct StSectionInternalStStatType
{	unsigned long SectionFaults;
	unsigned long SectionWarnings;
} StSectionInternalStStatType;

typedef struct StSectionInternalType
{	enum StSectionStepEnum Step;
	struct StSectionParType ParametersUsed;
	unsigned long Index;
	struct StSectionInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	struct StSectionInternalServChType ServiceChannel;
	struct StSectionInternalStStatType SuperTrakStatus;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit EnableSectionOld;
	unsigned char SectionOld;
	plcbit IgnoreResetParameter;
	struct TON ErrorTimer;
	plcbit ErrorRead[32];
	plcbit WarningRead[32];
	unsigned short AcknowledgeScope;
} StSectionInternalType;

typedef struct StReadPnuInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
	plcbit CommActive;
} StReadPnuInternalStatusType;

typedef struct StReadPnuInternalType
{	enum StReadPnuStepEnum Step;
	struct StReadPnuParType ParametersUsed;
	unsigned long Index;
	struct StReadPnuInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit UpdateOld;
	plcbit ErrorResetOld;
	plcbit ReadCmdOld;
	plcbit ExecuteReading;
} StReadPnuInternalType;

typedef struct StReadInfoType
{	unsigned long MaxValidDataSize;
} StReadInfoType;

typedef struct StWritePnuInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
	plcbit CommActive;
} StWritePnuInternalStatusType;

typedef struct StWritePnuInternalType
{	enum StWritePnuStepEnum Step;
	struct StWritePnuParType ParametersUsed;
	unsigned long Index;
	struct StWritePnuInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit WriteCmdOld;
	plcbit SaveParCmdOld;
	plcbit ExecuteWriting;
	plcbit ExecuteSaving;
	signed long SaveParData;
} StWritePnuInternalType;

typedef struct StWriteInfoType
{	unsigned long MaxValidDataSize;
} StWriteInfoType;

typedef struct StAdvCmdParType
{	unsigned char CommandID;
	unsigned char Context;
	unsigned char Parameters[6];
} StAdvCmdParType;

typedef struct StAdvCmdInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	unsigned char FunctionBlockInstance;
	plcbit InitParCheckDone;
} StAdvCmdInternalStatusType;

typedef struct StAdvCmdInternalType
{	enum StAdvCmdStepEnum Step;
	enum StAdvCmdSubStepEnum SubStep;
	struct StAdvCmdParType ParametersUsed;
	unsigned long Index;
	struct StAdvCmdInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	plcbit SendCmdOld;
} StAdvCmdInternalType;

typedef struct StAdvCmd
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StAdvCmdParType* Parameters;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct StAdvCmdInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit SendCommand;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandDone;
} StAdvCmd_typ;

typedef struct StControl
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StControlParType* Parameters;
	unsigned long StCtrlData;
	unsigned long StCtrlDataSize;
	unsigned long StStatData;
	unsigned long StStatDataSize;
	unsigned long StServChRequestData;
	unsigned long StServChRequestDataSize;
	unsigned long StServChResponseData;
	unsigned long StServChResponseDataSize;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct StControlInfoType Info;
	/* VAR (analog) */
	struct StControlInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit EnableAllSections;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit SectionsEnabled;
} StControl_typ;

typedef struct StPallet
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StPalletParType* Parameters;
	unsigned char PalletID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct StPalletInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit ReleaseToTarget;
	plcbit ReleaseToOffset;
	plcbit IncrementOffset;
	plcbit SetPalletMotionPar;
	plcbit SetPalletShelf;
	plcbit SetPalletGain;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandDone;
} StPallet_typ;

typedef struct StReadPnu
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StReadPnuParType* Parameters;
	unsigned long DataAddress;
	unsigned long DataSize;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long ValidDataSize;
	struct StReadInfoType Info;
	/* VAR (analog) */
	struct StReadPnuInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Read;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandDone;
} StReadPnu_typ;

typedef struct StSection
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StSectionParType* Parameters;
	unsigned char Section;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct StSectionInfoType Info;
	/* VAR (analog) */
	struct StSectionInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit EnableSection;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit SectionEnabled;
	plcbit UnrecognizedPallets;
	plcbit MotorPowerOn;
	plcbit PalletsRecovering;
	plcbit LocatingPallets;
	plcbit DisabledExternally;
} StSection_typ;

typedef struct StTarget
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StTargetParType* Parameters;
	unsigned char Target;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned char PalletID;
	unsigned char PalletOffsetIdx;
	/* VAR (analog) */
	struct StTargetInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit ReleasePallet;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit PalletPresent;
	plcbit PalletInPosition;
	plcbit PalletPreArrival;
	plcbit PalletOverTarget;
	plcbit CommandBusy;
	plcbit CommandDone;
} StTarget_typ;

typedef struct StTargetExt
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StTargetExtParType* Parameters;
	unsigned char Target;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned char PalletID;
	unsigned char PalletOffsetIdx;
	/* VAR (analog) */
	struct StTargetExtInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit ReleasePallet;
	plcbit ReleaseToTarget;
	plcbit ReleaseToOffset;
	plcbit IncrementOffset;
	plcbit SetPalletID;
	plcbit SetPalletMotionPar;
	plcbit SetPalletShelf;
	plcbit SetPalletGain;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit PalletPresent;
	plcbit PalletInPosition;
	plcbit PalletPreArrival;
	plcbit PalletOverTarget;
	plcbit CommandBusy;
	plcbit CommandDone;
} StTargetExt_typ;

typedef struct StWritePnu
{
	/* VAR_INPUT (analog) */
	struct StLinkType* StLink;
	struct StWritePnuParType* Parameters;
	unsigned long DataAddress;
	unsigned long DataSize;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct StWriteInfoType Info;
	/* VAR (analog) */
	struct StWritePnuInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Write;
	plcbit SaveParamters;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandDone;
} StWritePnu_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void StAdvCmd(struct StAdvCmd* inst);
_BUR_PUBLIC void StControl(struct StControl* inst);
_BUR_PUBLIC void StPallet(struct StPallet* inst);
_BUR_PUBLIC void StReadPnu(struct StReadPnu* inst);
_BUR_PUBLIC void StSection(struct StSection* inst);
_BUR_PUBLIC void StTarget(struct StTarget* inst);
_BUR_PUBLIC void StTargetExt(struct StTargetExt* inst);
_BUR_PUBLIC void StWritePnu(struct StWritePnu* inst);


#ifdef __cplusplus
};
#endif
#endif /* _STCOM_ */

