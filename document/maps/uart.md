# Universal Asynchronous Receiver-Transmitter (UART) Register Map

**Base Address:** `0x0000_5000`

| Register Name      | Offset | Description         |
| ------------------ | ------ | ------------------- |
| UART_CTRL          | 0x000  | Control Register    |
| UART_REQ_ID        | 0x004  | Request ID          |
| UART_GNT_PEEK      | 0x008  | Grant Peek          |
| UART_GNT_POP       | 0x00C  | Grant Pop           |
| UART_CFG           | 0x010  | Clock Divider       |
| UART_TX_DATA       | 0x014  | Transmit Data       |
| UART_RX_DATA       | 0x018  | Receive Data        |
| UART_RX_DATA_PEEK  | 0x01C  | Receive Data Peek   |
| UART_TX_FIFO_COUNT | 0x020  | Transmit FIFO Count |
| UART_RX_FIFO_COUNT | 0x024  | Receive FIFO Count  |

## Register Descriptions

### UART_CTRL

Offset: 0x000
Description: Controls the UART operation, including enabling/disabling transmitter and receiver, FIFO flushing, and interrupt settings.

| Bit | Name             | ACCESS | Reset Value | Description                           |
| --- | ---------------- | ------ | ----------- | ------------------------------------- |
| 0   | TX_EN            | RW     | 0           | Enable Transmitter                    |
| 1   | TX_FIFO_FLUSH    | RW     | 0           | Flush Transmit FIFO                   |
| 2   | TX_IRQ_EMPTY     | RW     | 0           | Enable interrupt at transmitter empty |
| 3   | TX_IRQ_NEAR_FULL | RW     | 0           | Enable interrupt near full TX FIFO    |
| 4   | TX_IRQ_FULL      | RW     | 0           | Enable interrupt at TX FIFO full      |
| 5   | RX_EN            | RW     | 0           | Enable Receiver                       |
| 6   | RX_FIFO_FLUSH    | RW     | 0           | Flush Receive FIFO                    |
| 7   | RX_IRQ_EMPTY     | RW     | 0           | Enable interrupt at receiver empty    |
| 8   | RX_IRQ_NEAR_FULL | RW     | 0           | Enable interrupt near full RX FIFO    |
| 9   | RX_IRQ_FULL      | RW     | 0           | Enable interrupt at RX FIFO full      |

### UART_REQ_ID

Offset: 0x004
Description: Contains the requester ID for the UART device.

| Bit  | Name | ACCESS | Reset Value | Description                  |
| ---- | ---- | ------ | ----------- | ---------------------------- |
| 31:0 | ID   | RW     | 0           | Requester ID for UART device |

### UART_GNT_PEEK

Offset: 0x008
Description: Peek Granted Requester ID to the UART device.

| Bit  | Name | ACCESS | Reset Value | Description                          |
| ---- | ---- | ------ | ----------- | ------------------------------------ |
| 31:0 | ID   | RO     | 0           | Granted Requester ID for UART device |

### UART_GNT_POP

Offset: 0x00C
Description: Pop the Granted Requester ID from the UART device.

| Bit  | Name | ACCESS | Reset Value | Description                              |
| ---- | ---- | ------ | ----------- | ---------------------------------------- |
| 31:0 | ID   | RW     | 0           | Pop Granted Requester ID for UART device |

### UART_CFG

Offset: 0x010
Description: Configures the UART clock divider, parity, and other settings.

| Bit   | Name        | ACCESS | Reset Value | Description                      |
| ----- | ----------- | ------ | ----------- | -------------------------------- |
| 19:0  | CLK_DIVIDER | RW     | 0           | Clock divider for UART operation |
| 20    | PARITY_EN   | RW     | 0           | Enable parity bit                |
| 21    | PARITY_TYPE | RW     | 0           | Parity type (0: even, 1: odd)    |
| 31:22 | Reserved    | -      | 0           | Reserved                         |

### UART_TX_DATA

Offset: 0x014
Description: Transmit data register for sending data over UART.

| Bit  | Name     | ACCESS | Reset Value | Description            |
| ---- | -------- | ------ | ----------- | ---------------------- |
| 7:0  | DATA     | RW     | 0           | Data to be transmitted |
| 31:8 | Reserved | -      | 0           | Reserved               |

### UART_RX_DATA

Offset: 0x018
Description: Receive data register for reading data received over UART.

| Bit  | Name     | ACCESS | Reset Value | Description             |
| ---- | -------- | ------ | ----------- | ----------------------- |
| 7:0  | DATA     | RO     | 0           | Data received over UART |
| 31:8 | Reserved | -      | 0           | Reserved                |

### UART_RX_DATA_PEEK

Offset: 0x01C
Description: Peek at the data received over UART without removing it from the FIFO.

| Bit  | Name     | ACCESS | Reset Value | Description |
| ---- | -------- | ------ | ----------- | ----------- |
| 7:0  | DATA     | RO     | 0           | Data peek   |
| 31:8 | Reserved | -      | 0           | Reserved    |

### UART_TX_FIFO_COUNT

Offset: 0x020
Description: Counts the number of entries in the transmit FIFO.

| Bit  | Name       | ACCESS | Reset Value | Description                  |
| ---- | ---------- | ------ | ----------- | ---------------------------- |
| 7:0  | FIFO_COUNT | RO     | 0           | Number of entries in TX FIFO |
| 31:8 | Reserved   | -      | 0           | Reserved                     |

### UART_RX_FIFO_COUNT

Offset: 0x024
Description: Counts the number of entries in the receive FIFO.

| Bit  | Name       | ACCESS | Reset Value | Description                  |
| ---- | ---------- | ------ | ----------- | ---------------------------- |
| 7:0  | FIFO_COUNT | RO     | 0           | Number of entries in RX FIFO |
| 31:8 | Reserved   | -      | 0           | Reserved                     |
