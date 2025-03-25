SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Pulse Secure\VC142.CRT\X64\;C:\Program Files (x86)\Pulse Secure\VC142.CRT\X86\;C:\Program Files (x86)\Common Files\Pulse Secure\TNC Client Plugin\;C:\Program Files\Bandizip\;C:\Program Files\Microsoft VS Code\bin;C:\Program Files\dotnet\;C:\Program Files\Git\cmd;C:\Program Files\nodejs\;C:\Users\lees\AppData\Local\Microsoft\WindowsApps;C:\Users\lees\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\lees\AppData\Local\Microsoft\WindowsApps;C:\Users\lees\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\BrAutomation\AS412\bin-en\4.12;C:\BrAutomation\AS412\bin-en\4.11;C:\BrAutomation\AS412\bin-en\4.10;C:\BrAutomation\AS412\bin-en\4.9;C:\BrAutomation\AS412\bin-en\4.8;C:\BrAutomation\AS412\bin-en\4.7;C:\BrAutomation\AS412\bin-en\4.6;C:\BrAutomation\AS412\bin-en\4.5;C:\BrAutomation\AS412\bin-en\4.4;C:\BrAutomation\AS412\bin-en\4.3;C:\BrAutomation\AS412\bin-en\4.2;C:\BrAutomation\AS412\bin-en\4.1;C:\BrAutomation\AS412\bin-en\4.0;C:\BrAutomation\AS412\bin-en
export AS_BUILD_MODE := BuildAndTransfer
export AS_VERSION := 4.12.5.95 SP
export AS_WORKINGVERSION := 4.12
export AS_COMPANY_NAME := B&R Industrial Automation GmbH
export AS_USER_NAME := lees
export AS_PATH := C:/BrAutomation/AS412
export AS_BIN_PATH := C:/BrAutomation/AS412/bin-en
export AS_PROJECT_PATH := C:/projects/project_test
export AS_PROJECT_NAME := SuperTrak_Distribution
export AS_SYSTEM_PATH := C:/BrAutomation/AS/System
export AS_VC_PATH := C:/BrAutomation/AS412/AS/VC
export AS_TEMP_PATH := C:/projects/project_test/Temp
export AS_CONFIGURATION := APC910
export AS_BINARIES_PATH := C:/projects/project_test/Binaries
export AS_GNU_INST_PATH := C:/BrAutomation/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := C:/BrAutomation/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BrAutomation/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := C:/BrAutomation/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_INSTALL_PATH := C:/BrAutomation/AS412
export WIN32_AS_PATH := "C:\BrAutomation\AS412"
export WIN32_AS_BIN_PATH := "C:\BrAutomation\AS412\bin-en"
export WIN32_AS_PROJECT_PATH := "C:\projects\project_test"
export WIN32_AS_SYSTEM_PATH := "C:\BrAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BrAutomation\AS412\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\projects\project_test\Temp"
export WIN32_AS_BINARIES_PATH := "C:\projects\project_test\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BrAutomation\AS412\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "C:\BrAutomation\AS412\AS\GnuInst\V4.1.2\bin"
export WIN32_AS_INSTALL_PATH := "C:\BrAutomation\AS412"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/4.9/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/SuperTrak_Distribution.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'BuildAndTransfer'   

