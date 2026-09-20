# Danfysik SYS8X00 Power Supply EPICS IOC

This IOC provides complete control and monitoring for the Danfysik System SYS8X00 series power supplies using EPICS StreamDevice. It includes both standard power supply control and an advanced UNIMAG interface for simplified bipolar operation.

## Features

### Standard Power Supply Control
- **Current Control**: Precise current setting with DAC-based control (0-65535 range)
- **Voltage Monitoring**: Real-time output voltage monitoring  
- **Polarity Control**: Support for positive/negative polarity switching (if equipped)
- **Ramping**: Configurable current ramping with rate and end point control
- **Status Monitoring**: Comprehensive status reporting including power, remote mode, regulation status
- **Error Handling**: Text-based error messages and error code reporting
- **Internal Monitoring**: Supply voltages (+15V, +24V) and temperature monitoring
- **Communication**: Support for Serial (RS-232/485/422) and TCP/IP connections

### UNIMAG Interface
- **Bipolar Current Control**: Simplified interface accepting signed current values (-IMAX to +IMAX)
- **Automatic Polarity Switching**: SNL state machine handles polarity changes automatically when crossing zero
- **State Machine Control**: Robust sequencing with error recovery and timeout handling
- **Debug Support**: Configurable debug levels and comprehensive diagnostics
- **Statistics**: Sequence counting and error tracking

## Communication Interfaces

### Supported Protocols
- **Serial Communication**: RS-232, RS-485, RS-422
  - Baud rates: 150 to 19200 bps
  - Standard serial port or USB-to-serial adapters
- **TCP/IP Communication**: 
  - Direct Ethernet connection (if available)
  - Serial-to-Ethernet terminal servers
  - Modbus TCP (future enhancement)

### Protocol Implementation
- Full implementation of Danfysik SYS8X00 command set
- Address-based communication (0-63 device addresses)
- Checksum validation for reliable communication
- Automatic retry and error recovery

## Getting Started

### Prerequisites
- EPICS Base 7.0+ (tested with 7.0.8)
- EPICS modules:
  - asyn 4-44+
  - StreamDevice 2.8.24+
  - sequencer 2.2+ (for UNIMAG interface)

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd danfysik-sys8x00
```

## UNIMAG states and watchdogs

`STATE_RB` uses the state enumeration shared by the UNIMAG power-supply IOCs:

| Value | State | Alarm | Meaning |
|-------|-------|-------|---------|
| 0 | `OFF` | - | Power supply off |
| 1 | `ON` | - | Output on |
| 2 | `STANDBY` | - | Ready, output disabled |
| 3 | `FAULT` | MAJOR | Power supply fault |
| 4 | `EXT_INTLK` | MAJOR | External interlock |
| 5 | `CONN_FAULT` | MAJOR | Communication errors (the status read fails) |
| 6 | `SP_NOT_REACHED` | MINOR | Current setpoint not reached |
| 7 | `ST_NOT_REACHED` | MAJOR | State not reached (UNIMAG failure) |

Faults win over `ST_NOT_REACHED`, which wins over `SP_NOT_REACHED`. Values from 8 up are
additional, device specific states. `STATE_SP` accepts `OFF`, `ON`, `STANDBY` and `RESET`.

Device specific states: `8 RAMPING` and `9 POL_CHANGE` (the polarity is being changed).
`FAULT` from the model specific interlock bits, `CONN_FAULT` when the last read failed
(`CONNECTED` = 0). `AT_SETPOINT` now compares `CURR_DIFF` with `SET_TOLERANCE`.

### UNIMAG configuration

| Parameter | PV | Description | Default | Units |
|-----------|----|-------------|---------|-------|
| `SET_TOLERANCE` | `SET_TOLERANCE` | Current setpoint tolerance (0 disables the setpoint check) | 1.0 (legacy `TOLERANCE` macro is still honoured) | Amperes |
| `ZERO_TOLERANCE` | `ZERO_TOLERANCE` | Zero current tolerance (a zero setpoint counts as reached within it) | 0.5 | Amperes |
| `SET_TIMEOUT_S` | `SET_TIMEOUT_S` | Setpoint / state timeout (restarts on progress) | 30 | Seconds |

They are db macros (same names) and live PVs, so they can also be changed at runtime. The
timeout restarts whenever the readback gets closer to the setpoint, on a new setpoint and on a
new state command. The setpoint check only runs while the supply is `ON`, and the state check
is armed by the first `STATE_SP` command after boot, so a supply left running is not reported.
`SP_NOT_REACHED` and `ST_NOT_REACHED` (and `SP_ERR`, `SP_WDOG`, `ST_WDOG`) are readable PVs.
