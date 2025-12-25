// UART RX: receives serial data, reconstructs bytes, and optionally
// checks parity. Outputs `rx_data_o` with `rx_data_valid_o` when a
// complete byte (and parity check) is available.
module uart_rx (
    input logic arst_ni,
    input logic clk_i,

    input logic cfg_parity_en_i,
    input logic cfg_parity_type_i,
    input logic cfg_stop_bits_i,

    output logic int_parity_err_o,

    output logic [7:0] rx_data_o,
    output logic       rx_data_valid_o,

    input logic rx_i
);

  // RX FSM states: IDLE -> DATA_BIT0..7 -> optional PARITY -> STOP
  typedef enum logic [3:0] {
    IDLE,
    DATA_BIT0,
    DATA_BIT1,
    DATA_BIT2,
    DATA_BIT3,
    DATA_BIT4,
    DATA_BIT5,
    DATA_BIT6,
    DATA_BIT7,
    PARITY_BIT,
    STOP_BIT
  } tx_state_t;

  // FSM registers
  tx_state_t current_state, next_state;
  // Parity calculation: expected vs. received bit
  logic parity_expected;
  logic parity_received;
  // Edge detection for start-bit sampling
  logic found_negedge;
  // Counters used to sample mid-bit and advance FSM
  logic counter_en;
  logic [2:0] counter;

  // Compute expected parity bit from received data and parity type
  assign parity_expected = (^rx_data_o) ^ cfg_parity_type_i;

  edge_detector #(
      .POSEDGE(0),
      .NEGEDGE(1),
      .ASYNC  (0)
  ) u_ed (
      .arst_ni(arst_ni),
      .clk_i(clk_i),
      .d_i(rx_i),
      .posedge_o(),
      .negedge_o(found_negedge)
  );

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      counter_en <= 1'b0;
    end else begin
      // Enable the bit-sampling counter when a start edge is found
      if (~counter_en && current_state == IDLE && found_negedge) begin
        counter_en <= 1'b1;
      end
      // Disable counter at end of STOP bit sequence
      if (counter_en && current_state == STOP_BIT && counter == 4) begin
        counter_en <= 1'b0;
      end
    end
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      counter <= '0;
    end else begin
      if (counter_en) begin
        counter <= counter + 1;
      end else begin
        counter <= '0;
      end
    end
  end

  always_comb begin
    next_state = IDLE;
    case (current_state)
      IDLE: begin
        // After detecting start, move to first data bit (sampling
        // happens in the sequential block when counter indicates).
        next_state = DATA_BIT0;
      end
      DATA_BIT0: begin
        next_state = DATA_BIT1;
      end
      DATA_BIT1: begin
        next_state = DATA_BIT2;
      end
      DATA_BIT2: begin
        next_state = DATA_BIT3;
      end
      DATA_BIT3: begin
        next_state = DATA_BIT4;
      end
      DATA_BIT4: begin
        next_state = DATA_BIT5;
      end
      DATA_BIT5: begin
        next_state = DATA_BIT6;
      end
      DATA_BIT6: begin
        next_state = DATA_BIT7;
      end
      DATA_BIT7: begin
        // After last data bit, go to PARITY or STOP depending on config
        next_state = cfg_parity_en_i ? PARITY_BIT : STOP_BIT;
      end
      PARITY_BIT: begin
        next_state = STOP_BIT;
      end
      default: begin
        next_state = IDLE;
      end
    endcase
  end

  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      current_state <= IDLE;
      rx_data_o <= '0;
      rx_data_valid_o <= 1'b0;
      int_parity_err_o <= 1'b0;
    end else begin
      rx_data_valid_o <= 1'b0;
      int_parity_err_o <= 1'b0;
      if (counter == 3'd4) begin
        current_state <= next_state;
        case (current_state)
          DATA_BIT0: begin
            rx_data_o[0] <= rx_i;
          end
          DATA_BIT1: begin
            rx_data_o[1] <= rx_i;
          end
          DATA_BIT2: begin
            rx_data_o[2] <= rx_i;
          end
          DATA_BIT3: begin
            rx_data_o[3] <= rx_i;
          end
          DATA_BIT4: begin
            rx_data_o[4] <= rx_i;
          end
          DATA_BIT5: begin
            rx_data_o[5] <= rx_i;
          end
          DATA_BIT6: begin
            rx_data_o[6] <= rx_i;
          end
          DATA_BIT7: begin
            rx_data_o[7] <= rx_i;
          end
          PARITY_BIT: begin
            // Capture received parity bit for later comparison
            parity_received <= rx_i;
          end
          STOP_BIT: begin
            if (cfg_parity_en_i) begin
              if (parity_received == parity_expected) begin
                rx_data_valid_o <= 1'b1;
              end else begin
                int_parity_err_o <= 1'b1;
              end
            end else begin
              rx_data_valid_o <= 1'b1;
            end
          end
        endcase
      end
    end
  end

endmodule
