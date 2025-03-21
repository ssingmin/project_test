/* Automation Studio generated header file */
/* Do not edit ! */
/* SuperTrak 0.48.0 */

#ifndef _SUPERTRAK_
#define _SUPERTRAK_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _SuperTrak_VERSION
#define _SuperTrak_VERSION 0.48.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "ArEventLog.h"
		#include "AsIOAcc.h"
#endif
#ifdef _SG4
		#include "ArEventLog.h"
		#include "AsIOAcc.h"
#endif
#ifdef _SGC
		#include "ArEventLog.h"
		#include "AsIOAcc.h"
#endif


/* Constants */
#ifdef _REPLACE_CONST
 #define EVENT_ID_GENERIC_ERROR (-536870912)
 #define EVENT_ID_GENERIC_WARNING (-1610612736)
 #define EVENT_ID_GENERIC_INFO 1610612736
 #define EVENT_ID_GENERIC_SUCCESS 536870912
 #define stPALLET_MODE_EXTERNAL 3U
 #define stPALLET_MODE_CAM 2U
 #define stPALLET_MODE_CNC 1U
 #define stPALLET_MODE_TRAJECTORY 0U
 #define stDATA_FILE_SYNC_MASTER_PARAMS 19U
 #define stDATA_FILE_SYNC_SERVOS 18U
 #define stDATA_FILE_SYNC_GLOBAL_PARAMS 17U
 #define stDATA_FILE_SIMULATION_CONFIG 16U
 #define stDATA_FILE_IO 15U
 #define stDATA_FILE_NETWORK_IO 14U
 #define stDATA_FILE_IR_TAG_CONFIG 13U
 #define stDATA_FILE_ENCODER_CONFIG 12U
 #define stDATA_FILE_CONTROL_GAIN 11U
 #define stDATA_FILE_ACCESS_CONTROL 10U
 #define stDATA_FILE_SECTION_PARAMS 9U
 #define stDATA_FILE_SYNCZONES_SANDBOX 8U
 #define stDATA_FILE_SYNCZONES 7U
 #define stDATA_FILE_OFFSETS 6U
 #define stDATA_FILE_PARAMETERS 5U
 #define stDATA_FILE_MOVE_CONFIG 4U
 #define stDATA_FILE_REGIONS 3U
 #define stDATA_FILE_TARGETS 2U
 #define stDATA_FILE_SYSTEM_LAYOUT 1U
 #define stIP_ADDR_MODE_BOOTP 3U
 #define stIP_ADDR_MODE_DHCP 2U
 #define stIP_ADDR_MODE_MANUAL 1U
 #define stIP_ADDR_MODE_NONE 0U
 #define stCONNECTION_MODBUSTCP 6U
 #define stCONNECTION_ETHERCAT 5U
 #define stCONNECTION_PROFINET 4U
 #define stCONNECTION_ETHERNETIP 3U
 #define stCONNECTION_POWERLINK 2U
 #define stCONNECTION_LOCAL 1U
 #define stCONNECTION_NONE 0U
 #define stDIRECTION_RIGHT 1U
 #define stDIRECTION_LEFT 0U
 #define scDATA_TYPE_LREAL 39U
 #define scDATA_TYPE_REAL 35U
 #define scDATA_TYPE_LINT 23U
 #define scDATA_TYPE_DINT 19U
 #define scDATA_TYPE_INT 17U
 #define scDATA_TYPE_SINT 16U
 #define scDATA_TYPE_ULINT 7U
 #define scDATA_TYPE_UDINT 3U
 #define scDATA_TYPE_UINT 1U
 #define scDATA_TYPE_USINT 0U
 #define scDATA_TYPE_BOOL 0U
 #define scTIMER_ABORT 65535U
 #define scSTATE_ERROR 9U
 #define scSTATE_SEND 3U
 #define scSTATE_WAIT 2U
 #define scSTATE_EXEC 1U
 #define scSTATE_RECV 0U
 #define scERR_INTERNAL_ERROR 15U
 #define scERR_INVALID_PACKET 14U
 #define scERR_BUFFER_SIZE 13U
 #define scERR_UNAUTHORIZED 11U
 #define scERR_COMMAND_TIMEOUT 10U
 #define scERR_INVALID_ARGUMENT 9U
 #define scERR_INVALID_COUNT 8U
 #define scERR_INVALID_VALUE 7U
 #define scERR_INVALID_INDEX 6U
 #define scERR_TASK_UNAVAILABLE 4U
 #define scERR_INVALID_TASK 3U
 #define scERR_INVALID_PARAM 2U
 #define scERR_INVALID_SECTION 1U
 #define scERR_SUCCESS 0U
 #define stPAR_POSITION_OFFSET 1660U
 #define stPAR_TARGET_POSITION 1651U
 #define stPAR_TARGET_SECTION 1650U
 #define stPAR_CPU_TEMPERATURE 1592U
 #define stPAR_STORAGE_DEVICE_WEAR 1591U
 #define stPAR_SOFTWARE_STARTUP_DONE 1579U
 #define stPAR_HARDWARE_SENSORS 1570U
 #define stPAR_TARGET_DOCKED_HPALLET 1553U
 #define stPAR_TARGET_PALLET_OFFSET 1552U
 #define stPAR_CALIBRATED_SECTION_LEN 1506U
 #define stPAR_PARAMETER_CHECKSUMS 1505U
 #define stPAR_SECTION_PALLET_COUNT 1502U
 #define stPAR_SECTION_FAULTS_ACTIVE 1480U
 #define stPAR_SYSTEM_FAULTS_ACTIVE 1460U
 #define stPAR_FIELDBUS_IF_NAME 1459U
 #define stPAR_FIELDBUS_IF_GATEWAY_ADDR 1453U
 #define stPAR_FIELDBUS_IF_NETWORK_MASK 1452U
 #define stPAR_FIELDBUS_IF_IP_ADDRESS 1451U
 #define stPAR_FIELDBUS_IF_ADDR_MODE 1450U
 #define stPAR_PLC_IF_FOLLOWER_COUNT 1446U
 #define stPAR_PLC_IF_SERV_CHAN_SIZE 1445U
 #define stPAR_PLC_IF_REVISION 1444U
 #define stPAR_PLC_IF_FOLLOWER_MAN_COUNT 1443U
 #define stPAR_PLC_IF_MASTER_COUNT 1442U
 #define stPAR_PLC_IF_SYNC_ZONE_COUNT 1440U
 #define stPAR_PLC_IF_SYNC_ZONE_START 1439U
 #define stPAR_PLC_IF_NETWORK_IO_COUNT 1438U
 #define stPAR_PLC_IF_NETWORK_IO_START 1437U
 #define stPAR_PLC_IF_COMMAND_COUNT 1436U
 #define stPAR_PLC_IF_TARGET_COUNT 1434U
 #define stPAR_PLC_IF_TARGET_START 1433U
 #define stPAR_PLC_IF_SECTION_COUNT 1432U
 #define stPAR_PLC_IF_SECTION_START 1431U
 #define stPAR_PLC_IF_OPTIONS 1430U
 #define stPAR_SYSTEM_AVERAGE_POWER 1398U
 #define stPAR_SYSTEM_PEAK_POWER 1397U
 #define stPAR_SYSTEM_LOAD_POWER 1396U
 #define stPAR_SYSTEM_INSTANT_POWER 1395U
 #define stPAR_SECTION_AVERAGE_POWER 1394U
 #define stPAR_SECTION_PEAK_POWER 1392U
 #define stPAR_SECTION_LOAD_POWER 1391U
 #define stPAR_SECTION_INSTANT_POWER 1390U
 #define stPAR_PALLET_CONTROL_MODE 1348U
 #define stPAR_PALLET_STATUS 1328U
 #define stPAR_PALLET_ID 1321U
 #define stPAR_LOAD_TARGET 1270U
 #define stPAR_RECOVERY_ACCELERATION 1255U
 #define stPAR_RECOVERY_VELOCITY 1254U
 #define stPAR_DEFAULT_ACCELERATION 1253U
 #define stPAR_DEFAULT_VELOCITY 1252U
 #define stPAR_MAXIMUM_ACCELERATION 1251U
 #define stPAR_MAXIMUM_VELOCITY 1250U
 #define stPAR_NETWORK_OUTPUT_FUNCTION 1230U
 #define stPAR_NETWORK_INPUT_FUNCTION 1220U
 #define stPAR_DIGITAL_OUTPUT_FUNCTION 1210U
 #define stPAR_DIGITAL_INPUT_FUNCTION 1200U
 #define stPAR_DEFAULT_SENSOR_ENABLE_MASK 1170U
 #define stPAR_USER_SENSOR_ENABLE_MASK 1169U
 #define stPAR_USER_SENSOR_DISABLE_MASK 1168U
 #define stPAR_DEFAULT_SHELF_OFFSET 1122U
 #define stPAR_PALLET_GAP 1121U
 #define stPAR_DEFAULT_SHELF_LENGTH 1120U
 #define stPAR_FLOW_DIRECTION 1105U
 #define stPAR_LOGICAL_HEAD_SECTION 1104U
 #define stPAR_PARAM_DATA_TYPE 1093U
 #define stPAR_PARAM_ARRAY_LENGTH 1092U
 #define stPAR_SECTION_TYPE 1082U
 #define stPAR_SECTION_ADDRESS 1081U
 #define stPAR_SECTION_COUNT 1080U
 #define stPAR_SAVE_PARAMETERS 971U
 #define stPAR_CLEAR_FAULTS 252U
 #define scTASK_ARRAY_WRITE 6U
 #define scTASK_ARRAY_READ 5U
 #define scTASK_WRITE 6U
 #define scTASK_READ 5U
 #define stMAX_CONTROL_IF_INDEX 3U
 #define stMAX_CONTROL_IF_COUNT 4U
#else
 _GLOBAL_CONST signed long EVENT_ID_GENERIC_ERROR;
 _GLOBAL_CONST signed long EVENT_ID_GENERIC_WARNING;
 _GLOBAL_CONST signed long EVENT_ID_GENERIC_INFO;
 _GLOBAL_CONST signed long EVENT_ID_GENERIC_SUCCESS;
 _GLOBAL_CONST unsigned char stPALLET_MODE_EXTERNAL;
 _GLOBAL_CONST unsigned char stPALLET_MODE_CAM;
 _GLOBAL_CONST unsigned char stPALLET_MODE_CNC;
 _GLOBAL_CONST unsigned char stPALLET_MODE_TRAJECTORY;
 _GLOBAL_CONST unsigned short stDATA_FILE_SYNC_MASTER_PARAMS;
 _GLOBAL_CONST unsigned short stDATA_FILE_SYNC_SERVOS;
 _GLOBAL_CONST unsigned short stDATA_FILE_SYNC_GLOBAL_PARAMS;
 _GLOBAL_CONST unsigned short stDATA_FILE_SIMULATION_CONFIG;
 _GLOBAL_CONST unsigned short stDATA_FILE_IO;
 _GLOBAL_CONST unsigned short stDATA_FILE_NETWORK_IO;
 _GLOBAL_CONST unsigned short stDATA_FILE_IR_TAG_CONFIG;
 _GLOBAL_CONST unsigned short stDATA_FILE_ENCODER_CONFIG;
 _GLOBAL_CONST unsigned short stDATA_FILE_CONTROL_GAIN;
 _GLOBAL_CONST unsigned short stDATA_FILE_ACCESS_CONTROL;
 _GLOBAL_CONST unsigned short stDATA_FILE_SECTION_PARAMS;
 _GLOBAL_CONST unsigned short stDATA_FILE_SYNCZONES_SANDBOX;
 _GLOBAL_CONST unsigned short stDATA_FILE_SYNCZONES;
 _GLOBAL_CONST unsigned short stDATA_FILE_OFFSETS;
 _GLOBAL_CONST unsigned short stDATA_FILE_PARAMETERS;
 _GLOBAL_CONST unsigned short stDATA_FILE_MOVE_CONFIG;
 _GLOBAL_CONST unsigned short stDATA_FILE_REGIONS;
 _GLOBAL_CONST unsigned short stDATA_FILE_TARGETS;
 _GLOBAL_CONST unsigned short stDATA_FILE_SYSTEM_LAYOUT;
 _GLOBAL_CONST unsigned char stIP_ADDR_MODE_BOOTP;
 _GLOBAL_CONST unsigned char stIP_ADDR_MODE_DHCP;
 _GLOBAL_CONST unsigned char stIP_ADDR_MODE_MANUAL;
 _GLOBAL_CONST unsigned char stIP_ADDR_MODE_NONE;
 _GLOBAL_CONST unsigned char stCONNECTION_MODBUSTCP;
 _GLOBAL_CONST unsigned char stCONNECTION_ETHERCAT;
 _GLOBAL_CONST unsigned char stCONNECTION_PROFINET;
 _GLOBAL_CONST unsigned char stCONNECTION_ETHERNETIP;
 _GLOBAL_CONST unsigned char stCONNECTION_POWERLINK;
 _GLOBAL_CONST unsigned char stCONNECTION_LOCAL;
 _GLOBAL_CONST unsigned char stCONNECTION_NONE;
 _GLOBAL_CONST unsigned short stDIRECTION_RIGHT;
 _GLOBAL_CONST unsigned short stDIRECTION_LEFT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_LREAL;
 _GLOBAL_CONST unsigned short scDATA_TYPE_REAL;
 _GLOBAL_CONST unsigned short scDATA_TYPE_LINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_DINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_INT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_SINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_ULINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_UDINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_UINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_USINT;
 _GLOBAL_CONST unsigned short scDATA_TYPE_BOOL;
 _GLOBAL_CONST unsigned short scTIMER_ABORT;
 _GLOBAL_CONST unsigned char scSTATE_ERROR;
 _GLOBAL_CONST unsigned char scSTATE_SEND;
 _GLOBAL_CONST unsigned char scSTATE_WAIT;
 _GLOBAL_CONST unsigned char scSTATE_EXEC;
 _GLOBAL_CONST unsigned char scSTATE_RECV;
 _GLOBAL_CONST unsigned short scERR_INTERNAL_ERROR;
 _GLOBAL_CONST unsigned short scERR_INVALID_PACKET;
 _GLOBAL_CONST unsigned short scERR_BUFFER_SIZE;
 _GLOBAL_CONST unsigned short scERR_UNAUTHORIZED;
 _GLOBAL_CONST unsigned short scERR_COMMAND_TIMEOUT;
 _GLOBAL_CONST unsigned short scERR_INVALID_ARGUMENT;
 _GLOBAL_CONST unsigned short scERR_INVALID_COUNT;
 _GLOBAL_CONST unsigned short scERR_INVALID_VALUE;
 _GLOBAL_CONST unsigned short scERR_INVALID_INDEX;
 _GLOBAL_CONST unsigned short scERR_TASK_UNAVAILABLE;
 _GLOBAL_CONST unsigned short scERR_INVALID_TASK;
 _GLOBAL_CONST unsigned short scERR_INVALID_PARAM;
 _GLOBAL_CONST unsigned short scERR_INVALID_SECTION;
 _GLOBAL_CONST unsigned short scERR_SUCCESS;
 _GLOBAL_CONST unsigned short stPAR_POSITION_OFFSET;
 _GLOBAL_CONST unsigned short stPAR_TARGET_POSITION;
 _GLOBAL_CONST unsigned short stPAR_TARGET_SECTION;
 _GLOBAL_CONST unsigned short stPAR_CPU_TEMPERATURE;
 _GLOBAL_CONST unsigned short stPAR_STORAGE_DEVICE_WEAR;
 _GLOBAL_CONST unsigned short stPAR_SOFTWARE_STARTUP_DONE;
 _GLOBAL_CONST unsigned short stPAR_HARDWARE_SENSORS;
 _GLOBAL_CONST unsigned short stPAR_TARGET_DOCKED_HPALLET;
 _GLOBAL_CONST unsigned short stPAR_TARGET_PALLET_OFFSET;
 _GLOBAL_CONST unsigned short stPAR_CALIBRATED_SECTION_LEN;
 _GLOBAL_CONST unsigned short stPAR_PARAMETER_CHECKSUMS;
 _GLOBAL_CONST unsigned short stPAR_SECTION_PALLET_COUNT;
 _GLOBAL_CONST unsigned short stPAR_SECTION_FAULTS_ACTIVE;
 _GLOBAL_CONST unsigned short stPAR_SYSTEM_FAULTS_ACTIVE;
 _GLOBAL_CONST unsigned short stPAR_FIELDBUS_IF_NAME;
 _GLOBAL_CONST unsigned short stPAR_FIELDBUS_IF_GATEWAY_ADDR;
 _GLOBAL_CONST unsigned short stPAR_FIELDBUS_IF_NETWORK_MASK;
 _GLOBAL_CONST unsigned short stPAR_FIELDBUS_IF_IP_ADDRESS;
 _GLOBAL_CONST unsigned short stPAR_FIELDBUS_IF_ADDR_MODE;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_FOLLOWER_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_SERV_CHAN_SIZE;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_REVISION;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_FOLLOWER_MAN_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_MASTER_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_SYNC_ZONE_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_SYNC_ZONE_START;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_NETWORK_IO_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_NETWORK_IO_START;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_COMMAND_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_TARGET_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_TARGET_START;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_SECTION_COUNT;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_SECTION_START;
 _GLOBAL_CONST unsigned short stPAR_PLC_IF_OPTIONS;
 _GLOBAL_CONST unsigned short stPAR_SYSTEM_AVERAGE_POWER;
 _GLOBAL_CONST unsigned short stPAR_SYSTEM_PEAK_POWER;
 _GLOBAL_CONST unsigned short stPAR_SYSTEM_LOAD_POWER;
 _GLOBAL_CONST unsigned short stPAR_SYSTEM_INSTANT_POWER;
 _GLOBAL_CONST unsigned short stPAR_SECTION_AVERAGE_POWER;
 _GLOBAL_CONST unsigned short stPAR_SECTION_PEAK_POWER;
 _GLOBAL_CONST unsigned short stPAR_SECTION_LOAD_POWER;
 _GLOBAL_CONST unsigned short stPAR_SECTION_INSTANT_POWER;
 _GLOBAL_CONST unsigned short stPAR_PALLET_CONTROL_MODE;
 _GLOBAL_CONST unsigned short stPAR_PALLET_STATUS;
 _GLOBAL_CONST unsigned short stPAR_PALLET_ID;
 _GLOBAL_CONST unsigned short stPAR_LOAD_TARGET;
 _GLOBAL_CONST unsigned short stPAR_RECOVERY_ACCELERATION;
 _GLOBAL_CONST unsigned short stPAR_RECOVERY_VELOCITY;
 _GLOBAL_CONST unsigned short stPAR_DEFAULT_ACCELERATION;
 _GLOBAL_CONST unsigned short stPAR_DEFAULT_VELOCITY;
 _GLOBAL_CONST unsigned short stPAR_MAXIMUM_ACCELERATION;
 _GLOBAL_CONST unsigned short stPAR_MAXIMUM_VELOCITY;
 _GLOBAL_CONST unsigned short stPAR_NETWORK_OUTPUT_FUNCTION;
 _GLOBAL_CONST unsigned short stPAR_NETWORK_INPUT_FUNCTION;
 _GLOBAL_CONST unsigned short stPAR_DIGITAL_OUTPUT_FUNCTION;
 _GLOBAL_CONST unsigned short stPAR_DIGITAL_INPUT_FUNCTION;
 _GLOBAL_CONST unsigned short stPAR_DEFAULT_SENSOR_ENABLE_MASK;
 _GLOBAL_CONST unsigned short stPAR_USER_SENSOR_ENABLE_MASK;
 _GLOBAL_CONST unsigned short stPAR_USER_SENSOR_DISABLE_MASK;
 _GLOBAL_CONST unsigned short stPAR_DEFAULT_SHELF_OFFSET;
 _GLOBAL_CONST unsigned short stPAR_PALLET_GAP;
 _GLOBAL_CONST unsigned short stPAR_DEFAULT_SHELF_LENGTH;
 _GLOBAL_CONST unsigned short stPAR_FLOW_DIRECTION;
 _GLOBAL_CONST unsigned short stPAR_LOGICAL_HEAD_SECTION;
 _GLOBAL_CONST unsigned short stPAR_PARAM_DATA_TYPE;
 _GLOBAL_CONST unsigned short stPAR_PARAM_ARRAY_LENGTH;
 _GLOBAL_CONST unsigned short stPAR_SECTION_TYPE;
 _GLOBAL_CONST unsigned short stPAR_SECTION_ADDRESS;
 _GLOBAL_CONST unsigned short stPAR_SECTION_COUNT;
 _GLOBAL_CONST unsigned short stPAR_SAVE_PARAMETERS;
 _GLOBAL_CONST unsigned short stPAR_CLEAR_FAULTS;
 _GLOBAL_CONST unsigned char scTASK_ARRAY_WRITE;
 _GLOBAL_CONST unsigned char scTASK_ARRAY_READ;
 _GLOBAL_CONST unsigned char scTASK_WRITE;
 _GLOBAL_CONST unsigned char scTASK_READ;
 _GLOBAL_CONST unsigned char stMAX_CONTROL_IF_INDEX;
 _GLOBAL_CONST unsigned char stMAX_CONTROL_IF_COUNT;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum StControlIfOptionBits_e
{	stCONTROL_IF_ENABLED = 0,
	stCONTROL_IF_SYSTEM_ENABLED = 1,
	stCONTROL_IF_STATUS_ONLY = 2,
	stCONTROL_IF_SERV_CHAN_ENABLED = 3,
	stCONTROL_IF_EXT_MASTER = 4
} StControlIfOptionBits_e;

typedef enum StPalletStatusBits_e
{	stPALLET_PRESENT = 0,
	stPALLET_RECOVERING = 1,
	stPALLET_AT_TARGET = 2,
	stPALLET_IN_POSITION = 3,
	stPALLET_SERVO_ENABLED = 4,
	stPALLET_INITIALIZING = 5,
	stPALLET_LOST = 6
} StPalletStatusBits_e;

typedef enum StTargetStatusBits_e
{	stTARGET_PALLET_PRESENT = 0,
	stTARGET_PALLET_IN_POSITION = 1,
	stTARGET_PALLET_PRE_ARRIVAL = 2,
	stTARGET_PALLET_OVER = 3,
	stTARGET_PALLET_POS_UNCERTAIN = 6,
	stTARGET_RELEASE_ERROR = 7
} StTargetStatusBits_e;

typedef enum StSectionStatusBits_e
{	stSECTION_ENABLED = 0,
	stSECTION_UNRECOGNIZED_PALLET = 1,
	stSECTION_MOTOR_POWER_ON = 2,
	stSECTION_PALLETS_RECOVERING = 3,
	stSECTION_LOCATING_PALLETS = 4,
	stSECTION_DISABLED_EXTERNALLY = 5,
	stSECTION_WARNING = 6,
	stSECTION_FAULT = 7
} StSectionStatusBits_e;

typedef enum StSectionControlBits_e
{	stSECTION_ENABLE = 0,
	stSECTION_ACKNOWLEDGE_FAULTS = 7
} StSectionControlBits_e;

typedef enum StSystemControlBits_e
{	stSYSTEM_ENABLE_ALL_SECTIONS = 0,
	stSYSTEM_ACKNOWLEDGE_FAULTS = 7,
	stSYSTEM_CONTROL_HEARTBEAT = 15
} StSystemControlBits_e;

typedef enum StSystemStatusBits_e
{	stSYSTEM_PALLETS_STOPPED = 4,
	stSYSTEM_WARNING = 6,
	stSYSTEM_FAULT = 7,
	stSYSTEM_STATUS_HEARTBEAT = 15
} StSystemStatusBits_e;

typedef struct SuperTrakSystemControl_t
{	plcword control;
	unsigned short reserved;
} SuperTrakSystemControl_t;

typedef struct SuperTrakSystemStatus_t
{	plcword status;
	unsigned short totalPallets;
} SuperTrakSystemStatus_t;

typedef struct SuperTrakSectionControl_t
{	plcbyte control;
} SuperTrakSectionControl_t;

typedef struct SuperTrakSectionStatus_t
{	plcbyte status;
} SuperTrakSectionStatus_t;

typedef struct SuperTrakSectionStatusR3_t
{	plcword status;
} SuperTrakSectionStatusR3_t;

typedef struct SuperTrakTargetStatus_t
{	plcbyte status;
	unsigned char palletID;
	unsigned char offsetIndex;
} SuperTrakTargetStatus_t;

typedef struct SuperTrakCommand_t
{	unsigned char u1[8];
} SuperTrakCommand_t;

typedef struct ServiceChannelHeader_t
{	unsigned short length;
	unsigned char sequence;
	unsigned char task;
	unsigned short param;
	unsigned char section;
	unsigned char reserved0;
	unsigned long startIndex;
	unsigned short reserved1;
	unsigned short count;
} ServiceChannelHeader_t;

typedef struct SyncZoneControl_t
{	plcbyte control;
} SyncZoneControl_t;

typedef struct SyncZoneStatus_t
{	plcbyte status;
	unsigned char firstPalletID;
	unsigned char lastPalletID;
} SyncZoneStatus_t;

typedef struct SyncZoneStatusR3_t
{	plcword status;
	unsigned char firstPalletID;
	unsigned char lastPalletID;
} SyncZoneStatusR3_t;

typedef struct SyncMasterControl_t
{	float masterVelocitySetpoint;
	float masterCycleStopPosition;
	plcword masterControlBits;
	unsigned short spareWord1;
} SyncMasterControl_t;

typedef struct SyncMasterStatus_t
{	float masterActVelocity;
	float masterActPosition;
	unsigned long masterErrorCode;
	plcword masterStatusBits;
	unsigned short spareWord1;
} SyncMasterStatus_t;

typedef struct SyncFollowerManualControl_t
{	unsigned char followerIndex;
	plcbyte followerControlBits;
	unsigned char followerSpare1;
	unsigned char followerSpare2;
	float followerCmdPosition;
	float followerVelocity;
} SyncFollowerManualControl_t;

typedef struct SyncFollowerManualStatus_t
{	unsigned char followerIndex;
	plcbyte followerStatusBits;
	unsigned char followerSpare1;
	unsigned char followerSpare2;
	float followerActVelocity;
	float followerActPosition;
	float followerCmdPosition;
	signed long followerErrorCode;
} SyncFollowerManualStatus_t;

typedef struct SyncSingleFollowerControl_t
{	plcbyte controlBits;
	unsigned char selectedRecipe;
} SyncSingleFollowerControl_t;

typedef struct SyncSingleFollowerStatus_t
{	plcbyte statusBits;
	unsigned char activeRecipe;
} SyncSingleFollowerStatus_t;

typedef struct SyncSingleFollowerFeedback_t
{	float position;
} SyncSingleFollowerFeedback_t;

typedef struct SyncExtMasterCommonIn_t
{	signed long timeStampReturn;
	plcbyte commonControlBits;
	unsigned char reserved[3];
} SyncExtMasterCommonIn_t;

typedef struct SyncExtMasterCommonOut_t
{	signed long timeStamp;
	signed long timeDiff;
} SyncExtMasterCommonOut_t;

typedef struct SyncExtMasterControl_t
{	signed long setpointPosition;
	signed long setpointVel;
	signed long setPointAccel;
	signed long setPointJerk;
	signed long commandedVel;
	signed long commandedAccel;
} SyncExtMasterControl_t;

typedef struct SyncExtMasterStatus_t
{	plcbyte extMasterStatusBits;
} SyncExtMasterStatus_t;

typedef struct StCmdReleasePallet_t
{	unsigned char command;
	unsigned char context;
	unsigned char destTarget;
	unsigned char moveConfig;
	unsigned char targetOffset;
	unsigned char reserved5;
	unsigned short incrementalOffset;
} StCmdReleasePallet_t;

typedef struct StCmdReleaseTargetOffset_t
{	unsigned char command;
	unsigned char context;
	unsigned char destTarget;
	unsigned char moveConfig;
	signed long offset;
} StCmdReleaseTargetOffset_t;

typedef struct StCmdReleaseIncrementalOffset_t
{	unsigned char command;
	unsigned char context;
	unsigned char destTarget;
	unsigned char moveConfig;
	signed long offset;
} StCmdReleaseIncrementalOffset_t;

typedef struct StCmdContinueMove_t
{	unsigned char command;
	unsigned char context;
	unsigned short reserved2to3;
	unsigned long reserved4to7;
} StCmdContinueMove_t;

typedef struct StCmdSetPalletID_t
{	unsigned char command;
	unsigned char target;
	unsigned char palletID;
	unsigned char reserved3;
	unsigned long reserved4to7;
} StCmdSetPalletID_t;

typedef struct StCmdSetVelocityAccel_t
{	unsigned char command;
	unsigned char context;
	unsigned short velocity;
	unsigned short acceleration;
	unsigned short reserved6to7;
} StCmdSetVelocityAccel_t;

typedef struct StCmdSetPalletWidth_t
{	unsigned char command;
	unsigned char context;
	unsigned short shelfWidth;
	unsigned short shelfOffset;
	unsigned short reserved6to7;
} StCmdSetPalletWidth_t;

typedef struct StCmdSetPalletControlParams_t
{	unsigned char command;
	unsigned char context;
	unsigned char controlGainSet;
	unsigned char movingFilterPercent;
	unsigned char stationaryFilterPercent;
	unsigned char reserved5;
	unsigned short reserved6to7;
} StCmdSetPalletControlParams_t;

typedef struct StCmdAntiSlosh_t
{	unsigned char command;
	unsigned char context;
	unsigned char containerShape;
	unsigned char oscillationModes;
	unsigned short containerLength;
	unsigned short fillLevel;
} StCmdAntiSlosh_t;

typedef struct StCmdAttachEncoderOutput_t
{	unsigned char command;
	unsigned char context;
	unsigned char encoderOutputIndex;
} StCmdAttachEncoderOutput_t;

typedef struct StCmdDetachEncoderOutput_t
{	unsigned char command;
	unsigned char context;
} StCmdDetachEncoderOutput_t;

typedef struct SuperTrakControlInterface_t
{	unsigned long pControl;
	unsigned long pStatus;
	unsigned short controlSize;
	unsigned short statusSize;
	unsigned char connectionType;
} SuperTrakControlInterface_t;

typedef struct ServiceChannel_t
{	unsigned char channelId;
	unsigned char state;
	unsigned char requestSequence;
	unsigned char reserved0;
	unsigned short timeLimit;
	unsigned short timer;
	struct ServiceChannelHeader_t* pRequestHeader;
	struct ServiceChannelHeader_t* pResponseHeader;
	unsigned short requestBufferSize;
	unsigned short responseBufferSize;
	unsigned long pRequestValues;
	unsigned long pResponseValues;
} ServiceChannel_t;

typedef struct SuperTrakControlIfConfig_t
{	plcword options;
	unsigned short revision;
	unsigned short systemControlOffset;
	unsigned short systemStatusOffset;
	unsigned short controlSize;
	unsigned short statusSize;
	unsigned short sectionStartIndex;
	unsigned short sectionCount;
	unsigned short sectionControlOffset;
	unsigned short sectionStatusOffset;
	unsigned short targetStartIndex;
	unsigned short targetCount;
	unsigned short targetControlOffset;
	unsigned short targetStatusOffset;
	unsigned short commandCount;
	unsigned short commandTriggerOffset;
	unsigned short commandDataOffset;
	unsigned short commandStatusOffset;
	unsigned short commandCompleteOffset;
	unsigned short commandSuccessOffset;
	unsigned short networkIoStartIndex;
	unsigned short networkIoCount;
	unsigned short networkInputOffset;
	unsigned short networkOutputOffset;
	unsigned short syncZoneStartIndex;
	unsigned short syncZoneCount;
	unsigned short syncZoneControlOffset;
	unsigned short syncZoneStatusOffset;
	unsigned short serviceChannelSize;
	unsigned short serviceChannelRequestOffset;
	unsigned short serviceChannelResponseOffset;
	unsigned short masterCount;
	unsigned short masterControlOffset;
	unsigned short masterStatusOffset;
	unsigned short followerManualCount;
	unsigned short followerManualControlOffset;
	unsigned short followerManualStatusOffset;
	unsigned short followerCount;
	unsigned short followerControlOffset;
	unsigned short followerStatusOffset;
	unsigned short followerPositionOffset;
	unsigned short extMasterStatusOffset;
	unsigned short extMasterControlOffset;
} SuperTrakControlIfConfig_t;

typedef struct SuperTrakPalletInfo_t
{	unsigned char palletID;
	plcbyte status;
	unsigned char controlMode;
	unsigned char section;
	signed long position;
} SuperTrakPalletInfo_t;

typedef struct FieldbusHardwareOption_t
{	unsigned long ID;
	plcstring Title[40];
	plcstring Data[20];
} FieldbusHardwareOption_t;

typedef struct PosTrigEdgeGen_t
{	plcbit InputError;
	plcbit InputWarning;
	plcbit OutputEnable;
	plcbit OutputQuitError;
	plcbit OutputQuitWarning;
	signed char OutputSequence;
	signed long OutputTimestamp;
} PosTrigEdgeGen_t;

typedef struct QuadPosTrigHardware_t
{	plcbit ModuleOk;
	plcstring DeviceAddress[40];
	struct PosTrigEdgeGen_t EdgeGen[4];
} QuadPosTrigHardware_t;

typedef struct StPositionTriggerInternal_t
{	plcbit busy;
	signed long prevPulseRelativeTime;
	signed long prevPulseTime;
	signed long prevPulseEndTime;
	unsigned long writtenPulseDuration;
	struct AsIOAccWrite AsyncIOWrite;
} StPositionTriggerInternal_t;

typedef struct EncoderOutputHardware_t
{	plcbit ModuleOk;
	plcbit InMovFifoEmpty;
	plcbit InMovFifoFull;
	plcbit InMovTargetTimeViolation;
	plcbit InMovMaxFrequencyViolation;
	plcbit OutMovQuitFifoEmpty;
	plcbit OutMovQuitFifoFull;
	plcbit OutMovQuitTargetTimeViolation;
	plcbit OutMovQuitMaxFreqViolation;
	plcbit OutMovEnable;
	signed long OutMovTargetTime;
	signed long OutMovTargetPosition;
	signed long OutMovReferenceStopMargin;
} EncoderOutputHardware_t;

typedef struct StServiceChannel
{
	/* VAR_INPUT (analog) */
	unsigned char Task;
	unsigned char Section;
	unsigned short Parameter;
	unsigned long StartIndex;
	unsigned short Count;
	unsigned short reserved0;
	unsigned short RequestDataLength;
	unsigned short ResponseBufferSize;
	unsigned long pRequestData;
	unsigned long pResponseBuffer;
	/* VAR_OUTPUT (analog) */
	unsigned short ErrorID;
	unsigned short ResponseDataLength;
	/* VAR (analog) */
	unsigned long Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Done;
	plcbit Error;
} StServiceChannel_typ;

typedef struct StPositionTrigger
{
	/* VAR_INPUT (analog) */
	struct QuadPosTrigHardware_t* Hardware;
	unsigned short EdgeGenIndex;
	unsigned short PositionTriggerIndex;
	signed long MinimumTimeOffset;
	signed long MaximumTimeOffset;
	/* VAR_OUTPUT (analog) */
	unsigned long OutputPulseCount;
	unsigned long LatePulseCount;
	unsigned long DroppedPulseCount;
	unsigned long HwWarningCount;
	unsigned long HwErrorCount;
	/* VAR (analog) */
	struct StPositionTriggerInternal_t Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit HardwareError;
	plcbit ParameterError;
} StPositionTrigger_typ;

typedef struct StEncoderOutput
{
	/* VAR_INPUT (analog) */
	struct EncoderOutputHardware_t* Hardware;
	unsigned short EncoderOutputIndex;
	signed long TimeDelay;
	/* VAR_OUTPUT (analog) */
	signed long MovFifoEmptyCount;
	signed long MovFifoFullCount;
	signed long MovTargetTimeViolationCount;
	signed long MovMaxFrequencyViolationCount;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Error;
} StEncoderOutput_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void StServiceChannel(struct StServiceChannel* inst);
_BUR_PUBLIC void StPositionTrigger(struct StPositionTrigger* inst);
_BUR_PUBLIC void StEncoderOutput(struct StEncoderOutput* inst);
_BUR_PUBLIC plcbit SuperTrakInit(plcstring* storagePath, plcstring* simIPAddress, plcstring* ethernetInterfaces);
_BUR_PUBLIC plcbit SuperTrakFieldbusHwConfig(unsigned long pOptions, unsigned short optionCount);
_BUR_PUBLIC plcbit SuperTrakCyclic1(void);
_BUR_PUBLIC plcbit SuperTrakExit(void);
_BUR_PUBLIC plcbit SuperTrakProcessControl(unsigned short index, struct SuperTrakControlInterface_t* data);
_BUR_PUBLIC plcbit SuperTrakProcessStatus(unsigned short index, struct SuperTrakControlInterface_t* data);
_BUR_PUBLIC plcbit SuperTrakServiceChannel(struct ServiceChannel_t* sc);
_BUR_PUBLIC unsigned short SuperTrakServChanRead(unsigned char section, unsigned short parameter, unsigned long startIndex, unsigned short count, unsigned long pBuffer, unsigned short bufferSize);
_BUR_PUBLIC unsigned short SuperTrakServChanWrite(unsigned char section, unsigned short parameter, unsigned long startIndex, unsigned short count, unsigned long pData, unsigned short dataLength);
_BUR_PUBLIC plcbit SuperTrakGetControlIfConfig(unsigned short index, struct SuperTrakControlIfConfig_t* config);
_BUR_PUBLIC plcbit SuperTrakCncBeginControl(unsigned short instance, unsigned short target);
_BUR_PUBLIC plcbit SuperTrakCncUpdateControl(unsigned short instance, signed long position, float acceleration);
_BUR_PUBLIC plcbit SuperTrakCncEndControl(unsigned short instance);
_BUR_PUBLIC plcbit SuperTrakGetPalletInfo(unsigned long palletInfo, unsigned char count, plcbit useSetpointPositions);
_BUR_PUBLIC plcbit SuperTrakBeginExternalControl(unsigned short palletID);
_BUR_PUBLIC plcbit SuperTrakPalletControl(unsigned short palletID, unsigned short setpointSection, signed long setpointPosition, float setpointVelocity, float setpointAccel);
_BUR_PUBLIC plcbit SuperTrakAttachParameter(unsigned short paramNum, unsigned long varAddress, unsigned short varType, unsigned long count, unsigned long indexOffset);
_BUR_PUBLIC signed long SuperTrakGetDistance(unsigned short userStartSection, signed long startPosition, unsigned short userEndSection, signed long endPosition, plcbit inForwardDirection);
_BUR_PUBLIC unsigned short SuperTrakSimulateMoveTrajectory(signed long moveDistance, signed short desiredVelocity, float desiredAccel, unsigned long pPositionBuffer, unsigned short positionBufferCount);
_BUR_PUBLIC plcbit SuperTrakGetRelativePosition(unsigned short section, signed long position, signed long distance, unsigned short* resultSection, signed long* resultPosition);
_BUR_PUBLIC unsigned short SuperTrakSimCreatePallet(unsigned char tagID, unsigned short section, float position, float shelfWidth, float shelfOffset, float mass);
_BUR_PUBLIC plcbit SuperTrakSimDeletePallet(unsigned short hSimPallet);
_BUR_PUBLIC plcbit SuperTrakProcessInputs(unsigned long pInputs, unsigned short inputCount);
_BUR_PUBLIC plcbit SuperTrakProcessOutputs(unsigned long pOutputs, unsigned short outputCount);
_BUR_PUBLIC ArEventLogRecordIDType SuperTrakLogWrite(plcstring* objectID, ArEventLogRecordIDType originRecordID, unsigned char severity, plcstring* message);
_BUR_PUBLIC plcbit SuperTrakLegacyLogWrite(unsigned long logLevel, unsigned long errornr, plcstring* message);


#ifdef __cplusplus
};
#endif
#endif /* _SUPERTRAK_ */

