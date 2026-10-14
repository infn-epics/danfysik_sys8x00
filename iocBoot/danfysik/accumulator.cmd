#!../../bin/linux-x86_64/danfysiksys8x00

#===============================================================================
# Test configuration: danfysik-acc-ser18002 (zone ACCUMULATOR, devgroup mag)
#===============================================================================

< envPaths
epicsEnvSet("IOC", "danfysik")

## Register all support components
dbLoadDatabase "$(TOP)/dbd/danfysiksys8x00.dbd"
danfysiksys8x00_registerRecordDeviceDriver pdbbase

# Environment variables
epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/db")
epicsEnvSet("BOOT", "${TOP}/iocBoot/${IOC}")

# Device configuration
epicsEnvSet("DEVICE_PREFIX", "ACC:MAG:DANFYSIK")     # Base device PV prefix
epicsEnvSet("PS_IP", "192.168.192.32")              # IP address of power supply server
epicsEnvSet("PS_PORT", "4001")                      # TCP port number

# Create TCP/IP port driver
drvAsynIPPortConfigure("DANFYSIK_PORT", "$(PS_IP):$(PS_PORT)", 0, 0, 1)

# Set trace masks for debugging (comment out for production)
#asynSetTraceMask("DANFYSIK_PORT", -1, 0x09)
#asynSetTraceIOMask("DANFYSIK_PORT", -1, 0x02)

#===============================================================================
# Database Loading
#===============================================================================

# DHSA*001 (geo 236)
epicsEnvSet("DEVICE_DHSA001", "$(DEVICE_PREFIX):DHSA001")
epicsEnvSet("ADDR_DHSA001", "5")
epicsEnvSet("IMAX_DHSA001", "700.0")
epicsEnvSet("VMAX_DHSA001", "250.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_DHSA001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_DHSA001),IMAX=$(IMAX_DHSA001),VMAX=$(VMAX_DHSA001),PREC=3")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_DHSA001),IMAX=$(IMAX_DHSA001)")

# QUAA*001 (geo 204)
epicsEnvSet("DEVICE_QUAA001", "$(DEVICE_PREFIX):QUAA001")
epicsEnvSet("ADDR_QUAA001", "2")
epicsEnvSet("IMAX_QUAA001", "315.0")
epicsEnvSet("VMAX_QUAA001", "255.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_QUAA001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA001),IMAX=$(IMAX_QUAA001),VMAX=$(VMAX_QUAA001),PREC=3")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_QUAA001),IMAX=$(IMAX_QUAA001)")

# QUAA*002 (geo 215)
epicsEnvSet("DEVICE_QUAA002", "$(DEVICE_PREFIX):QUAA002")
epicsEnvSet("ADDR_QUAA002", "3")
epicsEnvSet("IMAX_QUAA002", "315.0")
epicsEnvSet("VMAX_QUAA002", "255.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_QUAA002),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA002),IMAX=$(IMAX_QUAA002),VMAX=$(VMAX_QUAA002),PREC=3")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_QUAA002),IMAX=$(IMAX_QUAA002)")

# QUAA*003 (geo 225)
epicsEnvSet("DEVICE_QUAA003", "$(DEVICE_PREFIX):QUAA003")
epicsEnvSet("ADDR_QUAA003", "4")
epicsEnvSet("IMAX_QUAA003", "315.0")
epicsEnvSet("VMAX_QUAA003", "255.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_QUAA003),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA003),IMAX=$(IMAX_QUAA003),VMAX=$(VMAX_QUAA003),PREC=3")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_QUAA003),IMAX=$(IMAX_QUAA003)")

# SXPA*001 (geo 203)
epicsEnvSet("DEVICE_SXPA001", "$(DEVICE_PREFIX):SXPA001")
epicsEnvSet("ADDR_SXPA001", "1")
epicsEnvSet("IMAX_SXPA001", "336.0")
epicsEnvSet("VMAX_SXPA001", "30.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_SXPA001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_SXPA001),IMAX=$(IMAX_SXPA001),VMAX=$(VMAX_SXPA001),PREC=3")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_SXPA001),IMAX=$(IMAX_SXPA001)")

# SXPA*002 (geo 204)
epicsEnvSet("DEVICE_SXPA002", "$(DEVICE_PREFIX):SXPA002")
epicsEnvSet("ADDR_SXPA002", "0")
epicsEnvSet("IMAX_SXPA002", "336.0")
epicsEnvSet("VMAX_SXPA002", "30.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_SXPA002),PORT=DANFYSIK_PORT,ADDR=$(ADDR_SXPA002),IMAX=$(IMAX_SXPA002),VMAX=$(VMAX_SXPA002),PREC=3")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_SXPA002),IMAX=$(IMAX_SXPA002)")

#===============================================================================
# IOC Initialization
#===============================================================================
#var streamDebug 1

iocInit

#===============================================================================
# UNIMAG State Machine (SNL Sequencer)
#===============================================================================
seq danfysikUnimagControl, "device=$(DEVICE_DHSA001), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_QUAA001), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_QUAA002), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_QUAA003), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_SXPA001), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_SXPA002), debug=1"
