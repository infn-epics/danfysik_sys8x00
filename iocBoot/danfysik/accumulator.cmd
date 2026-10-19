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

# Poll rates: six sys80it units share one serial line (~19 transactions/s)
epicsEnvSet("SCAN_FAST", "2 second")
epicsEnvSet("SCAN_SLOW", "10 second")
epicsEnvSet("SCAN_DIAG", "Passive")

# Create TCP/IP port driver
drvAsynIPPortConfigure("DANFYSIK_PORT", "$(PS_IP):$(PS_PORT)", 0, 0, 1)

# Set trace masks for debugging (comment out for production)
#asynSetTraceMask("DANFYSIK_PORT", -1, 0x09)
#asynSetTraceIOMask("DANFYSIK_PORT", -1, 0x02)

#===============================================================================
# Database Loading
#===============================================================================

# DHSA*001 (geo 236)
epicsEnvSet("DEVICE_DHSA*001", "$(DEVICE_PREFIX):DHSA*001")
epicsEnvSet("ADDR_DHSA*001", "5")
epicsEnvSet("IMAX_DHSA*001", "700.0")
epicsEnvSet("VMAX_DHSA*001", "250.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_DHSA*001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_DHSA*001),IMAX=$(IMAX_DHSA*001),VMAX=$(VMAX_DHSA*001),PREC=3,SCAN_FAST=$(SCAN_FAST),SCAN_SLOW=$(SCAN_SLOW)")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_DHSA*001),IMAX=$(IMAX_DHSA*001)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it.template", "DEVICE=$(DEVICE_DHSA*001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_DHSA*001),IMAX=$(IMAX_DHSA*001),VMAX=$(VMAX_DHSA*001),SCAN_SLOW=$(SCAN_SLOW),SCAN_DIAG=$(SCAN_DIAG)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it_unimag.template", "DEVICE=$(DEVICE_DHSA*001)")

# QUAA*001 (geo 204)
epicsEnvSet("DEVICE_QUAA*001", "$(DEVICE_PREFIX):QUAA*001")
epicsEnvSet("ADDR_QUAA*001", "2")
epicsEnvSet("IMAX_QUAA*001", "315.0")
epicsEnvSet("VMAX_QUAA*001", "255.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_QUAA*001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA*001),IMAX=$(IMAX_QUAA*001),VMAX=$(VMAX_QUAA*001),PREC=3,SCAN_FAST=$(SCAN_FAST),SCAN_SLOW=$(SCAN_SLOW)")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_QUAA*001),IMAX=$(IMAX_QUAA*001)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it.template", "DEVICE=$(DEVICE_QUAA*001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA*001),IMAX=$(IMAX_QUAA*001),VMAX=$(VMAX_QUAA*001),SCAN_SLOW=$(SCAN_SLOW),SCAN_DIAG=$(SCAN_DIAG)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it_unimag.template", "DEVICE=$(DEVICE_QUAA*001)")

# QUAA*002 (geo 215)
epicsEnvSet("DEVICE_QUAA*002", "$(DEVICE_PREFIX):QUAA*002")
epicsEnvSet("ADDR_QUAA*002", "3")
epicsEnvSet("IMAX_QUAA*002", "315.0")
epicsEnvSet("VMAX_QUAA*002", "255.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_QUAA*002),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA*002),IMAX=$(IMAX_QUAA*002),VMAX=$(VMAX_QUAA*002),PREC=3,SCAN_FAST=$(SCAN_FAST),SCAN_SLOW=$(SCAN_SLOW)")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_QUAA*002),IMAX=$(IMAX_QUAA*002)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it.template", "DEVICE=$(DEVICE_QUAA*002),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA*002),IMAX=$(IMAX_QUAA*002),VMAX=$(VMAX_QUAA*002),SCAN_SLOW=$(SCAN_SLOW),SCAN_DIAG=$(SCAN_DIAG)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it_unimag.template", "DEVICE=$(DEVICE_QUAA*002)")

# QUAA*003 (geo 225)
epicsEnvSet("DEVICE_QUAA*003", "$(DEVICE_PREFIX):QUAA*003")
epicsEnvSet("ADDR_QUAA*003", "4")
epicsEnvSet("IMAX_QUAA*003", "315.0")
epicsEnvSet("VMAX_QUAA*003", "255.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_QUAA*003),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA*003),IMAX=$(IMAX_QUAA*003),VMAX=$(VMAX_QUAA*003),PREC=3,SCAN_FAST=$(SCAN_FAST),SCAN_SLOW=$(SCAN_SLOW)")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_QUAA*003),IMAX=$(IMAX_QUAA*003)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it.template", "DEVICE=$(DEVICE_QUAA*003),PORT=DANFYSIK_PORT,ADDR=$(ADDR_QUAA*003),IMAX=$(IMAX_QUAA*003),VMAX=$(VMAX_QUAA*003),SCAN_SLOW=$(SCAN_SLOW),SCAN_DIAG=$(SCAN_DIAG)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it_unimag.template", "DEVICE=$(DEVICE_QUAA*003)")

# SXPA*001 (geo 203)
epicsEnvSet("DEVICE_SXPA*001", "$(DEVICE_PREFIX):SXPA*001")
epicsEnvSet("ADDR_SXPA*001", "1")
epicsEnvSet("IMAX_SXPA*001", "336.0")
epicsEnvSet("VMAX_SXPA*001", "30.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_SXPA*001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_SXPA*001),IMAX=$(IMAX_SXPA*001),VMAX=$(VMAX_SXPA*001),PREC=3,SCAN_FAST=$(SCAN_FAST),SCAN_SLOW=$(SCAN_SLOW)")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_SXPA*001),IMAX=$(IMAX_SXPA*001)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it.template", "DEVICE=$(DEVICE_SXPA*001),PORT=DANFYSIK_PORT,ADDR=$(ADDR_SXPA*001),IMAX=$(IMAX_SXPA*001),VMAX=$(VMAX_SXPA*001),SCAN_SLOW=$(SCAN_SLOW),SCAN_DIAG=$(SCAN_DIAG)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it_unimag.template", "DEVICE=$(DEVICE_SXPA*001)")

# SXPA*002 (geo 204)
epicsEnvSet("DEVICE_SXPA*002", "$(DEVICE_PREFIX):SXPA*002")
epicsEnvSet("ADDR_SXPA*002", "0")
epicsEnvSet("IMAX_SXPA*002", "336.0")
epicsEnvSet("VMAX_SXPA*002", "30.0")
dbLoadRecords("$(TOP)/db/danfysik.template", "DEVICE=$(DEVICE_SXPA*002),PORT=DANFYSIK_PORT,ADDR=$(ADDR_SXPA*002),IMAX=$(IMAX_SXPA*002),VMAX=$(VMAX_SXPA*002),PREC=3,SCAN_FAST=$(SCAN_FAST),SCAN_SLOW=$(SCAN_SLOW)")
dbLoadRecords("$(TOP)/db/danfysik_unimag.template", "DEVICE=$(DEVICE_SXPA*002),IMAX=$(IMAX_SXPA*002)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it.template", "DEVICE=$(DEVICE_SXPA*002),PORT=DANFYSIK_PORT,ADDR=$(ADDR_SXPA*002),IMAX=$(IMAX_SXPA*002),VMAX=$(VMAX_SXPA*002),SCAN_SLOW=$(SCAN_SLOW),SCAN_DIAG=$(SCAN_DIAG)")
dbLoadRecords("$(TOP)/db/danfysik_sys80it_unimag.template", "DEVICE=$(DEVICE_SXPA*002)")

#===============================================================================
# IOC Initialization
#===============================================================================
#var streamDebug 1
# var streamError 1
# var streamDebug 1

iocInit

#===============================================================================
# UNIMAG State Machine (SNL Sequencer)
#===============================================================================
seq danfysikUnimagControl, "device=$(DEVICE_DHSA*001), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_QUAA*001), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_QUAA*002), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_QUAA*003), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_SXPA*001), debug=1"
seq danfysikUnimagControl, "device=$(DEVICE_SXPA*002), debug=1"
