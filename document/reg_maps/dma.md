# Direct Memory Access (DMA) Controller Register Map

**Base Address:** `0x0000_F000`

| Register Name          | Offset | Description                      |
| ---------------------- | ------ | -------------------------------- |
| DMA_CTRL               | 0x000  | DMA Control Register             |
| DMA_STATUS             | 0x004  | DMA Status Register              |
| DMA_TRANSFER_SIZE      | 0x008  | DMA Transfer Size Register       |
| DMA_TRANSFER_REMAINING | 0x00C  | DMA Transfer Remaining Register  |
| DMA_TRANSFER_SIDEBAND  | 0x010  | DMA Transfer Sideband Register   |
| DMA_SRC_ADDR_LOWER     | 0x020  | DMA Source Address Register      |
| DMA_SRC_ADDR_UPPER     | 0x024  | DMA Source Address Register      |
| DMA_DEST_ADDR_LOWER    | 0x028  | DMA Destination Address Register |
| DMA_DEST_ADDR_UPPER    | 0x02C  | DMA Destination Address Register |

## Register Descriptions

### DMA_CTRL

Offset: 0x000
Description : Controls the operation of the DMA controller.

| Bit  | Name     | ACCESS | Reset Value | Description                             |
| ---- | -------- | ------ | ----------- | --------------------------------------- |
| 0    | START    | RW     | 0           | Start DMA transfer                      |
| 1    | INT_EN   | RW     | 0           | Enable interrupt on transfer completion |
| 31:2 | Reserved | -      | 0           | Reserved                                |

### DMA_STATUS

Offset: 0x004
Description : Indicates the current status of the DMA controller.

| Bit  | Name     | ACCESS | Reset Value | Description           |
| ---- | -------- | ------ | ----------- | --------------------- |
| 0    | BUSY     | RO     | 0           | DMA is currently busy |
| 31:1 | Reserved | -      | 0           | Reserved              |

### DMA_TRANSFER_SIZE

Offset: 0x008
Description : Specifies the size of the DMA transfer in bytes.

| Bit  | Name | ACCESS | Reset Value | Description                       |
| ---- | ---- | ------ | ----------- | --------------------------------- |
| 31:0 | SIZE | RW     | 0           | Size of the DMA transfer in bytes |

### DMA_TRANSFER_REMAINING

Offset: 0x00C
Description : Indicates the number of bytes remaining in the current DMA transfer.

| Bit  | Name | ACCESS | Reset Value | Description                                   |
| ---- | ---- | ------ | ----------- | --------------------------------------------- |
| 31:0 | REM  | RO     | 0           | Number of bytes remaining in the DMA transfer |

### DMA_TRANSFER_SIDEBAND

Offset: 0x010
Description : Sideband information for the DMA transfer.

| Bit   | Name        | ACCESS | Reset Value | Description                 |
| ----- | ----------- | ------ | ----------- | --------------------------- |
| 11:0  | SRC_STRIDE  | RW     | 0           | Source stride in bytes      |
| 15:12 | SRC_SCHEME  | RW     | 0           | Source addressing scheme    |
| 27:16 | DEST_STRIDE | RW     | 0           | Destination stride in bytes |
| 31:28 | DEST_SCHEME | RW     | 0           | Destination addressing      |

### DMA_SRC_ADDR_LOWER

Offset: 0x020
Description : Lower 32 bits of the source address for the DMA transfer.

| Bit  | Name       | ACCESS | Reset Value | Description                     |
| ---- | ---------- | ------ | ----------- | ------------------------------- |
| 31:0 | SRC_ADDR_L | RW     | 0           | Lower 32 bits of source address |

### DMA_SRC_ADDR_UPPER

Offset: 0x024
Description : Upper 32 bits of the source address for the DMA transfer.

| Bit  | Name       | ACCESS | Reset Value | Description                     |
| ---- | ---------- | ------ | ----------- | ------------------------------- |
| 31:0 | SRC_ADDR_U | RW     | 0           | Upper 32 bits of source address |

### DMA_DEST_ADDR_LOWER

Offset: 0x028
Description : Lower 32 bits of the destination address for the DMA transfer.

| Bit  | Name        | ACCESS | Reset Value | Description                          |
| ---- | ----------- | ------ | ----------- | ------------------------------------ |
| 31:0 | DEST_ADDR_L | RW     | 0           | Lower 32 bits of destination address |

### DMA_DEST_ADDR_UPPER

Offset: 0x02C
Description : Upper 32 bits of the destination address for the DMA transfer.

| Bit  | Name        | ACCESS | Reset Value | Description                          |
| ---- | ----------- | ------ | ----------- | ------------------------------------ |
| 31:0 | DEST_ADDR_U | RW     | 0           | Upper 32 bits of destination address |
