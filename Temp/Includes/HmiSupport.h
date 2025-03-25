/* Automation Studio generated header file */
/* Do not edit ! */
/* HmiSupport 5.06.0 */

#ifndef _HMISUPPORT_
#define _HMISUPPORT_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _HmiSupport_VERSION
#define _HmiSupport_VERSION 5.06.0
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
 #define HMI_CONFIG_VERSION "V5.6.0"
 #define HMI_CONFIG_SIZE_OF_LOG_DATA 250U
 #define HMI_CONFIG_FB_ID_HMICONTROL 4096U
 #define HMI_CONFIG_FB_ID_HMIREAD 8192U
 #define HMI_CONFIG_FB_ID_HMIWRITE 12288U
 #define HMI_CONFIG_NR_OF_SECTIONS 64U
 #define HMI_CONFIG_MAX_NR_OF_FBS 1024U
 #define HMI_CONFIG_COMM_TIME_OUT 500
 #define HMI_CONFIG_SERV_CH_TASK_READ 5U
 #define HMI_CONFIG_SERV_CH_TASK_WRITE 6U
 #define HMI_CONFIG_SERV_CH_MAX_DATA 32U
 #define HMI_CONFIG_CMD_IF_BYTE_STRUCT 4U
 #define HMI_SC_CODE_SUCCESS 0U
 #define HMI_SC_CODE_WRONG_SECTION_ID 1U
 #define HMI_SC_CODE_WRONG_PAR_ID 2U
 #define HMI_SC_CODE_WRONG_TASK 3U
 #define HMI_SC_CODE_TASK_UNAVAILABLE 4U
 #define HMI_SC_CODE_WRONG_PAR_IDX 6U
 #define HMI_SC_CODE_WRONG_PAR_VALUE 7U
 #define HMI_SC_CODE_WRONG_PAR_COUNT 8U
 #define HMI_SC_CODE_TIMEOUT 10U
 #define HMI_SC_CODE_NOT_AUTHORIZED 13U
 #define HMI_SC_CODE_INVALID_PACKET 14U
 #define HMI_SC_CODE_INTERNAL_ERROR 15U
 #define HMI_SC_SAVE_PARAMTER_CODE 971U
 #define HMI_SC_SAVE_PARAMTER_CMD 60028U
 #define HMI_PNU_SECTION_COUNT 1080U
 #define HMI_PNU_SYSTEM_NAME 1053U
 #define HMI_PNU_ENABLE_CONTROL 1057U
 #define HMI_PNU_CMD_IF_SECTIONS 1432U
 #define HMI_PNU_CMD_IF_TARGETS 1434U
 #define HMI_PNU_CMD_IF_COMMANDS 1436U
 #define HMI_PNU_CMD_IF_OPTIONS 1430U
 #define HMI_CONFIG_SECTIONS_MINUS_ONE 63U
 #define HMI_CONFIG_FBS_MINUS_ONE 1023U
 #define HMI_CONFIG_SERV_CH_MAX_DATA_M1 31U
 #define HMI_NO_ERROR 0
 #define HMI_ERR_FB_INSTANCE_REG (-536805375)
 #define HMI_ERR_WRONG_PARAMETER (-536805373)
 #define HMI_ERR_COMMUNICAITON_TIME_OUT (-536805372)
 #define HMI_ERR_NO_HMICONTROL_REG (-536805371)
 #define HMI_ERR_SUPERTRAK_SYS (-536805370)
 #define HMI_ERR_WRONG_CONFIG (-536805369)
 #define HMI_ERR_CMD_NOT_EXECUTED (-536805368)
 #define HMI_ERR_SUPERTRAK_SEC (-536805367)
 #define HMI_ERR_SERVICE_CHANNEL_FAULT (-536805366)
 #define HMI_ERR_CMD_HANDSHAKE (-536805365)
 #define HMI_WRN_SUPERTRAK_SYS (-1610547099)
 #define HMI_WRN_SUPERTRAK_SEC (-1610547098)
 #define HMI_WRN_ENABLE_SIGNAL_SOURCE (-1610547097)
 #define HMI_INFO_COMM_STRUCT_TOO_BIG 1610678473
 #define HMI_SUCC_FB_REGISTRATION 536936749
 #define HMI_SUCC_PARAM_VALID 536936750
#else
 _GLOBAL_CONST plcstring HMI_CONFIG_VERSION[9];
 _GLOBAL_CONST unsigned char HMI_CONFIG_SIZE_OF_LOG_DATA;
 _GLOBAL_CONST unsigned short HMI_CONFIG_FB_ID_HMICONTROL;
 _GLOBAL_CONST unsigned short HMI_CONFIG_FB_ID_HMIREAD;
 _GLOBAL_CONST unsigned short HMI_CONFIG_FB_ID_HMIWRITE;
 _GLOBAL_CONST unsigned char HMI_CONFIG_NR_OF_SECTIONS;
 _GLOBAL_CONST unsigned short HMI_CONFIG_MAX_NR_OF_FBS;
 _GLOBAL_CONST plctime HMI_CONFIG_COMM_TIME_OUT;
 _GLOBAL_CONST unsigned char HMI_CONFIG_SERV_CH_TASK_READ;
 _GLOBAL_CONST unsigned char HMI_CONFIG_SERV_CH_TASK_WRITE;
 _GLOBAL_CONST unsigned char HMI_CONFIG_SERV_CH_MAX_DATA;
 _GLOBAL_CONST unsigned char HMI_CONFIG_CMD_IF_BYTE_STRUCT;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_SUCCESS;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_WRONG_SECTION_ID;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_WRONG_PAR_ID;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_WRONG_TASK;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_TASK_UNAVAILABLE;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_WRONG_PAR_IDX;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_WRONG_PAR_VALUE;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_WRONG_PAR_COUNT;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_TIMEOUT;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_NOT_AUTHORIZED;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_INVALID_PACKET;
 _GLOBAL_CONST unsigned char HMI_SC_CODE_INTERNAL_ERROR;
 _GLOBAL_CONST unsigned short HMI_SC_SAVE_PARAMTER_CODE;
 _GLOBAL_CONST unsigned long HMI_SC_SAVE_PARAMTER_CMD;
 _GLOBAL_CONST unsigned short HMI_PNU_SECTION_COUNT;
 _GLOBAL_CONST unsigned short HMI_PNU_SYSTEM_NAME;
 _GLOBAL_CONST unsigned short HMI_PNU_ENABLE_CONTROL;
 _GLOBAL_CONST unsigned short HMI_PNU_CMD_IF_SECTIONS;
 _GLOBAL_CONST unsigned short HMI_PNU_CMD_IF_TARGETS;
 _GLOBAL_CONST unsigned short HMI_PNU_CMD_IF_COMMANDS;
 _GLOBAL_CONST unsigned short HMI_PNU_CMD_IF_OPTIONS;
 _GLOBAL_CONST unsigned char HMI_CONFIG_SECTIONS_MINUS_ONE;
 _GLOBAL_CONST unsigned short HMI_CONFIG_FBS_MINUS_ONE;
 _GLOBAL_CONST unsigned char HMI_CONFIG_SERV_CH_MAX_DATA_M1;
 _GLOBAL_CONST signed long HMI_NO_ERROR;
 _GLOBAL_CONST signed long HMI_ERR_FB_INSTANCE_REG;
 _GLOBAL_CONST signed long HMI_ERR_WRONG_PARAMETER;
 _GLOBAL_CONST signed long HMI_ERR_COMMUNICAITON_TIME_OUT;
 _GLOBAL_CONST signed long HMI_ERR_NO_HMICONTROL_REG;
 _GLOBAL_CONST signed long HMI_ERR_SUPERTRAK_SYS;
 _GLOBAL_CONST signed long HMI_ERR_WRONG_CONFIG;
 _GLOBAL_CONST signed long HMI_ERR_CMD_NOT_EXECUTED;
 _GLOBAL_CONST signed long HMI_ERR_SUPERTRAK_SEC;
 _GLOBAL_CONST signed long HMI_ERR_SERVICE_CHANNEL_FAULT;
 _GLOBAL_CONST signed long HMI_ERR_CMD_HANDSHAKE;
 _GLOBAL_CONST signed long HMI_WRN_SUPERTRAK_SYS;
 _GLOBAL_CONST signed long HMI_WRN_SUPERTRAK_SEC;
 _GLOBAL_CONST signed long HMI_WRN_ENABLE_SIGNAL_SOURCE;
 _GLOBAL_CONST signed long HMI_INFO_COMM_STRUCT_TOO_BIG;
 _GLOBAL_CONST signed long HMI_SUCC_FB_REGISTRATION;
 _GLOBAL_CONST signed long HMI_SUCC_PARAM_VALID;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum HMIControlStepEnum
{	HMI_CTRL_STATE_INIT = 0,
	HMI_CTRL_STATE_INIT_CHECK_CONFIG = 1,
	HMI_CTRL_STATE_CREATE_LOGBOOK = 2,
	HMI_CTRL_STATE_REGISTER_FB = 3,
	HMI_CTRL_STATE_OPERATION = 10,
	HMI_CTRL_STATE_ERROR = 255
} HMIControlStepEnum;

typedef enum HMIWriteStepEnum
{	HMI_WPAR_STATE_INIT = 0,
	HMI_WPAR_STATE_INIT_CHECK_CONFIG = 1,
	HMI_WPAR_STATE_INIT_REG_FB = 2,
	HMI_WPAR_STATE_INIT_CHECK_PAR = 3,
	HMI_WPAR_STATE_OPERATION = 10,
	HMI_WPAR_STATE_ERROR = 255
} HMIWriteStepEnum;

typedef enum HMIReadStepEnum
{	HMI_RPAR_STATE_INIT = 0,
	HMI_RPAR_STATE_INIT_CHECK_CONFIG = 1,
	HMI_RPAR_STATE_INIT_REG_FB = 2,
	HMI_RPAR_STATE_INIT_CHECK_PAR = 3,
	HMI_RPAR_STATE_OPERATION = 10,
	HMI_RPAR_STATE_ERROR = 255
} HMIReadStepEnum;

typedef struct HMILinkSuperTrakStatusType
{	plcbit StatusValid;
} HMILinkSuperTrakStatusType;

typedef struct HMILinkLibStatusType
{	ArEventLogIdentType LogBookIdent;
	unsigned short FbID[1024];
} HMILinkLibStatusType;

typedef struct HMILinkType
{	struct HMILinkSuperTrakStatusType SuperTrakStatus;
	struct HMILinkLibStatusType LibraryStatus;
} HMILinkType;

typedef struct HMIControlLibraryType
{	plcstring Version[9];
} HMIControlLibraryType;

typedef struct HMIControlInfoType
{	struct HMIControlLibraryType Library;
} HMIControlInfoType;

typedef struct HMIControlInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit LogBookCreated;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
} HMIControlInternalStatusType;

typedef struct HMIControlInternalType
{	enum HMIControlStepEnum Step;
	unsigned long Index;
	unsigned long Index2;
	struct HMIControlInternalStatusType Status;
	plcstring AddErrorInfo[251];
	ArEventLogRecordIDType LastLogEntryID;
	struct ArEventLogCreate ArEventLogCreate;
	struct ArEventLogGetIdent ArEventLogGetIdent;
	struct ArEventLogWrite ArEventLogWrite;
	struct TON CommunicationWatchdog;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
} HMIControlInternalType;

typedef struct HMIReadParType
{	unsigned short ParameterNumber;
	unsigned char SectionID;
	unsigned long StartParameterIndex;
	unsigned short ParameterValueCount;
	unsigned short STRINGsize;
} HMIReadParType;

typedef struct HMIReadInfoType
{	unsigned short ErrorCode;
} HMIReadInfoType;

typedef struct HMIReadInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
	plcbit CommActive;
	unsigned short ReadStatus;
} HMIReadInternalStatusType;

typedef struct HMIReadInternalType
{	enum HMIReadStepEnum Step;
	struct HMIReadParType ParametersUsed;
	unsigned long Index;
	struct HMIReadInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
} HMIReadInternalType;

typedef struct HMIWriteSaveType
{	plcbit SystemLayout;
	plcbit Targets;
	plcbit Regions;
	plcbit MoveConfig;
	plcbit GlobalPar;
	plcbit Offsets;
	plcbit SectionPar;
	plcbit ControlGains;
	plcbit EncoderConfig;
	plcbit IRTagConfig;
	plcbit VirtualIO;
	plcbit PosTrig;
} HMIWriteSaveType;

typedef struct HMIWriteParType
{	unsigned short ParameterNumber;
	unsigned char SectionID;
	unsigned long StartParameterIndex;
	unsigned short ParameterValueCount;
	unsigned long UDINTvalue;
	unsigned short UINTvalue;
	unsigned char USINTvalue;
	signed long DINTvalue;
	signed short INTvalue;
	signed char SINTvalue;
	float REALvalue;
	plcstring STRINGvalue[81];
	unsigned short STRINGsize;
	struct HMIWriteSaveType Save;
} HMIWriteParType;

typedef struct HMIWriteInfoType
{	unsigned short ErrorCode;
} HMIWriteInfoType;

typedef struct HMIWriteInternalStatusType
{	plcbit InitConfigCheckDone;
	plcbit FuncitonBlockRegistered;
	unsigned short FuncitonBlockID;
	unsigned short FunctionBlockIDIndex;
	plcbit InitParCheckDone;
	plcbit CommActive;
	unsigned short WriteStatus;
} HMIWriteInternalStatusType;

typedef struct HMIWriteInternalType
{	enum HMIWriteStepEnum Step;
	struct HMIWriteParType ParametersUsed;
	unsigned long Index;
	struct HMIWriteInternalStatusType Status;
	plcstring AddErrorInfo[251];
	struct ArEventLogWrite ArEventLogWrite;
	plcbit ErrorResetOld;
	plcbit UpdateOld;
	unsigned long SaveValue;
} HMIWriteInternalType;

typedef struct HMIControl
{
	/* VAR_INPUT (analog) */
	struct HMILinkType* HMILink;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct HMIControlInfoType Info;
	/* VAR (analog) */
	struct HMIControlInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} HMIControl_typ;

typedef struct HMIReadParID
{
	/* VAR_INPUT (analog) */
	struct HMILinkType* HMILink;
	struct HMIReadParType* Parameters;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long Out_UDINT;
	unsigned short Out_UINT;
	unsigned char Out_USINT;
	signed long Out_DINT;
	signed short Out_INT;
	signed char Out_SINT;
	float Out_REAL;
	plcstring Out_STRING[81];
	struct HMIReadInfoType Info;
	/* VAR (analog) */
	struct HMIReadInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit ReadUDINT;
	plcbit ReadUINT;
	plcbit ReadUSINT;
	plcbit ReadDINT;
	plcbit ReadINT;
	plcbit ReadSINT;
	plcbit ReadREAL;
	plcbit ReadSTRING;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandDone;
} HMIReadParID_typ;

typedef struct HMIWriteParID
{
	/* VAR_INPUT (analog) */
	struct HMILinkType* HMILink;
	struct HMIWriteParType* Parameters;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct HMIWriteInfoType Info;
	/* VAR (analog) */
	struct HMIWriteInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit WriteUDINT;
	plcbit WriteUINT;
	plcbit WriteUSINT;
	plcbit WriteDINT;
	plcbit WriteINT;
	plcbit WriteSINT;
	plcbit WriteREAL;
	plcbit WriteSTRING;
	plcbit SaveParameters;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandDone;
} HMIWriteParID_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void HMIControl(struct HMIControl* inst);
_BUR_PUBLIC void HMIReadParID(struct HMIReadParID* inst);
_BUR_PUBLIC void HMIWriteParID(struct HMIWriteParID* inst);


#ifdef __cplusplus
};
#endif
#endif /* _HMISUPPORT_ */

