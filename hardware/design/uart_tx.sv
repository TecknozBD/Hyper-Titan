module uart_tx (
    input logic arst_ni,
    input logic clk_i,

    input logic cfg_parity_en_i,
    input logic cfg_parity_type_i,
    input logic cfg_stop_bits_i,

    input logic [7:0] tx_data_i,
    input logic tx_data_valid_i,
    output logic tx_data_ready_o,

    output logic tx_o
);

  typedef enum logic [3:0] {
    IDLE,
    START_BIT,
    DATA_BIT0,
    DATA_BIT1,
    DATA_BIT2,
    DATA_BIT3,
    DATA_BIT4,
    DATA_BIT5,
    DATA_BIT6,
    DATA_BIT7,
    PARITY_BIT,
    STOP_BIT1,
    STOP_BIT2
  } tx_state_t;

  tx_state_t current_state, next_state;
  logic parity_bit;

  assign parity_bit = (^tx_data_i) ^ cfg_parity_type_i;

  always_comb begin
    next_state = IDLE;
    tx_o = 1'b1;
    tx_data_ready_o = 1'b0;
    case (current_state)
      IDLE: begin
        if (tx_data_valid_i) begin
          next_state = START_BIT;
        end
      end
      START_BIT: begin
        next_state = DATA_BIT0;
        tx_o = 1'b0;
      end
      DATA_BIT0: begin
        next_state = DATA_BIT1;
        tx_o = tx_data_i[0];
      end
      DATA_BIT1: begin
        next_state = DATA_BIT2;
        tx_o = tx_data_i[1];
      end
      DATA_BIT2: begin
        next_state = DATA_BIT3;
        tx_o = tx_data_i[2];
      end
      DATA_BIT3: begin
        next_state = DATA_BIT4;
        tx_o = tx_data_i[3];
      end
      DATA_BIT4: begin
        next_state = DATA_BIT5;
        tx_o = tx_data_i[4];
      end
      DATA_BIT5: begin
        next_state = DATA_BIT6;
        tx_o = tx_data_i[5];
      end
      DATA_BIT6: begin
        next_state = DATA_BIT7;
        tx_o = tx_data_i[6];
      end
      DATA_BIT7: begin
        next_state = cfg_parity_en_i ? PARITY_BIT : STOP_BIT1;
        tx_o = tx_data_i[7];
      end
      PARITY_BIT: begin
        next_state = STOP_BIT1;
        tx_o = parity_bit;
      end
      STOP_BIT1: begin
        next_state = cfg_stop_bits_i ? STOP_BIT2 : IDLE;
        tx_o = 1'b1;
        tx_data_ready_o = 1'b1;
      end
      default: begin
        next_state = IDLE;
        tx_o = 1'b1;
      end
    endcase
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

endmodule
