`ifndef AXI_TYPEDEF_SVH_
`define AXI_TYPEDEF_SVH_ 0

`define AXI_TYPEDEF_AW_CHAN_T(aw_chan_t, addr_t, id_t, user_t)  \
  typedef struct packed {                                       \
    id_t              id;                                       \
    addr_t            addr;                                     \
    axi_pkg::len_t    len;                                      \
    axi_pkg::size_t   size;                                     \
    axi_pkg::burst_t  burst;                                    \
    logic             lock;                                     \
    axi_pkg::cache_t  cache;                                    \
    axi_pkg::prot_t   prot;                                     \
    axi_pkg::qos_t    qos;                                      \
    axi_pkg::region_t region;                                   \
    axi_pkg::atop_t   atop;                                     \
    user_t            user;                                     \
  } aw_chan_t;
`define AXI_TYPEDEF_W_CHAN_T(w_chan_t, data_t, strb_t, user_t)  \
  typedef struct packed {                                       \
    data_t data;                                                \
    strb_t strb;                                                \
    logic  last;                                                \
    user_t user;                                                \
  } w_chan_t;
`define AXI_TYPEDEF_B_CHAN_T(b_chan_t, id_t, user_t)  \
  typedef struct packed {                             \
    id_t            id;                               \
    axi_pkg::resp_t resp;                             \
    user_t          user;                             \
  } b_chan_t;
`define AXI_TYPEDEF_AR_CHAN_T(ar_chan_t, addr_t, id_t, user_t)  \
  typedef struct packed {                                       \
    id_t              id;                                       \
    addr_t            addr;                                     \
    axi_pkg::len_t    len;                                      \
    axi_pkg::size_t   size;                                     \
    axi_pkg::burst_t  burst;                                    \
    logic             lock;                                     \
    axi_pkg::cache_t  cache;                                    \
    axi_pkg::prot_t   prot;                                     \
    axi_pkg::qos_t    qos;                                      \
    axi_pkg::region_t region;                                   \
    user_t            user;                                     \
  } ar_chan_t;
`define AXI_TYPEDEF_R_CHAN_T(r_chan_t, data_t, id_t, user_t)  \
  typedef struct packed {                                     \
    id_t            id;                                       \
    data_t          data;                                     \
    axi_pkg::resp_t resp;                                     \
    logic           last;                                     \
    user_t          user;                                     \
  } r_chan_t;
`define AXI_TYPEDEF_REQ_T(req_t, aw_chan_t, w_chan_t, ar_chan_t)  \
  typedef struct packed {                                         \
    aw_chan_t aw;                                                 \
    logic     aw_valid;                                           \
    w_chan_t  w;                                                  \
    logic     w_valid;                                            \
    logic     b_ready;                                            \
    ar_chan_t ar;                                                 \
    logic     ar_valid;                                           \
    logic     r_ready;                                            \
  } req_t;
`define AXI_TYPEDEF_RESP_T(resp_t, b_chan_t, r_chan_t)  \
  typedef struct packed {                               \
    logic     aw_ready;                                 \
    logic     ar_ready;                                 \
    logic     w_ready;                                  \
    logic     b_valid;                                  \
    b_chan_t  b;                                        \
    logic     r_valid;                                  \
    r_chan_t  r;                                        \
  } resp_t;

`define AXI_TYPEDEF_ALL_CT(__name, __req, __rsp, __addr_t, __id_t, __data_t, __strb_t, __user_t) \
  `AXI_TYPEDEF_AW_CHAN_T(__name``_aw_chan_t, __addr_t, __id_t, __user_t)                         \
  `AXI_TYPEDEF_W_CHAN_T(__name``_w_chan_t, __data_t, __strb_t, __user_t)                         \
  `AXI_TYPEDEF_B_CHAN_T(__name``_b_chan_t, __id_t, __user_t)                                     \
  `AXI_TYPEDEF_AR_CHAN_T(__name``_ar_chan_t, __addr_t, __id_t, __user_t)                         \
  `AXI_TYPEDEF_R_CHAN_T(__name``_r_chan_t, __data_t, __id_t, __user_t)                           \
  `AXI_TYPEDEF_REQ_T(__req, __name``_aw_chan_t, __name``_w_chan_t, __name``_ar_chan_t)           \
  `AXI_TYPEDEF_RESP_T(__rsp, __name``_b_chan_t, __name``_r_chan_t)

`define AXI_TYPEDEF_ALL(__name, __addr_t, __id_t, __data_t, __strb_t, __user_t)                                \
  `AXI_TYPEDEF_ALL_CT(__name, __name``_req_t, __name``_resp_t, __addr_t, __id_t, __data_t, __strb_t, __user_t)

`define AXI_LITE_TYPEDEF_AW_CHAN_T(aw_chan_lite_t, addr_t)  \
  typedef struct packed {                                   \
    addr_t          addr;                                   \
    axi_pkg::prot_t prot;                                   \
  } aw_chan_lite_t;
`define AXI_LITE_TYPEDEF_W_CHAN_T(w_chan_lite_t, data_t, strb_t)  \
  typedef struct packed {                                         \
    data_t   data;                                                \
    strb_t   strb;                                                \
  } w_chan_lite_t;
`define AXI_LITE_TYPEDEF_B_CHAN_T(b_chan_lite_t)  \
  typedef struct packed {                         \
    axi_pkg::resp_t resp;                         \
  } b_chan_lite_t;
`define AXI_LITE_TYPEDEF_AR_CHAN_T(ar_chan_lite_t, addr_t)  \
  typedef struct packed {                                   \
    addr_t          addr;                                   \
    axi_pkg::prot_t prot;                                   \
  } ar_chan_lite_t;
`define AXI_LITE_TYPEDEF_R_CHAN_T(r_chan_lite_t, data_t)  \
  typedef struct packed {                                 \
    data_t          data;                                 \
    axi_pkg::resp_t resp;                                 \
  } r_chan_lite_t;
`define AXI_LITE_TYPEDEF_REQ_T(req_lite_t, aw_chan_lite_t, w_chan_lite_t, ar_chan_lite_t)  \
  typedef struct packed {                                                                  \
    aw_chan_lite_t aw;                                                                     \
    logic          aw_valid;                                                               \
    w_chan_lite_t  w;                                                                      \
    logic          w_valid;                                                                \
    logic          b_ready;                                                                \
    ar_chan_lite_t ar;                                                                     \
    logic          ar_valid;                                                               \
    logic          r_ready;                                                                \
  } req_lite_t;
`define AXI_LITE_TYPEDEF_RESP_T(resp_lite_t, b_chan_lite_t, r_chan_lite_t)  \
  typedef struct packed {                                                   \
    logic          aw_ready;                                                \
    logic          w_ready;                                                 \
    b_chan_lite_t  b;                                                       \
    logic          b_valid;                                                 \
    logic          ar_ready;                                                \
    r_chan_lite_t  r;                                                       \
    logic          r_valid;                                                 \
  } resp_lite_t;

`define AXI_LITE_TYPEDEF_ALL_CT(__name, __req, __rsp, __addr_t, __data_t, __strb_t)         \
  `AXI_LITE_TYPEDEF_AW_CHAN_T(__name``_aw_chan_t, __addr_t)                                 \
  `AXI_LITE_TYPEDEF_W_CHAN_T(__name``_w_chan_t, __data_t, __strb_t)                         \
  `AXI_LITE_TYPEDEF_B_CHAN_T(__name``_b_chan_t)                                             \
  `AXI_LITE_TYPEDEF_AR_CHAN_T(__name``_ar_chan_t, __addr_t)                                 \
  `AXI_LITE_TYPEDEF_R_CHAN_T(__name``_r_chan_t, __data_t)                                   \
  `AXI_LITE_TYPEDEF_REQ_T(__req, __name``_aw_chan_t, __name``_w_chan_t, __name``_ar_chan_t) \
  `AXI_LITE_TYPEDEF_RESP_T(__rsp, __name``_b_chan_t, __name``_r_chan_t)

`define AXI_LITE_TYPEDEF_ALL(__name, __addr_t, __data_t, __strb_t)                                \
  `AXI_LITE_TYPEDEF_ALL_CT(__name, __name``_req_t, __name``_resp_t, __addr_t, __data_t, __strb_t)

`endif


`ifndef COMMON_CELLS_REGISTERS_SVH_
`define COMMON_CELLS_REGISTERS_SVH_ 0

`define REG_DFLT_CLK clk_i
`define REG_DFLT_RST rst_ni

`define FF(__q, __d, __reset_value, __clk = `REG_DFLT_CLK, __arst_n = `REG_DFLT_RST) \
  always_ff @(posedge (__clk) or negedge (__arst_n)) begin                           \
    if (!__arst_n) begin                                                             \
      __q <= (__reset_value);                                                        \
    end else begin                                                                   \
      __q <= (__d);                                                                  \
    end                                                                              \
  end

`define FFAR(__q, __d, __reset_value, __clk, __arst)     \
  always_ff @(posedge (__clk) or posedge (__arst)) begin \
    if (__arst) begin                                    \
      __q <= (__reset_value);                            \
    end else begin                                       \
      __q <= (__d);                                      \
    end                                                  \
  end

`define FFARN(__q, __d, __reset_value, __clk, __arst_n) \
  `FF(__q, __d, __reset_value, __clk, __arst_n)

`define FFSR(__q, __d, __reset_value, __clk, __reset_clk) \
  always_ff @(posedge (__clk)) begin                      \
    __q <= (__reset_clk) ? (__reset_value) : (__d);       \
  end

`define FFSRN(__q, __d, __reset_value, __clk, __reset_n_clk) \
  always_ff @(posedge (__clk)) begin                         \
    __q <= (!__reset_n_clk) ? (__reset_value) : (__d);       \
  end

`define FFNR(__q, __d, __clk)        \
  always_ff @(posedge (__clk)) begin \
    __q <= (__d);                    \
  end

`define FFL(__q, __d, __load, __reset_value, __clk = `REG_DFLT_CLK, __arst_n = `REG_DFLT_RST) \
  always_ff @(posedge (__clk) or negedge (__arst_n)) begin                                    \
    if (!__arst_n) begin                                                                      \
      __q <= (__reset_value);                                                                 \
    end else begin                                                                            \
      if (__load) begin                                                                       \
        __q <= (__d);                                                                         \
      end                                                                                     \
    end                                                                                       \
  end

`define FFLAR(__q, __d, __load, __reset_value, __clk, __arst) \
  always_ff @(posedge (__clk) or posedge (__arst)) begin      \
    if (__arst) begin                                         \
      __q <= (__reset_value);                                 \
    end else begin                                            \
      if (__load) begin                                       \
        __q <= (__d);                                         \
      end                                                     \
    end                                                       \
  end

`define FFLARN(__q, __d, __load, __reset_value, __clk, __arst_n) \
  `FFL(__q, __d, __load, __reset_value, __clk, __arst_n)

`define FFLSR(__q, __d, __load, __reset_value, __clk, __reset_clk) \
  always_ff @(posedge (__clk)) begin                               \
    if (__reset_clk) begin                                         \
      __q <= (__reset_value);                                      \
    end else if (__load) begin                                     \
      __q <= (__d);                                                \
    end                                                            \
  end

`define FFLSRN(__q, __d, __load, __reset_value, __clk, __reset_n_clk) \
  always_ff @(posedge (__clk)) begin                                  \
    if (!__reset_n_clk) begin                                         \
      __q <= (__reset_value);                                         \
    end else if (__load) begin                                        \
      __q <= (__d);                                                   \
    end                                                               \
  end

`define FFLARNC(__q, __d, __load, __clear, __reset_value, __clk, __arst_n) \
  always_ff @(posedge (__clk) or negedge (__arst_n)) begin                 \
    if (!__arst_n) begin                                                   \
      __q <= (__reset_value);                                              \
    end else begin                                                         \
      if (__clear) begin                                                   \
        __q <= (__reset_value);                                            \
      end else if (__load) begin                                           \
        __q <= (__d);                                                      \
      end                                                                  \
    end                                                                    \
  end

`define FFARNC(__q, __d, __clear, __reset_value, __clk, __arst_n) \
  always_ff @(posedge (__clk) or negedge (__arst_n)) begin        \
    if (!__arst_n) begin                                          \
      __q <= (__reset_value);                                     \
    end else begin                                                \
      if (__clear) begin                                          \
        __q <= (__reset_value);                                   \
      end else begin                                              \
        __q <= (__d);                                             \
      end                                                         \
    end                                                           \
  end

`define FFLNR(__q, __d, __load, __clk) \
  always_ff @(posedge (__clk)) begin   \
    if (__load) begin                  \
      __q <= (__d);                    \
    end                                \
  end

`endif


package axi_pkg;

  parameter int unsigned BurstWidth = 32'd2;
  parameter int unsigned RespWidth = 32'd2;
  parameter int unsigned CacheWidth = 32'd4;
  parameter int unsigned ProtWidth = 32'd3;
  parameter int unsigned QosWidth = 32'd4;
  parameter int unsigned RegionWidth = 32'd4;
  parameter int unsigned LenWidth = 32'd8;
  parameter int unsigned SizeWidth = 32'd3;
  parameter int unsigned LockWidth = 32'd1;
  parameter int unsigned AtopWidth = 32'd6;
  parameter int unsigned NsaidWidth = 32'd4;

  typedef logic [1:0] burst_t;
  typedef logic [1:0] resp_t;
  typedef logic [3:0] cache_t;
  typedef logic [2:0] prot_t;
  typedef logic [3:0] qos_t;
  typedef logic [3:0] region_t;
  typedef logic [7:0] len_t;
  typedef logic [2:0] size_t;
  typedef logic [5:0] atop_t;
  typedef logic [3:0] nsaid_t;

  localparam BURST_FIXED = 2'b00;
  localparam BURST_INCR = 2'b01;
  localparam BURST_WRAP = 2'b10;
  localparam RESP_OKAY = 2'b00;
  localparam RESP_EXOKAY = 2'b01;
  localparam RESP_SLVERR = 2'b10;
  localparam RESP_DECERR = 2'b11;
  localparam CACHE_BUFFERABLE = 4'b0001;
  localparam CACHE_MODIFIABLE = 4'b0010;
  localparam CACHE_RD_ALLOC = 4'b0100;
  localparam CACHE_WR_ALLOC = 4'b1000;



  function automatic shortint unsigned num_bytes(size_t size);
    return 1 << size;
  endfunction



  typedef logic [127:0] largest_addr_t;



  function automatic largest_addr_t aligned_addr(largest_addr_t addr, size_t size);
    return (addr >> size) << size;
  endfunction



  function automatic largest_addr_t wrap_boundary(largest_addr_t addr, size_t size, len_t len);
    largest_addr_t wrap_addr;

    unique case (len)
      4'b1: wrap_addr = (addr >> (unsigned'(size) + 1)) << (unsigned'(size) + 1);
      4'b11: wrap_addr = (addr >> (unsigned'(size) + 2)) << (unsigned'(size) + 2);
      4'b111: wrap_addr = (addr >> (unsigned'(size) + 3)) << (unsigned'(size) + 3);
      4'b1111: wrap_addr = (addr >> (unsigned'(size) + 4)) << (unsigned'(size) + 4);
      default: wrap_addr = '0;
    endcase
    return wrap_addr;
  endfunction



  function automatic largest_addr_t beat_addr(largest_addr_t addr, size_t size, len_t len,
                                              burst_t burst, shortint unsigned i_beat);
    largest_addr_t ret_addr = addr;
    largest_addr_t wrp_bond = '0;
    if (burst == BURST_WRAP) begin

      wrp_bond = wrap_boundary(addr, size, len);
    end
    if (i_beat != 0 && burst != BURST_FIXED) begin

      ret_addr = aligned_addr(addr, size) + i_beat * num_bytes(size);

      if (burst == BURST_WRAP && ret_addr >= wrp_bond + (num_bytes(size) * (len + 1))) begin
        ret_addr = ret_addr - (num_bytes(size) * (len + 1));
      end
    end
    return ret_addr;
  endfunction



  function automatic shortint unsigned beat_lower_byte(
      largest_addr_t addr, size_t size, len_t len, burst_t burst, shortint unsigned strobe_width,
      shortint unsigned i_beat);
    largest_addr_t _addr = beat_addr(addr, size, len, burst, i_beat);
    return shortint'(_addr - (_addr / strobe_width) * strobe_width);
  endfunction



  function automatic shortint unsigned beat_upper_byte(
      largest_addr_t addr, size_t size, len_t len, burst_t burst, shortint unsigned strobe_width,
      shortint unsigned i_beat);
    if (i_beat == 0) begin
      return aligned_addr(addr, size) + (num_bytes(size) - 1) -
          (addr / strobe_width) * strobe_width;
    end else begin
      return beat_lower_byte(addr, size, len, burst, strobe_width, i_beat) + num_bytes(size) - 1;
    end
  endfunction



  function automatic logic bufferable(cache_t cache);
    return |(cache & CACHE_BUFFERABLE);
  endfunction



  function automatic logic modifiable(cache_t cache);
    return |(cache & CACHE_MODIFIABLE);
  endfunction



  typedef enum logic [3:0] {
    DEVICE_NONBUFFERABLE,
    DEVICE_BUFFERABLE,
    NORMAL_NONCACHEABLE_NONBUFFERABLE,
    NORMAL_NONCACHEABLE_BUFFERABLE,
    WTHRU_NOALLOCATE,
    WTHRU_RALLOCATE,
    WTHRU_WALLOCATE,
    WTHRU_RWALLOCATE,
    WBACK_NOALLOCATE,
    WBACK_RALLOCATE,
    WBACK_WALLOCATE,
    WBACK_RWALLOCATE
  } mem_type_t;



  function automatic logic [3:0] get_arcache(mem_type_t mtype);
    unique case (mtype)
      DEVICE_NONBUFFERABLE:              return 4'b0000;
      DEVICE_BUFFERABLE:                 return 4'b0001;
      NORMAL_NONCACHEABLE_NONBUFFERABLE: return 4'b0010;
      NORMAL_NONCACHEABLE_BUFFERABLE:    return 4'b0011;
      WTHRU_NOALLOCATE:                  return 4'b1010;
      WTHRU_RALLOCATE:                   return 4'b1110;
      WTHRU_WALLOCATE:                   return 4'b1010;
      WTHRU_RWALLOCATE:                  return 4'b1110;
      WBACK_NOALLOCATE:                  return 4'b1011;
      WBACK_RALLOCATE:                   return 4'b1111;
      WBACK_WALLOCATE:                   return 4'b1011;
      WBACK_RWALLOCATE:                  return 4'b1111;
    endcase
  endfunction



  function automatic logic [3:0] get_awcache(mem_type_t mtype);
    unique case (mtype)
      DEVICE_NONBUFFERABLE:              return 4'b0000;
      DEVICE_BUFFERABLE:                 return 4'b0001;
      NORMAL_NONCACHEABLE_NONBUFFERABLE: return 4'b0010;
      NORMAL_NONCACHEABLE_BUFFERABLE:    return 4'b0011;
      WTHRU_NOALLOCATE:                  return 4'b0110;
      WTHRU_RALLOCATE:                   return 4'b0110;
      WTHRU_WALLOCATE:                   return 4'b1110;
      WTHRU_RWALLOCATE:                  return 4'b1110;
      WBACK_NOALLOCATE:                  return 4'b0111;
      WBACK_RALLOCATE:                   return 4'b0111;
      WBACK_WALLOCATE:                   return 4'b1111;
      WBACK_RWALLOCATE:                  return 4'b1111;
    endcase
  endfunction



  function automatic resp_t resp_precedence(resp_t resp_a, resp_t resp_b);
    unique case (resp_a)
      RESP_OKAY: begin

        if (resp_b == RESP_EXOKAY) begin
          return resp_a;
        end else begin
          return resp_b;
        end
      end
      RESP_EXOKAY: begin

        return resp_b;
      end
      RESP_SLVERR: begin

        if (resp_b == RESP_DECERR) begin
          return resp_b;
        end else begin
          return resp_a;
        end
      end
      RESP_DECERR: begin

        return resp_a;
      end
    endcase
  endfunction



  function automatic int unsigned aw_width(int unsigned addr_width, int unsigned id_width,
                                           int unsigned user_width);
    return (id_width + addr_width + LenWidth + SizeWidth + BurstWidth + LockWidth + CacheWidth +
            ProtWidth + QosWidth + RegionWidth + AtopWidth + user_width );
  endfunction



  function automatic int unsigned w_width(int unsigned data_width, int unsigned user_width);
    return (data_width + data_width / 32'd8 + 32'd1 + user_width);
  endfunction



  function automatic int unsigned b_width(int unsigned id_width, int unsigned user_width);
    return (id_width + RespWidth + user_width);
  endfunction



  function automatic int unsigned ar_width(int unsigned addr_width, int unsigned id_width,
                                           int unsigned user_width);
    return (id_width + addr_width + LenWidth + SizeWidth + BurstWidth + LockWidth + CacheWidth +
            ProtWidth + QosWidth + RegionWidth + user_width );
  endfunction



  function automatic int unsigned r_width(int unsigned data_width, int unsigned id_width,
                                          int unsigned user_width);
    return (id_width + data_width + RespWidth + 32'd1 + user_width);
  endfunction



  function automatic int unsigned req_width(int unsigned addr_width, int unsigned data_width,
                                            int unsigned id_width, int unsigned aw_user_width,
                                            int unsigned ar_user_width, int unsigned w_user_width);
    return (aw_width(addr_width, id_width, aw_user_width) +
            32'd1 + w_width(data_width, w_user_width) + 32'd1 +
            ar_width(addr_width, id_width, ar_user_width) + 32'd1 + 32'd1 + 32'd1);
  endfunction



  function automatic int unsigned rsp_width(int unsigned data_width, int unsigned id_width,
                                            int unsigned r_user_width, int unsigned b_user_width);
    return (r_width(data_width, id_width, r_user_width) + 32'd1 + b_width(id_width, b_user_width) +
            32'd1 + 32'd1 + 32'd1 + 32'd1);
  endfunction

  localparam ATOP_ATOMICSWAP = 6'b110000;
  localparam ATOP_ATOMICCMP = 6'b110001;
  localparam ATOP_NONE = 2'b00;
  localparam ATOP_ATOMICSTORE = 2'b01;
  localparam ATOP_ATOMICLOAD = 2'b10;
  localparam ATOP_LITTLE_END = 1'b0;
  localparam ATOP_BIG_END = 1'b1;
  localparam ATOP_ADD = 3'b000;
  localparam ATOP_CLR = 3'b001;
  localparam ATOP_EOR = 3'b010;
  localparam ATOP_SET = 3'b011;
  localparam ATOP_SMAX = 3'b100;
  localparam ATOP_SMIN = 3'b101;
  localparam ATOP_UMAX = 3'b110;
  localparam ATOP_UMIN = 3'b111;
  localparam ATOP_R_RESP = 32'd5;

  localparam bit [9:0] DemuxAw = (1 << 9);
  localparam bit [9:0] DemuxW = (1 << 8);
  localparam bit [9:0] DemuxB = (1 << 7);
  localparam bit [9:0] DemuxAr = (1 << 6);
  localparam bit [9:0] DemuxR = (1 << 5);
  localparam bit [9:0] MuxAw = (1 << 4);
  localparam bit [9:0] MuxW = (1 << 3);
  localparam bit [9:0] MuxB = (1 << 2);
  localparam bit [9:0] MuxAr = (1 << 1);
  localparam bit [9:0] MuxR = (1 << 0);

  typedef enum bit [9:0] {
    NO_LATENCY    = 10'b000_00_000_00,
    CUT_SLV_AX    = DemuxAw | DemuxAr,
    CUT_MST_AX    = MuxAw | MuxAr,
    CUT_ALL_AX    = DemuxAw | DemuxAr | MuxAw | MuxAr,
    CUT_SLV_PORTS = DemuxAw | DemuxW | DemuxB | DemuxAr | DemuxR,
    CUT_MST_PORTS = MuxAw | MuxW | MuxB | MuxAr | MuxR,
    CUT_ALL_PORTS = 10'b111_11_111_11
  } xbar_latency_e;

  typedef struct packed {
    int unsigned NoSlvPorts;
    int unsigned NoMstPorts;
    int unsigned MaxMstTrans;
    int unsigned MaxSlvTrans;
    bit FallThrough;
    bit [9:0] LatencyMode;
    int unsigned PipelineStages;
    int unsigned AxiIdWidthSlvPorts;
    int unsigned AxiIdUsedSlvPorts;
    bit UniqueIds;
    int unsigned AxiAddrWidth;
    int unsigned AxiDataWidth;
    int unsigned NoAddrRules;
  } xbar_cfg_t;

  typedef struct packed {
    int unsigned idx;
    logic [63:0] start_addr;
    logic [63:0] end_addr;
  } xbar_rule_64_t;

  typedef struct packed {
    int unsigned idx;
    logic [31:0] start_addr;
    logic [31:0] end_addr;
  } xbar_rule_32_t;

  function automatic integer unsigned iomsb(input integer unsigned width);
    return (width != 32'd0) ? unsigned'(width - 1) : 32'd0;
  endfunction

endpackage

package ariane_axi_pkg;

  typedef enum logic {
    SINGLE_REQ,
    CACHE_LINE_REQ
  } ad_req_t;

  localparam int IdWidth = 4;
  localparam int AddrWidth = 64;
  localparam int DataWidth = 64;
  localparam int StrbWidth = DataWidth / 8;
  localparam int UserWidth = 1;

  `AXI_TYPEDEF_ALL(m, logic [AddrWidth-1:0], logic [IdWidth-1:0], logic [DataWidth-1:0],
                   logic [StrbWidth-1:0], logic [UserWidth-1:0])

endpackage

package riscv_pkg;

  typedef enum logic [1:0] {
    PRIV_LVL_M = 2'b11,
    PRIV_LVL_S = 2'b01,
    PRIV_LVL_U = 2'b00
  } priv_lvl_t;

  typedef enum logic [1:0] {
    XLEN_32  = 2'b01,
    XLEN_64  = 2'b10,
    XLEN_128 = 2'b11
  } xlen_t;

  typedef enum logic [1:0] {
    Off     = 2'b00,
    Initial = 2'b01,
    Clean   = 2'b10,
    Dirty   = 2'b11
  } xs_t;

  typedef struct packed {
    logic         sd;
    logic [62:36] wpri4;
    xlen_t        sxl;
    xlen_t        uxl;
    logic [8:0]   wpri3;
    logic         tsr;
    logic         tw;
    logic         tvm;
    logic         mxr;
    logic         sum;
    logic         mprv;
    xs_t          xs;
    xs_t          fs;
    priv_lvl_t    mpp;
    logic [1:0]   wpri2;
    logic         spp;
    logic         mpie;
    logic         wpri1;
    logic         spie;
    logic         upie;
    logic         mie;
    logic         wpri0;
    logic         sie;
    logic         uie;
  } status_rv64_t;

  typedef struct packed {
    logic       sd;
    logic [7:0] wpri3;
    logic       tsr;
    logic       tw;
    logic       tvm;
    logic       mxr;
    logic       sum;
    logic       mprv;
    logic [1:0] xs;
    logic [1:0] fs;
    priv_lvl_t  mpp;
    logic [1:0] wpri2;
    logic       spp;
    logic       mpie;
    logic       wpri1;
    logic       spie;
    logic       upie;
    logic       mie;
    logic       wpri0;
    logic       sie;
    logic       uie;
  } status_rv32_t;

  typedef struct packed {
    logic [3:0]  mode;
    logic [15:0] asid;
    logic [43:0] ppn;
  } satp_t;

  typedef struct packed {
    logic [31:25] funct7;
    logic [24:20] rs2;
    logic [19:15] rs1;
    logic [14:12] funct3;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } rtype_t;

  typedef struct packed {
    logic [31:27] rs3;
    logic [26:25] funct2;
    logic [24:20] rs2;
    logic [19:15] rs1;
    logic [14:12] funct3;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } r4type_t;

  typedef struct packed {
    logic [31:27] funct5;
    logic [26:25] fmt;
    logic [24:20] rs2;
    logic [19:15] rs1;
    logic [14:12] rm;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } rftype_t;

  typedef struct packed {
    logic [31:30] funct2;
    logic [29:25] vecfltop;
    logic [24:20] rs2;
    logic [19:15] rs1;
    logic [14:14] repl;
    logic [13:12] vfmt;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } rvftype_t;

  typedef struct packed {
    logic [31:20] imm;
    logic [19:15] rs1;
    logic [14:12] funct3;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } itype_t;

  typedef struct packed {
    logic [31:25] imm;
    logic [24:20] rs2;
    logic [19:15] rs1;
    logic [14:12] funct3;
    logic [11:7]  imm0;
    logic [6:0]   opcode;
  } stype_t;

  typedef struct packed {
    logic [31:12] funct3;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } utype_t;

  typedef struct packed {
    logic [31:27] funct5;
    logic         aq;
    logic         rl;
    logic [24:20] rs2;
    logic [19:15] rs1;
    logic [14:12] funct3;
    logic [11:7]  rd;
    logic [6:0]   opcode;
  } atype_t;

  typedef union packed {
    logic [31:0] instr;
    rtype_t      rtype;
    r4type_t     r4type;
    rftype_t     rftype;
    rvftype_t    rvftype;
    itype_t      itype;
    stype_t      stype;
    utype_t      utype;
    atype_t      atype;
  } instruction_t;

  localparam OpcodeLoad = 7'b00_000_11;
  localparam OpcodeLoadFp = 7'b00_001_11;
  localparam OpcodeCustom0 = 7'b00_010_11;
  localparam OpcodeMiscMem = 7'b00_011_11;
  localparam OpcodeOpImm = 7'b00_100_11;
  localparam OpcodeAuipc = 7'b00_101_11;
  localparam OpcodeOpImm32 = 7'b00_110_11;

  localparam OpcodeStore = 7'b01_000_11;
  localparam OpcodeStoreFp = 7'b01_001_11;
  localparam OpcodeCustom1 = 7'b01_010_11;
  localparam OpcodeAmo = 7'b01_011_11;
  localparam OpcodeOp = 7'b01_100_11;
  localparam OpcodeLui = 7'b01_101_11;
  localparam OpcodeOp32 = 7'b01_110_11;

  localparam OpcodeMadd = 7'b10_000_11;
  localparam OpcodeMsub = 7'b10_001_11;
  localparam OpcodeNmsub = 7'b10_010_11;
  localparam OpcodeNmadd = 7'b10_011_11;
  localparam OpcodeOpFp = 7'b10_100_11;
  localparam OpcodeRsrvd1 = 7'b10_101_11;
  localparam OpcodeCustom2 = 7'b10_110_11;

  localparam OpcodeBranch = 7'b11_000_11;
  localparam OpcodeJalr = 7'b11_001_11;
  localparam OpcodeRsrvd2 = 7'b11_010_11;
  localparam OpcodeJal = 7'b11_011_11;
  localparam OpcodeSystem = 7'b11_100_11;
  localparam OpcodeRsrvd3 = 7'b11_101_11;
  localparam OpcodeCustom3 = 7'b11_110_11;

  localparam OpcodeC0 = 2'b00;
  localparam OpcodeC0Addi4spn = 3'b000;
  localparam OpcodeC0Fld = 3'b001;
  localparam OpcodeC0Lw = 3'b010;
  localparam OpcodeC0Ld = 3'b011;
  localparam OpcodeC0Rsrvd = 3'b100;
  localparam OpcodeC0Fsd = 3'b101;
  localparam OpcodeC0Sw = 3'b110;
  localparam OpcodeC0Sd = 3'b111;

  localparam OpcodeC1 = 2'b01;
  localparam OpcodeC1Addi = 3'b000;
  localparam OpcodeC1Addiw = 3'b001;
  localparam OpcodeC1Li = 3'b010;
  localparam OpcodeC1LuiAddi16sp = 3'b011;
  localparam OpcodeC1MiscAlu = 3'b100;
  localparam OpcodeC1J = 3'b101;
  localparam OpcodeC1Beqz = 3'b110;
  localparam OpcodeC1Bnez = 3'b111;

  localparam OpcodeC2 = 2'b10;
  localparam OpcodeC2Slli = 3'b000;
  localparam OpcodeC2Fldsp = 3'b001;
  localparam OpcodeC2Lwsp = 3'b010;
  localparam OpcodeC2Ldsp = 3'b011;
  localparam OpcodeC2JalrMvAdd = 3'b100;
  localparam OpcodeC2Fsdsp = 3'b101;
  localparam OpcodeC2Swsp = 3'b110;
  localparam OpcodeC2Sdsp = 3'b111;

  typedef struct packed {
    logic [9:0] reserved;
    logic [43:0] ppn;
    logic [1:0] rsw;
    logic d;
    logic a;
    logic g;
    logic u;
    logic x;
    logic w;
    logic r;
    logic v;
  } pte_t;

  localparam logic [63:0] INSTR_ADDR_MISALIGNED = 0;
  localparam logic [63:0] INSTR_ACCESS_FAULT = 1;
  localparam logic [63:0] ILLEGAL_INSTR = 2;
  localparam logic [63:0] BREAKPOINT = 3;
  localparam logic [63:0] LD_ADDR_MISALIGNED = 4;
  localparam logic [63:0] LD_ACCESS_FAULT = 5;
  localparam logic [63:0] ST_ADDR_MISALIGNED = 6;
  localparam logic [63:0] ST_ACCESS_FAULT = 7;
  localparam logic [63:0] ENV_CALL_UMODE = 8;
  localparam logic [63:0] ENV_CALL_SMODE = 9;
  localparam logic [63:0] ENV_CALL_MMODE = 11;
  localparam logic [63:0] INSTR_PAGE_FAULT = 12;
  localparam logic [63:0] LOAD_PAGE_FAULT = 13;
  localparam logic [63:0] STORE_PAGE_FAULT = 15;

  localparam int unsigned IRQ_S_SOFT = 1;
  localparam int unsigned IRQ_M_SOFT = 3;
  localparam int unsigned IRQ_S_TIMER = 5;
  localparam int unsigned IRQ_M_TIMER = 7;
  localparam int unsigned IRQ_S_EXT = 9;
  localparam int unsigned IRQ_M_EXT = 11;

  localparam logic [63:0] MIP_SSIP = (1 << IRQ_S_SOFT);
  localparam logic [63:0] MIP_MSIP = (1 << IRQ_M_SOFT);
  localparam logic [63:0] MIP_STIP = (1 << IRQ_S_TIMER);
  localparam logic [63:0] MIP_MTIP = (1 << IRQ_M_TIMER);
  localparam logic [63:0] MIP_SEIP = (1 << IRQ_S_EXT);
  localparam logic [63:0] MIP_MEIP = (1 << IRQ_M_EXT);

  localparam logic [63:0] S_SW_INTERRUPT = (1 << 63) | IRQ_S_SOFT;
  localparam logic [63:0] M_SW_INTERRUPT = (1 << 63) | IRQ_M_SOFT;
  localparam logic [63:0] S_TIMER_INTERRUPT = (1 << 63) | IRQ_S_TIMER;
  localparam logic [63:0] M_TIMER_INTERRUPT = (1 << 63) | IRQ_M_TIMER;
  localparam logic [63:0] S_EXT_INTERRUPT = (1 << 63) | IRQ_S_EXT;
  localparam logic [63:0] M_EXT_INTERRUPT = (1 << 63) | IRQ_M_EXT;

  typedef enum logic [11:0] {

    CSR_FFLAGS = 12'h001,
    CSR_FRM    = 12'h002,
    CSR_FCSR   = 12'h003,
    CSR_FTRAN  = 12'h800,

    CSR_SSTATUS    = 12'h100,
    CSR_SIE        = 12'h104,
    CSR_STVEC      = 12'h105,
    CSR_SCOUNTEREN = 12'h106,
    CSR_SSCRATCH   = 12'h140,
    CSR_SEPC       = 12'h141,
    CSR_SCAUSE     = 12'h142,
    CSR_STVAL      = 12'h143,
    CSR_SIP        = 12'h144,
    CSR_SATP       = 12'h180,

    CSR_MSTATUS    = 12'h300,
    CSR_MISA       = 12'h301,
    CSR_MEDELEG    = 12'h302,
    CSR_MIDELEG    = 12'h303,
    CSR_MIE        = 12'h304,
    CSR_MTVEC      = 12'h305,
    CSR_MCOUNTEREN = 12'h306,
    CSR_MSCRATCH   = 12'h340,
    CSR_MEPC       = 12'h341,
    CSR_MCAUSE     = 12'h342,
    CSR_MTVAL      = 12'h343,
    CSR_MIP        = 12'h344,
    CSR_PMPCFG0    = 12'h3A0,
    CSR_PMPADDR0   = 12'h3B0,
    CSR_MVENDORID  = 12'hF11,
    CSR_MARCHID    = 12'hF12,
    CSR_MIMPID     = 12'hF13,
    CSR_MHARTID    = 12'hF14,
    CSR_MCYCLE     = 12'hB00,
    CSR_MINSTRET   = 12'hB02,
    CSR_DCACHE     = 12'h701,
    CSR_ICACHE     = 12'h700,

    CSR_TSELECT = 12'h7A0,
    CSR_TDATA1  = 12'h7A1,
    CSR_TDATA2  = 12'h7A2,
    CSR_TDATA3  = 12'h7A3,
    CSR_TINFO   = 12'h7A4,

    CSR_DCSR      = 12'h7b0,
    CSR_DPC       = 12'h7b1,
    CSR_DSCRATCH0 = 12'h7b2,
    CSR_DSCRATCH1 = 12'h7b3,

    CSR_CYCLE   = 12'hC00,
    CSR_TIME    = 12'hC01,
    CSR_INSTRET = 12'hC02,

    CSR_L1_ICACHE_MISS = 12'hC03,
    CSR_L1_DCACHE_MISS = 12'hC04,
    CSR_ITLB_MISS      = 12'hC05,
    CSR_DTLB_MISS      = 12'hC06,
    CSR_LOAD           = 12'hC07,
    CSR_STORE          = 12'hC08,
    CSR_EXCEPTION      = 12'hC09,
    CSR_EXCEPTION_RET  = 12'hC0A,
    CSR_BRANCH_JUMP    = 12'hC0B,
    CSR_CALL           = 12'hC0C,
    CSR_RET            = 12'hC0D,
    CSR_MIS_PREDICT    = 12'hC0E,
    CSR_SB_FULL        = 12'hC0F,
    CSR_IF_EMPTY       = 12'hC10
  } csr_reg_t;

  localparam logic [63:0] SSTATUS_UIE = 64'h00000001;
  localparam logic [63:0] SSTATUS_SIE = 64'h00000002;
  localparam logic [63:0] SSTATUS_SPIE = 64'h00000020;
  localparam logic [63:0] SSTATUS_SPP = 64'h00000100;
  localparam logic [63:0] SSTATUS_FS = 64'h00006000;
  localparam logic [63:0] SSTATUS_XS = 64'h00018000;
  localparam logic [63:0] SSTATUS_SUM = 64'h00040000;
  localparam logic [63:0] SSTATUS_MXR = 64'h00080000;
  localparam logic [63:0] SSTATUS_UPIE = 64'h00000010;
  localparam logic [63:0] SSTATUS_UXL = 64'h0000000300000000;
  localparam logic [63:0] SSTATUS64_SD = 64'h8000000000000000;
  localparam logic [63:0] SSTATUS32_SD = 64'h80000000;

  localparam logic [63:0] MSTATUS_UIE = 64'h00000001;
  localparam logic [63:0] MSTATUS_SIE = 64'h00000002;
  localparam logic [63:0] MSTATUS_HIE = 64'h00000004;
  localparam logic [63:0] MSTATUS_MIE = 64'h00000008;
  localparam logic [63:0] MSTATUS_UPIE = 64'h00000010;
  localparam logic [63:0] MSTATUS_SPIE = 64'h00000020;
  localparam logic [63:0] MSTATUS_HPIE = 64'h00000040;
  localparam logic [63:0] MSTATUS_MPIE = 64'h00000080;
  localparam logic [63:0] MSTATUS_SPP = 64'h00000100;
  localparam logic [63:0] MSTATUS_HPP = 64'h00000600;
  localparam logic [63:0] MSTATUS_MPP = 64'h00001800;
  localparam logic [63:0] MSTATUS_FS = 64'h00006000;
  localparam logic [63:0] MSTATUS_XS = 64'h00018000;
  localparam logic [63:0] MSTATUS_MPRV = 64'h00020000;
  localparam logic [63:0] MSTATUS_SUM = 64'h00040000;
  localparam logic [63:0] MSTATUS_MXR = 64'h00080000;
  localparam logic [63:0] MSTATUS_TVM = 64'h00100000;
  localparam logic [63:0] MSTATUS_TW = 64'h00200000;
  localparam logic [63:0] MSTATUS_TSR = 64'h00400000;
  localparam logic [63:0] MSTATUS32_SD = 64'h80000000;
  localparam logic [63:0] MSTATUS_UXL = 64'h0000000300000000;
  localparam logic [63:0] MSTATUS_SXL = 64'h0000000C00000000;
  localparam logic [63:0] MSTATUS64_SD = 64'h8000000000000000;

  typedef enum logic [2:0] {
    CSRRW  = 3'h1,
    CSRRS  = 3'h2,
    CSRRC  = 3'h3,
    CSRRWI = 3'h5,
    CSRRSI = 3'h6,
    CSRRCI = 3'h7
  } csr_op_t;

  typedef struct packed {
    logic [1:0] rw;
    priv_lvl_t  priv_lvl;
    logic [7:0] address;
  } csr_addr_t;

  typedef union packed {
    csr_reg_t  address;
    csr_addr_t csr_decode;
  } csr_t;

  typedef struct packed {
    logic [31:15] reserved;
    logic [6:0]   fprec;
    logic [2:0]   frm;
    logic [4:0]   fflags;
  } fcsr_t;

  typedef struct packed {
    logic [31:28] xdebugver;
    logic [27:16] zero2;
    logic         ebreakm;
    logic         zero1;
    logic         ebreaks;
    logic         ebreaku;
    logic         stepie;
    logic         stopcount;
    logic         stoptime;
    logic [8:6]   cause;
    logic         zero0;
    logic         mprven;
    logic         nmip;
    logic         step;
    priv_lvl_t    prv;
  } dcsr_t;

  function automatic logic [31:0] jal(logic [4:0] rd, logic [20:0] imm);

    return {imm[20], imm[10:1], imm[11], imm[19:12], rd, 7'h6f};
  endfunction

  function automatic logic [31:0] jalr(logic [4:0] rd, logic [4:0] rs1, logic [11:0] offset);

    return {offset[11:0], rs1, 3'b0, rd, 7'h67};
  endfunction

  function automatic logic [31:0] andi(logic [4:0] rd, logic [4:0] rs1, logic [11:0] imm);

    return {imm[11:0], rs1, 3'h7, rd, 7'h13};
  endfunction

  function automatic logic [31:0] slli(logic [4:0] rd, logic [4:0] rs1, logic [5:0] shamt);

    return {6'b0, shamt[5:0], rs1, 3'h1, rd, 7'h13};
  endfunction

  function automatic logic [31:0] srli(logic [4:0] rd, logic [4:0] rs1, logic [5:0] shamt);

    return {6'b0, shamt[5:0], rs1, 3'h5, rd, 7'h13};
  endfunction

  function automatic logic [31:0] load(logic [2:0] size, logic [4:0] dest, logic [4:0] base,
                                       logic [11:0] offset);

    return {offset[11:0], base, size, dest, 7'h03};
  endfunction

  function automatic logic [31:0] auipc(logic [4:0] rd, logic [20:0] imm);

    return {imm[20], imm[10:1], imm[11], imm[19:12], rd, 7'h17};
  endfunction

  function automatic logic [31:0] store(logic [2:0] size, logic [4:0] src, logic [4:0] base,
                                        logic [11:0] offset);

    return {offset[11:5], src, base, size, offset[4:0], 7'h23};
  endfunction

  function automatic logic [31:0] float_load(logic [2:0] size, logic [4:0] dest, logic [4:0] base,
                                             logic [11:0] offset);

    return {offset[11:0], base, size, dest, 7'b00_001_11};
  endfunction

  function automatic logic [31:0] float_store(logic [2:0] size, logic [4:0] src, logic [4:0] base,
                                              logic [11:0] offset);

    return {offset[11:5], src, base, size, offset[4:0], 7'b01_001_11};
  endfunction

  function automatic logic [31:0] csrw(csr_reg_t csr, logic [4:0] rs1);

    return {csr, rs1, 3'h1, 5'h0, 7'h73};
  endfunction

  function automatic logic [31:0] csrr(csr_reg_t csr, logic [4:0] dest);

    return {csr, 5'h0, 3'h2, dest, 7'h73};
  endfunction

  function automatic logic [31:0] ebreak();
    return 32'h00100073;
  endfunction

  function automatic logic [31:0] nop();
    return 32'h00000013;
  endfunction

  function automatic logic [31:0] illegal();
    return 32'h00000000;
  endfunction

  function string spikeCommitLog(logic [63:0] pc, priv_lvl_t priv_lvl, logic [31:0] instr,
                                 logic [4:0] rd, logic [63:0] result, logic rd_fpr);
    string rd_s;
    automatic string rf_s = rd_fpr ? "f" : "x";

    if (rd < 10) rd_s = $sformatf("%s %0d", rf_s, rd);
    else rd_s = $sformatf("%s%0d", rf_s, rd);

    if (rd_fpr || rd != 0) begin
      return $sformatf("%d 0x%h (0x%h) %s 0x%h\n", priv_lvl, pc, instr, rd_s, result);
    end else begin
      return $sformatf("%d 0x%h (0x%h)\n", priv_lvl, pc, instr);
    end
  endfunction

  typedef struct {
    byte priv;
    longint unsigned pc;
    byte is_fp;
    byte rd;
    longint unsigned data;
    int unsigned instr;
    byte was_exception;
  } commit_log_t;

endpackage

package dm;
  localparam logic [3:0] DbgVersion013 = 4'h2;

  localparam logic [4:0] ProgBufSize = 5'h8;

  localparam logic [3:0] DataCount = 4'h2;

  localparam logic [63:0] HaltAddress = 64'h800;
  localparam logic [63:0] ResumeAddress = HaltAddress + 4;
  localparam logic [63:0] ExceptionAddress = HaltAddress + 8;

  localparam logic [11:0] DataAddr = 12'h380;

  typedef enum logic [7:0] {
    Data0        = 8'h04,
    Data1        = 8'h05,
    Data2        = 8'h06,
    Data3        = 8'h07,
    Data4        = 8'h08,
    Data5        = 8'h09,
    Data6        = 8'h0A,
    Data7        = 8'h0B,
    Data8        = 8'h0C,
    Data9        = 8'h0D,
    Data10       = 8'h0E,
    Data11       = 8'h0F,
    DMControl    = 8'h10,
    DMStatus     = 8'h11,
    Hartinfo     = 8'h12,
    HaltSum1     = 8'h13,
    HAWindowSel  = 8'h14,
    HAWindow     = 8'h15,
    AbstractCS   = 8'h16,
    Command      = 8'h17,
    AbstractAuto = 8'h18,
    DevTreeAddr0 = 8'h19,
    DevTreeAddr1 = 8'h1A,
    DevTreeAddr2 = 8'h1B,
    DevTreeAddr3 = 8'h1C,
    NextDM       = 8'h1D,
    ProgBuf0     = 8'h20,
    ProgBuf15    = 8'h2F,
    AuthData     = 8'h30,
    HaltSum2     = 8'h34,
    HaltSum3     = 8'h35,
    SBAddress3   = 8'h37,
    SBCS         = 8'h38,
    SBAddress0   = 8'h39,
    SBAddress1   = 8'h3A,
    SBAddress2   = 8'h3B,
    SBData0      = 8'h3C,
    SBData1      = 8'h3D,
    SBData2      = 8'h3E,
    SBData3      = 8'h3F,
    HaltSum0     = 8'h40
  } dm_csr_t;

  localparam logic [2:0] CauseBreakpoint = 3'h1;
  localparam logic [2:0] CauseTrigger = 3'h2;
  localparam logic [2:0] CauseRequest = 3'h3;
  localparam logic [2:0] CauseSingleStep = 3'h4;

  typedef struct packed {
    logic [31:23] zero1;
    logic         impebreak;
    logic [21:20] zero0;
    logic         allhavereset;
    logic         anyhavereset;
    logic         allresumeack;
    logic         anyresumeack;
    logic         allnonexistent;
    logic         anynonexistent;
    logic         allunavail;
    logic         anyunavail;
    logic         allrunning;
    logic         anyrunning;
    logic         allhalted;
    logic         anyhalted;
    logic         authenticated;
    logic         authbusy;
    logic         hasresethaltreq;
    logic         devtreevalid;
    logic [3:0]   version;
  } dmstatus_t;

  typedef struct packed {
    logic         haltreq;
    logic         resumereq;
    logic         hartreset;
    logic         ackhavereset;
    logic         zero1;
    logic         hasel;
    logic [25:16] hartsello;
    logic [15:6]  hartselhi;
    logic [5:4]   zero0;
    logic         setresethaltreq;
    logic         clrresethaltreq;
    logic         ndmreset;
    logic         dmactive;
  } dmcontrol_t;

  typedef struct packed {
    logic [31:24] zero1;
    logic [23:20] nscratch;
    logic [19:17] zero0;
    logic         dataaccess;
    logic [15:12] datasize;
    logic [11:0]  dataaddr;
  } hartinfo_t;

  typedef enum logic [2:0] {
    CmdErrNone,
    CmdErrBusy,
    CmdErrNotSupported,
    CmdErrorException,
    CmdErrorHaltResume,
    CmdErrorBus,
    CmdErrorOther = 7
  } cmderr_t;

  typedef struct packed {
    logic [31:29] zero3;
    logic [28:24] progbufsize;
    logic [23:13] zero2;
    logic         busy;
    logic         zero1;
    cmderr_t      cmderr;
    logic [7:4]   zero0;
    logic [3:0]   datacount;
  } abstractcs_t;

  typedef enum logic [7:0] {
    AccessRegister = 8'h0,
    QuickAccess    = 8'h1,
    AccessMemory   = 8'h2
  } cmd_t;

  typedef struct packed {
    cmd_t        cmdtype;
    logic [23:0] control;
  } command_t;

  typedef struct packed {
    logic [31:16] autoexecprogbuf;
    logic [15:12] zero0;
    logic [11:0]  autoexecdata;
  } abstractauto_t;

  typedef struct packed {
    logic         zero1;
    logic [22:20] aarsize;
    logic         zero0;
    logic         postexec;
    logic         transfer;
    logic         write;
    logic [15:0]  regno;
  } ac_ar_cmd_t;

  typedef enum logic [1:0] {
    DTM_NOP   = 2'h0,
    DTM_READ  = 2'h1,
    DTM_WRITE = 2'h2
  } dtm_op_t;

  typedef struct packed {
    logic [31:29] sbversion;
    logic [28:23] zero0;
    logic         sbbusyerror;
    logic         sbbusy;
    logic         sbreadonaddr;
    logic [19:17] sbaccess;
    logic         sbautoincrement;
    logic         sbreadondata;
    logic [14:12] sberror;
    logic [11:5]  sbasize;
    logic         sbaccess128;
    logic         sbaccess64;
    logic         sbaccess32;
    logic         sbaccess16;
    logic         sbaccess8;
  } sbcs_t;

  localparam logic [1:0] DTM_SUCCESS = 2'h0;

  typedef struct packed {
    logic [6:0]  addr;
    dtm_op_t     op;
    logic [31:0] data;
  } dmi_req_t;

  typedef struct packed {
    logic [31:0] data;
    logic [1:0]  resp;
  } dmi_resp_t;

endpackage

package ariane_pkg;

  localparam NR_SB_ENTRIES = 8;
  localparam TRANS_ID_BITS = $clog2(NR_SB_ENTRIES);

  localparam ASID_WIDTH = 1;
  localparam BTB_ENTRIES = 64;
  localparam BHT_ENTRIES = 128;
  localparam RAS_DEPTH = 2;
  localparam BITS_SATURATION_COUNTER = 2;
  localparam NR_COMMIT_PORTS = 2;

  localparam ENABLE_RENAME = 1'b0;

  localparam ISSUE_WIDTH = 1;

  localparam NR_LOAD_PIPE_REGS = 1;
  localparam NR_STORE_PIPE_REGS = 0;

  localparam int unsigned DEPTH_SPEC = 4;

  localparam int unsigned DEPTH_COMMIT = 8;

  localparam bit RVF = 1'b1;
  localparam bit RVD = 1'b1;
  localparam bit RVA = 1'b1;

  localparam bit XF16 = 1'b0;
  localparam bit XF16ALT = 1'b0;
  localparam bit XF8 = 1'b0;
  localparam bit XFVEC = 1'b0;

  localparam logic [30:0] LAT_COMP_FP32 = 'd3;
  localparam logic [30:0] LAT_COMP_FP64 = 'd4;
  localparam logic [30:0] LAT_COMP_FP16 = 'd3;
  localparam logic [30:0] LAT_COMP_FP16ALT = 'd3;
  localparam logic [30:0] LAT_COMP_FP8 = 'd2;
  localparam logic [30:0] LAT_DIVSQRT = 'd2;
  localparam logic [30:0] LAT_NONCOMP = 'd1;
  localparam logic [30:0] LAT_CONV = 'd2;

  localparam bit FP_PRESENT = RVF | RVD | XF16 | XF16ALT | XF8;

  localparam FLEN = RVD ? 64 : RVF ? 32 : XF16 ? 16 : XF16ALT ? 16 : XF8 ? 8 : 0;

  localparam bit NSX = XF16 | XF16ALT | XF8 | XFVEC;

  localparam bit RVFVEC = RVF & XFVEC & FLEN > 32;
  localparam bit XF16VEC = XF16 & XFVEC & FLEN > 16;
  localparam bit XF16ALTVEC = XF16ALT & XFVEC & FLEN > 16;
  localparam bit XF8VEC = XF8 & XFVEC & FLEN > 8;

  localparam logic [63:0] ARIANE_MARCHID = 64'd3;

  localparam logic [63:0] ISA_CODE = (RVA << 0)  
  | (1 << 2)  
  | (RVD << 3)  
  | (RVF << 5)  
  | (1 << 8)  
  | (1 << 12)  
  | (0 << 13)  
  | (1 << 18)  
  | (1 << 20)  
  | (NSX << 23)  
  | (1 << 63);

  localparam REG_ADDR_SIZE = 6;
  localparam NR_WB_PORTS = 4;

  localparam dm::hartinfo_t DebugHartInfo = '{
      zero1: '0,
      nscratch: 2,
      zero0: '0,
      dataaccess: 1'b1,
      datasize: dm::DataCount,
      dataaddr: dm::DataAddr
  };

  localparam bit ENABLE_SPIKE_COMMIT_LOG = 1'b1;

  localparam logic INVALIDATE_ON_FLUSH = 1'b1;

  localparam bit ENABLE_CYCLE_COUNT = 1'b1;

  localparam bit ENABLE_WFI = 1'b1;

  localparam bit ZERO_TVAL = 1'b0;

  localparam logic [63:0] SMODE_STATUS_READ_MASK = riscv_pkg::SSTATUS_UIE
                                                   | riscv_pkg::SSTATUS_SIE
                                                   | riscv_pkg::SSTATUS_SPIE
                                                   | riscv_pkg::SSTATUS_SPP
                                                   | riscv_pkg::SSTATUS_FS
                                                   | riscv_pkg::SSTATUS_XS
                                                   | riscv_pkg::SSTATUS_SUM
                                                   | riscv_pkg::SSTATUS_MXR
                                                   | riscv_pkg::SSTATUS_UPIE
                                                   | riscv_pkg::SSTATUS_SPIE
                                                   | riscv_pkg::SSTATUS_UXL
                                                   | riscv_pkg::SSTATUS64_SD;

  localparam logic [63:0] SMODE_STATUS_WRITE_MASK = riscv_pkg::SSTATUS_SIE
                                                    | riscv_pkg::SSTATUS_SPIE
                                                    | riscv_pkg::SSTATUS_SPP
                                                    | riscv_pkg::SSTATUS_FS
                                                    | riscv_pkg::SSTATUS_SUM
                                                    | riscv_pkg::SSTATUS_MXR;

  localparam int unsigned FETCH_FIFO_DEPTH = 8;
  localparam int unsigned FETCH_WIDTH = 32;

  localparam int unsigned INSTR_PER_FETCH = FETCH_WIDTH / 16;

  typedef struct packed {
    logic [63:0] cause;
    logic [63:0] tval;

    logic valid;
  } exception_t;

  typedef enum logic [1:0] {
    BHT,
    BTB,
    RAS
  } cf_t;

  typedef struct packed {
    logic [63:0] pc;
    logic [63:0] target_address;
    logic        is_mispredict;
    logic        is_taken;

    logic valid;
    logic clear;
    cf_t  cf_type;
  } branchpredict_t;

  typedef struct packed {
    logic        valid;
    logic [63:0] predict_address;
    logic        predict_taken;

    cf_t cf_type;
  } branchpredict_sbe_t;

  typedef struct packed {
    logic        valid;
    logic [63:0] pc;
    logic [63:0] target_address;
    logic        clear;
  } btb_update_t;

  typedef struct packed {
    logic        valid;
    logic [63:0] target_address;
  } btb_prediction_t;

  typedef struct packed {
    logic        valid;
    logic [63:0] ra;
  } ras_t;

  typedef struct packed {
    logic        valid;
    logic [63:0] pc;
    logic        mispredict;
    logic        taken;
  } bht_update_t;

  typedef struct packed {
    logic valid;
    logic taken;
    logic strongly_taken;
  } bht_prediction_t;

  typedef enum logic [3:0] {
    NONE,
    LOAD,
    STORE,
    ALU,
    CTRL_FLOW,
    MULT,
    CSR,
    FPU,
    FPU_VEC
  } fu_t;

  localparam EXC_OFF_RST = 8'h80;

  localparam int unsigned ICACHE_INDEX_WIDTH = 12;
  localparam int unsigned ICACHE_TAG_WIDTH = 44;
  localparam int unsigned ICACHE_LINE_WIDTH = 128;
  localparam int unsigned ICACHE_SET_ASSOC = 4;

  localparam int unsigned DCACHE_INDEX_WIDTH = 12;
  localparam int unsigned DCACHE_TAG_WIDTH = 44;
  localparam int unsigned DCACHE_LINE_WIDTH = 128;
  localparam int unsigned DCACHE_SET_ASSOC = 8;

  typedef enum logic [6:0] {
    ADD,
    SUB,
    ADDW,
    SUBW,

    XORL,
    ORL,
    ANDL,

    SRA,
    SRL,
    SLL,
    SRLW,
    SLLW,
    SRAW,

    LTS,
    LTU,
    GES,
    GEU,
    EQ,
    NE,

    JALR,

    SLTS,
    SLTU,

    MRET,
    SRET,
    DRET,
    ECALL,
    WFI,
    FENCE,
    FENCE_I,
    SFENCE_VMA,
    CSR_WRITE,
    CSR_READ,
    CSR_SET,
    CSR_CLEAR,

    LD,
    SD,
    LW,
    LWU,
    SW,
    LH,
    LHU,
    SH,
    LB,
    SB,
    LBU,

    AMO_LRW,
    AMO_LRD,
    AMO_SCW,
    AMO_SCD,
    AMO_SWAPW,
    AMO_ADDW,
    AMO_ANDW,
    AMO_ORW,
    AMO_XORW,
    AMO_MAXW,
    AMO_MAXWU,
    AMO_MINW,
    AMO_MINWU,
    AMO_SWAPD,
    AMO_ADDD,
    AMO_ANDD,
    AMO_ORD,
    AMO_XORD,
    AMO_MAXD,
    AMO_MAXDU,
    AMO_MIND,
    AMO_MINDU,

    MUL,
    MULH,
    MULHU,
    MULHSU,
    MULW,

    DIV,
    DIVU,
    DIVW,
    DIVUW,
    REM,
    REMU,
    REMW,
    REMUW,

    FLD,
    FLW,
    FLH,
    FLB,
    FSD,
    FSW,
    FSH,
    FSB,

    FADD,
    FSUB,
    FMUL,
    FDIV,
    FMIN_MAX,
    FSQRT,
    FMADD,
    FMSUB,
    FNMSUB,
    FNMADD,

    FCVT_F2I,
    FCVT_I2F,
    FCVT_F2F,
    FSGNJ,
    FMV_F2X,
    FMV_X2F,

    FCMP,

    FCLASS,

    VFMIN,
    VFMAX,
    VFSGNJ,
    VFSGNJN,
    VFSGNJX,
    VFEQ,
    VFNE,
    VFLT,
    VFGE,
    VFLE,
    VFGT,
    VFCPKAB_S,
    VFCPKCD_S,
    VFCPKAB_D,
    VFCPKCD_D
  } fu_op;

  typedef struct packed {
    fu_t                      fu;
    fu_op                     operator;
    logic [63:0]              operand_a;
    logic [63:0]              operand_b;
    logic [63:0]              imm;
    logic [TRANS_ID_BITS-1:0] trans_id;
  } fu_data_t;

  function automatic logic is_rs1_fpr(input fu_op op);
    if (FP_PRESENT) begin
      unique case (op) inside
        [FMUL : FNMADD], FCVT_F2I, FCVT_F2F, FSGNJ, FMV_F2X, FCMP, FCLASS, [VFMIN : VFCPKCD_D]:
        return 1'b1;
        default: return 1'b0;
      endcase
    end else return 1'b0;
  endfunction
  ;

  function automatic logic is_rs2_fpr(input fu_op op);
    if (FP_PRESENT) begin
      unique case (op) inside
        [FSD : FSB],  
        [FADD : FMIN_MAX],  
        [FMADD : FNMADD],  
        FCVT_F2F,  
        [FSGNJ : FMV_F2X],  
        FCMP,  
        [VFMIN : VFCPKCD_D]:
        return 1'b1;
        default: return 1'b0;
      endcase
    end else return 1'b0;
  endfunction
  ;

  function automatic logic is_imm_fpr(input fu_op op);
    if (FP_PRESENT) begin
      unique case (op) inside
        [FADD : FSUB], [FMADD : FNMADD], [VFCPKAB_S : VFCPKCD_D]: return 1'b1;
        default: return 1'b0;
      endcase
    end else return 1'b0;
  endfunction
  ;

  function automatic logic is_rd_fpr(input fu_op op);
    if (FP_PRESENT) begin
      unique case (op) inside
        [FLD : FLB],  
        [FADD : FNMADD],  
        FCVT_I2F,  
        FCVT_F2F,  
        FSGNJ,  
        FMV_X2F,  
        [VFMIN : VFSGNJX],  
        [VFCPKAB_S : VFCPKCD_D]:
        return 1'b1;
        default: return 1'b0;
      endcase
    end else return 1'b0;
  endfunction
  ;

  function automatic logic is_amo(fu_op op);
    case (op) inside
      [AMO_LRW : AMO_MINDU]: begin
        return 1'b1;
      end
      default: return 1'b0;
    endcase
  endfunction

  typedef struct packed {
    logic                     valid;
    logic [63:0]              vaddr;
    logic [63:0]              data;
    logic [7:0]               be;
    fu_t                      fu;
    fu_op                     operator;
    logic [TRANS_ID_BITS-1:0] trans_id;
  } lsu_ctrl_t;

  typedef struct packed {
    logic [63:0]                address;
    logic [FETCH_WIDTH-1:0]     instruction;
    branchpredict_sbe_t         branch_predict;
    logic [INSTR_PER_FETCH-1:0] bp_taken;
    logic                       page_fault;
  } frontend_fetch_t;

  typedef struct packed {
    logic [63:0]        address;
    logic [31:0]        instruction;
    branchpredict_sbe_t branch_predict;
    exception_t         ex;
  } fetch_entry_t;

  typedef struct packed {
    logic [63:0] pc;
    logic [TRANS_ID_BITS-1:0] trans_id;

    fu_t fu;
    fu_op op;
    logic [REG_ADDR_SIZE-1:0] rs1;
    logic [REG_ADDR_SIZE-1:0] rs2;
    logic [REG_ADDR_SIZE-1:0] rd;
    logic [63:0] result;

    logic               valid;
    logic               use_imm;
    logic               use_zimm;
    logic               use_pc;
    exception_t         ex;
    branchpredict_sbe_t bp;
    logic               is_compressed;

  } scoreboard_entry_t;

  typedef enum logic [3:0] {
    AMO_NONE = 4'b0000,
    AMO_LR   = 4'b0001,
    AMO_SC   = 4'b0010,
    AMO_SWAP = 4'b0011,
    AMO_ADD  = 4'b0100,
    AMO_AND  = 4'b0101,
    AMO_OR   = 4'b0110,
    AMO_XOR  = 4'b0111,
    AMO_MAX  = 4'b1000,
    AMO_MAXU = 4'b1001,
    AMO_MIN  = 4'b1010,
    AMO_MINU = 4'b1011,
    AMO_CAS1 = 4'b1100,
    AMO_CAS2 = 4'b1101
  } amo_t;

  typedef struct packed {
    logic                  valid;
    logic                  is_2M;
    logic                  is_1G;
    logic [26:0]           vpn;
    logic [ASID_WIDTH-1:0] asid;
    riscv_pkg::pte_t       content;
  } tlb_update_t;

  localparam logic [3:0] MODE_SV39 = 4'h8;
  localparam logic [3:0] MODE_OFF = 4'h0;

  localparam PPN4K_WIDTH = 38;

  typedef struct packed {
    logic        fetch_valid;
    logic [63:0] fetch_paddr;
    exception_t  fetch_exception;
  } icache_areq_i_t;

  typedef struct packed {
    logic        fetch_req;
    logic [63:0] fetch_vaddr;
  } icache_areq_o_t;

  typedef struct packed {
    logic        req;
    logic        kill_s1;
    logic        kill_s2;
    logic [63:0] vaddr;
  } icache_dreq_i_t;

  typedef struct packed {
    logic                   ready;
    logic                   valid;
    logic [FETCH_WIDTH-1:0] data;
    logic [63:0]            vaddr;
    exception_t             ex;
  } icache_dreq_o_t;

  typedef struct packed {
    logic        req;
    amo_t        amo_op;
    logic [1:0]  size;
    logic [63:0] operand_a;
    logic [63:0] operand_b;
  } amo_req_t;

  typedef struct packed {
    logic        ack;
    logic [63:0] result;
  } amo_resp_t;

  typedef struct packed {
    logic [DCACHE_INDEX_WIDTH-1:0] address_index;
    logic [DCACHE_TAG_WIDTH-1:0]   address_tag;
    logic [63:0]                   data_wdata;
    logic                          data_req;
    logic                          data_we;
    logic [7:0]                    data_be;
    logic [1:0]                    data_size;
    logic                          kill_req;
    logic                          tag_valid;
  } dcache_req_i_t;

  typedef struct packed {
    logic        data_gnt;
    logic        data_rvalid;
    logic [63:0] data_rdata;
  } dcache_req_o_t;

  function automatic logic [63:0] sext32(logic [31:0] operand);
    return {{32{operand[31]}}, operand[31:0]};
  endfunction

  function automatic logic [63:0] uj_imm(logic [31:0] instruction_i);
    return {
      {44{instruction_i[31]}}, instruction_i[19:12], instruction_i[20], instruction_i[30:21], 1'b0
    };
  endfunction

  function automatic logic [63:0] i_imm(logic [31:0] instruction_i);
    return {{52{instruction_i[31]}}, instruction_i[31:20]};
  endfunction

  function automatic logic [63:0] sb_imm(logic [31:0] instruction_i);
    return {
      {51{instruction_i[31]}},
      instruction_i[31],
      instruction_i[7],
      instruction_i[30:25],
      instruction_i[11:8],
      1'b0
    };
  endfunction

  function automatic logic [63:0] data_align(logic [2:0] addr, logic [63:0] data);
    case (addr)
      3'b000: return data;
      3'b001: return {data[55:0], data[63:56]};
      3'b010: return {data[47:0], data[63:48]};
      3'b011: return {data[39:0], data[63:40]};
      3'b100: return {data[31:0], data[63:32]};
      3'b101: return {data[23:0], data[63:24]};
      3'b110: return {data[15:0], data[63:16]};
      3'b111: return {data[7:0], data[63:8]};
    endcase
    return data;
  endfunction

  function automatic logic [7:0] be_gen(logic [2:0] addr, logic [1:0] size);
    case (size)
      2'b11: begin
        return 8'b1111_1111;
      end
      2'b10: begin
        case (addr[2:0])
          3'b000: return 8'b0000_1111;
          3'b001: return 8'b0001_1110;
          3'b010: return 8'b0011_1100;
          3'b011: return 8'b0111_1000;
          3'b100: return 8'b1111_0000;
        endcase
      end
      2'b01: begin
        case (addr[2:0])
          3'b000: return 8'b0000_0011;
          3'b001: return 8'b0000_0110;
          3'b010: return 8'b0000_1100;
          3'b011: return 8'b0001_1000;
          3'b100: return 8'b0011_0000;
          3'b101: return 8'b0110_0000;
          3'b110: return 8'b1100_0000;
        endcase
      end
      2'b00: begin
        case (addr[2:0])
          3'b000: return 8'b0000_0001;
          3'b001: return 8'b0000_0010;
          3'b010: return 8'b0000_0100;
          3'b011: return 8'b0000_1000;
          3'b100: return 8'b0001_0000;
          3'b101: return 8'b0010_0000;
          3'b110: return 8'b0100_0000;
          3'b111: return 8'b1000_0000;
        endcase
      end
    endcase
    return 8'b0;
  endfunction

  function automatic logic [1:0] extract_transfer_size(fu_op op);
    case (op)
      LD, SD, FLD, FSD,
            AMO_LRD,   AMO_SCD,
            AMO_SWAPD, AMO_ADDD,
            AMO_ANDD,  AMO_ORD,
            AMO_XORD,  AMO_MAXD,
            AMO_MAXDU, AMO_MIND,
            AMO_MINDU: begin
        return 2'b11;
      end
      LW, LWU, SW, FLW, FSW,
            AMO_LRW,   AMO_SCW,
            AMO_SWAPW, AMO_ADDW,
            AMO_ANDW,  AMO_ORW,
            AMO_XORW,  AMO_MAXW,
            AMO_MAXWU, AMO_MINW,
            AMO_MINWU: begin
        return 2'b10;
      end
      LH, LHU, SH, FLH, FSH: return 2'b01;
      LB, LBU, SB, FLB, FSB: return 2'b00;
      default:               return 2'b11;
    endcase
  endfunction
endpackage

package config_pkg;

  localparam int unsigned ILEN = 32;
  localparam int unsigned NRET = 1;

  typedef enum {

    NOC_TYPE_AXI4_ATOP,

    NOC_TYPE_L15_BIG_ENDIAN,
    NOC_TYPE_L15_LITTLE_ENDIAN
  } noc_type_e;

  typedef enum logic [2:0] {
    WB = 0,
    WT = 1,
    HPDCACHE_WT = 2,
    HPDCACHE_WB = 3,
    HPDCACHE_WT_WB = 4
  } cache_type_t;

  typedef enum logic {
    BHT = 0,
    PH_BHT = 1
  } bp_type_t;

  typedef enum logic [3:0] {
    ModeOff  = 0,
    ModeSv32 = 1,
    ModeSv39 = 8,
    ModeSv48 = 9,
    ModeSv57 = 10,
    ModeSv64 = 11
  } vm_mode_t;

  typedef enum {
    COPRO_NONE,
    COPRO_EXAMPLE
  } copro_type_t;

  localparam NrMaxRules = 16;

  typedef struct packed {

    int unsigned XLEN;

    int unsigned VLEN;

    bit RVA;

    bit RVB;

    bit ZKN;

    bit RVV;

    bit RVC;

    bit RVH;

    bit RVZCB;

    bit RVZCMP;

    bit RVZCMT;

    bit RVZiCond;

    bit RVZicntr;

    bit RVZihpm;

    bit RVF;

    bit RVD;

    bit XF16;

    bit XF16ALT;

    bit XF8;

    bit XFVec;

    bit PerfCounterEn;

    bit MmuPresent;

    bit RVS;

    bit RVU;

    bit SoftwareInterruptEn;

    bit DebugEn;

    logic [63:0] DmBaseAddress;

    logic [63:0] HaltAddress;

    logic [63:0] ExceptionAddress;

    bit TvalEn;

    bit DirectVecOnly;

    int unsigned NrPMPEntries;

    logic [63:0][63:0] PMPCfgRstVal;

    logic [63:0][63:0] PMPAddrRstVal;

    bit [63:0] PMPEntryReadOnly;

    bit PMPNapotEn;

    int unsigned NrNonIdempotentRules;

    logic [NrMaxRules-1:0][63:0] NonIdempotentAddrBase;

    logic [NrMaxRules-1:0][63:0] NonIdempotentLength;

    int unsigned NrExecuteRegionRules;

    logic [NrMaxRules-1:0][63:0] ExecuteRegionAddrBase;

    logic [NrMaxRules-1:0][63:0] ExecuteRegionLength;

    int unsigned NrCachedRegionRules;

    logic [NrMaxRules-1:0][63:0] CachedRegionAddrBase;

    logic [NrMaxRules-1:0][63:0] CachedRegionLength;

    bit CvxifEn;

    copro_type_t CoproType;

    noc_type_e NOCType;

    int unsigned AxiAddrWidth;

    int unsigned AxiDataWidth;

    int unsigned AxiIdWidth;

    int unsigned AxiUserWidth;

    bit AxiBurstWriteEn;

    int unsigned MemTidWidth;

    int unsigned IcacheByteSize;

    int unsigned IcacheSetAssoc;

    int unsigned IcacheLineWidth;

    cache_type_t DCacheType;

    int unsigned DcacheIdWidth;

    int unsigned DcacheByteSize;

    int unsigned DcacheSetAssoc;

    int unsigned DcacheLineWidth;

    bit DcacheFlushOnFence;

    bit DcacheInvalidateOnFlush;

    int unsigned DataUserEn;

    int unsigned WtDcacheWbufDepth;

    int unsigned FetchUserEn;

    int unsigned FetchUserWidth;

    bit FpgaEn;

    bit FpgaAlteraEn;

    bit TechnoCut;

    bit SuperscalarEn;

    int unsigned NrCommitPorts;

    int unsigned NrLoadPipeRegs;

    int unsigned NrStorePipeRegs;

    int unsigned NrScoreboardEntries;

    int unsigned NrLoadBufEntries;

    int unsigned MaxOutstandingStores;

    int unsigned RASDepth;

    int unsigned BTBEntries;

    bp_type_t BPType;

    int unsigned BHTEntries;

    int unsigned BHTHist;

    int unsigned InstrTlbEntries;

    int unsigned DataTlbEntries;

    bit unsigned UseSharedTlb;

    int unsigned SharedTlbDepth;
  } cva6_user_cfg_t;

  typedef struct packed {
    int unsigned XLEN;
    int unsigned VLEN;
    int unsigned PLEN;
    int unsigned GPLEN;
    bit IS_XLEN32;
    bit IS_XLEN64;
    int unsigned XLEN_ALIGN_BYTES;
    int unsigned ASID_WIDTH;
    int unsigned VMID_WIDTH;

    bit FpgaEn;
    bit FpgaAlteraEn;
    bit TechnoCut;

    bit          SuperscalarEn;
    int unsigned NrCommitPorts;
    int unsigned NrIssuePorts;
    bit          SpeculativeSb;

    int unsigned NrLoadPipeRegs;
    int unsigned NrStorePipeRegs;

    int unsigned AxiAddrWidth;
    int unsigned AxiDataWidth;
    int unsigned AxiIdWidth;
    int unsigned AxiUserWidth;
    int unsigned MEM_TID_WIDTH;
    int unsigned NrLoadBufEntries;
    bit          RVF;
    bit          RVD;
    bit          XF16;
    bit          XF16ALT;
    bit          XF8;
    bit          RVA;
    bit          RVB;
    bit          ZKN;
    bit          RVV;
    bit          RVC;
    bit          RVH;
    bit          RVZCB;
    bit          RVZCMP;
    bit          RVZCMT;
    bit          XFVec;
    bit          CvxifEn;
    copro_type_t CoproType;
    bit          RVZiCond;
    bit          RVZicntr;
    bit          RVZihpm;

    int unsigned NR_SB_ENTRIES;
    int unsigned TRANS_ID_BITS;

    bit          FpPresent;
    bit          NSX;
    int unsigned FLen;
    bit          RVFVec;
    bit          XF16Vec;
    bit          XF16ALTVec;
    bit          XF8Vec;
    int unsigned NrRgprPorts;
    int unsigned NrWbPorts;
    bit          EnableAccelerator;
    bit          PerfCounterEn;
    bit          MmuPresent;
    bit          RVS;
    bit          RVU;
    bit          SoftwareInterruptEn;

    logic [63:0] HaltAddress;
    logic [63:0] ExceptionAddress;
    int unsigned RASDepth;
    int unsigned BTBEntries;
    bp_type_t    BPType;
    int unsigned BHTEntries;
    int unsigned BHTHist;
    int unsigned InstrTlbEntries;
    int unsigned DataTlbEntries;
    bit unsigned UseSharedTlb;
    int unsigned SharedTlbDepth;
    int unsigned VpnLen;
    int unsigned PtLevels;

    logic [63:0]                 DmBaseAddress;
    bit                          TvalEn;
    bit                          DirectVecOnly;
    int unsigned                 NrPMPEntries;
    logic [63:0][63:0]           PMPCfgRstVal;
    logic [63:0][63:0]           PMPAddrRstVal;
    bit [63:0]                   PMPEntryReadOnly;
    bit                          PMPNapotEn;
    noc_type_e                   NOCType;
    int unsigned                 NrNonIdempotentRules;
    logic [NrMaxRules-1:0][63:0] NonIdempotentAddrBase;
    logic [NrMaxRules-1:0][63:0] NonIdempotentLength;
    int unsigned                 NrExecuteRegionRules;
    logic [NrMaxRules-1:0][63:0] ExecuteRegionAddrBase;
    logic [NrMaxRules-1:0][63:0] ExecuteRegionLength;
    int unsigned                 NrCachedRegionRules;
    logic [NrMaxRules-1:0][63:0] CachedRegionAddrBase;
    logic [NrMaxRules-1:0][63:0] CachedRegionLength;
    int unsigned                 MaxOutstandingStores;
    bit                          DebugEn;
    bit                          NonIdemPotenceEn;
    bit                          AxiBurstWriteEn;

    int unsigned ICACHE_SET_ASSOC;
    int unsigned ICACHE_SET_ASSOC_WIDTH;
    int unsigned ICACHE_INDEX_WIDTH;
    int unsigned ICACHE_TAG_WIDTH;
    int unsigned ICACHE_LINE_WIDTH;
    int unsigned ICACHE_USER_LINE_WIDTH;
    cache_type_t DCacheType;
    int unsigned DcacheIdWidth;
    int unsigned DCACHE_SET_ASSOC;
    int unsigned DCACHE_SET_ASSOC_WIDTH;
    int unsigned DCACHE_INDEX_WIDTH;
    int unsigned DCACHE_TAG_WIDTH;
    int unsigned DCACHE_LINE_WIDTH;
    int unsigned DCACHE_USER_LINE_WIDTH;
    int unsigned DCACHE_USER_WIDTH;
    int unsigned DCACHE_OFFSET_WIDTH;
    int unsigned DCACHE_NUM_WORDS;

    int unsigned DCACHE_MAX_TX;

    bit DcacheFlushOnFence;
    bit DcacheInvalidateOnFlush;

    int unsigned DATA_USER_EN;
    int unsigned WtDcacheWbufDepth;
    int unsigned FETCH_USER_WIDTH;
    int unsigned FETCH_USER_EN;
    bit          AXI_USER_EN;

    int unsigned FETCH_WIDTH;
    int unsigned FETCH_ALIGN_BITS;
    int unsigned INSTR_PER_FETCH;
    int unsigned LOG2_INSTR_PER_FETCH;

    int unsigned ModeW;
    int unsigned ASIDW;
    int unsigned VMIDW;
    int unsigned PPNW;
    int unsigned GPPNW;
    vm_mode_t MODE_SV;
    int unsigned SV;
    int unsigned SVX;

    int unsigned X_NUM_RS;
    int unsigned X_ID_WIDTH;
    int unsigned X_RFR_WIDTH;
    int unsigned X_RFW_WIDTH;
    int unsigned X_NUM_HARTS;
    int unsigned X_HARTID_WIDTH;
    int unsigned X_DUALREAD;
    int unsigned X_DUALWRITE;
    int unsigned X_ISSUE_REGISTER_SPLIT;

  } cva6_cfg_t;

  localparam cva6_cfg_t cva6_cfg_empty = cva6_cfg_t'(0);

  function automatic void check_cfg(cva6_cfg_t Cfg);

    assert (Cfg.RASDepth > 0);
    assert (Cfg.BTBEntries == 0 || (2 ** $clog2(Cfg.BTBEntries) == Cfg.BTBEntries));
    assert (Cfg.BHTEntries == 0 || (2 ** $clog2(Cfg.BHTEntries) == Cfg.BHTEntries));
    assert (Cfg.NrNonIdempotentRules <= NrMaxRules);
    assert (Cfg.NrExecuteRegionRules <= NrMaxRules);
    assert (Cfg.NrCachedRegionRules <= NrMaxRules);
    assert (Cfg.NrPMPEntries <= 64);
    assert (!(Cfg.SuperscalarEn && Cfg.RVF));
    assert (Cfg.FETCH_WIDTH == 32 || Cfg.FETCH_WIDTH == 64)
    else $fatal(1, "[frontend] fetch width != not supported");

    assert (!(Cfg.RVS && !Cfg.SoftwareInterruptEn));
    assert (!(Cfg.RVH && !Cfg.SoftwareInterruptEn));
    assert (!(Cfg.RVZCMT && ~Cfg.MmuPresent));

  endfunction

  function automatic logic range_check(logic [63:0] base, logic [63:0] len, logic [63:0] address);

    return (address >= base) && (({1'b0, address}) < (65'(base) + len));
  endfunction : range_check

  function automatic logic is_inside_nonidempotent_regions(cva6_cfg_t Cfg, logic [63:0] address);
    logic [NrMaxRules-1:0] pass;
    pass = '0;
    for (int unsigned k = 0; k < Cfg.NrNonIdempotentRules; k++) begin
      pass[k] = range_check(Cfg.NonIdempotentAddrBase[k], Cfg.NonIdempotentLength[k], address);
    end
    return |pass;
  endfunction : is_inside_nonidempotent_regions

  function automatic logic is_inside_execute_regions(cva6_cfg_t Cfg, logic [63:0] address);

    logic [NrMaxRules-1:0] pass;
    if (Cfg.NrExecuteRegionRules != 0) begin
      pass = '0;
      for (int unsigned k = 0; k < Cfg.NrExecuteRegionRules; k++) begin
        pass[k] = range_check(Cfg.ExecuteRegionAddrBase[k], Cfg.ExecuteRegionLength[k], address);
      end
      return |pass;
    end else begin
      return 1;
    end
  endfunction : is_inside_execute_regions

  function automatic logic is_inside_cacheable_regions(cva6_cfg_t Cfg, logic [63:0] address);
    automatic logic [NrMaxRules-1:0] pass;
    pass = '0;
    for (int unsigned k = 0; k < Cfg.NrCachedRegionRules; k++) begin
      pass[k] = range_check(Cfg.CachedRegionAddrBase[k], Cfg.CachedRegionLength[k], address);
    end
    return |pass;
  endfunction : is_inside_cacheable_regions

endpackage

package fpnew_pkg;

  typedef struct packed {
    int unsigned exp_bits;
    int unsigned man_bits;
  } fp_encoding_t;

  localparam int unsigned NUM_FP_FORMATS = 5;
  localparam int unsigned FP_FORMAT_BITS = $clog2(NUM_FP_FORMATS);

  typedef enum logic [FP_FORMAT_BITS-1:0] {
    FP32    = 'd0,
    FP64    = 'd1,
    FP16    = 'd2,
    FP8     = 'd3,
    FP16ALT = 'd4

  } fp_format_e;

  localparam fp_encoding_t [0:NUM_FP_FORMATS-1] FP_ENCODINGS = '{
      '{8, 23},
      '{11, 52},
      '{5, 10},
      '{5, 2},
      '{8, 7}

  };

  typedef logic [0:NUM_FP_FORMATS-1] fmt_logic_t;
  typedef logic [0:NUM_FP_FORMATS-1][31:0] fmt_unsigned_t;

  localparam fmt_logic_t CPK_FORMATS = 5'b11000;

  localparam int unsigned NUM_INT_FORMATS = 4;
  localparam int unsigned INT_FORMAT_BITS = $clog2(NUM_INT_FORMATS);

  typedef enum logic [INT_FORMAT_BITS-1:0] {
    INT8,
    INT16,
    INT32,
    INT64

  } int_format_e;

  function automatic int unsigned int_width(int_format_e ifmt);
    unique case (ifmt)
      INT8:  return 8;
      INT16: return 16;
      INT32: return 32;
      INT64: return 64;
      default: begin

        $fatal(1, "Invalid INT format supplied");

        return INT8;
      end
    endcase
  endfunction

  typedef logic [0:NUM_INT_FORMATS-1] ifmt_logic_t;

  localparam int unsigned NUM_OPGROUPS = 4;

  typedef enum logic [1:0] {
    ADDMUL,
    DIVSQRT,
    NONCOMP,
    CONV
  } opgroup_e;

  localparam int unsigned OP_BITS = 4;

  typedef enum logic [OP_BITS-1:0] {
    FMADD,
    FNMSUB,
    ADD,
    MUL,
    DIV,
    SQRT,
    SGNJ,
    MINMAX,
    CMP,
    CLASSIFY,
    F2F,
    F2I,
    I2F,
    CPKAB,
    CPKCD
  } operation_e;

  typedef enum logic [2:0] {
    RNE = 3'b000,
    RTZ = 3'b001,
    RDN = 3'b010,
    RUP = 3'b011,
    RMM = 3'b100,
    ROD = 3'b101,
    DYN = 3'b111
  } roundmode_e;

  typedef struct packed {
    logic NV;
    logic DZ;
    logic OF;
    logic UF;
    logic NX;
  } status_t;

  typedef struct packed {
    logic is_normal;
    logic is_subnormal;
    logic is_zero;
    logic is_inf;
    logic is_nan;
    logic is_signalling;
    logic is_quiet;
    logic is_boxed;
  } fp_info_t;

  typedef enum logic [9:0] {
    NEGINF     = 10'b00_0000_0001,
    NEGNORM    = 10'b00_0000_0010,
    NEGSUBNORM = 10'b00_0000_0100,
    NEGZERO    = 10'b00_0000_1000,
    POSZERO    = 10'b00_0001_0000,
    POSSUBNORM = 10'b00_0010_0000,
    POSNORM    = 10'b00_0100_0000,
    POSINF     = 10'b00_1000_0000,
    SNAN       = 10'b01_0000_0000,
    QNAN       = 10'b10_0000_0000
  } classmask_e;

  typedef enum logic [1:0] {
    BEFORE,
    AFTER,
    INSIDE,
    DISTRIBUTED
  } pipe_config_t;

  typedef enum logic [1:0] {
    DISABLED,
    PARALLEL,
    MERGED
  } unit_type_t;

  typedef unit_type_t [0:NUM_FP_FORMATS-1] fmt_unit_types_t;

  typedef fmt_unit_types_t [0:NUM_OPGROUPS-1] opgrp_fmt_unit_types_t;

  typedef fmt_unsigned_t [0:NUM_OPGROUPS-1] opgrp_fmt_unsigned_t;

  typedef struct packed {
    int unsigned Width;
    logic        EnableVectors;
    logic        EnableNanBox;
    fmt_logic_t  FpFmtMask;
    ifmt_logic_t IntFmtMask;
  } fpu_features_t;

  localparam fpu_features_t RV64D = '{
      Width: 64,
      EnableVectors: 1'b0,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b11000,
      IntFmtMask: 4'b0011
  };

  localparam fpu_features_t RV32D = '{
      Width: 64,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b11000,
      IntFmtMask: 4'b0010
  };

  localparam fpu_features_t RV32F = '{
      Width: 32,
      EnableVectors: 1'b0,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b10000,
      IntFmtMask: 4'b0010
  };

  localparam fpu_features_t RV64D_Xsflt = '{
      Width: 64,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b11111,
      IntFmtMask: 4'b1111
  };

  localparam fpu_features_t RV32F_Xsflt = '{
      Width: 32,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b10111,
      IntFmtMask: 4'b1110
  };

  localparam fpu_features_t RV32F_Xf16alt_Xfvec = '{
      Width: 32,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b10001,
      IntFmtMask: 4'b0110
  };

  typedef struct packed {
    opgrp_fmt_unsigned_t   PipeRegs;
    opgrp_fmt_unit_types_t UnitTypes;
    pipe_config_t          PipeConfig;
  } fpu_implementation_t;

  localparam fpu_implementation_t DEFAULT_NOREGS = '{
      PipeRegs: '{default: 0},
      UnitTypes: '{
          '{default: PARALLEL},
          '{default: MERGED},
          '{default: PARALLEL},
          '{default: MERGED}
      },
      PipeConfig: BEFORE
  };

  localparam fpu_implementation_t DEFAULT_SNITCH = '{
      PipeRegs: '{default: 1},
      UnitTypes: '{
          '{default: PARALLEL},
          '{default: DISABLED},
          '{default: PARALLEL},
          '{default: MERGED}
      },
      PipeConfig: BEFORE
  };

  localparam logic DONT_CARE = 1'b1;

  function automatic int minimum(int a, int b);
    return (a < b) ? a : b;
  endfunction

  function automatic int maximum(int a, int b);
    return (a > b) ? a : b;
  endfunction

  function automatic int unsigned fp_width(fp_format_e fmt);
    return FP_ENCODINGS[fmt].exp_bits + FP_ENCODINGS[fmt].man_bits + 1;
  endfunction

  function automatic int unsigned max_fp_width(fmt_logic_t cfg);
    automatic int unsigned res = 0;
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++)
    if (cfg[i]) res = unsigned'(maximum(res, fp_width(fp_format_e'(i))));
    return res;
  endfunction

  function automatic int unsigned min_fp_width(fmt_logic_t cfg);
    automatic int unsigned res = max_fp_width(cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++)
    if (cfg[i]) res = unsigned'(minimum(res, fp_width(fp_format_e'(i))));
    return res;
  endfunction

  function automatic int unsigned exp_bits(fp_format_e fmt);
    return FP_ENCODINGS[fmt].exp_bits;
  endfunction

  function automatic int unsigned man_bits(fp_format_e fmt);
    return FP_ENCODINGS[fmt].man_bits;
  endfunction

  function automatic int unsigned bias(fp_format_e fmt);
    return unsigned'(2 ** (FP_ENCODINGS[fmt].exp_bits - 1) - 1);
  endfunction

  function automatic fp_encoding_t super_format(fmt_logic_t cfg);
    automatic fp_encoding_t res;
    res = '0;
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)
    if (cfg[fmt]) begin
      res.exp_bits = unsigned'(maximum(res.exp_bits, exp_bits(fp_format_e'(fmt))));
      res.man_bits = unsigned'(maximum(res.man_bits, man_bits(fp_format_e'(fmt))));
    end
    return res;
  endfunction

  function automatic int unsigned max_int_width(ifmt_logic_t cfg);
    automatic int unsigned res = 0;
    for (int ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++) begin
      if (cfg[ifmt]) res = maximum(res, int_width(int_format_e'(ifmt)));
    end
    return res;
  endfunction

  function automatic opgroup_e get_opgroup(operation_e op);
    unique case (op)
      FMADD, FNMSUB, ADD, MUL:     return ADDMUL;
      DIV, SQRT:                   return DIVSQRT;
      SGNJ, MINMAX, CMP, CLASSIFY: return NONCOMP;
      F2F, F2I, I2F, CPKAB, CPKCD: return CONV;
      default:                     return NONCOMP;
    endcase
  endfunction

  function automatic int unsigned num_operands(opgroup_e grp);
    unique case (grp)
      ADDMUL:  return 3;
      DIVSQRT: return 2;
      NONCOMP: return 2;
      CONV:    return 3;
      default: return 0;
    endcase
  endfunction

  function automatic int unsigned num_lanes(int unsigned width, fp_format_e fmt, logic vec);
    return vec ? width / fp_width(fmt) : 1;
  endfunction

  function automatic int unsigned max_num_lanes(int unsigned width, fmt_logic_t cfg, logic vec);
    return vec ? width / min_fp_width(cfg) : 1;
  endfunction

  function automatic fmt_logic_t get_lane_formats(int unsigned width, fmt_logic_t cfg,
                                                  int unsigned lane_no);
    automatic fmt_logic_t res;
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)

    res[fmt] = cfg[fmt] & (width / fp_width(fp_format_e'(fmt)) > lane_no);
    return res;
  endfunction

  function automatic ifmt_logic_t get_lane_int_formats(int unsigned width, fmt_logic_t cfg,
                                                       ifmt_logic_t icfg, int unsigned lane_no);
    automatic ifmt_logic_t res;
    automatic fmt_logic_t  lanefmts;
    res = '0;
    lanefmts = get_lane_formats(width, cfg, lane_no);

    for (int unsigned ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++)
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)

    if ((fp_width(fp_format_e'(fmt)) == int_width(int_format_e'(ifmt))))
      res[ifmt] |= icfg[ifmt] && lanefmts[fmt];
    return res;
  endfunction

  function automatic fmt_logic_t get_conv_lane_formats(int unsigned width, fmt_logic_t cfg,
                                                       int unsigned lane_no);
    automatic fmt_logic_t res;
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)

    res[fmt] = cfg[fmt] &&
        ((width / fp_width(fp_format_e'(fmt)) > lane_no) || (CPK_FORMATS[fmt] && (lane_no < 2)));
    return res;
  endfunction

  function automatic ifmt_logic_t get_conv_lane_int_formats(
      int unsigned width, fmt_logic_t cfg, ifmt_logic_t icfg, int unsigned lane_no);
    automatic ifmt_logic_t res;
    automatic fmt_logic_t  lanefmts;
    res = '0;
    lanefmts = get_conv_lane_formats(width, cfg, lane_no);

    for (int unsigned ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++)
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)

    res[ifmt] |= icfg[ifmt] && lanefmts[fmt] && (fp_width(
        fp_format_e'(fmt)
    ) == int_width(
        int_format_e'(ifmt)
    ));
    return res;
  endfunction

  function automatic logic any_enabled_multi(fmt_unit_types_t types, fmt_logic_t cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++) if (cfg[i] && types[i] == MERGED) return 1'b1;
    return 1'b0;
  endfunction

  function automatic logic is_first_enabled_multi(fp_format_e fmt, fmt_unit_types_t types,
                                                  fmt_logic_t cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++) begin
      if (cfg[i] && types[i] == MERGED) return (fp_format_e'(i) == fmt);
    end
    return 1'b0;
  endfunction

  function automatic fp_format_e get_first_enabled_multi(fmt_unit_types_t types, fmt_logic_t cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++)
    if (cfg[i] && types[i] == MERGED) return fp_format_e'(i);
    return fp_format_e'(0);
  endfunction

  function automatic int unsigned get_num_regs_multi(fmt_unsigned_t regs, fmt_unit_types_t types,
                                                     fmt_logic_t cfg);
    automatic int unsigned res = 0;
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++) begin
      if (cfg[i] && types[i] == MERGED) res = maximum(res, regs[i]);
    end
    return res;
  endfunction

endpackage

package defs_div_sqrt_mvp;

  localparam C_RM = 3;
  localparam C_RM_NEAREST = 3'h0;
  localparam C_RM_TRUNC = 3'h1;
  localparam C_RM_PLUSINF = 3'h2;
  localparam C_RM_MINUSINF = 3'h3;
  localparam C_PC = 6;
  localparam C_FS = 2;
  localparam C_IUNC = 2;
  localparam Iteration_unit_num_S = 2'b10;

  localparam C_OP_FP64 = 64;
  localparam C_MANT_FP64 = 52;
  localparam C_EXP_FP64 = 11;
  localparam C_BIAS_FP64 = 1023;
  localparam C_BIAS_AONE_FP64 = 11'h400;
  localparam C_HALF_BIAS_FP64 = 511;
  localparam C_EXP_ZERO_FP64 = 11'h000;
  localparam C_EXP_ONE_FP64 = 13'h001;
  localparam C_EXP_INF_FP64 = 11'h7FF;
  localparam C_MANT_ZERO_FP64 = 52'h0;
  localparam C_MANT_NAN_FP64 = 52'h8_0000_0000_0000;
  localparam C_PZERO_FP64 = 64'h0000_0000_0000_0000;
  localparam C_MZERO_FP64 = 64'h8000_0000_0000_0000;
  localparam C_QNAN_FP64 = 64'h7FF8_0000_0000_0000;

  localparam C_OP_FP32 = 32;
  localparam C_MANT_FP32 = 23;
  localparam C_EXP_FP32 = 8;
  localparam C_BIAS_FP32 = 127;
  localparam C_BIAS_AONE_FP32 = 8'h80;
  localparam C_HALF_BIAS_FP32 = 63;
  localparam C_EXP_ZERO_FP32 = 8'h00;
  localparam C_EXP_INF_FP32 = 8'hFF;
  localparam C_MANT_ZERO_FP32 = 23'h0;
  localparam C_PZERO_FP32 = 32'h0000_0000;
  localparam C_MZERO_FP32 = 32'h8000_0000;
  localparam C_QNAN_FP32 = 32'h7FC0_0000;

  localparam C_OP_FP16 = 16;
  localparam C_MANT_FP16 = 10;
  localparam C_EXP_FP16 = 5;
  localparam C_BIAS_FP16 = 15;
  localparam C_BIAS_AONE_FP16 = 5'h10;
  localparam C_HALF_BIAS_FP16 = 7;
  localparam C_EXP_ZERO_FP16 = 5'h00;
  localparam C_EXP_INF_FP16 = 5'h1F;
  localparam C_MANT_ZERO_FP16 = 10'h0;
  localparam C_PZERO_FP16 = 16'h0000;
  localparam C_MZERO_FP16 = 16'h8000;
  localparam C_QNAN_FP16 = 16'h7E00;

  localparam C_OP_FP16ALT = 16;
  localparam C_MANT_FP16ALT = 7;
  localparam C_EXP_FP16ALT = 8;
  localparam C_BIAS_FP16ALT = 127;
  localparam C_BIAS_AONE_FP16ALT = 8'h80;
  localparam C_HALF_BIAS_FP16ALT = 63;
  localparam C_EXP_ZERO_FP16ALT = 8'h00;
  localparam C_EXP_INF_FP16ALT = 8'hFF;
  localparam C_MANT_ZERO_FP16ALT = 7'h0;
  localparam C_QNAN_FP16ALT = 16'h7FC0;

endpackage : defs_div_sqrt_mvp
package std_cache_pkg;

    
    localparam DCACHE_BYTE_OFFSET = $clog2(ariane_pkg::DCACHE_LINE_WIDTH/8);
    localparam DCACHE_NUM_WORDS   = 2**(ariane_pkg::DCACHE_INDEX_WIDTH-DCACHE_BYTE_OFFSET);
    localparam DCACHE_DIRTY_WIDTH = ariane_pkg::DCACHE_SET_ASSOC*2;
    

    typedef struct packed {
        logic [1:0]      id;     
        logic            valid;
        logic            we;
        logic [55:0]     addr;
        logic [7:0][7:0] wdata;
        logic [7:0]      be;
    } mshr_t;

    typedef struct packed {
        logic         valid;
        logic [63:0]  addr;
        logic [7:0]   be;
        logic [1:0]   size;
        logic         we;
        logic [63:0]  wdata;
        logic         bypass;
    } miss_req_t;

    typedef struct packed {
        logic [ariane_pkg::DCACHE_TAG_WIDTH-1:0]  tag;    
        logic [ariane_pkg::DCACHE_LINE_WIDTH-1:0] data;   
        logic                                     valid;  
        logic                                     dirty;  
    } cache_line_t;

    
    typedef struct packed {
        logic [(ariane_pkg::DCACHE_TAG_WIDTH+7)/8-1:0]  tag;    
        logic [(ariane_pkg::DCACHE_LINE_WIDTH+7)/8-1:0] data;   
        logic [ariane_pkg::DCACHE_SET_ASSOC-1:0]        vldrty; 
    } cl_be_t;

    
    function automatic logic [$clog2(ariane_pkg::DCACHE_SET_ASSOC)-1:0] one_hot_to_bin (
        input logic [ariane_pkg::DCACHE_SET_ASSOC-1:0] in
    );
        for (int unsigned i = 0; i < ariane_pkg::DCACHE_SET_ASSOC; i++) begin
            if (in[i])
                return i;
        end
    endfunction
    
    function automatic logic [ariane_pkg::DCACHE_SET_ASSOC-1:0] get_victim_cl (
        input logic [ariane_pkg::DCACHE_SET_ASSOC-1:0] valid_dirty
    );
        
        logic [ariane_pkg::DCACHE_SET_ASSOC-1:0] oh = '0;
        for (int unsigned i = 0; i < ariane_pkg::DCACHE_SET_ASSOC; i++) begin
            if (valid_dirty[i]) begin
                oh[i] = 1'b1;
                return oh;
            end
        end
    endfunction
endpackage : std_cache_pkg

module ras #(
    parameter int unsigned DEPTH = 2
) (
    input  logic                    clk_i,
    input  logic                    rst_ni,
    input  logic                    push_i,
    input  logic                    pop_i,
    input  logic             [63:0] data_i,
    output ariane_pkg::ras_t        data_o
);

  ariane_pkg::ras_t [DEPTH-1:0] stack_d, stack_q;

  assign data_o = stack_q[0];

  always_comb begin
    stack_d = stack_q;

    if (push_i) begin
      stack_d[0].ra = data_i;

      stack_d[0].valid = 1'b1;
      stack_d[DEPTH-1:1] = stack_q[DEPTH-2:0];
    end

    if (pop_i) begin
      stack_d[DEPTH-2:0] = stack_q[DEPTH-1:1];

      stack_d[DEPTH-1].valid = 1'b0;
      stack_d[DEPTH-1].ra = 'b0;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      stack_q <= '0;
    end else begin
      stack_q <= stack_d;
    end
  end
endmodule


module btb #(
    parameter int NR_ENTRIES = 8
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic debug_mode_i,

    input  logic                        [63:0] vpc_i,
    input  ariane_pkg::btb_update_t            btb_update_i,
    output ariane_pkg::btb_prediction_t        btb_prediction_o
);

  localparam OFFSET = 1;
  localparam ANTIALIAS_BITS = 8;

  localparam PREDICTION_BITS = $clog2(NR_ENTRIES) + OFFSET;

  ariane_pkg::btb_prediction_t btb_d[NR_ENTRIES-1:0], btb_q[NR_ENTRIES-1:0];
  logic [$clog2(NR_ENTRIES)-1:0] index, update_pc;

  assign index            = vpc_i[PREDICTION_BITS-1:OFFSET];
  assign update_pc        = btb_update_i.pc[PREDICTION_BITS-1:OFFSET];

  assign btb_prediction_o = btb_q[index];

  always_comb begin : update_branch_predict
    btb_d = btb_q;

    if (btb_update_i.valid && !debug_mode_i) begin
      btb_d[update_pc].valid = 1'b1;

      btb_d[update_pc].target_address = btb_update_i.target_address;

      if (btb_update_i.clear) begin
        btb_d[update_pc].valid = 1'b0;
      end
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin

      for (int i = 0; i < NR_ENTRIES; i++) btb_q[i] <= '{default: 0};
    end else begin

      if (flush_i) begin
        for (int i = 0; i < NR_ENTRIES; i++) begin
          btb_q[i].valid <= 1'b0;
        end
      end else begin
        btb_q <= btb_d;
      end
    end
  end
endmodule


module bht #(
    parameter int unsigned NR_ENTRIES = 1024
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic debug_mode_i,

    input  logic                        [63:0] vpc_i,
    input  ariane_pkg::bht_update_t            bht_update_i,
    output ariane_pkg::bht_prediction_t        bht_prediction_o
);
  localparam OFFSET = 2;
  localparam ANTIALIAS_BITS = 8;

  localparam PREDICTION_BITS = $clog2(NR_ENTRIES) + OFFSET;

  struct packed {
    logic       valid;
    logic [1:0] saturation_counter;
  }
      bht_d[NR_ENTRIES-1:0], bht_q[NR_ENTRIES-1:0];

  logic [$clog2(NR_ENTRIES)-1:0] index, update_pc;
  logic [1:0] saturation_counter;

  assign index                           = vpc_i[PREDICTION_BITS-1:OFFSET];
  assign update_pc                       = bht_update_i.pc[PREDICTION_BITS-1:OFFSET];

  assign bht_prediction_o.valid          = bht_q[index].valid;
  assign bht_prediction_o.taken          = bht_q[index].saturation_counter == 2'b10;
  assign bht_prediction_o.strongly_taken = (bht_q[index].saturation_counter == 2'b11);
  always_comb begin : update_bht
    bht_d = bht_q;
    saturation_counter = bht_q[update_pc].saturation_counter;

    if (bht_update_i.valid && !debug_mode_i) begin
      bht_d[update_pc].valid = 1'b1;

      if (saturation_counter == 2'b11) begin

        if (~bht_update_i.taken) bht_d[update_pc].saturation_counter = saturation_counter - 1;

      end else if (saturation_counter == 2'b00) begin

        if (bht_update_i.taken) bht_d[update_pc].saturation_counter = saturation_counter + 1;
      end else begin
        if (bht_update_i.taken) bht_d[update_pc].saturation_counter = saturation_counter + 1;
        else bht_d[update_pc].saturation_counter = saturation_counter - 1;
      end
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      for (int unsigned i = 0; i < NR_ENTRIES; i++) bht_q[i] <= '0;
    end else begin

      if (flush_i) begin
        for (int i = 0; i < NR_ENTRIES; i++) begin
          bht_q[i].valid <= 1'b0;
          bht_q[i].saturation_counter <= 2'b10;
        end
      end else begin
        bht_q <= bht_d;
      end
    end
  end
endmodule


module instr_scan (
    input  logic [31:0] instr_i,
    output logic        is_rvc_o,
    output logic        rvi_return_o,
    output logic        rvi_call_o,
    output logic        rvi_branch_o,
    output logic        rvi_jalr_o,
    output logic        rvi_jump_o,
    output logic [63:0] rvi_imm_o,
    output logic        rvc_branch_o,
    output logic        rvc_jump_o,
    output logic        rvc_jr_o,
    output logic        rvc_return_o,
    output logic        rvc_jalr_o,
    output logic        rvc_call_o,
    output logic [63:0] rvc_imm_o
);
  assign is_rvc_o = (instr_i[1:0] != 2'b11);

  assign rvi_return_o = rvi_jalr_o & ~instr_i[7] & ~instr_i[19] & ~instr_i[18] & ~instr_i[16] & instr_i[15];
  assign rvi_call_o = (rvi_jalr_o | rvi_jump_o) & instr_i[7];

  assign rvi_imm_o = (instr_i[3]) ? ariane_pkg::uj_imm(instr_i) : ariane_pkg::sb_imm(instr_i);
  assign rvi_branch_o = (instr_i[6:0] == riscv_pkg::OpcodeBranch) ? 1'b1 : 1'b0;
  assign rvi_jalr_o = (instr_i[6:0] == riscv_pkg::OpcodeJalr) ? 1'b1 : 1'b0;
  assign rvi_jump_o = (instr_i[6:0] == riscv_pkg::OpcodeJal) ? 1'b1 : 1'b0;

  assign rvc_jump_o   = (instr_i[15:13] == riscv_pkg::OpcodeC1J) & is_rvc_o & (instr_i[1:0] == riscv_pkg::OpcodeC1);

  assign rvc_jr_o     = (instr_i[15:13] == riscv_pkg::OpcodeC2JalrMvAdd)
                        & ~instr_i[12]
                        & (instr_i[6:2] == 5'b00000)
                        & (instr_i[1:0] == riscv_pkg::OpcodeC2)
                        & is_rvc_o;
  assign rvc_branch_o = ((instr_i[15:13] == riscv_pkg::OpcodeC1Beqz) | (instr_i[15:13] == riscv_pkg::OpcodeC1Bnez))
                        & (instr_i[1:0] == riscv_pkg::OpcodeC1)
                        & is_rvc_o;

  assign rvc_return_o = ~instr_i[11] & ~instr_i[10] & ~instr_i[8] & instr_i[7] & rvc_jr_o;

  assign rvc_jalr_o   = (instr_i[15:13] == riscv_pkg::OpcodeC2JalrMvAdd)
                        & instr_i[12]
                        & (instr_i[6:2] == 5'b00000) & is_rvc_o;
  assign rvc_call_o = rvc_jalr_o;

  assign rvc_imm_o    = (instr_i[14]) ? {{56{instr_i[12]}}, instr_i[6:5], instr_i[2], instr_i[11:10], instr_i[4:3], 1'b0}
                                       : {{53{instr_i[12]}}, instr_i[8], instr_i[10:9], instr_i[6], instr_i[7], instr_i[2], instr_i[11], instr_i[5:3], 1'b0};
endmodule


module fifo_v3 #(
    parameter bit          FALL_THROUGH = 1'b0,
    parameter int unsigned DATA_WIDTH   = 32,
    parameter int unsigned DEPTH        = 8,
    parameter type         dtype        = logic [DATA_WIDTH-1:0],

    parameter int unsigned ADDR_DEPTH = (DEPTH > 1) ? $clog2(DEPTH) : 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic testmode_i,

    output logic full_o,
    output logic empty_o,
    output logic [ADDR_DEPTH-1:0] usage_o,

    input dtype data_i,
    input logic push_i,

    output dtype data_o,
    input  logic pop_i
);

  localparam int unsigned FIFO_DEPTH = (DEPTH > 0) ? DEPTH : 1;

  logic gate_clock;

  logic [ADDR_DEPTH - 1:0] read_pointer_n, read_pointer_q, write_pointer_n, write_pointer_q;

  logic [ADDR_DEPTH:0] status_cnt_n, status_cnt_q;

  dtype [FIFO_DEPTH - 1:0] mem_n, mem_q;

  assign usage_o = status_cnt_q[ADDR_DEPTH-1:0];

  if (DEPTH == 0) begin
    assign empty_o = ~push_i;
    assign full_o  = ~pop_i;
  end else begin
    assign full_o  = (status_cnt_q == FIFO_DEPTH[ADDR_DEPTH:0]);
    assign empty_o = (status_cnt_q == 0) & ~(FALL_THROUGH & push_i);
  end

  always_comb begin : read_write_comb

    read_pointer_n  = read_pointer_q;
    write_pointer_n = write_pointer_q;
    status_cnt_n    = status_cnt_q;
    data_o          = (DEPTH == 0) ? data_i : mem_q[read_pointer_q];
    mem_n           = mem_q;
    gate_clock      = 1'b1;

    if (push_i && ~full_o) begin

      mem_n[write_pointer_q] = data_i;

      gate_clock = 1'b0;

      if (write_pointer_q == FIFO_DEPTH[ADDR_DEPTH-1:0] - 1) write_pointer_n = '0;
      else write_pointer_n = write_pointer_q + 1;

      status_cnt_n = status_cnt_q + 1;
    end

    if (pop_i && ~empty_o) begin

      if (read_pointer_n == FIFO_DEPTH[ADDR_DEPTH-1:0] - 1) read_pointer_n = '0;
      else read_pointer_n = read_pointer_q + 1;

      status_cnt_n = status_cnt_q - 1;
    end

    if (push_i && pop_i && ~full_o && ~empty_o) status_cnt_n = status_cnt_q;

    if (FALL_THROUGH && (status_cnt_q == 0) && push_i && pop_i) begin
      data_o = data_i;
      status_cnt_n = status_cnt_q;
      read_pointer_n = read_pointer_q;
      write_pointer_n = write_pointer_q;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      read_pointer_q  <= '0;
      write_pointer_q <= '0;
      status_cnt_q    <= '0;
    end else begin
      if (flush_i) begin
        read_pointer_q  <= '0;
        write_pointer_q <= '0;
        status_cnt_q    <= '0;
      end else begin
        read_pointer_q  <= read_pointer_n;
        write_pointer_q <= write_pointer_n;
        status_cnt_q    <= status_cnt_n;
      end
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      mem_q <= '0;
    end else if (!gate_clock) begin
      mem_q <= mem_n;
    end
  end

endmodule


module fifo_v2 #(
    parameter bit          FALL_THROUGH = 1'b0,
    parameter int unsigned DATA_WIDTH   = 32,
    parameter int unsigned DEPTH        = 8,
    parameter int unsigned ALM_EMPTY_TH = 1,
    parameter int unsigned ALM_FULL_TH  = 1,
    parameter type         dtype        = logic [DATA_WIDTH-1:0],

    parameter int unsigned ADDR_DEPTH = (DEPTH > 1) ? $clog2(DEPTH) : 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic testmode_i,

    output logic full_o,
    output logic empty_o,
    output logic alm_full_o,
    output logic alm_empty_o,

    input dtype data_i,
    input logic push_i,

    output dtype data_o,
    input  logic pop_i
);

  logic [ADDR_DEPTH-1:0] usage;

  if (DEPTH == 0) begin
    assign alm_full_o  = 1'b0;
    assign alm_empty_o = 1'b0;
  end else begin
    assign alm_full_o  = (usage >= ALM_FULL_TH[ADDR_DEPTH-1:0]);
    assign alm_empty_o = (usage <= ALM_EMPTY_TH[ADDR_DEPTH-1:0]);
  end

  fifo_v3 #(
      .FALL_THROUGH(FALL_THROUGH),
      .DATA_WIDTH  (DATA_WIDTH),
      .DEPTH       (DEPTH),
      .dtype       (dtype)
  ) i_fifo_v3 (
      .clk_i,
      .rst_ni,
      .flush_i,
      .testmode_i,
      .full_o,
      .empty_o,
      .usage_o(usage),
      .data_i,
      .push_i,
      .data_o,
      .pop_i
  );

endmodule


import ariane_pkg::*;
module frontend #(
    parameter logic [63:0] DmBaseAddress = 64'h0
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic flush_bp_i,
    input logic debug_mode_i,

    input logic [63:0] boot_addr_i,

    input branchpredict_t resolved_branch_i,

    input logic        set_pc_commit_i,
    input logic [63:0] pc_commit_i,

    input logic [63:0] epc_i,
    input logic        eret_i,
    input logic [63:0] trap_vector_base_i,
    input logic        ex_valid_i,
    input logic        set_debug_pc_i,

    input  icache_dreq_o_t icache_dreq_i,
    output icache_dreq_i_t icache_dreq_o,

    output frontend_fetch_t fetch_entry_o,
    output logic            fetch_entry_valid_o,
    input  logic            fetch_ack_i
);

  logic            [               31:0] icache_data_q;
  logic                                  icache_valid_q;
  logic                                  icache_ex_valid_q;
  logic                                  instruction_valid;
  logic            [INSTR_PER_FETCH-1:0] instr_is_compressed;

  logic            [               63:0] icache_vaddr_q;

  bht_prediction_t                       bht_prediction;
  btb_prediction_t                       btb_prediction;
  ras_t                                  ras_predict;
  bht_update_t                           bht_update;
  btb_update_t                           btb_update;
  logic ras_push, ras_pop;
  logic [63:0] ras_update;

  logic        if_ready;
  logic [63:0] npc_d, npc_q;
  logic npc_rst_load_q;

  logic [INSTR_PER_FETCH-1:0] rvi_return, rvi_call, rvi_branch, rvi_jalr, rvi_jump;
  logic [INSTR_PER_FETCH-1:0][63:0] rvi_imm;

  logic [INSTR_PER_FETCH-1:0]       is_rvc;
  logic [INSTR_PER_FETCH-1:0] rvc_branch, rvc_jump, rvc_jr, rvc_return, rvc_jalr, rvc_call;
  logic               [INSTR_PER_FETCH-1:0][63:0] rvc_imm;

  logic               [INSTR_PER_FETCH-1:0][31:0] instr;
  logic               [INSTR_PER_FETCH-1:0][63:0] addr;

  logic               [               63:0]       bp_vaddr;
  logic                                           bp_valid;
  logic                                           is_mispredict;

  branchpredict_sbe_t                             bp_sbe;

  logic fifo_valid, fifo_ready, fifo_empty, fifo_pop;
  logic s2_eff_kill, issue_req, s2_in_flight_d, s2_in_flight_q;
  logic [$clog2(FETCH_FIFO_DEPTH):0] fifo_credits_d;
  logic [$clog2(FETCH_FIFO_DEPTH):0] fifo_credits_q;

  logic [15:0] unaligned_instr_d, unaligned_instr_q;

  logic unaligned_d, unaligned_q;

  logic [63:0] unaligned_address_d, unaligned_address_q;

  for (genvar i = 0; i < INSTR_PER_FETCH; i++) begin

    assign instr_is_compressed[i] = ~&icache_data_q[i*16+:2];
  end

  always_comb begin : re_align
    unaligned_d = unaligned_q;
    unaligned_address_d = unaligned_address_q;
    unaligned_instr_d = unaligned_instr_q;
    instruction_valid = icache_valid_q;

    instr[0] = icache_data_q;
    addr[0] = icache_vaddr_q;

    instr[1] = '0;
    addr[1] = {icache_vaddr_q[63:2], 2'b10};

    if (icache_valid_q) begin

      if (unaligned_q) begin
        instr[0] = {icache_data_q[15:0], unaligned_instr_q};
        addr[0] = unaligned_address_q;

        unaligned_address_d = {icache_vaddr_q[63:2], 2'b10};
        unaligned_instr_d = icache_data_q[31:16];

        if (instr_is_compressed[1]) begin
          unaligned_d = 1'b0;
          instr[1] = {16'b0, icache_data_q[31:16]};
        end
      end else if (instr_is_compressed[0]) begin

        if (instr_is_compressed[1]) begin
          instr[1] = {16'b0, icache_data_q[31:16]};
        end else begin
          unaligned_instr_d = icache_data_q[31:16];
          unaligned_address_d = {icache_vaddr_q[63:2], 2'b10};
          unaligned_d = 1'b1;
        end
      end
    end

    if (icache_valid_q && icache_vaddr_q[1] && !instr_is_compressed[1]) begin
      instruction_valid = 1'b0;
      unaligned_d = 1'b1;
      unaligned_address_d = {icache_vaddr_q[63:2], 2'b10};
      unaligned_instr_d = icache_data_q[31:16];
    end

    if (icache_dreq_o.kill_s2) begin
      unaligned_d = 1'b0;
    end
  end

  logic [INSTR_PER_FETCH:0] taken;

  always_comb begin : frontend_ctrl
    automatic logic take_rvi_cf;
    automatic logic take_rvc_cf;

    take_rvi_cf    = 1'b0;
    take_rvc_cf    = 1'b0;
    ras_pop        = 1'b0;
    ras_push       = 1'b0;
    ras_update     = '0;
    taken          = '0;
    take_rvi_cf    = 1'b0;

    bp_vaddr       = '0;
    bp_valid       = 1'b0;

    bp_sbe.cf_type = RAS;

    if (instruction_valid) begin

      for (int unsigned i = 0; i < INSTR_PER_FETCH; i++) begin

        if (!taken[i]) begin

          ras_push   = rvi_call[i] | rvc_call[i];
          ras_update = addr[i] + (rvc_call[i] ? 2 : 4);

          if (rvi_branch[i] || rvc_branch[i]) begin
            bp_sbe.cf_type = BHT;

            if (bht_prediction.valid) begin
              take_rvi_cf = rvi_branch[i] & (bht_prediction.taken | bht_prediction.strongly_taken);
              take_rvc_cf = rvc_branch[i] & (bht_prediction.taken | bht_prediction.strongly_taken);

            end else begin

              take_rvi_cf = rvi_branch[i] & rvi_imm[i][63];
              take_rvc_cf = rvc_branch[i] & rvc_imm[i][63];
            end
          end

          if (rvi_jump[i] || rvc_jump[i]) begin
            take_rvi_cf = rvi_jump[i];
            take_rvc_cf = rvc_jump[i];
          end

          if ((rvi_jalr[i] || rvc_jalr[i]) && ~(rvi_call[i] || rvc_call[i])) begin
            bp_sbe.cf_type = BTB;
            if (btb_prediction.valid) begin
              bp_vaddr   = btb_prediction.target_address;
              taken[i+1] = 1'b1;
            end
          end

          if ((rvi_return[i] || rvc_return[i]) && ras_predict.valid) begin
            bp_vaddr = ras_predict.ra;
            ras_pop = 1'b1;
            taken[i+1] = 1'b1;
            bp_sbe.cf_type = RAS;
          end

          if (take_rvi_cf) begin
            taken[i+1] = 1'b1;
            bp_vaddr   = addr[i] + rvi_imm[i];
          end

          if (take_rvc_cf) begin
            taken[i+1] = 1'b1;
            bp_vaddr   = addr[i] + rvc_imm[i];
          end

          if (icache_vaddr_q[1]) begin
            taken[1] = 1'b0;

            ras_pop  = 1'b0;
            ras_push = 1'b0;
          end
        end
      end
    end

    bp_valid = |taken;

    bp_sbe.valid = bp_valid;
    bp_sbe.predict_address = bp_vaddr;
    bp_sbe.predict_taken = bp_valid;
  end

  assign is_mispredict = resolved_branch_i.valid & resolved_branch_i.is_mispredict;

  assign icache_dreq_o.kill_s1 = is_mispredict | flush_i;

  assign icache_dreq_o.kill_s2 = icache_dreq_o.kill_s1 | bp_valid;
  assign fifo_valid = icache_valid_q;

  assign bht_update.valid = resolved_branch_i.valid & (resolved_branch_i.cf_type == BHT);
  assign bht_update.pc    = resolved_branch_i.pc;
  assign bht_update.mispredict = resolved_branch_i.is_mispredict;
  assign bht_update.taken = resolved_branch_i.is_taken;

  assign btb_update.valid = resolved_branch_i.valid & (resolved_branch_i.cf_type == BTB);
  assign btb_update.pc    = resolved_branch_i.pc;
  assign btb_update.target_address = resolved_branch_i.target_address;
  assign btb_update.clear = resolved_branch_i.clear;

  always_comb begin : npc_select
    automatic logic [63:0] fetch_address;

    if (npc_rst_load_q) begin
      npc_d         = boot_addr_i;
      fetch_address = boot_addr_i;
    end else begin
      fetch_address = npc_q;

      npc_d         = npc_q;
    end

    if (bp_valid) begin
      fetch_address = bp_vaddr;
      npc_d = bp_vaddr;
    end

    if (if_ready) begin
      npc_d = {fetch_address[63:2], 2'b0} + 'h4;
    end

    if (is_mispredict) begin
      npc_d = resolved_branch_i.target_address;
    end

    if (eret_i) begin
      npc_d = epc_i;
    end

    if (ex_valid_i) begin
      npc_d = trap_vector_base_i;
    end

    if (set_pc_commit_i) begin

      npc_d = pc_commit_i + 64'h4;
    end

    if (set_debug_pc_i) begin
      npc_d = DmBaseAddress + dm::HaltAddress;
    end

    icache_dreq_o.vaddr = fetch_address;
  end

  assign fifo_credits_d       =  (flush_i) ? FETCH_FIFO_DEPTH :
                                               fifo_credits_q + fifo_pop + s2_eff_kill - issue_req;

  assign s2_eff_kill = s2_in_flight_q & icache_dreq_o.kill_s2;
  assign s2_in_flight_d      = (flush_i)             ? 1'b0 :
                                 (issue_req)           ? 1'b1 :
                                 (icache_dreq_i.valid) ? 1'b0 :
                                                         s2_in_flight_q;

  assign issue_req = if_ready & (~icache_dreq_o.kill_s1);
  assign fifo_pop = fetch_ack_i & fetch_entry_valid_o;
  assign fifo_ready = (|fifo_credits_q);
  assign if_ready = icache_dreq_i.ready & fifo_ready;
  assign icache_dreq_o.req = fifo_ready;
  assign fetch_entry_valid_o = ~fifo_empty;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      npc_q               <= '0;
      npc_rst_load_q      <= 1'b1;
      icache_data_q       <= '0;
      icache_valid_q      <= 1'b0;
      icache_vaddr_q      <= 'b0;
      icache_ex_valid_q   <= 1'b0;
      unaligned_q         <= 1'b0;
      unaligned_address_q <= '0;
      unaligned_instr_q   <= '0;
      fifo_credits_q      <= FETCH_FIFO_DEPTH;
      s2_in_flight_q      <= 1'b0;
    end else begin
      npc_rst_load_q      <= 1'b0;
      npc_q               <= npc_d;
      icache_data_q       <= icache_dreq_i.data;
      icache_valid_q      <= icache_dreq_i.valid;
      icache_vaddr_q      <= icache_dreq_i.vaddr;
      icache_ex_valid_q   <= icache_dreq_i.ex.valid;
      unaligned_q         <= unaligned_d;
      unaligned_address_q <= unaligned_address_d;
      unaligned_instr_q   <= unaligned_instr_d;
      fifo_credits_q      <= fifo_credits_d;
      s2_in_flight_q      <= s2_in_flight_d;
    end
  end

  ras #(
      .DEPTH(RAS_DEPTH)
  ) i_ras (
      .push_i(ras_push),
      .pop_i (ras_pop),
      .data_i(ras_update),
      .data_o(ras_predict),
      .*
  );

  btb #(
      .NR_ENTRIES(BTB_ENTRIES)
  ) i_btb (
      .clk_i,
      .rst_ni,
      .flush_i         (flush_bp_i),
      .debug_mode_i,
      .vpc_i           (icache_vaddr_q),
      .btb_update_i    (btb_update),
      .btb_prediction_o(btb_prediction)
  );

  bht #(
      .NR_ENTRIES(BHT_ENTRIES)
  ) i_bht (
      .clk_i,
      .rst_ni,
      .flush_i         (flush_bp_i),
      .debug_mode_i,
      .vpc_i           (icache_vaddr_q),
      .bht_update_i    (bht_update),
      .bht_prediction_o(bht_prediction)
  );

  for (genvar i = 0; i < INSTR_PER_FETCH; i++) begin
    instr_scan i_instr_scan (
        .instr_i     (instr[i]),
        .is_rvc_o    (is_rvc[i]),
        .rvi_return_o(rvi_return[i]),
        .rvi_call_o  (rvi_call[i]),
        .rvi_branch_o(rvi_branch[i]),
        .rvi_jalr_o  (rvi_jalr[i]),
        .rvi_jump_o  (rvi_jump[i]),
        .rvi_imm_o   (rvi_imm[i]),
        .rvc_branch_o(rvc_branch[i]),
        .rvc_jump_o  (rvc_jump[i]),
        .rvc_jr_o    (rvc_jr[i]),
        .rvc_return_o(rvc_return[i]),
        .rvc_jalr_o  (rvc_jalr[i]),
        .rvc_call_o  (rvc_call[i]),
        .rvc_imm_o   (rvc_imm[i])
    );
  end

  fifo_v2 #(
      .DEPTH(8),
      .dtype(frontend_fetch_t)
  ) i_fetch_fifo (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .flush_i(flush_i),
      .testmode_i(1'b0),
      .full_o(),
      .empty_o(fifo_empty),
      .alm_full_o(),
      .alm_empty_o(),
      .data_i({icache_vaddr_q, icache_data_q, bp_sbe, taken[INSTR_PER_FETCH:1], icache_ex_valid_q}),
      .push_i(fifo_valid),
      .data_o(fetch_entry_o),
      .pop_i(fifo_pop)
  );

endmodule


import ariane_pkg::*;
module instr_realigner (
    input logic clk_i,
    input logic rst_ni,

    input logic flush_i,

    input  frontend_fetch_t fetch_entry_i,
    input  logic            fetch_entry_valid_i,
    output logic            fetch_ack_o,

    output fetch_entry_t fetch_entry_o,
    output logic         fetch_entry_valid_o,
    input  logic         fetch_ack_i
);

  logic unaligned_n, unaligned_q;

  logic [15:0] unaligned_instr_n, unaligned_instr_q;

  logic compressed_n, compressed_q;

  logic [63:0] unaligned_address_n, unaligned_address_q;

  logic jump_unaligned_half_word;

  logic kill_upper_16_bit;
  assign kill_upper_16_bit = fetch_entry_i.branch_predict.valid &
                               fetch_entry_i.branch_predict.predict_taken &
                               fetch_entry_i.bp_taken[0];

  always_comb begin : realign_instr

    unaligned_n                  = unaligned_q;
    unaligned_instr_n            = unaligned_instr_q;
    compressed_n                 = compressed_q;
    unaligned_address_n          = unaligned_address_q;

    fetch_entry_o.address        = fetch_entry_i.address;
    fetch_entry_o.instruction    = fetch_entry_i.instruction;
    fetch_entry_o.branch_predict = fetch_entry_i.branch_predict;
    fetch_entry_o.ex.valid       = fetch_entry_i.page_fault;
    fetch_entry_o.ex.tval        = (fetch_entry_i.page_fault) ? fetch_entry_i.address : '0;
    fetch_entry_o.ex.cause       = (fetch_entry_i.page_fault) ? riscv_pkg::INSTR_PAGE_FAULT : '0;

    fetch_entry_valid_o          = fetch_entry_valid_i;
    fetch_ack_o                  = fetch_ack_i;

    jump_unaligned_half_word     = 1'b0;

    if (fetch_entry_valid_i && !compressed_q) begin

      if (fetch_entry_i.address[1] == 1'b0) begin

        if (!unaligned_q) begin

          unaligned_n = 1'b0;

          if (fetch_entry_i.instruction[1:0] != 2'b11) begin

            fetch_entry_o.instruction = {15'b0, fetch_entry_i.instruction[15:0]};

            if (fetch_entry_i.branch_predict.valid && !fetch_entry_i.bp_taken[0])
              fetch_entry_o.branch_predict.valid = 1'b0;

            if (!kill_upper_16_bit) begin

              if (fetch_entry_i.instruction[17:16] != 2'b11) begin

                compressed_n = 1'b1;

                fetch_ack_o  = 1'b0;

              end else begin

                unaligned_instr_n = fetch_entry_i.instruction[31:16];

                unaligned_address_n = {fetch_entry_i.address[63:2], 2'b10};

                unaligned_n = 1'b1;

              end
            end
          end
        end else if (unaligned_q) begin

          fetch_entry_o.address = unaligned_address_q;
          fetch_entry_o.instruction = {fetch_entry_i.instruction[15:0], unaligned_instr_q};

          if (!kill_upper_16_bit) begin

            if (fetch_entry_i.instruction[17:16] != 2'b11) begin

              compressed_n = 1'b1;

              fetch_ack_o  = 1'b0;

              unaligned_n  = 1'b0;

              if (fetch_entry_i.branch_predict.valid && !fetch_entry_i.bp_taken[0])
                fetch_entry_o.branch_predict.valid = 1'b0;

            end else if (!kill_upper_16_bit) begin

              unaligned_instr_n = fetch_entry_i.instruction[31:16];

              unaligned_address_n = {fetch_entry_i.address[63:2], 2'b10};

              unaligned_n = 1'b1;
            end
          end else if (fetch_entry_i.branch_predict.valid) begin

            unaligned_n = 1'b0;
          end
        end
      end else if (fetch_entry_i.address[1] == 1'b1) begin

        unaligned_n = 1'b0;

        if (fetch_entry_i.instruction[17:16] != 2'b11) begin

          fetch_entry_o.instruction = {15'b0, fetch_entry_i.instruction[31:16]};

        end else begin

          unaligned_instr_n = fetch_entry_i.instruction[31:16];

          unaligned_n = 1'b1;

          unaligned_address_n = {fetch_entry_i.address[63:2], 2'b10};

          fetch_entry_valid_o = 1'b0;

          fetch_ack_o = 1'b1;

          jump_unaligned_half_word = 1'b1;
        end

      end
    end

    if (compressed_q) begin
      fetch_ack_o = fetch_ack_i;
      compressed_n = 1'b0;
      fetch_entry_o.instruction = {16'b0, fetch_entry_i.instruction[31:16]};
      fetch_entry_o.address = {fetch_entry_i.address[63:2], 2'b10};
      fetch_entry_valid_o = 1'b1;
    end

    if (!fetch_ack_i && !jump_unaligned_half_word) begin
      unaligned_n         = unaligned_q;
      unaligned_instr_n   = unaligned_instr_q;
      compressed_n        = compressed_q;
      unaligned_address_n = unaligned_address_q;
    end

    if (flush_i) begin

      unaligned_n  = 1'b0;
      compressed_n = 1'b0;
    end

    fetch_entry_o.ex.tval = fetch_entry_o.address;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      unaligned_q         <= 1'b0;
      unaligned_instr_q   <= 16'b0;
      unaligned_address_q <= 64'b0;
      compressed_q        <= 1'b0;
    end else begin
      unaligned_q         <= unaligned_n;
      unaligned_instr_q   <= unaligned_instr_n;
      unaligned_address_q <= unaligned_address_n;
      compressed_q        <= compressed_n;
    end
  end

endmodule


import ariane_pkg::*;
module compressed_decoder (
    input  logic [31:0] instr_i,
    output logic [31:0] instr_o,
    output logic        illegal_instr_o,
    output logic        is_compressed_o
);

  always_comb begin
    illegal_instr_o = 1'b0;
    instr_o         = '0;
    is_compressed_o = 1'b1;
    instr_o         = instr_i;

    unique case (instr_i[1:0])

      riscv_pkg::OpcodeC0: begin
        unique case (instr_i[15:13])
          riscv_pkg::OpcodeC0Addi4spn: begin

            instr_o = {
              2'b0,
              instr_i[10:7],
              instr_i[12:11],
              instr_i[5],
              instr_i[6],
              2'b00,
              5'h02,
              3'b000,
              2'b01,
              instr_i[4:2],
              riscv_pkg::OpcodeOpImm
            };
            if (instr_i[12:5] == 8'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC0Fld: begin

            instr_o = {
              4'b0,
              instr_i[6:5],
              instr_i[12:10],
              3'b000,
              2'b01,
              instr_i[9:7],
              3'b011,
              2'b01,
              instr_i[4:2],
              riscv_pkg::OpcodeLoadFp
            };
          end

          riscv_pkg::OpcodeC0Lw: begin

            instr_o = {
              5'b0,
              instr_i[5],
              instr_i[12:10],
              instr_i[6],
              2'b00,
              2'b01,
              instr_i[9:7],
              3'b010,
              2'b01,
              instr_i[4:2],
              riscv_pkg::OpcodeLoad
            };
          end

          riscv_pkg::OpcodeC0Ld: begin

            instr_o = {
              4'b0,
              instr_i[6:5],
              instr_i[12:10],
              3'b000,
              2'b01,
              instr_i[9:7],
              3'b011,
              2'b01,
              instr_i[4:2],
              riscv_pkg::OpcodeLoad
            };
          end

          riscv_pkg::OpcodeC0Fsd: begin

            instr_o = {
              4'b0,
              instr_i[6:5],
              instr_i[12],
              2'b01,
              instr_i[4:2],
              2'b01,
              instr_i[9:7],
              3'b011,
              instr_i[11:10],
              3'b000,
              riscv_pkg::OpcodeStoreFp
            };
          end

          riscv_pkg::OpcodeC0Sw: begin

            instr_o = {
              5'b0,
              instr_i[5],
              instr_i[12],
              2'b01,
              instr_i[4:2],
              2'b01,
              instr_i[9:7],
              3'b010,
              instr_i[11:10],
              instr_i[6],
              2'b00,
              riscv_pkg::OpcodeStore
            };
          end

          riscv_pkg::OpcodeC0Sd: begin

            instr_o = {
              4'b0,
              instr_i[6:5],
              instr_i[12],
              2'b01,
              instr_i[4:2],
              2'b01,
              instr_i[9:7],
              3'b011,
              instr_i[11:10],
              3'b000,
              riscv_pkg::OpcodeStore
            };
          end

          default: begin
            illegal_instr_o = 1'b1;
          end
        endcase
      end

      riscv_pkg::OpcodeC1: begin
        unique case (instr_i[15:13])
          riscv_pkg::OpcodeC1Addi: begin

            instr_o = {
              {6{instr_i[12]}},
              instr_i[12],
              instr_i[6:2],
              instr_i[11:7],
              3'b0,
              instr_i[11:7],
              riscv_pkg::OpcodeOpImm
            };
          end

          riscv_pkg::OpcodeC1Addiw: begin
            if (instr_i[11:7] != 5'h0)
              instr_o = {
                {6{instr_i[12]}},
                instr_i[12],
                instr_i[6:2],
                instr_i[11:7],
                3'b0,
                instr_i[11:7],
                riscv_pkg::OpcodeOpImm32
              };
            else illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC1Li: begin

            instr_o = {
              {6{instr_i[12]}},
              instr_i[12],
              instr_i[6:2],
              5'b0,
              3'b0,
              instr_i[11:7],
              riscv_pkg::OpcodeOpImm
            };
            if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC1LuiAddi16sp: begin

            instr_o = {{15{instr_i[12]}}, instr_i[6:2], instr_i[11:7], riscv_pkg::OpcodeLui};

            if (instr_i[11:7] == 5'h02) begin

              instr_o = {
                {3{instr_i[12]}},
                instr_i[4:3],
                instr_i[5],
                instr_i[2],
                instr_i[6],
                4'b0,
                5'h02,
                3'b000,
                5'h02,
                riscv_pkg::OpcodeOpImm
              };
            end else if (instr_i[11:7] == 5'b0) begin
              illegal_instr_o = 1'b1;
            end

            if ({instr_i[12], instr_i[6:2]} == 6'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC1MiscAlu: begin
            unique case (instr_i[11:10])
              2'b00, 2'b01: begin

                instr_o = {
                  1'b0,
                  instr_i[10],
                  4'b0,
                  instr_i[12],
                  instr_i[6:2],
                  2'b01,
                  instr_i[9:7],
                  3'b101,
                  2'b01,
                  instr_i[9:7],
                  riscv_pkg::OpcodeOpImm
                };

                if ({instr_i[12], instr_i[6:2]} == 6'b0) illegal_instr_o = 1'b1;
              end

              2'b10: begin

                instr_o = {
                  {6{instr_i[12]}},
                  instr_i[12],
                  instr_i[6:2],
                  2'b01,
                  instr_i[9:7],
                  3'b111,
                  2'b01,
                  instr_i[9:7],
                  riscv_pkg::OpcodeOpImm
                };
              end

              2'b11: begin
                unique case ({
                  instr_i[12], instr_i[6:5]
                })
                  3'b000: begin

                    instr_o = {
                      2'b01,
                      5'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b000,
                      2'b01,
                      instr_i[9:7],
                      riscv_pkg::OpcodeOp
                    };
                  end

                  3'b001: begin

                    instr_o = {
                      7'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b100,
                      2'b01,
                      instr_i[9:7],
                      riscv_pkg::OpcodeOp
                    };
                  end

                  3'b010: begin

                    instr_o = {
                      7'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b110,
                      2'b01,
                      instr_i[9:7],
                      riscv_pkg::OpcodeOp
                    };
                  end

                  3'b011: begin

                    instr_o = {
                      7'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b111,
                      2'b01,
                      instr_i[9:7],
                      riscv_pkg::OpcodeOp
                    };
                  end

                  3'b100: begin

                    instr_o = {
                      2'b01,
                      5'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b000,
                      2'b01,
                      instr_i[9:7],
                      riscv_pkg::OpcodeOp32
                    };
                  end
                  3'b101: begin

                    instr_o = {
                      2'b00,
                      5'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b000,
                      2'b01,
                      instr_i[9:7],
                      riscv_pkg::OpcodeOp32
                    };
                  end

                  3'b110, 3'b111: begin

                    illegal_instr_o = 1'b1;
                    instr_o = {16'b0, instr_i};
                  end
                endcase
              end
            endcase
          end

          riscv_pkg::OpcodeC1J: begin

            instr_o = {
              instr_i[12],
              instr_i[8],
              instr_i[10:9],
              instr_i[6],
              instr_i[7],
              instr_i[2],
              instr_i[11],
              instr_i[5:3],
              {9{instr_i[12]}},
              4'b0,
              ~instr_i[15],
              riscv_pkg::OpcodeJal
            };
          end

          riscv_pkg::OpcodeC1Beqz, riscv_pkg::OpcodeC1Bnez: begin

            instr_o = {
              {4{instr_i[12]}},
              instr_i[6:5],
              instr_i[2],
              5'b0,
              2'b01,
              instr_i[9:7],
              2'b00,
              instr_i[13],
              instr_i[11:10],
              instr_i[4:3],
              instr_i[12],
              riscv_pkg::OpcodeBranch
            };
          end
        endcase
      end

      riscv_pkg::OpcodeC2: begin
        unique case (instr_i[15:13])
          riscv_pkg::OpcodeC2Slli: begin

            instr_o = {
              6'b0,
              instr_i[12],
              instr_i[6:2],
              instr_i[11:7],
              3'b001,
              instr_i[11:7],
              riscv_pkg::OpcodeOpImm
            };
            if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
            if ({instr_i[12], instr_i[6:2]} == 6'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC2Fldsp: begin

            instr_o = {
              3'b0,
              instr_i[4:2],
              instr_i[12],
              instr_i[6:5],
              3'b000,
              5'h02,
              3'b011,
              instr_i[11:7],
              riscv_pkg::OpcodeLoadFp
            };
            if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC2Lwsp: begin

            instr_o = {
              4'b0,
              instr_i[3:2],
              instr_i[12],
              instr_i[6:4],
              2'b00,
              5'h02,
              3'b010,
              instr_i[11:7],
              riscv_pkg::OpcodeLoad
            };
            if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC2Ldsp: begin

            instr_o = {
              3'b0,
              instr_i[4:2],
              instr_i[12],
              instr_i[6:5],
              3'b000,
              5'h02,
              3'b011,
              instr_i[11:7],
              riscv_pkg::OpcodeLoad
            };
            if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
          end

          riscv_pkg::OpcodeC2JalrMvAdd: begin
            if (instr_i[12] == 1'b0) begin

              instr_o = {7'b0, instr_i[6:2], 5'b0, 3'b0, instr_i[11:7], riscv_pkg::OpcodeOp};

              if (instr_i[6:2] == 5'b0) begin

                instr_o = {12'b0, instr_i[11:7], 3'b0, 5'b0, riscv_pkg::OpcodeJalr};

                illegal_instr_o = (instr_i[11:7] != '0) ? 1'b0 : 1'b1;
              end
            end else begin

              instr_o = {
                7'b0, instr_i[6:2], instr_i[11:7], 3'b0, instr_i[11:7], riscv_pkg::OpcodeOp
              };

              if (instr_i[11:7] == 5'b0) begin

                instr_o = {32'h00_10_00_73};
                if (instr_i[6:2] != 5'b0) illegal_instr_o = 1'b1;
              end else if (instr_i[6:2] == 5'b0) begin

                instr_o = {12'b0, instr_i[11:7], 3'b000, 5'b00001, riscv_pkg::OpcodeJalr};
              end
            end
          end

          riscv_pkg::OpcodeC2Fsdsp: begin

            instr_o = {
              3'b0,
              instr_i[9:7],
              instr_i[12],
              instr_i[6:2],
              5'h02,
              3'b011,
              instr_i[11:10],
              3'b000,
              riscv_pkg::OpcodeStoreFp
            };
          end

          riscv_pkg::OpcodeC2Swsp: begin

            instr_o = {
              4'b0,
              instr_i[8:7],
              instr_i[12],
              instr_i[6:2],
              5'h02,
              3'b010,
              instr_i[11:9],
              2'b00,
              riscv_pkg::OpcodeStore
            };
          end

          riscv_pkg::OpcodeC2Sdsp: begin

            instr_o = {
              3'b0,
              instr_i[9:7],
              instr_i[12],
              instr_i[6:2],
              5'h02,
              3'b011,
              instr_i[11:10],
              3'b000,
              riscv_pkg::OpcodeStore
            };
          end

          default: begin
            illegal_instr_o = 1'b1;
          end
        endcase
      end

      default: is_compressed_o = 1'b0;
    endcase

    if (illegal_instr_o && is_compressed_o) begin
      instr_o = instr_i;
    end
  end
endmodule


import ariane_pkg::*;
module decoder (
    input logic               [63:0] pc_i,
    input logic                      is_compressed_i,
    input logic               [15:0] compressed_instr_i,
    input logic                      is_illegal_i,
    input logic               [31:0] instruction_i,
    input branchpredict_sbe_t        branch_predict_i,
    input exception_t                ex_i,

    input  riscv_pkg::priv_lvl_t       priv_lvl_i,
    input  logic                       debug_mode_i,
    input  riscv_pkg::xs_t             fs_i,
    input  logic                 [2:0] frm_i,
    input  logic                       tvm_i,
    input  logic                       tw_i,
    input  logic                       tsr_i,
    output scoreboard_entry_t          instruction_o,
    output logic                       is_control_flow_instr_o
);
  logic illegal_instr;

  logic ecall;

  logic ebreak;

  logic check_fprm;
  riscv_pkg::instruction_t instr;
  assign instr = riscv_pkg::instruction_t'(instruction_i);

  enum logic [3:0] {
    NOIMM,
    IIMM,
    SIMM,
    SBIMM,
    UIMM,
    JIMM,
    RS3
  } imm_select;

  logic [63:0] imm_i_type;
  logic [63:0] imm_s_type;
  logic [63:0] imm_sb_type;
  logic [63:0] imm_u_type;
  logic [63:0] imm_uj_type;
  logic [63:0] imm_bi_type;

  always_comb begin : decoder

    imm_select                  = NOIMM;
    is_control_flow_instr_o     = 1'b0;
    illegal_instr               = 1'b0;
    instruction_o.pc            = pc_i;
    instruction_o.trans_id      = 5'b0;
    instruction_o.fu            = NONE;
    instruction_o.op            = ADD;
    instruction_o.rs1           = '0;
    instruction_o.rs2           = '0;
    instruction_o.rd            = '0;
    instruction_o.use_pc        = 1'b0;
    instruction_o.trans_id      = '0;
    instruction_o.is_compressed = is_compressed_i;
    instruction_o.use_zimm      = 1'b0;
    instruction_o.bp            = branch_predict_i;
    ecall                       = 1'b0;
    ebreak                      = 1'b0;
    check_fprm                  = 1'b0;

    if (~ex_i.valid) begin
      case (instr.rtype.opcode)
        riscv_pkg::OpcodeSystem: begin
          instruction_o.fu       = CSR;
          instruction_o.rs1[4:0] = instr.itype.rs1;
          instruction_o.rd[4:0]  = instr.itype.rd;

          unique case (instr.itype.funct3)
            3'b000: begin

              if (instr.itype.rs1 != '0 || instr.itype.rd != '0) illegal_instr = 1'b1;

              case (instr.itype.imm)

                12'b0: ecall = 1'b1;

                12'b1: ebreak = 1'b1;

                12'b1_0000_0010: begin
                  instruction_o.op = SRET;

                  if (priv_lvl_i == riscv_pkg::PRIV_LVL_U) begin
                    illegal_instr = 1'b1;

                    instruction_o.op = ADD;
                  end

                  if (priv_lvl_i == riscv_pkg::PRIV_LVL_S && tsr_i) begin
                    illegal_instr = 1'b1;

                    instruction_o.op = ADD;
                  end
                end

                12'b11_0000_0010: begin
                  instruction_o.op = MRET;

                  if (priv_lvl_i inside {riscv_pkg::PRIV_LVL_U, riscv_pkg::PRIV_LVL_S})
                    illegal_instr = 1'b1;
                end

                12'b111_1011_0010: begin
                  instruction_o.op = DRET;

                  illegal_instr = (!debug_mode_i) ? 1'b1 : 1'b0;
                end

                12'b1_0000_0101: begin
                  if (ENABLE_WFI) instruction_o.op = WFI;

                  if (priv_lvl_i == riscv_pkg::PRIV_LVL_S && tw_i) begin
                    illegal_instr = 1'b1;
                    instruction_o.op = ADD;
                  end

                  if (priv_lvl_i == riscv_pkg::PRIV_LVL_U) begin
                    illegal_instr = 1'b1;
                    instruction_o.op = ADD;
                  end
                end

                default: begin
                  if (instr.instr[31:25] == 7'b1001) begin

                    illegal_instr    = (priv_lvl_i inside {riscv_pkg::PRIV_LVL_M, riscv_pkg::PRIV_LVL_S}) ? 1'b0 : 1'b1;
                    instruction_o.op = SFENCE_VMA;

                    if (priv_lvl_i == riscv_pkg::PRIV_LVL_S && tvm_i) illegal_instr = 1'b1;
                  end
                end
              endcase
            end

            3'b001: begin
              imm_select = IIMM;
              instruction_o.op = CSR_WRITE;
            end

            3'b010: begin
              imm_select = IIMM;

              if (instr.itype.rs1 == 5'b0) instruction_o.op = CSR_READ;
              else instruction_o.op = CSR_SET;
            end

            3'b011: begin
              imm_select = IIMM;

              if (instr.itype.rs1 == 5'b0) instruction_o.op = CSR_READ;
              else instruction_o.op = CSR_CLEAR;
            end

            3'b101: begin
              instruction_o.rs1[4:0] = instr.itype.rs1;
              imm_select = IIMM;
              instruction_o.use_zimm = 1'b1;
              instruction_o.op = CSR_WRITE;
            end
            3'b110: begin
              instruction_o.rs1[4:0] = instr.itype.rs1;
              imm_select = IIMM;
              instruction_o.use_zimm = 1'b1;

              if (instr.itype.rs1 == 5'b0) instruction_o.op = CSR_READ;
              else instruction_o.op = CSR_SET;
            end
            3'b111: begin
              instruction_o.rs1[4:0] = instr.itype.rs1;
              imm_select = IIMM;
              instruction_o.use_zimm = 1'b1;

              if (instr.itype.rs1 == 5'b0) instruction_o.op = CSR_READ;
              else instruction_o.op = CSR_CLEAR;
            end
            default: illegal_instr = 1'b1;
          endcase
        end

        riscv_pkg::OpcodeMiscMem: begin
          instruction_o.fu  = CSR;
          instruction_o.rs1 = '0;
          instruction_o.rs2 = '0;
          instruction_o.rd  = '0;

          case (instr.stype.funct3)

            3'b000: instruction_o.op = FENCE;

            3'b001: begin
              if (instr.instr[31:20] != '0) illegal_instr = 1'b1;
              instruction_o.op = FENCE_I;
            end
            default: illegal_instr = 1'b1;
          endcase

          if (instr.stype.rs1 != '0 || instr.stype.imm0 != '0 || instr.instr[31:28] != '0)
            illegal_instr = 1'b1;
        end

        riscv_pkg::OpcodeOp: begin

          if (instr.rvftype.funct2 == 2'b10) begin

            if (FP_PRESENT && XFVEC && fs_i != riscv_pkg::Off) begin
              automatic logic allow_replication;

              instruction_o.fu       = FPU_VEC;
              instruction_o.rs1[4:0] = instr.rvftype.rs1;
              instruction_o.rs2[4:0] = instr.rvftype.rs2;
              instruction_o.rd[4:0]  = instr.rvftype.rd;
              check_fprm             = 1'b1;
              allow_replication      = 1'b1;

              unique case (instr.rvftype.vecfltop)
                5'b00001: begin
                  instruction_o.op  = FADD;
                  instruction_o.rs1 = '0;
                  instruction_o.rs2 = instr.rvftype.rs1;
                  imm_select        = IIMM;
                end
                5'b00010: begin
                  instruction_o.op  = FSUB;
                  instruction_o.rs1 = '0;
                  instruction_o.rs2 = instr.rvftype.rs1;
                  imm_select        = IIMM;
                end
                5'b00011: instruction_o.op = FMUL;
                5'b00100: instruction_o.op = FDIV;
                5'b00101: begin
                  instruction_o.op = VFMIN;
                  check_fprm       = 1'b0;
                end
                5'b00110: begin
                  instruction_o.op = VFMAX;
                  check_fprm       = 1'b0;
                end
                5'b00111: begin
                  instruction_o.op  = FSQRT;
                  allow_replication = 1'b0;
                  if (instr.rvftype.rs2 != 5'b00000) illegal_instr = 1'b1;
                end
                5'b01000: begin
                  instruction_o.op = FMADD;
                  imm_select       = SIMM;
                end
                5'b01001: begin
                  instruction_o.op = FMSUB;
                  imm_select       = SIMM;
                end
                5'b01100: begin
                  unique case (instr.rvftype.rs2) inside
                    5'b00000: begin
                      instruction_o.rs2 = instr.rvftype.rs1;
                      if (instr.rvftype.repl) instruction_o.op = FMV_F2X;
                      else instruction_o.op = FMV_X2F;
                      check_fprm = 1'b0;
                    end
                    5'b00001: begin
                      instruction_o.op  = FCLASS;
                      check_fprm        = 1'b0;
                      allow_replication = 1'b0;
                    end
                    5'b00010: instruction_o.op = FCVT_F2I;
                    5'b00011: instruction_o.op = FCVT_I2F;
                    5'b001??: begin
                      instruction_o.op  = FCVT_F2F;
                      instruction_o.rs2 = instr.rvftype.rd;
                      imm_select        = IIMM;

                      unique case (instr.rvftype.rs2[21:20])

                        2'b00:   if (~RVFVEC) illegal_instr = 1'b1;
                        2'b01:   if (~XF16ALTVEC) illegal_instr = 1'b1;
                        2'b10:   if (~XF16VEC) illegal_instr = 1'b1;
                        2'b11:   if (~XF8VEC) illegal_instr = 1'b1;
                        default: illegal_instr = 1'b1;
                      endcase
                    end
                    default:  illegal_instr = 1'b1;
                  endcase
                end
                5'b01101: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFSGNJ;
                end
                5'b01110: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFSGNJN;
                end
                5'b01111: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFSGNJX;
                end
                5'b10000: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFEQ;
                end
                5'b10001: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFNE;
                end
                5'b10010: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFLT;
                end
                5'b10011: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFGE;
                end
                5'b10100: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFLE;
                end
                5'b10101: begin
                  check_fprm = 1'b0;
                  instruction_o.op = VFGT;
                end
                5'b11000: begin
                  instruction_o.op = VFCPKAB_S;
                  imm_select       = SIMM;
                  if (~RVF) illegal_instr = 1'b1;

                  unique case (instr.rvftype.vfmt)

                    2'b00: begin
                      if (~RVFVEC) illegal_instr = 1'b1;
                      if (instr.rvftype.repl) illegal_instr = 1'b1;
                    end
                    2'b01: begin
                      if (~XF16ALTVEC) illegal_instr = 1'b1;
                    end
                    2'b10: begin
                      if (~XF16VEC) illegal_instr = 1'b1;
                    end
                    2'b11: begin
                      if (~XF8VEC) illegal_instr = 1'b1;
                    end
                    default: illegal_instr = 1'b1;
                  endcase
                end
                5'b11001: begin
                  instruction_o.op = VFCPKCD_S;
                  imm_select       = SIMM;
                  if (~RVF) illegal_instr = 1'b1;

                  unique case (instr.rvftype.vfmt)

                    2'b00:   illegal_instr = 1'b1;
                    2'b01:   illegal_instr = 1'b1;
                    2'b10:   illegal_instr = 1'b1;
                    2'b11: begin
                      if (~XF8VEC) illegal_instr = 1'b1;
                    end
                    default: illegal_instr = 1'b1;
                  endcase
                end
                5'b11010: begin
                  instruction_o.op = VFCPKAB_D;
                  imm_select       = SIMM;
                  if (~RVD) illegal_instr = 1'b1;

                  unique case (instr.rvftype.vfmt)

                    2'b00: begin
                      if (~RVFVEC) illegal_instr = 1'b1;
                      if (instr.rvftype.repl) illegal_instr = 1'b1;
                    end
                    2'b01: begin
                      if (~XF16ALTVEC) illegal_instr = 1'b1;
                    end
                    2'b10: begin
                      if (~XF16VEC) illegal_instr = 1'b1;
                    end
                    2'b11: begin
                      if (~XF8VEC) illegal_instr = 1'b1;
                    end
                    default: illegal_instr = 1'b1;
                  endcase
                end
                5'b11011: begin
                  instruction_o.op = VFCPKCD_D;
                  imm_select       = SIMM;
                  if (~RVD) illegal_instr = 1'b1;

                  unique case (instr.rvftype.vfmt)

                    2'b00:   illegal_instr = 1'b1;
                    2'b01:   illegal_instr = 1'b1;
                    2'b10:   illegal_instr = 1'b1;
                    2'b11: begin
                      if (~XF8VEC) illegal_instr = 1'b1;
                    end
                    default: illegal_instr = 1'b1;
                  endcase
                end
                default:  illegal_instr = 1'b1;
              endcase

              unique case (instr.rvftype.vfmt)

                2'b00:   if (~RVFVEC) illegal_instr = 1'b1;
                2'b01:   if (~XF16ALTVEC) illegal_instr = 1'b1;
                2'b10:   if (~XF16VEC) illegal_instr = 1'b1;
                2'b11:   if (~XF8VEC) illegal_instr = 1'b1;
                default: illegal_instr = 1'b1;
              endcase

              if (~allow_replication & instr.rvftype.repl) illegal_instr = 1'b1;

              if (check_fprm) begin
                unique case (frm_i) inside
                  [3'b000 : 3'b100]: ;
                  default: illegal_instr = 1'b1;
                endcase
              end

            end else begin
              illegal_instr = 1'b1;
            end

          end else begin
            instruction_o.fu  = (instr.rtype.funct7 == 7'b000_0001) ? MULT : ALU;
            instruction_o.rs1 = instr.rtype.rs1;
            instruction_o.rs2 = instr.rtype.rs2;
            instruction_o.rd  = instr.rtype.rd;

            unique case ({
              instr.rtype.funct7, instr.rtype.funct3
            })
              {7'b000_0000, 3'b000} : instruction_o.op = ADD;
              {7'b010_0000, 3'b000} : instruction_o.op = SUB;
              {7'b000_0000, 3'b010} : instruction_o.op = SLTS;
              {7'b000_0000, 3'b011} : instruction_o.op = SLTU;
              {7'b000_0000, 3'b100} : instruction_o.op = XORL;
              {7'b000_0000, 3'b110} : instruction_o.op = ORL;
              {7'b000_0000, 3'b111} : instruction_o.op = ANDL;
              {7'b000_0000, 3'b001} : instruction_o.op = SLL;
              {7'b000_0000, 3'b101} : instruction_o.op = SRL;
              {7'b010_0000, 3'b101} : instruction_o.op = SRA;

              {7'b000_0001, 3'b000} : instruction_o.op = MUL;
              {7'b000_0001, 3'b001} : instruction_o.op = MULH;
              {7'b000_0001, 3'b010} : instruction_o.op = MULHSU;
              {7'b000_0001, 3'b011} : instruction_o.op = MULHU;
              {7'b000_0001, 3'b100} : instruction_o.op = DIV;
              {7'b000_0001, 3'b101} : instruction_o.op = DIVU;
              {7'b000_0001, 3'b110} : instruction_o.op = REM;
              {7'b000_0001, 3'b111} : instruction_o.op = REMU;
              default: begin
                illegal_instr = 1'b1;
              end
            endcase
          end
        end

        riscv_pkg::OpcodeOp32: begin
          instruction_o.fu = (instr.rtype.funct7 == 7'b000_0001) ? MULT : ALU;
          instruction_o.rs1[4:0] = instr.rtype.rs1;
          instruction_o.rs2[4:0] = instr.rtype.rs2;
          instruction_o.rd[4:0] = instr.rtype.rd;

          unique case ({
            instr.rtype.funct7, instr.rtype.funct3
          })
            {7'b000_0000, 3'b000} : instruction_o.op = ADDW;
            {7'b010_0000, 3'b000} : instruction_o.op = SUBW;
            {7'b000_0000, 3'b001} : instruction_o.op = SLLW;
            {7'b000_0000, 3'b101} : instruction_o.op = SRLW;
            {7'b010_0000, 3'b101} : instruction_o.op = SRAW;

            {7'b000_0001, 3'b000} : instruction_o.op = MULW;
            {7'b000_0001, 3'b100} : instruction_o.op = DIVW;
            {7'b000_0001, 3'b101} : instruction_o.op = DIVUW;
            {7'b000_0001, 3'b110} : instruction_o.op = REMW;
            {7'b000_0001, 3'b111} : instruction_o.op = REMUW;
            default: illegal_instr = 1'b1;
          endcase
        end

        riscv_pkg::OpcodeOpImm: begin
          instruction_o.fu = ALU;
          imm_select = IIMM;
          instruction_o.rs1[4:0] = instr.itype.rs1;
          instruction_o.rd[4:0] = instr.itype.rd;

          unique case (instr.itype.funct3)
            3'b000: instruction_o.op = ADD;
            3'b010: instruction_o.op = SLTS;
            3'b011: instruction_o.op = SLTU;
            3'b100: instruction_o.op = XORL;
            3'b110: instruction_o.op = ORL;
            3'b111: instruction_o.op = ANDL;

            3'b001: begin
              instruction_o.op = SLL;
              if (instr.instr[31:26] != 6'b0) illegal_instr = 1'b1;
            end

            3'b101: begin
              if (instr.instr[31:26] == 6'b0) instruction_o.op = SRL;
              else if (instr.instr[31:26] == 6'b010_000) instruction_o.op = SRA;
              else illegal_instr = 1'b1;
            end
          endcase
        end

        riscv_pkg::OpcodeOpImm32: begin
          instruction_o.fu = ALU;
          imm_select = IIMM;
          instruction_o.rs1[4:0] = instr.itype.rs1;
          instruction_o.rd[4:0] = instr.itype.rd;

          unique case (instr.itype.funct3)
            3'b000: instruction_o.op = ADDW;

            3'b001: begin
              instruction_o.op = SLLW;
              if (instr.instr[31:25] != 7'b0) illegal_instr = 1'b1;
            end

            3'b101: begin
              if (instr.instr[31:25] == 7'b0) instruction_o.op = SRLW;
              else if (instr.instr[31:25] == 7'b010_0000) instruction_o.op = SRAW;
              else illegal_instr = 1'b1;
            end

            default: illegal_instr = 1'b1;
          endcase
        end

        riscv_pkg::OpcodeStore: begin
          instruction_o.fu = STORE;
          imm_select = SIMM;
          instruction_o.rs1[4:0] = instr.stype.rs1;
          instruction_o.rs2[4:0] = instr.stype.rs2;

          unique case (instr.stype.funct3)
            3'b000:  instruction_o.op = SB;
            3'b001:  instruction_o.op = SH;
            3'b010:  instruction_o.op = SW;
            3'b011:  instruction_o.op = SD;
            default: illegal_instr = 1'b1;
          endcase
        end

        riscv_pkg::OpcodeLoad: begin
          instruction_o.fu = LOAD;
          imm_select = IIMM;
          instruction_o.rs1[4:0] = instr.itype.rs1;
          instruction_o.rd[4:0] = instr.itype.rd;

          unique case (instr.itype.funct3)
            3'b000:  instruction_o.op = LB;
            3'b001:  instruction_o.op = LH;
            3'b010:  instruction_o.op = LW;
            3'b100:  instruction_o.op = LBU;
            3'b101:  instruction_o.op = LHU;
            3'b110:  instruction_o.op = LWU;
            3'b011:  instruction_o.op = LD;
            default: illegal_instr = 1'b1;
          endcase
        end

        riscv_pkg::OpcodeStoreFp: begin
          if (FP_PRESENT && fs_i != riscv_pkg::Off) begin
            instruction_o.fu  = STORE;
            imm_select        = SIMM;
            instruction_o.rs1 = instr.stype.rs1;
            instruction_o.rs2 = instr.stype.rs2;

            unique case (instr.stype.funct3)

              3'b000:  if (XF8) instruction_o.op = FSB;
 else illegal_instr = 1'b1;
              3'b001:  if (XF16 | XF16ALT) instruction_o.op = FSH;
 else illegal_instr = 1'b1;
              3'b010:  if (RVF) instruction_o.op = FSW;
 else illegal_instr = 1'b1;
              3'b011:  if (RVD) instruction_o.op = FSD;
 else illegal_instr = 1'b1;
              default: illegal_instr = 1'b1;
            endcase
          end else illegal_instr = 1'b1;
        end

        riscv_pkg::OpcodeLoadFp: begin
          if (FP_PRESENT && fs_i != riscv_pkg::Off) begin
            instruction_o.fu  = LOAD;
            imm_select        = IIMM;
            instruction_o.rs1 = instr.itype.rs1;
            instruction_o.rd  = instr.itype.rd;

            unique case (instr.itype.funct3)

              3'b000:  if (XF8) instruction_o.op = FLB;
 else illegal_instr = 1'b1;
              3'b001:  if (XF16 | XF16ALT) instruction_o.op = FLH;
 else illegal_instr = 1'b1;
              3'b010:  if (RVF) instruction_o.op = FLW;
 else illegal_instr = 1'b1;
              3'b011:  if (RVD) instruction_o.op = FLD;
 else illegal_instr = 1'b1;
              default: illegal_instr = 1'b1;
            endcase
          end else illegal_instr = 1'b1;
        end

        riscv_pkg::OpcodeMadd,
                riscv_pkg::OpcodeMsub,
                riscv_pkg::OpcodeNmsub,
                riscv_pkg::OpcodeNmadd: begin
          if (FP_PRESENT && fs_i != riscv_pkg::Off) begin
            instruction_o.fu  = FPU;
            instruction_o.rs1 = instr.r4type.rs1;
            instruction_o.rs2 = instr.r4type.rs2;
            instruction_o.rd  = instr.r4type.rd;
            imm_select        = RS3;
            check_fprm        = 1'b1;

            unique case (instr.r4type.opcode)
              default:                instruction_o.op = FMADD;
              riscv_pkg::OpcodeMsub:  instruction_o.op = FMSUB;
              riscv_pkg::OpcodeNmsub: instruction_o.op = FNMSUB;
              riscv_pkg::OpcodeNmadd: instruction_o.op = FNMADD;
            endcase

            unique case (instr.r4type.funct2)

              2'b00:   if (~RVF) illegal_instr = 1'b1;
              2'b01:   if (~RVD) illegal_instr = 1'b1;
              2'b10:   if (~XF16 & ~XF16ALT) illegal_instr = 1'b1;
              2'b11:   if (~XF8) illegal_instr = 1'b1;
              default: illegal_instr = 1'b1;
            endcase

            if (check_fprm) begin
              unique case (instr.rftype.rm) inside
                [3'b000 : 3'b100]: ;
                3'b101: begin
                  if (~XF16ALT || instr.rftype.fmt != 2'b10) illegal_instr = 1'b1;
                  unique case (frm_i) inside
                    [3'b000 : 3'b100]: ;
                    default: illegal_instr = 1'b1;
                  endcase
                end
                3'b111: begin

                  unique case (frm_i) inside
                    [3'b000 : 3'b100]: ;
                    default: illegal_instr = 1'b1;
                  endcase
                end
                default: illegal_instr = 1'b1;
              endcase
            end
          end else begin
            illegal_instr = 1'b1;
          end
        end

        riscv_pkg::OpcodeOpFp: begin
          if (FP_PRESENT && fs_i != riscv_pkg::Off) begin
            instruction_o.fu  = FPU;
            instruction_o.rs1 = instr.rftype.rs1;
            instruction_o.rs2 = instr.rftype.rs2;
            instruction_o.rd  = instr.rftype.rd;
            check_fprm        = 1'b1;

            unique case (instr.rftype.funct5)
              5'b00000: begin
                instruction_o.op  = FADD;
                instruction_o.rs1 = '0;
                instruction_o.rs2 = instr.rftype.rs1;
                imm_select        = IIMM;
              end
              5'b00001: begin
                instruction_o.op  = FSUB;
                instruction_o.rs1 = '0;
                instruction_o.rs2 = instr.rftype.rs1;
                imm_select        = IIMM;
              end
              5'b00010: instruction_o.op = FMUL;
              5'b00011: instruction_o.op = FDIV;
              5'b01011: begin
                instruction_o.op = FSQRT;

                if (instr.rftype.rs2 != 5'b00000) illegal_instr = 1'b1;
              end
              5'b00100: begin
                instruction_o.op = FSGNJ;
                check_fprm       = 1'b0;
                if (XF16ALT) begin
                  if (!(instr.rftype.rm inside {[3'b000 : 3'b010], [3'b100 : 3'b110]}))
                    illegal_instr = 1'b1;
                end else begin
                  if (!(instr.rftype.rm inside {[3'b000 : 3'b010]})) illegal_instr = 1'b1;
                end
              end
              5'b00101: begin
                instruction_o.op = FMIN_MAX;
                check_fprm       = 1'b0;
                if (XF16ALT) begin
                  if (!(instr.rftype.rm inside {[3'b000 : 3'b001], [3'b100 : 3'b101]}))
                    illegal_instr = 1'b1;
                end else begin
                  if (!(instr.rftype.rm inside {[3'b000 : 3'b001]})) illegal_instr = 1'b1;
                end
              end
              5'b01000: begin
                instruction_o.op  = FCVT_F2F;
                instruction_o.rs2 = instr.rvftype.rs1;
                imm_select        = IIMM;
                if (instr.rftype.rs2[24:23]) illegal_instr = 1'b1;

                unique case (instr.rftype.rs2[22:20])

                  3'b000:  if (~RVF) illegal_instr = 1'b1;
                  3'b001:  if (~RVD) illegal_instr = 1'b1;
                  3'b010:  if (~XF16) illegal_instr = 1'b1;
                  3'b110:  if (~XF16ALT) illegal_instr = 1'b1;
                  3'b011:  if (~XF8) illegal_instr = 1'b1;
                  default: illegal_instr = 1'b1;
                endcase
              end
              5'b10100: begin
                instruction_o.op = FCMP;
                check_fprm       = 1'b0;
                if (XF16ALT) begin
                  if (!(instr.rftype.rm inside {[3'b000 : 3'b010], [3'b100 : 3'b110]}))
                    illegal_instr = 1'b1;
                end else begin
                  if (!(instr.rftype.rm inside {[3'b000 : 3'b010]})) illegal_instr = 1'b1;
                end
              end
              5'b11000: begin
                instruction_o.op = FCVT_F2I;
                imm_select       = IIMM;
                if (instr.rftype.rs2[24:22]) illegal_instr = 1'b1;
              end
              5'b11010: begin
                instruction_o.op = FCVT_I2F;
                imm_select       = IIMM;
                if (instr.rftype.rs2[24:22]) illegal_instr = 1'b1;
              end
              5'b11100: begin
                instruction_o.rs2 = instr.rftype.rs1;
                check_fprm        = 1'b0;
                if (instr.rftype.rm == 3'b000 || (XF16ALT && instr.rftype.rm == 3'b100))
                  instruction_o.op = FMV_F2X;
                else if (instr.rftype.rm == 3'b001 || (XF16ALT && instr.rftype.rm == 3'b101))
                  instruction_o.op = FCLASS;
                else illegal_instr = 1'b1;

                if (instr.rftype.rs2 != 5'b00000) illegal_instr = 1'b1;
              end
              5'b11110: begin
                instruction_o.op  = FMV_X2F;
                instruction_o.rs2 = instr.rftype.rs1;
                check_fprm        = 1'b0;
                if (!(instr.rftype.rm == 3'b000 || (XF16ALT && instr.rftype.rm == 3'b100)))
                  illegal_instr = 1'b1;

                if (instr.rftype.rs2 != 5'b00000) illegal_instr = 1'b1;
              end
              default:  illegal_instr = 1'b1;
            endcase

            unique case (instr.rftype.fmt)

              2'b00:   if (~RVF) illegal_instr = 1'b1;
              2'b01:   if (~RVD) illegal_instr = 1'b1;
              2'b10:   if (~XF16 & ~XF16ALT) illegal_instr = 1'b1;
              2'b11:   if (~XF8) illegal_instr = 1'b1;
              default: illegal_instr = 1'b1;
            endcase

            if (check_fprm) begin
              unique case (instr.rftype.rm) inside
                [3'b000 : 3'b100]: ;
                3'b101: begin
                  if (~XF16ALT || instr.rftype.fmt != 2'b10) illegal_instr = 1'b1;
                  unique case (frm_i) inside
                    [3'b000 : 3'b100]: ;
                    default: illegal_instr = 1'b1;
                  endcase
                end
                3'b111: begin

                  unique case (frm_i) inside
                    [3'b000 : 3'b100]: ;
                    default: illegal_instr = 1'b1;
                  endcase
                end
                default: illegal_instr = 1'b1;
              endcase
            end
          end else begin
            illegal_instr = 1'b1;
          end
        end

        riscv_pkg::OpcodeAmo: begin

          instruction_o.fu = STORE;
          instruction_o.rs1[4:0] = instr.atype.rs1;
          instruction_o.rs2[4:0] = instr.atype.rs2;
          instruction_o.rd[4:0] = instr.atype.rd;

          if (RVA && instr.stype.funct3 == 3'h2) begin
            unique case (instr.instr[31:27])
              5'h0: instruction_o.op = AMO_ADDW;
              5'h1: instruction_o.op = AMO_SWAPW;
              5'h2: begin
                instruction_o.op = AMO_LRW;
                if (instr.atype.rs2 != 0) illegal_instr = 1'b1;
              end
              5'h3: instruction_o.op = AMO_SCW;
              5'h4: instruction_o.op = AMO_XORW;
              5'h8: instruction_o.op = AMO_ORW;
              5'hC: instruction_o.op = AMO_ANDW;
              5'h10: instruction_o.op = AMO_MINW;
              5'h14: instruction_o.op = AMO_MAXW;
              5'h18: instruction_o.op = AMO_MINWU;
              5'h1C: instruction_o.op = AMO_MAXWU;
              default: illegal_instr = 1'b1;
            endcase

          end else if (RVA && instr.stype.funct3 == 3'h3) begin
            unique case (instr.instr[31:27])
              5'h0: instruction_o.op = AMO_ADDD;
              5'h1: instruction_o.op = AMO_SWAPD;
              5'h2: begin
                instruction_o.op = AMO_LRD;
                if (instr.atype.rs2 != 0) illegal_instr = 1'b1;
              end
              5'h3: instruction_o.op = AMO_SCD;
              5'h4: instruction_o.op = AMO_XORD;
              5'h8: instruction_o.op = AMO_ORD;
              5'hC: instruction_o.op = AMO_ANDD;
              5'h10: instruction_o.op = AMO_MIND;
              5'h14: instruction_o.op = AMO_MAXD;
              5'h18: instruction_o.op = AMO_MINDU;
              5'h1C: instruction_o.op = AMO_MAXDU;
              default: illegal_instr = 1'b1;
            endcase
          end else begin
            illegal_instr = 1'b1;
          end
        end

        riscv_pkg::OpcodeBranch: begin
          imm_select              = SBIMM;
          instruction_o.fu        = CTRL_FLOW;
          instruction_o.rs1[4:0]  = instr.stype.rs1;
          instruction_o.rs2[4:0]  = instr.stype.rs2;

          is_control_flow_instr_o = 1'b1;

          case (instr.stype.funct3)
            3'b000: instruction_o.op = EQ;
            3'b001: instruction_o.op = NE;
            3'b100: instruction_o.op = LTS;
            3'b101: instruction_o.op = GES;
            3'b110: instruction_o.op = LTU;
            3'b111: instruction_o.op = GEU;
            default: begin
              is_control_flow_instr_o = 1'b0;
              illegal_instr           = 1'b1;
            end
          endcase
        end

        riscv_pkg::OpcodeJalr: begin
          instruction_o.fu        = CTRL_FLOW;
          instruction_o.op        = JALR;
          instruction_o.rs1[4:0]  = instr.itype.rs1;
          imm_select              = IIMM;
          instruction_o.rd[4:0]   = instr.itype.rd;
          is_control_flow_instr_o = 1'b1;

          if (instr.itype.funct3 != 3'b0) illegal_instr = 1'b1;
        end

        riscv_pkg::OpcodeJal: begin
          instruction_o.fu        = CTRL_FLOW;
          imm_select              = JIMM;
          instruction_o.rd[4:0]   = instr.utype.rd;
          is_control_flow_instr_o = 1'b1;
        end

        riscv_pkg::OpcodeAuipc: begin
          instruction_o.fu      = ALU;
          imm_select            = UIMM;
          instruction_o.use_pc  = 1'b1;
          instruction_o.rd[4:0] = instr.utype.rd;
        end

        riscv_pkg::OpcodeLui: begin
          imm_select            = UIMM;
          instruction_o.fu      = ALU;
          instruction_o.rd[4:0] = instr.utype.rd;
        end

        default: illegal_instr = 1'b1;
      endcase
    end
  end

  always_comb begin : sign_extend
    imm_i_type  = i_imm(instruction_i);
    imm_s_type  = {{52{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7]};
    imm_sb_type = sb_imm(instruction_i);
    imm_u_type  = {{32{instruction_i[31]}}, instruction_i[31:12], 12'b0};
    imm_uj_type = uj_imm(instruction_i);
    imm_bi_type = {{59{instruction_i[24]}}, instruction_i[24:20]};

    case (imm_select)
      IIMM: begin
        instruction_o.result  = imm_i_type;
        instruction_o.use_imm = 1'b1;
      end
      SIMM: begin
        instruction_o.result  = imm_s_type;
        instruction_o.use_imm = 1'b1;
      end
      SBIMM: begin
        instruction_o.result  = imm_sb_type;
        instruction_o.use_imm = 1'b1;
      end
      UIMM: begin
        instruction_o.result  = imm_u_type;
        instruction_o.use_imm = 1'b1;
      end
      JIMM: begin
        instruction_o.result  = imm_uj_type;
        instruction_o.use_imm = 1'b1;
      end
      RS3: begin

        instruction_o.result  = {59'b0, instr.r4type.rs3};
        instruction_o.use_imm = 1'b0;
      end
      default: begin
        instruction_o.result  = 64'b0;
        instruction_o.use_imm = 1'b0;
      end
    endcase
  end

  always_comb begin : exception_handling
    instruction_o.ex    = ex_i;
    instruction_o.valid = ex_i.valid;

    if (~ex_i.valid) begin

      instruction_o.ex.tval  = (is_compressed_i) ? {48'b0, compressed_instr_i} : {32'b0, instruction_i};

      if (illegal_instr || is_illegal_i) begin
        instruction_o.valid    = 1'b1;
        instruction_o.ex.valid = 1'b1;

        instruction_o.ex.cause = riscv_pkg::ILLEGAL_INSTR;

      end else if (ecall) begin

        instruction_o.valid    = 1'b1;

        instruction_o.ex.valid = 1'b1;

        case (priv_lvl_i)
          riscv_pkg::PRIV_LVL_M: instruction_o.ex.cause = riscv_pkg::ENV_CALL_MMODE;
          riscv_pkg::PRIV_LVL_S: instruction_o.ex.cause = riscv_pkg::ENV_CALL_SMODE;
          riscv_pkg::PRIV_LVL_U: instruction_o.ex.cause = riscv_pkg::ENV_CALL_UMODE;
          default: ;
        endcase
      end else if (ebreak) begin

        instruction_o.valid    = 1'b1;

        instruction_o.ex.valid = 1'b1;

        instruction_o.ex.cause = riscv_pkg::BREAKPOINT;
      end
    end
  end
endmodule


import ariane_pkg::*;
module id_stage (
    input logic clk_i,
    input logic rst_ni,

    input logic flush_i,

    input  frontend_fetch_t fetch_entry_i,
    input  logic            fetch_entry_valid_i,
    output logic            decoded_instr_ack_o,

    output scoreboard_entry_t issue_entry_o,
    output logic              issue_entry_valid_o,
    output logic              is_ctrl_flow_o,
    input  logic              issue_instr_ack_i,

    input riscv_pkg::priv_lvl_t       priv_lvl_i,
    input riscv_pkg::xs_t             fs_i,
    input logic                 [2:0] frm_i,

    input logic debug_mode_i,
    input logic tvm_i,
    input logic tw_i,
    input logic tsr_i
);

  struct packed {
    logic              valid;
    scoreboard_entry_t sbe;
    logic              is_ctrl_flow;
  }
      issue_n, issue_q;

  logic                     is_control_flow_instr;
  scoreboard_entry_t        decoded_instruction;

  fetch_entry_t             fetch_entry;
  logic                     is_illegal;
  logic              [31:0] instruction;
  logic                     is_compressed;
  logic                     fetch_ack_i;
  logic                     fetch_entry_valid;

  instr_realigner instr_realigner_i (
      .fetch_entry_i      (fetch_entry_i),
      .fetch_entry_valid_i(fetch_entry_valid_i),
      .fetch_ack_o        (decoded_instr_ack_o),

      .fetch_entry_o      (fetch_entry),
      .fetch_entry_valid_o(fetch_entry_valid),
      .fetch_ack_i        (fetch_ack_i),
      .*
  );

  compressed_decoder compressed_decoder_i (
      .instr_i        (fetch_entry.instruction),
      .instr_o        (instruction),
      .illegal_instr_o(is_illegal),
      .is_compressed_o(is_compressed)

  );

  decoder decoder_i (
      .pc_i                   (fetch_entry.address),
      .is_compressed_i        (is_compressed),
      .compressed_instr_i     (fetch_entry.instruction[15:0]),
      .instruction_i          (instruction),
      .branch_predict_i       (fetch_entry.branch_predict),
      .is_illegal_i           (is_illegal),
      .ex_i                   (fetch_entry.ex),
      .instruction_o          (decoded_instruction),
      .is_control_flow_instr_o(is_control_flow_instr),
      .fs_i,
      .frm_i,
      .*
  );

  assign issue_entry_o = issue_q.sbe;
  assign issue_entry_valid_o = issue_q.valid;
  assign is_ctrl_flow_o = issue_q.is_ctrl_flow;

  always_comb begin
    issue_n     = issue_q;
    fetch_ack_i = 1'b0;

    if (issue_instr_ack_i) issue_n.valid = 1'b0;

    if ((!issue_q.valid || issue_instr_ack_i) && fetch_entry_valid) begin
      fetch_ack_i = 1'b1;
      issue_n = {1'b1, decoded_instruction, is_control_flow_instr};
    end

    if (flush_i) issue_n.valid = 1'b0;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      issue_q <= '0;
    end else begin
      issue_q <= issue_n;
    end
  end

endmodule


import ariane_pkg::*;
module re_name (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic flush_unissied_instr_i,

    input  scoreboard_entry_t issue_instr_i,
    input  logic              issue_instr_valid_i,
    output logic              issue_ack_o,

    output scoreboard_entry_t issue_instr_o,
    output logic              issue_instr_valid_o,
    input  logic              issue_ack_i
);

  assign issue_instr_valid_o = issue_instr_valid_i;
  assign issue_ack_o         = issue_ack_i;

  logic [31:0] re_name_table_gpr_n, re_name_table_gpr_q;
  logic [31:0] re_name_table_fpr_n, re_name_table_fpr_q;

  always_comb begin

    logic name_bit_rs1, name_bit_rs2, name_bit_rs3, name_bit_rd;

    re_name_table_gpr_n = re_name_table_gpr_q;
    re_name_table_fpr_n = re_name_table_fpr_q;
    issue_instr_o       = issue_instr_i;

    if (issue_ack_i && !flush_unissied_instr_i) begin

      if (is_rd_fpr(issue_instr_i.op))
        re_name_table_fpr_n[issue_instr_i.rd] = re_name_table_fpr_q[issue_instr_i.rd] ^ 1'b1;
      else re_name_table_gpr_n[issue_instr_i.rd] = re_name_table_gpr_q[issue_instr_i.rd] ^ 1'b1;
    end

    name_bit_rs1 = is_rs1_fpr(issue_instr_i.op) ? re_name_table_fpr_q[issue_instr_i.rs1] :
        re_name_table_gpr_q[issue_instr_i.rs1];
    name_bit_rs2 = is_rs2_fpr(issue_instr_i.op) ? re_name_table_fpr_q[issue_instr_i.rs2] :
        re_name_table_gpr_q[issue_instr_i.rs2];

    name_bit_rs3 = re_name_table_fpr_q[issue_instr_i.result[4:0]];

    name_bit_rd = is_rd_fpr(issue_instr_i.op) ? re_name_table_fpr_q[issue_instr_i.rd] ^ 1'b1 :
        re_name_table_gpr_q[issue_instr_i.rd] ^ (issue_instr_i.rd != '0);

    issue_instr_o.rs1 = {ENABLE_RENAME & name_bit_rs1, issue_instr_i.rs1[4:0]};
    issue_instr_o.rs2 = {ENABLE_RENAME & name_bit_rs2, issue_instr_i.rs2[4:0]};

    if (is_imm_fpr(issue_instr_i.op))
      issue_instr_o.result = {ENABLE_RENAME & name_bit_rs3, issue_instr_i.result[4:0]};

    issue_instr_o.rd = {ENABLE_RENAME & name_bit_rd, issue_instr_i.rd[4:0]};

    re_name_table_gpr_n[0] = 1'b0;

    if (flush_i) begin
      re_name_table_gpr_n = '0;
      re_name_table_fpr_n = '0;
    end

  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      re_name_table_gpr_q <= '0;
      re_name_table_fpr_q <= '0;
    end else begin
      re_name_table_gpr_q <= re_name_table_gpr_n;
      re_name_table_fpr_q <= re_name_table_fpr_n;
    end
  end
endmodule


import ariane_pkg::*;
module scoreboard #(
    parameter int unsigned NR_ENTRIES = 8,
    parameter int unsigned NR_WB_PORTS = 1,
    parameter int unsigned NR_COMMIT_PORTS = 2
) (
    input  logic clk_i,
    input  logic rst_ni,
    output logic sb_full_o,
    input  logic flush_unissued_instr_i,
    input  logic flush_i,
    input  logic unresolved_branch_i,

    output fu_t [2**REG_ADDR_SIZE:0] rd_clobber_gpr_o,
    output fu_t [2**REG_ADDR_SIZE:0] rd_clobber_fpr_o,

    input  logic [REG_ADDR_SIZE-1:0] rs1_i,
    output logic [             63:0] rs1_o,
    output logic                     rs1_valid_o,

    input  logic [REG_ADDR_SIZE-1:0] rs2_i,
    output logic [             63:0] rs2_o,
    output logic                     rs2_valid_o,

    input  logic [REG_ADDR_SIZE-1:0] rs3_i,
    output logic [         FLEN-1:0] rs3_o,
    output logic                     rs3_valid_o,

    output scoreboard_entry_t [NR_COMMIT_PORTS-1:0] commit_instr_o,
    input  logic              [NR_COMMIT_PORTS-1:0] commit_ack_i,

    input  scoreboard_entry_t decoded_instr_i,
    input  logic              decoded_instr_valid_i,
    output logic              decoded_instr_ack_o,

    output scoreboard_entry_t issue_instr_o,
    output logic              issue_instr_valid_o,
    input  logic              issue_ack_i,

    input branchpredict_t                                      resolved_branch_i,
    input logic           [NR_WB_PORTS-1:0][TRANS_ID_BITS-1:0] trans_id_i,
    input logic           [NR_WB_PORTS-1:0][             63:0] wbdata_i,
    input exception_t     [NR_WB_PORTS-1:0]                    ex_i,
    input logic           [NR_WB_PORTS-1:0]                    wb_valid_i
);
  localparam int unsigned BITS_ENTRIES = $clog2(NR_ENTRIES);

  typedef struct packed {
    logic issued;
    scoreboard_entry_t sbe;
  } mem_t;

  mem_t mem_q[NR_ENTRIES-1:0];
  mem_t mem_n[NR_ENTRIES-1:0];

  logic [BITS_ENTRIES-1:0] issue_cnt_n, issue_cnt_q;
  logic [BITS_ENTRIES-1:0] issue_pointer_n, issue_pointer_q;
  logic [BITS_ENTRIES-1:0] commit_pointer_n, commit_pointer_q;
  logic issue_full;

  assign issue_full = (issue_cnt_q == NR_ENTRIES - 1);

  assign sb_full_o  = issue_full;

  always_comb begin : commit_ports
    for (logic [BITS_ENTRIES-1:0] i = 0; i < NR_COMMIT_PORTS; i++)
    commit_instr_o[i] = mem_q[commit_pointer_q+i].sbe;
  end

  always_comb begin
    issue_instr_o          = decoded_instr_i;

    issue_instr_o.trans_id = issue_pointer_q;

    issue_instr_valid_o    = decoded_instr_valid_i && !unresolved_branch_i && !issue_full;
    decoded_instr_ack_o    = issue_ack_i && !issue_full;
  end

  always_comb begin : issue_fifo
    automatic logic [BITS_ENTRIES-1:0] issue_cnt;
    automatic logic [BITS_ENTRIES-1:0] commit_pointer;

    commit_pointer  = commit_pointer_q;
    issue_cnt       = issue_cnt_q;

    mem_n           = mem_q;
    issue_pointer_n = issue_pointer_q;

    if (decoded_instr_valid_i && decoded_instr_ack_o && !flush_unissued_instr_i) begin

      issue_cnt++;
      mem_n[issue_pointer_q] = {1'b1, decoded_instr_i};

      issue_pointer_n = issue_pointer_q + 1'b1;
    end

    for (int unsigned i = 0; i < NR_WB_PORTS; i++) begin

      if (wb_valid_i[i] && mem_n[trans_id_i[i]].issued) begin
        mem_n[trans_id_i[i]].sbe.valid = 1'b1;
        mem_n[trans_id_i[i]].sbe.result = wbdata_i[i];

        mem_n[trans_id_i[i]].sbe.bp.predict_address = resolved_branch_i.target_address;

        if (ex_i[i].valid) mem_n[trans_id_i[i]].sbe.ex = ex_i[i];

        else if (mem_n[trans_id_i[i]].sbe.fu inside {FPU, FPU_VEC})
          mem_n[trans_id_i[i]].sbe.ex.cause = ex_i[i].cause;
      end
    end

    for (logic [BITS_ENTRIES-1:0] i = 0; i < NR_COMMIT_PORTS; i++) begin
      if (commit_ack_i[i]) begin

        issue_cnt--;

        mem_n[commit_pointer_q + i].issued    = 1'b0;
        mem_n[commit_pointer_q + i].sbe.valid = 1'b0;

        commit_pointer++;
      end
    end

    if (flush_i) begin
      for (int unsigned i = 0; i < NR_ENTRIES; i++) begin

        mem_n[i].issued       = 1'b0;
        mem_n[i].sbe.valid    = 1'b0;
        mem_n[i].sbe.ex.valid = 1'b0;

        issue_cnt             = '0;
        issue_pointer_n       = '0;
        commit_pointer        = '0;
      end
    end

    issue_cnt_n      = issue_cnt;

    commit_pointer_n = commit_pointer;
  end

  always_comb begin : clobber_output
    rd_clobber_gpr_o = '{default: NONE};
    rd_clobber_fpr_o = '{default: NONE};

    for (int unsigned i = 0; i < NR_ENTRIES; i++) begin
      if (mem_q[i].issued) begin

        if (is_rd_fpr(mem_q[i].sbe.op)) rd_clobber_fpr_o[mem_q[i].sbe.rd] = mem_q[i].sbe.fu;
        else rd_clobber_gpr_o[mem_q[i].sbe.rd] = mem_q[i].sbe.fu;
      end
    end

    rd_clobber_gpr_o[0] = NONE;
  end

  always_comb begin : read_operands
    rs1_o       = 64'b0;
    rs2_o       = 64'b0;
    rs3_o       = '0;
    rs1_valid_o = 1'b0;
    rs2_valid_o = 1'b0;
    rs3_valid_o = 1'b0;

    for (int unsigned i = 0; i < NR_ENTRIES; i++) begin

      if (mem_q[i].issued) begin

        if ((mem_q[i].sbe.rd == rs1_i) && (is_rd_fpr(
                mem_q[i].sbe.op
            ) == is_rs1_fpr(
                issue_instr_o.op
            ))) begin
          rs1_o       = mem_q[i].sbe.result;
          rs1_valid_o = mem_q[i].sbe.valid;
        end else if ((mem_q[i].sbe.rd == rs2_i) && (is_rd_fpr(
                mem_q[i].sbe.op
            ) == is_rs2_fpr(
                issue_instr_o.op
            ))) begin
          rs2_o       = mem_q[i].sbe.result;
          rs2_valid_o = mem_q[i].sbe.valid;
        end else if ((mem_q[i].sbe.rd == rs3_i) && (is_rd_fpr(
                mem_q[i].sbe.op
            ) == is_imm_fpr(
                issue_instr_o.op
            ))) begin
          rs3_o       = mem_q[i].sbe.result;
          rs3_valid_o = mem_q[i].sbe.valid;
        end
      end
    end

    for (int unsigned j = 0; j < NR_WB_PORTS; j++) begin
      if (mem_q[trans_id_i[j]].sbe.rd == rs1_i && wb_valid_i[j] && ~ex_i[j].valid && (is_rd_fpr(
              mem_q[trans_id_i[j]].sbe.op
          ) == is_rs1_fpr(
              issue_instr_o.op
          ))) begin
        rs1_o = wbdata_i[j];
        rs1_valid_o = wb_valid_i[j];
        break;
      end
      if (mem_q[trans_id_i[j]].sbe.rd == rs2_i && wb_valid_i[j] && ~ex_i[j].valid && (is_rd_fpr(
              mem_q[trans_id_i[j]].sbe.op
          ) == is_rs2_fpr(
              issue_instr_o.op
          ))) begin
        rs2_o = wbdata_i[j];
        rs2_valid_o = wb_valid_i[j];
        break;
      end
      if (mem_q[trans_id_i[j]].sbe.rd == rs3_i && wb_valid_i[j] && ~ex_i[j].valid && (is_rd_fpr(
              mem_q[trans_id_i[j]].sbe.op
          ) == is_imm_fpr(
              issue_instr_o.op
          ))) begin
        rs3_o = wbdata_i[j];
        rs3_valid_o = wb_valid_i[j];
        break;
      end
    end

    if (rs1_i == '0 && ~is_rs1_fpr(issue_instr_o.op)) rs1_valid_o = 1'b0;
    if (rs2_i == '0 && ~is_rs2_fpr(issue_instr_o.op)) rs2_valid_o = 1'b0;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      foreach (mem_q[i]) mem_q[i] <= mem_t'(0);
      issue_cnt_q      <= '0;
      commit_pointer_q <= '0;
      issue_pointer_q  <= '0;
    end else begin
      issue_cnt_q      <= issue_cnt_n;
      issue_pointer_q  <= issue_pointer_n;
      mem_q            <= mem_n;
      commit_pointer_q <= commit_pointer_n;
    end
  end

endmodule


module ariane_regfile #(
    parameter int unsigned DATA_WIDTH     = 32,
    parameter int unsigned NR_READ_PORTS  = 2,
    parameter int unsigned NR_WRITE_PORTS = 2,
    parameter bit          ZERO_REG_ZERO  = 0
) (

    input logic clk_i,
    input logic rst_ni,

    input logic test_en_i,

    input  logic [NR_READ_PORTS-1:0][           4:0] raddr_i,
    output logic [NR_READ_PORTS-1:0][DATA_WIDTH-1:0] rdata_o,

    input logic [NR_WRITE_PORTS-1:0][           4:0] waddr_i,
    input logic [NR_WRITE_PORTS-1:0][DATA_WIDTH-1:0] wdata_i,
    input logic [NR_WRITE_PORTS-1:0]                 we_i
);

  localparam ADDR_WIDTH = 5;
  localparam NUM_WORDS = 2 ** ADDR_WIDTH;

  logic [     NUM_WORDS-1:0][DATA_WIDTH-1:0] mem;
  logic [NR_WRITE_PORTS-1:0][ NUM_WORDS-1:0] we_dec;

  always_comb begin : we_decoder
    for (int unsigned j = 0; j < NR_WRITE_PORTS; j++) begin
      for (int unsigned i = 0; i < NUM_WORDS; i++) begin
        if (waddr_i[j] == i) we_dec[j][i] = we_i[j];
        else we_dec[j][i] = 1'b0;
      end
    end
  end

  always_ff @(posedge clk_i, negedge rst_ni) begin : register_write_behavioral
    if (~rst_ni) begin
      mem <= '{default: '0};
    end else begin
      for (int unsigned j = 0; j < NR_WRITE_PORTS; j++) begin
        for (int unsigned i = 0; i < NUM_WORDS; i++) begin
          if (we_dec[j][i]) begin
            mem[i] <= wdata_i[j];
          end
        end
        if (ZERO_REG_ZERO) begin
          mem[0] <= '0;
        end
      end
    end
  end

  for (genvar i = 0; i < NR_READ_PORTS; i++) begin
    assign rdata_o[i] = mem[raddr_i[i]];
  end

endmodule


import ariane_pkg::*;
module issue_read_operands #(
    parameter int unsigned NR_COMMIT_PORTS = 2
) (
    input logic clk_i,
    input logic rst_ni,

    input logic flush_i,

    input scoreboard_entry_t issue_instr_i,
    input logic issue_instr_valid_i,
    output logic issue_ack_o,

    output logic [REG_ADDR_SIZE-1:0] rs1_o,
    input logic [63:0] rs1_i,
    input logic rs1_valid_i,
    output logic [REG_ADDR_SIZE-1:0] rs2_o,
    input logic [63:0] rs2_i,
    input logic rs2_valid_i,
    output logic [REG_ADDR_SIZE-1:0] rs3_o,
    input logic [FLEN-1:0] rs3_i,
    input logic rs3_valid_i,

    input fu_t [2**REG_ADDR_SIZE:0] rd_clobber_gpr_i,
    input fu_t [2**REG_ADDR_SIZE:0] rd_clobber_fpr_i,

    output fu_data_t fu_data_o,
    output logic [63:0] pc_o,
    output logic is_compressed_instr_o,

    input  logic flu_ready_i,
    output logic alu_valid_o,

    output logic branch_valid_o,
    output branchpredict_sbe_t branch_predict_o,

    input  logic lsu_ready_i,
    output logic lsu_valid_o,

    output logic mult_valid_o,

    input logic fpu_ready_i,
    output logic fpu_valid_o,
    output logic [1:0] fpu_fmt_o,
    output logic [2:0] fpu_rm_o,

    output logic csr_valid_o,

    input logic [NR_COMMIT_PORTS-1:0][4:0] waddr_i,
    input logic [NR_COMMIT_PORTS-1:0][63:0] wdata_i,
    input logic [NR_COMMIT_PORTS-1:0] we_gpr_i,
    input logic [NR_COMMIT_PORTS-1:0] we_fpr_i

);
  logic stall;
  logic fu_busy;
  logic [63:0] operand_a_regfile, operand_b_regfile;
  logic [FLEN-1:0] operand_c_regfile;

  logic [63:0] operand_a_n, operand_a_q, operand_b_n, operand_b_q, imm_n, imm_q;

  logic alu_valid_n, alu_valid_q;
  logic mult_valid_n, mult_valid_q;
  logic fpu_valid_n, fpu_valid_q;
  logic [1:0] fpu_fmt_n, fpu_fmt_q;
  logic [2:0] fpu_rm_n, fpu_rm_q;
  logic lsu_valid_n, lsu_valid_q;
  logic csr_valid_n, csr_valid_q;
  logic branch_valid_n, branch_valid_q;

  logic [TRANS_ID_BITS-1:0] trans_id_n, trans_id_q;
  fu_op operator_n, operator_q;
  fu_t fu_n, fu_q;

  logic forward_rs1, forward_rs2, forward_rs3;

  riscv_pkg::instruction_t orig_instr;
  assign orig_instr          = riscv_pkg::instruction_t'(issue_instr_i.ex.tval[31:0]);

  assign fu_data_o.operand_a = operand_a_q;
  assign fu_data_o.operand_b = operand_b_q;
  assign fu_data_o.fu        = fu_q;
  assign fu_data_o.operator  = operator_q;
  assign fu_data_o.trans_id  = trans_id_q;
  assign fu_data_o.imm       = imm_q;
  assign alu_valid_o         = alu_valid_q;
  assign branch_valid_o      = branch_valid_q;
  assign lsu_valid_o         = lsu_valid_q;
  assign csr_valid_o         = csr_valid_q;
  assign mult_valid_o        = mult_valid_q;
  assign fpu_valid_o         = fpu_valid_q;
  assign fpu_fmt_o           = fpu_fmt_q;
  assign fpu_rm_o            = fpu_rm_q;

  always_comb begin : unit_busy
    unique case (issue_instr_i.fu)
      NONE: fu_busy = 1'b0;
      ALU, CTRL_FLOW, CSR, MULT: fu_busy = ~flu_ready_i;
      FPU, FPU_VEC: fu_busy = ~fpu_ready_i;
      LOAD, STORE: fu_busy = ~lsu_ready_i;
      default: fu_busy = 1'b0;
    endcase
  end

  always_comb begin : operands_available
    stall = 1'b0;

    forward_rs1 = 1'b0;
    forward_rs2 = 1'b0;
    forward_rs3 = 1'b0;

    rs1_o = issue_instr_i.rs1;
    rs2_o = issue_instr_i.rs2;
    rs3_o = issue_instr_i.result[REG_ADDR_SIZE-1:0];

    if (~issue_instr_i.use_zimm && (is_rs1_fpr(
            issue_instr_i.op
        ) ? rd_clobber_fpr_i[issue_instr_i.rs1] != NONE :
            rd_clobber_gpr_i[issue_instr_i.rs1] != NONE)) begin

      if (rs1_valid_i && (is_rs1_fpr(
              issue_instr_i.op
          ) ? 1'b1 : rd_clobber_gpr_i[issue_instr_i.rs1] != CSR)) begin
        forward_rs1 = 1'b1;
      end else begin
        stall = 1'b1;
      end
    end

    if (is_rs2_fpr(
            issue_instr_i.op
        ) ? rd_clobber_fpr_i[issue_instr_i.rs2] != NONE :
            rd_clobber_gpr_i[issue_instr_i.rs2] != NONE) begin

      if (rs2_valid_i && (is_rs2_fpr(
              issue_instr_i.op
          ) ? 1'b1 : rd_clobber_gpr_i[issue_instr_i.rs2] != CSR)) begin
        forward_rs2 = 1'b1;
      end else begin
        stall = 1'b1;
      end
    end

    if (is_imm_fpr(
            issue_instr_i.op
        ) && rd_clobber_fpr_i[issue_instr_i.result[REG_ADDR_SIZE-1:0]] != NONE) begin

      if (rs3_valid_i) begin
        forward_rs3 = 1'b1;
      end else begin
        stall = 1'b1;
      end
    end
  end

  always_comb begin : forwarding_operand_select

    operand_a_n = operand_a_regfile;
    operand_b_n = operand_b_regfile;

    imm_n       = is_imm_fpr(issue_instr_i.op) ? operand_c_regfile : issue_instr_i.result;
    trans_id_n  = issue_instr_i.trans_id;
    fu_n        = issue_instr_i.fu;
    operator_n  = issue_instr_i.op;

    if (forward_rs1) begin
      operand_a_n = rs1_i;
    end

    if (forward_rs2) begin
      operand_b_n = rs2_i;
    end

    if (forward_rs3) begin
      imm_n = rs3_i;
    end

    if (issue_instr_i.use_pc) begin
      operand_a_n = issue_instr_i.pc;
    end

    if (issue_instr_i.use_zimm) begin

      operand_a_n = {52'b0, issue_instr_i.rs1[4:0]};
    end

    if (issue_instr_i.use_imm && (issue_instr_i.fu != STORE) && (issue_instr_i.fu != CTRL_FLOW) && !is_rs2_fpr(
            issue_instr_i.op
        )) begin
      operand_b_n = issue_instr_i.result;
    end
  end

  always_comb begin : unit_valid
    alu_valid_n    = 1'b0;
    lsu_valid_n    = 1'b0;
    mult_valid_n   = 1'b0;
    fpu_valid_n    = 1'b0;
    fpu_fmt_n      = 2'b0;
    fpu_rm_n       = 3'b0;
    csr_valid_n    = 1'b0;
    branch_valid_n = 1'b0;

    if (~issue_instr_i.ex.valid && issue_instr_valid_i && issue_ack_o) begin
      case (issue_instr_i.fu)
        ALU:         alu_valid_n = 1'b1;
        CTRL_FLOW:   branch_valid_n = 1'b1;
        MULT:        mult_valid_n = 1'b1;
        FPU: begin
          fpu_valid_n = 1'b1;
          fpu_fmt_n   = orig_instr.rftype.fmt;
          fpu_rm_n    = orig_instr.rftype.rm;
        end
        FPU_VEC: begin
          fpu_valid_n = 1'b1;
          fpu_fmt_n   = orig_instr.rvftype.vfmt;
          fpu_rm_n    = {2'b0, orig_instr.rvftype.repl};
        end
        LOAD, STORE: lsu_valid_n = 1'b1;
        CSR:         csr_valid_n = 1'b1;
        default:     ;
      endcase
    end

    if (flush_i) begin
      alu_valid_n    = 1'b0;
      lsu_valid_n    = 1'b0;
      mult_valid_n   = 1'b0;
      fpu_valid_n    = 1'b0;
      csr_valid_n    = 1'b0;
      branch_valid_n = 1'b0;
    end
  end

  always_comb begin : issue_scoreboard

    issue_ack_o = 1'b0;

    if (issue_instr_valid_i) begin

      if (~stall && ~fu_busy) begin

        if (is_rd_fpr(
                issue_instr_i.op
            ) ? (rd_clobber_fpr_i[issue_instr_i.rd] == NONE) :
                (rd_clobber_gpr_i[issue_instr_i.rd] == NONE)) begin
          issue_ack_o = 1'b1;
        end

        for (int unsigned i = 0; i < NR_COMMIT_PORTS; i++)
        if (is_rd_fpr(
                issue_instr_i.op
            ) ? (we_fpr_i[i] && waddr_i[i] == issue_instr_i.rd) :
                (we_gpr_i[i] && waddr_i[i] == issue_instr_i.rd)) begin
          issue_ack_o = 1'b1;
        end
      end

      if (issue_instr_i.ex.valid) begin
        issue_ack_o = 1'b1;
      end

      if (issue_instr_i.fu == NONE) begin
        issue_ack_o = 1'b1;
      end
    end

    if (mult_valid_q && issue_instr_i.fu != MULT) begin
      issue_ack_o = 1'b0;
    end
  end

  logic [                1:0][63:0] rdata;
  logic [                1:0][ 4:0] raddr_pack;

  logic [NR_COMMIT_PORTS-1:0][ 4:0] waddr_pack;
  logic [NR_COMMIT_PORTS-1:0][63:0] wdata_pack;
  logic [NR_COMMIT_PORTS-1:0]       we_pack;
  assign raddr_pack = {issue_instr_i.rs2[4:0], issue_instr_i.rs1[4:0]};
  assign waddr_pack = {waddr_i[1],  waddr_i[0]};
  assign wdata_pack = {wdata_i[1],  wdata_i[0]};
  assign we_pack    = {we_gpr_i[1], we_gpr_i[0]};

  ariane_regfile #(
      .DATA_WIDTH    (64),
      .NR_READ_PORTS (2),
      .NR_WRITE_PORTS(NR_COMMIT_PORTS),
      .ZERO_REG_ZERO (1)
  ) i_ariane_regfile (
      .test_en_i(1'b0),
      .raddr_i  (raddr_pack),
      .rdata_o  (rdata),
      .waddr_i  (waddr_pack),
      .wdata_i  (wdata_pack),
      .we_i     (we_pack),
      .*
  );

  logic [2:0][FLEN-1:0] fprdata;

  logic [2:0][4:0] fp_raddr_pack;
  logic [NR_COMMIT_PORTS-1:0][63:0] fp_wdata_pack;

  generate
    if (FP_PRESENT) begin : float_regfile_gen
      assign fp_raddr_pack = {
        issue_instr_i.result[4:0], issue_instr_i.rs2[4:0], issue_instr_i.rs1[4:0]
      };
      assign fp_wdata_pack = {wdata_i[1][FLEN-1:0], wdata_i[0][FLEN-1:0]};

      ariane_regfile #(
          .DATA_WIDTH    (FLEN),
          .NR_READ_PORTS (3),
          .NR_WRITE_PORTS(NR_COMMIT_PORTS),
          .ZERO_REG_ZERO (0)
      ) i_ariane_fp_regfile (
          .test_en_i(1'b0),
          .raddr_i  (fp_raddr_pack),
          .rdata_o  (fprdata),
          .waddr_i  (waddr_pack),
          .wdata_i  (wdata_pack),
          .we_i     (we_fpr_i),
          .*
      );
    end else begin : no_fpr_gen
      assign fprdata = '{default: '0};
    end
  endgenerate

  assign operand_a_regfile = is_rs1_fpr(issue_instr_i.op) ? fprdata[0] : rdata[0];
  assign operand_b_regfile = is_rs2_fpr(issue_instr_i.op) ? fprdata[1] : rdata[1];
  assign operand_c_regfile = fprdata[2];

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      operand_a_q           <= '{default: 0};
      operand_b_q           <= '{default: 0};
      imm_q                 <= 64'b0;
      alu_valid_q           <= 1'b0;
      branch_valid_q        <= 1'b0;
      mult_valid_q          <= 1'b0;
      fpu_valid_q           <= 1'b0;
      fpu_fmt_q             <= 2'b0;
      fpu_rm_q              <= 3'b0;
      lsu_valid_q           <= 1'b0;
      csr_valid_q           <= 1'b0;
      fu_q                  <= NONE;
      operator_q            <= ADD;
      trans_id_q            <= 5'b0;
      pc_o                  <= 64'b0;
      is_compressed_instr_o <= 1'b0;
      branch_predict_o      <= branchpredict_sbe_t'('0);
    end else begin
      operand_a_q           <= operand_a_n;
      operand_b_q           <= operand_b_n;
      imm_q                 <= imm_n;
      alu_valid_q           <= alu_valid_n;
      branch_valid_q        <= branch_valid_n;
      mult_valid_q          <= mult_valid_n;
      fpu_valid_q           <= fpu_valid_n;
      fpu_fmt_q             <= fpu_fmt_n;
      fpu_rm_q              <= fpu_rm_n;
      lsu_valid_q           <= lsu_valid_n;
      csr_valid_q           <= csr_valid_n;
      fu_q                  <= fu_n;
      operator_q            <= operator_n;
      trans_id_q            <= trans_id_n;
      pc_o                  <= issue_instr_i.pc;
      is_compressed_instr_o <= issue_instr_i.is_compressed;
      branch_predict_o      <= issue_instr_i.bp;
    end
  end

endmodule



import ariane_pkg::*;
module issue_stage #(
    parameter int unsigned NR_ENTRIES = 8,
    parameter int unsigned NR_WB_PORTS = 4,
    parameter int unsigned NR_COMMIT_PORTS = 2
) (
    input logic clk_i,
    input logic rst_ni,

    output logic sb_full_o,
    input  logic flush_unissued_instr_i,
    input  logic flush_i,

    input  scoreboard_entry_t decoded_instr_i,
    input  logic              decoded_instr_valid_i,
    input  logic              is_ctrl_flow_i,
    output logic              decoded_instr_ack_o,

    output fu_data_t        fu_data_o,
    output logic     [63:0] pc_o,
    output logic            is_compressed_instr_o,
    input  logic            flu_ready_i,
    output logic            alu_valid_o,

    input logic resolve_branch_i,

    input  logic lsu_ready_i,
    output logic lsu_valid_o,

    output logic               branch_valid_o,
    output branchpredict_sbe_t branch_predict_o,

    output logic mult_valid_o,

    input  logic       fpu_ready_i,
    output logic       fpu_valid_o,
    output logic [1:0] fpu_fmt_o,
    output logic [2:0] fpu_rm_o,

    output logic csr_valid_o,

    input logic           [NR_WB_PORTS-1:0][TRANS_ID_BITS-1:0] trans_id_i,
    input branchpredict_t                                      resolved_branch_i,
    input logic           [NR_WB_PORTS-1:0][             63:0] wbdata_i,
    input exception_t     [NR_WB_PORTS-1:0]                    ex_ex_i,
    input logic           [NR_WB_PORTS-1:0]                    wb_valid_i,

    input logic [NR_COMMIT_PORTS-1:0][ 4:0] waddr_i,
    input logic [NR_COMMIT_PORTS-1:0][63:0] wdata_i,
    input logic [NR_COMMIT_PORTS-1:0]       we_gpr_i,
    input logic [NR_COMMIT_PORTS-1:0]       we_fpr_i,

    output scoreboard_entry_t [NR_COMMIT_PORTS-1:0] commit_instr_o,
    input  logic              [NR_COMMIT_PORTS-1:0] commit_ack_i
);

  fu_t               [2**REG_ADDR_SIZE:0] rd_clobber_gpr_sb_iro;
  fu_t               [2**REG_ADDR_SIZE:0] rd_clobber_fpr_sb_iro;

  logic              [ REG_ADDR_SIZE-1:0] rs1_iro_sb;
  logic              [              63:0] rs1_sb_iro;
  logic                                   rs1_valid_sb_iro;

  logic              [ REG_ADDR_SIZE-1:0] rs2_iro_sb;
  logic              [              63:0] rs2_sb_iro;
  logic                                   rs2_valid_iro_sb;

  logic              [ REG_ADDR_SIZE-1:0] rs3_iro_sb;
  logic              [          FLEN-1:0] rs3_sb_iro;
  logic                                   rs3_valid_iro_sb;

  scoreboard_entry_t                      issue_instr_rename_sb;
  logic                                   issue_instr_valid_rename_sb;
  logic                                   issue_ack_sb_rename;

  scoreboard_entry_t                      issue_instr_sb_iro;
  logic                                   issue_instr_valid_sb_iro;
  logic                                   issue_ack_iro_sb;

  re_name i_re_name (
      .clk_i                 (clk_i),
      .rst_ni                (rst_ni),
      .flush_i               (flush_i),
      .flush_unissied_instr_i(flush_unissued_instr_i),
      .issue_instr_i         (decoded_instr_i),
      .issue_instr_valid_i   (decoded_instr_valid_i),
      .issue_ack_o           (decoded_instr_ack_o),
      .issue_instr_o         (issue_instr_rename_sb),
      .issue_instr_valid_o   (issue_instr_valid_rename_sb),
      .issue_ack_i           (issue_ack_sb_rename)
  );

  scoreboard #(
      .NR_ENTRIES (NR_ENTRIES),
      .NR_WB_PORTS(NR_WB_PORTS)
  ) i_scoreboard (
      .sb_full_o          (sb_full_o),
      .unresolved_branch_i(1'b0),
      .rd_clobber_gpr_o   (rd_clobber_gpr_sb_iro),
      .rd_clobber_fpr_o   (rd_clobber_fpr_sb_iro),
      .rs1_i              (rs1_iro_sb),
      .rs1_o              (rs1_sb_iro),
      .rs1_valid_o        (rs1_valid_sb_iro),
      .rs2_i              (rs2_iro_sb),
      .rs2_o              (rs2_sb_iro),
      .rs2_valid_o        (rs2_valid_iro_sb),
      .rs3_i              (rs3_iro_sb),
      .rs3_o              (rs3_sb_iro),
      .rs3_valid_o        (rs3_valid_iro_sb),

      .decoded_instr_i      (issue_instr_rename_sb),
      .decoded_instr_valid_i(issue_instr_valid_rename_sb),
      .decoded_instr_ack_o  (issue_ack_sb_rename),
      .issue_instr_o        (issue_instr_sb_iro),
      .issue_instr_valid_o  (issue_instr_valid_sb_iro),
      .issue_ack_i          (issue_ack_iro_sb),

      .resolved_branch_i(resolved_branch_i),
      .trans_id_i       (trans_id_i),
      .wbdata_i         (wbdata_i),
      .ex_i             (ex_ex_i),
      .*
  );

  issue_read_operands i_issue_read_operands (
      .flush_i            (flush_unissued_instr_i),
      .issue_instr_i      (issue_instr_sb_iro),
      .issue_instr_valid_i(issue_instr_valid_sb_iro),
      .issue_ack_o        (issue_ack_iro_sb),
      .fu_data_o          (fu_data_o),
      .flu_ready_i        (flu_ready_i),
      .rs1_o              (rs1_iro_sb),
      .rs1_i              (rs1_sb_iro),
      .rs1_valid_i        (rs1_valid_sb_iro),
      .rs2_o              (rs2_iro_sb),
      .rs2_i              (rs2_sb_iro),
      .rs2_valid_i        (rs2_valid_iro_sb),
      .rs3_o              (rs3_iro_sb),
      .rs3_i              (rs3_sb_iro),
      .rs3_valid_i        (rs3_valid_iro_sb),
      .rd_clobber_gpr_i   (rd_clobber_gpr_sb_iro),
      .rd_clobber_fpr_i   (rd_clobber_fpr_sb_iro),
      .alu_valid_o        (alu_valid_o),
      .branch_valid_o     (branch_valid_o),
      .csr_valid_o        (csr_valid_o),
      .mult_valid_o       (mult_valid_o),
      .*
  );

endmodule


import ariane_pkg::*;

module alu (
    input  logic            clk_i,
    input  logic            rst_ni,
    input  fu_data_t        fu_data_i,
    output logic     [63:0] result_o,
    output logic            alu_branch_res_o
);

  logic [63:0] operand_a_rev;
  logic [31:0] operand_a_rev32;
  logic [64:0] operand_b_neg;
  logic [65:0] adder_result_ext_o;
  logic        less;

  generate
    genvar k;
    for (k = 0; k < 64; k++) assign operand_a_rev[k] = fu_data_i.operand_a[63-k];

    for (k = 0; k < 32; k++) assign operand_a_rev32[k] = fu_data_i.operand_a[31-k];
  endgenerate

  logic adder_op_b_negate;
  logic adder_z_flag;
  logic [64:0] adder_in_a, adder_in_b;
  logic [63:0] adder_result;

  always_comb begin
    adder_op_b_negate = 1'b0;

    unique case (fu_data_i.operator)

      EQ, NE, SUB, SUBW: adder_op_b_negate = 1'b1;

      default: ;
    endcase
  end

  assign adder_in_a         = {fu_data_i.operand_a, 1'b1};

  assign operand_b_neg      = {fu_data_i.operand_b, 1'b0} ^ {65{adder_op_b_negate}};
  assign adder_in_b         = operand_b_neg;

  assign adder_result_ext_o = $unsigned(adder_in_a) + $unsigned(adder_in_b);
  assign adder_result       = adder_result_ext_o[64:1];
  assign adder_z_flag       = ~|adder_result;

  always_comb begin : branch_resolve

    alu_branch_res_o = 1'b1;
    case (fu_data_i.operator)
      EQ:       alu_branch_res_o = adder_z_flag;
      NE:       alu_branch_res_o = ~adder_z_flag;
      LTS, LTU: alu_branch_res_o = less;
      GES, GEU: alu_branch_res_o = ~less;
      default:  alu_branch_res_o = 1'b1;
    endcase
  end

  logic        shift_left;
  logic        shift_arithmetic;

  logic [63:0] shift_amt;
  logic [63:0] shift_op_a;
  logic [31:0] shift_op_a32;

  logic [63:0] shift_result;
  logic [31:0] shift_result32;

  logic [64:0] shift_right_result;
  logic [32:0] shift_right_result32;

  logic [63:0] shift_left_result;
  logic [31:0] shift_left_result32;

  assign shift_amt = fu_data_i.operand_b;

  assign shift_left = (fu_data_i.operator == SLL) | (fu_data_i.operator == SLLW);

  assign shift_arithmetic = (fu_data_i.operator == SRA) | (fu_data_i.operator == SRAW);

  logic [64:0] shift_op_a_64;
  logic [32:0] shift_op_a_32;

  assign shift_op_a           = shift_left ? operand_a_rev : fu_data_i.operand_a;
  assign shift_op_a32         = shift_left ? operand_a_rev32 : fu_data_i.operand_a[31:0];

  assign shift_op_a_64        = {shift_arithmetic & shift_op_a[63], shift_op_a};
  assign shift_op_a_32        = {shift_arithmetic & shift_op_a[31], shift_op_a32};

  assign shift_right_result   = $unsigned($signed(shift_op_a_64) >>> shift_amt[5:0]);

  assign shift_right_result32 = $unsigned($signed(shift_op_a_32) >>> shift_amt[4:0]);

  genvar j;
  generate
    for (j = 0; j < 64; j++) assign shift_left_result[j] = shift_right_result[63-j];

    for (j = 0; j < 32; j++) assign shift_left_result32[j] = shift_right_result32[31-j];

  endgenerate

  assign shift_result   = shift_left ? shift_left_result : shift_right_result[63:0];
  assign shift_result32 = shift_left ? shift_left_result32 : shift_right_result32[31:0];

  always_comb begin
    logic sgn;
    sgn = 1'b0;

    if ((fu_data_i.operator == SLTS) || (fu_data_i.operator == LTS) || (fu_data_i.operator == GES))
      sgn = 1'b1;

    less = ($signed({sgn & fu_data_i.operand_a[63], fu_data_i.operand_a}) <
            $signed({sgn & fu_data_i.operand_b[63], fu_data_i.operand_b}));
  end

  always_comb begin
    result_o = '0;

    unique case (fu_data_i.operator)

      ANDL: result_o = fu_data_i.operand_a & fu_data_i.operand_b;
      ORL:  result_o = fu_data_i.operand_a | fu_data_i.operand_b;
      XORL: result_o = fu_data_i.operand_a ^ fu_data_i.operand_b;

      ADD, SUB: result_o = adder_result;

      ADDW, SUBW: result_o = {{32{adder_result[31]}}, adder_result[31:0]};

      SLL, SRL, SRA: result_o = shift_result;

      SLLW, SRLW, SRAW: result_o = {{32{shift_result32[31]}}, shift_result32[31:0]};

      SLTS, SLTU: result_o = {63'b0, less};

      default: ;
    endcase
  end
endmodule


import ariane_pkg::*;
module branch_unit (
    input  fu_data_t        fu_data_i,
    input  logic     [63:0] pc_i,
    input  logic            is_compressed_instr_i,
    input  logic            fu_valid_i,
    input  logic            branch_valid_i,
    input  logic            branch_comp_res_i,
    output logic     [63:0] branch_result_o,

    input  branchpredict_sbe_t branch_predict_i,
    output branchpredict_t     resolved_branch_o,
    output logic               resolve_branch_o,

    output exception_t branch_exception_o
);
  logic [63:0] target_address;
  logic [63:0] next_pc;

  always_comb begin : mispredict_handler

    automatic logic [63:0] jump_base;
    jump_base                        = (fu_data_i.operator == JALR) ? fu_data_i.operand_a : pc_i;

    resolve_branch_o                 = 1'b0;
    resolved_branch_o.target_address = 64'b0;
    resolved_branch_o.is_taken       = 1'b0;
    resolved_branch_o.valid          = branch_valid_i;
    resolved_branch_o.is_mispredict  = 1'b0;
    resolved_branch_o.clear          = 1'b0;
    resolved_branch_o.cf_type        = branch_predict_i.cf_type;

    next_pc                          = pc_i + ((is_compressed_instr_i) ? 64'h2 : 64'h4);

    target_address                   = $unsigned($signed(jump_base) + $signed(fu_data_i.imm));

    if (fu_data_i.operator == JALR) target_address[0] = 1'b0;

    branch_result_o = next_pc;

    resolved_branch_o.pc = (is_compressed_instr_i || pc_i[1] == 1'b0) ? pc_i : ({pc_i[63:2], 2'b0} + 64'h4);

    if (branch_valid_i) begin

      resolved_branch_o.target_address = (branch_comp_res_i) ? target_address : next_pc;
      resolved_branch_o.is_taken       = branch_comp_res_i;

      if (target_address[0] == 1'b0) begin

        if (branch_predict_i.valid) begin

          if (branch_predict_i.predict_taken != branch_comp_res_i) begin
            resolved_branch_o.is_mispredict = 1'b1;
          end

          if (branch_predict_i.predict_taken && target_address != branch_predict_i.predict_address) begin
            resolved_branch_o.is_mispredict = 1'b1;
          end

        end else begin
          if (branch_comp_res_i) begin
            resolved_branch_o.is_mispredict = 1'b1;
          end
        end
      end

      resolve_branch_o = 1'b1;

    end else if (fu_valid_i && branch_predict_i.valid && branch_predict_i.predict_taken) begin

      resolved_branch_o.is_mispredict  = 1'b1;
      resolved_branch_o.target_address = next_pc;

      resolved_branch_o.clear          = 1'b1;
      resolved_branch_o.valid          = 1'b1;
      resolve_branch_o                 = 1'b1;
    end
  end

  always_comb begin : exception_handling
    branch_exception_o.cause = riscv_pkg::INSTR_ADDR_MISALIGNED;
    branch_exception_o.valid = 1'b0;
    branch_exception_o.tval  = pc_i;

    if (branch_valid_i && target_address[0] != 1'b0) branch_exception_o.valid = 1'b1;
  end
endmodule


import ariane_pkg::*;
module csr_buffer (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    input fu_data_t fu_data_i,

    output logic        csr_ready_o,
    input  logic        csr_valid_i,
    output logic [63:0] csr_result_o,
    input  logic        csr_commit_i,

    output logic [11:0] csr_addr_o
);

  struct packed {
    logic [11:0] csr_address;
    logic        valid;
  }
      csr_reg_n, csr_reg_q;

  assign csr_result_o = fu_data_i.operand_a;
  assign csr_addr_o   = csr_reg_q.csr_address;

  always_comb begin : write
    csr_reg_n   = csr_reg_q;

    csr_ready_o = 1'b1;

    if ((csr_reg_q.valid || csr_valid_i) && ~csr_commit_i) csr_ready_o = 1'b0;

    if (csr_valid_i) begin
      csr_reg_n.csr_address = fu_data_i.operand_b[11:0];
      csr_reg_n.valid       = 1'b1;
    end

    if (csr_commit_i && ~csr_valid_i) begin
      csr_reg_n.valid = 1'b0;
    end

    if (flush_i) csr_reg_n.valid = 1'b0;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      csr_reg_q <= '{default: 0};
    end else begin
      csr_reg_q <= csr_reg_n;
    end
  end

endmodule


import ariane_pkg::*;
module multiplier (
    input  logic                     clk_i,
    input  logic                     rst_ni,
    input  logic [TRANS_ID_BITS-1:0] trans_id_i,
    input  logic                     mult_valid_i,
    input  fu_op                     operator_i,
    input  logic [             63:0] operand_a_i,
    input  logic [             63:0] operand_b_i,
    output logic [             63:0] result_o,
    output logic                     mult_valid_o,
    output logic                     mult_ready_o,
    output logic [TRANS_ID_BITS-1:0] mult_trans_id_o
);

  logic [TRANS_ID_BITS-1:0] trans_id_q;
  logic                     mult_valid_q;
  fu_op operator_d, operator_q;
  logic [127:0] mult_result_d, mult_result_q;

  logic sign_a, sign_b;
  logic mult_valid;

  assign mult_valid_o    = mult_valid_q;
  assign mult_trans_id_o = trans_id_q;
  assign mult_ready_o    = 1'b1;

  assign mult_valid      = mult_valid_i && (operator_i inside {MUL, MULH, MULHU, MULHSU, MULW});

  logic [127:0] mult_result;
  assign mult_result = $signed(
      {operand_a_i[63] & sign_a, operand_a_i}
  ) * $signed(
      {operand_b_i[63] & sign_b, operand_b_i}
  );

  always_comb begin
    sign_a = 1'b0;
    sign_b = 1'b0;

    if (operator_i == MULH) begin
      sign_a = 1'b1;
      sign_b = 1'b1;

    end else if (operator_i == MULHSU) begin
      sign_a = 1'b1;

    end else begin
      sign_a = 1'b0;
      sign_b = 1'b0;
    end
  end

  assign mult_result_d = $signed(
      {operand_a_i[63] & sign_a, operand_a_i}
  ) * $signed(
      {operand_b_i[63] & sign_b, operand_b_i}
  );

  assign operator_d = operator_i;
  always_comb begin : p_selmux
    unique case (operator_q)
      MULH, MULHU, MULHSU: result_o = mult_result_q[127:64];
      MULW:                result_o = sext32(mult_result_q[31:0]);

      default: result_o = mult_result_q[63:0];
    endcase
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      mult_valid_q  <= '0;
      trans_id_q    <= '0;
      operator_q    <= MUL;
      mult_result_q <= '0;
    end else begin

      trans_id_q    <= trans_id_i;

      mult_valid_q  <= mult_valid;
      operator_q    <= operator_d;
      mult_result_q <= mult_result_d;
    end
  end
endmodule


module lzc #(

    parameter int unsigned WIDTH = 2,
    parameter int unsigned MODE  = 0
) (
    input  logic [        WIDTH-1:0] in_i,
    output logic [$clog2(WIDTH)-1:0] cnt_o,
    output logic                     empty_o
);

  localparam int NUM_LEVELS = $clog2(WIDTH);

  initial begin
    assert (WIDTH > 0)
    else $fatal(1, "input must be at least one bit wide");
  end

  logic [        WIDTH-1:0][NUM_LEVELS-1:0] index_lut;
  logic [2**NUM_LEVELS-1:0]                 sel_nodes;
  logic [2**NUM_LEVELS-1:0][NUM_LEVELS-1:0] index_nodes;

  logic [        WIDTH-1:0]                 in_tmp;

  assign in_tmp = MODE ? {<<{in_i}} : in_i;

  for (genvar j = 0; j < WIDTH; j++) begin : g_index_lut
    assign index_lut[j] = j;
  end

  for (genvar level = 0; level < NUM_LEVELS; level++) begin : g_levels
    if (level == NUM_LEVELS - 1) begin : g_last_level
      for (genvar k = 0; k < 2 ** level; k++) begin : g_level

        if (k * 2 < WIDTH - 1) begin
          assign sel_nodes[2**level-1+k] = in_tmp[k*2] | in_tmp[k*2+1];
          assign index_nodes[2**level-1+k] = (in_tmp[k*2] == 1'b1) ? index_lut[k*2] :
                                                                     index_lut[k*2+1];
        end

        if (k * 2 == WIDTH - 1) begin
          assign sel_nodes[2**level-1+k]   = in_tmp[k*2];
          assign index_nodes[2**level-1+k] = index_lut[k*2];
        end

        if (k * 2 > WIDTH - 1) begin
          assign sel_nodes[2**level-1+k]   = 1'b0;
          assign index_nodes[2**level-1+k] = '0;
        end
      end
    end else begin
      for (genvar l = 0; l < 2 ** level; l++) begin : g_level
        assign sel_nodes[2**level-1+l]   = sel_nodes[2**(level+1)-1+l*2] | sel_nodes[2**(level+1)-1+l*2+1];
        assign index_nodes[2**level-1+l] = (sel_nodes[2**(level+1)-1+l*2] == 1'b1) ? index_nodes[2**(level+1)-1+l*2] :
                                                                                     index_nodes[2**(level+1)-1+l*2+1];
      end
    end
  end

  assign cnt_o   = NUM_LEVELS > 0 ? index_nodes[0] : '0;
  assign empty_o = NUM_LEVELS > 0 ? ~sel_nodes[0] : ~(|in_i);

endmodule : lzc


import ariane_pkg::*;
module serdiv #(
    parameter WIDTH = 64
) (
    input logic clk_i,
    input logic rst_ni,

    input logic [TRANS_ID_BITS-1:0] id_i,
    input logic [        WIDTH-1:0] op_a_i,
    input logic [        WIDTH-1:0] op_b_i,
    input logic [              1:0] opcode_i,

    input  logic in_vld_i,
    output logic in_rdy_o,
    input  logic flush_i,

    output logic                     out_vld_o,
    input  logic                     out_rdy_i,
    output logic [TRANS_ID_BITS-1:0] id_o,
    output logic [        WIDTH-1:0] res_o
);

  enum logic [1:0] {
    IDLE,
    DIVIDE,
    FINISH
  }
      state_d, state_q;

  logic [WIDTH-1:0] res_q, res_d;
  logic [WIDTH-1:0] op_a_q, op_a_d;
  logic [WIDTH-1:0] op_b_q, op_b_d;
  logic op_a_sign, op_b_sign;
  logic op_b_zero, op_b_zero_q, op_b_zero_d;

  logic [TRANS_ID_BITS-1:0] id_q, id_d;

  logic rem_sel_d, rem_sel_q;
  logic comp_inv_d, comp_inv_q;
  logic res_inv_d, res_inv_q;

  logic [WIDTH-1:0] add_mux;
  logic [WIDTH-1:0] add_out;
  logic [WIDTH-1:0] add_tmp;
  logic [WIDTH-1:0] b_mux;
  logic [WIDTH-1:0] out_mux;

  logic [$clog2(WIDTH+1)-1:0] cnt_q, cnt_d;
  logic cnt_zero;

  logic [WIDTH-1:0] lzc_a_input, lzc_b_input, op_b;
  logic [$clog2(WIDTH)-1:0] lzc_a_result, lzc_b_result;
  logic [$clog2(WIDTH+1)-1:0] shift_a;
  logic [  $clog2(WIDTH+1):0] div_shift;

  logic a_reg_en, b_reg_en, res_reg_en, ab_comp, pm_sel, load_en;
  logic lzc_a_no_one, lzc_b_no_one;
  logic div_res_zero_d, div_res_zero_q;

  assign op_b_zero   = (op_b_i == 0);
  assign op_a_sign   = op_a_i[$high(op_a_i)];
  assign op_b_sign   = op_b_i[$high(op_b_i)];

  assign lzc_a_input = (opcode_i[0] & op_a_sign) ? {~op_a_i, 1'b0} : op_a_i;
  assign lzc_b_input = (opcode_i[0] & op_b_sign) ? ~op_b_i : op_b_i;

  lzc #(
      .MODE (1),
      .WIDTH(WIDTH)
  ) i_lzc_a (
      .in_i   (lzc_a_input),
      .cnt_o  (lzc_a_result),
      .empty_o(lzc_a_no_one)
  );

  lzc #(
      .MODE (1),
      .WIDTH(WIDTH)
  ) i_lzc_b (
      .in_i   (lzc_b_input),
      .cnt_o  (lzc_b_result),
      .empty_o(lzc_b_no_one)
  );

  assign shift_a = (lzc_a_no_one) ? WIDTH : lzc_a_result;
  assign div_shift = (lzc_b_no_one) ? WIDTH : lzc_b_result - shift_a;

  assign op_b = op_b_i <<< $unsigned(div_shift);

  assign div_res_zero_d = (load_en) ? ($signed(div_shift) < 0) : div_res_zero_q;

  assign pm_sel = load_en & ~(opcode_i[0] & (op_a_sign ^ op_b_sign));

  assign add_mux = (load_en) ? op_a_i : op_b_q;

  assign b_mux = (load_en) ? op_b : {comp_inv_q, (op_b_q[$high(op_b_q):1])};

  assign out_mux = (rem_sel_q) ? op_a_q : res_q;

  assign res_o = (res_inv_q) ? -$signed(out_mux) : out_mux;

  assign ab_comp     = ((op_a_q == op_b_q) | ((op_a_q > op_b_q) ^ comp_inv_q)) & ((|op_a_q) | op_b_zero_q);

  assign add_tmp = (load_en) ? 0 : op_a_q;
  assign add_out = (pm_sel) ? add_tmp + add_mux : add_tmp - $signed(add_mux);

  assign cnt_zero = (cnt_q == 0);
  assign cnt_d = (load_en) ? div_shift : (~cnt_zero) ? cnt_q - 1 : cnt_q;

  always_comb begin : p_fsm

    state_d    = state_q;
    in_rdy_o   = 1'b0;
    out_vld_o  = 1'b0;
    load_en    = 1'b0;
    a_reg_en   = 1'b0;
    b_reg_en   = 1'b0;
    res_reg_en = 1'b0;

    unique case (state_q)
      IDLE: begin
        in_rdy_o = 1'b1;

        if (in_vld_i) begin
          in_rdy_o = 1'b0;
          a_reg_en = 1'b1;
          b_reg_en = 1'b1;
          load_en  = 1'b1;
          state_d  = DIVIDE;
        end
      end
      DIVIDE: begin
        if (~div_res_zero_q) begin
          a_reg_en   = ab_comp;
          b_reg_en   = 1'b1;
          res_reg_en = 1'b1;
        end

        if (div_res_zero_q) begin
          out_vld_o = 1'b1;
          state_d   = FINISH;
          if (out_rdy_i) begin

            state_d = IDLE;
          end
        end else if (cnt_zero) begin
          state_d = FINISH;
        end
      end
      FINISH: begin
        out_vld_o = 1'b1;

        if (out_rdy_i) begin

          state_d = IDLE;
        end
      end
      default: state_d = IDLE;
    endcase

    if (flush_i) begin
      in_rdy_o  = 1'b0;
      out_vld_o = 1'b0;
      a_reg_en  = 1'b0;
      b_reg_en  = 1'b0;
      load_en   = 1'b0;
      state_d   = IDLE;
    end
  end

  assign rem_sel_d = (load_en) ? opcode_i[1] : rem_sel_q;
  assign comp_inv_d = (load_en) ? opcode_i[0] & op_b_sign : comp_inv_q;
  assign op_b_zero_d = (load_en) ? op_b_zero : op_b_zero_q;
  assign res_inv_d    = (load_en) ? (~op_b_zero | opcode_i[1]) & opcode_i[0] & (op_a_sign ^ op_b_sign) : res_inv_q;

  assign id_d = (load_en) ? id_i : id_q;
  assign id_o = id_q;

  assign op_a_d = (a_reg_en) ? add_out : op_a_q;
  assign op_b_d = (b_reg_en) ? b_mux : op_b_q;
  assign res_d = (load_en) ? '0 : (res_reg_en) ? {res_q[$high(res_q)-1:0], ab_comp} : res_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin : p_regs
    if (~rst_ni) begin
      state_q        <= IDLE;
      op_a_q         <= '0;
      op_b_q         <= '0;
      res_q          <= '0;
      cnt_q          <= '0;
      id_q           <= '0;
      rem_sel_q      <= 1'b0;
      comp_inv_q     <= 1'b0;
      res_inv_q      <= 1'b0;
      op_b_zero_q    <= 1'b0;
      div_res_zero_q <= 1'b0;
    end else begin
      state_q        <= state_d;
      op_a_q         <= op_a_d;
      op_b_q         <= op_b_d;
      res_q          <= res_d;
      cnt_q          <= cnt_d;
      id_q           <= id_d;
      rem_sel_q      <= rem_sel_d;
      comp_inv_q     <= comp_inv_d;
      res_inv_q      <= res_inv_d;
      op_b_zero_q    <= op_b_zero_d;
      div_res_zero_q <= div_res_zero_d;
    end
  end

endmodule


import ariane_pkg::*;
module mult (
    input  logic                         clk_i,
    input  logic                         rst_ni,
    input  logic                         flush_i,
    input  fu_data_t                     fu_data_i,
    input  logic                         mult_valid_i,
    output logic     [             63:0] result_o,
    output logic                         mult_valid_o,
    output logic                         mult_ready_o,
    output logic     [TRANS_ID_BITS-1:0] mult_trans_id_o
);
  logic                     mul_valid;
  logic                     div_valid;
  logic                     div_ready_i;
  logic [TRANS_ID_BITS-1:0] mul_trans_id;
  logic [TRANS_ID_BITS-1:0] div_trans_id;
  logic [             63:0] mul_result;
  logic [             63:0] div_result;

  logic                     div_valid_op;
  logic                     mul_valid_op;

  assign mul_valid_op = ~flush_i && mult_valid_i && (fu_data_i.operator inside { MUL, MULH, MULHU, MULHSU, MULW });
  assign div_valid_op = ~flush_i && mult_valid_i && (fu_data_i.operator inside { DIV, DIVU, DIVW, DIVUW, REM, REMU, REMW, REMUW });

  assign div_ready_i = (mul_valid) ? 1'b0 : 1'b1;
  assign mult_trans_id_o = (mul_valid) ? mul_trans_id : div_trans_id;
  assign result_o = (mul_valid) ? mul_result : div_result;
  assign mult_valid_o = div_valid | mul_valid;

  multiplier i_multiplier (
      .clk_i,
      .rst_ni,
      .trans_id_i     (fu_data_i.trans_id),
      .operator_i     (fu_data_i.operator),
      .operand_a_i    (fu_data_i.operand_a),
      .operand_b_i    (fu_data_i.operand_b),
      .result_o       (mul_result),
      .mult_valid_i   (mul_valid_op),
      .mult_valid_o   (mul_valid),
      .mult_trans_id_o(mul_trans_id),
      .mult_ready_o   ()
  );

  logic [63:0] operand_b, operand_a;
  logic [63:0] result;

  logic        div_signed;
  logic        rem;
  logic word_op_d, word_op_q;

  assign div_signed = fu_data_i.operator inside {DIV, DIVW, REM, REMW};

  assign rem        = fu_data_i.operator inside {REM, REMU, REMW, REMUW};

  always_comb begin

    operand_a = '0;
    operand_b = '0;

    word_op_d = word_op_q;

    if (mult_valid_i && fu_data_i.operator inside {DIV, DIVU, DIVW, DIVUW, REM, REMU, REMW, REMUW}) begin

      if (fu_data_i.operator inside {DIVW, DIVUW, REMW, REMUW}) begin

        if (div_signed) begin
          operand_a = sext32(fu_data_i.operand_a[31:0]);
          operand_b = sext32(fu_data_i.operand_b[31:0]);
        end else begin
          operand_a = fu_data_i.operand_a[31:0];
          operand_b = fu_data_i.operand_b[31:0];
        end

        word_op_d = 1'b1;
      end else begin

        operand_a = fu_data_i.operand_a;
        operand_b = fu_data_i.operand_b;
        word_op_d = 1'b0;
      end
    end
  end

  serdiv #(
      .WIDTH(64)
  ) i_div (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .id_i     (fu_data_i.trans_id),
      .op_a_i   (operand_a),
      .op_b_i   (operand_b),
      .opcode_i ({rem, div_signed}),
      .in_vld_i (div_valid_op),
      .in_rdy_o (mult_ready_o),
      .flush_i  (flush_i),
      .out_vld_o(div_valid),
      .out_rdy_i(div_ready_i),
      .id_o     (div_trans_id),
      .res_o    (result)
  );

  assign div_result = (word_op_q) ? sext32(result) : result;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      word_op_q <= '0;
    end else begin
      word_op_q <= word_op_d;
    end
  end
endmodule




module fpnew_classifier #(
    parameter fpnew_pkg::fp_format_e FpFormat    = fpnew_pkg::fp_format_e'(0),
    parameter int unsigned           NumOperands = 1,

    localparam int unsigned WIDTH = fpnew_pkg::fp_width(FpFormat)
) (
    input  logic                [NumOperands-1:0][WIDTH-1:0] operands_i,
    input  logic                [NumOperands-1:0]            is_boxed_i,
    output fpnew_pkg::fp_info_t [NumOperands-1:0]            info_o
);

  localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(FpFormat);
  localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(FpFormat);

  typedef struct packed {
    logic                sign;
    logic [EXP_BITS-1:0] exponent;
    logic [MAN_BITS-1:0] mantissa;
  } fp_t;

  for (genvar op = 0; op < int'(NumOperands); op++) begin : gen_num_values

    fp_t  value;
    logic is_boxed;
    logic is_normal;
    logic is_inf;
    logic is_nan;
    logic is_signalling;
    logic is_quiet;
    logic is_zero;
    logic is_subnormal;

    always_comb begin : classify_input
      value                    = operands_i[op];
      is_boxed                 = is_boxed_i[op];
      is_normal                = is_boxed && (value.exponent != '0) && (value.exponent != '1);
      is_zero                  = is_boxed && (value.exponent == '0) && (value.mantissa == '0);
      is_subnormal             = is_boxed && (value.exponent == '0) && !is_zero;
      is_inf                   = is_boxed && ((value.exponent == '1) && (value.mantissa == '0));
      is_nan                   = !is_boxed || ((value.exponent == '1) && (value.mantissa != '0));
      is_signalling            = is_boxed && is_nan && (value.mantissa[MAN_BITS-1] == 1'b0);
      is_quiet                 = is_nan && !is_signalling;

      info_o[op].is_normal     = is_normal;
      info_o[op].is_subnormal  = is_subnormal;
      info_o[op].is_zero       = is_zero;
      info_o[op].is_inf        = is_inf;
      info_o[op].is_nan        = is_nan;
      info_o[op].is_signalling = is_signalling;
      info_o[op].is_quiet      = is_quiet;
      info_o[op].is_boxed      = is_boxed;
    end
  end
endmodule




module fpnew_rounding #(
    parameter int unsigned AbsWidth = 2
) (

    input logic [AbsWidth-1:0] abs_value_i,
    input logic                sign_i,

    input logic                  [1:0] round_sticky_bits_i,
    input fpnew_pkg::roundmode_e       rnd_mode_i,
    input logic                        effective_subtraction_i,

    output logic [AbsWidth-1:0] abs_rounded_o,
    output logic                sign_o,

    output logic exact_zero_o
);

  logic round_up;

  always_comb begin : rounding_decision
    unique case (rnd_mode_i)
      fpnew_pkg::RNE:
      unique case (round_sticky_bits_i)
        2'b00, 2'b01: round_up = 1'b0;
        2'b10: round_up = abs_value_i[0];
        2'b11: round_up = 1'b1;
        default: round_up = fpnew_pkg::DONT_CARE;
      endcase
      fpnew_pkg::RTZ: round_up = 1'b0;
      fpnew_pkg::RDN: round_up = (|round_sticky_bits_i) ? sign_i : 1'b0;
      fpnew_pkg::RUP: round_up = (|round_sticky_bits_i) ? ~sign_i : 1'b0;
      fpnew_pkg::RMM: round_up = round_sticky_bits_i[1];
      fpnew_pkg::ROD: round_up = ~abs_value_i[0] & (|round_sticky_bits_i);
      default: round_up = fpnew_pkg::DONT_CARE;
    endcase
  end

  assign abs_rounded_o = abs_value_i + round_up;

  assign exact_zero_o = (abs_value_i == '0) && (round_sticky_bits_i == '0);

  assign sign_o = (exact_zero_o && effective_subtraction_i)
                  ? (rnd_mode_i == fpnew_pkg::RDN)
                  : sign_i;

endmodule





module fpnew_fma #(
  parameter fpnew_pkg::fp_format_e   FpFormat    = fpnew_pkg::fp_format_e'(0),
  parameter int unsigned             NumPipeRegs = 0,
  parameter fpnew_pkg::pipe_config_t PipeConfig  = fpnew_pkg::BEFORE,
  parameter type                     TagType     = logic,
  parameter type                     AuxType     = logic,

  localparam int unsigned WIDTH = fpnew_pkg::fp_width(FpFormat)
) (
  input logic                      clk_i,
  input logic                      rst_ni,

  input logic [2:0][WIDTH-1:0]     operands_i,
  input logic [2:0]                is_boxed_i,
  input fpnew_pkg::roundmode_e     rnd_mode_i,
  input fpnew_pkg::operation_e     op_i,
  input logic                      op_mod_i,
  input TagType                    tag_i,
  input logic                      mask_i,
  input AuxType                    aux_i,

  input  logic                     in_valid_i,
  output logic                     in_ready_o,
  input  logic                     flush_i,

  output logic [WIDTH-1:0]         result_o,
  output fpnew_pkg::status_t       status_o,
  output logic                     extension_bit_o,
  output TagType                   tag_o,
  output logic                     mask_o,
  output AuxType                   aux_o,

  output logic                     out_valid_o,
  input  logic                     out_ready_i,

  output logic                     busy_o
);

  localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(FpFormat);
  localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(FpFormat);
  localparam int unsigned BIAS     = fpnew_pkg::bias(FpFormat);

  localparam int unsigned PRECISION_BITS = MAN_BITS + 1;

  localparam int unsigned LOWER_SUM_WIDTH  = 2 * PRECISION_BITS + 3;
  localparam int unsigned LZC_RESULT_WIDTH = $clog2(LOWER_SUM_WIDTH);

  localparam int unsigned EXP_WIDTH = unsigned'(fpnew_pkg::maximum(EXP_BITS + 2, LZC_RESULT_WIDTH));

  localparam int unsigned SHIFT_AMOUNT_WIDTH = $clog2(3 * PRECISION_BITS + 5);

  localparam NUM_INP_REGS = PipeConfig == fpnew_pkg::BEFORE
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 3)
                               : 0);
  localparam NUM_MID_REGS = PipeConfig == fpnew_pkg::INSIDE
                          ? NumPipeRegs
                          : (PipeConfig == fpnew_pkg::DISTRIBUTED
                             ? ((NumPipeRegs + 2) / 3)
                             : 0);
  localparam NUM_OUT_REGS = PipeConfig == fpnew_pkg::AFTER
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 3)
                               : 0);

  typedef struct packed {
    logic                sign;
    logic [EXP_BITS-1:0] exponent;
    logic [MAN_BITS-1:0] mantissa;
  } fp_t;

  logic                  [0:NUM_INP_REGS][2:0][WIDTH-1:0] inp_pipe_operands_q;
  logic                  [0:NUM_INP_REGS][2:0]            inp_pipe_is_boxed_q;
  fpnew_pkg::roundmode_e [0:NUM_INP_REGS]                 inp_pipe_rnd_mode_q;
  fpnew_pkg::operation_e [0:NUM_INP_REGS]                 inp_pipe_op_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_op_mod_q;
  TagType                [0:NUM_INP_REGS]                 inp_pipe_tag_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_mask_q;
  AuxType                [0:NUM_INP_REGS]                 inp_pipe_aux_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_valid_q;

  logic [0:NUM_INP_REGS] inp_pipe_ready;

  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_is_boxed_q[0] = is_boxed_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_op_mod_q[0]   = op_mod_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;

  assign in_ready_o = inp_pipe_ready[0];

  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline

    logic reg_ena;

    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];

    `FFLARNC(inp_pipe_valid_q[i+1], inp_pipe_valid_q[i], inp_pipe_ready[i], flush_i, 1'b0, clk_i, rst_ni)

    assign reg_ena = inp_pipe_ready[i] & inp_pipe_valid_q[i];

    `FFL(inp_pipe_operands_q[i+1], inp_pipe_operands_q[i], reg_ena, '0)
    `FFL(inp_pipe_is_boxed_q[i+1], inp_pipe_is_boxed_q[i], reg_ena, '0)
    `FFL(inp_pipe_rnd_mode_q[i+1], inp_pipe_rnd_mode_q[i], reg_ena, fpnew_pkg::RNE)
    `FFL(inp_pipe_op_q[i+1],       inp_pipe_op_q[i],       reg_ena, fpnew_pkg::FMADD)
    `FFL(inp_pipe_op_mod_q[i+1],   inp_pipe_op_mod_q[i],   reg_ena, '0)
    `FFL(inp_pipe_tag_q[i+1],      inp_pipe_tag_q[i],      reg_ena, TagType'('0))
    `FFL(inp_pipe_mask_q[i+1],     inp_pipe_mask_q[i],     reg_ena, '0)
    `FFL(inp_pipe_aux_q[i+1],      inp_pipe_aux_q[i],      reg_ena, AuxType'('0))
  end

  fpnew_pkg::fp_info_t [2:0] info_q;

  fpnew_classifier #(
    .FpFormat    ( FpFormat ),
    .NumOperands ( 3        )
    ) i_class_inputs (
    .operands_i ( inp_pipe_operands_q[NUM_INP_REGS] ),
    .is_boxed_i ( inp_pipe_is_boxed_q[NUM_INP_REGS] ),
    .info_o     ( info_q                            )
  );

  fp_t                 operand_a, operand_b, operand_c;
  fpnew_pkg::fp_info_t info_a,    info_b,    info_c;

  always_comb begin : op_select

    operand_a = inp_pipe_operands_q[NUM_INP_REGS][0];
    operand_b = inp_pipe_operands_q[NUM_INP_REGS][1];
    operand_c = inp_pipe_operands_q[NUM_INP_REGS][2];
    info_a    = info_q[0];
    info_b    = info_q[1];
    info_c    = info_q[2];

    operand_c.sign = operand_c.sign ^ inp_pipe_op_mod_q[NUM_INP_REGS];

    unique case (inp_pipe_op_q[NUM_INP_REGS])
      fpnew_pkg::FMADD:  ;
      fpnew_pkg::FNMSUB: operand_a.sign = ~operand_a.sign;
      fpnew_pkg::ADD: begin
        operand_a = '{sign: 1'b0, exponent: BIAS, mantissa: '0};
        info_a    = '{is_normal: 1'b1, is_boxed: 1'b1, default: 1'b0};
      end
      fpnew_pkg::MUL: begin
        if (inp_pipe_rnd_mode_q[NUM_INP_REGS] == fpnew_pkg::RDN)
          operand_c = '{sign: 1'b0, exponent: '0, mantissa: '0};
        else
          operand_c = '{sign: 1'b1, exponent: '0, mantissa: '0};
        info_c    = '{is_zero: 1'b1, is_boxed: 1'b1, default: 1'b0};
      end
      default: begin
        operand_a  = '{default: fpnew_pkg::DONT_CARE};
        operand_b  = '{default: fpnew_pkg::DONT_CARE};
        operand_c  = '{default: fpnew_pkg::DONT_CARE};
        info_a     = '{default: fpnew_pkg::DONT_CARE};
        info_b     = '{default: fpnew_pkg::DONT_CARE};
        info_c     = '{default: fpnew_pkg::DONT_CARE};
      end
    endcase
  end

  logic any_operand_inf;
  logic any_operand_nan;
  logic signalling_nan;
  logic effective_subtraction;
  logic tentative_sign;

  assign any_operand_inf = (| {info_a.is_inf,        info_b.is_inf,        info_c.is_inf});
  assign any_operand_nan = (| {info_a.is_nan,        info_b.is_nan,        info_c.is_nan});
  assign signalling_nan  = (| {info_a.is_signalling, info_b.is_signalling, info_c.is_signalling});

  assign effective_subtraction = operand_a.sign ^ operand_b.sign ^ operand_c.sign;

  assign tentative_sign = operand_a.sign ^ operand_b.sign;

  fp_t                special_result;
  fpnew_pkg::status_t special_status;
  logic               result_is_special;

  always_comb begin : special_cases

    special_result    = '{sign: 1'b0, exponent: '1, mantissa: 2**(MAN_BITS-1)};
    special_status    = '0;
    result_is_special = 1'b0;

    if ((info_a.is_inf && info_b.is_zero) || (info_a.is_zero && info_b.is_inf)) begin
      result_is_special = 1'b1;
      special_status.NV = 1'b1;

    end else if (any_operand_nan) begin
      result_is_special = 1'b1;
      special_status.NV = signalling_nan;

    end else if (any_operand_inf) begin
      result_is_special = 1'b1;

      if ((info_a.is_inf || info_b.is_inf) && info_c.is_inf && effective_subtraction)
        special_status.NV = 1'b1;

      else if (info_a.is_inf || info_b.is_inf) begin

        special_result    = '{sign: operand_a.sign ^ operand_b.sign, exponent: '1, mantissa: '0};

      end else if (info_c.is_inf) begin

        special_result    = '{sign: operand_c.sign, exponent: '1, mantissa: '0};
      end
    end
  end

  logic signed [EXP_WIDTH-1:0] exponent_a, exponent_b, exponent_c;
  logic signed [EXP_WIDTH-1:0] exponent_addend, exponent_product, exponent_difference;
  logic signed [EXP_WIDTH-1:0] tentative_exponent;

  assign exponent_a = signed'({1'b0, operand_a.exponent});
  assign exponent_b = signed'({1'b0, operand_b.exponent});
  assign exponent_c = signed'({1'b0, operand_c.exponent});

  assign exponent_addend = signed'(exponent_c + $signed({1'b0, ~info_c.is_normal}));

  assign exponent_product = (info_a.is_zero || info_b.is_zero)
                            ? 2 - signed'(BIAS)
                            : signed'(exponent_a + info_a.is_subnormal
                                      + exponent_b + info_b.is_subnormal
                                      - signed'(BIAS));

  assign exponent_difference = exponent_addend - exponent_product;

  assign tentative_exponent = (exponent_difference > 0) ? exponent_addend : exponent_product;

  logic [SHIFT_AMOUNT_WIDTH-1:0] addend_shamt;

  always_comb begin : addend_shift_amount

    if (exponent_difference <= signed'(-2 * PRECISION_BITS - 1))
      addend_shamt = 3 * PRECISION_BITS + 4;

    else if (exponent_difference <= signed'(PRECISION_BITS + 2))
      addend_shamt = unsigned'(signed'(PRECISION_BITS) + 3 - exponent_difference);

    else
      addend_shamt = 0;
  end

  logic [PRECISION_BITS-1:0]   mantissa_a, mantissa_b, mantissa_c;
  logic [2*PRECISION_BITS-1:0] product;
  logic [3*PRECISION_BITS+3:0] product_shifted;

  assign mantissa_a = {info_a.is_normal, operand_a.mantissa};
  assign mantissa_b = {info_b.is_normal, operand_b.mantissa};
  assign mantissa_c = {info_c.is_normal, operand_c.mantissa};

  assign product = mantissa_a * mantissa_b;

  assign product_shifted = product << 2;

  logic [3*PRECISION_BITS+3:0] addend_after_shift;
  logic [PRECISION_BITS-1:0]   addend_sticky_bits;
  logic                        sticky_before_add;
  logic [3*PRECISION_BITS+3:0] addend_shifted;
  logic                        inject_carry_in;

  assign {addend_after_shift, addend_sticky_bits} =
      (mantissa_c << (3 * PRECISION_BITS + 4)) >> addend_shamt;

  assign sticky_before_add     = (| addend_sticky_bits);

  assign addend_shifted  = (effective_subtraction) ? ~addend_after_shift : addend_after_shift;
  assign inject_carry_in = effective_subtraction & ~sticky_before_add;

  logic [3*PRECISION_BITS+4:0] sum_raw;
  logic                        sum_carry;
  logic [3*PRECISION_BITS+3:0] sum;
  logic                        final_sign;

  assign sum_raw = product_shifted + addend_shifted + inject_carry_in;
  assign sum_carry = sum_raw[3*PRECISION_BITS+4];

  assign sum        = (effective_subtraction && ~sum_carry) ? -sum_raw : sum_raw;

  assign final_sign = (effective_subtraction && (sum_carry == tentative_sign))
                      ? 1'b1
                      : (effective_subtraction ? 1'b0 : tentative_sign);

  logic                          effective_subtraction_q;
  logic signed [EXP_WIDTH-1:0]   exponent_product_q;
  logic signed [EXP_WIDTH-1:0]   exponent_difference_q;
  logic signed [EXP_WIDTH-1:0]   tentative_exponent_q;
  logic [SHIFT_AMOUNT_WIDTH-1:0] addend_shamt_q;
  logic                          sticky_before_add_q;
  logic [3*PRECISION_BITS+3:0]   sum_q;
  logic                          final_sign_q;
  fpnew_pkg::roundmode_e         rnd_mode_q;
  logic                          result_is_special_q;
  fp_t                           special_result_q;
  fpnew_pkg::status_t            special_status_q;

  logic                  [0:NUM_MID_REGS]                         mid_pipe_eff_sub_q;
  logic signed           [0:NUM_MID_REGS][EXP_WIDTH-1:0]          mid_pipe_exp_prod_q;
  logic signed           [0:NUM_MID_REGS][EXP_WIDTH-1:0]          mid_pipe_exp_diff_q;
  logic signed           [0:NUM_MID_REGS][EXP_WIDTH-1:0]          mid_pipe_tent_exp_q;
  logic                  [0:NUM_MID_REGS][SHIFT_AMOUNT_WIDTH-1:0] mid_pipe_add_shamt_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_sticky_q;
  logic                  [0:NUM_MID_REGS][3*PRECISION_BITS+3:0]   mid_pipe_sum_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_final_sign_q;
  fpnew_pkg::roundmode_e [0:NUM_MID_REGS]                         mid_pipe_rnd_mode_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_res_is_spec_q;
  fp_t                   [0:NUM_MID_REGS]                         mid_pipe_spec_res_q;
  fpnew_pkg::status_t    [0:NUM_MID_REGS]                         mid_pipe_spec_stat_q;
  TagType                [0:NUM_MID_REGS]                         mid_pipe_tag_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_mask_q;
  AuxType                [0:NUM_MID_REGS]                         mid_pipe_aux_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_valid_q;

  logic [0:NUM_MID_REGS] mid_pipe_ready;

  assign mid_pipe_eff_sub_q[0]     = effective_subtraction;
  assign mid_pipe_exp_prod_q[0]    = exponent_product;
  assign mid_pipe_exp_diff_q[0]    = exponent_difference;
  assign mid_pipe_tent_exp_q[0]    = tentative_exponent;
  assign mid_pipe_add_shamt_q[0]   = addend_shamt;
  assign mid_pipe_sticky_q[0]      = sticky_before_add;
  assign mid_pipe_sum_q[0]         = sum;
  assign mid_pipe_final_sign_q[0]  = final_sign;
  assign mid_pipe_rnd_mode_q[0]    = inp_pipe_rnd_mode_q[NUM_INP_REGS];
  assign mid_pipe_res_is_spec_q[0] = result_is_special;
  assign mid_pipe_spec_res_q[0]    = special_result;
  assign mid_pipe_spec_stat_q[0]   = special_status;
  assign mid_pipe_tag_q[0]         = inp_pipe_tag_q[NUM_INP_REGS];
  assign mid_pipe_mask_q[0]        = inp_pipe_mask_q[NUM_INP_REGS];
  assign mid_pipe_aux_q[0]         = inp_pipe_aux_q[NUM_INP_REGS];
  assign mid_pipe_valid_q[0]       = inp_pipe_valid_q[NUM_INP_REGS];

  assign inp_pipe_ready[NUM_INP_REGS] = mid_pipe_ready[0];

  for (genvar i = 0; i < NUM_MID_REGS; i++) begin : gen_inside_pipeline

    logic reg_ena;

    assign mid_pipe_ready[i] = mid_pipe_ready[i+1] | ~mid_pipe_valid_q[i+1];

    `FFLARNC(mid_pipe_valid_q[i+1], mid_pipe_valid_q[i], mid_pipe_ready[i], flush_i, 1'b0, clk_i, rst_ni)

    assign reg_ena = mid_pipe_ready[i] & mid_pipe_valid_q[i];

    `FFL(mid_pipe_eff_sub_q[i+1],     mid_pipe_eff_sub_q[i],     reg_ena, '0)
    `FFL(mid_pipe_exp_prod_q[i+1],    mid_pipe_exp_prod_q[i],    reg_ena, '0)
    `FFL(mid_pipe_exp_diff_q[i+1],    mid_pipe_exp_diff_q[i],    reg_ena, '0)
    `FFL(mid_pipe_tent_exp_q[i+1],    mid_pipe_tent_exp_q[i],    reg_ena, '0)
    `FFL(mid_pipe_add_shamt_q[i+1],   mid_pipe_add_shamt_q[i],   reg_ena, '0)
    `FFL(mid_pipe_sticky_q[i+1],      mid_pipe_sticky_q[i],      reg_ena, '0)
    `FFL(mid_pipe_sum_q[i+1],         mid_pipe_sum_q[i],         reg_ena, '0)
    `FFL(mid_pipe_final_sign_q[i+1],  mid_pipe_final_sign_q[i],  reg_ena, '0)
    `FFL(mid_pipe_rnd_mode_q[i+1],    mid_pipe_rnd_mode_q[i],    reg_ena, fpnew_pkg::RNE)
    `FFL(mid_pipe_res_is_spec_q[i+1], mid_pipe_res_is_spec_q[i], reg_ena, '0)
    `FFL(mid_pipe_spec_res_q[i+1],    mid_pipe_spec_res_q[i],    reg_ena, '0)
    `FFL(mid_pipe_spec_stat_q[i+1],   mid_pipe_spec_stat_q[i],   reg_ena, '0)
    `FFL(mid_pipe_tag_q[i+1],         mid_pipe_tag_q[i],         reg_ena, TagType'('0))
    `FFL(mid_pipe_mask_q[i+1],        mid_pipe_mask_q[i],        reg_ena, '0)
    `FFL(mid_pipe_aux_q[i+1],         mid_pipe_aux_q[i],         reg_ena, AuxType'('0))
  end

  assign effective_subtraction_q = mid_pipe_eff_sub_q[NUM_MID_REGS];
  assign exponent_product_q      = mid_pipe_exp_prod_q[NUM_MID_REGS];
  assign exponent_difference_q   = mid_pipe_exp_diff_q[NUM_MID_REGS];
  assign tentative_exponent_q    = mid_pipe_tent_exp_q[NUM_MID_REGS];
  assign addend_shamt_q          = mid_pipe_add_shamt_q[NUM_MID_REGS];
  assign sticky_before_add_q     = mid_pipe_sticky_q[NUM_MID_REGS];
  assign sum_q                   = mid_pipe_sum_q[NUM_MID_REGS];
  assign final_sign_q            = mid_pipe_final_sign_q[NUM_MID_REGS];
  assign rnd_mode_q              = mid_pipe_rnd_mode_q[NUM_MID_REGS];
  assign result_is_special_q     = mid_pipe_res_is_spec_q[NUM_MID_REGS];
  assign special_result_q        = mid_pipe_spec_res_q[NUM_MID_REGS];
  assign special_status_q        = mid_pipe_spec_stat_q[NUM_MID_REGS];

  logic        [LOWER_SUM_WIDTH-1:0]  sum_lower;
  logic        [LZC_RESULT_WIDTH-1:0] leading_zero_count;
  logic signed [LZC_RESULT_WIDTH:0]   leading_zero_count_sgn;
  logic                               lzc_zeroes;

  logic        [SHIFT_AMOUNT_WIDTH-1:0] norm_shamt;
  logic signed [EXP_WIDTH-1:0]          normalized_exponent;

  logic [3*PRECISION_BITS+4:0] sum_shifted;
  logic [PRECISION_BITS:0]     final_mantissa;
  logic [2*PRECISION_BITS+2:0] sum_sticky_bits;
  logic                        sticky_after_norm;

  logic signed [EXP_WIDTH-1:0] final_exponent;

  assign sum_lower = sum_q[LOWER_SUM_WIDTH-1:0];

  lzc #(
    .WIDTH ( LOWER_SUM_WIDTH ),
    .MODE  ( 1               )
  ) i_lzc (
    .in_i    ( sum_lower          ),
    .cnt_o   ( leading_zero_count ),
    .empty_o ( lzc_zeroes         )
  );

  assign leading_zero_count_sgn = signed'({1'b0, leading_zero_count});

  always_comb begin : norm_shift_amount

    if ((exponent_difference_q <= 0) || (effective_subtraction_q && (exponent_difference_q <= 2))) begin

      if ((exponent_product_q - leading_zero_count_sgn + 1 >= 0) && !lzc_zeroes) begin

        norm_shamt          = PRECISION_BITS + 2 + leading_zero_count;
        normalized_exponent = exponent_product_q - leading_zero_count_sgn + 1;

      end else begin

        norm_shamt          = unsigned'(signed'(PRECISION_BITS) + 2 + exponent_product_q);
        normalized_exponent = 0;
      end

    end else begin
      norm_shamt          = addend_shamt_q;
      normalized_exponent = tentative_exponent_q;
    end
  end

  assign sum_shifted       = sum_q << norm_shamt;

  always_comb begin : small_norm

    {final_mantissa, sum_sticky_bits} = sum_shifted;
    final_exponent                    = normalized_exponent;

    if (sum_shifted[3*PRECISION_BITS+4]) begin
      {final_mantissa, sum_sticky_bits} = sum_shifted >> 1;
      final_exponent                    = normalized_exponent + 1;

    end else if (sum_shifted[3*PRECISION_BITS+3]) begin

    end else if (normalized_exponent > 1) begin
      {final_mantissa, sum_sticky_bits} = sum_shifted << 1;
      final_exponent                    = normalized_exponent - 1;

    end else begin
      final_exponent = '0;
    end
  end

  assign sticky_after_norm = (| {sum_sticky_bits}) | sticky_before_add_q;

  logic                         pre_round_sign;
  logic [EXP_BITS-1:0]          pre_round_exponent;
  logic [MAN_BITS-1:0]          pre_round_mantissa;
  logic [EXP_BITS+MAN_BITS-1:0] pre_round_abs;
  logic [1:0]                   round_sticky_bits;

  logic of_before_round, of_after_round;
  logic uf_before_round, uf_after_round;
  logic result_zero;

  logic                         rounded_sign;
  logic [EXP_BITS+MAN_BITS-1:0] rounded_abs;

  assign of_before_round = final_exponent >= 2**(EXP_BITS)-1;
  assign uf_before_round = final_exponent == 0;

  assign pre_round_sign     = final_sign_q;
  assign pre_round_exponent = (of_before_round) ? 2**EXP_BITS-2 : unsigned'(final_exponent[EXP_BITS-1:0]);
  assign pre_round_mantissa = (of_before_round) ? '1 : final_mantissa[MAN_BITS:1];
  assign pre_round_abs      = {pre_round_exponent, pre_round_mantissa};

  assign round_sticky_bits  = (of_before_round) ? 2'b11 : {final_mantissa[0], sticky_after_norm};

  fpnew_rounding #(
    .AbsWidth ( EXP_BITS + MAN_BITS )
  ) i_fpnew_rounding (
    .abs_value_i             ( pre_round_abs           ),
    .sign_i                  ( pre_round_sign          ),
    .round_sticky_bits_i     ( round_sticky_bits       ),
    .rnd_mode_i              ( rnd_mode_q              ),
    .effective_subtraction_i ( effective_subtraction_q ),
    .abs_rounded_o           ( rounded_abs             ),
    .sign_o                  ( rounded_sign            ),
    .exact_zero_o            ( result_zero             )
  );

  assign uf_after_round = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '0;
  assign of_after_round = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '1;

  logic [WIDTH-1:0]     regular_result;
  fpnew_pkg::status_t   regular_status;

  assign regular_result    = {rounded_sign, rounded_abs};
  assign regular_status.NV = 1'b0;
  assign regular_status.DZ = 1'b0;
  assign regular_status.OF = of_before_round | of_after_round;
  assign regular_status.UF = uf_after_round & regular_status.NX;
  assign regular_status.NX = (| round_sticky_bits) | of_before_round | of_after_round;

  fp_t                result_d;
  fpnew_pkg::status_t status_d;

  assign result_d = result_is_special_q ? special_result_q : regular_result;
  assign status_d = result_is_special_q ? special_status_q : regular_status;

  fp_t                [0:NUM_OUT_REGS] out_pipe_result_q;
  fpnew_pkg::status_t [0:NUM_OUT_REGS] out_pipe_status_q;
  TagType             [0:NUM_OUT_REGS] out_pipe_tag_q;
  logic               [0:NUM_OUT_REGS] out_pipe_mask_q;
  AuxType             [0:NUM_OUT_REGS] out_pipe_aux_q;
  logic               [0:NUM_OUT_REGS] out_pipe_valid_q;

  logic [0:NUM_OUT_REGS] out_pipe_ready;

  assign out_pipe_result_q[0] = result_d;
  assign out_pipe_status_q[0] = status_d;
  assign out_pipe_tag_q[0]    = mid_pipe_tag_q[NUM_MID_REGS];
  assign out_pipe_mask_q[0]   = mid_pipe_mask_q[NUM_MID_REGS];
  assign out_pipe_aux_q[0]    = mid_pipe_aux_q[NUM_MID_REGS];
  assign out_pipe_valid_q[0]  = mid_pipe_valid_q[NUM_MID_REGS];

  assign mid_pipe_ready[NUM_MID_REGS] = out_pipe_ready[0];

  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline

    logic reg_ena;

    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];

    `FFLARNC(out_pipe_valid_q[i+1], out_pipe_valid_q[i], out_pipe_ready[i], flush_i, 1'b0, clk_i, rst_ni)

    assign reg_ena = out_pipe_ready[i] & out_pipe_valid_q[i];

    `FFL(out_pipe_result_q[i+1], out_pipe_result_q[i], reg_ena, '0)
    `FFL(out_pipe_status_q[i+1], out_pipe_status_q[i], reg_ena, '0)
    `FFL(out_pipe_tag_q[i+1],    out_pipe_tag_q[i],    reg_ena, TagType'('0))
    `FFL(out_pipe_mask_q[i+1],   out_pipe_mask_q[i],   reg_ena, '0)
    `FFL(out_pipe_aux_q[i+1],    out_pipe_aux_q[i],    reg_ena, AuxType'('0))
  end

  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;

  assign result_o        = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o        = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o = 1'b1;
  assign tag_o           = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o          = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o           = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o     = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o          = (| {inp_pipe_valid_q, mid_pipe_valid_q, out_pipe_valid_q});
endmodule




module fpnew_opgroup_fmt_slice #(
    parameter fpnew_pkg::opgroup_e   OpGroup  = fpnew_pkg::ADDMUL,
    parameter fpnew_pkg::fp_format_e FpFormat = fpnew_pkg::fp_format_e'(0),

    parameter int unsigned             Width         = 32,
    parameter logic                    EnableVectors = 1'b1,
    parameter int unsigned             NumPipeRegs   = 0,
    parameter fpnew_pkg::pipe_config_t PipeConfig    = fpnew_pkg::BEFORE,
    parameter type                     TagType       = logic,
    parameter int unsigned             TrueSIMDClass = 0,

    localparam int unsigned NUM_OPERANDS = fpnew_pkg::num_operands(OpGroup),
    localparam int unsigned NUM_LANES = fpnew_pkg::num_lanes(Width, FpFormat, EnableVectors),
    localparam type MaskType = logic [NUM_LANES-1:0]
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                  [NUM_OPERANDS-1:0][Width-1:0] operands_i,
    input logic                  [NUM_OPERANDS-1:0]            is_boxed_i,
    input fpnew_pkg::roundmode_e                               rnd_mode_i,
    input fpnew_pkg::operation_e                               op_i,
    input logic                                                op_mod_i,
    input logic                                                vectorial_op_i,
    input TagType                                              tag_i,
    input MaskType                                             simd_mask_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,

    output logic               [Width-1:0] result_o,
    output fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(FpFormat);
  localparam int unsigned SIMD_WIDTH = unsigned'(Width / NUM_LANES);
  logic [NUM_LANES-1:0] lane_in_ready, lane_out_valid;
  logic                          vectorial_op;

  logic [NUM_LANES*FP_WIDTH-1:0] slice_result;
  logic [Width-1:0] slice_regular_result, slice_class_result, slice_vec_class_result;

  fpnew_pkg::status_t    [NUM_LANES-1:0] lane_status;
  logic                  [NUM_LANES-1:0] lane_ext_bit;
  fpnew_pkg::classmask_e [NUM_LANES-1:0] lane_class_mask;
  TagType                [NUM_LANES-1:0] lane_tags;
  logic                  [NUM_LANES-1:0] lane_masks;
  logic [NUM_LANES-1:0] lane_vectorial, lane_busy, lane_is_class;

  logic result_is_vector, result_is_class;

  assign in_ready_o   = lane_in_ready[0];
  assign vectorial_op = vectorial_op_i & EnableVectors;

  for (genvar lane = 0; lane < int'(NUM_LANES); lane++) begin : gen_num_lanes
    logic [FP_WIDTH-1:0] local_result;
    logic                local_sign;

    if ((lane == 0) || EnableVectors) begin : active_lane
      logic in_valid, out_valid, out_ready;

      logic               [NUM_OPERANDS-1:0][FP_WIDTH-1:0] local_operands;
      logic               [    FP_WIDTH-1:0]               op_result;
      fpnew_pkg::status_t                                  op_status;

      assign in_valid = in_valid_i & ((lane == 0) | vectorial_op);

      always_comb begin : prepare_input
        for (int i = 0; i < int'(NUM_OPERANDS); i++) begin
          local_operands[i] = operands_i[i][(unsigned'(lane)+1)*FP_WIDTH-1:unsigned'(lane)*FP_WIDTH];
        end
      end

      if (OpGroup == fpnew_pkg::ADDMUL) begin : lane_instance
        fpnew_fma #(
            .FpFormat   (FpFormat),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic)
        ) i_fma (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands),
            .is_boxed_i     (is_boxed_i[NUM_OPERANDS-1:0]),
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (vectorial_op),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_vectorial[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane])
        );
        assign lane_is_class[lane]   = 1'b0;
        assign lane_class_mask[lane] = fpnew_pkg::NEGINF;
      end else
      if (OpGroup == fpnew_pkg::DIVSQRT) begin : lane_instance

      end else if (OpGroup == fpnew_pkg::NONCOMP) begin : lane_instance
        fpnew_noncomp #(
            .FpFormat   (FpFormat),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic)
        ) i_noncomp (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands),
            .is_boxed_i     (is_boxed_i[NUM_OPERANDS-1:0]),
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (vectorial_op),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .class_mask_o   (lane_class_mask[lane]),
            .is_class_o     (lane_is_class[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_vectorial[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane])
        );
      end

      assign out_ready            = out_ready_i & ((lane == 0) | result_is_vector);
      assign lane_out_valid[lane] = out_valid & ((lane == 0) | result_is_vector);

      assign local_result         = lane_out_valid[lane] ? op_result : '{default: lane_ext_bit[0]};
      assign lane_status[lane]    = lane_out_valid[lane] ? op_status : '0;

    end else begin
      assign lane_out_valid[lane] = 1'b0;
      assign lane_in_ready[lane]  = 1'b0;
      assign local_result         = '{default: lane_ext_bit[0]};
      assign lane_status[lane]    = '0;
      assign lane_busy[lane]      = 1'b0;
      assign lane_is_class[lane]  = 1'b0;
    end

    assign slice_result[(unsigned'(lane)+1)*FP_WIDTH-1:unsigned'(lane)*FP_WIDTH] = local_result;

    if (TrueSIMDClass && SIMD_WIDTH >= 10) begin : vectorial_true_class
      assign slice_vec_class_result[lane*SIMD_WIDTH+:10] = lane_class_mask[lane];
      assign slice_vec_class_result[(lane+1)*SIMD_WIDTH-1-:SIMD_WIDTH-10] = '0;
    end else if ((lane + 1) * 8 <= Width) begin : vectorial_class
      assign local_sign = (lane_class_mask[lane] == fpnew_pkg::NEGINF ||
                           lane_class_mask[lane] == fpnew_pkg::NEGNORM ||
                           lane_class_mask[lane] == fpnew_pkg::NEGSUBNORM ||
                           lane_class_mask[lane] == fpnew_pkg::NEGZERO);

      assign slice_vec_class_result[(lane+1)*8-1:lane*8] = {
        local_sign,
        ~local_sign,
        lane_class_mask[lane] == fpnew_pkg::QNAN,
        lane_class_mask[lane] == fpnew_pkg::SNAN,
        lane_class_mask[lane] == fpnew_pkg::POSZERO || lane_class_mask[lane] == fpnew_pkg::NEGZERO,
        lane_class_mask[lane] == fpnew_pkg::POSSUBNORM
            || lane_class_mask[lane] == fpnew_pkg::NEGSUBNORM,
        lane_class_mask[lane] == fpnew_pkg::POSNORM || lane_class_mask[lane] == fpnew_pkg::NEGNORM,
        lane_class_mask[lane] == fpnew_pkg::POSINF || lane_class_mask[lane] == fpnew_pkg::NEGINF
      };
    end
  end

  assign result_is_vector = lane_vectorial[0];
  assign result_is_class = lane_is_class[0];

  assign slice_regular_result = $signed({extension_bit_o, slice_result});

  localparam int unsigned CLASS_VEC_BITS = (NUM_LANES*8 > Width) ? 8 * (Width / 8) : NUM_LANES*8;

  if (!(TrueSIMDClass && SIMD_WIDTH >= 10)) begin
    if (CLASS_VEC_BITS < Width) begin : pad_vectorial_class
      assign slice_vec_class_result[Width-1:CLASS_VEC_BITS] = '0;
    end
  end

  assign slice_class_result = result_is_vector ? slice_vec_class_result : lane_class_mask[0];

  assign result_o           = result_is_class ? slice_class_result : slice_regular_result;

  assign extension_bit_o    = lane_ext_bit[0];
  assign tag_o              = lane_tags[0];
  assign busy_o             = (|lane_busy);
  assign out_valid_o        = lane_out_valid[0];

  always_comb begin : output_processing

    automatic fpnew_pkg::status_t temp_status;
    temp_status = '0;
    for (int i = 0; i < int'(NUM_LANES); i++) temp_status |= lane_status[i] & {5{lane_masks[i]}};
    status_o = temp_status;
  end
endmodule


module rr_arb_tree #(
    parameter int unsigned NumIn = 64,
    parameter int unsigned DataWidth = 32,
    parameter type DataType = logic [DataWidth-1:0],
    parameter bit ExtPrio = 1'b0,
    parameter bit AxiVldRdy = 1'b0,
    parameter bit LockIn = 1'b0,
    parameter bit FairArb = 1'b1,
    parameter int unsigned IdxWidth = (NumIn > 32'd1) ? unsigned'($clog2(NumIn)) : 32'd1,
    parameter type idx_t = logic [IdxWidth-1:0]
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input idx_t rr_i,
    input logic [NumIn-1:0] req_i,
    output logic [NumIn-1:0] gnt_o,
    input DataType [NumIn-1:0] data_i,
    output logic req_o,
    input logic gnt_i,
    output DataType data_o,
    output idx_t idx_o
);

  if (NumIn == unsigned'(1)) begin : gen_pass_through
    assign req_o    = req_i[0];
    assign gnt_o[0] = gnt_i;
    assign data_o   = data_i[0];
    assign idx_o    = '0;

  end else begin : gen_arbiter
    localparam int unsigned NumLevels = unsigned'($clog2(NumIn));

    idx_t    [2**NumLevels-2:0] index_nodes;
    DataType [2**NumLevels-2:0] data_nodes;
    logic    [2**NumLevels-2:0] gnt_nodes;
    logic    [2**NumLevels-2:0] req_nodes;
    idx_t                       rr_q;
    logic    [       NumIn-1:0] req_d;

    assign req_o  = req_nodes[0];
    assign data_o = data_nodes[0];
    assign idx_o  = index_nodes[0];

    if (ExtPrio) begin : gen_ext_rr
      assign rr_q  = rr_i;
      assign req_d = req_i;
    end else begin : gen_int_rr
      idx_t rr_d;

      if (LockIn) begin : gen_lock
        logic lock_d, lock_q;
        logic [NumIn-1:0] req_q;

        assign lock_d = req_o & ~gnt_i;
        assign req_d  = (lock_q) ? req_q : req_i;

        always_ff @(posedge clk_i or negedge rst_ni) begin : p_lock_reg
          if (!rst_ni) begin
            lock_q <= '0;
          end else begin
            if (flush_i) begin
              lock_q <= '0;
            end else begin
              lock_q <= lock_d;
            end
          end
        end

        always_ff @(posedge clk_i or negedge rst_ni) begin : p_req_regs
          if (!rst_ni) begin
            req_q <= '0;
          end else begin
            if (flush_i) begin
              req_q <= '0;
            end else begin
              req_q <= req_d;
            end
          end
        end
      end else begin : gen_no_lock
        assign req_d = req_i;
      end

      if (FairArb) begin : gen_fair_arb
        logic [NumIn-1:0] upper_mask, lower_mask;
        idx_t upper_idx, lower_idx, next_idx;
        logic upper_empty, lower_empty;

        for (genvar i = 0; i < NumIn; i++) begin : gen_mask
          assign upper_mask[i] = (i > rr_q) ? req_d[i] : 1'b0;
          assign lower_mask[i] = (i <= rr_q) ? req_d[i] : 1'b0;
        end

        lzc #(
            .WIDTH(NumIn),
            .MODE (1'b0)
        ) i_lzc_upper (
            .in_i   (upper_mask),
            .cnt_o  (upper_idx),
            .empty_o(upper_empty)
        );

        lzc #(
            .WIDTH(NumIn),
            .MODE (1'b0)
        ) i_lzc_lower (
            .in_i   (lower_mask),
            .cnt_o  (lower_idx),
            .empty_o()
        );

        assign next_idx = upper_empty ? lower_idx : upper_idx;
        assign rr_d     = (gnt_i && req_o) ? next_idx : rr_q;

      end else begin : gen_unfair_arb
        assign rr_d = (gnt_i && req_o) ? ((rr_q == idx_t'(NumIn - 1)) ? '0 : rr_q + 1'b1) : rr_q;
      end

      always_ff @(posedge clk_i or negedge rst_ni) begin : p_rr_regs
        if (!rst_ni) begin
          rr_q <= '0;
        end else begin
          if (flush_i) begin
            rr_q <= '0;
          end else begin
            rr_q <= rr_d;
          end
        end
      end
    end

    assign gnt_nodes[0] = gnt_i;

    for (genvar level = 0; unsigned'(level) < NumLevels; level++) begin : gen_levels
      for (genvar l = 0; l < 2 ** level; l++) begin : gen_level

        logic sel;

        localparam int unsigned Idx0 = 2 ** level - 1 + l;
        localparam int unsigned Idx1 = 2 ** (level + 1) - 1 + l * 2;

        if (unsigned'(level) == NumLevels - 1) begin : gen_first_level

          if (unsigned'(l) * 2 < NumIn - 1) begin : gen_reduce
            assign req_nodes[Idx0]   = req_d[l*2] | req_d[l*2+1];

            assign sel               = ~req_d[l*2] | req_d[l*2+1] & rr_q[NumLevels-1-level];

            assign index_nodes[Idx0] = idx_t'(sel);
            assign data_nodes[Idx0]  = (sel) ? data_i[l*2+1] : data_i[l*2];
            assign gnt_o[l*2]        = gnt_nodes[Idx0] & (AxiVldRdy | req_d[l*2]) & ~sel;
            assign gnt_o[l*2+1]      = gnt_nodes[Idx0] & (AxiVldRdy | req_d[l*2+1]) & sel;
          end

          if (unsigned'(l) * 2 == NumIn - 1) begin : gen_first
            assign req_nodes[Idx0]   = req_d[l*2];
            assign index_nodes[Idx0] = '0;
            assign data_nodes[Idx0]  = data_i[l*2];
            assign gnt_o[l*2]        = gnt_nodes[Idx0] & (AxiVldRdy | req_d[l*2]);
          end

          if (unsigned'(l) * 2 > NumIn - 1) begin : gen_out_of_range
            assign req_nodes[Idx0]   = 1'b0;
            assign index_nodes[Idx0] = idx_t'('0);
            assign data_nodes[Idx0]  = DataType'('0);
          end

        end else begin : gen_other_levels
          assign req_nodes[Idx0] = req_nodes[Idx1] | req_nodes[Idx1+1];

          assign sel = ~req_nodes[Idx1] | req_nodes[Idx1+1] & rr_q[NumLevels-1-level];

          assign index_nodes[Idx0] = (sel) ?
            idx_t'({1'b1, index_nodes[Idx1+1][NumLevels-unsigned'(level)-2:0]}) :
            idx_t'({1'b0, index_nodes[Idx1][NumLevels-unsigned'(level)-2:0]});

          assign data_nodes[Idx0] = (sel) ? data_nodes[Idx1+1] : data_nodes[Idx1];
          assign gnt_nodes[Idx1] = gnt_nodes[Idx0] & ~sel;
          assign gnt_nodes[Idx1+1] = gnt_nodes[Idx0] & sel;
        end

      end
    end

  end

endmodule : rr_arb_tree




module fpnew_opgroup_block #(
    parameter fpnew_pkg::opgroup_e OpGroup = fpnew_pkg::ADDMUL,

    parameter int unsigned                Width         = 32,
    parameter logic                       EnableVectors = 1'b1,
    parameter fpnew_pkg::fmt_logic_t      FpFmtMask     = '1,
    parameter fpnew_pkg::ifmt_logic_t     IntFmtMask    = '1,
    parameter fpnew_pkg::fmt_unsigned_t   FmtPipeRegs   = '{default: 0},
    parameter fpnew_pkg::fmt_unit_types_t FmtUnitTypes  = '{default: fpnew_pkg::PARALLEL},
    parameter fpnew_pkg::pipe_config_t    PipeConfig    = fpnew_pkg::BEFORE,
    parameter type                        TagType       = logic,
    parameter int unsigned                TrueSIMDClass = 0,

    localparam int unsigned NUM_FORMATS = fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned NUM_OPERANDS = fpnew_pkg::num_operands(OpGroup),
    localparam int unsigned NUM_LANES = fpnew_pkg::max_num_lanes(Width, FpFmtMask, EnableVectors),
    localparam type MaskType = logic [NUM_LANES-1:0]
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                   [NUM_OPERANDS-1:0][       Width-1:0] operands_i,
    input logic                   [ NUM_FORMATS-1:0][NUM_OPERANDS-1:0] is_boxed_i,
    input fpnew_pkg::roundmode_e                                       rnd_mode_i,
    input fpnew_pkg::operation_e                                       op_i,
    input logic                                                        op_mod_i,
    input fpnew_pkg::fp_format_e                                       src_fmt_i,
    input fpnew_pkg::fp_format_e                                       dst_fmt_i,
    input fpnew_pkg::int_format_e                                      int_fmt_i,
    input logic                                                        vectorial_op_i,
    input TagType                                                      tag_i,
    input MaskType                                                     simd_mask_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,

    output logic               [Width-1:0] result_o,
    output fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  typedef struct packed {
    logic [Width-1:0]   result;
    fpnew_pkg::status_t status;
    logic               ext_bit;
    TagType             tag;
  } output_t;

  logic [NUM_FORMATS-1:0] fmt_in_ready, fmt_out_valid, fmt_out_ready, fmt_busy;
  output_t [NUM_FORMATS-1:0] fmt_outputs;

  assign in_ready_o = in_valid_i & fmt_in_ready[dst_fmt_i];

  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_parallel_slices

    localparam logic ANY_MERGED = fpnew_pkg::any_enabled_multi(FmtUnitTypes, FpFmtMask);
    localparam logic IS_FIRST_MERGED = fpnew_pkg::is_first_enabled_multi(
        fpnew_pkg::fp_format_e'(fmt), FmtUnitTypes, FpFmtMask
    );

    if (FpFmtMask[fmt] && (FmtUnitTypes[fmt] == fpnew_pkg::PARALLEL)) begin : active_format

      logic in_valid;

      assign in_valid = in_valid_i & (dst_fmt_i == fmt);

      localparam int unsigned INTERNAL_LANES = fpnew_pkg::num_lanes(
          Width, fpnew_pkg::fp_format_e'(fmt), EnableVectors
      );
      logic [INTERNAL_LANES-1:0] mask_slice;
      always_comb
        for (int b = 0; b < INTERNAL_LANES; b++)
          mask_slice[b] = simd_mask_i[(NUM_LANES/INTERNAL_LANES)*b];

      fpnew_opgroup_fmt_slice #(
          .OpGroup      (OpGroup),
          .FpFormat     (fpnew_pkg::fp_format_e'(fmt)),
          .Width        (Width),
          .EnableVectors(EnableVectors),
          .NumPipeRegs  (FmtPipeRegs[fmt]),
          .PipeConfig   (PipeConfig),
          .TagType      (TagType),
          .TrueSIMDClass(TrueSIMDClass)
      ) i_fmt_slice (
          .clk_i,
          .rst_ni,
          .operands_i     (operands_i),
          .is_boxed_i     (is_boxed_i[fmt]),
          .rnd_mode_i,
          .op_i,
          .op_mod_i,
          .vectorial_op_i,
          .tag_i,
          .simd_mask_i    (mask_slice),
          .in_valid_i     (in_valid),
          .in_ready_o     (fmt_in_ready[fmt]),
          .flush_i,
          .result_o       (fmt_outputs[fmt].result),
          .status_o       (fmt_outputs[fmt].status),
          .extension_bit_o(fmt_outputs[fmt].ext_bit),
          .tag_o          (fmt_outputs[fmt].tag),
          .out_valid_o    (fmt_out_valid[fmt]),
          .out_ready_i    (fmt_out_ready[fmt]),
          .busy_o         (fmt_busy[fmt])
      );

    end else if (FpFmtMask[fmt] && ANY_MERGED && !IS_FIRST_MERGED) begin : merged_unused

      localparam FMT = fpnew_pkg::get_first_enabled_multi(FmtUnitTypes, FpFmtMask);

      assign fmt_in_ready[fmt]        = fmt_in_ready[int'(FMT)];

      assign fmt_out_valid[fmt]       = 1'b0;
      assign fmt_busy[fmt]            = 1'b0;

      assign fmt_outputs[fmt].result  = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].status  = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].ext_bit = fpnew_pkg::DONT_CARE;
      assign fmt_outputs[fmt].tag     = TagType'(fpnew_pkg::DONT_CARE);

    end else if (!FpFmtMask[fmt] || (FmtUnitTypes[fmt] == fpnew_pkg::DISABLED)) begin : disable_fmt
      assign fmt_in_ready[fmt]        = 1'b0;
      assign fmt_out_valid[fmt]       = 1'b0;
      assign fmt_busy[fmt]            = 1'b0;

      assign fmt_outputs[fmt].result  = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].status  = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].ext_bit = fpnew_pkg::DONT_CARE;
      assign fmt_outputs[fmt].tag     = TagType'(fpnew_pkg::DONT_CARE);
    end
  end

  if (fpnew_pkg::any_enabled_multi(FmtUnitTypes, FpFmtMask)) begin : gen_merged_slice

    localparam FMT = fpnew_pkg::get_first_enabled_multi(FmtUnitTypes, FpFmtMask);
    localparam REG = fpnew_pkg::get_num_regs_multi(FmtPipeRegs, FmtUnitTypes, FpFmtMask);

    logic in_valid;

    assign in_valid = in_valid_i & (FmtUnitTypes[dst_fmt_i] == fpnew_pkg::MERGED);

    fpnew_opgroup_multifmt_slice #(
        .OpGroup      (OpGroup),
        .Width        (Width),
        .FpFmtConfig  (FpFmtMask),
        .IntFmtConfig (IntFmtMask),
        .EnableVectors(EnableVectors),
        .NumPipeRegs  (REG),
        .PipeConfig   (PipeConfig),
        .TagType      (TagType)
    ) i_multifmt_slice (
        .clk_i,
        .rst_ni,
        .operands_i,
        .is_boxed_i,
        .rnd_mode_i,
        .op_i,
        .op_mod_i,
        .src_fmt_i,
        .dst_fmt_i,
        .int_fmt_i,
        .vectorial_op_i,
        .tag_i,
        .simd_mask_i    (simd_mask_i),
        .in_valid_i     (in_valid),
        .in_ready_o     (fmt_in_ready[FMT]),
        .flush_i,
        .result_o       (fmt_outputs[FMT].result),
        .status_o       (fmt_outputs[FMT].status),
        .extension_bit_o(fmt_outputs[FMT].ext_bit),
        .tag_o          (fmt_outputs[FMT].tag),
        .out_valid_o    (fmt_out_valid[FMT]),
        .out_ready_i    (fmt_out_ready[FMT]),
        .busy_o         (fmt_busy[FMT])
    );

  end

  output_t arbiter_output;

  rr_arb_tree #(
      .NumIn    (NUM_FORMATS),
      .DataType (output_t),
      .AxiVldRdy(1'b1)
  ) i_arbiter (
      .clk_i,
      .rst_ni,
      .flush_i,
      .rr_i  ('0),
      .req_i (fmt_out_valid),
      .gnt_o (fmt_out_ready),
      .data_i(fmt_outputs),
      .gnt_i (out_ready_i),
      .req_o (out_valid_o),
      .data_o(arbiter_output),
      .idx_o ()
  );

  assign result_o        = arbiter_output.result;
  assign status_o        = arbiter_output.status;
  assign extension_bit_o = arbiter_output.ext_bit;
  assign tag_o           = arbiter_output.tag;

  assign busy_o          = (|fmt_busy);

endmodule




import defs_div_sqrt_mvp::*;

module preprocess_mvp (
    input logic Clk_CI,
    input logic Rst_RBI,
    input logic Div_start_SI,
    input logic Sqrt_start_SI,
    input logic Ready_SI,

    input logic [C_OP_FP64-1:0] Operand_a_DI,
    input logic [C_OP_FP64-1:0] Operand_b_DI,
    input logic [     C_RM-1:0] RM_SI,
    input logic [     C_FS-1:0] Format_sel_SI,

    output logic                 Start_SO,
    output logic [ C_EXP_FP64:0] Exp_a_DO_norm,
    output logic [ C_EXP_FP64:0] Exp_b_DO_norm,
    output logic [C_MANT_FP64:0] Mant_a_DO_norm,
    output logic [C_MANT_FP64:0] Mant_b_DO_norm,

    output logic [C_RM-1:0] RM_dly_SO,

    output logic Sign_z_DO,
    output logic Inf_a_SO,
    output logic Inf_b_SO,
    output logic Zero_a_SO,
    output logic Zero_b_SO,
    output logic NaN_a_SO,
    output logic NaN_b_SO,
    output logic SNaN_SO,
    output logic Special_case_SBO,
    output logic Special_case_dly_SBO
);

  logic                   Hb_a_D;
  logic                   Hb_b_D;

  logic [ C_EXP_FP64-1:0] Exp_a_D;
  logic [ C_EXP_FP64-1:0] Exp_b_D;
  logic [C_MANT_FP64-1:0] Mant_a_NonH_D;
  logic [C_MANT_FP64-1:0] Mant_b_NonH_D;
  logic [  C_MANT_FP64:0] Mant_a_D;
  logic [  C_MANT_FP64:0] Mant_b_D;

  logic Sign_a_D, Sign_b_D;
  logic Start_S;

  always_comb begin
    case (Format_sel_SI)
      2'b00: begin
        Sign_a_D = Operand_a_DI[C_OP_FP32-1];
        Sign_b_D = Operand_b_DI[C_OP_FP32-1];
        Exp_a_D = {3'h0, Operand_a_DI[C_OP_FP32-2:C_MANT_FP32]};
        Exp_b_D = {3'h0, Operand_b_DI[C_OP_FP32-2:C_MANT_FP32]};
        Mant_a_NonH_D = {Operand_a_DI[C_MANT_FP32-1:0], 29'h0};
        Mant_b_NonH_D = {Operand_b_DI[C_MANT_FP32-1:0], 29'h0};
      end
      2'b01: begin
        Sign_a_D = Operand_a_DI[C_OP_FP64-1];
        Sign_b_D = Operand_b_DI[C_OP_FP64-1];
        Exp_a_D = Operand_a_DI[C_OP_FP64-2:C_MANT_FP64];
        Exp_b_D = Operand_b_DI[C_OP_FP64-2:C_MANT_FP64];
        Mant_a_NonH_D = Operand_a_DI[C_MANT_FP64-1:0];
        Mant_b_NonH_D = Operand_b_DI[C_MANT_FP64-1:0];
      end
      2'b10: begin
        Sign_a_D = Operand_a_DI[C_OP_FP16-1];
        Sign_b_D = Operand_b_DI[C_OP_FP16-1];
        Exp_a_D = {6'h00, Operand_a_DI[C_OP_FP16-2:C_MANT_FP16]};
        Exp_b_D = {6'h00, Operand_b_DI[C_OP_FP16-2:C_MANT_FP16]};
        Mant_a_NonH_D = {Operand_a_DI[C_MANT_FP16-1:0], 42'h0};
        Mant_b_NonH_D = {Operand_b_DI[C_MANT_FP16-1:0], 42'h0};
      end
      2'b11: begin
        Sign_a_D = Operand_a_DI[C_OP_FP16ALT-1];
        Sign_b_D = Operand_b_DI[C_OP_FP16ALT-1];
        Exp_a_D = {3'h0, Operand_a_DI[C_OP_FP16ALT-2:C_MANT_FP16ALT]};
        Exp_b_D = {3'h0, Operand_b_DI[C_OP_FP16ALT-2:C_MANT_FP16ALT]};
        Mant_a_NonH_D = {Operand_a_DI[C_MANT_FP16ALT-1:0], 45'h0};
        Mant_b_NonH_D = {Operand_b_DI[C_MANT_FP16ALT-1:0], 45'h0};
      end
    endcase
  end
  assign Mant_a_D = {Hb_a_D, Mant_a_NonH_D};
  assign Mant_b_D = {Hb_b_D, Mant_b_NonH_D};

  assign Hb_a_D   = |Exp_a_D;
  assign Hb_b_D   = |Exp_b_D;

  assign Start_S  = Div_start_SI | Sqrt_start_SI;

  logic Mant_a_prenorm_zero_S;
  logic Mant_b_prenorm_zero_S;

  logic Exp_a_prenorm_zero_S;
  logic Exp_b_prenorm_zero_S;
  assign Exp_a_prenorm_zero_S = ~Hb_a_D;
  assign Exp_b_prenorm_zero_S = ~Hb_b_D;

  logic Exp_a_prenorm_Inf_NaN_S;
  logic Exp_b_prenorm_Inf_NaN_S;

  logic Mant_a_prenorm_QNaN_S;
  logic Mant_a_prenorm_SNaN_S;
  logic Mant_b_prenorm_QNaN_S;
  logic Mant_b_prenorm_SNaN_S;

  assign Mant_a_prenorm_QNaN_S=Mant_a_NonH_D[C_MANT_FP64-1]&&(~(|Mant_a_NonH_D[C_MANT_FP64-2:0]));
  assign Mant_a_prenorm_SNaN_S=(~Mant_a_NonH_D[C_MANT_FP64-1])&&((|Mant_a_NonH_D[C_MANT_FP64-2:0]));
  assign Mant_b_prenorm_QNaN_S=Mant_b_NonH_D[C_MANT_FP64-1]&&(~(|Mant_b_NonH_D[C_MANT_FP64-2:0]));
  assign Mant_b_prenorm_SNaN_S=(~Mant_b_NonH_D[C_MANT_FP64-1])&&((|Mant_b_NonH_D[C_MANT_FP64-2:0]));

  always_comb begin
    case (Format_sel_SI)
      2'b00: begin
        Mant_a_prenorm_zero_S   = (Operand_a_DI[C_MANT_FP32-1:0] == C_MANT_ZERO_FP32);
        Mant_b_prenorm_zero_S   = (Operand_b_DI[C_MANT_FP32-1:0] == C_MANT_ZERO_FP32);
        Exp_a_prenorm_Inf_NaN_S = (Operand_a_DI[C_OP_FP32-2:C_MANT_FP32] == C_EXP_INF_FP32);
        Exp_b_prenorm_Inf_NaN_S = (Operand_b_DI[C_OP_FP32-2:C_MANT_FP32] == C_EXP_INF_FP32);
      end
      2'b01: begin
        Mant_a_prenorm_zero_S   = (Operand_a_DI[C_MANT_FP64-1:0] == C_MANT_ZERO_FP64);
        Mant_b_prenorm_zero_S   = (Operand_b_DI[C_MANT_FP64-1:0] == C_MANT_ZERO_FP64);
        Exp_a_prenorm_Inf_NaN_S = (Operand_a_DI[C_OP_FP64-2:C_MANT_FP64] == C_EXP_INF_FP64);
        Exp_b_prenorm_Inf_NaN_S = (Operand_b_DI[C_OP_FP64-2:C_MANT_FP64] == C_EXP_INF_FP64);
      end
      2'b10: begin
        Mant_a_prenorm_zero_S   = (Operand_a_DI[C_MANT_FP16-1:0] == C_MANT_ZERO_FP16);
        Mant_b_prenorm_zero_S   = (Operand_b_DI[C_MANT_FP16-1:0] == C_MANT_ZERO_FP16);
        Exp_a_prenorm_Inf_NaN_S = (Operand_a_DI[C_OP_FP16-2:C_MANT_FP16] == C_EXP_INF_FP16);
        Exp_b_prenorm_Inf_NaN_S = (Operand_b_DI[C_OP_FP16-2:C_MANT_FP16] == C_EXP_INF_FP16);
      end
      2'b11: begin
        Mant_a_prenorm_zero_S = (Operand_a_DI[C_MANT_FP16ALT-1:0] == C_MANT_ZERO_FP16ALT);
        Mant_b_prenorm_zero_S = (Operand_b_DI[C_MANT_FP16ALT-1:0] == C_MANT_ZERO_FP16ALT);
        Exp_a_prenorm_Inf_NaN_S=(Operand_a_DI[C_OP_FP16ALT-2:C_MANT_FP16ALT] == C_EXP_INF_FP16ALT);
        Exp_b_prenorm_Inf_NaN_S=(Operand_b_DI[C_OP_FP16ALT-2:C_MANT_FP16ALT] == C_EXP_INF_FP16ALT);
      end
    endcase
  end

  logic Zero_a_SN, Zero_a_SP;
  logic Zero_b_SN, Zero_b_SP;
  logic Inf_a_SN, Inf_a_SP;
  logic Inf_b_SN, Inf_b_SP;
  logic NaN_a_SN, NaN_a_SP;
  logic NaN_b_SN, NaN_b_SP;
  logic SNaN_SN, SNaN_SP;

  assign Zero_a_SN = (Start_S&&Ready_SI)?(Exp_a_prenorm_zero_S&&Mant_a_prenorm_zero_S):Zero_a_SP;
  assign Zero_b_SN = (Start_S&&Ready_SI)?(Exp_b_prenorm_zero_S&&Mant_b_prenorm_zero_S):Zero_b_SP;
  assign Inf_a_SN = (Start_S&&Ready_SI)?(Exp_a_prenorm_Inf_NaN_S&&Mant_a_prenorm_zero_S):Inf_a_SP;
  assign Inf_b_SN = (Start_S&&Ready_SI)?(Exp_b_prenorm_Inf_NaN_S&&Mant_b_prenorm_zero_S):Inf_b_SP;
  assign NaN_a_SN = (Start_S&&Ready_SI)?(Exp_a_prenorm_Inf_NaN_S&&(~Mant_a_prenorm_zero_S)):NaN_a_SP;
  assign NaN_b_SN = (Start_S&&Ready_SI)?(Exp_b_prenorm_Inf_NaN_S&&(~Mant_b_prenorm_zero_S)):NaN_b_SP;
  assign SNaN_SN = (Start_S&&Ready_SI) ? ((Mant_a_prenorm_SNaN_S&&NaN_a_SN) | (Mant_b_prenorm_SNaN_S&&NaN_b_SN)) : SNaN_SP;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Zero_a_SP <= '0;
      Zero_b_SP <= '0;
      Inf_a_SP  <= '0;
      Inf_b_SP  <= '0;
      NaN_a_SP  <= '0;
      NaN_b_SP  <= '0;
      SNaN_SP   <= '0;
    end else begin
      Inf_a_SP  <= Inf_a_SN;
      Inf_b_SP  <= Inf_b_SN;
      Zero_a_SP <= Zero_a_SN;
      Zero_b_SP <= Zero_b_SN;
      NaN_a_SP  <= NaN_a_SN;
      NaN_b_SP  <= NaN_b_SN;
      SNaN_SP   <= SNaN_SN;
    end
  end

  assign Special_case_SBO=(~{(Div_start_SI)?(Zero_a_SN | Zero_b_SN |  Inf_a_SN | Inf_b_SN | NaN_a_SN | NaN_b_SN): (Zero_a_SN | Inf_a_SN | NaN_a_SN | Sign_a_D) })&&(Start_S&&Ready_SI);
  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Special_case_dly_SBO <= '0;
    end else if ((Start_S && Ready_SI)) begin
      Special_case_dly_SBO <= Special_case_SBO;
    end else if (Special_case_dly_SBO) begin
      Special_case_dly_SBO <= 1'b1;
    end else begin
      Special_case_dly_SBO <= '0;
    end
  end

  logic Sign_z_DN;
  logic Sign_z_DP;

  always_comb begin
    if (Div_start_SI && Ready_SI) Sign_z_DN = Sign_a_D ^ Sign_b_D;
    else if (Sqrt_start_SI && Ready_SI) Sign_z_DN = Sign_a_D;
    else Sign_z_DN = Sign_z_DP;
  end

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Sign_z_DP <= '0;
    end else begin
      Sign_z_DP <= Sign_z_DN;
    end
  end

  logic [C_RM-1:0] RM_DN;
  logic [C_RM-1:0] RM_DP;

  always_comb begin
    if (Start_S && Ready_SI) RM_DN = RM_SI;
    else RM_DN = RM_DP;
  end

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      RM_DP <= '0;
    end else begin
      RM_DP <= RM_DN;
    end
  end
  assign RM_dly_SO = RM_DP;

  logic [5:0] Mant_leadingOne_a, Mant_leadingOne_b;
  logic Mant_zero_S_a, Mant_zero_S_b;

  lzc #(
      .WIDTH(C_MANT_FP64 + 1),
      .MODE (1)
  ) LOD_Ua (
      .in_i   (Mant_a_D),
      .cnt_o  (Mant_leadingOne_a),
      .empty_o(Mant_zero_S_a)
  );

  logic [C_MANT_FP64:0] Mant_a_norm_DN, Mant_a_norm_DP;

  assign  Mant_a_norm_DN = ((Start_S&&Ready_SI))?(Mant_a_D<<(Mant_leadingOne_a)):Mant_a_norm_DP;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Mant_a_norm_DP <= '0;
    end else begin
      Mant_a_norm_DP <= Mant_a_norm_DN;
    end
  end

  logic [C_EXP_FP64:0] Exp_a_norm_DN, Exp_a_norm_DP;
  assign  Exp_a_norm_DN = ((Start_S&&Ready_SI))?(Exp_a_D-Mant_leadingOne_a+(|Mant_leadingOne_a)):Exp_a_norm_DP;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Exp_a_norm_DP <= '0;
    end else begin
      Exp_a_norm_DP <= Exp_a_norm_DN;
    end
  end

  lzc #(
      .WIDTH(C_MANT_FP64 + 1),
      .MODE (1)
  ) LOD_Ub (
      .in_i   (Mant_b_D),
      .cnt_o  (Mant_leadingOne_b),
      .empty_o(Mant_zero_S_b)
  );
  logic [C_MANT_FP64:0] Mant_b_norm_DN, Mant_b_norm_DP;

  assign  Mant_b_norm_DN = ((Start_S&&Ready_SI))?(Mant_b_D<<(Mant_leadingOne_b)):Mant_b_norm_DP;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Mant_b_norm_DP <= '0;
    end else begin
      Mant_b_norm_DP <= Mant_b_norm_DN;
    end
  end

  logic [C_EXP_FP64:0] Exp_b_norm_DN, Exp_b_norm_DP;
  assign  Exp_b_norm_DN = ((Start_S&&Ready_SI))?(Exp_b_D-Mant_leadingOne_b+(|Mant_leadingOne_b)):Exp_b_norm_DP;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Exp_b_norm_DP <= '0;
    end else begin
      Exp_b_norm_DP <= Exp_b_norm_DN;
    end
  end

  assign Start_SO = Start_S;
  assign Exp_a_DO_norm = Exp_a_norm_DP;
  assign Exp_b_DO_norm = Exp_b_norm_DP;
  assign Mant_a_DO_norm = Mant_a_norm_DP;
  assign Mant_b_DO_norm = Mant_b_norm_DP;
  assign Sign_z_DO = Sign_z_DP;
  assign Inf_a_SO = Inf_a_SP;
  assign Inf_b_SO = Inf_b_SP;
  assign Zero_a_SO = Zero_a_SP;
  assign Zero_b_SO = Zero_b_SP;
  assign NaN_a_SO = NaN_a_SP;
  assign NaN_b_SO = NaN_b_SP;
  assign SNaN_SO = SNaN_SP;

endmodule




module iteration_div_sqrt_mvp #(
    parameter WIDTH = 25
) (

    input logic [WIDTH-1:0] A_DI,
    input logic [WIDTH-1:0] B_DI,
    input logic             Div_enable_SI,
    input logic             Div_start_dly_SI,
    input logic             Sqrt_enable_SI,
    input logic [      1:0] D_DI,

    output logic [      1:0] D_DO,
    output logic [WIDTH-1:0] Sum_DO,
    output logic             Carry_out_DO
);

  logic D_carry_D;
  logic Sqrt_cin_D;
  logic Cin_D;

  assign D_DO[0] = ~D_DI[0];
  assign D_DO[1] = ~(D_DI[1] ^ D_DI[0]);
  assign D_carry_D = D_DI[1] | D_DI[0];
  assign Sqrt_cin_D = Sqrt_enable_SI && D_carry_D;
  assign Cin_D = Div_enable_SI ? 1'b0 : Sqrt_cin_D;
  assign {Carry_out_DO, Sum_DO} = A_DI + B_DI + Cin_D;

endmodule




import defs_div_sqrt_mvp::*;

module control_mvp (
    input  logic                 Clk_CI,
    input  logic                 Rst_RBI,
    input  logic                 Div_start_SI,
    input  logic                 Sqrt_start_SI,
    input  logic                 Start_SI,
    input  logic                 Kill_SI,
    input  logic                 Special_case_SBI,
    input  logic                 Special_case_dly_SBI,
    input  logic [     C_PC-1:0] Precision_ctl_SI,
    input  logic [          1:0] Format_sel_SI,
    input  logic [C_MANT_FP64:0] Numerator_DI,
    input  logic [ C_EXP_FP64:0] Exp_num_DI,
    input  logic [C_MANT_FP64:0] Denominator_DI,
    input  logic [ C_EXP_FP64:0] Exp_den_DI,
    output logic                 Div_start_dly_SO,
    output logic                 Sqrt_start_dly_SO,
    output logic                 Div_enable_SO,
    output logic                 Sqrt_enable_SO,

    output logic Full_precision_SO,
    output logic FP32_SO,
    output logic FP64_SO,
    output logic FP16_SO,
    output logic FP16ALT_SO,

    output logic Ready_SO,
    output logic Done_SO,

    output logic [C_MANT_FP64+4:0] Mant_result_prenorm_DO,

    output logic [C_EXP_FP64+1:0] Exp_result_prenorm_DO
);

  logic [C_MANT_FP64+1+4:0] Partial_remainder_DN, Partial_remainder_DP;
  logic [C_MANT_FP64+4:0] Quotient_DP;

  logic [C_MANT_FP64+1:0] Numerator_se_D;
  logic [C_MANT_FP64+1:0] Denominator_se_D;
  logic [C_MANT_FP64+1:0] Denominator_se_DB;

  assign Numerator_se_D   = {1'b0, Numerator_DI};

  assign Denominator_se_D = {1'b0, Denominator_DI};

  always_comb begin
    if (FP32_SO) begin
      Denominator_se_DB = {
        ~Denominator_se_D[C_MANT_FP64+1:C_MANT_FP64-C_MANT_FP32],
        {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
      };
    end else if (FP64_SO) begin
      Denominator_se_DB = ~Denominator_se_D;
    end else if (FP16_SO) begin
      Denominator_se_DB = {
        ~Denominator_se_D[C_MANT_FP64+1:C_MANT_FP64-C_MANT_FP16],
        {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
      };
    end else begin
      Denominator_se_DB = {
        ~Denominator_se_D[C_MANT_FP64+1:C_MANT_FP64-C_MANT_FP16ALT],
        {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
      };
    end
  end
  logic [C_MANT_FP64+1:0] Mant_D_sqrt_Norm;

  assign Mant_D_sqrt_Norm = Exp_num_DI[0] ? {1'b0, Numerator_DI} : {Numerator_DI, 1'b0};

  logic [1:0] Format_sel_S;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Format_sel_S <= 'b0;
    end else if (Start_SI && Ready_SO) begin
      Format_sel_S <= Format_sel_SI;
    end else begin
      Format_sel_S <= Format_sel_S;
    end
  end

  assign FP32_SO = (Format_sel_S == 2'b00);
  assign FP64_SO = (Format_sel_S == 2'b01);
  assign FP16_SO = (Format_sel_S == 2'b10);
  assign FP16ALT_SO = (Format_sel_S == 2'b11);

  logic [C_PC-1:0] Precision_ctl_S;
  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Precision_ctl_S <= 'b0;
    end else if (Start_SI && Ready_SO) begin
      Precision_ctl_S <= Precision_ctl_SI;
    end else begin
      Precision_ctl_S <= Precision_ctl_S;
    end
  end
  assign Full_precision_SO = (Precision_ctl_S == 6'h00);
  logic [5:0] State_ctl_S;
  logic [5:0] State_Two_iteration_unit_S;
  logic [5:0] State_Four_iteration_unit_S;

  assign State_Two_iteration_unit_S  = Precision_ctl_S[C_PC-1:1];
  assign State_Four_iteration_unit_S = Precision_ctl_S[C_PC-1:2];
  always_comb begin
    case (Iteration_unit_num_S)

      2'b00: begin
        case (Format_sel_S)
          2'b00: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h1b;
            end else begin
              State_ctl_S = Precision_ctl_S;
            end
          end
          2'b01: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h38;
            end else begin
              State_ctl_S = Precision_ctl_S;
            end
          end
          2'b10: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h0e;
            end else begin
              State_ctl_S = Precision_ctl_S;
            end
          end
          2'b11: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h0b;
            end else begin
              State_ctl_S = Precision_ctl_S;
            end
          end
        endcase
      end
      2'b01: begin
        case (Format_sel_S)
          2'b00: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h0d;
            end else begin
              State_ctl_S = State_Two_iteration_unit_S;
            end
          end
          2'b01: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h1b;
            end else begin
              State_ctl_S = State_Two_iteration_unit_S;
            end
          end
          2'b10: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h06;
            end else begin
              State_ctl_S = State_Two_iteration_unit_S;
            end
          end
          2'b11: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h05;
            end else begin
              State_ctl_S = State_Two_iteration_unit_S;
            end
          end
        endcase
      end
      2'b10: begin
        case (Format_sel_S)
          2'b00: begin
            case (Precision_ctl_S)
              6'h00: begin
                State_ctl_S = 6'h08;
              end
              6'h06, 6'h07, 6'h08: begin
                State_ctl_S = 6'h02;
              end
              6'h09, 6'h0a, 6'h0b: begin
                State_ctl_S = 6'h03;
              end
              6'h0c, 6'h0d, 6'h0e: begin
                State_ctl_S = 6'h04;
              end
              6'h0f, 6'h10, 6'h11: begin
                State_ctl_S = 6'h05;
              end
              6'h12, 6'h13, 6'h14: begin
                State_ctl_S = 6'h06;
              end
              6'h15, 6'h16, 6'h17: begin
                State_ctl_S = 6'h07;
              end
              default: begin
                State_ctl_S = 6'h08;
              end
            endcase
          end
          2'b01: begin
            case (Precision_ctl_S)
              6'h00: begin
                State_ctl_S = 6'h12;
              end
              6'h06, 6'h07, 6'h08: begin
                State_ctl_S = 6'h02;
              end
              6'h09, 6'h0a, 6'h0b: begin
                State_ctl_S = 6'h03;
              end
              6'h0c, 6'h0d, 6'h0e: begin
                State_ctl_S = 6'h04;
              end
              6'h0f, 6'h10, 6'h11: begin
                State_ctl_S = 6'h05;
              end
              6'h12, 6'h13, 6'h14: begin
                State_ctl_S = 6'h06;
              end
              6'h15, 6'h16, 6'h17: begin
                State_ctl_S = 6'h07;
              end
              6'h18, 6'h19, 6'h1a: begin
                State_ctl_S = 6'h08;
              end
              6'h1b, 6'h1c, 6'h1d: begin
                State_ctl_S = 6'h09;
              end
              6'h1e, 6'h1f, 6'h20: begin
                State_ctl_S = 6'h0a;
              end
              6'h21, 6'h22, 6'h23: begin
                State_ctl_S = 6'h0b;
              end
              6'h24, 6'h25, 6'h26: begin
                State_ctl_S = 6'h0c;
              end
              6'h27, 6'h28, 6'h29: begin
                State_ctl_S = 6'h0d;
              end
              6'h2a, 6'h2b, 6'h2c: begin
                State_ctl_S = 6'h0e;
              end
              6'h2d, 6'h2e, 6'h2f: begin
                State_ctl_S = 6'h0f;
              end
              6'h30, 6'h31, 6'h32: begin
                State_ctl_S = 6'h10;
              end
              6'h33, 6'h34, 6'h35: begin
                State_ctl_S = 6'h11;
              end
              default: begin
                State_ctl_S = 6'h12;
              end
            endcase
          end
          2'b10: begin
            case (Precision_ctl_S)
              6'h00: begin
                State_ctl_S = 6'h04;
              end
              6'h06, 6'h07, 6'h08: begin
                State_ctl_S = 6'h02;
              end
              6'h09, 6'h0a, 6'h0b: begin
                State_ctl_S = 6'h03;
              end
              default: begin
                State_ctl_S = 6'h04;
              end
            endcase
          end
          2'b11: begin
            case (Precision_ctl_S)
              6'h00: begin
                State_ctl_S = 6'h03;
              end
              6'h06, 6'h07, 6'h08: begin
                State_ctl_S = 6'h02;
              end
              default: begin
                State_ctl_S = 6'h03;
              end
            endcase
          end
        endcase
      end
      2'b11: begin
        case (Format_sel_S)
          2'b00: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h06;
            end else begin
              State_ctl_S = State_Four_iteration_unit_S;
            end
          end
          2'b01: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h0d;
            end else begin
              State_ctl_S = State_Four_iteration_unit_S;
            end
          end
          2'b10: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h03;
            end else begin
              State_ctl_S = State_Four_iteration_unit_S;
            end
          end
          2'b11: begin
            if (Full_precision_SO) begin
              State_ctl_S = 6'h02;
            end else begin
              State_ctl_S = State_Four_iteration_unit_S;
            end
          end
        endcase
      end
    endcase
  end

  logic Div_start_dly_S;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Div_start_dly_S <= 1'b0;
    end else if (Div_start_SI && Ready_SO) begin
      Div_start_dly_S <= 1'b1;
    end else begin
      Div_start_dly_S <= 1'b0;
    end
  end

  assign Div_start_dly_SO = Div_start_dly_S;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) Div_enable_SO <= 1'b0;

    else if (Kill_SI) Div_enable_SO <= 1'b0;
    else if (Div_start_SI && Ready_SO) Div_enable_SO <= 1'b1;
    else if (Done_SO) Div_enable_SO <= 1'b0;
    else Div_enable_SO <= Div_enable_SO;
  end

  logic Sqrt_start_dly_S;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Sqrt_start_dly_S <= 1'b0;
    end else if (Sqrt_start_SI && Ready_SO) begin
      Sqrt_start_dly_S <= 1'b1;
    end else begin
      Sqrt_start_dly_S <= 1'b0;
    end
  end
  assign Sqrt_start_dly_SO = Sqrt_start_dly_S;

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) Sqrt_enable_SO <= 1'b0;
    else if (Kill_SI) Sqrt_enable_SO <= 1'b0;
    else if (Sqrt_start_SI && Ready_SO) Sqrt_enable_SO <= 1'b1;
    else if (Done_SO) Sqrt_enable_SO <= 1'b0;
    else Sqrt_enable_SO <= Sqrt_enable_SO;
  end

  logic [5:0] Crtl_cnt_S;
  logic       Start_dly_S;

  assign Start_dly_S = Div_start_dly_S | Sqrt_start_dly_S;

  logic Fsm_enable_S;
  assign Fsm_enable_S = ((Start_dly_S | (|Crtl_cnt_S)) && (~Kill_SI) && Special_case_dly_SBI);

  logic Final_state_S;
  assign Final_state_S = (Crtl_cnt_S == State_ctl_S);
  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Crtl_cnt_S <= '0;
    end else if (Final_state_S | Kill_SI) begin
      Crtl_cnt_S <= '0;
    end else if (Fsm_enable_S) begin
      Crtl_cnt_S <= Crtl_cnt_S + 1;
    end else begin
      Crtl_cnt_S <= '0;
    end
  end
  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Done_SO <= 1'b0;
    end else if (Start_SI && Ready_SO) begin
      if (~Special_case_SBI) begin
        Done_SO <= 1'b1;
      end else begin
        Done_SO <= 1'b0;
      end
    end else if (Final_state_S) begin
      Done_SO <= 1'b1;
    end else begin
      Done_SO <= 1'b0;
    end
  end

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Ready_SO <= 1'b1;
    end else if (Start_SI && Ready_SO) begin
      if (~Special_case_SBI) begin
        Ready_SO <= 1'b1;
      end else begin
        Ready_SO <= 1'b0;
      end
    end else if (Final_state_S | Kill_SI) begin
      Ready_SO <= 1'b1;
    end else begin
      Ready_SO <= Ready_SO;
    end
  end

  logic        Qcnt_one_0;
  logic        Qcnt_one_1;
  logic [ 1:0] Qcnt_one_2;
  logic [ 2:0] Qcnt_one_3;
  logic [ 3:0] Qcnt_one_4;
  logic [ 4:0] Qcnt_one_5;
  logic [ 5:0] Qcnt_one_6;
  logic [ 6:0] Qcnt_one_7;
  logic [ 7:0] Qcnt_one_8;
  logic [ 8:0] Qcnt_one_9;
  logic [ 9:0] Qcnt_one_10;
  logic [10:0] Qcnt_one_11;
  logic [11:0] Qcnt_one_12;
  logic [12:0] Qcnt_one_13;
  logic [13:0] Qcnt_one_14;
  logic [14:0] Qcnt_one_15;
  logic [15:0] Qcnt_one_16;
  logic [16:0] Qcnt_one_17;
  logic [17:0] Qcnt_one_18;
  logic [18:0] Qcnt_one_19;
  logic [19:0] Qcnt_one_20;
  logic [20:0] Qcnt_one_21;
  logic [21:0] Qcnt_one_22;
  logic [22:0] Qcnt_one_23;
  logic [23:0] Qcnt_one_24;
  logic [24:0] Qcnt_one_25;
  logic [25:0] Qcnt_one_26;
  logic [26:0] Qcnt_one_27;
  logic [27:0] Qcnt_one_28;
  logic [28:0] Qcnt_one_29;
  logic [29:0] Qcnt_one_30;
  logic [30:0] Qcnt_one_31;
  logic [31:0] Qcnt_one_32;
  logic [32:0] Qcnt_one_33;
  logic [33:0] Qcnt_one_34;
  logic [34:0] Qcnt_one_35;
  logic [35:0] Qcnt_one_36;
  logic [36:0] Qcnt_one_37;
  logic [37:0] Qcnt_one_38;
  logic [38:0] Qcnt_one_39;
  logic [39:0] Qcnt_one_40;
  logic [40:0] Qcnt_one_41;
  logic [41:0] Qcnt_one_42;
  logic [42:0] Qcnt_one_43;
  logic [43:0] Qcnt_one_44;
  logic [44:0] Qcnt_one_45;
  logic [45:0] Qcnt_one_46;
  logic [46:0] Qcnt_one_47;
  logic [47:0] Qcnt_one_48;
  logic [48:0] Qcnt_one_49;
  logic [49:0] Qcnt_one_50;
  logic [50:0] Qcnt_one_51;
  logic [51:0] Qcnt_one_52;
  logic [52:0] Qcnt_one_53;
  logic [53:0] Qcnt_one_54;
  logic [54:0] Qcnt_one_55;
  logic [55:0] Qcnt_one_56;
  logic [56:0] Qcnt_one_57;
  logic [57:0] Qcnt_one_58;
  logic [58:0] Qcnt_one_59;
  logic [59:0] Qcnt_one_60;

  logic [ 1:0] Qcnt_two_0;
  logic [ 2:0] Qcnt_two_1;
  logic [ 4:0] Qcnt_two_2;
  logic [ 6:0] Qcnt_two_3;
  logic [ 8:0] Qcnt_two_4;
  logic [10:0] Qcnt_two_5;
  logic [12:0] Qcnt_two_6;
  logic [14:0] Qcnt_two_7;
  logic [16:0] Qcnt_two_8;
  logic [18:0] Qcnt_two_9;
  logic [20:0] Qcnt_two_10;
  logic [22:0] Qcnt_two_11;
  logic [24:0] Qcnt_two_12;
  logic [26:0] Qcnt_two_13;
  logic [28:0] Qcnt_two_14;
  logic [30:0] Qcnt_two_15;
  logic [32:0] Qcnt_two_16;
  logic [34:0] Qcnt_two_17;
  logic [36:0] Qcnt_two_18;
  logic [38:0] Qcnt_two_19;
  logic [40:0] Qcnt_two_20;
  logic [42:0] Qcnt_two_21;
  logic [44:0] Qcnt_two_22;
  logic [46:0] Qcnt_two_23;
  logic [48:0] Qcnt_two_24;
  logic [50:0] Qcnt_two_25;
  logic [52:0] Qcnt_two_26;
  logic [54:0] Qcnt_two_27;
  logic [56:0] Qcnt_two_28;

  logic [ 2:0] Qcnt_three_0;
  logic [ 4:0] Qcnt_three_1;
  logic [ 7:0] Qcnt_three_2;
  logic [10:0] Qcnt_three_3;
  logic [13:0] Qcnt_three_4;
  logic [16:0] Qcnt_three_5;
  logic [19:0] Qcnt_three_6;
  logic [22:0] Qcnt_three_7;
  logic [25:0] Qcnt_three_8;
  logic [28:0] Qcnt_three_9;
  logic [31:0] Qcnt_three_10;
  logic [34:0] Qcnt_three_11;
  logic [37:0] Qcnt_three_12;
  logic [40:0] Qcnt_three_13;
  logic [43:0] Qcnt_three_14;
  logic [46:0] Qcnt_three_15;
  logic [49:0] Qcnt_three_16;
  logic [52:0] Qcnt_three_17;
  logic [55:0] Qcnt_three_18;
  logic [58:0] Qcnt_three_19;
  logic [61:0] Qcnt_three_20;

  logic [ 3:0] Qcnt_four_0;
  logic [ 6:0] Qcnt_four_1;
  logic [10:0] Qcnt_four_2;
  logic [14:0] Qcnt_four_3;
  logic [18:0] Qcnt_four_4;
  logic [22:0] Qcnt_four_5;
  logic [26:0] Qcnt_four_6;
  logic [30:0] Qcnt_four_7;
  logic [34:0] Qcnt_four_8;
  logic [38:0] Qcnt_four_9;
  logic [42:0] Qcnt_four_10;
  logic [46:0] Qcnt_four_11;
  logic [50:0] Qcnt_four_12;
  logic [54:0] Qcnt_four_13;
  logic [58:0] Qcnt_four_14;

  logic [C_MANT_FP64+1+4:0] Sqrt_R0, Sqrt_Q0, Q_sqrt0, Q_sqrt_com_0;
  logic [C_MANT_FP64+1+4:0] Sqrt_R1, Sqrt_Q1, Q_sqrt1, Q_sqrt_com_1;
  logic [C_MANT_FP64+1+4:0] Sqrt_R2, Sqrt_Q2, Q_sqrt2, Q_sqrt_com_2;
  logic [C_MANT_FP64+1+4:0] Sqrt_R3, Sqrt_Q3, Q_sqrt3, Q_sqrt_com_3, Sqrt_R4;
  logic [              1:0] Sqrt_DI                   [3:0];
  logic [              1:0] Sqrt_DO                   [3:0];
  logic                     Sqrt_carry_DO;
  logic [C_MANT_FP64+1+4:0] Iteration_cell_a_D        [3:0];
  logic [C_MANT_FP64+1+4:0] Iteration_cell_b_D        [3:0];
  logic [C_MANT_FP64+1+4:0] Iteration_cell_a_BMASK_D  [3:0];
  logic [C_MANT_FP64+1+4:0] Iteration_cell_b_BMASK_D  [3:0];
  logic                     Iteration_cell_carry_D    [3:0];
  logic [C_MANT_FP64+1+4:0] Iteration_cell_sum_D      [3:0];
  logic [C_MANT_FP64+1+4:0] Iteration_cell_sum_AMASK_D[3:0];
  logic [              3:0] Sqrt_quotinent_S;
  always_comb begin
    case (Format_sel_S)
      2'b00: begin
        Sqrt_quotinent_S = {
          (~Iteration_cell_sum_AMASK_D[0][C_MANT_FP32+5]),
          (~Iteration_cell_sum_AMASK_D[1][C_MANT_FP32+5]),
          (~Iteration_cell_sum_AMASK_D[2][C_MANT_FP32+5]),
          (~Iteration_cell_sum_AMASK_D[3][C_MANT_FP32+5])
        };
        Q_sqrt_com_0 = {{(C_MANT_FP64 - C_MANT_FP32) {1'b0}}, ~Q_sqrt0[C_MANT_FP32+5:0]};
        Q_sqrt_com_1 = {{(C_MANT_FP64 - C_MANT_FP32) {1'b0}}, ~Q_sqrt1[C_MANT_FP32+5:0]};
        Q_sqrt_com_2 = {{(C_MANT_FP64 - C_MANT_FP32) {1'b0}}, ~Q_sqrt2[C_MANT_FP32+5:0]};
        Q_sqrt_com_3 = {{(C_MANT_FP64 - C_MANT_FP32) {1'b0}}, ~Q_sqrt3[C_MANT_FP32+5:0]};
      end
      2'b01: begin
        Sqrt_quotinent_S = {
          Iteration_cell_carry_D[0],
          Iteration_cell_carry_D[1],
          Iteration_cell_carry_D[2],
          Iteration_cell_carry_D[3]
        };
        Q_sqrt_com_0 = ~Q_sqrt0;
        Q_sqrt_com_1 = ~Q_sqrt1;
        Q_sqrt_com_2 = ~Q_sqrt2;
        Q_sqrt_com_3 = ~Q_sqrt3;
      end
      2'b10: begin
        Sqrt_quotinent_S = {
          (~Iteration_cell_sum_AMASK_D[0][C_MANT_FP16+5]),
          (~Iteration_cell_sum_AMASK_D[1][C_MANT_FP16+5]),
          (~Iteration_cell_sum_AMASK_D[2][C_MANT_FP16+5]),
          (~Iteration_cell_sum_AMASK_D[3][C_MANT_FP16+5])
        };
        Q_sqrt_com_0 = {{(C_MANT_FP64 - C_MANT_FP16) {1'b0}}, ~Q_sqrt0[C_MANT_FP16+5:0]};
        Q_sqrt_com_1 = {{(C_MANT_FP64 - C_MANT_FP16) {1'b0}}, ~Q_sqrt1[C_MANT_FP16+5:0]};
        Q_sqrt_com_2 = {{(C_MANT_FP64 - C_MANT_FP16) {1'b0}}, ~Q_sqrt2[C_MANT_FP16+5:0]};
        Q_sqrt_com_3 = {{(C_MANT_FP64 - C_MANT_FP16) {1'b0}}, ~Q_sqrt3[C_MANT_FP16+5:0]};
      end
      2'b11: begin
        Sqrt_quotinent_S = {
          (~Iteration_cell_sum_AMASK_D[0][C_MANT_FP16ALT+5]),
          (~Iteration_cell_sum_AMASK_D[1][C_MANT_FP16ALT+5]),
          (~Iteration_cell_sum_AMASK_D[2][C_MANT_FP16ALT+5]),
          (~Iteration_cell_sum_AMASK_D[3][C_MANT_FP16ALT+5])
        };
        Q_sqrt_com_0 = {{(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}, ~Q_sqrt0[C_MANT_FP16ALT+5:0]};
        Q_sqrt_com_1 = {{(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}, ~Q_sqrt1[C_MANT_FP16ALT+5:0]};
        Q_sqrt_com_2 = {{(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}, ~Q_sqrt2[C_MANT_FP16ALT+5:0]};
        Q_sqrt_com_3 = {{(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}, ~Q_sqrt3[C_MANT_FP16ALT+5:0]};
      end
    endcase
  end
  assign Qcnt_one_0 = {1'b0};
  assign Qcnt_one_1 = {Quotient_DP[0]};
  assign Qcnt_one_2 = {Quotient_DP[1:0]};
  assign Qcnt_one_3 = {Quotient_DP[2:0]};
  assign Qcnt_one_4 = {Quotient_DP[3:0]};
  assign Qcnt_one_5 = {Quotient_DP[4:0]};
  assign Qcnt_one_6 = {Quotient_DP[5:0]};
  assign Qcnt_one_7 = {Quotient_DP[6:0]};
  assign Qcnt_one_8 = {Quotient_DP[7:0]};
  assign Qcnt_one_9 = {Quotient_DP[8:0]};
  assign Qcnt_one_10 = {Quotient_DP[9:0]};
  assign Qcnt_one_11 = {Quotient_DP[10:0]};
  assign Qcnt_one_12 = {Quotient_DP[11:0]};
  assign Qcnt_one_13 = {Quotient_DP[12:0]};
  assign Qcnt_one_14 = {Quotient_DP[13:0]};
  assign Qcnt_one_15 = {Quotient_DP[14:0]};
  assign Qcnt_one_16 = {Quotient_DP[15:0]};
  assign Qcnt_one_17 = {Quotient_DP[16:0]};
  assign Qcnt_one_18 = {Quotient_DP[17:0]};
  assign Qcnt_one_19 = {Quotient_DP[18:0]};
  assign Qcnt_one_20 = {Quotient_DP[19:0]};
  assign Qcnt_one_21 = {Quotient_DP[20:0]};
  assign Qcnt_one_22 = {Quotient_DP[21:0]};
  assign Qcnt_one_23 = {Quotient_DP[22:0]};
  assign Qcnt_one_24 = {Quotient_DP[23:0]};
  assign Qcnt_one_25 = {Quotient_DP[24:0]};
  assign Qcnt_one_26 = {Quotient_DP[25:0]};
  assign Qcnt_one_27 = {Quotient_DP[26:0]};
  assign Qcnt_one_28 = {Quotient_DP[27:0]};
  assign Qcnt_one_29 = {Quotient_DP[28:0]};
  assign Qcnt_one_30 = {Quotient_DP[29:0]};
  assign Qcnt_one_31 = {Quotient_DP[30:0]};
  assign Qcnt_one_32 = {Quotient_DP[31:0]};
  assign Qcnt_one_33 = {Quotient_DP[32:0]};
  assign Qcnt_one_34 = {Quotient_DP[33:0]};
  assign Qcnt_one_35 = {Quotient_DP[34:0]};
  assign Qcnt_one_36 = {Quotient_DP[35:0]};
  assign Qcnt_one_37 = {Quotient_DP[36:0]};
  assign Qcnt_one_38 = {Quotient_DP[37:0]};
  assign Qcnt_one_39 = {Quotient_DP[38:0]};
  assign Qcnt_one_40 = {Quotient_DP[39:0]};
  assign Qcnt_one_41 = {Quotient_DP[40:0]};
  assign Qcnt_one_42 = {Quotient_DP[41:0]};
  assign Qcnt_one_43 = {Quotient_DP[42:0]};
  assign Qcnt_one_44 = {Quotient_DP[43:0]};
  assign Qcnt_one_45 = {Quotient_DP[44:0]};
  assign Qcnt_one_46 = {Quotient_DP[45:0]};
  assign Qcnt_one_47 = {Quotient_DP[46:0]};
  assign Qcnt_one_48 = {Quotient_DP[47:0]};
  assign Qcnt_one_49 = {Quotient_DP[48:0]};
  assign Qcnt_one_50 = {Quotient_DP[49:0]};
  assign Qcnt_one_51 = {Quotient_DP[50:0]};
  assign Qcnt_one_52 = {Quotient_DP[51:0]};
  assign Qcnt_one_53 = {Quotient_DP[52:0]};
  assign Qcnt_one_54 = {Quotient_DP[53:0]};
  assign Qcnt_one_55 = {Quotient_DP[54:0]};
  assign Qcnt_one_56 = {Quotient_DP[55:0]};
  assign Qcnt_one_57 = {Quotient_DP[56:0]};
  assign Qcnt_two_0 = {1'b0, Sqrt_quotinent_S[3]};
  assign Qcnt_two_1 = {Quotient_DP[1:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_2 = {Quotient_DP[3:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_3 = {Quotient_DP[5:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_4 = {Quotient_DP[7:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_5 = {Quotient_DP[9:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_6 = {Quotient_DP[11:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_7 = {Quotient_DP[13:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_8 = {Quotient_DP[15:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_9 = {Quotient_DP[17:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_10 = {Quotient_DP[19:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_11 = {Quotient_DP[21:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_12 = {Quotient_DP[23:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_13 = {Quotient_DP[25:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_14 = {Quotient_DP[27:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_15 = {Quotient_DP[29:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_16 = {Quotient_DP[31:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_17 = {Quotient_DP[33:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_18 = {Quotient_DP[35:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_19 = {Quotient_DP[37:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_20 = {Quotient_DP[39:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_21 = {Quotient_DP[41:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_22 = {Quotient_DP[43:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_23 = {Quotient_DP[45:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_24 = {Quotient_DP[47:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_25 = {Quotient_DP[49:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_26 = {Quotient_DP[51:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_27 = {Quotient_DP[53:0], Sqrt_quotinent_S[3]};
  assign Qcnt_two_28 = {Quotient_DP[55:0], Sqrt_quotinent_S[3]};
  assign Qcnt_three_0 = {1'b0, Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_1 = {Quotient_DP[2:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_2 = {Quotient_DP[5:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_3 = {Quotient_DP[8:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_4 = {Quotient_DP[11:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_5 = {Quotient_DP[14:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_6 = {Quotient_DP[17:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_7 = {Quotient_DP[20:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_8 = {Quotient_DP[23:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_9 = {Quotient_DP[26:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_10 = {Quotient_DP[29:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_11 = {Quotient_DP[32:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_12 = {Quotient_DP[35:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_13 = {Quotient_DP[38:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_14 = {Quotient_DP[41:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_15 = {Quotient_DP[44:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_16 = {Quotient_DP[47:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_17 = {Quotient_DP[50:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_18 = {Quotient_DP[53:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_three_19 = {Quotient_DP[56:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2]};
  assign Qcnt_four_0 = {1'b0, Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]};
  assign Qcnt_four_1 = {
    Quotient_DP[3:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_2 = {
    Quotient_DP[7:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_3 = {
    Quotient_DP[11:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_4 = {
    Quotient_DP[15:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_5 = {
    Quotient_DP[19:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_6 = {
    Quotient_DP[23:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_7 = {
    Quotient_DP[27:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_8 = {
    Quotient_DP[31:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_9 = {
    Quotient_DP[35:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_10 = {
    Quotient_DP[39:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_11 = {
    Quotient_DP[43:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_12 = {
    Quotient_DP[47:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_13 = {
    Quotient_DP[51:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };
  assign Qcnt_four_14 = {
    Quotient_DP[55:0], Sqrt_quotinent_S[3], Sqrt_quotinent_S[2], Sqrt_quotinent_S[1]
  };

  always_comb begin

    case (Iteration_unit_num_S)
      2'b00: begin

        case (Crtl_cnt_S)

          6'b000000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_one_0};
            Sqrt_Q0 = Q_sqrt_com_0;
          end
          6'b000001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_one_1};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b000010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-3:C_MANT_FP64-4];
            Q_sqrt0 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_one_2};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b000011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-5:C_MANT_FP64-6];
            Q_sqrt0 = {{(C_MANT_FP64 + 3) {1'b0}}, Qcnt_one_3};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b000100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-7:C_MANT_FP64-8];
            Q_sqrt0 = {{(C_MANT_FP64 + 2) {1'b0}}, Qcnt_one_4};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b000101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-9:C_MANT_FP64-10];
            Q_sqrt0 = {{(C_MANT_FP64 + 1) {1'b0}}, Qcnt_one_5};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b000110: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-11:C_MANT_FP64-12];
            Q_sqrt0 = {{(C_MANT_FP64) {1'b0}}, Qcnt_one_6};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b000111: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-13:C_MANT_FP64-14];
            Q_sqrt0 = {{(C_MANT_FP64 - 1) {1'b0}}, Qcnt_one_7};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-15:C_MANT_FP64-16];
            Q_sqrt0 = {{(C_MANT_FP64 - 2) {1'b0}}, Qcnt_one_8};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-17:C_MANT_FP64-18];
            Q_sqrt0 = {{(C_MANT_FP64 - 3) {1'b0}}, Qcnt_one_9};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-19:C_MANT_FP64-20];
            Q_sqrt0 = {{(C_MANT_FP64 - 4) {1'b0}}, Qcnt_one_10};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-21:C_MANT_FP64-22];
            Q_sqrt0 = {{(C_MANT_FP64 - 5) {1'b0}}, Qcnt_one_11};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-23:C_MANT_FP64-24];
            Q_sqrt0 = {{(C_MANT_FP64 - 6) {1'b0}}, Qcnt_one_12};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-25:C_MANT_FP64-26];
            Q_sqrt0 = {{(C_MANT_FP64 - 7) {1'b0}}, Qcnt_one_13};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001110: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-27:C_MANT_FP64-28];
            Q_sqrt0 = {{(C_MANT_FP64 - 8) {1'b0}}, Qcnt_one_14};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b001111: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-29:C_MANT_FP64-30];
            Q_sqrt0 = {{(C_MANT_FP64 - 9) {1'b0}}, Qcnt_one_15};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-31:C_MANT_FP64-32];
            Q_sqrt0 = {{(C_MANT_FP64 - 10) {1'b0}}, Qcnt_one_16};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-33:C_MANT_FP64-34];
            Q_sqrt0 = {{(C_MANT_FP64 - 11) {1'b0}}, Qcnt_one_17};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-35:C_MANT_FP64-36];
            Q_sqrt0 = {{(C_MANT_FP64 - 12) {1'b0}}, Qcnt_one_18};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-37:C_MANT_FP64-38];
            Q_sqrt0 = {{(C_MANT_FP64 - 13) {1'b0}}, Qcnt_one_19};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-39:C_MANT_FP64-40];
            Q_sqrt0 = {{(C_MANT_FP64 - 14) {1'b0}}, Qcnt_one_20};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-41:C_MANT_FP64-42];
            Q_sqrt0 = {{(C_MANT_FP64 - 15) {1'b0}}, Qcnt_one_21};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010110: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-43:C_MANT_FP64-44];
            Q_sqrt0 = {{(C_MANT_FP64 - 16) {1'b0}}, Qcnt_one_22};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b010111: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-45:C_MANT_FP64-46];
            Q_sqrt0 = {{(C_MANT_FP64 - 17) {1'b0}}, Qcnt_one_23};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-47:C_MANT_FP64-48];
            Q_sqrt0 = {{(C_MANT_FP64 - 18) {1'b0}}, Qcnt_one_24};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-49:C_MANT_FP64-50];
            Q_sqrt0 = {{(C_MANT_FP64 - 19) {1'b0}}, Qcnt_one_25};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-51:C_MANT_FP64-52];
            Q_sqrt0 = {{(C_MANT_FP64 - 20) {1'b0}}, Qcnt_one_26};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 21) {1'b0}}, Qcnt_one_27};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 22) {1'b0}}, Qcnt_one_28};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 23) {1'b0}}, Qcnt_one_29};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 24) {1'b0}}, Qcnt_one_30};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b011111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 25) {1'b0}}, Qcnt_one_31};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 26) {1'b0}}, Qcnt_one_32};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 27) {1'b0}}, Qcnt_one_33};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 28) {1'b0}}, Qcnt_one_34};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 29) {1'b0}}, Qcnt_one_35};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 30) {1'b0}}, Qcnt_one_36};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 31) {1'b0}}, Qcnt_one_37};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 32) {1'b0}}, Qcnt_one_38};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b100111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 33) {1'b0}}, Qcnt_one_39};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 34) {1'b0}}, Qcnt_one_40};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 35) {1'b0}}, Qcnt_one_41};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 36) {1'b0}}, Qcnt_one_42};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 37) {1'b0}}, Qcnt_one_43};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 38) {1'b0}}, Qcnt_one_44};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 39) {1'b0}}, Qcnt_one_45};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 40) {1'b0}}, Qcnt_one_46};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b101111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 41) {1'b0}}, Qcnt_one_47};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 42) {1'b0}}, Qcnt_one_48};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 43) {1'b0}}, Qcnt_one_49};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 44) {1'b0}}, Qcnt_one_50};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 45) {1'b0}}, Qcnt_one_51};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 46) {1'b0}}, Qcnt_one_52};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 47) {1'b0}}, Qcnt_one_53};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 48) {1'b0}}, Qcnt_one_54};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b110111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 49) {1'b0}}, Qcnt_one_55};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end
          6'b111000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 50) {1'b0}}, Qcnt_one_56};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
          end

          default: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = '0;
            Sqrt_Q0 = '0;
          end
        endcase
      end

      2'b01: begin

        case (Crtl_cnt_S)

          6'b000000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_two_0[1]};
            Sqrt_Q0 = Q_sqrt_com_0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt1 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_two_0[1:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-3:C_MANT_FP64-4];
            Q_sqrt0 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_two_1[2:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-5:C_MANT_FP64-6];
            Q_sqrt1 = {{(C_MANT_FP64 + 3) {1'b0}}, Qcnt_two_1[2:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-7:C_MANT_FP64-8];
            Q_sqrt0 = {{(C_MANT_FP64 + 2) {1'b0}}, Qcnt_two_2[4:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-9:C_MANT_FP64-10];
            Q_sqrt1 = {{(C_MANT_FP64 + 1) {1'b0}}, Qcnt_two_2[4:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-11:C_MANT_FP64-12];
            Q_sqrt0 = {{(C_MANT_FP64) {1'b0}}, Qcnt_two_3[6:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-13:C_MANT_FP64-14];
            Q_sqrt1 = {{(C_MANT_FP64 - 1) {1'b0}}, Qcnt_two_3[6:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-15:C_MANT_FP64-16];
            Q_sqrt0 = {{(C_MANT_FP64 - 2) {1'b0}}, Qcnt_two_4[8:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-17:C_MANT_FP64-18];
            Q_sqrt1 = {{(C_MANT_FP64 - 3) {1'b0}}, Qcnt_two_4[8:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-19:C_MANT_FP64-20];
            Q_sqrt0 = {{(C_MANT_FP64 - 4) {1'b0}}, Qcnt_two_5[10:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-21:C_MANT_FP64-22];
            Q_sqrt1 = {{(C_MANT_FP64 - 5) {1'b0}}, Qcnt_two_5[10:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000110: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-23:C_MANT_FP64-24];
            Q_sqrt0 = {{(C_MANT_FP64 - 6) {1'b0}}, Qcnt_two_6[12:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-25:C_MANT_FP64-26];
            Q_sqrt1 = {{(C_MANT_FP64 - 7) {1'b0}}, Qcnt_two_6[12:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b000111: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-27:C_MANT_FP64-28];
            Q_sqrt0 = {{(C_MANT_FP64 - 8) {1'b0}}, Qcnt_two_7[14:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-29:C_MANT_FP64-30];
            Q_sqrt1 = {{(C_MANT_FP64 - 9) {1'b0}}, Qcnt_two_7[14:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-31:C_MANT_FP64-32];
            Q_sqrt0 = {{(C_MANT_FP64 - 10) {1'b0}}, Qcnt_two_8[16:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-33:C_MANT_FP64-34];
            Q_sqrt1 = {{(C_MANT_FP64 - 11) {1'b0}}, Qcnt_two_8[16:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-35:C_MANT_FP64-36];
            Q_sqrt0 = {{(C_MANT_FP64 - 12) {1'b0}}, Qcnt_two_9[18:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-37:C_MANT_FP64-38];
            Q_sqrt1 = {{(C_MANT_FP64 - 13) {1'b0}}, Qcnt_two_9[18:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-39:C_MANT_FP64-40];
            Q_sqrt0 = {{(C_MANT_FP64 - 14) {1'b0}}, Qcnt_two_10[20:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-41:C_MANT_FP64-42];
            Q_sqrt1 = {{(C_MANT_FP64 - 15) {1'b0}}, Qcnt_two_10[20:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-43:C_MANT_FP64-44];
            Q_sqrt0 = {{(C_MANT_FP64 - 16) {1'b0}}, Qcnt_two_11[22:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-45:C_MANT_FP64-46];
            Q_sqrt1 = {{(C_MANT_FP64 - 17) {1'b0}}, Qcnt_two_11[22:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-47:C_MANT_FP64-48];
            Q_sqrt0 = {{(C_MANT_FP64 - 18) {1'b0}}, Qcnt_two_12[24:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-49:C_MANT_FP64-50];
            Q_sqrt1 = {{(C_MANT_FP64 - 19) {1'b0}}, Qcnt_two_12[24:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-51:C_MANT_FP64-52];
            Q_sqrt0 = {{(C_MANT_FP64 - 20) {1'b0}}, Qcnt_two_13[26:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 21) {1'b0}}, Qcnt_two_13[26:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 22) {1'b0}}, Qcnt_two_14[28:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 23) {1'b0}}, Qcnt_two_14[28:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b001111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 24) {1'b0}}, Qcnt_two_15[30:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 25) {1'b0}}, Qcnt_two_15[30:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 26) {1'b0}}, Qcnt_two_16[32:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 27) {1'b0}}, Qcnt_two_16[32:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 28) {1'b0}}, Qcnt_two_17[34:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 29) {1'b0}}, Qcnt_two_17[34:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 30) {1'b0}}, Qcnt_two_18[36:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 31) {1'b0}}, Qcnt_two_18[36:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 32) {1'b0}}, Qcnt_two_19[38:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 33) {1'b0}}, Qcnt_two_19[38:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 34) {1'b0}}, Qcnt_two_20[40:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 35) {1'b0}}, Qcnt_two_20[40:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 36) {1'b0}}, Qcnt_two_21[42:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 37) {1'b0}}, Qcnt_two_21[42:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 38) {1'b0}}, Qcnt_two_22[44:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 39) {1'b0}}, Qcnt_two_22[44:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b010111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 40) {1'b0}}, Qcnt_two_23[46:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 41) {1'b0}}, Qcnt_two_23[46:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b011000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 42) {1'b0}}, Qcnt_two_24[48:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 43) {1'b0}}, Qcnt_two_24[48:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b011001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 44) {1'b0}}, Qcnt_two_25[50:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 45) {1'b0}}, Qcnt_two_25[50:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b011010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 46) {1'b0}}, Qcnt_two_26[52:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 47) {1'b0}}, Qcnt_two_26[52:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b011011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 48) {1'b0}}, Qcnt_two_27[54:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 49) {1'b0}}, Qcnt_two_27[54:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          6'b011100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 50) {1'b0}}, Qcnt_two_28[56:1]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 51) {1'b0}}, Qcnt_two_28[56:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

          default: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_two_0[1]};
            Sqrt_Q0 = Q_sqrt_com_0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt1 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_two_0[1:0]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
          end

        endcase
      end

      2'b10: begin

        case (Crtl_cnt_S)
          6'b000000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_three_0[2]};
            Sqrt_Q0 = Q_sqrt_com_0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt1 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_three_0[2:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-3:C_MANT_FP64-4];
            Q_sqrt2 = {{(C_MANT_FP64 + 3) {1'b0}}, Qcnt_three_0[2:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-5:C_MANT_FP64-6];
            Q_sqrt0 = {{(C_MANT_FP64 + 2) {1'b0}}, Qcnt_three_1[4:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-7:C_MANT_FP64-8];
            Q_sqrt1 = {{(C_MANT_FP64 + 1) {1'b0}}, Qcnt_three_1[4:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-9:C_MANT_FP64-10];
            Q_sqrt2 = {{(C_MANT_FP64) {1'b0}}, Qcnt_three_1[4:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-11:C_MANT_FP64-12];
            Q_sqrt0 = {{(C_MANT_FP64 - 1) {1'b0}}, Qcnt_three_2[7:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-13:C_MANT_FP64-14];
            Q_sqrt1 = {{(C_MANT_FP64 - 2) {1'b0}}, Qcnt_three_2[7:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-15:C_MANT_FP64-16];
            Q_sqrt2 = {{(C_MANT_FP64 - 3) {1'b0}}, Qcnt_three_2[7:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-17:C_MANT_FP64-18];
            Q_sqrt0 = {{(C_MANT_FP64 - 4) {1'b0}}, Qcnt_three_3[10:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-19:C_MANT_FP64-20];
            Q_sqrt1 = {{(C_MANT_FP64 - 5) {1'b0}}, Qcnt_three_3[10:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-21:C_MANT_FP64-22];
            Q_sqrt2 = {{(C_MANT_FP64 - 6) {1'b0}}, Qcnt_three_3[10:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-23:C_MANT_FP64-24];
            Q_sqrt0 = {{(C_MANT_FP64 - 7) {1'b0}}, Qcnt_three_4[13:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-25:C_MANT_FP64-26];
            Q_sqrt1 = {{(C_MANT_FP64 - 8) {1'b0}}, Qcnt_three_4[13:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-27:C_MANT_FP64-28];
            Q_sqrt2 = {{(C_MANT_FP64 - 9) {1'b0}}, Qcnt_three_4[13:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-29:C_MANT_FP64-30];
            Q_sqrt0 = {{(C_MANT_FP64 - 10) {1'b0}}, Qcnt_three_5[16:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-31:C_MANT_FP64-32];
            Q_sqrt1 = {{(C_MANT_FP64 - 11) {1'b0}}, Qcnt_three_5[16:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-33:C_MANT_FP64-34];
            Q_sqrt2 = {{(C_MANT_FP64 - 12) {1'b0}}, Qcnt_three_5[16:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000110: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-35:C_MANT_FP64-36];
            Q_sqrt0 = {{(C_MANT_FP64 - 13) {1'b0}}, Qcnt_three_6[19:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-37:C_MANT_FP64-38];
            Q_sqrt1 = {{(C_MANT_FP64 - 14) {1'b0}}, Qcnt_three_6[19:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-39:C_MANT_FP64-40];
            Q_sqrt2 = {{(C_MANT_FP64 - 15) {1'b0}}, Qcnt_three_6[19:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b000111: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-41:C_MANT_FP64-42];
            Q_sqrt0 = {{(C_MANT_FP64 - 16) {1'b0}}, Qcnt_three_7[22:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-43:C_MANT_FP64-44];
            Q_sqrt1 = {{(C_MANT_FP64 - 17) {1'b0}}, Qcnt_three_7[22:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-45:C_MANT_FP64-46];
            Q_sqrt2 = {{(C_MANT_FP64 - 18) {1'b0}}, Qcnt_three_7[22:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-47:C_MANT_FP64-48];
            Q_sqrt0 = {{(C_MANT_FP64 - 19) {1'b0}}, Qcnt_three_8[25:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-49:C_MANT_FP64-50];
            Q_sqrt1 = {{(C_MANT_FP64 - 20) {1'b0}}, Qcnt_three_8[25:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-51:C_MANT_FP64-52];
            Q_sqrt2 = {{(C_MANT_FP64 - 21) {1'b0}}, Qcnt_three_8[25:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 22) {1'b0}}, Qcnt_three_9[28:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 23) {1'b0}}, Qcnt_three_9[28:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 24) {1'b0}}, Qcnt_three_9[28:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 25) {1'b0}}, Qcnt_three_10[31:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 26) {1'b0}}, Qcnt_three_10[31:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 27) {1'b0}}, Qcnt_three_10[31:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 28) {1'b0}}, Qcnt_three_11[34:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 29) {1'b0}}, Qcnt_three_11[34:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 30) {1'b0}}, Qcnt_three_11[34:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 31) {1'b0}}, Qcnt_three_12[37:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 32) {1'b0}}, Qcnt_three_12[37:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 33) {1'b0}}, Qcnt_three_12[37:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 34) {1'b0}}, Qcnt_three_13[40:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 35) {1'b0}}, Qcnt_three_13[40:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 36) {1'b0}}, Qcnt_three_13[40:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001110: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 37) {1'b0}}, Qcnt_three_14[43:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 38) {1'b0}}, Qcnt_three_14[43:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 39) {1'b0}}, Qcnt_three_14[43:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b001111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 40) {1'b0}}, Qcnt_three_15[46:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 41) {1'b0}}, Qcnt_three_15[46:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 42) {1'b0}}, Qcnt_three_15[46:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b010000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 43) {1'b0}}, Qcnt_three_16[49:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 44) {1'b0}}, Qcnt_three_16[49:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 45) {1'b0}}, Qcnt_three_16[49:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b010001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 46) {1'b0}}, Qcnt_three_17[52:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 47) {1'b0}}, Qcnt_three_17[52:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 48) {1'b0}}, Qcnt_three_17[52:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          6'b010010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 49) {1'b0}}, Qcnt_three_18[55:2]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 50) {1'b0}}, Qcnt_three_18[55:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 51) {1'b0}}, Qcnt_three_18[55:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end

          default: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_three_0[2]};
            Sqrt_Q0 = Q_sqrt_com_0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt1 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_three_0[2:1]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-3:C_MANT_FP64-4];
            Q_sqrt2 = {{(C_MANT_FP64 + 3) {1'b0}}, Qcnt_three_0[2:0]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
          end
        endcase

      end

      2'b11: begin

        case (Crtl_cnt_S)

          6'b000000: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_four_0[3]};
            Sqrt_Q0 = Q_sqrt_com_0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt1 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_four_0[3:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-3:C_MANT_FP64-4];
            Q_sqrt2 = {{(C_MANT_FP64 + 3) {1'b0}}, Qcnt_four_0[3:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-5:C_MANT_FP64-6];
            Q_sqrt3 = {{(C_MANT_FP64 + 2) {1'b0}}, Qcnt_four_0[3:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000001: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-7:C_MANT_FP64-8];
            Q_sqrt0 = {{(C_MANT_FP64 + 1) {1'b0}}, Qcnt_four_1[6:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-9:C_MANT_FP64-10];
            Q_sqrt1 = {{(C_MANT_FP64) {1'b0}}, Qcnt_four_1[6:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-11:C_MANT_FP64-12];
            Q_sqrt2 = {{(C_MANT_FP64 - 1) {1'b0}}, Qcnt_four_1[6:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-13:C_MANT_FP64-14];
            Q_sqrt3 = {{(C_MANT_FP64 - 2) {1'b0}}, Qcnt_four_1[6:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000010: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-15:C_MANT_FP64-16];
            Q_sqrt0 = {{(C_MANT_FP64 - 3) {1'b0}}, Qcnt_four_2[10:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-17:C_MANT_FP64-18];
            Q_sqrt1 = {{(C_MANT_FP64 - 4) {1'b0}}, Qcnt_four_2[10:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-19:C_MANT_FP64-20];
            Q_sqrt2 = {{(C_MANT_FP64 - 5) {1'b0}}, Qcnt_four_2[10:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-21:C_MANT_FP64-22];
            Q_sqrt3 = {{(C_MANT_FP64 - 6) {1'b0}}, Qcnt_four_2[10:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000011: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-23:C_MANT_FP64-24];
            Q_sqrt0 = {{(C_MANT_FP64 - 7) {1'b0}}, Qcnt_four_3[14:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-25:C_MANT_FP64-26];
            Q_sqrt1 = {{(C_MANT_FP64 - 8) {1'b0}}, Qcnt_four_3[14:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-27:C_MANT_FP64-28];
            Q_sqrt2 = {{(C_MANT_FP64 - 9) {1'b0}}, Qcnt_four_3[14:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-29:C_MANT_FP64-30];
            Q_sqrt3 = {{(C_MANT_FP64 - 10) {1'b0}}, Qcnt_four_3[14:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000100: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-31:C_MANT_FP64-32];
            Q_sqrt0 = {{(C_MANT_FP64 - 11) {1'b0}}, Qcnt_four_4[18:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-33:C_MANT_FP64-34];
            Q_sqrt1 = {{(C_MANT_FP64 - 12) {1'b0}}, Qcnt_four_4[18:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-35:C_MANT_FP64-36];
            Q_sqrt2 = {{(C_MANT_FP64 - 13) {1'b0}}, Qcnt_four_4[18:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-37:C_MANT_FP64-38];
            Q_sqrt3 = {{(C_MANT_FP64 - 14) {1'b0}}, Qcnt_four_4[18:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000101: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-39:C_MANT_FP64-40];
            Q_sqrt0 = {{(C_MANT_FP64 - 15) {1'b0}}, Qcnt_four_5[22:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-41:C_MANT_FP64-42];
            Q_sqrt1 = {{(C_MANT_FP64 - 16) {1'b0}}, Qcnt_four_5[22:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-43:C_MANT_FP64-44];
            Q_sqrt2 = {{(C_MANT_FP64 - 17) {1'b0}}, Qcnt_four_5[22:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-45:C_MANT_FP64-46];
            Q_sqrt3 = {{(C_MANT_FP64 - 18) {1'b0}}, Qcnt_four_5[22:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000110: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64-47:C_MANT_FP64-48];
            Q_sqrt0 = {{(C_MANT_FP64 - 19) {1'b0}}, Qcnt_four_6[26:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-49:C_MANT_FP64-50];
            Q_sqrt1 = {{(C_MANT_FP64 - 20) {1'b0}}, Qcnt_four_6[26:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-51:C_MANT_FP64-52];
            Q_sqrt2 = {{(C_MANT_FP64 - 21) {1'b0}}, Qcnt_four_6[26:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 22) {1'b0}}, Qcnt_four_6[26:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b000111: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 23) {1'b0}}, Qcnt_four_7[30:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 24) {1'b0}}, Qcnt_four_7[30:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 25) {1'b0}}, Qcnt_four_7[30:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 26) {1'b0}}, Qcnt_four_7[30:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b001000: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 27) {1'b0}}, Qcnt_four_8[34:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 28) {1'b0}}, Qcnt_four_8[34:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 29) {1'b0}}, Qcnt_four_8[34:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 30) {1'b0}}, Qcnt_four_8[34:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b001001: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 31) {1'b0}}, Qcnt_four_9[38:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 32) {1'b0}}, Qcnt_four_9[38:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 33) {1'b0}}, Qcnt_four_9[38:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 34) {1'b0}}, Qcnt_four_9[38:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b001010: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 35) {1'b0}}, Qcnt_four_10[42:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 36) {1'b0}}, Qcnt_four_10[42:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 37) {1'b0}}, Qcnt_four_10[42:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 38) {1'b0}}, Qcnt_four_10[42:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b001011: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 39) {1'b0}}, Qcnt_four_11[46:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 40) {1'b0}}, Qcnt_four_11[46:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 41) {1'b0}}, Qcnt_four_11[46:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 42) {1'b0}}, Qcnt_four_11[46:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b001100: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 43) {1'b0}}, Qcnt_four_12[50:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 44) {1'b0}}, Qcnt_four_12[50:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 45) {1'b0}}, Qcnt_four_12[50:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 46) {1'b0}}, Qcnt_four_12[50:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          6'b001101: begin
            Sqrt_DI[0] = 2'b00;
            Q_sqrt0 = {{(C_MANT_FP64 - 47) {1'b0}}, Qcnt_four_13[54:3]};
            Sqrt_Q0 = Quotient_DP[0] ? Q_sqrt_com_0 : Q_sqrt0;
            Sqrt_DI[1] = 2'b00;
            Q_sqrt1 = {{(C_MANT_FP64 - 48) {1'b0}}, Qcnt_four_13[54:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = 2'b00;
            Q_sqrt2 = {{(C_MANT_FP64 - 49) {1'b0}}, Qcnt_four_13[54:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = 2'b00;
            Q_sqrt3 = {{(C_MANT_FP64 - 50) {1'b0}}, Qcnt_four_13[54:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end

          default: begin
            Sqrt_DI[0] = Mant_D_sqrt_Norm[C_MANT_FP64+1:C_MANT_FP64];
            Q_sqrt0 = {{(C_MANT_FP64 + 5) {1'b0}}, Qcnt_four_0[3]};
            Sqrt_Q0 = Q_sqrt_com_0;
            Sqrt_DI[1] = Mant_D_sqrt_Norm[C_MANT_FP64-1:C_MANT_FP64-2];
            Q_sqrt1 = {{(C_MANT_FP64 + 4) {1'b0}}, Qcnt_four_0[3:2]};
            Sqrt_Q1 = Sqrt_quotinent_S[3] ? Q_sqrt_com_1 : Q_sqrt1;
            Sqrt_DI[2] = Mant_D_sqrt_Norm[C_MANT_FP64-3:C_MANT_FP64-4];
            Q_sqrt2 = {{(C_MANT_FP64 + 3) {1'b0}}, Qcnt_four_0[3:1]};
            Sqrt_Q2 = Sqrt_quotinent_S[2] ? Q_sqrt_com_2 : Q_sqrt2;
            Sqrt_DI[3] = Mant_D_sqrt_Norm[C_MANT_FP64-5:C_MANT_FP64-6];
            Q_sqrt3 = {{(C_MANT_FP64 + 2) {1'b0}}, Qcnt_four_0[3:0]};
            Sqrt_Q3 = Sqrt_quotinent_S[1] ? Q_sqrt_com_3 : Q_sqrt3;
          end
        endcase
      end
    endcase

  end
  assign Sqrt_R0 = ((Sqrt_start_dly_S) ? '0 : {Partial_remainder_DP[C_MANT_FP64+5:0]});
  assign Sqrt_R1 = {
    Iteration_cell_sum_AMASK_D[0][C_MANT_FP64+5],
    Iteration_cell_sum_AMASK_D[0][C_MANT_FP64+2:0],
    Sqrt_DO[0]
  };
  assign Sqrt_R2 = {
    Iteration_cell_sum_AMASK_D[1][C_MANT_FP64+5],
    Iteration_cell_sum_AMASK_D[1][C_MANT_FP64+2:0],
    Sqrt_DO[1]
  };
  assign Sqrt_R3 = {
    Iteration_cell_sum_AMASK_D[2][C_MANT_FP64+5],
    Iteration_cell_sum_AMASK_D[2][C_MANT_FP64+2:0],
    Sqrt_DO[2]
  };
  assign Sqrt_R4 = {
    Iteration_cell_sum_AMASK_D[3][C_MANT_FP64+5],
    Iteration_cell_sum_AMASK_D[3][C_MANT_FP64+2:0],
    Sqrt_DO[3]
  };

  logic [C_MANT_FP64+5:0] Denominator_se_format_DB;

  assign Denominator_se_format_DB = {
    Denominator_se_DB[C_MANT_FP64+1:C_MANT_FP64-C_MANT_FP16ALT],
    {FP16ALT_SO ? FP16ALT_SO : Denominator_se_DB[C_MANT_FP64-C_MANT_FP16ALT-1]},
    Denominator_se_DB[C_MANT_FP64-C_MANT_FP16ALT-2:C_MANT_FP64-C_MANT_FP16],
    {FP16_SO ? FP16_SO : Denominator_se_DB[C_MANT_FP64-C_MANT_FP16-1]},
    Denominator_se_DB[C_MANT_FP64-C_MANT_FP16-2:C_MANT_FP64-C_MANT_FP32],
    {FP32_SO ? FP32_SO : Denominator_se_DB[C_MANT_FP64-C_MANT_FP32-1]},
    Denominator_se_DB[C_MANT_FP64-C_MANT_FP32-2:C_MANT_FP64-C_MANT_FP64],
    FP64_SO,
    3'b0
  };

  logic [C_MANT_FP64+5:0] First_iteration_cell_div_a_D, First_iteration_cell_div_b_D;
  logic Sel_b_for_first_S;
  assign First_iteration_cell_div_a_D=(Div_start_dly_S)?{Numerator_se_D[C_MANT_FP64+1:C_MANT_FP64-C_MANT_FP16ALT],{FP16ALT_SO?FP16ALT_SO:Numerator_se_D[C_MANT_FP64-C_MANT_FP16ALT-1]},
                                                         Numerator_se_D[C_MANT_FP64-C_MANT_FP16ALT-2:C_MANT_FP64-C_MANT_FP16],{FP16_SO?FP16_SO:Numerator_se_D[C_MANT_FP64-C_MANT_FP16-1]},
                                                         Numerator_se_D[C_MANT_FP64-C_MANT_FP16-2:C_MANT_FP64-C_MANT_FP32],{FP32_SO?FP32_SO:Numerator_se_D[C_MANT_FP64-C_MANT_FP32-1]},
                                                         Numerator_se_D[C_MANT_FP64-C_MANT_FP32-2:C_MANT_FP64-C_MANT_FP64],FP64_SO,3'b0}
                                                        :{Partial_remainder_DP[C_MANT_FP64+4:C_MANT_FP64-C_MANT_FP16ALT+3],{FP16ALT_SO?Quotient_DP[0]:Partial_remainder_DP[C_MANT_FP64-C_MANT_FP16ALT+2]},
                                                         Partial_remainder_DP[C_MANT_FP64-C_MANT_FP16ALT+1:C_MANT_FP64-C_MANT_FP16+3],{FP16_SO?Quotient_DP[0]:Partial_remainder_DP[C_MANT_FP64-C_MANT_FP16+2]},
                                                         Partial_remainder_DP[C_MANT_FP64-C_MANT_FP16+1:C_MANT_FP64-C_MANT_FP32+3],{FP32_SO?Quotient_DP[0]:Partial_remainder_DP[C_MANT_FP64-C_MANT_FP32+2]},
                                                         Partial_remainder_DP[C_MANT_FP64-C_MANT_FP32+1:C_MANT_FP64-C_MANT_FP64+3],FP64_SO&&Quotient_DP[0],3'b0};
  assign Sel_b_for_first_S = (Div_start_dly_S) ? 1 : Quotient_DP[0];
  assign First_iteration_cell_div_b_D=Sel_b_for_first_S?Denominator_se_format_DB:{Denominator_se_D,4'b0};
  assign Iteration_cell_a_BMASK_D[0] = Sqrt_enable_SO ? Sqrt_R0 : {First_iteration_cell_div_a_D};
  assign Iteration_cell_b_BMASK_D[0] = Sqrt_enable_SO ? Sqrt_Q0 : {First_iteration_cell_div_b_D};

  logic [C_MANT_FP64+5:0] Sec_iteration_cell_div_a_D, Sec_iteration_cell_div_b_D;
  logic Sel_b_for_sec_S;
  generate
    if (|Iteration_unit_num_S) begin
      assign Sel_b_for_sec_S = ~Iteration_cell_sum_AMASK_D[0][C_MANT_FP64+5];
      assign Sec_iteration_cell_div_a_D = {
        Iteration_cell_sum_AMASK_D[0][C_MANT_FP64+4:C_MANT_FP64-C_MANT_FP16ALT+3],
        {
          FP16ALT_SO ? Sel_b_for_sec_S : Iteration_cell_sum_AMASK_D[0][C_MANT_FP64-C_MANT_FP16ALT+2]
        },
        Iteration_cell_sum_AMASK_D[0][C_MANT_FP64-C_MANT_FP16ALT+1:C_MANT_FP64-C_MANT_FP16+3],
        {FP16_SO ? Sel_b_for_sec_S : Iteration_cell_sum_AMASK_D[0][C_MANT_FP64-C_MANT_FP16+2]},
        Iteration_cell_sum_AMASK_D[0][C_MANT_FP64-C_MANT_FP16+1:C_MANT_FP64-C_MANT_FP32+3],
        {FP32_SO ? Sel_b_for_sec_S : Iteration_cell_sum_AMASK_D[0][C_MANT_FP64-C_MANT_FP32+2]},
        Iteration_cell_sum_AMASK_D[0][C_MANT_FP64-C_MANT_FP32+1:C_MANT_FP64-C_MANT_FP64+3],
        FP64_SO && Sel_b_for_sec_S,
        3'b0
      };
      assign Sec_iteration_cell_div_b_D=Sel_b_for_sec_S?Denominator_se_format_DB:{Denominator_se_D,4'b0};
      assign Iteration_cell_a_BMASK_D[1] = Sqrt_enable_SO ? Sqrt_R1 : {Sec_iteration_cell_div_a_D};
      assign Iteration_cell_b_BMASK_D[1] = Sqrt_enable_SO ? Sqrt_Q1 : {Sec_iteration_cell_div_b_D};
    end
  endgenerate

  logic [C_MANT_FP64+5:0] Thi_iteration_cell_div_a_D, Thi_iteration_cell_div_b_D;
  logic Sel_b_for_thi_S;
  generate
    if ((Iteration_unit_num_S == 2'b10) | (Iteration_unit_num_S == 2'b11)) begin
      assign Sel_b_for_thi_S = ~Iteration_cell_sum_AMASK_D[1][C_MANT_FP64+5];
      assign Thi_iteration_cell_div_a_D = {
        Iteration_cell_sum_AMASK_D[1][C_MANT_FP64+4:C_MANT_FP64-C_MANT_FP16ALT+3],
        {
          FP16ALT_SO ? Sel_b_for_thi_S : Iteration_cell_sum_AMASK_D[1][C_MANT_FP64-C_MANT_FP16ALT+2]
        },
        Iteration_cell_sum_AMASK_D[1][C_MANT_FP64-C_MANT_FP16ALT+1:C_MANT_FP64-C_MANT_FP16+3],
        {FP16_SO ? Sel_b_for_thi_S : Iteration_cell_sum_AMASK_D[1][C_MANT_FP64-C_MANT_FP16+2]},
        Iteration_cell_sum_AMASK_D[1][C_MANT_FP64-C_MANT_FP16+1:C_MANT_FP64-C_MANT_FP32+3],
        {FP32_SO ? Sel_b_for_thi_S : Iteration_cell_sum_AMASK_D[1][C_MANT_FP64-C_MANT_FP32+2]},
        Iteration_cell_sum_AMASK_D[1][C_MANT_FP64-C_MANT_FP32+1:C_MANT_FP64-C_MANT_FP64+3],
        FP64_SO && Sel_b_for_thi_S,
        3'b0
      };
      assign Thi_iteration_cell_div_b_D=Sel_b_for_thi_S?Denominator_se_format_DB:{Denominator_se_D,4'b0};
      assign Iteration_cell_a_BMASK_D[2] = Sqrt_enable_SO ? Sqrt_R2 : {Thi_iteration_cell_div_a_D};
      assign Iteration_cell_b_BMASK_D[2] = Sqrt_enable_SO ? Sqrt_Q2 : {Thi_iteration_cell_div_b_D};
    end
  endgenerate

  logic [C_MANT_FP64+5:0] Fou_iteration_cell_div_a_D, Fou_iteration_cell_div_b_D;
  logic Sel_b_for_fou_S;

  generate
    if (Iteration_unit_num_S == 2'b11) begin
      assign Sel_b_for_fou_S = ~Iteration_cell_sum_AMASK_D[2][C_MANT_FP64+5];
      assign Fou_iteration_cell_div_a_D = {
        Iteration_cell_sum_AMASK_D[2][C_MANT_FP64+4:C_MANT_FP64-C_MANT_FP16ALT+3],
        {
          FP16ALT_SO ? Sel_b_for_fou_S : Iteration_cell_sum_AMASK_D[2][C_MANT_FP64-C_MANT_FP16ALT+2]
        },
        Iteration_cell_sum_AMASK_D[2][C_MANT_FP64-C_MANT_FP16ALT+1:C_MANT_FP64-C_MANT_FP16+3],
        {FP16_SO ? Sel_b_for_fou_S : Iteration_cell_sum_AMASK_D[2][C_MANT_FP64-C_MANT_FP16+2]},
        Iteration_cell_sum_AMASK_D[2][C_MANT_FP64-C_MANT_FP16+1:C_MANT_FP64-C_MANT_FP32+3],
        {FP32_SO ? Sel_b_for_fou_S : Iteration_cell_sum_AMASK_D[2][C_MANT_FP64-C_MANT_FP32+2]},
        Iteration_cell_sum_AMASK_D[2][C_MANT_FP64-C_MANT_FP32+1:C_MANT_FP64-C_MANT_FP64+3],
        FP64_SO && Sel_b_for_fou_S,
        3'b0
      };
      assign Fou_iteration_cell_div_b_D=Sel_b_for_fou_S?Denominator_se_format_DB:{Denominator_se_D,4'b0};
      assign Iteration_cell_a_BMASK_D[3] = Sqrt_enable_SO ? Sqrt_R3 : {Fou_iteration_cell_div_a_D};
      assign Iteration_cell_b_BMASK_D[3] = Sqrt_enable_SO ? Sqrt_Q3 : {Fou_iteration_cell_div_b_D};
    end
  endgenerate

  logic [C_MANT_FP64+1+4:0] Mask_bits_ctl_S;

  assign Mask_bits_ctl_S = 58'h3ff_ffff_ffff_ffff;

  logic Div_enable_SI   [3:0];
  logic Div_start_dly_SI[3:0];
  logic Sqrt_enable_SI  [3:0];
  generate
    genvar i, j;
    for (i = 0; i <= Iteration_unit_num_S; i++) begin
      for (j = 0; j <= C_MANT_FP64 + 5; j++) begin
        assign Iteration_cell_a_D[i][j] = Mask_bits_ctl_S[j] && Iteration_cell_a_BMASK_D[i][j];
        assign Iteration_cell_b_D[i][j] = Mask_bits_ctl_S[j] && Iteration_cell_b_BMASK_D[i][j];
        assign Iteration_cell_sum_AMASK_D[i][j] = Mask_bits_ctl_S[j] && Iteration_cell_sum_D[i][j];
      end

      assign Div_enable_SI[i] = Div_enable_SO;
      assign Div_start_dly_SI[i] = Div_start_dly_S;
      assign Sqrt_enable_SI[i] = Sqrt_enable_SO;
      iteration_div_sqrt_mvp #(C_MANT_FP64 + 6) iteration_div_sqrt (
          .A_DI            (Iteration_cell_a_D[i]),
          .B_DI            (Iteration_cell_b_D[i]),
          .Div_enable_SI   (Div_enable_SI[i]),
          .Div_start_dly_SI(Div_start_dly_SI[i]),
          .Sqrt_enable_SI  (Sqrt_enable_SI[i]),
          .D_DI            (Sqrt_DI[i]),
          .D_DO            (Sqrt_DO[i]),
          .Sum_DO          (Iteration_cell_sum_D[i]),
          .Carry_out_DO    (Iteration_cell_carry_D[i])
      );

    end

  endgenerate
  always_comb begin
    case (Iteration_unit_num_S)
      2'b00: begin
        if (Fsm_enable_S)
          Partial_remainder_DN = Sqrt_enable_SO ? Sqrt_R1 : Iteration_cell_sum_AMASK_D[0];
        else Partial_remainder_DN = Partial_remainder_DP;
      end
      2'b01: begin
        if (Fsm_enable_S)
          Partial_remainder_DN = Sqrt_enable_SO ? Sqrt_R2 : Iteration_cell_sum_AMASK_D[1];
        else Partial_remainder_DN = Partial_remainder_DP;
      end
      2'b10: begin
        if (Fsm_enable_S)
          Partial_remainder_DN = Sqrt_enable_SO ? Sqrt_R3 : Iteration_cell_sum_AMASK_D[2];
        else Partial_remainder_DN = Partial_remainder_DP;
      end
      2'b11: begin
        if (Fsm_enable_S)
          Partial_remainder_DN = Sqrt_enable_SO ? Sqrt_R4 : Iteration_cell_sum_AMASK_D[3];
        else Partial_remainder_DN = Partial_remainder_DP;
      end
    endcase
  end
  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Partial_remainder_DP <= '0;
    end else begin
      Partial_remainder_DP <= Partial_remainder_DN;
    end
  end

  logic [C_MANT_FP64+4:0] Quotient_DN;

  always_comb begin
    case (Iteration_unit_num_S)
      2'b00: begin
        if (Fsm_enable_S)
          Quotient_DN= Sqrt_enable_SO ? {Quotient_DP[C_MANT_FP64+3:0],Sqrt_quotinent_S[3]} :{Quotient_DP[C_MANT_FP64+3:0],Iteration_cell_carry_D[0]};
        else Quotient_DN = Quotient_DP;
      end
      2'b01: begin
        if (Fsm_enable_S)
          Quotient_DN= Sqrt_enable_SO ? {Quotient_DP[C_MANT_FP64+2:0],Sqrt_quotinent_S[3:2]} :{Quotient_DP[C_MANT_FP64+2:0],Iteration_cell_carry_D[0],Iteration_cell_carry_D[1]};
        else Quotient_DN = Quotient_DP;
      end
      2'b10: begin
        if (Fsm_enable_S)
          Quotient_DN= Sqrt_enable_SO ? {Quotient_DP[C_MANT_FP64+1:0],Sqrt_quotinent_S[3:1]} : {Quotient_DP[C_MANT_FP64+1:0],Iteration_cell_carry_D[0],Iteration_cell_carry_D[1],Iteration_cell_carry_D[2]};
        else Quotient_DN = Quotient_DP;
      end
      2'b11: begin
        if (Fsm_enable_S)
          Quotient_DN= Sqrt_enable_SO ? {Quotient_DP[C_MANT_FP64:0],Sqrt_quotinent_S } : {Quotient_DP[C_MANT_FP64:0],Iteration_cell_carry_D[0],Iteration_cell_carry_D[1],Iteration_cell_carry_D[2],Iteration_cell_carry_D[3]};
        else Quotient_DN = Quotient_DP;
      end
    endcase
  end

  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Quotient_DP <= '0;
    end else Quotient_DP <= Quotient_DN;
  end

  generate
    if (Iteration_unit_num_S == 2'b00) begin
      always_comb begin
        case (Format_sel_S)
          2'b00: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+4:0], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
                };
              end
              6'h17: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32:0], {(C_MANT_FP64 - C_MANT_FP32 + 4) {1'b0}}
                };
              end
              6'h16: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-1:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 1) {1'b0}}
                };
              end
              6'h15: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-2:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 2) {1'b0}}
                };
              end
              6'h14: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-3:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 3) {1'b0}}
                };
              end
              6'h13: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-4:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 4) {1'b0}}
                };
              end
              6'h12: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-5:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 5) {1'b0}}
                };
              end
              6'h11: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-6:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 6) {1'b0}}
                };
              end
              6'h10: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-7:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 7) {1'b0}}
                };
              end
              6'h0f: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-8:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 8) {1'b0}}
                };
              end
              6'h0e: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-9:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 9) {1'b0}}
                };
              end
              6'h0d: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-10:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 10) {1'b0}}
                };
              end
              6'h0c: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-11:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 11) {1'b0}}
                };
              end
              6'h0b: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-12:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 12) {1'b0}}
                };
              end
              6'h0a: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-13:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 13) {1'b0}}
                };
              end
              6'h09: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-14:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 14) {1'b0}}
                };
              end
              6'h08: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-15:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 15) {1'b0}}
                };
              end
              6'h07: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-16:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 16) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+4:0], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
                };
              end
            endcase
          end

          2'b01: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = Quotient_DP[C_MANT_FP64+4:0];
              end
              6'h34: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64:0], {(4) {1'b0}}};
              end
              6'h33: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-1:0], {(4 + 1) {1'b0}}};
              end
              6'h32: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-2:0], {(4 + 2) {1'b0}}};
              end
              6'h31: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-3:0], {(4 + 3) {1'b0}}};
              end
              6'h30: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-4:0], {(4 + 4) {1'b0}}};
              end
              6'h2f: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-5:0], {(4 + 5) {1'b0}}};
              end
              6'h2e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-6:0], {(4 + 6) {1'b0}}};
              end
              6'h2d: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-7:0], {(4 + 7) {1'b0}}};
              end
              6'h2c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-8:0], {(4 + 8) {1'b0}}};
              end
              6'h2b: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-9:0], {(4 + 9) {1'b0}}};
              end
              6'h2a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-10:0], {(4 + 10) {1'b0}}};
              end
              6'h29: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-11:0], {(4 + 11) {1'b0}}};
              end
              6'h28: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-12:0], {(4 + 12) {1'b0}}};
              end
              6'h27: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-13:0], {(4 + 13) {1'b0}}};
              end
              6'h26: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-14:0], {(4 + 14) {1'b0}}};
              end
              6'h25: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-15:0], {(4 + 15) {1'b0}}};
              end
              6'h24: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-16:0], {(4 + 16) {1'b0}}};
              end
              6'h23: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-17:0], {(4 + 17) {1'b0}}};
              end
              6'h22: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-18:0], {(4 + 18) {1'b0}}};
              end
              6'h21: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-19:0], {(4 + 19) {1'b0}}};
              end
              6'h20: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-20:0], {(4 + 20) {1'b0}}};
              end
              6'h1f: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-21:0], {(4 + 21) {1'b0}}};
              end
              6'h1e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-22:0], {(4 + 22) {1'b0}}};
              end
              6'h1d: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-23:0], {(4 + 23) {1'b0}}};
              end
              6'h1c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-24:0], {(4 + 24) {1'b0}}};
              end
              6'h1b: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-25:0], {(4 + 25) {1'b0}}};
              end
              6'h1a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-26:0], {(4 + 26) {1'b0}}};
              end
              6'h19: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-27:0], {(4 + 27) {1'b0}}};
              end
              6'h18: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-28:0], {(4 + 28) {1'b0}}};
              end
              6'h17: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-29:0], {(4 + 29) {1'b0}}};
              end
              6'h16: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-30:0], {(4 + 30) {1'b0}}};
              end
              6'h15: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-31:0], {(4 + 31) {1'b0}}};
              end
              6'h14: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-32:0], {(4 + 32) {1'b0}}};
              end
              6'h13: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-33:0], {(4 + 33) {1'b0}}};
              end
              6'h12: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-34:0], {(4 + 34) {1'b0}}};
              end
              6'h11: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-35:0], {(4 + 35) {1'b0}}};
              end
              6'h10: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-36:0], {(4 + 36) {1'b0}}};
              end
              6'h0f: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-37:0], {(4 + 37) {1'b0}}};
              end
              6'h0e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-38:0], {(4 + 38) {1'b0}}};
              end
              6'h0d: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-39:0], {(4 + 39) {1'b0}}};
              end
              6'h0c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-40:0], {(4 + 40) {1'b0}}};
              end
              6'h0b: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-41:0], {(4 + 41) {1'b0}}};
              end
              6'h0a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-42:0], {(4 + 42) {1'b0}}};
              end
              6'h09: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-43:0], {(4 + 43) {1'b0}}};
              end
              6'h08: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-44:0], {(4 + 44) {1'b0}}};
              end
              6'h07: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-45:0], {(4 + 45) {1'b0}}};
              end
              default: begin
                Mant_result_prenorm_DO = Quotient_DP[C_MANT_FP64+4:0];
              end
            endcase
          end

          2'b10: begin
            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+4:0], {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
                };
              end
              6'h0a: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16:0], {(C_MANT_FP64 - C_MANT_FP16 + 4) {1'b0}}
                };
              end
              6'h09: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16-1:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 1) {1'b0}}
                };
              end
              6'h08: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16-2:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 2) {1'b0}}
                };
              end
              6'h07: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16-3:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 3) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+4:0], {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
                };
              end
            endcase
          end

          2'b11: begin

            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
              6'h07: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT:0], {(C_MANT_FP64 - C_MANT_FP16ALT + 4) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
            endcase
          end
        endcase
      end
    end
  endgenerate
  generate
    if (Iteration_unit_num_S == 2'b01) begin
      always_comb begin
        case (Format_sel_S)
          2'b00: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+4:0], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
                };
              end
              6'h17, 6'h16: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32:0], {(C_MANT_FP64 - C_MANT_FP32 + 4) {1'b0}}
                };
              end
              6'h15, 6'h14: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-2:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 2) {1'b0}}
                };
              end
              6'h13, 6'h12: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-4:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 4) {1'b0}}
                };
              end
              6'h11, 6'h10: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-6:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 6) {1'b0}}
                };
              end
              6'h0f, 6'h0e: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-8:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 8) {1'b0}}
                };
              end
              6'h0d, 6'h0c: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-10:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 10) {1'b0}}
                };
              end
              6'h0b, 6'h0a: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-12:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 12) {1'b0}}
                };
              end
              6'h09, 6'h08: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-14:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 14) {1'b0}}
                };
              end
              6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-16:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 16) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+4:0], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
                };
              end
            endcase
          end
          2'b01: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+3:0], 1'b0};
              end
              6'h34: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+1:1], {(4) {1'b0}}};
              end
              6'h33, 6'h32: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-1:0], {(4 + 1) {1'b0}}};
              end
              6'h31, 6'h30: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-3:0], {(4 + 3) {1'b0}}};
              end
              6'h2f, 6'h2e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-5:0], {(4 + 5) {1'b0}}};
              end
              6'h2d, 6'h2c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-7:0], {(4 + 7) {1'b0}}};
              end
              6'h2b, 6'h2a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-9:0], {(4 + 9) {1'b0}}};
              end
              6'h29, 6'h28: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-11:0], {(4 + 11) {1'b0}}};
              end
              6'h27, 6'h26: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-13:0], {(4 + 13) {1'b0}}};
              end
              6'h25, 6'h24: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-15:0], {(4 + 15) {1'b0}}};
              end
              6'h23, 6'h22: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-17:0], {(4 + 17) {1'b0}}};
              end
              6'h21, 6'h20: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-19:0], {(4 + 19) {1'b0}}};
              end
              6'h1f, 6'h1e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-21:0], {(4 + 21) {1'b0}}};
              end
              6'h1d, 6'h1c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-23:0], {(4 + 23) {1'b0}}};
              end
              6'h1b, 6'h1a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-25:0], {(4 + 25) {1'b0}}};
              end
              6'h19, 6'h18: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-27:0], {(4 + 27) {1'b0}}};
              end
              6'h17, 6'h16: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-29:0], {(4 + 29) {1'b0}}};
              end
              6'h15, 6'h14: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-31:0], {(4 + 31) {1'b0}}};
              end
              6'h13, 6'h12: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-33:0], {(4 + 33) {1'b0}}};
              end
              6'h11, 6'h10: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-35:0], {(4 + 35) {1'b0}}};
              end
              6'h0f, 6'h0e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-37:0], {(4 + 37) {1'b0}}};
              end
              6'h0d, 6'h0c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-39:0], {(4 + 39) {1'b0}}};
              end
              6'h0b, 6'h0a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-41:0], {(4 + 41) {1'b0}}};
              end
              6'h09, 6'h08: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-43:0], {(4 + 43) {1'b0}}};
              end
              6'h07: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-45:0], {(4 + 45) {1'b0}}};
              end
              default: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+3:0], 1'b0};
              end
            endcase
          end

          2'b10: begin
            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+3:0], {(C_MANT_FP64 - C_MANT_FP16 + 1) {1'b0}}
                };
              end
              6'h0a: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+1:1], {(C_MANT_FP64 - C_MANT_FP16 + 4) {1'b0}}
                };
              end
              6'h09, 6'h08: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16-1:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 1) {1'b0}}
                };
              end
              6'h07: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16-3:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 3) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+4:0], {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
                };
              end
            endcase
          end

          2'b11: begin

            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
              6'h07: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT:0], {(C_MANT_FP64 - C_MANT_FP16ALT + 4) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
            endcase
          end
        endcase
      end
    end
  endgenerate
  generate
    if (Iteration_unit_num_S == 2'b10) begin
      always_comb begin
        case (Format_sel_S)
          2'b00: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+3:0], {(C_MANT_FP64 - C_MANT_FP32 + 1) {1'b0}}
                };
              end
              6'h17, 6'h16, 6'h15: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32:0], {(C_MANT_FP64 - C_MANT_FP32 + 4) {1'b0}}
                };
              end
              6'h14, 6'h13, 6'h12: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-3:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 3) {1'b0}}
                };
              end
              6'h11, 6'h10, 6'h0f: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-6:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 6) {1'b0}}
                };
              end
              6'h0e, 6'h0d, 6'h0c: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-9:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 9) {1'b0}}
                };
              end
              6'h0b, 6'h0a, 6'h09: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-12:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 12) {1'b0}}
                };
              end
              6'h08, 6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-15:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 15) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+3:0], {(C_MANT_FP64 - C_MANT_FP32 + 1) {1'b0}}
                };
              end
            endcase
          end

          2'b01: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = Quotient_DP[C_MANT_FP64+4:0];
              end
              6'h34, 6'h33: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+1:1], {(4) {1'b0}}};
              end
              6'h32, 6'h31, 6'h30: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-2:0], {(4 + 2) {1'b0}}};
              end
              6'h2f, 6'h2e, 6'h2d: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-5:0], {(4 + 5) {1'b0}}};
              end
              6'h2c, 6'h2b, 6'h2a: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-8:0], {(4 + 8) {1'b0}}};
              end
              6'h29, 6'h28, 6'h27: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-11:0], {(4 + 11) {1'b0}}};
              end
              6'h26, 6'h25, 6'h24: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-14:0], {(4 + 14) {1'b0}}};
              end
              6'h23, 6'h22, 6'h21: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-17:0], {(4 + 17) {1'b0}}};
              end
              6'h20, 6'h1f, 6'h1e: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-20:0], {(4 + 20) {1'b0}}};
              end
              6'h1d, 6'h1c, 6'h1b: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-23:0], {(4 + 23) {1'b0}}};
              end
              6'h1a, 6'h19, 6'h18: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-26:0], {(4 + 26) {1'b0}}};
              end
              6'h17, 6'h16, 6'h15: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-29:0], {(4 + 29) {1'b0}}};
              end
              6'h14, 6'h13, 6'h12: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-32:0], {(4 + 32) {1'b0}}};
              end
              6'h11, 6'h10, 6'h0f: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-35:0], {(4 + 35) {1'b0}}};
              end
              6'h0e, 6'h0d, 6'h0c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-38:0], {(4 + 38) {1'b0}}};
              end
              6'h0b, 6'h0a, 6'h09: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-41:0], {(4 + 41) {1'b0}}};
              end
              6'h08, 6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-44:0], {(4 + 44) {1'b0}}};
              end
              default: begin
                Mant_result_prenorm_DO = Quotient_DP[C_MANT_FP64+4:0];
              end
            endcase
          end

          2'b10: begin
            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+4:0], {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
                };
              end
              6'h0a, 6'h09: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+1:1], {(C_MANT_FP64 - C_MANT_FP16 + 4) {1'b0}}
                };
              end
              6'h08, 6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16-2:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 2) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+4:0], {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
                };
              end
            endcase
          end

          2'b11: begin

            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
              6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+1:1], {(C_MANT_FP64 - C_MANT_FP16ALT + 4) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
            endcase
          end
        endcase
      end
    end
  endgenerate
  generate
    if (Iteration_unit_num_S == 2'b11) begin
      always_comb begin
        case (Format_sel_S)
          2'b00: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+4:0], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
                };
              end
              6'h17, 6'h16, 6'h15, 6'h14: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32:0], {(C_MANT_FP64 - C_MANT_FP32 + 4) {1'b0}}
                };
              end
              6'h13, 6'h12, 6'h11, 6'h10: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-4:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 4) {1'b0}}
                };
              end
              6'h0f, 6'h0e, 6'h0d, 6'h0c: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-8:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 8) {1'b0}}
                };
              end
              6'h0b, 6'h0a, 6'h09, 6'h08: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-12:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 12) {1'b0}}
                };
              end
              6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32-16:0], {(C_MANT_FP64 - C_MANT_FP32 + 4 + 16) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP32+4:0], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
                };
              end
            endcase
          end

          2'b01: begin
            case (Precision_ctl_S)
              6'h00: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+3:0], {(1) {1'b0}}};
              end
              6'h34: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+3:0], {(1) {1'b0}}};
              end
              6'h33, 6'h32, 6'h31, 6'h30: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-1:0], {(5) {1'b0}}};
              end
              6'h2f, 6'h2e, 6'h2d, 6'h2c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-5:0], {(9) {1'b0}}};
              end
              6'h2b, 6'h2a, 6'h29, 6'h28: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-9:0], {(13) {1'b0}}};
              end
              6'h27, 6'h26, 6'h25, 6'h24: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-13:0], {(17) {1'b0}}};
              end
              6'h23, 6'h22, 6'h21, 6'h20: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-17:0], {(21) {1'b0}}};
              end
              6'h1f, 6'h1e, 6'h1d, 6'h1c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-21:0], {(25) {1'b0}}};
              end
              6'h1b, 6'h1a, 6'h19, 6'h18: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-25:0], {(29) {1'b0}}};
              end
              6'h17, 6'h16, 6'h15, 6'h14: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-29:0], {(33) {1'b0}}};
              end
              6'h13, 6'h12, 6'h11, 6'h10: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-33:0], {(37) {1'b0}}};
              end
              6'h0f, 6'h0e, 6'h0d, 6'h0c: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-37:0], {(41) {1'b0}}};
              end
              6'h0b, 6'h0a, 6'h09, 6'h08: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-41:0], {(45) {1'b0}}};
              end
              6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64-45:0], {(49) {1'b0}}};
              end
              default: begin
                Mant_result_prenorm_DO = {Quotient_DP[C_MANT_FP64+3:0], {(1) {1'b0}}};
              end
            endcase
          end

          2'b10: begin
            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+5:0], {(C_MANT_FP64 - C_MANT_FP16 - 1) {1'b0}}
                };
              end
              6'h0a, 6'h09, 6'h08: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+1:1], {(C_MANT_FP64 - C_MANT_FP16 + 4) {1'b0}}
                };
              end
              6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+1-4:0], {(C_MANT_FP64 - C_MANT_FP16 + 4 + 3) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16+5:0], {(C_MANT_FP64 - C_MANT_FP16 - 1) {1'b0}}
                };
              end
            endcase
          end

          2'b11: begin

            case (Precision_ctl_S)
              6'b00: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
              6'h07, 6'h06: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT:0], {(C_MANT_FP64 - C_MANT_FP16ALT + 4) {1'b0}}
                };
              end
              default: begin
                Mant_result_prenorm_DO = {
                  Quotient_DP[C_MANT_FP16ALT+4:0], {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
                };
              end
            endcase
          end
        endcase
      end
    end
  endgenerate

  logic [C_EXP_FP64+1:0] Exp_result_prenorm_DN, Exp_result_prenorm_DP;

  logic [C_EXP_FP64+1:0] Exp_add_a_D;
  logic [C_EXP_FP64+1:0] Exp_add_b_D;
  logic [C_EXP_FP64+1:0] Exp_add_c_D;

  integer C_BIAS_AONE, C_HALF_BIAS;
  always_comb begin
    case (Format_sel_S)
      2'b00: begin
        C_BIAS_AONE = C_BIAS_AONE_FP32;
        C_HALF_BIAS = C_HALF_BIAS_FP32;
      end
      2'b01: begin
        C_BIAS_AONE = C_BIAS_AONE_FP64;
        C_HALF_BIAS = C_HALF_BIAS_FP64;
      end
      2'b10: begin
        C_BIAS_AONE = C_BIAS_AONE_FP16;
        C_HALF_BIAS = C_HALF_BIAS_FP16;
      end
      2'b11: begin
        C_BIAS_AONE = C_BIAS_AONE_FP16ALT;
        C_HALF_BIAS = C_HALF_BIAS_FP16ALT;
      end
    endcase
  end
  assign Exp_add_a_D = {
    Sqrt_start_dly_S?{Exp_num_DI[C_EXP_FP64],Exp_num_DI[C_EXP_FP64],Exp_num_DI[C_EXP_FP64],Exp_num_DI[C_EXP_FP64:1]}:{Exp_num_DI[C_EXP_FP64],Exp_num_DI[C_EXP_FP64],Exp_num_DI}
  };
  assign Exp_add_b_D = {
    Sqrt_start_dly_S?{1'b0,{C_EXP_ZERO_FP64},Exp_num_DI[0]}:{~Exp_den_DI[C_EXP_FP64],~Exp_den_DI[C_EXP_FP64],~Exp_den_DI}
  };
  assign Exp_add_c_D = {Div_start_dly_S ? {{C_BIAS_AONE}} : {{C_HALF_BIAS}}};
  assign Exp_result_prenorm_DN  = (Start_dly_S)?{Exp_add_a_D + Exp_add_b_D + Exp_add_c_D}:Exp_result_prenorm_DP;
  always_ff @(posedge Clk_CI, negedge Rst_RBI) begin
    if (~Rst_RBI) begin
      Exp_result_prenorm_DP <= '0;
    end else begin
      Exp_result_prenorm_DP <= Exp_result_prenorm_DN;
    end
  end

  assign Exp_result_prenorm_DO = Exp_result_prenorm_DP;

endmodule



import defs_div_sqrt_mvp::*;

module nrbd_nrsc_mvp (
    input logic                 Clk_CI,
    input logic                 Rst_RBI,
    input logic                 Div_start_SI,
    input logic                 Sqrt_start_SI,
    input logic                 Start_SI,
    input logic                 Kill_SI,
    input logic                 Special_case_SBI,
    input logic                 Special_case_dly_SBI,
    input logic [     C_PC-1:0] Precision_ctl_SI,
    input logic [          1:0] Format_sel_SI,
    input logic [C_MANT_FP64:0] Mant_a_DI,
    input logic [C_MANT_FP64:0] Mant_b_DI,
    input logic [ C_EXP_FP64:0] Exp_a_DI,
    input logic [ C_EXP_FP64:0] Exp_b_DI,

    output logic Div_enable_SO,
    output logic Sqrt_enable_SO,

    output logic                   Full_precision_SO,
    output logic                   FP32_SO,
    output logic                   FP64_SO,
    output logic                   FP16_SO,
    output logic                   FP16ALT_SO,
    output logic                   Ready_SO,
    output logic                   Done_SO,
    output logic [C_MANT_FP64+4:0] Mant_z_DO,
    output logic [ C_EXP_FP64+1:0] Exp_z_DO
);
  logic Div_start_dly_S, Sqrt_start_dly_S;
  control_mvp control_U0 (
      .Clk_CI                (Clk_CI),
      .Rst_RBI               (Rst_RBI),
      .Div_start_SI          (Div_start_SI),
      .Sqrt_start_SI         (Sqrt_start_SI),
      .Start_SI              (Start_SI),
      .Kill_SI               (Kill_SI),
      .Special_case_SBI      (Special_case_SBI),
      .Special_case_dly_SBI  (Special_case_dly_SBI),
      .Precision_ctl_SI      (Precision_ctl_SI),
      .Format_sel_SI         (Format_sel_SI),
      .Numerator_DI          (Mant_a_DI),
      .Exp_num_DI            (Exp_a_DI),
      .Denominator_DI        (Mant_b_DI),
      .Exp_den_DI            (Exp_b_DI),
      .Div_start_dly_SO      (Div_start_dly_S),
      .Sqrt_start_dly_SO     (Sqrt_start_dly_S),
      .Div_enable_SO         (Div_enable_SO),
      .Sqrt_enable_SO        (Sqrt_enable_SO),
      .Full_precision_SO     (Full_precision_SO),
      .FP32_SO               (FP32_SO),
      .FP64_SO               (FP64_SO),
      .FP16_SO               (FP16_SO),
      .FP16ALT_SO            (FP16ALT_SO),
      .Ready_SO              (Ready_SO),
      .Done_SO               (Done_SO),
      .Mant_result_prenorm_DO(Mant_z_DO),
      .Exp_result_prenorm_DO (Exp_z_DO)
  );
endmodule



import defs_div_sqrt_mvp::*;

module norm_div_sqrt_mvp (
    input logic        [C_MANT_FP64+4:0] Mant_in_DI,
    input logic signed [ C_EXP_FP64+1:0] Exp_in_DI,
    input logic                          Sign_in_DI,
    input logic                          Div_enable_SI,
    input logic                          Sqrt_enable_SI,
    input logic                          Inf_a_SI,
    input logic                          Inf_b_SI,
    input logic                          Zero_a_SI,
    input logic                          Zero_b_SI,
    input logic                          NaN_a_SI,
    input logic                          NaN_b_SI,
    input logic                          SNaN_SI,
    input logic        [       C_RM-1:0] RM_SI,
    input logic                          Full_precision_SI,
    input logic                          FP32_SI,
    input logic                          FP64_SI,
    input logic                          FP16_SI,
    input logic                          FP16ALT_SI,

    output logic [C_EXP_FP64+C_MANT_FP64:0] Result_DO,
    output logic [                     4:0] Fflags_SO
);
  logic                     Sign_res_D;

  logic                     NV_OP_S;
  logic                     Exp_OF_S;
  logic                     Exp_UF_S;
  logic                     Div_Zero_S;
  logic                     In_Exact_S;

  logic [    C_MANT_FP64:0] Mant_res_norm_D;
  logic [   C_EXP_FP64-1:0] Exp_res_norm_D;

  logic [   C_EXP_FP64+1:0] Exp_Max_RS_FP64_D;
  logic [   C_EXP_FP32+1:0] Exp_Max_RS_FP32_D;
  logic [   C_EXP_FP16+1:0] Exp_Max_RS_FP16_D;
  logic [C_EXP_FP16ALT+1:0] Exp_Max_RS_FP16ALT_D;

  assign Exp_Max_RS_FP64_D = Exp_in_DI[C_EXP_FP64:0] + C_MANT_FP64 + 1;
  assign Exp_Max_RS_FP32_D = Exp_in_DI[C_EXP_FP32:0] + C_MANT_FP32 + 1;
  assign Exp_Max_RS_FP16_D = Exp_in_DI[C_EXP_FP16:0] + C_MANT_FP16 + 1;
  assign Exp_Max_RS_FP16ALT_D = Exp_in_DI[C_EXP_FP16ALT:0] + C_MANT_FP16ALT + 1;
  logic [C_EXP_FP64+1:0] Num_RS_D;
  assign Num_RS_D = ~Exp_in_DI + 1 + 1;
  logic [  C_MANT_FP64:0] Mant_RS_D;
  logic [C_MANT_FP64+4:0] Mant_forsticky_D;
  assign {Mant_RS_D, Mant_forsticky_D} = {Mant_in_DI, {(C_MANT_FP64 + 1) {1'b0}}} >> (Num_RS_D);

  logic [C_EXP_FP64+1:0] Exp_subOne_D;
  assign Exp_subOne_D = Exp_in_DI - 1;

  logic [            1:0] Mant_lower_D;
  logic                   Mant_sticky_bit_D;
  logic [C_MANT_FP64+4:0] Mant_forround_D;

  always_comb begin

    if (NaN_a_SI) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = {1'b0, C_MANT_NAN_FP64};
      Exp_res_norm_D = '1;
      Mant_forround_D = '0;
      Sign_res_D = 1'b0;
      NV_OP_S = SNaN_SI;
    end else if (NaN_b_SI) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = {1'b0, C_MANT_NAN_FP64};
      Exp_res_norm_D = '1;
      Mant_forround_D = '0;
      Sign_res_D = 1'b0;
      NV_OP_S = SNaN_SI;
    end else if (Inf_a_SI) begin
      if (Div_enable_SI && Inf_b_SI) begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = {1'b0, C_MANT_NAN_FP64};
        Exp_res_norm_D = '1;
        Mant_forround_D = '0;
        Sign_res_D = 1'b0;
        NV_OP_S = 1'b1;
      end else if (Sqrt_enable_SI && Sign_in_DI) begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = {1'b0, C_MANT_NAN_FP64};
        Exp_res_norm_D = '1;
        Mant_forround_D = '0;
        Sign_res_D = 1'b0;
        NV_OP_S = 1'b1;
      end else begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b1;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = '0;
        Exp_res_norm_D = '1;
        Mant_forround_D = '0;
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end
    end else if (Div_enable_SI && Inf_b_SI) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b1;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = '0;
      Exp_res_norm_D = '0;
      Mant_forround_D = '0;
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end else if (Zero_a_SI) begin
      if (Div_enable_SI && Zero_b_SI) begin
        Div_Zero_S = 1'b1;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = {1'b0, C_MANT_NAN_FP64};
        Exp_res_norm_D = '1;
        Mant_forround_D = '0;
        Sign_res_D = 1'b0;
        NV_OP_S = 1'b1;
      end else begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = '0;
        Exp_res_norm_D = '0;
        Mant_forround_D = '0;
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end
    end else if (Div_enable_SI && (Zero_b_SI)) begin
      Div_Zero_S = 1'b1;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = '0;
      Exp_res_norm_D = '1;
      Mant_forround_D = '0;
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end else if (Sign_in_DI && Sqrt_enable_SI) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = {1'b0, C_MANT_NAN_FP64};
      Exp_res_norm_D = '1;
      Mant_forround_D = '0;
      Sign_res_D = 1'b0;
      NV_OP_S = 1'b1;
    end else if ((Exp_in_DI[C_EXP_FP64:0] == '0)) begin
      if (Mant_in_DI != '0) begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b1;
        Mant_res_norm_D = {1'b0, Mant_in_DI[C_MANT_FP64+4:5]};
        Exp_res_norm_D = '0;
        Mant_forround_D = {Mant_in_DI[4:0], {(C_MANT_FP64) {1'b0}}};
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end else begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = '0;
        Exp_res_norm_D = '0;
        Mant_forround_D = '0;
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end
    end else if ((Exp_in_DI[C_EXP_FP64:0] == C_EXP_ONE_FP64) && (~Mant_in_DI[C_MANT_FP64+4])) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b1;
      Mant_res_norm_D = Mant_in_DI[C_MANT_FP64+4:4];
      Exp_res_norm_D = '0;
      Mant_forround_D = {Mant_in_DI[3:0], {(C_MANT_FP64 + 1) {1'b0}}};
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end else if (Exp_in_DI[C_EXP_FP64+1]) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b1;
      Mant_res_norm_D = {Mant_RS_D[C_MANT_FP64:0]};
      Exp_res_norm_D = '0;
      Mant_forround_D = {Mant_forsticky_D[C_MANT_FP64+4:0]};
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end

      else if( (Exp_in_DI[C_EXP_FP32]&&FP32_SI) | (Exp_in_DI[C_EXP_FP64]&&FP64_SI) | (Exp_in_DI[C_EXP_FP16]&&FP16_SI) | (Exp_in_DI[C_EXP_FP16ALT]&&FP16ALT_SI) )
        begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b1;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = '0;
      Exp_res_norm_D = '1;
      Mant_forround_D = '0;
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end

      else if( ((Exp_in_DI[C_EXP_FP32-1:0]=='1)&&FP32_SI) | ((Exp_in_DI[C_EXP_FP64-1:0]=='1)&&FP64_SI) |  ((Exp_in_DI[C_EXP_FP16-1:0]=='1)&&FP16_SI) | ((Exp_in_DI[C_EXP_FP16ALT-1:0]=='1)&&FP16ALT_SI) )
        begin
      if (~Mant_in_DI[C_MANT_FP64+4]) begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b0;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = Mant_in_DI[C_MANT_FP64+3:3];
        Exp_res_norm_D = Exp_subOne_D;
        Mant_forround_D = {Mant_in_DI[2:0], {(C_MANT_FP64 + 2) {1'b0}}};
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end else if (Mant_in_DI != '0) begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b1;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = '0;
        Exp_res_norm_D = '1;
        Mant_forround_D = '0;
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end else begin
        Div_Zero_S = 1'b0;
        Exp_OF_S = 1'b1;
        Exp_UF_S = 1'b0;
        Mant_res_norm_D = '0;
        Exp_res_norm_D = '1;
        Mant_forround_D = '0;
        Sign_res_D = Sign_in_DI;
        NV_OP_S = 1'b0;
      end
    end else if (Mant_in_DI[C_MANT_FP64+4]) begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = Mant_in_DI[C_MANT_FP64+4:4];
      Exp_res_norm_D = Exp_in_DI[C_EXP_FP64-1:0];
      Mant_forround_D = {Mant_in_DI[3:0], {(C_MANT_FP64 + 1) {1'b0}}};
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end else begin
      Div_Zero_S = 1'b0;
      Exp_OF_S = 1'b0;
      Exp_UF_S = 1'b0;
      Mant_res_norm_D = Mant_in_DI[C_MANT_FP64+3:3];
      Exp_res_norm_D = Exp_subOne_D;
      Mant_forround_D = {Mant_in_DI[2:0], {(C_MANT_FP64 + 2) {1'b0}}};
      Sign_res_D = Sign_in_DI;
      NV_OP_S = 1'b0;
    end

  end

  logic [  C_MANT_FP64:0] Mant_upper_D;
  logic [C_MANT_FP64+1:0] Mant_upperRounded_D;
  logic                   Mant_roundUp_S;
  logic                   Mant_rounded_S;

  always_comb begin
    if (FP32_SI) begin
      Mant_upper_D = {
        Mant_res_norm_D[C_MANT_FP64:C_MANT_FP64-C_MANT_FP32], {(C_MANT_FP64 - C_MANT_FP32) {1'b0}}
      };
      Mant_lower_D = Mant_res_norm_D[C_MANT_FP64-C_MANT_FP32-1:C_MANT_FP64-C_MANT_FP32-2];
      Mant_sticky_bit_D = |Mant_res_norm_D[C_MANT_FP64-C_MANT_FP32-3:0];
    end else if (FP64_SI) begin
      Mant_upper_D = Mant_res_norm_D[C_MANT_FP64:0];
      Mant_lower_D = Mant_forround_D[C_MANT_FP64+4:C_MANT_FP64+3];
      Mant_sticky_bit_D = |Mant_forround_D[C_MANT_FP64+3:0];
    end else if (FP16_SI) begin
      Mant_upper_D = {
        Mant_res_norm_D[C_MANT_FP64:C_MANT_FP64-C_MANT_FP16], {(C_MANT_FP64 - C_MANT_FP16) {1'b0}}
      };
      Mant_lower_D = Mant_res_norm_D[C_MANT_FP64-C_MANT_FP16-1:C_MANT_FP64-C_MANT_FP16-2];
      Mant_sticky_bit_D = |Mant_res_norm_D[C_MANT_FP64-C_MANT_FP16-3:30];
    end else begin
      Mant_upper_D = {
        Mant_res_norm_D[C_MANT_FP64:C_MANT_FP64-C_MANT_FP16ALT],
        {(C_MANT_FP64 - C_MANT_FP16ALT) {1'b0}}
      };
      Mant_lower_D = Mant_res_norm_D[C_MANT_FP64-C_MANT_FP16ALT-1:C_MANT_FP64-C_MANT_FP16ALT-2];
      Mant_sticky_bit_D = |Mant_res_norm_D[C_MANT_FP64-C_MANT_FP16ALT-3:30];
    end
  end

  assign Mant_rounded_S = (|(Mant_lower_D)) | Mant_sticky_bit_D;

  always_comb begin
    Mant_roundUp_S = 1'b0;
    case (RM_SI)
      C_RM_NEAREST:
      Mant_roundUp_S = Mant_lower_D[1] && ((Mant_lower_D[0] | Mant_sticky_bit_D )| ( (FP32_SI&&Mant_upper_D[C_MANT_FP64-C_MANT_FP32]) | (FP64_SI&&Mant_upper_D[0]) | (FP16_SI&&Mant_upper_D[C_MANT_FP64-C_MANT_FP16]) | (FP16ALT_SI&&Mant_upper_D[C_MANT_FP64-C_MANT_FP16ALT]) ) );
      C_RM_TRUNC: Mant_roundUp_S = 0;
      C_RM_PLUSINF: Mant_roundUp_S = Mant_rounded_S & ~Sign_in_DI;
      C_RM_MINUSINF: Mant_roundUp_S = Mant_rounded_S & Sign_in_DI;
      default: Mant_roundUp_S = 0;
    endcase
  end

  logic                 Mant_renorm_S;
  logic [C_MANT_FP64:0] Mant_roundUp_Vector_S;

  assign Mant_roundUp_Vector_S = {
    7'h0,
    (FP16ALT_SI && Mant_roundUp_S),
    2'h0,
    (FP16_SI && Mant_roundUp_S),
    12'h0,
    (FP32_SI && Mant_roundUp_S),
    28'h0,
    (FP64_SI && Mant_roundUp_S)
  };
  assign Mant_upperRounded_D = Mant_upper_D + Mant_roundUp_Vector_S;
  assign Mant_renorm_S = Mant_upperRounded_D[C_MANT_FP64+1];

  logic [C_MANT_FP64-1:0] Mant_res_round_D;
  logic [ C_EXP_FP64-1:0] Exp_res_round_D;
  assign Mant_res_round_D = (Mant_renorm_S)?Mant_upperRounded_D[C_MANT_FP64:1]:Mant_upperRounded_D[C_MANT_FP64-1:0];
  assign Exp_res_round_D = Exp_res_norm_D + Mant_renorm_S;

  logic [C_MANT_FP64-1:0] Mant_before_format_ctl_D;
  logic [ C_EXP_FP64-1:0] Exp_before_format_ctl_D;
  assign Mant_before_format_ctl_D = Full_precision_SI ? Mant_res_round_D : Mant_res_norm_D;
  assign Exp_before_format_ctl_D  = Full_precision_SI ? Exp_res_round_D : Exp_res_norm_D;

  always_comb begin
    if (FP32_SI) begin
      Result_DO = {
        32'hffff_ffff,
        Sign_res_D,
        Exp_before_format_ctl_D[C_EXP_FP32-1:0],
        Mant_before_format_ctl_D[C_MANT_FP64-1:C_MANT_FP64-C_MANT_FP32]
      };
    end else if (FP64_SI) begin
      Result_DO = {
        Sign_res_D,
        Exp_before_format_ctl_D[C_EXP_FP64-1:0],
        Mant_before_format_ctl_D[C_MANT_FP64-1:0]
      };
    end else if (FP16_SI) begin
      Result_DO = {
        48'hffff_ffff_ffff,
        Sign_res_D,
        Exp_before_format_ctl_D[C_EXP_FP16-1:0],
        Mant_before_format_ctl_D[C_MANT_FP64-1:C_MANT_FP64-C_MANT_FP16]
      };
    end else begin
      Result_DO = {
        48'hffff_ffff_ffff,
        Sign_res_D,
        Exp_before_format_ctl_D[C_EXP_FP16ALT-1:0],
        Mant_before_format_ctl_D[C_MANT_FP64-1:C_MANT_FP64-C_MANT_FP16ALT]
      };
    end
  end

  assign In_Exact_S = (~Full_precision_SI) | Mant_rounded_S;
  assign Fflags_SO  = {NV_OP_S, Div_Zero_S, Exp_OF_S, Exp_UF_S, In_Exact_S};

endmodule




import defs_div_sqrt_mvp::*;

module div_sqrt_top_mvp (
    input logic Clk_CI,
    input logic Rst_RBI,
    input logic Div_start_SI,
    input logic Sqrt_start_SI,

    input logic [C_OP_FP64-1:0] Operand_a_DI,
    input logic [C_OP_FP64-1:0] Operand_b_DI,

    input logic [C_RM-1:0] RM_SI,
    input logic [C_PC-1:0] Precision_ctl_SI,
    input logic [C_FS-1:0] Format_sel_SI,
    input logic            Kill_SI,

    output logic [C_OP_FP64-1:0] Result_DO,

    output logic [4:0] Fflags_SO,
    output logic       Ready_SO,
    output logic       Done_SO
);

  logic [   C_EXP_FP64:0] Exp_a_D;
  logic [   C_EXP_FP64:0] Exp_b_D;
  logic [  C_MANT_FP64:0] Mant_a_D;
  logic [  C_MANT_FP64:0] Mant_b_D;

  logic [ C_EXP_FP64+1:0] Exp_z_D;
  logic [C_MANT_FP64+4:0] Mant_z_D;
  logic                   Sign_z_D;
  logic                   Start_S;
  logic [       C_RM-1:0] RM_dly_S;
  logic                   Div_enable_S;
  logic                   Sqrt_enable_S;
  logic                   Inf_a_S;
  logic                   Inf_b_S;
  logic                   Zero_a_S;
  logic                   Zero_b_S;
  logic                   NaN_a_S;
  logic                   NaN_b_S;
  logic                   SNaN_S;
  logic Special_case_SB, Special_case_dly_SB;

  logic Full_precision_S;
  logic FP32_S;
  logic FP64_S;
  logic FP16_S;
  logic FP16ALT_S;
  preprocess_mvp preprocess_U0 (
      .Clk_CI              (Clk_CI),
      .Rst_RBI             (Rst_RBI),
      .Div_start_SI        (Div_start_SI),
      .Sqrt_start_SI       (Sqrt_start_SI),
      .Ready_SI            (Ready_SO),
      .Operand_a_DI        (Operand_a_DI),
      .Operand_b_DI        (Operand_b_DI),
      .RM_SI               (RM_SI),
      .Format_sel_SI       (Format_sel_SI),
      .Start_SO            (Start_S),
      .Exp_a_DO_norm       (Exp_a_D),
      .Exp_b_DO_norm       (Exp_b_D),
      .Mant_a_DO_norm      (Mant_a_D),
      .Mant_b_DO_norm      (Mant_b_D),
      .RM_dly_SO           (RM_dly_S),
      .Sign_z_DO           (Sign_z_D),
      .Inf_a_SO            (Inf_a_S),
      .Inf_b_SO            (Inf_b_S),
      .Zero_a_SO           (Zero_a_S),
      .Zero_b_SO           (Zero_b_S),
      .NaN_a_SO            (NaN_a_S),
      .NaN_b_SO            (NaN_b_S),
      .SNaN_SO             (SNaN_S),
      .Special_case_SBO    (Special_case_SB),
      .Special_case_dly_SBO(Special_case_dly_SB)
  );

  nrbd_nrsc_mvp nrbd_nrsc_U0 (
      .Clk_CI              (Clk_CI),
      .Rst_RBI             (Rst_RBI),
      .Div_start_SI        (Div_start_SI),
      .Sqrt_start_SI       (Sqrt_start_SI),
      .Start_SI            (Start_S),
      .Kill_SI             (Kill_SI),
      .Special_case_SBI    (Special_case_SB),
      .Special_case_dly_SBI(Special_case_dly_SB),
      .Div_enable_SO       (Div_enable_S),
      .Sqrt_enable_SO      (Sqrt_enable_S),
      .Precision_ctl_SI    (Precision_ctl_SI),
      .Format_sel_SI       (Format_sel_SI),
      .Exp_a_DI            (Exp_a_D),
      .Exp_b_DI            (Exp_b_D),
      .Mant_a_DI           (Mant_a_D),
      .Mant_b_DI           (Mant_b_D),
      .Full_precision_SO   (Full_precision_S),
      .FP32_SO             (FP32_S),
      .FP64_SO             (FP64_S),
      .FP16_SO             (FP16_S),
      .FP16ALT_SO          (FP16ALT_S),
      .Ready_SO            (Ready_SO),
      .Done_SO             (Done_SO),
      .Exp_z_DO            (Exp_z_D),
      .Mant_z_DO           (Mant_z_D)
  );
  norm_div_sqrt_mvp fpu_norm_U0 (
      .Mant_in_DI       (Mant_z_D),
      .Exp_in_DI        (Exp_z_D),
      .Sign_in_DI       (Sign_z_D),
      .Div_enable_SI    (Div_enable_S),
      .Sqrt_enable_SI   (Sqrt_enable_S),
      .Inf_a_SI         (Inf_a_S),
      .Inf_b_SI         (Inf_b_S),
      .Zero_a_SI        (Zero_a_S),
      .Zero_b_SI        (Zero_b_S),
      .NaN_a_SI         (NaN_a_S),
      .NaN_b_SI         (NaN_b_S),
      .SNaN_SI          (SNaN_S),
      .RM_SI            (RM_dly_S),
      .Full_precision_SI(Full_precision_S),
      .FP32_SI          (FP32_S),
      .FP64_SI          (FP64_S),
      .FP16_SI          (FP16_S),
      .FP16ALT_SI       (FP16ALT_S),
      .Result_DO        (Result_DO),
      .Fflags_SO        (Fflags_SO)
  );

endmodule





module fpnew_divsqrt_multi #(
    parameter fpnew_pkg::fmt_logic_t FpFmtConfig = '1,

    parameter int unsigned             NumPipeRegs = 0,
    parameter fpnew_pkg::pipe_config_t PipeConfig  = fpnew_pkg::AFTER,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,

    localparam int unsigned WIDTH       = fpnew_pkg::max_fp_width(FpFmtConfig),
    localparam int unsigned NUM_FORMATS = fpnew_pkg::NUM_FP_FORMATS
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                  [            1:0][WIDTH-1:0] operands_i,
    input logic                  [NUM_FORMATS-1:0][      1:0] is_boxed_i,
    input fpnew_pkg::roundmode_e                              rnd_mode_i,
    input fpnew_pkg::operation_e                              op_i,
    input fpnew_pkg::fp_format_e                              dst_fmt_i,
    input TagType                                             tag_i,
    input logic                                               mask_i,
    input AuxType                                             aux_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    output logic divsqrt_done_o,
    input  logic simd_synch_done_i,
    output logic divsqrt_ready_o,
    input  logic simd_synch_rdy_i,
    input  logic flush_i,

    output logic               [WIDTH-1:0] result_o,
    output fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic                           mask_o,
    output AuxType                         aux_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  localparam NUM_INP_REGS = (PipeConfig == fpnew_pkg::BEFORE)
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 2)
                               : 0);
  localparam NUM_OUT_REGS = (PipeConfig == fpnew_pkg::AFTER || PipeConfig == fpnew_pkg::INSIDE)
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 2)
                               : 0);

  logic                  [           1:0][WIDTH-1:0]            operands_q;
  fpnew_pkg::roundmode_e                                        rnd_mode_q;
  fpnew_pkg::operation_e                                        op_q;
  fpnew_pkg::fp_format_e                                        dst_fmt_q;
  logic                                                         in_valid_q;

  logic                  [0:NUM_INP_REGS][      1:0][WIDTH-1:0] inp_pipe_operands_q;
  fpnew_pkg::roundmode_e [0:NUM_INP_REGS]                       inp_pipe_rnd_mode_q;
  fpnew_pkg::operation_e [0:NUM_INP_REGS]                       inp_pipe_op_q;
  fpnew_pkg::fp_format_e [0:NUM_INP_REGS]                       inp_pipe_dst_fmt_q;
  TagType                [0:NUM_INP_REGS]                       inp_pipe_tag_q;
  logic                  [0:NUM_INP_REGS]                       inp_pipe_mask_q;
  AuxType                [0:NUM_INP_REGS]                       inp_pipe_aux_q;
  logic                  [0:NUM_INP_REGS]                       inp_pipe_valid_q;

  logic                  [0:NUM_INP_REGS]                       inp_pipe_ready;

  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_dst_fmt_q[0]  = dst_fmt_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;

  assign in_ready_o             = inp_pipe_ready[0];

  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline

    logic reg_ena;

    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];

    `FFLARNC(inp_pipe_valid_q[i+1], inp_pipe_valid_q[i], inp_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = inp_pipe_ready[i] & inp_pipe_valid_q[i];

    `FFL(inp_pipe_operands_q[i+1], inp_pipe_operands_q[i], reg_ena, '0)
    `FFL(inp_pipe_rnd_mode_q[i+1], inp_pipe_rnd_mode_q[i], reg_ena, fpnew_pkg::RNE)
    `FFL(inp_pipe_op_q[i+1], inp_pipe_op_q[i], reg_ena, fpnew_pkg::FMADD)
    `FFL(inp_pipe_dst_fmt_q[i+1], inp_pipe_dst_fmt_q[i], reg_ena, fpnew_pkg::fp_format_e'(0))
    `FFL(inp_pipe_tag_q[i+1], inp_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(inp_pipe_mask_q[i+1], inp_pipe_mask_q[i], reg_ena, '0)
    `FFL(inp_pipe_aux_q[i+1], inp_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  assign operands_q = inp_pipe_operands_q[NUM_INP_REGS];
  assign rnd_mode_q = inp_pipe_rnd_mode_q[NUM_INP_REGS];
  assign op_q       = inp_pipe_op_q[NUM_INP_REGS];
  assign dst_fmt_q  = inp_pipe_dst_fmt_q[NUM_INP_REGS];
  assign in_valid_q = inp_pipe_valid_q[NUM_INP_REGS];

  logic [1:0]       divsqrt_fmt;
  logic [1:0][63:0] divsqrt_operands;
  logic             input_is_fp8;

  always_comb begin : translate_fmt
    unique case (dst_fmt_q)
      fpnew_pkg::FP32:    divsqrt_fmt = 2'b00;
      fpnew_pkg::FP64:    divsqrt_fmt = 2'b01;
      fpnew_pkg::FP16:    divsqrt_fmt = 2'b10;
      fpnew_pkg::FP16ALT: divsqrt_fmt = 2'b11;
      default:            divsqrt_fmt = 2'b10;
    endcase

    input_is_fp8 = FpFmtConfig[fpnew_pkg::FP8] & (dst_fmt_q == fpnew_pkg::FP8);

    divsqrt_operands[0] = input_is_fp8 ? operands_q[0] << 8 : operands_q[0];
    divsqrt_operands[1] = input_is_fp8 ? operands_q[1] << 8 : operands_q[1];
  end

  logic in_ready;
  logic div_valid, sqrt_valid;
  logic unit_ready, unit_done, unit_done_q;
  logic op_starting;
  logic out_valid, out_ready;
  logic unit_busy;

  typedef enum logic [1:0] {
    IDLE,
    BUSY,
    HOLD
  } fsm_state_e;
  fsm_state_e state_q, state_d;

  assign divsqrt_ready_o = in_ready;

  assign inp_pipe_ready[NUM_INP_REGS] = simd_synch_rdy_i;

  `FFLARNC(unit_done_q, unit_done, unit_done, simd_synch_done_i, 1'b0, clk_i, rst_ni);

  assign divsqrt_done_o = unit_done_q | unit_done;

  assign div_valid = in_valid_q & (op_q == fpnew_pkg::DIV) & in_ready & ~flush_i;
  assign sqrt_valid = in_valid_q & (op_q != fpnew_pkg::DIV) & in_ready & ~flush_i;
  assign op_starting = div_valid | sqrt_valid;

  always_comb begin : flag_fsm

    in_ready  = 1'b0;
    out_valid = 1'b0;
    unit_busy = 1'b0;
    state_d   = state_q;

    unique case (state_q)

      IDLE: begin
        in_ready = 1'b1;
        if (in_valid_q && unit_ready) begin
          state_d = BUSY;
        end
      end

      BUSY: begin
        unit_busy = 1'b1;

        if (simd_synch_done_i) begin
          out_valid = 1'b1;

          if (out_ready) begin
            state_d = IDLE;
            if (in_valid_q && unit_ready) begin
              in_ready = 1'b1;
              state_d  = BUSY;
            end

          end else begin
            state_d = HOLD;
          end
        end
      end

      HOLD: begin
        unit_busy = 1'b1;
        out_valid = 1'b1;

        if (out_ready) begin
          state_d = IDLE;
          if (in_valid_q && unit_ready) begin
            in_ready = 1'b1;
            state_d  = BUSY;
          end
        end
      end

      default: state_d = IDLE;
    endcase

    if (flush_i) begin
      unit_busy = 1'b0;
      out_valid = 1'b0;
      state_d   = IDLE;
    end
  end

  `FF(state_q, state_d, IDLE)

  logic   result_is_fp8_q;
  TagType result_tag_q;
  logic   result_mask_q;
  AuxType result_aux_q;

  `FFL(result_is_fp8_q, input_is_fp8, op_starting, '0)
  `FFL(result_tag_q, inp_pipe_tag_q[NUM_INP_REGS], op_starting, '0)
  `FFL(result_mask_q, inp_pipe_mask_q[NUM_INP_REGS], op_starting, '0)
  `FFL(result_aux_q, inp_pipe_aux_q[NUM_INP_REGS], op_starting, '0)

  logic [63:0] unit_result;
  logic [WIDTH-1:0] adjusted_result, held_result_q;
  fpnew_pkg::status_t unit_status, held_status_q;
  logic hold_en;

  div_sqrt_top_mvp i_divsqrt_lei (
      .Clk_CI          (clk_i),
      .Rst_RBI         (rst_ni),
      .Div_start_SI    (div_valid),
      .Sqrt_start_SI   (sqrt_valid),
      .Operand_a_DI    (divsqrt_operands[0]),
      .Operand_b_DI    (divsqrt_operands[1]),
      .RM_SI           (rnd_mode_q),
      .Precision_ctl_SI('0),
      .Format_sel_SI   (divsqrt_fmt),
      .Kill_SI         (flush_i),
      .Result_DO       (unit_result),
      .Fflags_SO       (unit_status),
      .Ready_SO        (unit_ready),
      .Done_SO         (unit_done)
  );

  assign adjusted_result = result_is_fp8_q ? unit_result >> 8 : unit_result;

  assign hold_en = unit_done & (~simd_synch_done_i | ~out_ready);

  `FFLNR(held_result_q, adjusted_result, hold_en, clk_i)
  `FFLNR(held_status_q, unit_status, hold_en, clk_i)

  logic [WIDTH-1:0] result_d;
  fpnew_pkg::status_t status_d;

  assign result_d = unit_done_q ? held_result_q : adjusted_result;
  assign status_d = unit_done_q ? held_status_q : unit_status;

  logic               [0:NUM_OUT_REGS][WIDTH-1:0] out_pipe_result_q;
  fpnew_pkg::status_t [0:NUM_OUT_REGS]            out_pipe_status_q;
  TagType             [0:NUM_OUT_REGS]            out_pipe_tag_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_mask_q;
  AuxType             [0:NUM_OUT_REGS]            out_pipe_aux_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_valid_q;

  logic               [0:NUM_OUT_REGS]            out_pipe_ready;

  assign out_pipe_result_q[0] = result_d;
  assign out_pipe_status_q[0] = status_d;
  assign out_pipe_tag_q[0]    = result_tag_q;
  assign out_pipe_mask_q[0]   = result_mask_q;
  assign out_pipe_aux_q[0]    = result_aux_q;
  assign out_pipe_valid_q[0]  = out_valid;

  assign out_ready = out_pipe_ready[0];

  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline

    logic reg_ena;

    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];

    `FFLARNC(out_pipe_valid_q[i+1], out_pipe_valid_q[i], out_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = out_pipe_ready[i] & out_pipe_valid_q[i];

    `FFL(out_pipe_result_q[i+1], out_pipe_result_q[i], reg_ena, '0)
    `FFL(out_pipe_status_q[i+1], out_pipe_status_q[i], reg_ena, '0)
    `FFL(out_pipe_tag_q[i+1], out_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(out_pipe_mask_q[i+1], out_pipe_mask_q[i], reg_ena, '0)
    `FFL(out_pipe_aux_q[i+1], out_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;

  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = 1'b1;
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, unit_busy, out_pipe_valid_q});
endmodule





module fpnew_opgroup_multifmt_slice #(
    parameter fpnew_pkg::opgroup_e OpGroup = fpnew_pkg::CONV,
    parameter int unsigned         Width   = 64,

    parameter fpnew_pkg::fmt_logic_t   FpFmtConfig   = '1,
    parameter fpnew_pkg::ifmt_logic_t  IntFmtConfig  = '1,
    parameter logic                    EnableVectors = 1'b1,
    parameter int unsigned             NumPipeRegs   = 0,
    parameter fpnew_pkg::pipe_config_t PipeConfig    = fpnew_pkg::BEFORE,
    parameter type                     TagType       = logic,

    localparam int unsigned NUM_OPERANDS = fpnew_pkg::num_operands(OpGroup),
    localparam int unsigned NUM_FORMATS = fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned NUM_SIMD_LANES = fpnew_pkg::max_num_lanes(
        Width, FpFmtConfig, EnableVectors
    ),
    localparam type MaskType = logic [NUM_SIMD_LANES-1:0]
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                   [NUM_OPERANDS-1:0][       Width-1:0] operands_i,
    input logic                   [ NUM_FORMATS-1:0][NUM_OPERANDS-1:0] is_boxed_i,
    input fpnew_pkg::roundmode_e                                       rnd_mode_i,
    input fpnew_pkg::operation_e                                       op_i,
    input logic                                                        op_mod_i,
    input fpnew_pkg::fp_format_e                                       src_fmt_i,
    input fpnew_pkg::fp_format_e                                       dst_fmt_i,
    input fpnew_pkg::int_format_e                                      int_fmt_i,
    input logic                                                        vectorial_op_i,
    input TagType                                                      tag_i,
    input MaskType                                                     simd_mask_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,

    output logic               [Width-1:0] result_o,
    output fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  localparam int unsigned MAX_FP_WIDTH = fpnew_pkg::max_fp_width(FpFmtConfig);
  localparam int unsigned MAX_INT_WIDTH = fpnew_pkg::max_int_width(IntFmtConfig);
  localparam int unsigned NUM_LANES = fpnew_pkg::max_num_lanes(Width, FpFmtConfig, 1'b1);
  localparam int unsigned NUM_INT_FORMATS = fpnew_pkg::NUM_INT_FORMATS;

  localparam int unsigned FMT_BITS = fpnew_pkg::maximum(
      $clog2(NUM_FORMATS), $clog2(NUM_INT_FORMATS)
  );
  localparam int unsigned AUX_BITS = FMT_BITS + 2;

  logic [NUM_LANES-1:0] lane_in_ready, lane_out_valid, divsqrt_done, divsqrt_ready;
  logic                vectorial_op;
  logic [FMT_BITS-1:0] dst_fmt;
  logic [AUX_BITS-1:0] aux_data;

  logic dst_fmt_is_int, dst_is_cpk;
  logic [1:0] dst_vec_op;
  logic [2:0] target_aux_d, target_aux_q;
  logic is_up_cast, is_down_cast;

  logic [    NUM_FORMATS-1:0][Width-1:0] fmt_slice_result;
  logic [NUM_INT_FORMATS-1:0][Width-1:0] ifmt_slice_result;
  logic [          Width-1:0]            conv_slice_result;
  logic [Width-1:0] conv_target_d, conv_target_q;

  fpnew_pkg::status_t [NUM_LANES-1:0]               lane_status;
  logic               [NUM_LANES-1:0]               lane_ext_bit;
  TagType             [NUM_LANES-1:0]               lane_tags;
  logic               [NUM_LANES-1:0]               lane_masks;
  logic               [NUM_LANES-1:0][AUX_BITS-1:0] lane_aux;
  logic               [NUM_LANES-1:0]               lane_busy;

  logic                                             result_is_vector;
  logic               [ FMT_BITS-1:0]               result_fmt;
  logic result_fmt_is_int, result_is_cpk;
  logic [1:0] result_vec_op;

  logic simd_synch_rdy, simd_synch_done;

  assign in_ready_o = lane_in_ready[0];
  assign vectorial_op = vectorial_op_i & EnableVectors;

  assign dst_fmt_is_int = (OpGroup == fpnew_pkg::CONV) & (op_i == fpnew_pkg::F2I);
  assign dst_is_cpk     = (OpGroup == fpnew_pkg::CONV) & (op_i == fpnew_pkg::CPKAB ||
                                                          op_i == fpnew_pkg::CPKCD);
  assign dst_vec_op = (OpGroup == fpnew_pkg::CONV) & {(op_i == fpnew_pkg::CPKCD), op_mod_i};

  assign is_up_cast = (fpnew_pkg::fp_width(dst_fmt_i) > fpnew_pkg::fp_width(src_fmt_i));
  assign is_down_cast = (fpnew_pkg::fp_width(dst_fmt_i) < fpnew_pkg::fp_width(src_fmt_i));

  assign dst_fmt = dst_fmt_is_int ? int_fmt_i : dst_fmt_i;

  assign aux_data = {dst_fmt_is_int, vectorial_op, dst_fmt};
  assign target_aux_d = {dst_vec_op, dst_is_cpk};

  if (OpGroup == fpnew_pkg::CONV) begin : conv_target
    assign conv_target_d = dst_is_cpk ? operands_i[2] : operands_i[1];
  end

  logic [NUM_FORMATS-1:0]      is_boxed_1op;
  logic [NUM_FORMATS-1:0][1:0] is_boxed_2op;

  always_comb begin : boxed_2op
    for (int fmt = 0; fmt < NUM_FORMATS; fmt++) begin
      is_boxed_1op[fmt] = is_boxed_i[fmt][0];
      is_boxed_2op[fmt] = is_boxed_i[fmt][1:0];
    end
  end

  for (genvar lane = 0; lane < int'(NUM_LANES); lane++) begin : gen_num_lanes
    localparam int unsigned LANE = unsigned'(lane);

    localparam fpnew_pkg::fmt_logic_t ACTIVE_FORMATS = fpnew_pkg::get_lane_formats(
        Width, FpFmtConfig, LANE
    );
    localparam fpnew_pkg::ifmt_logic_t ACTIVE_INT_FORMATS = fpnew_pkg::get_lane_int_formats(
        Width, FpFmtConfig, IntFmtConfig, LANE
    );
    localparam int unsigned MAX_WIDTH = fpnew_pkg::max_fp_width(ACTIVE_FORMATS);

    localparam fpnew_pkg::fmt_logic_t CONV_FORMATS = fpnew_pkg::get_conv_lane_formats(
        Width, FpFmtConfig, LANE
    );
    localparam fpnew_pkg::ifmt_logic_t CONV_INT_FORMATS = fpnew_pkg::get_conv_lane_int_formats(
        Width, FpFmtConfig, IntFmtConfig, LANE
    );
    localparam int unsigned CONV_WIDTH = fpnew_pkg::max_fp_width(CONV_FORMATS);

    localparam fpnew_pkg::fmt_logic_t LANE_FORMATS = (OpGroup == fpnew_pkg::CONV)
                                                     ? CONV_FORMATS : ACTIVE_FORMATS;
    localparam int unsigned LANE_WIDTH = (OpGroup == fpnew_pkg::CONV) ? CONV_WIDTH : MAX_WIDTH;

    logic [LANE_WIDTH-1:0] local_result;

    if ((lane == 0) || EnableVectors) begin : active_lane
      logic in_valid, out_valid, out_ready;

      logic               [NUM_OPERANDS-1:0][LANE_WIDTH-1:0] local_operands;
      logic               [  LANE_WIDTH-1:0]                 op_result;
      fpnew_pkg::status_t                                    op_status;

      assign in_valid = in_valid_i & ((lane == 0) | vectorial_op);

      always_comb begin : prepare_input
        for (int unsigned i = 0; i < NUM_OPERANDS; i++) begin
          local_operands[i] = operands_i[i] >> LANE * fpnew_pkg::fp_width(src_fmt_i);
        end

        if (OpGroup == fpnew_pkg::CONV) begin

          if (op_i == fpnew_pkg::I2F) begin
            local_operands[0] = operands_i[0] >> LANE * fpnew_pkg::int_width(int_fmt_i);

          end else if (op_i == fpnew_pkg::F2F) begin
            if (vectorial_op && op_mod_i && is_up_cast) begin
              local_operands[0] = operands_i[0] >>
                  LANE * fpnew_pkg::fp_width(src_fmt_i) + MAX_FP_WIDTH / 2;
            end

          end else if (dst_is_cpk) begin
            if (lane == 1) begin
              local_operands[0] = operands_i[1][LANE_WIDTH-1:0];
            end
          end
        end
      end

      if (OpGroup == fpnew_pkg::ADDMUL) begin : lane_instance
        fpnew_fma_multi #(
            .FpFmtConfig(LANE_FORMATS),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic [AUX_BITS-1:0])
        ) i_fpnew_fma_multi (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands),
            .is_boxed_i,
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .src_fmt_i,
            .dst_fmt_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (aux_data),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_aux[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane])
        );

      end else if (OpGroup == fpnew_pkg::DIVSQRT) begin : lane_instance
        fpnew_divsqrt_multi #(
            .FpFmtConfig(LANE_FORMATS),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic [AUX_BITS-1:0])
        ) i_fpnew_divsqrt_multi (
            .clk_i,
            .rst_ni,
            .operands_i       (local_operands[1:0]),
            .is_boxed_i       (is_boxed_2op),
            .rnd_mode_i,
            .op_i,
            .dst_fmt_i,
            .tag_i,
            .mask_i           (simd_mask_i[lane]),
            .aux_i            (aux_data),
            .in_valid_i       (in_valid),
            .in_ready_o       (lane_in_ready[lane]),
            .divsqrt_done_o   (divsqrt_done[lane]),
            .simd_synch_done_i(simd_synch_done),
            .divsqrt_ready_o  (divsqrt_ready[lane]),
            .simd_synch_rdy_i (simd_synch_rdy),
            .flush_i,
            .result_o         (op_result),
            .status_o         (op_status),
            .extension_bit_o  (lane_ext_bit[lane]),
            .tag_o            (lane_tags[lane]),
            .mask_o           (lane_masks[lane]),
            .aux_o            (lane_aux[lane]),
            .out_valid_o      (out_valid),
            .out_ready_i      (out_ready),
            .busy_o           (lane_busy[lane])
        );
      end else
      if (OpGroup == fpnew_pkg::NONCOMP) begin : lane_instance

      end else if (OpGroup == fpnew_pkg::CONV) begin : lane_instance
        fpnew_cast_multi #(
            .FpFmtConfig (LANE_FORMATS),
            .IntFmtConfig(CONV_INT_FORMATS),
            .NumPipeRegs (NumPipeRegs),
            .PipeConfig  (PipeConfig),
            .TagType     (TagType),
            .AuxType     (logic [AUX_BITS-1:0])
        ) i_fpnew_cast_multi (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands[0]),
            .is_boxed_i     (is_boxed_1op),
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .src_fmt_i,
            .dst_fmt_i,
            .int_fmt_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (aux_data),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_aux[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane])
        );
      end

      assign out_ready            = out_ready_i & ((lane == 0) | result_is_vector);
      assign lane_out_valid[lane] = out_valid & ((lane == 0) | result_is_vector);

      assign local_result         = lane_out_valid[lane] ? op_result : '{default: lane_ext_bit[0]};
      assign lane_status[lane]    = lane_out_valid[lane] ? op_status : '0;

    end else begin : inactive_lane
      assign lane_out_valid[lane] = 1'b0;
      assign lane_in_ready[lane]  = 1'b0;
      assign local_result         = '{default: lane_ext_bit[0]};
      assign lane_status[lane]    = '0;
      assign lane_busy[lane]      = 1'b0;
    end

    for (genvar fmt = 0; fmt < NUM_FORMATS; fmt++) begin : pack_fp_result

      localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));

      if (ACTIVE_FORMATS[fmt]) begin
        assign fmt_slice_result[fmt][(LANE+1)*FP_WIDTH-1:LANE*FP_WIDTH] =
            local_result[FP_WIDTH-1:0];
      end else if ((LANE + 1) * FP_WIDTH <= Width) begin
        assign fmt_slice_result[fmt][(LANE+1)*FP_WIDTH-1:LANE*FP_WIDTH] = '{
                default: lane_ext_bit[LANE]
            };
      end else if (LANE * FP_WIDTH < Width) begin
        assign fmt_slice_result[fmt][Width-1:LANE*FP_WIDTH] = '{default: lane_ext_bit[LANE]};
      end
    end

    if (OpGroup == fpnew_pkg::CONV) begin : int_results_enabled
      for (genvar ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++) begin : pack_int_result

        localparam int unsigned INT_WIDTH = fpnew_pkg::int_width(fpnew_pkg::int_format_e'(ifmt));
        if (ACTIVE_INT_FORMATS[ifmt]) begin
          assign ifmt_slice_result[ifmt][(LANE+1)*INT_WIDTH-1:LANE*INT_WIDTH] =
            local_result[INT_WIDTH-1:0];
        end else if ((LANE + 1) * INT_WIDTH <= Width) begin
          assign ifmt_slice_result[ifmt][(LANE+1)*INT_WIDTH-1:LANE*INT_WIDTH] = '0;
        end else if (LANE * INT_WIDTH < Width) begin
          assign ifmt_slice_result[ifmt][Width-1:LANE*INT_WIDTH] = '0;
        end
      end
    end
  end

  for (genvar fmt = 0; fmt < NUM_FORMATS; fmt++) begin : extend_fp_result

    localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));
    if (NUM_LANES * FP_WIDTH < Width)
      assign fmt_slice_result[fmt][Width-1:NUM_LANES*FP_WIDTH] = '{default: lane_ext_bit[0]};
  end

  for (genvar ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++) begin : int_results_disabled
    if (OpGroup != fpnew_pkg::CONV) begin : mute_int_result
      assign ifmt_slice_result[ifmt] = '0;
    end
  end

  if (OpGroup == fpnew_pkg::CONV) begin : target_regs

    logic [0:NumPipeRegs][Width-1:0] byp_pipe_target_q;
    logic [0:NumPipeRegs][      2:0] byp_pipe_aux_q;
    logic [0:NumPipeRegs]            byp_pipe_valid_q;

    logic [0:NumPipeRegs]            byp_pipe_ready;

    assign byp_pipe_target_q[0] = conv_target_d;
    assign byp_pipe_aux_q[0]    = target_aux_d;
    assign byp_pipe_valid_q[0]  = in_valid_i & vectorial_op;

    for (genvar i = 0; i < NumPipeRegs; i++) begin : gen_bypass_pipeline

      logic reg_ena;

      assign byp_pipe_ready[i] = byp_pipe_ready[i+1] | ~byp_pipe_valid_q[i+1];

      `FFLARNC(byp_pipe_valid_q[i+1], byp_pipe_valid_q[i], byp_pipe_ready[i], flush_i, 1'b0, clk_i,
               rst_ni)

      assign reg_ena = byp_pipe_ready[i] & byp_pipe_valid_q[i];

      `FFL(byp_pipe_target_q[i+1], byp_pipe_target_q[i], reg_ena, '0)
      `FFL(byp_pipe_aux_q[i+1], byp_pipe_aux_q[i], reg_ena, '0)
    end

    assign byp_pipe_ready[NumPipeRegs] = out_ready_i & result_is_vector;

    assign conv_target_q = byp_pipe_target_q[NumPipeRegs];

    assign {result_vec_op, result_is_cpk} = byp_pipe_aux_q[NumPipeRegs];
  end else begin : no_conv
    assign {result_vec_op, result_is_cpk} = '0;
  end

  assign simd_synch_rdy = EnableVectors ? &divsqrt_ready : divsqrt_ready[0];
  assign simd_synch_done = EnableVectors ? &divsqrt_done : divsqrt_done[0];

  assign {result_fmt_is_int, result_is_vector, result_fmt} = lane_aux[0];

  assign result_o = result_fmt_is_int
                    ? ifmt_slice_result[result_fmt]
                    : fmt_slice_result[result_fmt];

  assign extension_bit_o = lane_ext_bit[0];
  assign tag_o = lane_tags[0];
  assign busy_o = (|lane_busy);

  assign out_valid_o = lane_out_valid[0];

  always_comb begin : output_processing

    automatic fpnew_pkg::status_t temp_status;
    temp_status = '0;
    for (int i = 0; i < int'(NUM_LANES); i++) temp_status |= lane_status[i] & {5{lane_masks[i]}};
    status_o = temp_status;
  end

endmodule





module fpnew_noncomp #(
    parameter fpnew_pkg::fp_format_e   FpFormat    = fpnew_pkg::fp_format_e'(0),
    parameter int unsigned             NumPipeRegs = 0,
    parameter fpnew_pkg::pipe_config_t PipeConfig  = fpnew_pkg::BEFORE,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,

    localparam int unsigned WIDTH = fpnew_pkg::fp_width(FpFormat)
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                  [1:0][WIDTH-1:0] operands_i,
    input logic                  [1:0]            is_boxed_i,
    input fpnew_pkg::roundmode_e                  rnd_mode_i,
    input fpnew_pkg::operation_e                  op_i,
    input logic                                   op_mod_i,
    input TagType                                 tag_i,
    input logic                                   mask_i,
    input AuxType                                 aux_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,

    output logic                  [WIDTH-1:0] result_o,
    output fpnew_pkg::status_t                status_o,
    output logic                              extension_bit_o,
    output fpnew_pkg::classmask_e             class_mask_o,
    output logic                              is_class_o,
    output TagType                            tag_o,
    output logic                              mask_o,
    output AuxType                            aux_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(FpFormat);
  localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(FpFormat);

  localparam NUM_INP_REGS = (PipeConfig == fpnew_pkg::BEFORE || PipeConfig == fpnew_pkg::INSIDE)
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 2)
                               : 0);
  localparam NUM_OUT_REGS = PipeConfig == fpnew_pkg::AFTER
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 2)
                               : 0);

  typedef struct packed {
    logic                sign;
    logic [EXP_BITS-1:0] exponent;
    logic [MAN_BITS-1:0] mantissa;
  } fp_t;

  logic                  [0:NUM_INP_REGS][1:0][WIDTH-1:0] inp_pipe_operands_q;
  logic                  [0:NUM_INP_REGS][1:0]            inp_pipe_is_boxed_q;
  fpnew_pkg::roundmode_e [0:NUM_INP_REGS]                 inp_pipe_rnd_mode_q;
  fpnew_pkg::operation_e [0:NUM_INP_REGS]                 inp_pipe_op_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_op_mod_q;
  TagType                [0:NUM_INP_REGS]                 inp_pipe_tag_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_mask_q;
  AuxType                [0:NUM_INP_REGS]                 inp_pipe_aux_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_valid_q;

  logic                  [0:NUM_INP_REGS]                 inp_pipe_ready;

  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_is_boxed_q[0] = is_boxed_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_op_mod_q[0]   = op_mod_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;

  assign in_ready_o             = inp_pipe_ready[0];

  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline

    logic reg_ena;

    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];

    `FFLARNC(inp_pipe_valid_q[i+1], inp_pipe_valid_q[i], inp_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = inp_pipe_ready[i] & inp_pipe_valid_q[i];

    `FFL(inp_pipe_operands_q[i+1], inp_pipe_operands_q[i], reg_ena, '0)
    `FFL(inp_pipe_is_boxed_q[i+1], inp_pipe_is_boxed_q[i], reg_ena, '0)
    `FFL(inp_pipe_rnd_mode_q[i+1], inp_pipe_rnd_mode_q[i], reg_ena, fpnew_pkg::RNE)
    `FFL(inp_pipe_op_q[i+1], inp_pipe_op_q[i], reg_ena, fpnew_pkg::FMADD)
    `FFL(inp_pipe_op_mod_q[i+1], inp_pipe_op_mod_q[i], reg_ena, '0)
    `FFL(inp_pipe_tag_q[i+1], inp_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(inp_pipe_mask_q[i+1], inp_pipe_mask_q[i], reg_ena, '0)
    `FFL(inp_pipe_aux_q[i+1], inp_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  fpnew_pkg::fp_info_t [1:0] info_q;

  fpnew_classifier #(
      .FpFormat   (FpFormat),
      .NumOperands(2)
  ) i_class_a (
      .operands_i(inp_pipe_operands_q[NUM_INP_REGS]),
      .is_boxed_i(inp_pipe_is_boxed_q[NUM_INP_REGS]),
      .info_o    (info_q)
  );

  fp_t operand_a, operand_b;
  fpnew_pkg::fp_info_t info_a, info_b;

  assign operand_a = inp_pipe_operands_q[NUM_INP_REGS][0];
  assign operand_b = inp_pipe_operands_q[NUM_INP_REGS][1];
  assign info_a    = info_q[0];
  assign info_b    = info_q[1];

  logic any_operand_inf;
  logic any_operand_nan;
  logic signalling_nan;

  assign any_operand_inf = (|{info_a.is_inf, info_b.is_inf});
  assign any_operand_nan = (|{info_a.is_nan, info_b.is_nan});
  assign signalling_nan  = (|{info_a.is_signalling, info_b.is_signalling});

  logic operands_equal, operand_a_smaller;

  assign operands_equal    = (operand_a == operand_b) || (info_a.is_zero && info_b.is_zero);

  assign operand_a_smaller = (operand_a < operand_b) ^ (operand_a.sign || operand_b.sign);

  fp_t                sgnj_result;
  fpnew_pkg::status_t sgnj_status;
  logic               sgnj_extension_bit;

  always_comb begin : sign_injections
    logic sign_a, sign_b;

    sgnj_result = operand_a;

    if (!info_a.is_boxed)
      sgnj_result = '{sign: 1'b0, exponent: '1, mantissa: 2 ** (MAN_BITS - 1)};

    sign_a = operand_a.sign & info_a.is_boxed;
    sign_b = operand_b.sign & info_b.is_boxed;

    unique case (inp_pipe_rnd_mode_q[NUM_INP_REGS])
      fpnew_pkg::RNE: sgnj_result.sign = sign_b;
      fpnew_pkg::RTZ: sgnj_result.sign = ~sign_b;
      fpnew_pkg::RDN: sgnj_result.sign = sign_a ^ sign_b;
      fpnew_pkg::RUP: sgnj_result = operand_a;
      default:        sgnj_result = '{default: fpnew_pkg::DONT_CARE};
    endcase
  end

  assign sgnj_status = '0;

  assign sgnj_extension_bit = inp_pipe_op_mod_q[NUM_INP_REGS] ? sgnj_result.sign : 1'b1;

  fp_t                minmax_result;
  fpnew_pkg::status_t minmax_status;
  logic               minmax_extension_bit;

  always_comb begin : min_max

    minmax_status = '0;

    minmax_status.NV = signalling_nan;

    if (info_a.is_nan && info_b.is_nan)
      minmax_result = '{sign: 1'b0, exponent: '1, mantissa: 2 ** (MAN_BITS - 1)};

    else if (info_a.is_nan) minmax_result = operand_b;
    else if (info_b.is_nan) minmax_result = operand_a;

    else begin
      unique case (inp_pipe_rnd_mode_q[NUM_INP_REGS])
        fpnew_pkg::RNE: minmax_result = operand_a_smaller ? operand_a : operand_b;
        fpnew_pkg::RTZ: minmax_result = operand_a_smaller ? operand_b : operand_a;
        default: minmax_result = '{default: fpnew_pkg::DONT_CARE};
      endcase
    end
  end

  assign minmax_extension_bit = 1'b1;

  fp_t                cmp_result;
  fpnew_pkg::status_t cmp_status;
  logic               cmp_extension_bit;

  always_comb begin : comparisons

    cmp_result = '0;
    cmp_status = '0;

    if (signalling_nan) cmp_status.NV = 1'b1;

    else begin
      unique case (inp_pipe_rnd_mode_q[NUM_INP_REGS])
        fpnew_pkg::RNE: begin
          if (any_operand_nan) cmp_status.NV = 1'b1;
          else cmp_result = (operand_a_smaller | operands_equal) ^ inp_pipe_op_mod_q[NUM_INP_REGS];
        end
        fpnew_pkg::RTZ: begin
          if (any_operand_nan) cmp_status.NV = 1'b1;
          else cmp_result = (operand_a_smaller & ~operands_equal) ^ inp_pipe_op_mod_q[NUM_INP_REGS];
        end
        fpnew_pkg::RDN: begin
          if (any_operand_nan) cmp_result = inp_pipe_op_mod_q[NUM_INP_REGS];
          else cmp_result = operands_equal ^ inp_pipe_op_mod_q[NUM_INP_REGS];
        end
        default: cmp_result = '{default: fpnew_pkg::DONT_CARE};
      endcase
    end
  end

  assign cmp_extension_bit = 1'b0;

  fpnew_pkg::status_t    class_status;
  logic                  class_extension_bit;
  fpnew_pkg::classmask_e class_mask_d;

  always_comb begin : classify
    if (info_a.is_normal) begin
      class_mask_d = operand_a.sign ? fpnew_pkg::NEGNORM : fpnew_pkg::POSNORM;
    end else if (info_a.is_subnormal) begin
      class_mask_d = operand_a.sign ? fpnew_pkg::NEGSUBNORM : fpnew_pkg::POSSUBNORM;
    end else if (info_a.is_zero) begin
      class_mask_d = operand_a.sign ? fpnew_pkg::NEGZERO : fpnew_pkg::POSZERO;
    end else if (info_a.is_inf) begin
      class_mask_d = operand_a.sign ? fpnew_pkg::NEGINF : fpnew_pkg::POSINF;
    end else if (info_a.is_nan) begin
      class_mask_d = info_a.is_signalling ? fpnew_pkg::SNAN : fpnew_pkg::QNAN;
    end else begin
      class_mask_d = fpnew_pkg::QNAN;
    end
  end

  assign class_status        = '0;
  assign class_extension_bit = 1'b0;

  fp_t                result_d;
  fpnew_pkg::status_t status_d;
  logic               extension_bit_d;
  logic               is_class_d;

  always_comb begin : select_result
    unique case (inp_pipe_op_q[NUM_INP_REGS])
      fpnew_pkg::SGNJ: begin
        result_d        = sgnj_result;
        status_d        = sgnj_status;
        extension_bit_d = sgnj_extension_bit;
      end
      fpnew_pkg::MINMAX: begin
        result_d        = minmax_result;
        status_d        = minmax_status;
        extension_bit_d = minmax_extension_bit;
      end
      fpnew_pkg::CMP: begin
        result_d        = cmp_result;
        status_d        = cmp_status;
        extension_bit_d = cmp_extension_bit;
      end
      fpnew_pkg::CLASSIFY: begin
        result_d        = '{default: fpnew_pkg::DONT_CARE};
        status_d        = class_status;
        extension_bit_d = class_extension_bit;
      end
      default: begin
        result_d        = '{default: fpnew_pkg::DONT_CARE};
        status_d        = '{default: fpnew_pkg::DONT_CARE};
        extension_bit_d = fpnew_pkg::DONT_CARE;
      end
    endcase
  end

  assign is_class_d = (inp_pipe_op_q[NUM_INP_REGS] == fpnew_pkg::CLASSIFY);

  fp_t                   [0:NUM_OUT_REGS] out_pipe_result_q;
  fpnew_pkg::status_t    [0:NUM_OUT_REGS] out_pipe_status_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_extension_bit_q;
  fpnew_pkg::classmask_e [0:NUM_OUT_REGS] out_pipe_class_mask_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_is_class_q;
  TagType                [0:NUM_OUT_REGS] out_pipe_tag_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_mask_q;
  AuxType                [0:NUM_OUT_REGS] out_pipe_aux_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_valid_q;

  logic                  [0:NUM_OUT_REGS] out_pipe_ready;

  assign out_pipe_result_q[0]         = result_d;
  assign out_pipe_status_q[0]         = status_d;
  assign out_pipe_extension_bit_q[0]  = extension_bit_d;
  assign out_pipe_class_mask_q[0]     = class_mask_d;
  assign out_pipe_is_class_q[0]       = is_class_d;
  assign out_pipe_tag_q[0]            = inp_pipe_tag_q[NUM_INP_REGS];
  assign out_pipe_mask_q[0]           = inp_pipe_mask_q[NUM_INP_REGS];
  assign out_pipe_aux_q[0]            = inp_pipe_aux_q[NUM_INP_REGS];
  assign out_pipe_valid_q[0]          = inp_pipe_valid_q[NUM_INP_REGS];

  assign inp_pipe_ready[NUM_INP_REGS] = out_pipe_ready[0];

  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline

    logic reg_ena;

    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];

    `FFLARNC(out_pipe_valid_q[i+1], out_pipe_valid_q[i], out_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = out_pipe_ready[i] & out_pipe_valid_q[i];

    `FFL(out_pipe_result_q[i+1], out_pipe_result_q[i], reg_ena, '0)
    `FFL(out_pipe_status_q[i+1], out_pipe_status_q[i], reg_ena, '0)
    `FFL(out_pipe_extension_bit_q[i+1], out_pipe_extension_bit_q[i], reg_ena, '0)
    `FFL(out_pipe_class_mask_q[i+1], out_pipe_class_mask_q[i], reg_ena, fpnew_pkg::QNAN)
    `FFL(out_pipe_is_class_q[i+1], out_pipe_is_class_q[i], reg_ena, '0)
    `FFL(out_pipe_tag_q[i+1], out_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(out_pipe_mask_q[i+1], out_pipe_mask_q[i], reg_ena, '0)
    `FFL(out_pipe_aux_q[i+1], out_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;

  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = out_pipe_extension_bit_q[NUM_OUT_REGS];
  assign class_mask_o                 = out_pipe_class_mask_q[NUM_OUT_REGS];
  assign is_class_o                   = out_pipe_is_class_q[NUM_OUT_REGS];
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, out_pipe_valid_q});
endmodule





module fpnew_cast_multi #(
    parameter fpnew_pkg::fmt_logic_t  FpFmtConfig  = '1,
    parameter fpnew_pkg::ifmt_logic_t IntFmtConfig = '1,

    parameter int unsigned             NumPipeRegs = 0,
    parameter fpnew_pkg::pipe_config_t PipeConfig  = fpnew_pkg::BEFORE,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,

    localparam int unsigned WIDTH = fpnew_pkg::maximum(
        fpnew_pkg::max_fp_width(FpFmtConfig), fpnew_pkg::max_int_width(IntFmtConfig)
    ),
    localparam int unsigned NUM_FORMATS = fpnew_pkg::NUM_FP_FORMATS
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                   [      WIDTH-1:0] operands_i,
    input logic                   [NUM_FORMATS-1:0] is_boxed_i,
    input fpnew_pkg::roundmode_e                    rnd_mode_i,
    input fpnew_pkg::operation_e                    op_i,
    input logic                                     op_mod_i,
    input fpnew_pkg::fp_format_e                    src_fmt_i,
    input fpnew_pkg::fp_format_e                    dst_fmt_i,
    input fpnew_pkg::int_format_e                   int_fmt_i,
    input TagType                                   tag_i,
    input logic                                     mask_i,
    input AuxType                                   aux_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,

    output logic               [WIDTH-1:0] result_o,
    output fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic                           mask_o,
    output AuxType                         aux_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  localparam int unsigned NUM_INT_FORMATS = fpnew_pkg::NUM_INT_FORMATS;
  localparam int unsigned MAX_INT_WIDTH = fpnew_pkg::max_int_width(IntFmtConfig);

  localparam fpnew_pkg::fp_encoding_t SUPER_FORMAT = fpnew_pkg::super_format(FpFmtConfig);

  localparam int unsigned SUPER_EXP_BITS = SUPER_FORMAT.exp_bits;
  localparam int unsigned SUPER_MAN_BITS = SUPER_FORMAT.man_bits;
  localparam int unsigned SUPER_BIAS = 2 ** (SUPER_EXP_BITS - 1) - 1;

  localparam int unsigned INT_MAN_WIDTH = fpnew_pkg::maximum(SUPER_MAN_BITS + 1, MAX_INT_WIDTH);

  localparam int unsigned LZC_RESULT_WIDTH = $clog2(INT_MAN_WIDTH);

  localparam int unsigned INT_EXP_WIDTH = fpnew_pkg::maximum(
      $clog2(MAX_INT_WIDTH), fpnew_pkg::maximum(SUPER_EXP_BITS, $clog2(SUPER_BIAS + SUPER_MAN_BITS))
  ) + 1;

  localparam NUM_INP_REGS = PipeConfig == fpnew_pkg::BEFORE
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 3)
                               : 0);
  localparam NUM_MID_REGS = PipeConfig == fpnew_pkg::INSIDE
                          ? NumPipeRegs
                          : (PipeConfig == fpnew_pkg::DISTRIBUTED
                             ? ((NumPipeRegs + 2) / 3)
                             : 0);
  localparam NUM_OUT_REGS = PipeConfig == fpnew_pkg::AFTER
                            ? NumPipeRegs
                            : (PipeConfig == fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 3)
                               : 0);

  logic                   [      WIDTH-1:0]                  operands_q;
  logic                   [NUM_FORMATS-1:0]                  is_boxed_q;
  logic                                                      op_mod_q;
  fpnew_pkg::fp_format_e                                     src_fmt_q;
  fpnew_pkg::fp_format_e                                     dst_fmt_q;
  fpnew_pkg::int_format_e                                    int_fmt_q;

  logic                   [ 0:NUM_INP_REGS][      WIDTH-1:0] inp_pipe_operands_q;
  logic                   [ 0:NUM_INP_REGS][NUM_FORMATS-1:0] inp_pipe_is_boxed_q;
  fpnew_pkg::roundmode_e  [ 0:NUM_INP_REGS]                  inp_pipe_rnd_mode_q;
  fpnew_pkg::operation_e  [ 0:NUM_INP_REGS]                  inp_pipe_op_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_op_mod_q;
  fpnew_pkg::fp_format_e  [ 0:NUM_INP_REGS]                  inp_pipe_src_fmt_q;
  fpnew_pkg::fp_format_e  [ 0:NUM_INP_REGS]                  inp_pipe_dst_fmt_q;
  fpnew_pkg::int_format_e [ 0:NUM_INP_REGS]                  inp_pipe_int_fmt_q;
  TagType                 [ 0:NUM_INP_REGS]                  inp_pipe_tag_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_mask_q;
  AuxType                 [ 0:NUM_INP_REGS]                  inp_pipe_aux_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_valid_q;

  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_ready;

  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_is_boxed_q[0] = is_boxed_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_op_mod_q[0]   = op_mod_i;
  assign inp_pipe_src_fmt_q[0]  = src_fmt_i;
  assign inp_pipe_dst_fmt_q[0]  = dst_fmt_i;
  assign inp_pipe_int_fmt_q[0]  = int_fmt_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;

  assign in_ready_o             = inp_pipe_ready[0];

  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline

    logic reg_ena;

    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];

    `FFLARNC(inp_pipe_valid_q[i+1], inp_pipe_valid_q[i], inp_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = inp_pipe_ready[i] & inp_pipe_valid_q[i];

    `FFL(inp_pipe_operands_q[i+1], inp_pipe_operands_q[i], reg_ena, '0)
    `FFL(inp_pipe_is_boxed_q[i+1], inp_pipe_is_boxed_q[i], reg_ena, '0)
    `FFL(inp_pipe_rnd_mode_q[i+1], inp_pipe_rnd_mode_q[i], reg_ena, fpnew_pkg::RNE)
    `FFL(inp_pipe_op_q[i+1], inp_pipe_op_q[i], reg_ena, fpnew_pkg::FMADD)
    `FFL(inp_pipe_op_mod_q[i+1], inp_pipe_op_mod_q[i], reg_ena, '0)
    `FFL(inp_pipe_src_fmt_q[i+1], inp_pipe_src_fmt_q[i], reg_ena, fpnew_pkg::fp_format_e'(0))
    `FFL(inp_pipe_dst_fmt_q[i+1], inp_pipe_dst_fmt_q[i], reg_ena, fpnew_pkg::fp_format_e'(0))
    `FFL(inp_pipe_int_fmt_q[i+1], inp_pipe_int_fmt_q[i], reg_ena, fpnew_pkg::int_format_e'(0))
    `FFL(inp_pipe_tag_q[i+1], inp_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(inp_pipe_mask_q[i+1], inp_pipe_mask_q[i], reg_ena, '0)
    `FFL(inp_pipe_aux_q[i+1], inp_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  assign operands_q = inp_pipe_operands_q[NUM_INP_REGS];
  assign is_boxed_q = inp_pipe_is_boxed_q[NUM_INP_REGS];
  assign op_mod_q   = inp_pipe_op_mod_q[NUM_INP_REGS];
  assign src_fmt_q  = inp_pipe_src_fmt_q[NUM_INP_REGS];
  assign dst_fmt_q  = inp_pipe_dst_fmt_q[NUM_INP_REGS];
  assign int_fmt_q  = inp_pipe_int_fmt_q[NUM_INP_REGS];

  logic src_is_int, dst_is_int;

  assign src_is_int = (inp_pipe_op_q[NUM_INP_REGS] == fpnew_pkg::I2F);
  assign dst_is_int = (inp_pipe_op_q[NUM_INP_REGS] == fpnew_pkg::F2I);

  logic                [  INT_MAN_WIDTH-1:0]                    encoded_mant;

  logic                [    NUM_FORMATS-1:0]                    fmt_sign;
  logic signed         [    NUM_FORMATS-1:0][INT_EXP_WIDTH-1:0] fmt_exponent;
  logic                [    NUM_FORMATS-1:0][INT_MAN_WIDTH-1:0] fmt_mantissa;
  logic signed         [    NUM_FORMATS-1:0][INT_EXP_WIDTH-1:0] fmt_shift_compensation;

  fpnew_pkg::fp_info_t [    NUM_FORMATS-1:0]                    info;

  logic                [NUM_INT_FORMATS-1:0][INT_MAN_WIDTH-1:0] ifmt_input_val;
  logic                                                         int_sign;
  logic [INT_MAN_WIDTH-1:0] int_value, int_mantissa;

  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : fmt_init_inputs

    localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(fpnew_pkg::fp_format_e'(fmt));

    if (FpFmtConfig[fmt]) begin : active_format

      fpnew_classifier #(
          .FpFormat   (fpnew_pkg::fp_format_e'(fmt)),
          .NumOperands(1)
      ) i_fpnew_classifier (
          .operands_i(operands_q[FP_WIDTH-1:0]),
          .is_boxed_i(is_boxed_q[fmt]),
          .info_o    (info[fmt])
      );

      assign fmt_sign[fmt]               = operands_q[FP_WIDTH-1];
      assign fmt_exponent[fmt]           = signed'({1'b0, operands_q[MAN_BITS+:EXP_BITS]});
      assign fmt_mantissa[fmt]           = {info[fmt].is_normal, operands_q[MAN_BITS-1:0]};

      assign fmt_shift_compensation[fmt] = signed'(INT_MAN_WIDTH - 1 - MAN_BITS);
    end else begin : inactive_format
      assign info[fmt]                   = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_sign[fmt]               = fpnew_pkg::DONT_CARE;
      assign fmt_exponent[fmt]           = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_mantissa[fmt]           = '{default: fpnew_pkg::DONT_CARE};
      assign fmt_shift_compensation[fmt] = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_sign_extend_int

    localparam int unsigned INT_WIDTH = fpnew_pkg::int_width(fpnew_pkg::int_format_e'(ifmt));

    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : sign_ext_input

        ifmt_input_val[ifmt]                = '{default: operands_q[INT_WIDTH-1] & ~op_mod_q};
        ifmt_input_val[ifmt][INT_WIDTH-1:0] = operands_q[INT_WIDTH-1:0];
      end
    end else begin : inactive_format
      assign ifmt_input_val[ifmt] = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  assign int_value    = ifmt_input_val[int_fmt_q];
  assign int_sign     = int_value[INT_MAN_WIDTH-1] & ~op_mod_q;
  assign int_mantissa = int_sign ? unsigned'(-int_value) : int_value;

  assign encoded_mant = src_is_int ? int_mantissa : fmt_mantissa[src_fmt_q];

  logic signed [INT_EXP_WIDTH-1:0] src_bias;
  logic signed [INT_EXP_WIDTH-1:0] src_exp;
  logic signed [INT_EXP_WIDTH-1:0] src_subnormal;
  logic signed [INT_EXP_WIDTH-1:0] src_offset;

  assign src_bias      = signed'(fpnew_pkg::bias(src_fmt_q));
  assign src_exp       = fmt_exponent[src_fmt_q];
  assign src_subnormal = signed'({1'b0, info[src_fmt_q].is_subnormal});
  assign src_offset    = fmt_shift_compensation[src_fmt_q];

  logic                               input_sign;
  logic signed [   INT_EXP_WIDTH-1:0] input_exp;
  logic        [   INT_MAN_WIDTH-1:0] input_mant;
  logic                               mant_is_zero;

  logic signed [   INT_EXP_WIDTH-1:0] fp_input_exp;
  logic signed [   INT_EXP_WIDTH-1:0] int_input_exp;

  logic        [LZC_RESULT_WIDTH-1:0] renorm_shamt;
  logic        [  LZC_RESULT_WIDTH:0] renorm_shamt_sgn;

  lzc #(
      .WIDTH(INT_MAN_WIDTH),
      .MODE (1)
  ) i_lzc (
      .in_i   (encoded_mant),
      .cnt_o  (renorm_shamt),
      .empty_o(mant_is_zero)
  );
  assign renorm_shamt_sgn = signed'({1'b0, renorm_shamt});

  assign input_sign = src_is_int ? int_sign : fmt_sign[src_fmt_q];

  assign input_mant = encoded_mant << renorm_shamt;

  assign fp_input_exp = signed'(src_exp + src_subnormal - src_bias - renorm_shamt_sgn + src_offset);
  assign int_input_exp = signed'(INT_MAN_WIDTH - 1 - renorm_shamt_sgn);

  assign input_exp = src_is_int ? int_input_exp : fp_input_exp;

  logic signed [INT_EXP_WIDTH-1:0] destination_exp;

  assign destination_exp = input_exp + signed'(fpnew_pkg::bias(dst_fmt_q));

  logic                                                          input_sign_q;
  logic signed            [INT_EXP_WIDTH-1:0]                    input_exp_q;
  logic                   [INT_MAN_WIDTH-1:0]                    input_mant_q;
  logic signed            [INT_EXP_WIDTH-1:0]                    destination_exp_q;
  logic                                                          src_is_int_q;
  logic                                                          dst_is_int_q;
  fpnew_pkg::fp_info_t                                           info_q;
  logic                                                          mant_is_zero_q;
  logic                                                          op_mod_q2;
  fpnew_pkg::roundmode_e                                         rnd_mode_q;
  fpnew_pkg::fp_format_e                                         src_fmt_q2;
  fpnew_pkg::fp_format_e                                         dst_fmt_q2;
  fpnew_pkg::int_format_e                                        int_fmt_q2;

  logic                   [   0:NUM_MID_REGS]                    mid_pipe_input_sign_q;
  logic signed            [   0:NUM_MID_REGS][INT_EXP_WIDTH-1:0] mid_pipe_input_exp_q;
  logic                   [   0:NUM_MID_REGS][INT_MAN_WIDTH-1:0] mid_pipe_input_mant_q;
  logic signed            [   0:NUM_MID_REGS][INT_EXP_WIDTH-1:0] mid_pipe_dest_exp_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_src_is_int_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_dst_is_int_q;
  fpnew_pkg::fp_info_t    [   0:NUM_MID_REGS]                    mid_pipe_info_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_mant_zero_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_op_mod_q;
  fpnew_pkg::roundmode_e  [   0:NUM_MID_REGS]                    mid_pipe_rnd_mode_q;
  fpnew_pkg::fp_format_e  [   0:NUM_MID_REGS]                    mid_pipe_src_fmt_q;
  fpnew_pkg::fp_format_e  [   0:NUM_MID_REGS]                    mid_pipe_dst_fmt_q;
  fpnew_pkg::int_format_e [   0:NUM_MID_REGS]                    mid_pipe_int_fmt_q;
  TagType                 [   0:NUM_MID_REGS]                    mid_pipe_tag_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_mask_q;
  AuxType                 [   0:NUM_MID_REGS]                    mid_pipe_aux_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_valid_q;

  logic                   [   0:NUM_MID_REGS]                    mid_pipe_ready;

  assign mid_pipe_input_sign_q[0]     = input_sign;
  assign mid_pipe_input_exp_q[0]      = input_exp;
  assign mid_pipe_input_mant_q[0]     = input_mant;
  assign mid_pipe_dest_exp_q[0]       = destination_exp;
  assign mid_pipe_src_is_int_q[0]     = src_is_int;
  assign mid_pipe_dst_is_int_q[0]     = dst_is_int;
  assign mid_pipe_info_q[0]           = info[src_fmt_q];
  assign mid_pipe_mant_zero_q[0]      = mant_is_zero;
  assign mid_pipe_op_mod_q[0]         = op_mod_q;
  assign mid_pipe_rnd_mode_q[0]       = inp_pipe_rnd_mode_q[NUM_INP_REGS];
  assign mid_pipe_src_fmt_q[0]        = src_fmt_q;
  assign mid_pipe_dst_fmt_q[0]        = dst_fmt_q;
  assign mid_pipe_int_fmt_q[0]        = int_fmt_q;
  assign mid_pipe_tag_q[0]            = inp_pipe_tag_q[NUM_INP_REGS];
  assign mid_pipe_mask_q[0]           = inp_pipe_mask_q[NUM_INP_REGS];
  assign mid_pipe_aux_q[0]            = inp_pipe_aux_q[NUM_INP_REGS];
  assign mid_pipe_valid_q[0]          = inp_pipe_valid_q[NUM_INP_REGS];

  assign inp_pipe_ready[NUM_INP_REGS] = mid_pipe_ready[0];

  for (genvar i = 0; i < NUM_MID_REGS; i++) begin : gen_inside_pipeline

    logic reg_ena;

    assign mid_pipe_ready[i] = mid_pipe_ready[i+1] | ~mid_pipe_valid_q[i+1];

    `FFLARNC(mid_pipe_valid_q[i+1], mid_pipe_valid_q[i], mid_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = mid_pipe_ready[i] & mid_pipe_valid_q[i];

    `FFL(mid_pipe_input_sign_q[i+1], mid_pipe_input_sign_q[i], reg_ena, '0)
    `FFL(mid_pipe_input_exp_q[i+1], mid_pipe_input_exp_q[i], reg_ena, '0)
    `FFL(mid_pipe_input_mant_q[i+1], mid_pipe_input_mant_q[i], reg_ena, '0)
    `FFL(mid_pipe_dest_exp_q[i+1], mid_pipe_dest_exp_q[i], reg_ena, '0)
    `FFL(mid_pipe_src_is_int_q[i+1], mid_pipe_src_is_int_q[i], reg_ena, '0)
    `FFL(mid_pipe_dst_is_int_q[i+1], mid_pipe_dst_is_int_q[i], reg_ena, '0)
    `FFL(mid_pipe_info_q[i+1], mid_pipe_info_q[i], reg_ena, '0)
    `FFL(mid_pipe_mant_zero_q[i+1], mid_pipe_mant_zero_q[i], reg_ena, '0)
    `FFL(mid_pipe_op_mod_q[i+1], mid_pipe_op_mod_q[i], reg_ena, '0)
    `FFL(mid_pipe_rnd_mode_q[i+1], mid_pipe_rnd_mode_q[i], reg_ena, fpnew_pkg::RNE)
    `FFL(mid_pipe_src_fmt_q[i+1], mid_pipe_src_fmt_q[i], reg_ena, fpnew_pkg::fp_format_e'(0))
    `FFL(mid_pipe_dst_fmt_q[i+1], mid_pipe_dst_fmt_q[i], reg_ena, fpnew_pkg::fp_format_e'(0))
    `FFL(mid_pipe_int_fmt_q[i+1], mid_pipe_int_fmt_q[i], reg_ena, fpnew_pkg::int_format_e'(0))
    `FFL(mid_pipe_tag_q[i+1], mid_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(mid_pipe_mask_q[i+1], mid_pipe_mask_q[i], reg_ena, '0)
    `FFL(mid_pipe_aux_q[i+1], mid_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  assign input_sign_q      = mid_pipe_input_sign_q[NUM_MID_REGS];
  assign input_exp_q       = mid_pipe_input_exp_q[NUM_MID_REGS];
  assign input_mant_q      = mid_pipe_input_mant_q[NUM_MID_REGS];
  assign destination_exp_q = mid_pipe_dest_exp_q[NUM_MID_REGS];
  assign src_is_int_q      = mid_pipe_src_is_int_q[NUM_MID_REGS];
  assign dst_is_int_q      = mid_pipe_dst_is_int_q[NUM_MID_REGS];
  assign info_q            = mid_pipe_info_q[NUM_MID_REGS];
  assign mant_is_zero_q    = mid_pipe_mant_zero_q[NUM_MID_REGS];
  assign op_mod_q2         = mid_pipe_op_mod_q[NUM_MID_REGS];
  assign rnd_mode_q        = mid_pipe_rnd_mode_q[NUM_MID_REGS];
  assign src_fmt_q2        = mid_pipe_src_fmt_q[NUM_MID_REGS];
  assign dst_fmt_q2        = mid_pipe_dst_fmt_q[NUM_MID_REGS];
  assign int_fmt_q2        = mid_pipe_int_fmt_q[NUM_MID_REGS];

  logic [INT_EXP_WIDTH-1:0] final_exp;

  logic [2*INT_MAN_WIDTH:0] preshift_mant;
  logic [2*INT_MAN_WIDTH:0] destination_mant;
  logic [SUPER_MAN_BITS-1:0] final_mant;
  logic [MAX_INT_WIDTH-1:0] final_int;

  logic [$clog2(INT_MAN_WIDTH+1)-1:0] denorm_shamt;

  logic [1:0] fp_round_sticky_bits, int_round_sticky_bits, round_sticky_bits;
  logic of_before_round, uf_before_round;

  always_comb begin : cast_value

    final_exp       = unsigned'(destination_exp_q);
    preshift_mant   = '0;
    denorm_shamt    = SUPER_MAN_BITS - fpnew_pkg::man_bits(dst_fmt_q2);
    of_before_round = 1'b0;
    uf_before_round = 1'b0;

    preshift_mant   = input_mant_q << (INT_MAN_WIDTH + 1);

    if (dst_is_int_q) begin

      denorm_shamt = unsigned'(MAX_INT_WIDTH - 1 - input_exp_q);

      if (input_exp_q >= signed'(fpnew_pkg::int_width(int_fmt_q2) - 1 + op_mod_q2)) begin
        denorm_shamt    = '0;
        of_before_round = 1'b1;

      end else if (input_exp_q < -1) begin
        denorm_shamt    = MAX_INT_WIDTH + 1;
        uf_before_round = 1'b1;
      end

    end else begin

      if ((destination_exp_q >= signed'(2 ** fpnew_pkg::exp_bits(
              dst_fmt_q2
          )) - 1) || (~src_is_int_q && info_q.is_inf)) begin
        final_exp       = unsigned'(2 ** fpnew_pkg::exp_bits(dst_fmt_q2) - 2);
        preshift_mant   = '1;
        of_before_round = 1'b1;

      end else if (destination_exp_q < 1 && destination_exp_q >= -signed'(fpnew_pkg::man_bits(
              dst_fmt_q2
          ))) begin
        final_exp       = '0;
        denorm_shamt    = unsigned'(denorm_shamt + 1 - destination_exp_q);
        uf_before_round = 1'b1;

      end else if (destination_exp_q < -signed'(fpnew_pkg::man_bits(dst_fmt_q2))) begin
        final_exp       = '0;
        denorm_shamt    = unsigned'(denorm_shamt + 2 + fpnew_pkg::man_bits(dst_fmt_q2));
        uf_before_round = 1'b1;
      end
    end
  end

  localparam NUM_FP_STICKY = 2 * INT_MAN_WIDTH - SUPER_MAN_BITS - 1;
  localparam NUM_INT_STICKY = 2 * INT_MAN_WIDTH - MAX_INT_WIDTH;

  assign destination_mant = preshift_mant >> denorm_shamt;

  assign {final_mant, fp_round_sticky_bits[1]} =
      destination_mant[2*INT_MAN_WIDTH-1-:SUPER_MAN_BITS+1];
  assign {final_int, int_round_sticky_bits[1]} = destination_mant[2*INT_MAN_WIDTH-:MAX_INT_WIDTH+1];

  assign fp_round_sticky_bits[0] = (|{destination_mant[NUM_FP_STICKY-1:0]});
  assign int_round_sticky_bits[0] = (|{destination_mant[NUM_INT_STICKY-1:0]});

  assign round_sticky_bits = dst_is_int_q ? int_round_sticky_bits : fp_round_sticky_bits;

  logic [          WIDTH-1:0]            pre_round_abs;
  logic                                  of_after_round;
  logic                                  uf_after_round;

  logic [    NUM_FORMATS-1:0][WIDTH-1:0] fmt_pre_round_abs;
  logic [    NUM_FORMATS-1:0]            fmt_of_after_round;
  logic [    NUM_FORMATS-1:0]            fmt_uf_after_round;

  logic [NUM_INT_FORMATS-1:0][WIDTH-1:0] ifmt_pre_round_abs;
  logic [NUM_INT_FORMATS-1:0]            ifmt_of_after_round;

  logic                                  rounded_sign;
  logic [          WIDTH-1:0]            rounded_abs;
  logic                                  result_true_zero;

  logic [          WIDTH-1:0]            rounded_int_res;
  logic                                  rounded_int_res_zero;

  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_res_assemble

    localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(fpnew_pkg::fp_format_e'(fmt));

    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : assemble_result
        fmt_pre_round_abs[fmt] = {final_exp[EXP_BITS-1:0], final_mant[MAN_BITS-1:0]};
      end
    end else begin : inactive_format
      assign fmt_pre_round_abs[fmt] = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_int_res_sign_ext

    localparam int unsigned INT_WIDTH = fpnew_pkg::int_width(fpnew_pkg::int_format_e'(ifmt));

    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : assemble_result

        ifmt_pre_round_abs[ifmt]                = '{default: final_int[INT_WIDTH-1]};
        ifmt_pre_round_abs[ifmt][INT_WIDTH-1:0] = final_int[INT_WIDTH-1:0];
      end
    end else begin : inactive_format
      assign ifmt_pre_round_abs[ifmt] = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  assign pre_round_abs = dst_is_int_q ? ifmt_pre_round_abs[int_fmt_q2] : fmt_pre_round_abs[dst_fmt_q2];

  fpnew_rounding #(
      .AbsWidth(WIDTH)
  ) i_fpnew_rounding (
      .abs_value_i            (pre_round_abs),
      .sign_i                 (input_sign_q),
      .round_sticky_bits_i    (round_sticky_bits),
      .rnd_mode_i             (rnd_mode_q),
      .effective_subtraction_i(1'b0),
      .abs_rounded_o          (rounded_abs),
      .sign_o                 (rounded_sign),
      .exact_zero_o           (result_true_zero)
  );

  logic [NUM_FORMATS-1:0][WIDTH-1:0] fmt_result;

  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_sign_inject

    localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(fpnew_pkg::fp_format_e'(fmt));

    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : post_process

        fmt_uf_after_round[fmt] = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '0;
        fmt_of_after_round[fmt] = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '1;

        fmt_result[fmt] = '1;
        fmt_result[fmt][FP_WIDTH-1:0] = src_is_int_q & mant_is_zero_q
                                        ? '0
                                        : {rounded_sign, rounded_abs[EXP_BITS+MAN_BITS-1:0]};
      end
    end else begin : inactive_format
      assign fmt_uf_after_round[fmt] = fpnew_pkg::DONT_CARE;
      assign fmt_of_after_round[fmt] = fpnew_pkg::DONT_CARE;
      assign fmt_result[fmt]         = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  assign rounded_int_res      = rounded_sign ? unsigned'(-rounded_abs) : rounded_abs;
  assign rounded_int_res_zero = (rounded_int_res == '0);

  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_int_overflow

    localparam int unsigned INT_WIDTH = fpnew_pkg::int_width(fpnew_pkg::int_format_e'(ifmt));

    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : detect_overflow
        ifmt_of_after_round[ifmt] = 1'b0;

        if (!rounded_sign && input_exp_q == signed'(INT_WIDTH - 2 + op_mod_q2)) begin

          ifmt_of_after_round[ifmt] = ~rounded_int_res[INT_WIDTH-2+op_mod_q2];
        end
      end
    end else begin : inactive_format
      assign ifmt_of_after_round[ifmt] = fpnew_pkg::DONT_CARE;
    end
  end

  assign uf_after_round = fmt_uf_after_round[dst_fmt_q2];
  assign of_after_round = dst_is_int_q ? ifmt_of_after_round[int_fmt_q2] : fmt_of_after_round[dst_fmt_q2];

  logic               [      WIDTH-1:0]            fp_special_result;
  fpnew_pkg::status_t                              fp_special_status;
  logic                                            fp_result_is_special;

  logic               [NUM_FORMATS-1:0][WIDTH-1:0] fmt_special_result;

  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_special_results

    localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = fpnew_pkg::exp_bits(fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = fpnew_pkg::man_bits(fpnew_pkg::fp_format_e'(fmt));

    localparam logic [EXP_BITS-1:0] QNAN_EXPONENT = '1;
    localparam logic [MAN_BITS-1:0] QNAN_MANTISSA = 2 ** (MAN_BITS - 1);

    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : special_results
        logic [FP_WIDTH-1:0] special_res;
        special_res = info_q.is_zero
                      ? input_sign_q << FP_WIDTH-1
                      : {1'b0, QNAN_EXPONENT, QNAN_MANTISSA};

        fmt_special_result[fmt] = '1;
        fmt_special_result[fmt][FP_WIDTH-1:0] = special_res;
      end
    end else begin : inactive_format
      assign fmt_special_result[fmt] = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  assign fp_result_is_special = ~src_is_int_q & (info_q.is_zero | info_q.is_nan | ~info_q.is_boxed);

  assign fp_special_status = '{NV: info_q.is_signalling, default: 1'b0};

  assign fp_special_result = fmt_special_result[dst_fmt_q2];

  logic               [          WIDTH-1:0]            int_special_result;
  fpnew_pkg::status_t                                  int_special_status;
  logic                                                int_result_is_special;

  logic               [NUM_INT_FORMATS-1:0][WIDTH-1:0] ifmt_special_result;

  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_special_results_int

    localparam int unsigned INT_WIDTH = fpnew_pkg::int_width(fpnew_pkg::int_format_e'(ifmt));

    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : special_results
        automatic logic [INT_WIDTH-1:0] special_res;

        special_res[INT_WIDTH-2:0] = '1;
        special_res[INT_WIDTH-1]   = op_mod_q2;

        if (input_sign_q && !info_q.is_nan) special_res = ~special_res;

        ifmt_special_result[ifmt]                = '{default: special_res[INT_WIDTH-1]};
        ifmt_special_result[ifmt][INT_WIDTH-1:0] = special_res;
      end
    end else begin : inactive_format
      assign ifmt_special_result[ifmt] = '{default: fpnew_pkg::DONT_CARE};
    end
  end

  assign int_result_is_special = info_q.is_nan | info_q.is_inf |
                                 of_before_round | of_after_round | ~info_q.is_boxed |
                                 (input_sign_q & op_mod_q2 & ~rounded_int_res_zero);

  assign int_special_status = '{NV: 1'b1, default: 1'b0};

  assign int_special_result = ifmt_special_result[int_fmt_q2];

  fpnew_pkg::status_t int_regular_status, fp_regular_status;

  logic [WIDTH-1:0] fp_result, int_result;
  fpnew_pkg::status_t fp_status, int_status;

  assign fp_regular_status.NV = src_is_int_q & (of_before_round | of_after_round);
  assign fp_regular_status.DZ = 1'b0;
  assign fp_regular_status.OF = ~src_is_int_q & (~info_q.is_inf & (of_before_round | of_after_round));
  assign fp_regular_status.UF = uf_after_round & fp_regular_status.NX;
  assign fp_regular_status.NX = src_is_int_q ? (| fp_round_sticky_bits)
            : (| fp_round_sticky_bits) | (~info_q.is_inf & (of_before_round | of_after_round));
  assign int_regular_status = '{NX: (|int_round_sticky_bits), default: 1'b0};

  assign fp_result = fp_result_is_special ? fp_special_result : fmt_result[dst_fmt_q2];
  assign fp_status = fp_result_is_special ? fp_special_status : fp_regular_status;
  assign int_result = int_result_is_special ? int_special_result : rounded_int_res;
  assign int_status = int_result_is_special ? int_special_status : int_regular_status;

  logic               [WIDTH-1:0] result_d;
  fpnew_pkg::status_t             status_d;
  logic                           extension_bit;

  assign result_d = dst_is_int_q ? int_result : fp_result;
  assign status_d = dst_is_int_q ? int_status : fp_status;

  assign extension_bit = dst_is_int_q ? int_result[WIDTH-1] : 1'b1;

  logic               [0:NUM_OUT_REGS][WIDTH-1:0] out_pipe_result_q;
  fpnew_pkg::status_t [0:NUM_OUT_REGS]            out_pipe_status_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_ext_bit_q;
  TagType             [0:NUM_OUT_REGS]            out_pipe_tag_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_mask_q;
  AuxType             [0:NUM_OUT_REGS]            out_pipe_aux_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_valid_q;

  logic               [0:NUM_OUT_REGS]            out_pipe_ready;

  assign out_pipe_result_q[0]         = result_d;
  assign out_pipe_status_q[0]         = status_d;
  assign out_pipe_ext_bit_q[0]        = extension_bit;
  assign out_pipe_tag_q[0]            = mid_pipe_tag_q[NUM_MID_REGS];
  assign out_pipe_mask_q[0]           = mid_pipe_mask_q[NUM_MID_REGS];
  assign out_pipe_aux_q[0]            = mid_pipe_aux_q[NUM_MID_REGS];
  assign out_pipe_valid_q[0]          = mid_pipe_valid_q[NUM_MID_REGS];

  assign mid_pipe_ready[NUM_MID_REGS] = out_pipe_ready[0];

  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline

    logic reg_ena;

    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];

    `FFLARNC(out_pipe_valid_q[i+1], out_pipe_valid_q[i], out_pipe_ready[i], flush_i, 1'b0, clk_i,
             rst_ni)

    assign reg_ena = out_pipe_ready[i] & out_pipe_valid_q[i];

    `FFL(out_pipe_result_q[i+1], out_pipe_result_q[i], reg_ena, '0)
    `FFL(out_pipe_status_q[i+1], out_pipe_status_q[i], reg_ena, '0)
    `FFL(out_pipe_ext_bit_q[i+1], out_pipe_ext_bit_q[i], reg_ena, '0)
    `FFL(out_pipe_tag_q[i+1], out_pipe_tag_q[i], reg_ena, TagType'('0))
    `FFL(out_pipe_mask_q[i+1], out_pipe_mask_q[i], reg_ena, '0)
    `FFL(out_pipe_aux_q[i+1], out_pipe_aux_q[i], reg_ena, AuxType'('0))
  end

  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;

  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = out_pipe_ext_bit_q[NUM_OUT_REGS];
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, mid_pipe_valid_q, out_pipe_valid_q});
endmodule




module fpnew_top #(

    parameter fpnew_pkg::fpu_features_t       Features       = fpnew_pkg::RV64D_Xsflt,
    parameter fpnew_pkg::fpu_implementation_t Implementation = fpnew_pkg::DEFAULT_NOREGS,
    parameter type                            TagType        = logic,
    parameter int unsigned                    TrueSIMDClass  = 0,
    parameter int unsigned                    EnableSIMDMask = 0,

    localparam int unsigned NumLanes = fpnew_pkg::max_num_lanes(
        Features.Width, Features.FpFmtMask, Features.EnableVectors
    ),
    localparam type MaskType = logic [NumLanes-1:0],
    localparam int unsigned WIDTH = Features.Width,
    localparam int unsigned NUM_OPERANDS = 3
) (
    input logic clk_i,
    input logic rst_ni,

    input logic                   [NUM_OPERANDS-1:0][WIDTH-1:0] operands_i,
    input fpnew_pkg::roundmode_e                                rnd_mode_i,
    input fpnew_pkg::operation_e                                op_i,
    input logic                                                 op_mod_i,
    input fpnew_pkg::fp_format_e                                src_fmt_i,
    input fpnew_pkg::fp_format_e                                dst_fmt_i,
    input fpnew_pkg::int_format_e                               int_fmt_i,
    input logic                                                 vectorial_op_i,
    input TagType                                               tag_i,
    input MaskType                                              simd_mask_i,

    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,

    output logic               [WIDTH-1:0] result_o,
    output fpnew_pkg::status_t             status_o,
    output TagType                         tag_o,

    output logic out_valid_o,
    input  logic out_ready_i,

    output logic busy_o
);

  localparam int unsigned NUM_OPGROUPS = fpnew_pkg::NUM_OPGROUPS;
  localparam int unsigned NUM_FORMATS = fpnew_pkg::NUM_FP_FORMATS;

  typedef struct packed {
    logic [WIDTH-1:0]   result;
    fpnew_pkg::status_t status;
    TagType             tag;
  } output_t;

  logic [NUM_OPGROUPS-1:0] opgrp_in_ready, opgrp_out_valid, opgrp_out_ready, opgrp_ext, opgrp_busy;
  output_t [NUM_OPGROUPS-1:0] opgrp_outputs;

  logic [NUM_FORMATS-1:0][NUM_OPERANDS-1:0] is_boxed;

  assign in_ready_o = in_valid_i & opgrp_in_ready[fpnew_pkg::get_opgroup(op_i)];

  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_nanbox_check
    localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));

    if (Features.EnableNanBox && (FP_WIDTH < WIDTH)) begin : check
      for (genvar op = 0; op < int'(NUM_OPERANDS); op++) begin : operands
        assign is_boxed[fmt][op] = (!vectorial_op_i)
                                   ? operands_i[op][WIDTH-1:FP_WIDTH] == '1
                                   : 1'b1;
      end
    end else begin : no_check
      assign is_boxed[fmt] = '1;
    end
  end

  MaskType simd_mask;
  assign simd_mask = simd_mask_i | ~{NumLanes{logic'(EnableSIMDMask)}};

  for (genvar opgrp = 0; opgrp < int'(NUM_OPGROUPS); opgrp++) begin : gen_operation_groups
    localparam int unsigned NUM_OPS = fpnew_pkg::num_operands(fpnew_pkg::opgroup_e'(opgrp));

    logic in_valid;
    logic [NUM_FORMATS-1:0][NUM_OPS-1:0] input_boxed;

    assign in_valid = in_valid_i & (fpnew_pkg::get_opgroup(op_i) == fpnew_pkg::opgroup_e'(opgrp));

    always_comb begin : slice_inputs
      for (int unsigned fmt = 0; fmt < NUM_FORMATS; fmt++)
      input_boxed[fmt] = is_boxed[fmt][NUM_OPS-1:0];
    end

    fpnew_opgroup_block #(
        .OpGroup      (fpnew_pkg::opgroup_e'(opgrp)),
        .Width        (WIDTH),
        .EnableVectors(Features.EnableVectors),
        .FpFmtMask    (Features.FpFmtMask),
        .IntFmtMask   (Features.IntFmtMask),
        .FmtPipeRegs  (Implementation.PipeRegs[opgrp]),
        .FmtUnitTypes (Implementation.UnitTypes[opgrp]),
        .PipeConfig   (Implementation.PipeConfig),
        .TagType      (TagType),
        .TrueSIMDClass(TrueSIMDClass)
    ) i_opgroup_block (
        .clk_i,
        .rst_ni,
        .operands_i     (operands_i[NUM_OPS-1:0]),
        .is_boxed_i     (input_boxed),
        .rnd_mode_i,
        .op_i,
        .op_mod_i,
        .src_fmt_i,
        .dst_fmt_i,
        .int_fmt_i,
        .vectorial_op_i,
        .tag_i,
        .simd_mask_i    (simd_mask),
        .in_valid_i     (in_valid),
        .in_ready_o     (opgrp_in_ready[opgrp]),
        .flush_i,
        .result_o       (opgrp_outputs[opgrp].result),
        .status_o       (opgrp_outputs[opgrp].status),
        .extension_bit_o(opgrp_ext[opgrp]),
        .tag_o          (opgrp_outputs[opgrp].tag),
        .out_valid_o    (opgrp_out_valid[opgrp]),
        .out_ready_i    (opgrp_out_ready[opgrp]),
        .busy_o         (opgrp_busy[opgrp])
    );
  end

  output_t arbiter_output;

  rr_arb_tree #(
      .NumIn    (NUM_OPGROUPS),
      .DataType (output_t),
      .AxiVldRdy(1'b1)
  ) i_arbiter (
      .clk_i,
      .rst_ni,
      .flush_i,
      .rr_i  ('0),
      .req_i (opgrp_out_valid),
      .gnt_o (opgrp_out_ready),
      .data_i(opgrp_outputs),
      .gnt_i (out_ready_i),
      .req_o (out_valid_o),
      .data_o(arbiter_output),
      .idx_o ()
  );

  assign result_o = arbiter_output.result;
  assign status_o = arbiter_output.status;
  assign tag_o    = arbiter_output.tag;

  assign busy_o   = (|opgrp_busy);

endmodule




module fpu_wrap
  import ariane_pkg::*;
#(
    parameter config_pkg::cva6_cfg_t CVA6Cfg = '{

        XLEN                  : 64,
        VLEN                  : 0,
        PLEN                  : 64,
        GPLEN                 : 64,
        IS_XLEN32             : 1'b0,
        IS_XLEN64             : 1'b1,
        XLEN_ALIGN_BYTES      : 8,
        ASID_WIDTH            : 1,
        VMID_WIDTH            : 7,

        FpgaEn                : 1'b0,
        FpgaAlteraEn          : 1'b0,
        TechnoCut             : 1'b0,

        SuperscalarEn         : 1'b0,
        NrCommitPorts         : 1,
        NrIssuePorts          : 1,
        SpeculativeSb         : 1'b0,

        NrLoadPipeRegs        : 2,
        NrStorePipeRegs       : 2,

        AxiAddrWidth          : 64,
        AxiDataWidth          : 64,
        AxiIdWidth            : 4,
        AxiUserWidth          : 1,
        MEM_TID_WIDTH         : 4,
        NrLoadBufEntries      : 8,

        RVF                   : 1'b1,
        RVD                   : 1'b1,
        XF16                  : 1'b0,
        XF16ALT               : 1'b0,
        XF8                   : 1'b0,
        RVA                   : 1'b1,
        RVB                   : 1'b0,
        ZKN                   : 1'b0,
        RVV                   : 1'b0,
        RVC                   : 1'b1,
        RVH                   : 1'b0,
        RVZCB                 : 1'b0,
        RVZCMP                : 1'b0,
        RVZCMT                : 1'b0,
        XFVec                 : 1'b0,
        CvxifEn               : 1'b0,
        CoproType             : config_pkg::COPRO_NONE,
        RVZiCond              : 1'b0,
        RVZicntr              : 1'b0,
        RVZihpm               : 1'b0,

        NR_SB_ENTRIES         : 8,
        TRANS_ID_BITS         : 3,

        FpPresent             : 1'b1,
        NSX                   : 1'b0,
        FLen                  : 64,
        RVFVec                : 1'b0,
        XF16Vec               : 1'b0,
        XF16ALTVec            : 1'b0,
        XF8Vec                : 1'b0,

        NrRgprPorts           : 2,
        NrWbPorts             : 1,

        EnableAccelerator     : 1'b0,
        PerfCounterEn         : 1'b1,
        MmuPresent            : 1'b1,
        RVS                   : 1'b1,
        RVU                   : 1'b1,
        SoftwareInterruptEn   : 1'b1,

        HaltAddress           : 64'h80000000,
        ExceptionAddress      : 64'h80000000,

        RASDepth              : 2,
        BTBEntries            : 64,
        BPType                : config_pkg::BHT,
        BHTEntries            : 128,
        BHTHist               : 8,

        InstrTlbEntries       : 16,
        DataTlbEntries        : 16,
        UseSharedTlb          : 1'b0,
        SharedTlbDepth        : 0,
        VpnLen                : 39,
        PtLevels              : 3,

        DmBaseAddress         : 64'h0,
        TvalEn                : 1'b1,
        DirectVecOnly         : 1'b0,

        NrPMPEntries          : 8,

        PMPCfgRstVal          : '0,
        PMPAddrRstVal         : '0,
        PMPEntryReadOnly      : '0,
        PMPNapotEn            : 1'b1,

        NOCType               : config_pkg::NOC_TYPE_AXI4_ATOP,
        NrNonIdempotentRules  : 0,
        NonIdempotentAddrBase : '0,
        NonIdempotentLength   : '0,
        NrExecuteRegionRules  : 0,
        ExecuteRegionAddrBase : '0,
        ExecuteRegionLength   : '0,
        NrCachedRegionRules   : 0,
        CachedRegionAddrBase  : '0,
        CachedRegionLength    : '0,
        MaxOutstandingStores  : 8,
        DebugEn               : 1'b1,
        NonIdemPotenceEn      : 1'b0,
        AxiBurstWriteEn       : 1'b1,

        ICACHE_SET_ASSOC          : 4,
        ICACHE_SET_ASSOC_WIDTH    : 2,
        ICACHE_INDEX_WIDTH        : 12,

        ICACHE_TAG_WIDTH          : 44,
        ICACHE_LINE_WIDTH         : 128,
        ICACHE_USER_LINE_WIDTH    : 0,

        DCacheType                : config_pkg::WT,
        DcacheIdWidth             : 4,
        DCACHE_SET_ASSOC          : 8,
        DCACHE_SET_ASSOC_WIDTH    : 3,
        DCACHE_INDEX_WIDTH        : 12,
        DCACHE_TAG_WIDTH          : 44,
        DCACHE_LINE_WIDTH         : 128,
        DCACHE_USER_LINE_WIDTH    : 0,
        DCACHE_USER_WIDTH         : 0,
        DCACHE_OFFSET_WIDTH       : 6,
        DCACHE_NUM_WORDS          : 8,

        DCACHE_MAX_TX             : 2,

        DcacheFlushOnFence        : 1'b1,
        DcacheInvalidateOnFlush   : 1'b1,

        DATA_USER_EN          : 1'b0,
        WtDcacheWbufDepth     : 4,
        FETCH_USER_WIDTH      : 0,
        FETCH_USER_EN         : 1'b0,
        AXI_USER_EN           : 1'b0,

        FETCH_WIDTH           : 32,
        FETCH_ALIGN_BITS      : 3,
        INSTR_PER_FETCH       : 2,
        LOG2_INSTR_PER_FETCH  : 1,

        ModeW                 : 2,
        ASIDW                 : 1,
        VMIDW                 : 7,
        PPNW                  : 44,
        GPPNW                 : 44,
        MODE_SV               : config_pkg::ModeOff,
        SV                    : 1,
        SVX                   : 0,

        X_NUM_RS              : 32,
        X_ID_WIDTH            : 5,
        X_RFR_WIDTH           : 5,
        X_RFW_WIDTH           : 5,
        X_NUM_HARTS           : 1,
        X_HARTID_WIDTH        : 0,
        X_DUALREAD            : 1,
        X_DUALWRITE           : 0,
        X_ISSUE_REGISTER_SPLIT : 0
    },
    parameter type exception_t = struct packed {
      logic [CVA6Cfg.XLEN-1:0] cause;
      logic [CVA6Cfg.XLEN-1:0] tval;
      logic valid;
    },
    parameter type fu_data_t = struct packed {
      fu_t                              fu;
      fu_op                             operation;
      logic [CVA6Cfg.XLEN-1:0]          operand_a;
      logic [CVA6Cfg.XLEN-1:0]          operand_b;
      logic [CVA6Cfg.XLEN-1:0]          imm;
      logic [CVA6Cfg.TRANS_ID_BITS-1:0] trans_id;
    }
) (
    input  logic     clk_i,
    input  logic     rst_ni,
    input  logic     flush_i,
    input  logic     fpu_valid_i,
    output logic     fpu_ready_o,
    input  fu_data_t fu_data_i,

    input  logic       [                      1:0] fpu_fmt_i,
    input  logic       [                      2:0] fpu_rm_i,
    input  logic       [                      2:0] fpu_frm_i,
    input  logic       [                      6:0] fpu_prec_i,
    output logic       [CVA6Cfg.TRANS_ID_BITS-1:0] fpu_trans_id_o,
    output logic       [         CVA6Cfg.FLen-1:0] result_o,
    output logic                                   fpu_valid_o,
    output exception_t                             fpu_exception_o
);

  enum logic {
    READY,
    STALL
  }
      state_q, state_d;
  if (CVA6Cfg.FpPresent) begin : fpu_gen
    logic [CVA6Cfg.FLen-1:0] operand_a_i;
    logic [CVA6Cfg.FLen-1:0] operand_b_i;
    logic [CVA6Cfg.FLen-1:0] operand_c_i;
    assign operand_a_i = fu_data_i.operand_a[CVA6Cfg.FLen-1:0];
    assign operand_b_i = fu_data_i.operand_b[CVA6Cfg.FLen-1:0];
    assign operand_c_i = fu_data_i.imm[CVA6Cfg.FLen-1:0];

    localparam OPBITS = fpnew_pkg::OP_BITS;
    localparam FMTBITS = $clog2(fpnew_pkg::NUM_FP_FORMATS);
    localparam IFMTBITS = $clog2(fpnew_pkg::NUM_INT_FORMATS);

    localparam fpnew_pkg::fpu_features_t FPU_FEATURES = '{
        Width: unsigned'(CVA6Cfg.FLen),
        EnableVectors: CVA6Cfg.XFVec,
        EnableNanBox: 1'b1,
        FpFmtMask: {CVA6Cfg.RVF, CVA6Cfg.RVD, CVA6Cfg.XF16, CVA6Cfg.XF8, CVA6Cfg.XF16ALT},
        IntFmtMask: {
          CVA6Cfg.XFVec && CVA6Cfg.XF8,
          CVA6Cfg.XFVec && (CVA6Cfg.XF16 || CVA6Cfg.XF16ALT),
          1'b1,
          1'b1
        }
    };

    localparam fpnew_pkg::fpu_implementation_t FPU_IMPLEMENTATION = '{
        PipeRegs: '{
            '{
                unsigned'(LAT_COMP_FP32),
                unsigned'(LAT_COMP_FP64),
                unsigned'(LAT_COMP_FP16),
                unsigned'(LAT_COMP_FP8),
                unsigned'(LAT_COMP_FP16ALT)
            },
            '{default: unsigned'(LAT_DIVSQRT)},
            '{default: unsigned'(LAT_NONCOMP)},
            '{default: unsigned'(LAT_CONV)}
        },
        UnitTypes: '{
            '{default: fpnew_pkg::PARALLEL},
            '{default: fpnew_pkg::MERGED},
            '{default: fpnew_pkg::PARALLEL},
            '{default: fpnew_pkg::MERGED}
        },
        PipeConfig: fpnew_pkg::DISTRIBUTED
    };

    logic [CVA6Cfg.FLen-1:0] operand_a_d, operand_a_q, operand_a;
    logic [CVA6Cfg.FLen-1:0] operand_b_d, operand_b_q, operand_b;
    logic [CVA6Cfg.FLen-1:0] operand_c_d, operand_c_q, operand_c;
    logic [OPBITS-1:0] fpu_op_d, fpu_op_q, fpu_op;
    logic fpu_op_mod_d, fpu_op_mod_q, fpu_op_mod;
    logic [FMTBITS-1:0] fpu_srcfmt_d, fpu_srcfmt_q, fpu_srcfmt;
    logic [FMTBITS-1:0] fpu_dstfmt_d, fpu_dstfmt_q, fpu_dstfmt;
    logic [IFMTBITS-1:0] fpu_ifmt_d, fpu_ifmt_q, fpu_ifmt;
    logic [2:0] fpu_rm_d, fpu_rm_q, fpu_rm;
    logic fpu_vec_op_d, fpu_vec_op_q, fpu_vec_op;

    logic [CVA6Cfg.TRANS_ID_BITS-1:0] fpu_tag_d, fpu_tag_q, fpu_tag;

    logic fpu_in_ready, fpu_in_valid;
    logic fpu_out_ready, fpu_out_valid;

    logic [4:0] fpu_status;

    logic hold_inputs;
    logic use_hold;

    always_comb begin : input_translation

      automatic logic vec_replication;
      automatic logic replicate_c;
      automatic logic check_ah;

      operand_a_d     = operand_a_i;
      operand_b_d     = operand_b_i;
      operand_c_d     = operand_c_i;
      fpu_op_d        = fpnew_pkg::SGNJ;
      fpu_op_mod_d    = 1'b0;
      fpu_dstfmt_d    = fpnew_pkg::FP32;
      fpu_ifmt_d      = fpnew_pkg::INT32;
      fpu_rm_d        = fpu_rm_i;
      fpu_vec_op_d    = fu_data_i.fu == FPU_VEC;
      fpu_tag_d       = fu_data_i.trans_id;
      vec_replication = fpu_rm_i[0];
      replicate_c     = 1'b0;
      check_ah        = 1'b0;

      if (!(fpu_rm_i inside {[3'b000 : 3'b100]})) fpu_rm_d = fpu_frm_i;

      if (fpu_vec_op_d) fpu_rm_d = fpu_frm_i;

      unique case (fpu_fmt_i)

        2'b00: fpu_dstfmt_d = fpnew_pkg::FP32;

        2'b01: fpu_dstfmt_d = fpu_vec_op_d ? fpnew_pkg::FP16ALT : fpnew_pkg::FP64;

        2'b10: begin
          if (!fpu_vec_op_d && fpu_rm_i == 3'b101) fpu_dstfmt_d = fpnew_pkg::FP16ALT;
          else fpu_dstfmt_d = fpnew_pkg::FP16;
        end

        default: fpu_dstfmt_d = fpnew_pkg::FP8;
      endcase

      fpu_srcfmt_d = fpu_dstfmt_d;

      unique case (fu_data_i.operation)

        FADD: begin
          fpu_op_d    = fpnew_pkg::ADD;
          replicate_c = 1'b1;
        end

        FSUB: begin
          fpu_op_d     = fpnew_pkg::ADD;
          fpu_op_mod_d = 1'b1;
          replicate_c  = 1'b1;
        end

        FMUL: fpu_op_d = fpnew_pkg::MUL;

        FDIV: fpu_op_d = fpnew_pkg::DIV;

        FMIN_MAX: begin
          fpu_op_d = fpnew_pkg::MINMAX;
          fpu_rm_d = {1'b0, fpu_rm_i[1:0]};
          check_ah = 1'b1;
        end

        FSQRT: fpu_op_d = fpnew_pkg::SQRT;

        FMADD: fpu_op_d = fpnew_pkg::FMADD;

        FMSUB: begin
          fpu_op_d     = fpnew_pkg::FMADD;
          fpu_op_mod_d = 1'b1;
        end

        FNMSUB: fpu_op_d = fpnew_pkg::FNMSUB;

        FNMADD: begin
          fpu_op_d     = fpnew_pkg::FNMSUB;
          fpu_op_mod_d = 1'b1;
        end

        FCVT_F2I: begin
          fpu_op_d = fpnew_pkg::F2I;

          if (fpu_vec_op_d) begin
            fpu_op_mod_d    = fpu_rm_i[0];
            vec_replication = 1'b0;
            unique case (fpu_fmt_i)
              2'b00: fpu_ifmt_d = fpnew_pkg::INT32;
              2'b01, 2'b10: fpu_ifmt_d = fpnew_pkg::INT16;
              2'b11: fpu_ifmt_d = fpnew_pkg::INT8;
            endcase

          end else begin
            fpu_op_mod_d = operand_c_i[0];
            if (operand_c_i[1]) fpu_ifmt_d = fpnew_pkg::INT64;
            else fpu_ifmt_d = fpnew_pkg::INT32;
          end
        end

        FCVT_I2F: begin
          fpu_op_d = fpnew_pkg::I2F;

          if (fpu_vec_op_d) begin
            fpu_op_mod_d    = fpu_rm_i[0];
            vec_replication = 1'b0;
            unique case (fpu_fmt_i)
              2'b00: fpu_ifmt_d = fpnew_pkg::INT32;
              2'b01, 2'b10: fpu_ifmt_d = fpnew_pkg::INT16;
              2'b11: fpu_ifmt_d = fpnew_pkg::INT8;
            endcase

          end else begin
            fpu_op_mod_d = operand_c_i[0];
            if (operand_c_i[1]) fpu_ifmt_d = fpnew_pkg::INT64;
            else fpu_ifmt_d = fpnew_pkg::INT32;
          end
        end

        FCVT_F2F: begin
          fpu_op_d = fpnew_pkg::F2F;

          if (fpu_vec_op_d) begin
            vec_replication = 1'b0;
            unique case (operand_c_i[1:0])
              2'b00: fpu_srcfmt_d = fpnew_pkg::FP32;
              2'b01: fpu_srcfmt_d = fpnew_pkg::FP16ALT;
              2'b10: fpu_srcfmt_d = fpnew_pkg::FP16;
              2'b11: fpu_srcfmt_d = fpnew_pkg::FP8;
            endcase

          end else begin
            unique case (operand_c_i[2:0])
              3'b000:  fpu_srcfmt_d = fpnew_pkg::FP32;
              3'b001:  fpu_srcfmt_d = fpnew_pkg::FP64;
              3'b010:  fpu_srcfmt_d = fpnew_pkg::FP16;
              3'b110:  fpu_srcfmt_d = fpnew_pkg::FP16ALT;
              3'b011:  fpu_srcfmt_d = fpnew_pkg::FP8;
              default: ;
            endcase
          end
        end

        FSGNJ: begin
          fpu_op_d = fpnew_pkg::SGNJ;
          fpu_rm_d = {1'b0, fpu_rm_i[1:0]};
          check_ah = 1'b1;
        end

        FMV_F2X: begin
          fpu_op_d        = fpnew_pkg::SGNJ;
          fpu_rm_d        = 3'b011;
          fpu_op_mod_d    = 1'b1;
          check_ah        = 1'b1;
          vec_replication = 1'b0;
        end

        FMV_X2F: begin
          fpu_op_d        = fpnew_pkg::SGNJ;
          fpu_rm_d        = 3'b011;
          check_ah        = 1'b1;
          vec_replication = 1'b0;
        end

        FCMP: begin
          fpu_op_d = fpnew_pkg::CMP;
          fpu_rm_d = {1'b0, fpu_rm_i[1:0]};
          check_ah = 1'b1;
        end

        FCLASS: begin
          fpu_op_d = fpnew_pkg::CLASSIFY;
          fpu_rm_d = {1'b0, fpu_rm_i[1:0]};
          check_ah = 1'b1;
        end

        VFMIN: begin
          fpu_op_d = fpnew_pkg::MINMAX;
          fpu_rm_d = 3'b000;
        end

        VFMAX: begin
          fpu_op_d = fpnew_pkg::MINMAX;
          fpu_rm_d = 3'b001;
        end

        VFSGNJ: begin
          fpu_op_d = fpnew_pkg::SGNJ;
          fpu_rm_d = 3'b000;
        end

        VFSGNJN: begin
          fpu_op_d = fpnew_pkg::SGNJ;
          fpu_rm_d = 3'b001;
        end

        VFSGNJX: begin
          fpu_op_d = fpnew_pkg::SGNJ;
          fpu_rm_d = 3'b010;
        end

        VFEQ: begin
          fpu_op_d = fpnew_pkg::CMP;
          fpu_rm_d = 3'b010;
        end

        VFNE: begin
          fpu_op_d     = fpnew_pkg::CMP;
          fpu_op_mod_d = 1'b1;
          fpu_rm_d     = 3'b010;
        end

        VFLT: begin
          fpu_op_d = fpnew_pkg::CMP;
          fpu_rm_d = 3'b001;
        end

        VFGE: begin
          fpu_op_d     = fpnew_pkg::CMP;
          fpu_op_mod_d = 1'b1;
          fpu_rm_d     = 3'b001;
        end

        VFLE: begin
          fpu_op_d = fpnew_pkg::CMP;
          fpu_rm_d = 3'b000;
        end

        VFGT: begin
          fpu_op_d     = fpnew_pkg::CMP;
          fpu_op_mod_d = 1'b1;
          fpu_rm_d     = 3'b000;
        end

        VFCPKAB_S: begin
          fpu_op_d        = fpnew_pkg::CPKAB;
          fpu_op_mod_d    = fpu_rm_i[0];
          vec_replication = 1'b0;
          fpu_srcfmt_d    = fpnew_pkg::FP32;
        end

        VFCPKCD_S: begin
          fpu_op_d        = fpnew_pkg::CPKCD;
          fpu_op_mod_d    = fpu_rm_i[0];
          vec_replication = 1'b0;
          fpu_srcfmt_d    = fpnew_pkg::FP32;
        end

        VFCPKAB_D: begin
          fpu_op_d        = fpnew_pkg::CPKAB;
          fpu_op_mod_d    = fpu_rm_i[0];
          vec_replication = 1'b0;
          fpu_srcfmt_d    = fpnew_pkg::FP64;
        end

        VFCPKCD_D: begin
          fpu_op_d        = fpnew_pkg::CPKCD;
          fpu_op_mod_d    = fpu_rm_i[0];
          vec_replication = 1'b0;
          fpu_srcfmt_d    = fpnew_pkg::FP64;
        end

        default: ;
      endcase

      if (!fpu_vec_op_d && check_ah) if (fpu_rm_i[2]) fpu_dstfmt_d = fpnew_pkg::FP16ALT;

      if (fpu_vec_op_d && vec_replication) begin
        if (replicate_c) begin
          unique case (fpu_dstfmt_d)
            fpnew_pkg::FP32: operand_c_d = CVA6Cfg.RVD ? {2{operand_c_i[31:0]}} : operand_c_i;
            fpnew_pkg::FP16, fpnew_pkg::FP16ALT:
            operand_c_d = CVA6Cfg.RVD ? {4{operand_c_i[15:0]}} : {2{operand_c_i[15:0]}};
            fpnew_pkg::FP8:
            operand_c_d = CVA6Cfg.RVD ? {8{operand_c_i[7:0]}} : {4{operand_c_i[7:0]}};
            default: ;
          endcase
        end else begin
          unique case (fpu_dstfmt_d)
            fpnew_pkg::FP32: operand_b_d = CVA6Cfg.RVD ? {2{operand_b_i[31:0]}} : operand_b_i;
            fpnew_pkg::FP16, fpnew_pkg::FP16ALT:
            operand_b_d = CVA6Cfg.RVD ? {4{operand_b_i[15:0]}} : {2{operand_b_i[15:0]}};
            fpnew_pkg::FP8:
            operand_b_d = CVA6Cfg.RVD ? {8{operand_b_i[7:0]}} : {4{operand_b_i[7:0]}};
            default: ;
          endcase
        end
      end
    end

    always_comb begin : p_inputFSM

      fpu_ready_o  = 1'b0;
      fpu_in_valid = 1'b0;
      hold_inputs  = 1'b0;
      use_hold     = 1'b0;
      state_d      = state_q;

      unique case (state_q)

        READY: begin
          fpu_ready_o  = 1'b1;
          fpu_in_valid = fpu_valid_i;

          if (fpu_valid_i & ~fpu_in_ready) begin
            fpu_ready_o = 1'b0;
            hold_inputs = 1'b1;
            state_d     = STALL;
          end
        end

        STALL: begin
          fpu_in_valid = 1'b1;
          use_hold     = 1'b1;

          if (fpu_in_ready) begin
            fpu_ready_o = 1'b1;
            state_d     = READY;
          end
        end

        default: ;
      endcase

      if (flush_i) begin
        state_d = READY;
      end

    end

    always_ff @(posedge clk_i or negedge rst_ni) begin : fp_hold_reg
      if (~rst_ni) begin
        state_q      <= READY;
        operand_a_q  <= '0;
        operand_b_q  <= '0;
        operand_c_q  <= '0;
        fpu_op_q     <= '0;
        fpu_op_mod_q <= '0;
        fpu_srcfmt_q <= '0;
        fpu_dstfmt_q <= '0;
        fpu_ifmt_q   <= '0;
        fpu_rm_q     <= '0;
        fpu_vec_op_q <= '0;
        fpu_tag_q    <= '0;
      end else begin
        state_q <= state_d;

        if (hold_inputs) begin
          operand_a_q  <= operand_a_d;
          operand_b_q  <= operand_b_d;
          operand_c_q  <= operand_c_d;
          fpu_op_q     <= fpu_op_d;
          fpu_op_mod_q <= fpu_op_mod_d;
          fpu_srcfmt_q <= fpu_srcfmt_d;
          fpu_dstfmt_q <= fpu_dstfmt_d;
          fpu_ifmt_q   <= fpu_ifmt_d;
          fpu_rm_q     <= fpu_rm_d;
          fpu_vec_op_q <= fpu_vec_op_d;
          fpu_tag_q    <= fpu_tag_d;
        end
      end
    end

    assign operand_a  = use_hold ? operand_a_q : operand_a_d;
    assign operand_b  = use_hold ? operand_b_q : operand_b_d;
    assign operand_c  = use_hold ? operand_c_q : operand_c_d;
    assign fpu_op     = use_hold ? fpu_op_q : fpu_op_d;
    assign fpu_op_mod = use_hold ? fpu_op_mod_q : fpu_op_mod_d;
    assign fpu_srcfmt = use_hold ? fpu_srcfmt_q : fpu_srcfmt_d;
    assign fpu_dstfmt = use_hold ? fpu_dstfmt_q : fpu_dstfmt_d;
    assign fpu_ifmt   = use_hold ? fpu_ifmt_q : fpu_ifmt_d;
    assign fpu_rm     = use_hold ? fpu_rm_q : fpu_rm_d;
    assign fpu_vec_op = use_hold ? fpu_vec_op_q : fpu_vec_op_d;
    assign fpu_tag    = use_hold ? fpu_tag_q : fpu_tag_d;

    logic [2:0][CVA6Cfg.FLen-1:0] fpu_operands;

    assign fpu_operands[0] = operand_a;
    assign fpu_operands[1] = operand_b;
    assign fpu_operands[2] = operand_c;

    fpnew_top #(
        .Features      (FPU_FEATURES),
        .Implementation(FPU_IMPLEMENTATION),
        .TagType       (logic [CVA6Cfg.TRANS_ID_BITS-1:0])
    ) i_fpnew_bulk (
        .clk_i,
        .rst_ni,
        .operands_i    (fpu_operands),
        .rnd_mode_i    (fpnew_pkg::roundmode_e'(fpu_rm)),
        .op_i          (fpnew_pkg::operation_e'(fpu_op)),
        .op_mod_i      (fpu_op_mod),
        .src_fmt_i     (fpnew_pkg::fp_format_e'(fpu_srcfmt)),
        .dst_fmt_i     (fpnew_pkg::fp_format_e'(fpu_dstfmt)),
        .int_fmt_i     (fpnew_pkg::int_format_e'(fpu_ifmt)),
        .vectorial_op_i(fpu_vec_op),
        .tag_i         (fpu_tag),
        .simd_mask_i   (1'b1),
        .in_valid_i    (fpu_in_valid),
        .in_ready_o    (fpu_in_ready),
        .flush_i,
        .result_o,
        .status_o      (fpu_status),
        .tag_o         (fpu_trans_id_o),
        .out_valid_o   (fpu_out_valid),
        .out_ready_i   (fpu_out_ready),
        .busy_o        ()
    );

    assign fpu_exception_o.cause = {59'h0, fpu_status};
    assign fpu_exception_o.valid = 1'b0;
    assign fpu_exception_o.tval = '0;

    assign fpu_out_ready = 1'b1;

    assign fpu_valid_o = fpu_out_valid;

  end
endmodule


import ariane_pkg::*;
module tlb #(
    parameter int unsigned TLB_ENTRIES = 4,
    parameter int unsigned ASID_WIDTH  = 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    input tlb_update_t update_i,

    input  logic                             lu_access_i,
    input  logic            [ASID_WIDTH-1:0] lu_asid_i,
    input  logic            [          63:0] lu_vaddr_i,
    output riscv_pkg::pte_t                  lu_content_o,
    output logic                             lu_is_2M_o,
    output logic                             lu_is_1G_o,
    output logic                             lu_hit_o
);

  struct packed {
    logic [ASID_WIDTH-1:0] asid;
    logic [8:0]            vpn2;
    logic [8:0]            vpn1;
    logic [8:0]            vpn0;
    logic                  is_2M;
    logic                  is_1G;
    logic                  valid;
  } [TLB_ENTRIES-1:0]
      tags_q, tags_n;

  riscv_pkg::pte_t [TLB_ENTRIES-1:0] content_q, content_n;
  logic [8:0] vpn0, vpn1, vpn2;
  logic [TLB_ENTRIES-1:0] lu_hit;
  logic [TLB_ENTRIES-1:0] replace_en;

  always_comb begin : translation
    vpn0         = lu_vaddr_i[20:12];
    vpn1         = lu_vaddr_i[29:21];
    vpn2         = lu_vaddr_i[38:30];

    lu_hit       = '{default: 0};
    lu_hit_o     = 1'b0;
    lu_content_o = '{default: 0};
    lu_is_1G_o   = 1'b0;
    lu_is_2M_o   = 1'b0;

    for (int unsigned i = 0; i < TLB_ENTRIES; i++) begin

      if (tags_q[i].valid && lu_asid_i == tags_q[i].asid && vpn2 == tags_q[i].vpn2) begin

        if (tags_q[i].is_1G) begin
          lu_is_1G_o = 1'b1;
          lu_content_o = content_q[i];
          lu_hit_o = 1'b1;
          lu_hit[i] = 1'b1;

        end else if (vpn1 == tags_q[i].vpn1) begin

          if (tags_q[i].is_2M || vpn0 == tags_q[i].vpn0) begin
            lu_is_2M_o   = tags_q[i].is_2M;
            lu_content_o = content_q[i];
            lu_hit_o     = 1'b1;
            lu_hit[i]    = 1'b1;
          end
        end
      end
    end
  end

  always_comb begin : update_flush
    tags_n    = tags_q;
    content_n = content_q;

    for (int unsigned i = 0; i < TLB_ENTRIES; i++) begin
      if (flush_i) begin

        if (lu_asid_i == 1'b0) tags_n[i].valid = 1'b0;
        else if (lu_asid_i == tags_q[i].asid) tags_n[i].valid = 1'b0;

      end else if (update_i.valid & replace_en[i]) begin

        tags_n[i] = '{
            asid: update_i.asid,
            vpn2: update_i.vpn[26:18],
            vpn1: update_i.vpn[17:9],
            vpn0: update_i.vpn[8:0],
            is_1G: update_i.is_1G,
            is_2M: update_i.is_2M,
            valid: 1'b1
        };

        content_n[i] = update_i.content;
      end
    end
  end

  logic [2*(TLB_ENTRIES-1)-1:0] plru_tree_q, plru_tree_n;
  always_comb begin : plru_replacement
    plru_tree_n = plru_tree_q;

    for (int unsigned i = 0; i < TLB_ENTRIES; i++) begin
      automatic int unsigned idx_base, shift, new_index;

      if (lu_hit[i] & lu_access_i) begin

        for (int unsigned lvl = 0; lvl < $clog2(TLB_ENTRIES); lvl++) begin
          idx_base = $unsigned((2 ** lvl) - 1);

          shift = $clog2(TLB_ENTRIES) - lvl;

          new_index = ~((i >> (shift - 1)) & 32'b1);
          plru_tree_n[idx_base+(i>>shift)] = new_index[0];
        end
      end
    end

    for (int unsigned i = 0; i < TLB_ENTRIES; i += 1) begin
      automatic logic en;
      automatic int unsigned idx_base, shift, new_index;
      en = 1'b1;
      for (int unsigned lvl = 0; lvl < $clog2(TLB_ENTRIES); lvl++) begin
        idx_base = $unsigned((2 ** lvl) - 1);

        shift = $clog2(TLB_ENTRIES) - lvl;

        new_index = (i >> (shift - 1)) & 32'b1;
        if (new_index[0]) begin
          en &= plru_tree_q[idx_base+(i>>shift)];
        end else begin
          en &= ~plru_tree_q[idx_base+(i>>shift)];
        end
      end
      replace_en[i] = en;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      tags_q      <= '{default: 0};
      content_q   <= '{default: 0};
      plru_tree_q <= '{default: 0};
    end else begin
      tags_q      <= tags_n;
      content_q   <= content_n;
      plru_tree_q <= plru_tree_n;
    end
  end

endmodule


import ariane_pkg::*;
module ptw #(
    parameter int ASID_WIDTH = 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    output logic ptw_active_o,
    output logic walking_instr_o,
    output logic ptw_error_o,
    input  logic enable_translation_i,
    input  logic en_ld_st_translation_i,

    input logic lsu_is_store_i,

    input  dcache_req_o_t req_port_i,
    output dcache_req_i_t req_port_o,

    output tlb_update_t itlb_update_o,
    output tlb_update_t dtlb_update_o,

    output logic [38:0] update_vaddr_o,

    input logic [ASID_WIDTH-1:0] asid_i,

    input logic        itlb_access_i,
    input logic        itlb_hit_i,
    input logic [63:0] itlb_vaddr_i,

    input logic        dtlb_access_i,
    input logic        dtlb_hit_i,
    input logic [63:0] dtlb_vaddr_i,

    input logic [43:0] satp_ppn_i,
    input logic        mxr_i,

    output logic itlb_miss_o,
    output logic dtlb_miss_o

);

  logic data_rvalid_q;
  logic [63:0] data_rdata_q;

  riscv_pkg::pte_t pte;
  assign pte = riscv_pkg::pte_t'(data_rdata_q);

  enum logic [2:0] {
    IDLE,
    WAIT_GRANT,
    PTE_LOOKUP,
    WAIT_RVALID,
    PROPAGATE_ERROR
  }
      state_q, state_d;

  enum logic [1:0] {
    LVL1,
    LVL2,
    LVL3
  }
      ptw_lvl_q, ptw_lvl_n;

  logic is_instr_ptw_q, is_instr_ptw_n;
  logic global_mapping_q, global_mapping_n;

  logic tag_valid_n, tag_valid_q;

  logic [ASID_WIDTH-1:0] tlb_update_asid_q, tlb_update_asid_n;

  logic [63:0] vaddr_q, vaddr_n;

  logic [55:0] ptw_pptr_q, ptw_pptr_n;

  assign update_vaddr_o = vaddr_q;

  assign ptw_active_o = (state_q != IDLE);
  assign walking_instr_o = is_instr_ptw_q;

  assign req_port_o.address_index = ptw_pptr_q[DCACHE_INDEX_WIDTH-1:0];
  assign req_port_o.address_tag   = ptw_pptr_q[DCACHE_INDEX_WIDTH+DCACHE_TAG_WIDTH-1:DCACHE_INDEX_WIDTH];

  assign req_port_o.kill_req = '0;

  assign req_port_o.data_wdata = 64'b0;

  assign itlb_update_o.vpn = vaddr_q[38:12];
  assign dtlb_update_o.vpn = vaddr_q[38:12];

  assign itlb_update_o.is_2M = (ptw_lvl_q == LVL2);
  assign itlb_update_o.is_1G = (ptw_lvl_q == LVL1);
  assign dtlb_update_o.is_2M = (ptw_lvl_q == LVL2);
  assign dtlb_update_o.is_1G = (ptw_lvl_q == LVL1);

  assign itlb_update_o.asid = tlb_update_asid_q;
  assign dtlb_update_o.asid = tlb_update_asid_q;

  assign itlb_update_o.content = pte | (global_mapping_q << 5);
  assign dtlb_update_o.content = pte | (global_mapping_q << 5);

  assign req_port_o.tag_valid = tag_valid_q;

  always_comb begin : ptw

    tag_valid_n          = 1'b0;
    req_port_o.data_req  = 1'b0;
    req_port_o.data_be   = 8'hFF;
    req_port_o.data_size = 2'b11;
    req_port_o.data_we   = 1'b0;
    ptw_error_o          = 1'b0;
    itlb_update_o.valid  = 1'b0;
    dtlb_update_o.valid  = 1'b0;
    is_instr_ptw_n       = is_instr_ptw_q;
    ptw_lvl_n            = ptw_lvl_q;
    ptw_pptr_n           = ptw_pptr_q;
    state_d              = state_q;
    global_mapping_n     = global_mapping_q;

    tlb_update_asid_n    = tlb_update_asid_q;
    vaddr_n              = vaddr_q;

    itlb_miss_o          = 1'b0;
    dtlb_miss_o          = 1'b0;

    case (state_q)

      IDLE: begin

        ptw_lvl_n        = LVL1;
        global_mapping_n = 1'b0;
        is_instr_ptw_n   = 1'b0;

        if (enable_translation_i & itlb_access_i & ~itlb_hit_i & ~dtlb_access_i) begin
          ptw_pptr_n        = {satp_ppn_i, itlb_vaddr_i[38:30], 3'b0};
          is_instr_ptw_n    = 1'b1;
          tlb_update_asid_n = asid_i;
          vaddr_n           = itlb_vaddr_i;
          state_d           = WAIT_GRANT;
          itlb_miss_o       = 1'b1;

        end else if (en_ld_st_translation_i & dtlb_access_i & ~dtlb_hit_i) begin
          ptw_pptr_n        = {satp_ppn_i, dtlb_vaddr_i[38:30], 3'b0};
          tlb_update_asid_n = asid_i;
          vaddr_n           = dtlb_vaddr_i;
          state_d           = WAIT_GRANT;
          dtlb_miss_o       = 1'b1;
        end
      end

      WAIT_GRANT: begin

        req_port_o.data_req = 1'b1;

        if (req_port_i.data_gnt) begin

          tag_valid_n = 1'b1;
          state_d     = PTE_LOOKUP;
        end
      end

      PTE_LOOKUP: begin

        if (data_rvalid_q) begin

          if (pte.g) global_mapping_n = 1'b1;

          if (!pte.v || (!pte.r && pte.w)) state_d = PROPAGATE_ERROR;

          else begin
            state_d = IDLE;

            if (pte.r || pte.x) begin

              if (is_instr_ptw_q) begin

                if (!pte.x || !pte.a) state_d = PROPAGATE_ERROR;
                else itlb_update_o.valid = 1'b1;

              end else begin

                if (pte.a && (pte.r || (pte.x && mxr_i))) begin
                  dtlb_update_o.valid = 1'b1;
                end else begin
                  state_d = PROPAGATE_ERROR;
                end

                if (lsu_is_store_i && (!pte.w || !pte.d)) begin
                  dtlb_update_o.valid = 1'b0;
                  state_d = PROPAGATE_ERROR;
                end
              end

              if (ptw_lvl_q == LVL1 && pte.ppn[17:0] != '0) begin
                state_d             = PROPAGATE_ERROR;
                dtlb_update_o.valid = 1'b0;
                itlb_update_o.valid = 1'b0;
              end else if (ptw_lvl_q == LVL2 && pte.ppn[8:0] != '0) begin
                state_d             = PROPAGATE_ERROR;
                dtlb_update_o.valid = 1'b0;
                itlb_update_o.valid = 1'b0;
              end

            end else begin

              if (ptw_lvl_q == LVL1) begin

                ptw_lvl_n  = LVL2;
                ptw_pptr_n = {pte.ppn, vaddr_q[29:21], 3'b0};
              end

              if (ptw_lvl_q == LVL2) begin

                ptw_lvl_n  = LVL3;
                ptw_pptr_n = {pte.ppn, vaddr_q[20:12], 3'b0};
              end

              state_d = WAIT_GRANT;

              if (ptw_lvl_q == LVL3) begin

                ptw_lvl_n = LVL3;
                state_d   = PROPAGATE_ERROR;
              end
            end
          end
        end

      end

      PROPAGATE_ERROR: begin
        state_d     = IDLE;
        ptw_error_o = 1'b1;
      end

      WAIT_RVALID: begin
        if (data_rvalid_q) state_d = IDLE;
      end
      default: begin
        state_d = IDLE;
      end
    endcase

    if (flush_i) begin

      if ((state_q == PTE_LOOKUP && !data_rvalid_q) || ((state_q == WAIT_GRANT) && req_port_i.data_gnt))
        state_d = WAIT_RVALID;
      else state_d = IDLE;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      state_q           <= IDLE;
      is_instr_ptw_q    <= 1'b0;
      ptw_lvl_q         <= LVL1;
      tag_valid_q       <= 1'b0;
      tlb_update_asid_q <= '0;
      vaddr_q           <= '0;
      ptw_pptr_q        <= '0;
      global_mapping_q  <= 1'b0;
      data_rdata_q      <= '0;
      data_rvalid_q     <= 1'b0;
    end else begin
      state_q           <= state_d;
      ptw_pptr_q        <= ptw_pptr_n;
      is_instr_ptw_q    <= is_instr_ptw_n;
      ptw_lvl_q         <= ptw_lvl_n;
      tag_valid_q       <= tag_valid_n;
      tlb_update_asid_q <= tlb_update_asid_n;
      vaddr_q           <= vaddr_n;
      global_mapping_q  <= global_mapping_n;
      data_rdata_q      <= req_port_i.data_rdata;
      data_rvalid_q     <= req_port_i.data_rvalid;
    end
  end

endmodule


import ariane_pkg::*;
module mmu #(
    parameter int unsigned INSTR_TLB_ENTRIES = 4,
    parameter int unsigned DATA_TLB_ENTRIES  = 4,
    parameter int unsigned ASID_WIDTH        = 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic enable_translation_i,
    input logic en_ld_st_translation_i,

    input  icache_areq_o_t icache_areq_i,
    output icache_areq_i_t icache_areq_o,

    input exception_t        misaligned_ex_i,
    input logic              lsu_req_i,
    input logic       [63:0] lsu_vaddr_i,
    input logic              lsu_is_store_i,

    output logic lsu_dtlb_hit_o,

    output logic              lsu_valid_o,
    output logic       [63:0] lsu_paddr_o,
    output exception_t        lsu_exception_o,

    input riscv_pkg::priv_lvl_t priv_lvl_i,
    input riscv_pkg::priv_lvl_t ld_st_priv_lvl_i,
    input logic                 sum_i,
    input logic                 mxr_i,

    input logic [          43:0] satp_ppn_i,
    input logic [ASID_WIDTH-1:0] asid_i,
    input logic                  flush_tlb_i,

    output logic itlb_miss_o,
    output logic dtlb_miss_o,

    input  dcache_req_o_t req_port_i,
    output dcache_req_i_t req_port_o
);

  logic        iaccess_err;
  logic        daccess_err;
  logic        ptw_active;
  logic        walking_instr;
  logic        ptw_error;

  logic [38:0] update_vaddr;
  tlb_update_t update_ptw_itlb, update_ptw_dtlb;

  logic            itlb_lu_access;
  riscv_pkg::pte_t itlb_content;
  logic            itlb_is_2M;
  logic            itlb_is_1G;
  logic            itlb_lu_hit;

  logic            dtlb_lu_access;
  riscv_pkg::pte_t dtlb_content;
  logic            dtlb_is_2M;
  logic            dtlb_is_1G;
  logic            dtlb_lu_hit;

  assign itlb_lu_access = icache_areq_i.fetch_req;
  assign dtlb_lu_access = lsu_req_i;

  tlb #(
      .TLB_ENTRIES(INSTR_TLB_ENTRIES),
      .ASID_WIDTH (ASID_WIDTH)
  ) i_itlb (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      .flush_i(flush_tlb_i),

      .update_i(update_ptw_itlb),

      .lu_access_i (itlb_lu_access),
      .lu_asid_i   (asid_i),
      .lu_vaddr_i  (icache_areq_i.fetch_vaddr),
      .lu_content_o(itlb_content),

      .lu_is_2M_o(itlb_is_2M),
      .lu_is_1G_o(itlb_is_1G),
      .lu_hit_o  (itlb_lu_hit)
  );

  tlb #(
      .TLB_ENTRIES(DATA_TLB_ENTRIES),
      .ASID_WIDTH (ASID_WIDTH)
  ) i_dtlb (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      .flush_i(flush_tlb_i),

      .update_i(update_ptw_dtlb),

      .lu_access_i (dtlb_lu_access),
      .lu_asid_i   (asid_i),
      .lu_vaddr_i  (lsu_vaddr_i),
      .lu_content_o(dtlb_content),

      .lu_is_2M_o(dtlb_is_2M),
      .lu_is_1G_o(dtlb_is_1G),
      .lu_hit_o  (dtlb_lu_hit)
  );

  ptw #(
      .ASID_WIDTH(ASID_WIDTH)
  ) i_ptw (
      .clk_i               (clk_i),
      .rst_ni              (rst_ni),
      .ptw_active_o        (ptw_active),
      .walking_instr_o     (walking_instr),
      .ptw_error_o         (ptw_error),
      .enable_translation_i(enable_translation_i),

      .update_vaddr_o(update_vaddr),
      .itlb_update_o (update_ptw_itlb),
      .dtlb_update_o (update_ptw_dtlb),

      .itlb_access_i(itlb_lu_access),
      .itlb_hit_i   (itlb_lu_hit),
      .itlb_vaddr_i (icache_areq_i.fetch_vaddr),

      .dtlb_access_i(dtlb_lu_access),
      .dtlb_hit_i   (dtlb_lu_hit),
      .dtlb_vaddr_i (lsu_vaddr_i),

      .req_port_i(req_port_i),
      .req_port_o(req_port_o),

      .*
  );

  always_comb begin : instr_interface

    icache_areq_o.fetch_valid = icache_areq_i.fetch_req;
    icache_areq_o.fetch_paddr = icache_areq_i.fetch_vaddr;

    icache_areq_o.fetch_exception = '0;

    iaccess_err   = icache_areq_i.fetch_req && (((priv_lvl_i == riscv_pkg::PRIV_LVL_U) && ~itlb_content.u)
                                                 || ((priv_lvl_i == riscv_pkg::PRIV_LVL_S) && itlb_content.u));

    if (enable_translation_i) begin

      if (icache_areq_i.fetch_req && !((&icache_areq_i.fetch_vaddr[63:38]) == 1'b1 || (|icache_areq_i.fetch_vaddr[63:38]) == 1'b0)) begin
        icache_areq_o.fetch_exception = {
          riscv_pkg::INSTR_ACCESS_FAULT, icache_areq_i.fetch_vaddr, 1'b1
        };
      end

      icache_areq_o.fetch_valid = 1'b0;

      icache_areq_o.fetch_paddr = {itlb_content.ppn, icache_areq_i.fetch_vaddr[11:0]};

      if (itlb_is_2M) begin
        icache_areq_o.fetch_paddr[20:12] = icache_areq_i.fetch_vaddr[20:12];
      end

      if (itlb_is_1G) begin
        icache_areq_o.fetch_paddr[29:12] = icache_areq_i.fetch_vaddr[29:12];
      end

      if (itlb_lu_hit) begin
        icache_areq_o.fetch_valid = icache_areq_i.fetch_req;

        if (iaccess_err) begin

          icache_areq_o.fetch_exception = {
            riscv_pkg::INSTR_PAGE_FAULT, icache_areq_i.fetch_vaddr, 1'b1
          };
        end
      end else if (ptw_active && walking_instr) begin
        icache_areq_o.fetch_valid = ptw_error;
        icache_areq_o.fetch_exception = {riscv_pkg::INSTR_PAGE_FAULT, {25'b0, update_vaddr}, 1'b1};
      end
    end
  end

  logic [63:0] lsu_vaddr_n, lsu_vaddr_q;
  riscv_pkg::pte_t dtlb_pte_n, dtlb_pte_q;
  exception_t misaligned_ex_n, misaligned_ex_q;
  logic lsu_req_n, lsu_req_q;
  logic lsu_is_store_n, lsu_is_store_q;
  logic dtlb_hit_n, dtlb_hit_q;
  logic dtlb_is_2M_n, dtlb_is_2M_q;
  logic dtlb_is_1G_n, dtlb_is_1G_q;

  assign lsu_dtlb_hit_o = (en_ld_st_translation_i) ? dtlb_lu_hit : 1'b1;

  always_comb begin : data_interface

    lsu_vaddr_n = lsu_vaddr_i;
    lsu_req_n = lsu_req_i;
    misaligned_ex_n = misaligned_ex_i;
    dtlb_pte_n = dtlb_content;
    dtlb_hit_n = dtlb_lu_hit;
    lsu_is_store_n = lsu_is_store_i;
    dtlb_is_2M_n = dtlb_is_2M;
    dtlb_is_1G_n = dtlb_is_1G;

    lsu_paddr_o = lsu_vaddr_q;
    lsu_valid_o = lsu_req_q;
    lsu_exception_o = misaligned_ex_q;

    misaligned_ex_n.valid = misaligned_ex_i.valid & lsu_req_i;

    daccess_err = (ld_st_priv_lvl_i == riscv_pkg::PRIV_LVL_S && !sum_i && dtlb_pte_q.u) ||
                      (ld_st_priv_lvl_i == riscv_pkg::PRIV_LVL_U && !dtlb_pte_q.u);

    if (en_ld_st_translation_i && !misaligned_ex_q.valid) begin
      lsu_valid_o = 1'b0;

      lsu_paddr_o = {dtlb_pte_q.ppn, lsu_vaddr_q[11:0]};

      if (dtlb_is_2M_q) begin
        lsu_paddr_o[20:12] = lsu_vaddr_q[20:12];
      end

      if (dtlb_is_1G_q) begin
        lsu_paddr_o[29:12] = lsu_vaddr_q[29:12];
      end

      if (dtlb_hit_q && lsu_req_q) begin
        lsu_valid_o = 1'b1;

        if (lsu_is_store_q) begin

          if (!dtlb_pte_q.w || daccess_err || !dtlb_pte_q.d) begin
            lsu_exception_o = {riscv_pkg::STORE_PAGE_FAULT, lsu_vaddr_q, 1'b1};
          end

        end else if (daccess_err) begin
          lsu_exception_o = {riscv_pkg::LOAD_PAGE_FAULT, lsu_vaddr_q, 1'b1};
        end
      end else if (ptw_active && !walking_instr) begin

        if (ptw_error) begin

          lsu_valid_o = 1'b1;

          if (lsu_is_store_q) begin
            lsu_exception_o = {riscv_pkg::STORE_PAGE_FAULT, {25'b0, update_vaddr}, 1'b1};
          end else begin
            lsu_exception_o = {riscv_pkg::LOAD_PAGE_FAULT, {25'b0, update_vaddr}, 1'b1};
          end
        end
      end
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      lsu_vaddr_q     <= '0;
      lsu_req_q       <= '0;
      misaligned_ex_q <= '0;
      dtlb_pte_q      <= '0;
      dtlb_hit_q      <= '0;
      lsu_is_store_q  <= '0;
      dtlb_is_2M_q    <= '0;
      dtlb_is_1G_q    <= '0;
    end else begin
      lsu_vaddr_q     <= lsu_vaddr_n;
      lsu_req_q       <= lsu_req_n;
      misaligned_ex_q <= misaligned_ex_n;
      dtlb_pte_q      <= dtlb_pte_n;
      dtlb_hit_q      <= dtlb_hit_n;
      lsu_is_store_q  <= lsu_is_store_n;
      dtlb_is_2M_q    <= dtlb_is_2M_n;
      dtlb_is_1G_q    <= dtlb_is_1G_n;
    end
  end
endmodule


import ariane_pkg::*;
module store_buffer (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    output logic no_st_pending_o,

    input  logic [11:0] page_offset_i,
    output logic        page_offset_matches_o,

    input  logic commit_i,
    output logic commit_ready_o,
    output logic ready_o,

    input logic valid_i,
    input logic valid_without_flush_i,

    input logic [63:0] paddr_i,
    input logic [63:0] data_i,
    input logic [ 7:0] be_i,
    input logic [ 1:0] data_size_i,

    input  dcache_req_o_t req_port_i,
    output dcache_req_i_t req_port_o
);

  struct packed {
    logic [63:0] address;
    logic [63:0] data;
    logic [7:0]  be;
    logic [1:0]  data_size;
    logic        valid;
  }
      speculative_queue_n[DEPTH_SPEC-1:0],
      speculative_queue_q[DEPTH_SPEC-1:0],
      commit_queue_n[DEPTH_COMMIT-1:0],
      commit_queue_q[DEPTH_COMMIT-1:0];

  logic [$clog2(DEPTH_SPEC):0] speculative_status_cnt_n, speculative_status_cnt_q;
  logic [$clog2(DEPTH_COMMIT):0] commit_status_cnt_n, commit_status_cnt_q;

  logic [$clog2(DEPTH_SPEC)-1:0] speculative_read_pointer_n, speculative_read_pointer_q;
  logic [$clog2(DEPTH_SPEC)-1:0] speculative_write_pointer_n, speculative_write_pointer_q;

  logic [$clog2(DEPTH_COMMIT)-1:0] commit_read_pointer_n, commit_read_pointer_q;
  logic [$clog2(DEPTH_COMMIT)-1:0] commit_write_pointer_n, commit_write_pointer_q;

  always_comb begin : core_if
    automatic logic [DEPTH_SPEC:0] speculative_status_cnt;
    speculative_status_cnt      = speculative_status_cnt_q;

    ready_o                     = (speculative_status_cnt_q < (DEPTH_SPEC - 1)) || commit_i;

    speculative_status_cnt_n    = speculative_status_cnt_q;
    speculative_read_pointer_n  = speculative_read_pointer_q;
    speculative_write_pointer_n = speculative_write_pointer_q;
    speculative_queue_n         = speculative_queue_q;

    if (valid_i) begin
      speculative_queue_n[speculative_write_pointer_q].address = paddr_i;
      speculative_queue_n[speculative_write_pointer_q].data = data_i;
      speculative_queue_n[speculative_write_pointer_q].be = be_i;
      speculative_queue_n[speculative_write_pointer_q].data_size = data_size_i;
      speculative_queue_n[speculative_write_pointer_q].valid = 1'b1;

      speculative_write_pointer_n = speculative_write_pointer_q + 1'b1;
      speculative_status_cnt++;
    end

    if (commit_i) begin

      speculative_queue_n[speculative_read_pointer_q].valid = 1'b0;

      speculative_read_pointer_n = speculative_read_pointer_q + 1'b1;
      speculative_status_cnt--;
    end

    speculative_status_cnt_n = speculative_status_cnt;

    if (flush_i) begin

      for (int unsigned i = 0; i < DEPTH_SPEC; i++) speculative_queue_n[i].valid = 1'b0;

      speculative_write_pointer_n = speculative_read_pointer_q;

      speculative_status_cnt_n = 'b0;
    end
  end

  assign req_port_o.kill_req = 1'b0;
  assign req_port_o.data_we = 1'b1;
  assign req_port_o.tag_valid = 1'b0;

  assign req_port_o.address_index = commit_queue_q[commit_read_pointer_q].address[ariane_pkg::DCACHE_INDEX_WIDTH-1:0];

  assign req_port_o.address_tag   = commit_queue_q[commit_read_pointer_q].address[ariane_pkg::DCACHE_TAG_WIDTH     +
                                                                                    ariane_pkg::DCACHE_INDEX_WIDTH-1 :
                                                                                    ariane_pkg::DCACHE_INDEX_WIDTH];
  assign req_port_o.data_wdata = commit_queue_q[commit_read_pointer_q].data;
  assign req_port_o.data_be = commit_queue_q[commit_read_pointer_q].be;
  assign req_port_o.data_size = commit_queue_q[commit_read_pointer_q].data_size;

  always_comb begin : store_if
    automatic logic [DEPTH_COMMIT:0] commit_status_cnt;
    commit_status_cnt      = commit_status_cnt_q;

    commit_ready_o         = (commit_status_cnt_q < DEPTH_COMMIT);

    no_st_pending_o        = (commit_status_cnt_q == 0);

    commit_read_pointer_n  = commit_read_pointer_q;
    commit_write_pointer_n = commit_write_pointer_q;

    commit_queue_n         = commit_queue_q;

    req_port_o.data_req    = 1'b0;

    if (commit_queue_q[commit_read_pointer_q].valid) begin
      req_port_o.data_req = 1'b1;
      if (req_port_i.data_gnt) begin

        commit_queue_n[commit_read_pointer_q].valid = 1'b0;

        commit_read_pointer_n = commit_read_pointer_q + 1'b1;
        commit_status_cnt--;
      end
    end

    if (commit_i) begin
      commit_queue_n[commit_write_pointer_q] = speculative_queue_q[speculative_read_pointer_q];
      commit_write_pointer_n = commit_write_pointer_n + 1'b1;
      commit_status_cnt++;
    end

    commit_status_cnt_n = commit_status_cnt;
  end

  always_comb begin : address_checker
    page_offset_matches_o = 1'b0;

    for (int unsigned i = 0; i < DEPTH_COMMIT; i++) begin

      if ((page_offset_i[11:3] == commit_queue_q[i].address[11:3]) && commit_queue_q[i].valid) begin
        page_offset_matches_o = 1'b1;
        break;
      end
    end

    for (int unsigned i = 0; i < DEPTH_SPEC; i++) begin

      if ((page_offset_i[11:3] == speculative_queue_q[i].address[11:3]) && speculative_queue_q[i].valid) begin
        page_offset_matches_o = 1'b1;
        break;
      end
    end

    if ((page_offset_i[11:3] == paddr_i[11:3]) && valid_without_flush_i) begin
      page_offset_matches_o = 1'b1;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin : p_spec
    if (~rst_ni) begin
      speculative_queue_q         <= '{default: 0};
      speculative_read_pointer_q  <= '0;
      speculative_write_pointer_q <= '0;
      speculative_status_cnt_q    <= '0;
    end else begin
      speculative_queue_q         <= speculative_queue_n;
      speculative_read_pointer_q  <= speculative_read_pointer_n;
      speculative_write_pointer_q <= speculative_write_pointer_n;
      speculative_status_cnt_q    <= speculative_status_cnt_n;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin : p_commit
    if (~rst_ni) begin
      commit_queue_q         <= '{default: 0};
      commit_read_pointer_q  <= '0;
      commit_write_pointer_q <= '0;
      commit_status_cnt_q    <= '0;
    end else begin
      commit_queue_q         <= commit_queue_n;
      commit_read_pointer_q  <= commit_read_pointer_n;
      commit_write_pointer_q <= commit_write_pointer_n;
      commit_status_cnt_q    <= commit_status_cnt_n;
    end
  end

endmodule



module amo_buffer (
    input  logic                         clk_i,
    input  logic                         rst_ni,
    input  logic                         flush_i,
    input  logic                         valid_i,
    output logic                         ready_o,
    input  ariane_pkg::amo_t             amo_op_i,
    input  logic                  [63:0] paddr_i,
    input  logic                  [63:0] data_i,
    input  logic                  [ 1:0] data_size_i,
    output ariane_pkg::amo_req_t         amo_req_o,
    input  ariane_pkg::amo_resp_t        amo_resp_i,
    input  logic                         amo_valid_commit_i,
    input  logic                         no_st_pending_i
);
  logic flush_amo_buffer;
  logic amo_valid;

  typedef struct packed {
    ariane_pkg::amo_t op;
    logic [63:0]      paddr;
    logic [63:0]      data;
    logic [1:0]       size;
  } amo_op_t;

  amo_op_t amo_data_in, amo_data_out;

  assign amo_req_o.req = no_st_pending_i & amo_valid_commit_i & amo_valid;
  assign amo_req_o.amo_op = amo_data_out.op;
  assign amo_req_o.size = amo_data_out.size;
  assign amo_req_o.operand_a = amo_data_out.paddr;
  assign amo_req_o.operand_b = amo_data_out.data;

  assign amo_data_in.op = amo_op_i;
  assign amo_data_in.data = data_i;
  assign amo_data_in.paddr = paddr_i;
  assign amo_data_in.size = data_size_i;

  assign flush_amo_buffer = flush_i & !amo_valid_commit_i;

  fifo_v2 #(
      .DEPTH       (1),
      .ALM_EMPTY_TH(0),
      .ALM_FULL_TH (0),
      .dtype       (amo_op_t)
  ) i_amo_fifo (
      .clk_i      (clk_i),
      .rst_ni     (rst_ni),
      .flush_i    (flush_amo_buffer),
      .testmode_i (1'b0),
      .full_o     (amo_valid),
      .empty_o    (ready_o),
      .alm_full_o (),
      .alm_empty_o(),
      .data_i     (amo_data_in),
      .push_i     (valid_i),
      .data_o     (amo_data_out),
      .pop_i      (amo_resp_i.ack)
  );

endmodule


import ariane_pkg::*;
module store_unit (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic flush_i,
    output logic no_st_pending_o,

    input  logic      valid_i,
    input  lsu_ctrl_t lsu_ctrl_i,
    output logic      pop_st_o,
    input  logic      commit_i,
    output logic      commit_ready_o,
    input  logic      amo_valid_commit_i,

    output logic                           valid_o,
    output logic       [TRANS_ID_BITS-1:0] trans_id_o,
    output logic       [             63:0] result_o,
    output exception_t                     ex_o,

    output logic              translation_req_o,
    output logic       [63:0] vaddr_o,
    input  logic       [63:0] paddr_i,
    input  exception_t        ex_i,
    input  logic              dtlb_hit_i,

    input  logic [11:0] page_offset_i,
    output logic        page_offset_matches_o,

    output amo_req_t      amo_req_o,
    input  amo_resp_t     amo_resp_i,
    input  dcache_req_o_t req_port_i,
    output dcache_req_i_t req_port_o
);

  assign result_o = 64'b0;

  enum logic [1:0] {
    IDLE,
    VALID_STORE,
    WAIT_TRANSLATION,
    WAIT_STORE_READY
  }
      state_d, state_q;

  logic st_ready;
  logic st_valid;
  logic st_valid_without_flush;
  logic instr_is_amo;
  assign instr_is_amo = is_amo(lsu_ctrl_i.operator);

  logic [63:0] st_data_n, st_data_q;
  logic [7:0] st_be_n, st_be_q;
  logic [1:0] st_data_size_n, st_data_size_q;
  amo_t amo_op_d, amo_op_q;

  logic [TRANS_ID_BITS-1:0] trans_id_n, trans_id_q;

  assign vaddr_o    = lsu_ctrl_i.vaddr;
  assign trans_id_o = trans_id_q;

  always_comb begin : store_control
    translation_req_o      = 1'b0;
    valid_o                = 1'b0;
    st_valid               = 1'b0;
    st_valid_without_flush = 1'b0;
    pop_st_o               = 1'b0;
    ex_o                   = ex_i;
    trans_id_n             = lsu_ctrl_i.trans_id;
    state_d                = state_q;

    case (state_q)

      IDLE: begin
        if (valid_i) begin
          state_d = VALID_STORE;
          translation_req_o = 1'b1;
          pop_st_o = 1'b1;

          if (!dtlb_hit_i) begin
            state_d  = WAIT_TRANSLATION;
            pop_st_o = 1'b0;
          end

          if (!st_ready) begin
            state_d  = WAIT_STORE_READY;
            pop_st_o = 1'b0;
          end
        end
      end

      VALID_STORE: begin
        valid_o = 1'b1;

        if (!flush_i) st_valid = 1'b1;

        st_valid_without_flush = 1'b1;

        if (valid_i && !instr_is_amo) begin

          translation_req_o = 1'b1;
          state_d = VALID_STORE;
          pop_st_o = 1'b1;

          if (!dtlb_hit_i) begin
            state_d  = WAIT_TRANSLATION;
            pop_st_o = 1'b0;
          end

          if (!st_ready) begin
            state_d  = WAIT_STORE_READY;
            pop_st_o = 1'b0;
          end

        end else begin
          state_d = IDLE;
        end
      end

      WAIT_STORE_READY: begin

        translation_req_o = 1'b1;

        if (st_ready && dtlb_hit_i) begin
          state_d = IDLE;
        end
      end

      WAIT_TRANSLATION: begin
        translation_req_o = 1'b1;

        if (dtlb_hit_i) begin
          state_d = IDLE;
        end
      end
    endcase

    if (ex_i.valid && (state_q != IDLE)) begin

      pop_st_o = 1'b1;
      st_valid = 1'b0;
      state_d  = IDLE;
      valid_o  = 1'b1;
    end

    if (flush_i) state_d = IDLE;
  end

  always_comb begin
    st_be_n = lsu_ctrl_i.be;

    st_data_n = instr_is_amo ? lsu_ctrl_i.data : data_align(lsu_ctrl_i.vaddr[2:0], lsu_ctrl_i.data);
    st_data_size_n = extract_transfer_size(lsu_ctrl_i.operator);

    case (lsu_ctrl_i.operator)
      AMO_LRW, AMO_LRD:     amo_op_d = AMO_LR;
      AMO_SCW, AMO_SCD:     amo_op_d = AMO_SC;
      AMO_SWAPW, AMO_SWAPD: amo_op_d = AMO_SWAP;
      AMO_ADDW, AMO_ADDD:   amo_op_d = AMO_ADD;
      AMO_ANDW, AMO_ANDD:   amo_op_d = AMO_AND;
      AMO_ORW, AMO_ORD:     amo_op_d = AMO_OR;
      AMO_XORW, AMO_XORD:   amo_op_d = AMO_XOR;
      AMO_MAXW, AMO_MAXD:   amo_op_d = AMO_MAX;
      AMO_MAXWU, AMO_MAXDU: amo_op_d = AMO_MAXU;
      AMO_MINW, AMO_MIND:   amo_op_d = AMO_MIN;
      AMO_MINWU, AMO_MINDU: amo_op_d = AMO_MINU;
      default:              amo_op_d = AMO_NONE;
    endcase
  end

  logic store_buffer_valid, amo_buffer_valid;
  logic store_buffer_ready, amo_buffer_ready;

  assign store_buffer_valid = st_valid & (amo_op_q == AMO_NONE);
  assign amo_buffer_valid = st_valid & (amo_op_q != AMO_NONE);

  assign st_ready = store_buffer_ready & amo_buffer_ready;

  store_buffer store_buffer_i (
      .clk_i,
      .rst_ni,
      .flush_i,
      .no_st_pending_o,
      .page_offset_i,
      .page_offset_matches_o,
      .commit_i,
      .commit_ready_o,
      .ready_o(store_buffer_ready),
      .valid_i(store_buffer_valid),

      .valid_without_flush_i(st_valid_without_flush),
      .paddr_i,
      .data_i               (st_data_q),
      .be_i                 (st_be_q),
      .data_size_i          (st_data_size_q),
      .req_port_i           (req_port_i),
      .req_port_o           (req_port_o)
  );

  amo_buffer i_amo_buffer (
      .clk_i,
      .rst_ni,
      .flush_i,
      .valid_i           (amo_buffer_valid),
      .ready_o           (amo_buffer_ready),
      .paddr_i           (paddr_i),
      .amo_op_i          (amo_op_q),
      .data_i            (st_data_q),
      .data_size_i       (st_data_size_q),
      .amo_req_o         (amo_req_o),
      .amo_resp_i        (amo_resp_i),
      .amo_valid_commit_i(amo_valid_commit_i),
      .no_st_pending_i   (no_st_pending_o)
  );

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      state_q        <= IDLE;
      st_be_q        <= '0;
      st_data_q      <= '0;
      st_data_size_q <= '0;
      trans_id_q     <= '0;
      amo_op_q       <= AMO_NONE;
    end else begin
      state_q        <= state_d;
      st_be_q        <= st_be_n;
      st_data_q      <= st_data_n;
      trans_id_q     <= trans_id_n;
      st_data_size_q <= st_data_size_n;
      amo_op_q       <= amo_op_d;
    end
  end

endmodule


import ariane_pkg::*;
module load_unit (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    input  logic      valid_i,
    input  lsu_ctrl_t lsu_ctrl_i,
    output logic      pop_ld_o,

    output logic                           valid_o,
    output logic       [TRANS_ID_BITS-1:0] trans_id_o,
    output logic       [             63:0] result_o,
    output exception_t                     ex_o,

    output logic              translation_req_o,
    output logic       [63:0] vaddr_o,
    input  logic       [63:0] paddr_i,
    input  exception_t        ex_i,
    input  logic              dtlb_hit_i,

    output logic [11:0] page_offset_o,
    input  logic        page_offset_matches_i,

    input  dcache_req_o_t req_port_i,
    output dcache_req_i_t req_port_o
);
  enum logic [2:0] {
    IDLE,
    WAIT_GNT,
    SEND_TAG,
    WAIT_PAGE_OFFSET,
    ABORT_TRANSACTION,
    WAIT_TRANSLATION,
    WAIT_FLUSH
  }
      state_d, state_q;

  struct packed {
    logic [TRANS_ID_BITS-1:0] trans_id;
    logic [2:0]               address_offset;
    fu_op                     operator;
  }
      load_data_d, load_data_q, in_data;

  assign page_offset_o = lsu_ctrl_i.vaddr[11:0];

  assign vaddr_o = lsu_ctrl_i.vaddr;

  assign req_port_o.data_we = 1'b0;
  assign req_port_o.data_wdata = '0;

  assign in_data = {lsu_ctrl_i.trans_id, lsu_ctrl_i.vaddr[2:0], lsu_ctrl_i.operator};

  assign req_port_o.address_index = lsu_ctrl_i.vaddr[ariane_pkg::DCACHE_INDEX_WIDTH-1:0];

  assign req_port_o.address_tag   = paddr_i[ariane_pkg::DCACHE_TAG_WIDTH     +
                                              ariane_pkg::DCACHE_INDEX_WIDTH-1 :
                                              ariane_pkg::DCACHE_INDEX_WIDTH];

  assign ex_o = ex_i;

  always_comb begin : load_control

    state_d              = state_q;
    load_data_d          = load_data_q;
    translation_req_o    = 1'b0;
    req_port_o.data_req  = 1'b0;

    req_port_o.kill_req  = 1'b0;
    req_port_o.tag_valid = 1'b0;
    req_port_o.data_be   = lsu_ctrl_i.be;
    req_port_o.data_size = extract_transfer_size(lsu_ctrl_i.operator);
    pop_ld_o             = 1'b0;

    case (state_q)
      IDLE: begin

        if (valid_i) begin

          translation_req_o = 1'b1;

          if (!page_offset_matches_i) begin

            req_port_o.data_req = 1'b1;

            if (!req_port_i.data_gnt) begin
              state_d = WAIT_GNT;
            end else begin
              if (dtlb_hit_i) begin

                state_d  = SEND_TAG;
                pop_ld_o = 1'b1;
              end else state_d = ABORT_TRANSACTION;
            end
          end else begin

            state_d = WAIT_PAGE_OFFSET;
          end
        end
      end

      WAIT_PAGE_OFFSET: begin

        if (!page_offset_matches_i) begin
          state_d = WAIT_GNT;
        end
      end

      ABORT_TRANSACTION: begin
        req_port_o.kill_req = 1'b1;
        req_port_o.tag_valid = 1'b1;

        state_d = WAIT_TRANSLATION;
      end

      WAIT_TRANSLATION: begin
        translation_req_o = 1'b1;

        if (dtlb_hit_i) state_d = WAIT_GNT;
      end

      WAIT_GNT: begin

        translation_req_o   = 1'b1;

        req_port_o.data_req = 1'b1;

        if (req_port_i.data_gnt) begin

          if (dtlb_hit_i) begin
            state_d  = SEND_TAG;
            pop_ld_o = 1'b1;
          end else state_d = ABORT_TRANSACTION;
        end

      end

      SEND_TAG: begin
        req_port_o.tag_valid = 1'b1;
        state_d = IDLE;

        if (valid_i) begin

          translation_req_o = 1'b1;

          if (!page_offset_matches_i) begin

            req_port_o.data_req = 1'b1;

            if (!req_port_i.data_gnt) begin
              state_d = WAIT_GNT;
            end else begin

              if (dtlb_hit_i) begin

                state_d  = SEND_TAG;
                pop_ld_o = 1'b1;
              end else state_d = ABORT_TRANSACTION;
            end
          end else begin

            state_d = WAIT_PAGE_OFFSET;
          end
        end

        if (ex_i.valid) begin
          req_port_o.kill_req = 1'b1;
        end
      end

      WAIT_FLUSH: begin

        req_port_o.kill_req = 1'b1;
        req_port_o.tag_valid = 1'b1;

        state_d = IDLE;
      end

    endcase

    if (ex_i.valid && valid_i) begin

      state_d = IDLE;

      if (!req_port_i.data_rvalid) pop_ld_o = 1'b1;
    end

    if (pop_ld_o && !ex_i.valid) begin
      load_data_d = in_data;
    end

    if (flush_i) begin
      state_d = WAIT_FLUSH;
    end
  end

  always_comb begin : rvalid_output
    valid_o = 1'b0;

    trans_id_o = load_data_q.trans_id;

    if (req_port_i.data_rvalid && state_q != WAIT_FLUSH) begin

      if (!req_port_o.kill_req) valid_o = 1'b1;

      if (ex_i.valid) valid_o = 1'b1;
    end

    if (valid_i && ex_i.valid && !req_port_i.data_rvalid) begin
      valid_o    = 1'b1;
      trans_id_o = lsu_ctrl_i.trans_id;

    end else if (state_q == WAIT_TRANSLATION) begin
      valid_o = 1'b0;
    end

  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      state_q     <= IDLE;
      load_data_q <= '0;
    end else begin
      state_q     <= state_d;
      load_data_q <= load_data_d;
    end
  end

  logic [63:0] shifted_data;

  assign shifted_data = req_port_i.data_rdata >> {load_data_q.address_offset, 3'b000};

  logic [7:0] sign_bits;
  logic [2:0] idx_d, idx_q;
  logic sign_bit, signed_d, signed_q, fp_sign_d, fp_sign_q;

  assign signed_d = load_data_d.operator inside {LW, LH, LB};
  assign fp_sign_d = load_data_d.operator inside {FLW, FLH, FLB};
  assign idx_d     = (load_data_d.operator inside {LW, FLW}) ? load_data_d.address_offset + 3 :
                       (load_data_d.operator inside {LH, FLH}) ? load_data_d.address_offset + 1 :
                                                                 load_data_d.address_offset;

  assign sign_bits = {
    req_port_i.data_rdata[63],
    req_port_i.data_rdata[55],
    req_port_i.data_rdata[47],
    req_port_i.data_rdata[39],
    req_port_i.data_rdata[31],
    req_port_i.data_rdata[23],
    req_port_i.data_rdata[15],
    req_port_i.data_rdata[7]
  };

  assign sign_bit = signed_q & sign_bits[idx_q] | fp_sign_q;

  always_comb begin
    unique case (load_data_q.operator)
      LW, LWU, FLW:    result_o = {{32{sign_bit}}, shifted_data[31:0]};
      LH, LHU, FLH:    result_o = {{48{sign_bit}}, shifted_data[15:0]};
      LB, LBU, FLB:    result_o = {{56{sign_bit}}, shifted_data[7:0]};
      default:    result_o = shifted_data;
    endcase
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin : p_regs
    if (~rst_ni) begin
      idx_q     <= 0;
      signed_q  <= 0;
      fp_sign_q <= 0;
    end else begin
      idx_q     <= idx_d;
      signed_q  <= signed_d;
      fp_sign_q <= fp_sign_d;
    end
  end

endmodule


module pipe_reg_simple #(
    parameter type         dtype = logic,
    parameter int unsigned Depth = 1
) (
    input  logic clk_i,
    input  logic rst_ni,
    input  dtype d_i,
    output dtype d_o
);

  if (Depth == 0) begin
    assign d_o = d_i;

  end else if (Depth == 1) begin
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (~rst_ni) begin
        d_o <= '0;
      end else begin
        d_o <= d_i;
      end
    end

  end else if (Depth > 1) begin
    dtype [Depth-1:0] reg_d, reg_q;
    assign d_o   = reg_q[Depth-1];
    assign reg_d = {reg_q[Depth-2:0], d_i};

    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (~rst_ni) begin
        reg_q <= '0;
      end else begin
        reg_q <= reg_d;
      end
    end
  end

endmodule


import ariane_pkg::*;
module lsu_bypass (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    input lsu_ctrl_t lsu_req_i,
    input logic      lus_req_valid_i,
    input logic      pop_ld_i,
    input logic      pop_st_i,

    output lsu_ctrl_t lsu_ctrl_o,
    output logic      ready_o
);

  lsu_ctrl_t [1:0] mem_n, mem_q;
  logic read_pointer_n, read_pointer_q;
  logic write_pointer_n, write_pointer_q;
  logic [1:0] status_cnt_n, status_cnt_q;

  logic empty;
  assign empty   = (status_cnt_q == 0);
  assign ready_o = empty;

  always_comb begin
    automatic logic [1:0] status_cnt;
    automatic logic write_pointer;
    automatic logic read_pointer;

    status_cnt = status_cnt_q;
    write_pointer = write_pointer_q;
    read_pointer = read_pointer_q;

    mem_n = mem_q;

    if (lus_req_valid_i) begin
      mem_n[write_pointer_q] = lsu_req_i;
      write_pointer++;
      status_cnt++;
    end

    if (pop_ld_i) begin

      mem_n[read_pointer_q].valid = 1'b0;
      read_pointer++;
      status_cnt--;
    end

    if (pop_st_i) begin

      mem_n[read_pointer_q].valid = 1'b0;
      read_pointer++;
      status_cnt--;
    end

    if (pop_st_i && pop_ld_i) foreach (mem_n[i]) mem_n[i] = lsu_ctrl_t'('0);

    if (flush_i) begin
      status_cnt = '0;
      write_pointer = '0;
      read_pointer = '0;
      foreach (mem_n[i]) mem_n[i] = lsu_ctrl_t'('0);
    end

    read_pointer_n  = read_pointer;
    write_pointer_n = write_pointer;
    status_cnt_n    = status_cnt;
  end

  always_comb begin : output_assignments
    if (empty) begin
      lsu_ctrl_o = lsu_req_i;
    end else begin
      lsu_ctrl_o = mem_q[read_pointer_q];
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      foreach (mem_q[i]) mem_q[i] <= lsu_ctrl_t'('0);
      status_cnt_q    <= '0;
      write_pointer_q <= '0;
      read_pointer_q  <= '0;
    end else begin
      mem_q           <= mem_n;
      status_cnt_q    <= status_cnt_n;
      write_pointer_q <= write_pointer_n;
      read_pointer_q  <= read_pointer_n;
    end
  end
endmodule



import ariane_pkg::*;
module load_store_unit #(
    parameter int unsigned ASID_WIDTH = 1
) (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic flush_i,
    output logic no_st_pending_o,
    input  logic amo_valid_commit_i,

    input  fu_data_t fu_data_i,
    output logic     lsu_ready_o,
    input  logic     lsu_valid_i,

    output logic [TRANS_ID_BITS-1:0] load_trans_id_o,
    output logic [63:0] load_result_o,
    output logic load_valid_o,
    output exception_t load_exception_o,

    output logic [TRANS_ID_BITS-1:0] store_trans_id_o,
    output logic [63:0] store_result_o,
    output logic store_valid_o,
    output exception_t store_exception_o,

    input  logic commit_i,
    output logic commit_ready_o,

    input logic enable_translation_i,
    input logic en_ld_st_translation_i,

    input  icache_areq_o_t icache_areq_i,
    output icache_areq_i_t icache_areq_o,

    input riscv_pkg::priv_lvl_t                  priv_lvl_i,
    input riscv_pkg::priv_lvl_t                  ld_st_priv_lvl_i,
    input logic                                  sum_i,
    input logic                                  mxr_i,
    input logic                 [          43:0] satp_ppn_i,
    input logic                 [ASID_WIDTH-1:0] asid_i,
    input logic                                  flush_tlb_i,

    output logic itlb_miss_o,
    output logic dtlb_miss_o,

    input  dcache_req_o_t [2:0] dcache_req_ports_i,
    output dcache_req_i_t [2:0] dcache_req_ports_o,

    output amo_req_t  amo_req_o,
    input  amo_resp_t amo_resp_i
);

  logic             data_misaligned;

  lsu_ctrl_t        lsu_ctrl;

  logic             pop_st;
  logic             pop_ld;

  logic      [63:0] vaddr_i;
  logic      [ 7:0] be_i;

  assign vaddr_i = $unsigned($signed(fu_data_i.imm) + $signed(fu_data_i.operand_a));

  logic                           st_valid_i;
  logic                           ld_valid_i;
  logic                           ld_translation_req;
  logic                           st_translation_req;
  logic       [             63:0] ld_vaddr;
  logic       [             63:0] st_vaddr;
  logic                           translation_req;
  logic                           translation_valid;
  logic       [             63:0] mmu_vaddr;
  logic       [             63:0] mmu_paddr;
  exception_t                     mmu_exception;
  logic                           dtlb_hit;

  logic                           ld_valid;
  logic       [TRANS_ID_BITS-1:0] ld_trans_id;
  logic       [             63:0] ld_result;
  logic                           st_valid;
  logic       [TRANS_ID_BITS-1:0] st_trans_id;
  logic       [             63:0] st_result;

  logic       [             11:0] page_offset;
  logic                           page_offset_matches;

  exception_t                     misaligned_exception;
  exception_t                     ld_ex;
  exception_t                     st_ex;

  mmu #(
      .INSTR_TLB_ENTRIES(16),
      .DATA_TLB_ENTRIES (16),
      .ASID_WIDTH       (ASID_WIDTH)
  ) i_mmu (

      .misaligned_ex_i(misaligned_exception),
      .lsu_is_store_i (st_translation_req),
      .lsu_req_i      (translation_req),
      .lsu_vaddr_i    (mmu_vaddr),
      .lsu_valid_o    (translation_valid),
      .lsu_paddr_o    (mmu_paddr),
      .lsu_exception_o(mmu_exception),
      .lsu_dtlb_hit_o (dtlb_hit),

      .req_port_i(dcache_req_ports_i[0]),
      .req_port_o(dcache_req_ports_o[0]),

      .icache_areq_i(icache_areq_i),
      .icache_areq_o(icache_areq_o),
      .*
  );

  store_unit i_store_unit (
      .clk_i,
      .rst_ni,
      .flush_i,
      .no_st_pending_o,

      .valid_i   (st_valid_i),
      .lsu_ctrl_i(lsu_ctrl),
      .pop_st_o  (pop_st),
      .commit_i,
      .commit_ready_o,
      .amo_valid_commit_i,

      .valid_o   (st_valid),
      .trans_id_o(st_trans_id),
      .result_o  (st_result),
      .ex_o      (st_ex),

      .translation_req_o(st_translation_req),
      .vaddr_o          (st_vaddr),
      .paddr_i          (mmu_paddr),
      .ex_i             (mmu_exception),
      .dtlb_hit_i       (dtlb_hit),

      .page_offset_i        (page_offset),
      .page_offset_matches_o(page_offset_matches),

      .amo_req_o,
      .amo_resp_i,

      .req_port_i(dcache_req_ports_i[2]),
      .req_port_o(dcache_req_ports_o[2])
  );

  load_unit i_load_unit (
      .valid_i   (ld_valid_i),
      .lsu_ctrl_i(lsu_ctrl),
      .pop_ld_o  (pop_ld),

      .valid_o   (ld_valid),
      .trans_id_o(ld_trans_id),
      .result_o  (ld_result),
      .ex_o      (ld_ex),

      .translation_req_o(ld_translation_req),
      .vaddr_o          (ld_vaddr),
      .paddr_i          (mmu_paddr),
      .ex_i             (mmu_exception),
      .dtlb_hit_i       (dtlb_hit),

      .page_offset_o        (page_offset),
      .page_offset_matches_i(page_offset_matches),

      .req_port_i(dcache_req_ports_i[1]),
      .req_port_o(dcache_req_ports_o[1]),
      .*
  );

  pipe_reg_simple #(
      .dtype(logic [$bits(ld_valid) + $bits(ld_trans_id) + $bits(ld_result) + $bits(ld_ex) - 1:0]),
      .Depth(NR_LOAD_PIPE_REGS)
  ) i_pipe_reg_load (
      .clk_i,
      .rst_ni,
      .d_i({ld_valid, ld_trans_id, ld_result, ld_ex}),
      .d_o({load_valid_o, load_trans_id_o, load_result_o, load_exception_o})
  );

  pipe_reg_simple #(
      .dtype(logic [$bits(st_valid) + $bits(st_trans_id) + $bits(st_result) + $bits(st_ex) - 1:0]),
      .Depth(NR_STORE_PIPE_REGS)
  ) i_pipe_reg_store (
      .clk_i,
      .rst_ni,
      .d_i({st_valid, st_trans_id, st_result, st_ex}),
      .d_o({store_valid_o, store_trans_id_o, store_result_o, store_exception_o})
  );

  always_comb begin : which_op

    ld_valid_i      = 1'b0;
    st_valid_i      = 1'b0;

    translation_req = 1'b0;
    mmu_vaddr       = 64'b0;

    unique case (lsu_ctrl.fu)

      LOAD: begin
        ld_valid_i      = lsu_ctrl.valid;
        translation_req = ld_translation_req;
        mmu_vaddr       = ld_vaddr;
      end

      STORE: begin
        st_valid_i      = lsu_ctrl.valid;
        translation_req = st_translation_req;
        mmu_vaddr       = st_vaddr;
      end

      default: ;
    endcase
  end

  assign be_i = be_gen(vaddr_i[2:0], extract_transfer_size(fu_data_i.operator));

  always_comb begin : data_misaligned_detection

    misaligned_exception = {64'b0, 64'b0, 1'b0};

    data_misaligned = 1'b0;

    if (lsu_ctrl.valid) begin
      case (lsu_ctrl.operator)

        LD, SD, FLD, FSD,
                AMO_LRD, AMO_SCD,
                AMO_SWAPD, AMO_ADDD, AMO_ANDD, AMO_ORD,
                AMO_XORD, AMO_MAXD, AMO_MAXDU, AMO_MIND,
                AMO_MINDU: begin
          if (lsu_ctrl.vaddr[2:0] != 3'b000) begin
            data_misaligned = 1'b1;
          end
        end

        LW, LWU, SW, FLW, FSW,
                AMO_LRW, AMO_SCW,
                AMO_SWAPW, AMO_ADDW, AMO_ANDW, AMO_ORW,
                AMO_XORW, AMO_MAXW, AMO_MAXWU, AMO_MINW,
                AMO_MINWU: begin
          if (lsu_ctrl.vaddr[1:0] != 2'b00) begin
            data_misaligned = 1'b1;
          end
        end

        LH, LHU, SH, FLH, FSH: begin
          if (lsu_ctrl.vaddr[0] != 1'b0) begin
            data_misaligned = 1'b1;
          end
        end

        default: ;
      endcase
    end

    if (data_misaligned) begin

      if (lsu_ctrl.fu == LOAD) begin
        misaligned_exception = {riscv_pkg::LD_ADDR_MISALIGNED, lsu_ctrl.vaddr, 1'b1};

      end else if (lsu_ctrl.fu == STORE) begin
        misaligned_exception = {riscv_pkg::ST_ADDR_MISALIGNED, lsu_ctrl.vaddr, 1'b1};
      end
    end

    if (en_ld_st_translation_i && !((&lsu_ctrl.vaddr[63:38]) == 1'b1 || (|lsu_ctrl.vaddr[63:38]) == 1'b0)) begin

      if (lsu_ctrl.fu == LOAD) begin
        misaligned_exception = {riscv_pkg::LD_ACCESS_FAULT, lsu_ctrl.vaddr, 1'b1};

      end else if (lsu_ctrl.fu == STORE) begin
        misaligned_exception = {riscv_pkg::ST_ACCESS_FAULT, lsu_ctrl.vaddr, 1'b1};
      end
    end
  end

  lsu_ctrl_t lsu_req_i;

  assign lsu_req_i = {
    lsu_valid_i,
    vaddr_i,
    fu_data_i.operand_b,
    be_i,
    fu_data_i.fu,
    fu_data_i.operator,
    fu_data_i.trans_id
  };

  lsu_bypass lsu_bypass_i (
      .lsu_req_i      (lsu_req_i),
      .lus_req_valid_i(lsu_valid_i),
      .pop_ld_i       (pop_ld),
      .pop_st_i       (pop_st),

      .lsu_ctrl_o(lsu_ctrl),
      .ready_o   (lsu_ready_o),
      .*
  );

endmodule



import ariane_pkg::*;
module ex_stage (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    input fu_data_t        fu_data_i,
    input logic     [63:0] pc_i,
    input logic            is_compressed_instr_i,

    output logic       [             63:0] flu_result_o,
    output logic       [TRANS_ID_BITS-1:0] flu_trans_id_o,
    output exception_t                     flu_exception_o,
    output logic                           flu_ready_o,
    output logic                           flu_valid_o,

    input logic alu_valid_i,

    input  logic               branch_valid_i,
    input  branchpredict_sbe_t branch_predict_i,
    output branchpredict_t     resolved_branch_o,
    output logic               resolve_branch_o,

    input  logic        csr_valid_i,
    output logic [11:0] csr_addr_o,
    input  logic        csr_commit_i,

    input logic mult_valid_i,

    output logic lsu_ready_o,
    input  logic lsu_valid_i,

    output logic                           load_valid_o,
    output logic       [             63:0] load_result_o,
    output logic       [TRANS_ID_BITS-1:0] load_trans_id_o,
    output exception_t                     load_exception_o,
    output logic                           store_valid_o,
    output logic       [             63:0] store_result_o,
    output logic       [TRANS_ID_BITS-1:0] store_trans_id_o,
    output exception_t                     store_exception_o,

    input  logic lsu_commit_i,
    output logic lsu_commit_ready_o,
    output logic no_st_pending_o,
    input  logic amo_valid_commit_i,

    output logic                           fpu_ready_o,
    input  logic                           fpu_valid_i,
    input  logic       [              1:0] fpu_fmt_i,
    input  logic       [              2:0] fpu_rm_i,
    input  logic       [              2:0] fpu_frm_i,
    input  logic       [              6:0] fpu_prec_i,
    output logic       [TRANS_ID_BITS-1:0] fpu_trans_id_o,
    output logic       [             63:0] fpu_result_o,
    output logic                           fpu_valid_o,
    output exception_t                     fpu_exception_o,

    input logic enable_translation_i,
    input logic en_ld_st_translation_i,
    input logic flush_tlb_i,

    input riscv_pkg::priv_lvl_t                  priv_lvl_i,
    input riscv_pkg::priv_lvl_t                  ld_st_priv_lvl_i,
    input logic                                  sum_i,
    input logic                                  mxr_i,
    input logic                 [          43:0] satp_ppn_i,
    input logic                 [ASID_WIDTH-1:0] asid_i,

    input  icache_areq_o_t icache_areq_i,
    output icache_areq_i_t icache_areq_o,

    input  dcache_req_o_t [2:0] dcache_req_ports_i,
    output dcache_req_i_t [2:0] dcache_req_ports_o,
    output amo_req_t            amo_req_o,
    input  amo_resp_t           amo_resp_i,

    output logic itlb_miss_o,
    output logic dtlb_miss_o
);

  logic alu_branch_res;
  logic [63:0] alu_result, branch_result, csr_result, mult_result;
  logic csr_ready, mult_ready;
  logic [TRANS_ID_BITS-1:0] mult_trans_id;
  logic mult_valid;

  fu_data_t alu_data;
  assign alu_data = (alu_valid_i | branch_valid_i) ? fu_data_i : '0;

  alu alu_i (
      .clk_i,
      .rst_ni,
      .fu_data_i       (alu_data),
      .result_o        (alu_result),
      .alu_branch_res_o(alu_branch_res)
  );

  branch_unit branch_unit_i (
      .fu_data_i,
      .pc_i,
      .is_compressed_instr_i,

      .fu_valid_i ( alu_valid_i || lsu_valid_i || csr_valid_i || mult_valid_i || fpu_valid_i ) ,
      .branch_valid_i,
      .branch_comp_res_i ( alu_branch_res ),
      .branch_result_o   ( branch_result ),
      .branch_predict_i,
      .resolved_branch_o,
      .resolve_branch_o,
      .branch_exception_o ( flu_exception_o )
  );

  csr_buffer csr_buffer_i (
      .clk_i,
      .rst_ni,
      .flush_i,
      .fu_data_i,
      .csr_valid_i,
      .csr_ready_o (csr_ready),
      .csr_result_o(csr_result),
      .csr_commit_i,
      .csr_addr_o
  );

  assign flu_valid_o = alu_valid_i | branch_valid_i | csr_valid_i | mult_valid;

  always_comb begin

    flu_result_o   = branch_result;
    flu_trans_id_o = fu_data_i.trans_id;

    if (alu_valid_i) begin
      flu_result_o = alu_result;

    end else if (csr_valid_i) begin
      flu_result_o = csr_result;
    end else if (mult_valid) begin
      flu_result_o   = mult_result;
      flu_trans_id_o = mult_trans_id;
    end
  end

  always_comb begin
    flu_ready_o = csr_ready & mult_ready;
  end

  fu_data_t mult_data;

  assign mult_data = mult_valid_i ? fu_data_i : '0;

  mult i_mult (
      .clk_i,
      .rst_ni,
      .flush_i,
      .mult_valid_i,
      .fu_data_i      (mult_data),
      .result_o       (mult_result),
      .mult_valid_o   (mult_valid),
      .mult_ready_o   (mult_ready),
      .mult_trans_id_o(mult_trans_id)
  );

  generate
    if (FP_PRESENT) begin : fpu_gen
      fu_data_t fpu_data;
      assign fpu_data = fpu_valid_i ? fu_data_i : '0;

      fpu_wrap #(
          .exception_t(exception_t)
      ) fpu_i (
          .clk_i,
          .rst_ni,
          .flush_i,
          .fpu_valid_i,
          .fpu_ready_o,
          .fu_data_i(fpu_data),
          .fpu_fmt_i,
          .fpu_rm_i,
          .fpu_frm_i,
          .fpu_prec_i,
          .fpu_trans_id_o,
          .result_o (fpu_result_o),
          .fpu_valid_o,
          .fpu_exception_o
      );
    end else begin : no_fpu_gen
      assign fpu_ready_o     = '0;
      assign fpu_trans_id_o  = '0;
      assign fpu_result_o    = '0;
      assign fpu_valid_o     = '0;
      assign fpu_exception_o = '0;
    end
  endgenerate

  fu_data_t lsu_data;

  assign lsu_data = lsu_valid_i ? fu_data_i : '0;

  load_store_unit lsu_i (
      .clk_i,
      .rst_ni,
      .flush_i,
      .no_st_pending_o,
      .fu_data_i     (lsu_data),
      .lsu_ready_o,
      .lsu_valid_i,
      .load_trans_id_o,
      .load_result_o,
      .load_valid_o,
      .load_exception_o,
      .store_trans_id_o,
      .store_result_o,
      .store_valid_o,
      .store_exception_o,
      .commit_i      (lsu_commit_i),
      .commit_ready_o(lsu_commit_ready_o),
      .enable_translation_i,
      .en_ld_st_translation_i,
      .icache_areq_i,
      .icache_areq_o,
      .priv_lvl_i,
      .ld_st_priv_lvl_i,
      .sum_i,
      .mxr_i,
      .satp_ppn_i,
      .asid_i,
      .flush_tlb_i,
      .itlb_miss_o,
      .dtlb_miss_o,
      .dcache_req_ports_i,
      .dcache_req_ports_o,
      .amo_valid_commit_i,
      .amo_req_o,
      .amo_resp_i
  );

endmodule


import ariane_pkg::*;
module commit_stage #(
    parameter int unsigned NR_COMMIT_PORTS = 2
) (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic       halt_i,
    input  logic       flush_dcache_i,
    output exception_t exception_o,
    output logic       dirty_fp_state_o,
    input  logic       debug_mode_i,
    input  logic       debug_req_i,
    input  logic       single_step_i,

    input  scoreboard_entry_t [NR_COMMIT_PORTS-1:0] commit_instr_i,
    output logic              [NR_COMMIT_PORTS-1:0] commit_ack_o,

    output logic [NR_COMMIT_PORTS-1:0][ 4:0] waddr_o,
    output logic [NR_COMMIT_PORTS-1:0][63:0] wdata_o,
    output logic [NR_COMMIT_PORTS-1:0]       we_gpr_o,
    output logic [NR_COMMIT_PORTS-1:0]       we_fpr_o,

    input amo_resp_t amo_resp_i,

    output logic [63:0] pc_o,

    output fu_op              csr_op_o,
    output logic       [63:0] csr_wdata_o,
    input  logic       [63:0] csr_rdata_i,
    input  exception_t        csr_exception_i,
    output logic              csr_write_fflags_o,

    output logic commit_lsu_o,
    input  logic commit_lsu_ready_i,
    output logic amo_valid_commit_o,
    input  logic no_st_pending_i,
    output logic commit_csr_o,
    output logic fence_i_o,
    output logic fence_o,
    output logic flush_commit_o,
    output logic sfence_vma_o
);

  assign waddr_o[0]       = commit_instr_i[0].rd[4:0];
  assign waddr_o[1]       = commit_instr_i[1].rd[4:0];

  assign pc_o             = commit_instr_i[0].pc;
  assign dirty_fp_state_o = |we_fpr_o;

  logic instr_0_is_amo;
  assign instr_0_is_amo = is_amo(commit_instr_i[0].op);

  always_comb begin : commit

    commit_ack_o[0]    = 1'b0;
    commit_ack_o[1]    = 1'b0;

    amo_valid_commit_o = 1'b0;

    we_gpr_o[0]        = 1'b0;
    we_gpr_o[1]        = 1'b0;
    we_fpr_o           = '{default: 1'b0};
    commit_lsu_o       = 1'b0;
    commit_csr_o       = 1'b0;

    wdata_o[0]         = (amo_resp_i.ack) ? amo_resp_i.result : commit_instr_i[0].result;
    wdata_o[1]         = commit_instr_i[1].result;
    csr_op_o           = ADD;
    csr_wdata_o        = 64'b0;
    fence_i_o          = 1'b0;
    fence_o            = 1'b0;
    sfence_vma_o       = 1'b0;
    csr_write_fflags_o = 1'b0;
    flush_commit_o     = 1'b0;

    if (commit_instr_i[0].valid && !halt_i) begin

      if (!debug_req_i || debug_mode_i) begin
        commit_ack_o[0] = 1'b1;

        if (!exception_o.valid) begin

          if (is_rd_fpr(commit_instr_i[0].op)) we_fpr_o[0] = 1'b1;
          else we_gpr_o[0] = 1'b1;

          if (commit_instr_i[0].fu == STORE && !instr_0_is_amo) begin

            if (commit_lsu_ready_i) commit_lsu_o = 1'b1;
            else commit_ack_o[0] = 1'b0;
          end

          if (commit_instr_i[0].fu inside {FPU, FPU_VEC}) begin

            csr_wdata_o = {59'b0, commit_instr_i[0].ex.cause[4:0]};
            csr_write_fflags_o = 1'b1;
          end
        end

        if (commit_instr_i[0].fu == CSR) begin

          commit_csr_o = 1'b1;
          wdata_o[0]   = csr_rdata_i;
          csr_op_o     = commit_instr_i[0].op;
          csr_wdata_o  = commit_instr_i[0].result;
        end

        if (commit_instr_i[0].op == SFENCE_VMA) begin

          sfence_vma_o = no_st_pending_i;

          commit_ack_o[0] = no_st_pending_i;
        end

        if (commit_instr_i[0].op == FENCE_I || (flush_dcache_i && commit_instr_i[0].fu != STORE)) begin
          commit_ack_o[0] = no_st_pending_i;

          fence_i_o = no_st_pending_i;
        end

        if (commit_instr_i[0].op == FENCE) begin
          commit_ack_o[0] = no_st_pending_i;

          fence_o = no_st_pending_i;
        end
      end

      if (RVA && instr_0_is_amo && !commit_instr_i[0].ex.valid) begin

        commit_ack_o[0] = amo_resp_i.ack;

        flush_commit_o = amo_resp_i.ack;
        amo_valid_commit_o = 1'b1;
        we_gpr_o[0] = amo_resp_i.ack;
      end
    end

    if (commit_ack_o[0] && commit_instr_i[1].valid
                            && !halt_i
                            && !(commit_instr_i[0].fu inside {CSR})
                            && !flush_dcache_i
                            && !instr_0_is_amo
                            && !single_step_i) begin

      if (!exception_o.valid && !commit_instr_i[1].ex.valid
                                   && (commit_instr_i[1].fu inside {ALU, LOAD, CTRL_FLOW, MULT, FPU, FPU_VEC})) begin

        if (is_rd_fpr(commit_instr_i[1].op)) we_fpr_o[1] = 1'b1;
        else we_gpr_o[1] = 1'b1;

        commit_ack_o[1] = 1'b1;

        if (commit_instr_i[1].fu inside {FPU, FPU_VEC}) begin
          if (csr_write_fflags_o)
            csr_wdata_o = {
              59'b0, (commit_instr_i[0].ex.cause[4:0] | commit_instr_i[1].ex.cause[4:0])
            };
          else csr_wdata_o = {59'b0, commit_instr_i[1].ex.cause[4:0]};

          csr_write_fflags_o = 1'b1;
        end
      end
    end
  end

  always_comb begin : exception_handling

    exception_o.valid = 1'b0;
    exception_o.cause = 64'b0;
    exception_o.tval  = 64'b0;

    if (commit_instr_i[0].valid) begin

      if (csr_exception_i.valid && !csr_exception_i.cause[63]) begin
        exception_o      = csr_exception_i;

        exception_o.tval = commit_instr_i[0].ex.tval;
      end

      if (commit_instr_i[0].ex.valid) begin
        exception_o = commit_instr_i[0].ex;
      end

      if (csr_exception_i.valid && csr_exception_i.cause[63]
                                      && !amo_valid_commit_o
                                      && commit_instr_i[0].fu != CSR) begin
        exception_o = csr_exception_i;
        exception_o.tval = commit_instr_i[0].ex.tval;
      end
    end

    if (halt_i) begin
      exception_o.valid = 1'b0;
    end
  end

endmodule


import ariane_pkg::*;
module csr_regfile #(
    parameter logic        [63:0] DmBaseAddress = 64'h0,
    parameter int                 AsidWidth     = 1,
    parameter int unsigned        NrCommitPorts = 2
) (
    input logic clk_i,
    input logic rst_ni,
    input logic time_irq_i,

    output logic flush_o,
    output logic halt_csr_o,

    input scoreboard_entry_t [NrCommitPorts-1:0] commit_instr_i,
    input logic              [NrCommitPorts-1:0] commit_ack_i,

    input logic [63:0] boot_addr_i,
    input logic [63:0] hart_id_i,

    input exception_t ex_i,

    input  fu_op              csr_op_i,
    input  logic       [11:0] csr_addr_i,
    input  logic       [63:0] csr_wdata_i,
    output logic       [63:0] csr_rdata_o,
    input  logic              dirty_fp_state_i,
    input  logic              csr_write_fflags_i,
    input  logic       [63:0] pc_i,
    output exception_t        csr_exception_o,

    output logic                 [63:0] epc_o,
    output logic                        eret_o,
    output logic                 [63:0] trap_vector_base_o,
    output riscv_pkg::priv_lvl_t        priv_lvl_o,

    output riscv_pkg::xs_t       fs_o,
    output logic           [4:0] fflags_o,
    output logic           [2:0] frm_o,
    output logic           [6:0] fprec_o,

    output logic                                 en_translation_o,
    output logic                                 en_ld_st_translation_o,
    output riscv_pkg::priv_lvl_t                 ld_st_priv_lvl_o,
    output logic                                 sum_o,
    output logic                                 mxr_o,
    output logic                 [         43:0] satp_ppn_o,
    output logic                 [AsidWidth-1:0] asid_o,

    input  logic [1:0] irq_i,
    input  logic       ipi_i,
    input  logic       debug_req_i,
    output logic       set_debug_pc_o,

    output logic tvm_o,
    output logic tw_o,
    output logic tsr_o,
    output logic debug_mode_o,
    output logic single_step_o,

    output logic icache_en_o,
    output logic dcache_en_o,

    output logic [ 4:0] perf_addr_o,
    output logic [63:0] perf_data_o,
    input  logic [63:0] perf_data_i,
    output logic        perf_we_o
);

  logic read_access_exception, update_access_exception;
  logic csr_we, csr_read;
  logic [63:0] csr_wdata, csr_rdata;
  riscv_pkg::priv_lvl_t trap_to_priv_lvl;

  logic en_ld_st_translation_d, en_ld_st_translation_q;
  logic mprv;
  logic mret;
  logic sret;
  logic dret;

  logic dirty_fp_state_csr;
  riscv_pkg::csr_t csr_addr;

  assign csr_addr = riscv_pkg::csr_t'(csr_addr_i);
  assign fs_o = mstatus_q.fs;

  riscv_pkg::priv_lvl_t priv_lvl_d, priv_lvl_q;

  logic debug_mode_q, debug_mode_d;

  riscv_pkg::status_rv64_t mstatus_q, mstatus_d;
  riscv_pkg::satp_t satp_q, satp_d;
  riscv_pkg::dcsr_t dcsr_q, dcsr_d;

  logic mtvec_rst_load_q;

  logic [63:0] dpc_q, dpc_d;
  logic [63:0] dscratch0_q, dscratch0_d;
  logic [63:0] dscratch1_q, dscratch1_d;
  logic [63:0] mtvec_q, mtvec_d;
  logic [63:0] medeleg_q, medeleg_d;
  logic [63:0] mideleg_q, mideleg_d;
  logic [63:0] mip_q, mip_d;
  logic [63:0] mie_q, mie_d;
  logic [63:0] mscratch_q, mscratch_d;
  logic [63:0] mepc_q, mepc_d;
  logic [63:0] mcause_q, mcause_d;
  logic [63:0] mtval_q, mtval_d;

  logic [63:0] stvec_q, stvec_d;
  logic [63:0] sscratch_q, sscratch_d;
  logic [63:0] sepc_q, sepc_d;
  logic [63:0] scause_q, scause_d;
  logic [63:0] stval_q, stval_d;
  logic [63:0] dcache_q, dcache_d;
  logic [63:0] icache_q, icache_d;

  logic wfi_d, wfi_q;

  logic [63:0] cycle_q, cycle_d;
  logic [63:0] instret_q, instret_d;

  riscv_pkg::fcsr_t fcsr_q, fcsr_d;

  always_comb begin : csr_read_process

    read_access_exception = 1'b0;
    csr_rdata = 64'b0;
    perf_addr_o = csr_addr.address[4:0];
    ;

    if (csr_read) begin
      unique case (csr_addr.address)
        riscv_pkg::CSR_FFLAGS: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            read_access_exception = 1'b1;
          end else begin
            csr_rdata = {59'b0, fcsr_q.fflags};
          end
        end
        riscv_pkg::CSR_FRM: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            read_access_exception = 1'b1;
          end else begin
            csr_rdata = {61'b0, fcsr_q.frm};
          end
        end
        riscv_pkg::CSR_FCSR: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            read_access_exception = 1'b1;
          end else begin
            csr_rdata = {56'b0, fcsr_q.frm, fcsr_q.fflags};
          end
        end

        riscv_pkg::CSR_FTRAN: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            read_access_exception = 1'b1;
          end else begin
            csr_rdata = {57'b0, fcsr_q.fprec};
          end
        end

        riscv_pkg::CSR_DCSR:      csr_rdata = {32'b0, dcsr_q};
        riscv_pkg::CSR_DPC:       csr_rdata = dpc_q;
        riscv_pkg::CSR_DSCRATCH0: csr_rdata = dscratch0_q;
        riscv_pkg::CSR_DSCRATCH1: csr_rdata = dscratch1_q;

        riscv_pkg::CSR_TSELECT: ;
        riscv_pkg::CSR_TDATA1:  ;
        riscv_pkg::CSR_TDATA2:  ;
        riscv_pkg::CSR_TDATA3:  ;

        riscv_pkg::CSR_SSTATUS: begin
          csr_rdata = mstatus_q & ariane_pkg::SMODE_STATUS_READ_MASK;
        end
        riscv_pkg::CSR_SIE:        csr_rdata = mie_q & mideleg_q;
        riscv_pkg::CSR_SIP:        csr_rdata = mip_q & mideleg_q;
        riscv_pkg::CSR_STVEC:      csr_rdata = stvec_q;
        riscv_pkg::CSR_SCOUNTEREN: csr_rdata = 64'b0;
        riscv_pkg::CSR_SSCRATCH:   csr_rdata = sscratch_q;
        riscv_pkg::CSR_SEPC:       csr_rdata = sepc_q;
        riscv_pkg::CSR_SCAUSE:     csr_rdata = scause_q;
        riscv_pkg::CSR_STVAL:      csr_rdata = stval_q;
        riscv_pkg::CSR_SATP: begin

          if (priv_lvl_o == riscv_pkg::PRIV_LVL_S && mstatus_q.tvm) begin
            read_access_exception = 1'b1;
          end else begin
            csr_rdata = satp_q;
          end
        end

        riscv_pkg::CSR_MSTATUS:    csr_rdata = mstatus_q;
        riscv_pkg::CSR_MISA:       csr_rdata = ISA_CODE;
        riscv_pkg::CSR_MEDELEG:    csr_rdata = medeleg_q;
        riscv_pkg::CSR_MIDELEG:    csr_rdata = mideleg_q;
        riscv_pkg::CSR_MIE:        csr_rdata = mie_q;
        riscv_pkg::CSR_MTVEC:      csr_rdata = mtvec_q;
        riscv_pkg::CSR_MCOUNTEREN: csr_rdata = 64'b0;
        riscv_pkg::CSR_MSCRATCH:   csr_rdata = mscratch_q;
        riscv_pkg::CSR_MEPC:       csr_rdata = mepc_q;
        riscv_pkg::CSR_MCAUSE:     csr_rdata = mcause_q;
        riscv_pkg::CSR_MTVAL:      csr_rdata = mtval_q;
        riscv_pkg::CSR_MIP:        csr_rdata = mip_q;
        riscv_pkg::CSR_MVENDORID:  csr_rdata = 64'b0;
        riscv_pkg::CSR_MARCHID:    csr_rdata = ARIANE_MARCHID;
        riscv_pkg::CSR_MIMPID:     csr_rdata = 64'b0;
        riscv_pkg::CSR_MHARTID:    csr_rdata = hart_id_i;
        riscv_pkg::CSR_MCYCLE:     csr_rdata = cycle_q;
        riscv_pkg::CSR_MINSTRET:   csr_rdata = instret_q;

        riscv_pkg::CSR_DCACHE: csr_rdata = dcache_q;
        riscv_pkg::CSR_ICACHE: csr_rdata = icache_q;

        riscv_pkg::CSR_CYCLE: csr_rdata = cycle_q;
        riscv_pkg::CSR_INSTRET: csr_rdata = instret_q;
        riscv_pkg::CSR_L1_ICACHE_MISS,
                riscv_pkg::CSR_L1_DCACHE_MISS,
                riscv_pkg::CSR_ITLB_MISS,
                riscv_pkg::CSR_DTLB_MISS,
                riscv_pkg::CSR_LOAD,
                riscv_pkg::CSR_STORE,
                riscv_pkg::CSR_EXCEPTION,
                riscv_pkg::CSR_EXCEPTION_RET,
                riscv_pkg::CSR_BRANCH_JUMP,
                riscv_pkg::CSR_CALL,
                riscv_pkg::CSR_RET,
                riscv_pkg::CSR_MIS_PREDICT,
                riscv_pkg::CSR_SB_FULL,
                riscv_pkg::CSR_IF_EMPTY:
        csr_rdata = perf_data_i;
        default: read_access_exception = 1'b1;
      endcase
    end
  end

  logic [63:0] mask;
  always_comb begin : csr_update
    automatic riscv_pkg::satp_t sapt;
    automatic logic [63:0] instret;

    sapt = satp_q;
    instret = instret_q;

    cycle_d = cycle_q;
    instret_d = instret_q;
    if (!debug_mode_q) begin

      for (int i = 0; i < NrCommitPorts; i++) begin
        if (commit_ack_i[i] && !ex_i.valid) instret++;
      end
      instret_d = instret;

      if (ENABLE_CYCLE_COUNT) cycle_d = cycle_q + 1'b1;
      else cycle_d = instret;
    end

    eret_o                  = 1'b0;
    flush_o                 = 1'b0;
    update_access_exception = 1'b0;

    set_debug_pc_o          = 1'b0;

    perf_we_o               = 1'b0;
    perf_data_o             = 'b0;

    fcsr_d                  = fcsr_q;

    priv_lvl_d              = priv_lvl_q;
    debug_mode_d            = debug_mode_q;
    dcsr_d                  = dcsr_q;
    dpc_d                   = dpc_q;
    dscratch0_d             = dscratch0_q;
    dscratch1_d             = dscratch1_q;
    mstatus_d               = mstatus_q;

    if (mtvec_rst_load_q) begin
      mtvec_d = boot_addr_i + 'h40;
    end else begin
      mtvec_d = mtvec_q;
    end

    medeleg_d              = medeleg_q;
    mideleg_d              = mideleg_q;
    mip_d                  = mip_q;
    mie_d                  = mie_q;
    mepc_d                 = mepc_q;
    mcause_d               = mcause_q;
    mscratch_d             = mscratch_q;
    mtval_d                = mtval_q;
    dcache_d               = dcache_q;
    icache_d               = icache_q;

    sepc_d                 = sepc_q;
    scause_d               = scause_q;
    stvec_d                = stvec_q;
    sscratch_d             = sscratch_q;
    stval_d                = stval_q;
    satp_d                 = satp_q;

    en_ld_st_translation_d = en_ld_st_translation_q;
    dirty_fp_state_csr     = 1'b0;

    if (csr_we) begin
      unique case (csr_addr.address)

        riscv_pkg::CSR_FFLAGS: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            update_access_exception = 1'b1;
          end else begin
            dirty_fp_state_csr = 1'b1;
            fcsr_d.fflags = csr_wdata[4:0];

            flush_o = 1'b1;
          end
        end
        riscv_pkg::CSR_FRM: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            update_access_exception = 1'b1;
          end else begin
            dirty_fp_state_csr = 1'b1;
            fcsr_d.frm    = csr_wdata[2:0];

            flush_o = 1'b1;
          end
        end
        riscv_pkg::CSR_FCSR: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            update_access_exception = 1'b1;
          end else begin
            dirty_fp_state_csr = 1'b1;
            fcsr_d[7:0] = csr_wdata[7:0];

            flush_o = 1'b1;
          end
        end
        riscv_pkg::CSR_FTRAN: begin
          if (mstatus_q.fs == riscv_pkg::Off) begin
            update_access_exception = 1'b1;
          end else begin
            dirty_fp_state_csr = 1'b1;
            fcsr_d.fprec = csr_wdata[6:0];

            flush_o = 1'b1;
          end
        end

        riscv_pkg::CSR_DCSR: begin
          dcsr_d           = csr_wdata[31:0];

          dcsr_d.xdebugver = 4'h4;

          dcsr_d.prv       = priv_lvl_q;

          dcsr_d.nmip      = 1'b0;
          dcsr_d.stopcount = 1'b0;
          dcsr_d.stoptime  = 1'b0;
        end
        riscv_pkg::CSR_DPC:       dpc_d = csr_wdata;
        riscv_pkg::CSR_DSCRATCH0: dscratch0_d = csr_wdata;
        riscv_pkg::CSR_DSCRATCH1: dscratch1_d = csr_wdata;

        riscv_pkg::CSR_TSELECT: ;
        riscv_pkg::CSR_TDATA1:  ;
        riscv_pkg::CSR_TDATA2:  ;
        riscv_pkg::CSR_TDATA3:  ;

        riscv_pkg::CSR_SSTATUS: begin
          mask = ariane_pkg::SMODE_STATUS_WRITE_MASK;
          mstatus_d = (mstatus_q & ~mask) | (csr_wdata & mask);

          if (!FP_PRESENT) begin
            mstatus_d.fs = riscv_pkg::Off;
          end

          mstatus_d.sd = (&mstatus_q.xs) | (&mstatus_q.fs);

          flush_o = 1'b1;
        end

        riscv_pkg::CSR_SIE: begin

          mie_d = (mie_q & ~mideleg_q) | (csr_wdata & mideleg_q);
        end

        riscv_pkg::CSR_SIP: begin

          mask  = riscv_pkg::MIP_SSIP & mideleg_q;
          mip_d = (mip_q & ~mask) | (csr_wdata & mask);
        end

        riscv_pkg::CSR_SCOUNTEREN: ;
        riscv_pkg::CSR_STVEC:      stvec_d = {csr_wdata[63:2], 1'b0, csr_wdata[0]};
        riscv_pkg::CSR_SSCRATCH:   sscratch_d = csr_wdata;
        riscv_pkg::CSR_SEPC:       sepc_d = {csr_wdata[63:1], 1'b0};
        riscv_pkg::CSR_SCAUSE:     scause_d = csr_wdata;
        riscv_pkg::CSR_STVAL:      stval_d = csr_wdata;

        riscv_pkg::CSR_SATP: begin

          if (priv_lvl_o == riscv_pkg::PRIV_LVL_S && mstatus_q.tvm) update_access_exception = 1'b1;
          else begin
            sapt      = riscv_pkg::satp_t'(csr_wdata);

            sapt.asid = sapt.asid & {{(16 - AsidWidth) {1'b0}}, {AsidWidth{1'b1}}};

            if (sapt.mode == MODE_OFF || sapt.mode == MODE_SV39) satp_d = sapt;
          end

          flush_o = 1'b1;
        end

        riscv_pkg::CSR_MSTATUS: begin
          mstatus_d    = csr_wdata;

          mstatus_d.sd = (&mstatus_q.xs) | (&mstatus_q.fs);
          mstatus_d.xs = riscv_pkg::Off;
          if (!FP_PRESENT) begin
            mstatus_d.fs = riscv_pkg::Off;
          end
          mstatus_d.upie = 1'b0;
          mstatus_d.uie  = 1'b0;

          flush_o        = 1'b1;
        end

        riscv_pkg::CSR_MISA: ;

        riscv_pkg::CSR_MEDELEG: begin
          mask = (1 << riscv_pkg::INSTR_ADDR_MISALIGNED) |
                           (1 << riscv_pkg::BREAKPOINT) |
                           (1 << riscv_pkg::ENV_CALL_UMODE) |
                           (1 << riscv_pkg::INSTR_PAGE_FAULT) |
                           (1 << riscv_pkg::LOAD_PAGE_FAULT) |
                           (1 << riscv_pkg::STORE_PAGE_FAULT);
          medeleg_d = (medeleg_q & ~mask) | (csr_wdata & mask);
        end

        riscv_pkg::CSR_MIDELEG: begin
          mask = riscv_pkg::MIP_SSIP | riscv_pkg::MIP_STIP | riscv_pkg::MIP_SEIP;
          mideleg_d = (mideleg_q & ~mask) | (csr_wdata & mask);
        end

        riscv_pkg::CSR_MIE: begin
          mask = riscv_pkg::MIP_SSIP | riscv_pkg::MIP_STIP | riscv_pkg::MIP_SEIP | riscv_pkg::MIP_MSIP | riscv_pkg::MIP_MTIP;
          mie_d = (mie_q & ~mask) | (csr_wdata & mask);
        end

        riscv_pkg::CSR_MTVEC: begin
          mtvec_d = {csr_wdata[63:2], 1'b0, csr_wdata[0]};

          if (csr_wdata[0]) mtvec_d = {csr_wdata[63:8], 7'b0, csr_wdata[0]};
        end
        riscv_pkg::CSR_MCOUNTEREN: ;

        riscv_pkg::CSR_MSCRATCH: mscratch_d = csr_wdata;
        riscv_pkg::CSR_MEPC:     mepc_d = {csr_wdata[63:1], 1'b0};
        riscv_pkg::CSR_MCAUSE:   mcause_d = csr_wdata;
        riscv_pkg::CSR_MTVAL:    mtval_d = csr_wdata;
        riscv_pkg::CSR_MIP: begin
          mask  = riscv_pkg::MIP_SSIP | riscv_pkg::MIP_STIP | riscv_pkg::MIP_SEIP;
          mip_d = (mip_q & ~mask) | (csr_wdata & mask);
        end

        riscv_pkg::CSR_MCYCLE:   cycle_d = csr_wdata;
        riscv_pkg::CSR_MINSTRET: instret = csr_wdata;
        riscv_pkg::CSR_DCACHE:   dcache_d = csr_wdata[0];
        riscv_pkg::CSR_ICACHE:   icache_d = csr_wdata[0];
        riscv_pkg::CSR_L1_ICACHE_MISS,
                riscv_pkg::CSR_L1_DCACHE_MISS,
                riscv_pkg::CSR_ITLB_MISS,
                riscv_pkg::CSR_DTLB_MISS,
                riscv_pkg::CSR_LOAD,
                riscv_pkg::CSR_STORE,
                riscv_pkg::CSR_EXCEPTION,
                riscv_pkg::CSR_EXCEPTION_RET,
                riscv_pkg::CSR_BRANCH_JUMP,
                riscv_pkg::CSR_CALL,
                riscv_pkg::CSR_RET,
                riscv_pkg::CSR_MIS_PREDICT: begin
          perf_data_o = csr_wdata;
          perf_we_o   = 1'b1;
        end
        default:                 update_access_exception = 1'b1;
      endcase
    end

    mstatus_d.sxl = riscv_pkg::XLEN_64;
    mstatus_d.uxl = riscv_pkg::XLEN_64;

    if (FP_PRESENT && (dirty_fp_state_csr || dirty_fp_state_i)) begin
      mstatus_d.fs = riscv_pkg::Dirty;
    end

    if (csr_write_fflags_i) begin
      fcsr_d.fflags = csr_wdata_i[4:0] | fcsr_q.fflags;
    end

    mip_d[riscv_pkg::IRQ_M_EXT] = irq_i[0];

    mip_d[riscv_pkg::IRQ_M_SOFT] = ipi_i;

    mip_d[riscv_pkg::IRQ_M_TIMER] = time_irq_i;

    trap_to_priv_lvl = riscv_pkg::PRIV_LVL_M;

    if (!debug_mode_q && ex_i.valid) begin

      flush_o = 1'b0;

      if ((ex_i.cause[63] && mideleg_q[ex_i.cause[5:0]]) ||
                (~ex_i.cause[63] && medeleg_q[ex_i.cause[5:0]])) begin

        trap_to_priv_lvl = (priv_lvl_o == riscv_pkg::PRIV_LVL_M) ? riscv_pkg::PRIV_LVL_M : riscv_pkg::PRIV_LVL_S;
      end

      if (trap_to_priv_lvl == riscv_pkg::PRIV_LVL_S) begin

        mstatus_d.sie = 1'b0;
        mstatus_d.spie = mstatus_q.sie;

        mstatus_d.spp = priv_lvl_q[0];

        scause_d = ex_i.cause;

        sepc_d = pc_i;

        stval_d        = (ariane_pkg::ZERO_TVAL
                                  && (ex_i.cause inside {
                                    riscv_pkg::ILLEGAL_INSTR,
                                    riscv_pkg::BREAKPOINT,
                                    riscv_pkg::ENV_CALL_UMODE,
                                    riscv_pkg::ENV_CALL_SMODE,
                                    riscv_pkg::ENV_CALL_MMODE
                                  } || ex_i.cause[63])) ? '0 : ex_i.tval;

      end else begin

        mstatus_d.mie = 1'b0;
        mstatus_d.mpie = mstatus_q.mie;

        mstatus_d.mpp = priv_lvl_q;
        mcause_d = ex_i.cause;

        mepc_d = pc_i;

        mtval_d        = (ariane_pkg::ZERO_TVAL
                                  && (ex_i.cause inside {
                                    riscv_pkg::ILLEGAL_INSTR,
                                    riscv_pkg::BREAKPOINT,
                                    riscv_pkg::ENV_CALL_UMODE,
                                    riscv_pkg::ENV_CALL_SMODE,
                                    riscv_pkg::ENV_CALL_MMODE
                                  } || ex_i.cause[63])) ? '0 : ex_i.tval;
      end

      priv_lvl_d = trap_to_priv_lvl;
    end

    if (!debug_mode_q) begin
      dcsr_d.prv = priv_lvl_o;

      if (ex_i.valid && ex_i.cause == riscv_pkg::BREAKPOINT) begin

        unique case (priv_lvl_o)
          riscv_pkg::PRIV_LVL_M: begin
            debug_mode_d   = dcsr_q.ebreakm;
            set_debug_pc_o = dcsr_q.ebreakm;
          end
          riscv_pkg::PRIV_LVL_S: begin
            debug_mode_d   = dcsr_q.ebreaks;
            set_debug_pc_o = dcsr_q.ebreaks;
          end
          riscv_pkg::PRIV_LVL_U: begin
            debug_mode_d   = dcsr_q.ebreaku;
            set_debug_pc_o = dcsr_q.ebreaku;
          end
          default: ;
        endcase

        dpc_d = pc_i;
        dcsr_d.cause = dm::CauseBreakpoint;
      end

      if (debug_req_i && commit_instr_i[0].valid) begin

        dpc_d = pc_i;

        debug_mode_d = 1'b1;

        set_debug_pc_o = 1'b1;

        dcsr_d.cause = dm::CauseRequest;
      end

      if (dcsr_q.step && commit_ack_i[0]) begin

        if (commit_instr_i[0].fu == CTRL_FLOW) begin

          dpc_d = commit_instr_i[0].bp.predict_address;

        end else if (ex_i.valid) begin
          dpc_d = trap_vector_base_o;

        end else if (eret_o) begin
          dpc_d = epc_o;

        end else begin
          dpc_d = commit_instr_i[0].pc + (commit_instr_i[0].is_compressed ? 'h2 : 'h4);
        end
        debug_mode_d   = 1'b1;
        set_debug_pc_o = 1'b1;
        dcsr_d.cause   = dm::CauseSingleStep;
      end
    end

    if (debug_mode_q && ex_i.valid && ex_i.cause == riscv_pkg::BREAKPOINT) begin
      set_debug_pc_o = 1'b1;
    end

    if (mprv && satp_q.mode == MODE_SV39 && (mstatus_q.mpp != riscv_pkg::PRIV_LVL_M))
      en_ld_st_translation_d = 1'b1;
    else en_ld_st_translation_d = en_translation_o;

    ld_st_priv_lvl_o = (mprv) ? mstatus_q.mpp : priv_lvl_o;
    en_ld_st_translation_o = en_ld_st_translation_q;

    if (mret) begin

      eret_o         = 1'b1;

      mstatus_d.mie  = mstatus_q.mpie;

      priv_lvl_d     = mstatus_q.mpp;

      mstatus_d.mpp  = riscv_pkg::PRIV_LVL_U;

      mstatus_d.mpie = 1'b1;
    end

    if (sret) begin

      eret_o         = 1'b1;

      mstatus_d.sie  = mstatus_q.spie;

      priv_lvl_d     = riscv_pkg::priv_lvl_t'({1'b0, mstatus_q.spp});

      mstatus_d.spp  = 1'b0;

      mstatus_d.spie = 1'b1;
    end

    if (dret) begin

      eret_o       = 1'b1;

      priv_lvl_d   = riscv_pkg::priv_lvl_t'(dcsr_q.prv);

      debug_mode_d = 1'b0;
    end
  end

  always_comb begin : csr_op_logic
    csr_wdata = csr_wdata_i;
    csr_we    = 1'b1;
    csr_read  = 1'b1;
    mret      = 1'b0;
    sret      = 1'b0;
    dret      = 1'b0;

    unique case (csr_op_i)
      CSR_WRITE: csr_wdata = csr_wdata_i;
      CSR_SET:   csr_wdata = csr_wdata_i | csr_rdata;
      CSR_CLEAR: csr_wdata = (~csr_wdata_i) & csr_rdata;
      CSR_READ:  csr_we = 1'b0;
      SRET: begin

        csr_we   = 1'b0;
        csr_read = 1'b0;
        sret     = 1'b1;
      end
      MRET: begin

        csr_we   = 1'b0;
        csr_read = 1'b0;
        mret     = 1'b1;
      end
      DRET: begin

        csr_we   = 1'b0;
        csr_read = 1'b0;
        dret     = 1'b1;
      end
      default: begin
        csr_we   = 1'b0;
        csr_read = 1'b0;
      end
    endcase

    if (ex_i.valid) begin
      mret = 1'b0;
      sret = 1'b0;
      dret = 1'b0;
    end
  end

  logic interrupt_global_enable;

  always_comb begin : exception_ctrl
    automatic logic [63:0] interrupt_cause;
    interrupt_cause = '0;

    wfi_d = wfi_q;

    csr_exception_o = {64'b0, 64'b0, 1'b0};

    if (mie_q[riscv_pkg::S_TIMER_INTERRUPT[5:0]] && mip_q[riscv_pkg::S_TIMER_INTERRUPT[5:0]])
      interrupt_cause = riscv_pkg::S_TIMER_INTERRUPT;

    if (mie_q[riscv_pkg::S_SW_INTERRUPT[5:0]] && mip_q[riscv_pkg::S_SW_INTERRUPT[5:0]])
      interrupt_cause = riscv_pkg::S_SW_INTERRUPT;

    if (mie_q[riscv_pkg::S_EXT_INTERRUPT[5:0]] && (mip_q[riscv_pkg::S_EXT_INTERRUPT[5:0]] | irq_i[1]))
      interrupt_cause = riscv_pkg::S_EXT_INTERRUPT;

    if (mip_q[riscv_pkg::M_TIMER_INTERRUPT[5:0]] && mie_q[riscv_pkg::M_TIMER_INTERRUPT[5:0]])
      interrupt_cause = riscv_pkg::M_TIMER_INTERRUPT;

    if (mip_q[riscv_pkg::M_SW_INTERRUPT[5:0]] && mie_q[riscv_pkg::M_SW_INTERRUPT[5:0]])
      interrupt_cause = riscv_pkg::M_SW_INTERRUPT;

    if (mip_q[riscv_pkg::M_EXT_INTERRUPT[5:0]] && mie_q[riscv_pkg::M_EXT_INTERRUPT[5:0]])
      interrupt_cause = riscv_pkg::M_EXT_INTERRUPT;

    interrupt_global_enable = (~debug_mode_q)

                                & (~dcsr_q.step | dcsr_q.stepie)
                                & ((mstatus_q.mie & (priv_lvl_o == riscv_pkg::PRIV_LVL_M))
                                | (priv_lvl_o != riscv_pkg::PRIV_LVL_M));

    if (interrupt_cause[63] && interrupt_global_enable) begin

      csr_exception_o.cause = interrupt_cause;

      if (mideleg_q[interrupt_cause[5:0]]) begin
        if ((mstatus_q.sie && priv_lvl_o == riscv_pkg::PRIV_LVL_S) || priv_lvl_o == riscv_pkg::PRIV_LVL_U)
          csr_exception_o.valid = 1'b1;
      end else begin
        csr_exception_o.valid = 1'b1;
      end
    end

    if (csr_we || csr_read) begin
      if ((riscv_pkg::priv_lvl_t'(priv_lvl_o & csr_addr.csr_decode.priv_lvl) != csr_addr.csr_decode.priv_lvl)) begin
        csr_exception_o.cause = riscv_pkg::ILLEGAL_INSTR;
        csr_exception_o.valid = 1'b1;
      end

      if (csr_addr_i[11:4] == 8'h7b && !debug_mode_q) begin
        csr_exception_o.cause = riscv_pkg::ILLEGAL_INSTR;
        csr_exception_o.valid = 1'b1;
      end
    end

    if (update_access_exception || read_access_exception) begin
      csr_exception_o.cause = riscv_pkg::ILLEGAL_INSTR;

      csr_exception_o.valid = 1'b1;
    end

    if (|mip_q || debug_req_i || irq_i[1]) begin
      wfi_d = 1'b0;

    end else if (!debug_mode_q && csr_op_i == WFI && !ex_i.valid) begin
      wfi_d = 1'b1;
    end
  end

  always_comb begin : priv_output
    trap_vector_base_o = {mtvec_q[63:2], 2'b0};

    if (trap_to_priv_lvl == riscv_pkg::PRIV_LVL_S) begin
      trap_vector_base_o = {stvec_q[63:2], 2'b0};
    end

    if (debug_mode_q) begin
      trap_vector_base_o = DmBaseAddress + dm::ExceptionAddress;
    end

    if ((mtvec_q[0] || stvec_q[0]) && csr_exception_o.cause[63]) begin
      trap_vector_base_o[7:2] = csr_exception_o.cause[5:0];
    end

    epc_o = mepc_q;

    if (sret) begin
      epc_o = sepc_q;
    end

    if (dret) begin
      epc_o = dpc_q;
    end
  end

  always_comb begin

    csr_rdata_o = csr_rdata;

    unique case (csr_addr.address)
      riscv_pkg::CSR_MIP: csr_rdata_o = csr_rdata | (irq_i[1] << riscv_pkg::IRQ_S_EXT);

      riscv_pkg::CSR_SIP: begin
        csr_rdata_o = csr_rdata
                            | ((irq_i[1] & mideleg_q[riscv_pkg::IRQ_S_EXT]) << riscv_pkg::IRQ_S_EXT);
      end
      default: ;
    endcase
  end

  assign priv_lvl_o = (debug_mode_q) ? riscv_pkg::PRIV_LVL_M : priv_lvl_q;

  assign fflags_o = fcsr_q.fflags;
  assign frm_o = fcsr_q.frm;
  assign fprec_o = fcsr_q.fprec;

  assign satp_ppn_o = satp_q.ppn;
  assign asid_o = satp_q.asid[AsidWidth-1:0];
  assign sum_o = mstatus_q.sum;

  assign en_translation_o = (satp_q.mode == 4'h8 && priv_lvl_o != riscv_pkg::PRIV_LVL_M)
                              ? 1'b1
                              : 1'b0;
  assign mxr_o = mstatus_q.mxr;
  assign tvm_o = mstatus_q.tvm;
  assign tw_o = mstatus_q.tw;
  assign tsr_o = mstatus_q.tsr;
  assign halt_csr_o = wfi_q;
  assign icache_en_o = icache_q[0] & (~debug_mode_q);
  assign dcache_en_o = dcache_q[0];

  assign mprv = (debug_mode_q && !dcsr_q.mprven) ? 1'b0 : mstatus_q.mprv;
  assign debug_mode_o = debug_mode_q;
  assign single_step_o = dcsr_q.step;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      priv_lvl_q             <= riscv_pkg::PRIV_LVL_M;

      fcsr_q                 <= 64'b0;

      debug_mode_q           <= 1'b0;
      dcsr_q                 <= '0;
      dcsr_q.prv             <= riscv_pkg::PRIV_LVL_M;
      dpc_q                  <= 64'b0;
      dscratch0_q            <= 64'b0;
      dscratch1_q            <= 64'b0;

      mstatus_q              <= 64'b0;

      mtvec_rst_load_q       <= 1'b1;
      mtvec_q                <= '0;
      medeleg_q              <= 64'b0;
      mideleg_q              <= 64'b0;
      mip_q                  <= 64'b0;
      mie_q                  <= 64'b0;
      mepc_q                 <= 64'b0;
      mcause_q               <= 64'b0;
      mscratch_q             <= 64'b0;
      mtval_q                <= 64'b0;
      dcache_q               <= 64'b1;
      icache_q               <= 64'b1;

      sepc_q                 <= 64'b0;
      scause_q               <= 64'b0;
      stvec_q                <= 64'b0;
      sscratch_q             <= 64'b0;
      stval_q                <= 64'b0;
      satp_q                 <= 64'b0;

      cycle_q                <= 64'b0;
      instret_q              <= 64'b0;

      en_ld_st_translation_q <= 1'b0;

      wfi_q                  <= 1'b0;
    end else begin
      priv_lvl_q             <= priv_lvl_d;

      fcsr_q                 <= fcsr_d;

      debug_mode_q           <= debug_mode_d;
      dcsr_q                 <= dcsr_d;
      dpc_q                  <= dpc_d;
      dscratch0_q            <= dscratch0_d;
      dscratch1_q            <= dscratch1_d;

      mstatus_q              <= mstatus_d;
      mtvec_rst_load_q       <= 1'b0;
      mtvec_q                <= mtvec_d;
      medeleg_q              <= medeleg_d;
      mideleg_q              <= mideleg_d;
      mip_q                  <= mip_d;
      mie_q                  <= mie_d;
      mepc_q                 <= mepc_d;
      mcause_q               <= mcause_d;
      mscratch_q             <= mscratch_d;
      mtval_q                <= mtval_d;
      dcache_q               <= dcache_d;
      icache_q               <= icache_d;

      sepc_q                 <= sepc_d;
      scause_q               <= scause_d;
      stvec_q                <= stvec_d;
      sscratch_q             <= sscratch_d;
      stval_q                <= stval_d;
      satp_q                 <= satp_d;

      cycle_q                <= cycle_d;
      instret_q              <= instret_d;

      en_ld_st_translation_q <= en_ld_st_translation_d;

      wfi_q                  <= wfi_d;
    end
  end

endmodule


import ariane_pkg::*;
module perf_counters #(
    int unsigned NR_EXTERNAL_COUNTERS = 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic debug_mode_i,

    input  logic [ 4:0] addr_i,
    input  logic        we_i,
    input  logic [63:0] data_i,
    output logic [63:0] data_o,

    input scoreboard_entry_t [NR_COMMIT_PORTS-1:0] commit_instr_i,
    input logic              [NR_COMMIT_PORTS-1:0] commit_ack_i,

    input logic l1_icache_miss_i,
    input logic l1_dcache_miss_i,

    input logic itlb_miss_i,
    input logic dtlb_miss_i,

    input logic sb_full_i,

    input logic if_empty_i,

    input exception_t     ex_i,
    input logic           eret_i,
    input branchpredict_t resolved_branch_i
);

  logic [riscv_pkg::CSR_IF_EMPTY[4:0] : riscv_pkg::CSR_L1_ICACHE_MISS[4:0]][63:0]
      perf_counter_d, perf_counter_q;

  always_comb begin : perf_counters
    perf_counter_d = perf_counter_q;
    data_o = 'b0;

    if (!debug_mode_i) begin

      if (l1_icache_miss_i)
        perf_counter_d[riscv_pkg::CSR_L1_ICACHE_MISS[4:0]] = perf_counter_q[riscv_pkg::CSR_L1_ICACHE_MISS[4:0]] + 1'b1;

      if (l1_dcache_miss_i)
        perf_counter_d[riscv_pkg::CSR_L1_DCACHE_MISS[4:0]] = perf_counter_q[riscv_pkg::CSR_L1_DCACHE_MISS[4:0]] + 1'b1;

      if (itlb_miss_i)
        perf_counter_d[riscv_pkg::CSR_ITLB_MISS[4:0]] = perf_counter_q[riscv_pkg::CSR_ITLB_MISS[4:0]] + 1'b1;

      if (dtlb_miss_i)
        perf_counter_d[riscv_pkg::CSR_DTLB_MISS[4:0]] = perf_counter_q[riscv_pkg::CSR_DTLB_MISS[4:0]] + 1'b1;

      for (int unsigned i = 0; i < NR_COMMIT_PORTS - 1; i++) begin
        if (commit_ack_i[i]) begin
          if (commit_instr_i[i].fu == LOAD)
            perf_counter_d[riscv_pkg::CSR_LOAD[4:0]] = perf_counter_q[riscv_pkg::CSR_LOAD[4:0]] + 1'b1;

          if (commit_instr_i[i].fu == STORE)
            perf_counter_d[riscv_pkg::CSR_STORE[4:0]] = perf_counter_q[riscv_pkg::CSR_STORE[4:0]] + 1'b1;

          if (commit_instr_i[i].fu == CTRL_FLOW)
            perf_counter_d[riscv_pkg::CSR_BRANCH_JUMP[4:0]] = perf_counter_q[riscv_pkg::CSR_BRANCH_JUMP[4:0]] + 1'b1;

          if (commit_instr_i[i].fu == CTRL_FLOW && commit_instr_i[i].op == '0 && commit_instr_i[i].rd == 'b1)
            perf_counter_d[riscv_pkg::CSR_CALL[4:0]] = perf_counter_q[riscv_pkg::CSR_CALL[4:0]] + 1'b1;

          if (commit_instr_i[i].op == JALR && commit_instr_i[i].rs1 == 'b1)
            perf_counter_d[riscv_pkg::CSR_RET[4:0]] = perf_counter_q[riscv_pkg::CSR_RET[4:0]] + 1'b1;
        end
      end

      if (ex_i.valid)
        perf_counter_d[riscv_pkg::CSR_EXCEPTION[4:0]] = perf_counter_q[riscv_pkg::CSR_EXCEPTION[4:0]] + 1'b1;

      if (eret_i)
        perf_counter_d[riscv_pkg::CSR_EXCEPTION_RET[4:0]] = perf_counter_q[riscv_pkg::CSR_EXCEPTION_RET[4:0]] + 1'b1;

      if (resolved_branch_i.valid && resolved_branch_i.is_mispredict)
        perf_counter_d[riscv_pkg::CSR_MIS_PREDICT[4:0]] = perf_counter_q[riscv_pkg::CSR_MIS_PREDICT[4:0]] + 1'b1;

      if (sb_full_i) begin
        perf_counter_d[riscv_pkg::CSR_SB_FULL[4:0]] = perf_counter_q[riscv_pkg::CSR_SB_FULL[4:0]] + 1'b1;
      end

      if (if_empty_i) begin
        perf_counter_d[riscv_pkg::CSR_IF_EMPTY[4:0]] = perf_counter_q[riscv_pkg::CSR_IF_EMPTY[4:0]] + 1'b1;
      end
    end

    data_o = perf_counter_q[addr_i];
    if (we_i) begin
      perf_counter_d[addr_i] = data_i;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      perf_counter_q <= '0;
    end else begin
      perf_counter_q <= perf_counter_d;
    end
  end

endmodule


import ariane_pkg::*;
module controller (
    input  logic clk_i,
    input  logic rst_ni,
    output logic set_pc_commit_o,
    output logic flush_if_o,
    output logic flush_unissued_instr_o,
    output logic flush_id_o,
    output logic flush_ex_o,
    output logic flush_icache_o,
    output logic flush_dcache_o,
    input  logic flush_dcache_ack_i,
    output logic flush_tlb_o,

    input  logic           halt_csr_i,
    output logic           halt_o,
    input  logic           eret_i,
    input  logic           ex_valid_i,
    input  logic           set_debug_pc_i,
    input  branchpredict_t resolved_branch_i,
    input  logic           flush_csr_i,
    input  logic           fence_i_i,
    input  logic           fence_i,
    input  logic           sfence_vma_i,
    input  logic           flush_commit_i
);

  logic fence_active_d, fence_active_q;
  logic flush_dcache;

  always_comb begin : flush_ctrl
    fence_active_d         = fence_active_q;
    set_pc_commit_o        = 1'b0;
    flush_if_o             = 1'b0;
    flush_unissued_instr_o = 1'b0;
    flush_id_o             = 1'b0;
    flush_ex_o             = 1'b0;
    flush_dcache           = 1'b0;
    flush_icache_o         = 1'b0;
    flush_tlb_o            = 1'b0;

    if (resolved_branch_i.is_mispredict) begin

      flush_unissued_instr_o = 1'b1;

      flush_if_o             = 1'b1;
    end

    if (fence_i) begin

      set_pc_commit_o        = 1'b1;
      flush_if_o             = 1'b1;
      flush_unissued_instr_o = 1'b1;
      flush_id_o             = 1'b1;
      flush_ex_o             = 1'b1;

      flush_dcache           = 1'b1;
      fence_active_d         = 1'b1;
    end

    if (fence_i_i) begin
      set_pc_commit_o        = 1'b1;
      flush_if_o             = 1'b1;
      flush_unissued_instr_o = 1'b1;
      flush_id_o             = 1'b1;
      flush_ex_o             = 1'b1;
      flush_icache_o         = 1'b1;

      flush_dcache           = 1'b1;
      fence_active_d         = 1'b1;
    end

    if (flush_dcache_ack_i && fence_active_q) begin
      fence_active_d = 1'b0;

    end else if (fence_active_q) begin
      flush_dcache = 1'b1;
    end

    if (sfence_vma_i) begin
      set_pc_commit_o        = 1'b1;
      flush_if_o             = 1'b1;
      flush_unissued_instr_o = 1'b1;
      flush_id_o             = 1'b1;
      flush_ex_o             = 1'b1;

      flush_tlb_o            = 1'b1;
    end

    if (flush_csr_i || flush_commit_i) begin
      set_pc_commit_o        = 1'b1;
      flush_if_o             = 1'b1;
      flush_unissued_instr_o = 1'b1;
      flush_id_o             = 1'b1;
      flush_ex_o             = 1'b1;
    end

    if (ex_valid_i || eret_i || set_debug_pc_i) begin

      set_pc_commit_o        = 1'b0;
      flush_if_o             = 1'b1;
      flush_unissued_instr_o = 1'b1;
      flush_id_o             = 1'b1;
      flush_ex_o             = 1'b1;
    end
  end

  always_comb begin

    halt_o = halt_csr_i || fence_active_q;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      fence_active_q <= 1'b0;
      flush_dcache_o <= 1'b0;
    end else begin
      fence_active_q <= fence_active_d;

      flush_dcache_o <= flush_dcache;
    end
  end
endmodule


module SyncSpRamBeNx64 #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_DEPTH = 1024,
    parameter OUT_REGS   = 0,
    parameter SIM_INIT   = 0

) (
    input  logic                  Clk_CI,
    input  logic                  Rst_RBI,
    input  logic                  CSel_SI,
    input  logic                  WrEn_SI,
    input  logic [           7:0] BEn_SI,
    input  logic [          63:0] WrData_DI,
    input  logic [ADDR_WIDTH-1:0] Addr_DI,
    output logic [          63:0] RdData_DO
);

  localparam DATA_BYTES = 8;

  logic [DATA_BYTES*8-1:0] RdData_DN;
  logic [DATA_BYTES*8-1:0] RdData_DP;

  logic [DATA_BYTES*8-1:0] Mem_DP[DATA_DEPTH-1:0];

  always_ff @(posedge Clk_CI) begin
    automatic logic [63:0] val;
    if (Rst_RBI == 1'b0 && SIM_INIT > 0) begin
      for (int k = 0; k < DATA_DEPTH; k++) begin
        if (SIM_INIT == 1) val = '0;
        else val = 64'hdeadbeefdeadbeef;
        Mem_DP[k] = val;
      end
    end else if (CSel_SI) begin
      if (WrEn_SI) begin
        if (BEn_SI[0]) Mem_DP[Addr_DI][7:0] <= WrData_DI[7:0];
        if (BEn_SI[1]) Mem_DP[Addr_DI][15:8] <= WrData_DI[15:8];
        if (BEn_SI[2]) Mem_DP[Addr_DI][23:16] <= WrData_DI[23:16];
        if (BEn_SI[3]) Mem_DP[Addr_DI][31:24] <= WrData_DI[31:24];
        if (BEn_SI[4]) Mem_DP[Addr_DI][39:32] <= WrData_DI[39:32];
        if (BEn_SI[5]) Mem_DP[Addr_DI][47:40] <= WrData_DI[47:40];
        if (BEn_SI[6]) Mem_DP[Addr_DI][55:48] <= WrData_DI[55:48];
        if (BEn_SI[7]) Mem_DP[Addr_DI][63:56] <= WrData_DI[63:56];
      end
      RdData_DN <= Mem_DP[Addr_DI];
    end
  end

  generate
    if (OUT_REGS > 0) begin : g_outreg
      always_ff @(posedge Clk_CI or negedge Rst_RBI) begin
        if (Rst_RBI == 1'b0) begin
          RdData_DP <= 0;
        end else begin
          RdData_DP <= RdData_DN;
        end
      end
    end
  endgenerate

  generate
    if (OUT_REGS == 0) begin : g_oureg_byp
      assign RdData_DP = RdData_DN;
    end
  endgenerate

  assign RdData_DO = RdData_DP;

endmodule


module sram #(
    parameter DATA_WIDTH = 64,
    parameter NUM_WORDS  = 1024,
    parameter OUT_REGS   = 0
) (
    input  logic                         clk_i,
    input  logic                         rst_ni,
    input  logic                         req_i,
    input  logic                         we_i,
    input  logic [$clog2(NUM_WORDS)-1:0] addr_i,
    input  logic [       DATA_WIDTH-1:0] wdata_i,
    input  logic [ (DATA_WIDTH+7)/8-1:0] be_i,
    output logic [       DATA_WIDTH-1:0] rdata_o
);

  localparam DATA_WIDTH_ALIGNED = ((DATA_WIDTH + 63) / 64) * 64;
  localparam BE_WIDTH_ALIGNED = (((DATA_WIDTH + 7) / 8 + 7) / 8) * 8;

  logic [DATA_WIDTH_ALIGNED-1:0] wdata_aligned;
  logic [  BE_WIDTH_ALIGNED-1:0] be_aligned;
  logic [DATA_WIDTH_ALIGNED-1:0] rdata_aligned;

  always_comb begin : p_align
    wdata_aligned                    = '0;
    be_aligned                       = '0;
    wdata_aligned[DATA_WIDTH-1:0]    = wdata_i;
    be_aligned[BE_WIDTH_ALIGNED-1:0] = be_i;

    rdata_o                          = rdata_aligned[DATA_WIDTH-1:0];
  end

  genvar k;
  generate
    for (k = 0; k < (DATA_WIDTH + 63) / 64; k++) begin

      SyncSpRamBeNx64 #(
          .ADDR_WIDTH($clog2(NUM_WORDS)),
          .DATA_DEPTH(NUM_WORDS),
          .OUT_REGS  (0),
          .SIM_INIT  (2)
      ) i_ram (
          .Clk_CI   (clk_i),
          .Rst_RBI  (rst_ni),
          .CSel_SI  (req_i),
          .WrEn_SI  (we_i),
          .BEn_SI   (be_aligned[k*8+:8]),
          .WrData_DI(wdata_aligned[k*64+:64]),
          .Addr_DI  (addr_i),
          .RdData_DO(rdata_aligned[k*64+:64])
      );
    end
  endgenerate

endmodule : sram


module lfsr_8bit #(
    parameter logic [7:0] SEED = 8'b0,
    parameter int unsigned WIDTH = 8
) (
    input  logic                     clk_i,
    input  logic                     rst_ni,
    input  logic                     en_i,
    output logic [        WIDTH-1:0] refill_way_oh,
    output logic [$clog2(WIDTH)-1:0] refill_way_bin
);

  localparam int unsigned LOG_WIDTH = $clog2(WIDTH);

  logic [7:0] shift_d, shift_q;

  always_comb begin

    automatic logic shift_in;
    shift_in = !(shift_q[7] ^ shift_q[3] ^ shift_q[2] ^ shift_q[1]);

    shift_d  = shift_q;

    if (en_i) shift_d = {shift_q[6:0], shift_in};

    refill_way_oh = 'b0;
    refill_way_oh[shift_q[LOG_WIDTH-1:0]] = 1'b1;
    refill_way_bin = shift_q;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin : proc_
    if (~rst_ni) begin
      shift_q <= SEED;
    end else begin
      shift_q <= shift_d;
    end
  end

  initial begin
    assert (WIDTH <= 8)
    else $fatal(1, "WIDTH needs to be less than 8 because of the 8-bit LFSR");
  end

endmodule


import ariane_pkg::*;
import std_cache_pkg::*;
module std_icache (
    input logic                 clk_i,
    input logic                 rst_ni,
    input riscv_pkg::priv_lvl_t priv_lvl_i,

    input  logic flush_i,
    input  logic en_i,
    output logic miss_o,

    input  icache_areq_i_t areq_i,
    output icache_areq_o_t areq_o,

    input  icache_dreq_i_t dreq_i,
    output icache_dreq_o_t dreq_o,

    output ariane_axi_pkg::m_req_t  axi_req_o,
    input  ariane_axi_pkg::m_resp_t axi_resp_i
);

  localparam int unsigned ICACHE_BYTE_OFFSET = $clog2(ICACHE_LINE_WIDTH / 8);
  localparam int unsigned ICACHE_NUM_WORD = 2 ** (ICACHE_INDEX_WIDTH - ICACHE_BYTE_OFFSET);
  localparam int unsigned NR_AXI_REFILLS = ($clog2(
      ICACHE_LINE_WIDTH / 64
  ) == 0) ? 1 : $clog2(
      ICACHE_LINE_WIDTH / 64
  );

  enum logic [3:0] {
    FLUSH,
    IDLE,
    TAG_CMP,
    WAIT_AXI_R_RESP,
    WAIT_KILLED_REFILL,
    WAIT_KILLED_AXI_R_RESP,
    REDO_REQ,
    TAG_CMP_SAVED,
    REFILL,
    WAIT_ADDRESS_TRANSLATION,
    WAIT_ADDRESS_TRANSLATION_KILLED
  }
      state_d, state_q;
  logic [$clog2(ICACHE_NUM_WORD)-1:0] cnt_d, cnt_q;
  logic [NR_AXI_REFILLS-1:0] burst_cnt_d, burst_cnt_q;
  logic [63:0] vaddr_d, vaddr_q;
  logic [ICACHE_TAG_WIDTH-1:0] tag_d, tag_q;
  logic [ICACHE_SET_ASSOC-1:0] evict_way_d, evict_way_q;
  logic flushing_d, flushing_q;

  logic [ICACHE_SET_ASSOC-1:0] req;
  logic [ICACHE_SET_ASSOC-1:0] vld_req;
  logic [(ICACHE_LINE_WIDTH+7)/8-1:0] data_be;
  logic [(2**NR_AXI_REFILLS-1):0][7:0] be;
  logic [$clog2(ICACHE_NUM_WORD)-1:0] addr;
  logic we;
  logic [ICACHE_SET_ASSOC-1:0] hit;
  logic [$clog2(ICACHE_NUM_WORD)-1:0] idx;
  logic update_lfsr;
  logic [ICACHE_SET_ASSOC-1:0] random_way;
  logic [ICACHE_SET_ASSOC-1:0] way_valid;
  logic [$clog2(ICACHE_SET_ASSOC)-1:0] repl_invalid;
  logic repl_w_random;
  logic [ICACHE_TAG_WIDTH-1:0] tag;

  struct packed {
    logic                        valid;
    logic [ICACHE_TAG_WIDTH-1:0] tag;
  }
      tag_rdata[ICACHE_SET_ASSOC-1:0], tag_wdata;

  logic [ICACHE_LINE_WIDTH-1:0] data_rdata[ICACHE_SET_ASSOC-1:0], data_wdata;
  logic [(2**NR_AXI_REFILLS-1):0][63:0] wdata;

  for (genvar i = 0; i < ICACHE_SET_ASSOC; i++) begin : sram_block

    sram #(

        .DATA_WIDTH(ICACHE_TAG_WIDTH + 1),
        .NUM_WORDS (ICACHE_NUM_WORD)
    ) tag_sram (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .req_i  (vld_req[i]),
        .we_i   (we),
        .addr_i (addr),
        .wdata_i(tag_wdata),
        .be_i   ('1),
        .rdata_o(tag_rdata[i])
    );

    sram #(
        .DATA_WIDTH(ICACHE_LINE_WIDTH),
        .NUM_WORDS (ICACHE_NUM_WORD)
    ) data_sram (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .req_i  (req[i]),
        .we_i   (we),
        .addr_i (addr),
        .wdata_i(data_wdata),
        .be_i   (data_be),
        .rdata_o(data_rdata[i])
    );

  end

  logic [ICACHE_SET_ASSOC-1:0][FETCH_WIDTH-1:0] cl_sel;

  assign idx = vaddr_q[ICACHE_BYTE_OFFSET-1:2];

  generate
    for (genvar i = 0; i < ICACHE_SET_ASSOC; i++) begin : g_tag_cmpsel
      assign hit[i] = (tag_rdata[i].tag == tag) ? tag_rdata[i].valid : 1'b0;
      assign cl_sel[i] = (hit[i]) ? data_rdata[i][{idx, 5'b0}+:FETCH_WIDTH] : '0;
      assign way_valid[i] = tag_rdata[i].valid;
    end
  endgenerate

  always_comb begin : p_reduction
    dreq_o.data = cl_sel[0];
    for (int i = 1; i < ICACHE_SET_ASSOC; i++) dreq_o.data |= cl_sel[i];
  end

  assign axi_req_o.aw_valid = '0;
  assign axi_req_o.aw.addr = '0;
  assign axi_req_o.aw.prot = '0;
  assign axi_req_o.aw.region = '0;
  assign axi_req_o.aw.len = '0;
  assign axi_req_o.aw.size = 3'b000;
  assign axi_req_o.aw.burst = 2'b00;
  assign axi_req_o.aw.lock = '0;
  assign axi_req_o.aw.cache = '0;
  assign axi_req_o.aw.qos = '0;
  assign axi_req_o.aw.id = '0;
  assign axi_req_o.aw.atop = '0;
  assign axi_req_o.w_valid = '0;
  assign axi_req_o.w.data = '0;
  assign axi_req_o.w.strb = '0;
  assign axi_req_o.w.last = 1'b0;
  assign axi_req_o.b_ready = 1'b0;

  assign axi_req_o.ar.prot = {1'b1, 1'b0, (priv_lvl_i == riscv_pkg::PRIV_LVL_M)};
  assign axi_req_o.ar.region = '0;
  assign axi_req_o.ar.len = (2 ** NR_AXI_REFILLS) - 1;
  assign axi_req_o.ar.size = 3'b011;
  assign axi_req_o.ar.burst = 2'b01;
  assign axi_req_o.ar.lock = '0;
  assign axi_req_o.ar.cache = '0;
  assign axi_req_o.ar.qos = '0;
  assign axi_req_o.ar.id = '0;

  assign axi_req_o.r_ready = 1'b1;

  assign data_be = be;
  assign data_wdata = wdata;

  assign dreq_o.ex = areq_i.fetch_exception;

  assign addr = (state_q == FLUSH) ? cnt_q : vaddr_d[ICACHE_INDEX_WIDTH-1:ICACHE_BYTE_OFFSET];

  always_comb begin : cache_ctrl

    state_d = state_q;
    cnt_d = cnt_q;
    vaddr_d = vaddr_q;
    tag_d = tag_q;
    evict_way_d = evict_way_q;
    flushing_d = flushing_q;
    burst_cnt_d = burst_cnt_q;

    dreq_o.vaddr = vaddr_q;

    req = '0;
    vld_req = '0;
    we = 1'b0;
    be = '0;
    wdata = '0;
    tag_wdata = '0;
    dreq_o.ready = 1'b0;
    tag = areq_i.fetch_paddr[ICACHE_TAG_WIDTH+ICACHE_INDEX_WIDTH-1:ICACHE_INDEX_WIDTH];
    dreq_o.valid = 1'b0;
    update_lfsr = 1'b0;
    miss_o = 1'b0;

    axi_req_o.ar_valid = 1'b0;
    axi_req_o.ar.addr = '0;

    areq_o.fetch_req = 1'b0;
    areq_o.fetch_vaddr = vaddr_q;

    case (state_q)

      IDLE: begin
        dreq_o.ready = 1'b1;
        vaddr_d      = dreq_i.vaddr;

        if (dreq_i.req) begin

          req     = '1;
          vld_req = '1;

          state_d = TAG_CMP;
        end

        if (flush_i || flushing_q) state_d = FLUSH;

        if (dreq_i.kill_s1) state_d = IDLE;
      end

      TAG_CMP, TAG_CMP_SAVED: begin
        areq_o.fetch_req = 1'b1;

        req              = '1;
        vld_req          = '1;

        if (state_q == TAG_CMP_SAVED) tag = tag_q;

        if (|hit && areq_i.fetch_valid && (en_i || (state_q != TAG_CMP))) begin
          dreq_o.ready = 1'b1;
          dreq_o.valid = 1'b1;
          vaddr_d      = dreq_i.vaddr;

          if (dreq_i.req) begin

            state_d = TAG_CMP;

          end else begin
            state_d = IDLE;
          end

          if (dreq_i.kill_s1) state_d = IDLE;

        end else begin
          state_d = REFILL;

          evict_way_d = hit;

          tag_d = areq_i.fetch_paddr[ICACHE_TAG_WIDTH+ICACHE_INDEX_WIDTH-1:ICACHE_INDEX_WIDTH];
          miss_o = en_i;

          if (!(|hit)) begin

            if (repl_w_random) begin
              evict_way_d = random_way;

              update_lfsr = 1'b1;

            end else begin
              evict_way_d[repl_invalid] = 1'b1;
            end
          end
        end

        if (!areq_i.fetch_valid) begin
          state_d = WAIT_ADDRESS_TRANSLATION;
        end
      end

      WAIT_ADDRESS_TRANSLATION, WAIT_ADDRESS_TRANSLATION_KILLED: begin
        areq_o.fetch_req = 1'b1;

        if (areq_i.fetch_valid && (state_q == WAIT_ADDRESS_TRANSLATION)) begin
          if (areq_i.fetch_exception.valid) begin
            dreq_o.valid = 1'b1;
            state_d = IDLE;
          end else begin
            state_d = REDO_REQ;
            tag_d   = areq_i.fetch_paddr[ICACHE_TAG_WIDTH+ICACHE_INDEX_WIDTH-1:ICACHE_INDEX_WIDTH];
          end
        end else if (areq_i.fetch_valid) begin
          state_d = IDLE;
        end

        if (dreq_i.kill_s2) state_d = WAIT_ADDRESS_TRANSLATION_KILLED;
      end

      REFILL, WAIT_KILLED_REFILL: begin
        axi_req_o.ar_valid = 1'b1;
        axi_req_o.ar.addr[ICACHE_INDEX_WIDTH+ICACHE_TAG_WIDTH-1:0] = {
          tag_q, vaddr_q[ICACHE_INDEX_WIDTH-1:ICACHE_BYTE_OFFSET], {ICACHE_BYTE_OFFSET{1'b0}}
        };
        burst_cnt_d = '0;

        if (dreq_i.kill_s2) state_d = WAIT_KILLED_REFILL;

        if (axi_resp_i.ar_ready)
          state_d = (dreq_i.kill_s2 || (state_q == WAIT_KILLED_REFILL)) ? WAIT_KILLED_AXI_R_RESP : WAIT_AXI_R_RESP;
      end

      WAIT_AXI_R_RESP, WAIT_KILLED_AXI_R_RESP: begin

        req     = evict_way_q;
        vld_req = evict_way_q;

        if (axi_resp_i.r_valid) begin
          we = 1'b1;
          tag_wdata.tag = tag_q;
          tag_wdata.valid = 1'b1;
          wdata[burst_cnt_q] = axi_resp_i.r.data;

          be[burst_cnt_q] = '1;

          burst_cnt_d = burst_cnt_q + 1;
        end

        if (dreq_i.kill_s2) state_d = WAIT_KILLED_AXI_R_RESP;

        if (axi_resp_i.r_valid && axi_resp_i.r.last) begin
          state_d = (dreq_i.kill_s2) ? IDLE : REDO_REQ;
        end

        if ((state_q == WAIT_KILLED_AXI_R_RESP) && axi_resp_i.r.last && axi_resp_i.r_valid)
          state_d = IDLE;
      end

      REDO_REQ: begin
        req     = '1;
        vld_req = '1;
        tag     = tag_q;
        state_d = TAG_CMP_SAVED;
      end

      FLUSH: begin
        cnt_d   = cnt_q + 1;
        vld_req = '1;
        we      = 1;

        if (cnt_q == ICACHE_NUM_WORD - 1) begin
          state_d = IDLE;
          flushing_d = 1'b0;
        end
      end

      default: state_d = IDLE;
    endcase

    if (dreq_i.kill_s2 && !(state_q inside {
                                                    REFILL,
                                                    WAIT_AXI_R_RESP,
                                                    WAIT_KILLED_AXI_R_RESP,
                                                    WAIT_KILLED_REFILL,
                                                    WAIT_ADDRESS_TRANSLATION,
                                                    WAIT_ADDRESS_TRANSLATION_KILLED})
                           && !dreq_o.ready) begin
      state_d = IDLE;
    end

    if (dreq_i.kill_s2) dreq_o.valid = 1'b0;

    if (flush_i) begin
      flushing_d   = 1'b1;
      dreq_o.ready = 1'b0;
    end

    if (flushing_q) dreq_o.ready = 1'b0;
  end

  lzc #(
      .WIDTH(ICACHE_SET_ASSOC)
  ) i_lzc (
      .in_i   (~way_valid),
      .cnt_o  (repl_invalid),
      .empty_o(repl_w_random)
  );

  lfsr_8bit #(
      .WIDTH(ICACHE_SET_ASSOC)
  ) i_lfsr (
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .en_i          (update_lfsr),
      .refill_way_oh (random_way),
      .refill_way_bin()
  );

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      state_q     <= FLUSH;
      cnt_q       <= '0;
      vaddr_q     <= '0;
      tag_q       <= '0;
      evict_way_q <= '0;
      flushing_q  <= 1'b0;
      burst_cnt_q <= '0;
      ;
    end else begin
      state_q     <= state_d;
      cnt_q       <= cnt_d;
      vaddr_q     <= vaddr_d;
      tag_q       <= tag_d;
      evict_way_q <= evict_way_d;
      flushing_q  <= flushing_d;
      burst_cnt_q <= burst_cnt_d;
    end
  end

endmodule


import ariane_pkg::*;
import std_cache_pkg::*;
module cache_ctrl #(
    parameter logic [63:0] CACHE_START_ADDR = 64'h4000_0000
) (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic flush_i,
    input  logic bypass_i,
    output logic busy_o,

    input  dcache_req_i_t req_port_i,
    output dcache_req_o_t req_port_o,

    output logic        [  DCACHE_SET_ASSOC-1:0] req_o,
    output logic        [DCACHE_INDEX_WIDTH-1:0] addr_o,
    input  logic                                 gnt_i,
    output cache_line_t                          data_o,
    output cl_be_t                               be_o,
    output logic        [  DCACHE_TAG_WIDTH-1:0] tag_o,
    input  cache_line_t [  DCACHE_SET_ASSOC-1:0] data_i,
    output logic                                 we_o,
    input  logic        [  DCACHE_SET_ASSOC-1:0] hit_way_i,

    output miss_req_t miss_req_o,

    input logic        miss_gnt_i,
    input logic        active_serving_i,
    input logic [63:0] critical_word_i,
    input logic        critical_word_valid_i,

    input logic        bypass_gnt_i,
    input logic        bypass_valid_i,
    input logic [63:0] bypass_data_i,

    output logic [55:0] mshr_addr_o,
    input  logic        mshr_addr_matches_i,
    input  logic        mshr_index_matches_i
);

  enum logic [3:0] {
    IDLE,
    WAIT_TAG,
    WAIT_TAG_BYPASSED,
    STORE_REQ,
    WAIT_REFILL_VALID,
    WAIT_REFILL_GNT,
    WAIT_TAG_SAVED,
    WAIT_MSHR,
    WAIT_CRITICAL_WORD
  }
      state_d, state_q;

  typedef struct packed {
    logic [DCACHE_INDEX_WIDTH-1:0] index;
    logic [DCACHE_TAG_WIDTH-1:0]   tag;
    logic [7:0]                    be;
    logic [1:0]                    size;
    logic                          we;
    logic [63:0]                   wdata;
    logic                          bypass;
  } mem_req_t;

  logic [DCACHE_SET_ASSOC-1:0] hit_way_d, hit_way_q;

  assign busy_o = (state_q != IDLE);

  mem_req_t mem_req_d, mem_req_q;

  logic [DCACHE_LINE_WIDTH-1:0] cl_i;

  always_comb begin : way_select
    cl_i = '0;
    for (int unsigned i = 0; i < DCACHE_SET_ASSOC; i++) if (hit_way_i[i]) cl_i = data_i[i].data;

  end

  always_comb begin : cache_ctrl_fsm
    automatic logic [$clog2(DCACHE_LINE_WIDTH)-1:0] cl_offset;

    cl_offset = mem_req_q.index[DCACHE_BYTE_OFFSET-1:3] << 6;

    state_d   = state_q;
    mem_req_d = mem_req_q;
    hit_way_d = hit_way_q;

    req_port_o.data_gnt    = 1'b0;
    req_port_o.data_rvalid = 1'b0;
    req_port_o.data_rdata  = '0;
    miss_req_o    = '0;
    mshr_addr_o   = '0;

    req_o  = '0;
    addr_o = req_port_i.address_index;
    data_o = '0;
    be_o   = '0;
    tag_o  = '0;
    we_o   = '0;
    tag_o  = 'b0;

    case (state_q)

      IDLE: begin

        if (req_port_i.data_req && !flush_i) begin

          req_o = '1;

          mem_req_d.index = req_port_i.address_index;
          mem_req_d.tag   = req_port_i.address_tag;
          mem_req_d.be    = req_port_i.data_be;
          mem_req_d.size  = req_port_i.data_size;
          mem_req_d.we    = req_port_i.data_we;
          mem_req_d.wdata = req_port_i.data_wdata;

          if (bypass_i) begin
            state_d = (req_port_i.data_we) ? WAIT_REFILL_GNT : WAIT_TAG_BYPASSED;

            req_port_o.data_gnt = (req_port_i.data_we) ? 1'b0 : 1'b1;
            mem_req_d.bypass = 1'b1;

          end else begin

            if (gnt_i) begin
              state_d = WAIT_TAG;
              mem_req_d.bypass = 1'b0;

              if (!req_port_i.data_we) req_port_o.data_gnt = 1'b1;
            end
          end
        end
      end

      WAIT_TAG, WAIT_TAG_SAVED: begin

        tag_o = (state_q == WAIT_TAG_SAVED || mem_req_q.we) ? mem_req_q.tag
                                                                    : req_port_i.address_tag;

        if (req_port_i.data_req && !flush_i) begin
          req_o = '1;
        end

        if (!req_port_i.kill_req) begin

          if (|hit_way_i) begin

            if (req_port_i.data_req && !mem_req_q.we && !flush_i) begin
              state_d             = WAIT_TAG;
              mem_req_d.index     = req_port_i.address_index;
              mem_req_d.be        = req_port_i.data_be;
              mem_req_d.size      = req_port_i.data_size;
              mem_req_d.we        = req_port_i.data_we;
              mem_req_d.wdata     = req_port_i.data_wdata;
              mem_req_d.tag       = req_port_i.address_tag;
              mem_req_d.bypass    = 1'b0;

              req_port_o.data_gnt = gnt_i;

              if (!gnt_i) begin
                state_d = IDLE;
              end
            end else begin
              state_d = IDLE;
            end

            case (mem_req_q.index[3])
              1'b0: req_port_o.data_rdata = cl_i[63:0];
              1'b1: req_port_o.data_rdata = cl_i[127:64];
            endcase

            if (!mem_req_q.we) begin
              req_port_o.data_rvalid = 1'b1;

            end else begin
              state_d   = STORE_REQ;
              hit_way_d = hit_way_i;
            end

          end else begin

            mem_req_d.tag = req_port_i.address_tag;

            state_d = WAIT_REFILL_GNT;
          end

          mshr_addr_o = {tag_o, mem_req_q.index};

          if ((mshr_index_matches_i && mem_req_q.we) || mshr_addr_matches_i) begin
            state_d = WAIT_MSHR;

            if (state_q != WAIT_TAG_SAVED) begin
              mem_req_d.tag = req_port_i.address_tag;
            end
          end

          if (tag_o < CACHE_START_ADDR[DCACHE_TAG_WIDTH+DCACHE_INDEX_WIDTH-1:DCACHE_INDEX_WIDTH]) begin
            mem_req_d.tag = req_port_i.address_tag;
            mem_req_d.bypass = 1'b1;
            state_d = WAIT_REFILL_GNT;
          end
        end
      end

      STORE_REQ: begin

        mshr_addr_o = {mem_req_q.tag, mem_req_q.index};

        if (!mshr_index_matches_i) begin

          req_o                      = hit_way_q;
          addr_o                     = mem_req_q.index;
          we_o                       = 1'b1;

          be_o.vldrty                = hit_way_q;

          be_o.data[cl_offset>>3+:8] = mem_req_q.be;
          data_o.data[cl_offset+:64] = mem_req_q.wdata;

          data_o.dirty               = 1'b1;
          data_o.valid               = 1'b1;

          if (gnt_i) begin
            req_port_o.data_gnt = 1'b1;
            state_d = IDLE;
          end
        end else begin
          state_d = WAIT_MSHR;
        end
      end

      WAIT_MSHR: begin
        mshr_addr_o = {mem_req_q.tag, mem_req_q.index};

        if (!mshr_index_matches_i) begin
          req_o  = '1;

          addr_o = mem_req_q.index;

          if (gnt_i) state_d = WAIT_TAG_SAVED;
        end
      end

      WAIT_TAG_BYPASSED: begin

        if (!req_port_i.kill_req) begin

          mem_req_d.tag = req_port_i.address_tag;
          state_d = WAIT_REFILL_GNT;
        end
      end

      WAIT_REFILL_GNT: begin

        mshr_addr_o = {mem_req_q.tag, mem_req_q.index};

        miss_req_o.valid = 1'b1;
        miss_req_o.bypass = mem_req_q.bypass;
        miss_req_o.addr = {mem_req_q.tag, mem_req_q.index};
        miss_req_o.be = mem_req_q.be;
        miss_req_o.size = mem_req_q.size;
        miss_req_o.we = mem_req_q.we;
        miss_req_o.wdata = mem_req_q.wdata;

        if (bypass_gnt_i) begin
          state_d = WAIT_REFILL_VALID;

          if (mem_req_q.we) req_port_o.data_gnt = 1'b1;
        end

        if (miss_gnt_i && !mem_req_q.we) state_d = WAIT_CRITICAL_WORD;
        else if (miss_gnt_i) begin
          state_d = IDLE;
          req_port_o.data_gnt = 1'b1;
        end

        if (mshr_addr_matches_i && !active_serving_i) begin
          state_d = WAIT_MSHR;
        end
      end

      WAIT_CRITICAL_WORD: begin

        if (req_port_i.data_req) begin

          req_o = '1;
        end

        if (critical_word_valid_i) begin
          req_port_o.data_rvalid = 1'b1;
          req_port_o.data_rdata  = critical_word_i;

          if (req_port_i.data_req) begin

            mem_req_d.index = req_port_i.address_index;
            mem_req_d.be    = req_port_i.data_be;
            mem_req_d.size  = req_port_i.data_size;
            mem_req_d.we    = req_port_i.data_we;
            mem_req_d.wdata = req_port_i.data_wdata;
            mem_req_d.tag   = req_port_i.address_tag;

            state_d = IDLE;

            if (gnt_i) begin
              state_d = WAIT_TAG;
              mem_req_d.bypass = 1'b0;
              req_port_o.data_gnt = 1'b1;
            end
          end else begin
            state_d = IDLE;
          end
        end
      end

      WAIT_REFILL_VALID: begin

        if (bypass_valid_i) begin
          req_port_o.data_rdata = bypass_data_i;
          req_port_o.data_rvalid = 1'b1;
          state_d = IDLE;
        end
      end
    endcase

    if (req_port_i.kill_req) begin
      state_d = IDLE;
      req_port_o.data_rvalid = 1'b1;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      state_q   <= IDLE;
      mem_req_q <= '0;
      hit_way_q <= '0;
    end else begin
      state_q   <= state_d;
      mem_req_q <= mem_req_d;
      hit_way_q <= hit_way_d;
    end
  end

endmodule


module arbiter #(
    parameter int unsigned NR_PORTS   = 3,
    parameter int unsigned DATA_WIDTH = 64
) (
    input logic clk_i,
    input logic rst_ni,

    input logic [NR_PORTS-1:0] data_req_i,
    input logic [NR_PORTS-1:0][63:0] address_i,
    input logic [NR_PORTS-1:0][DATA_WIDTH-1:0] data_wdata_i,
    input logic [NR_PORTS-1:0] data_we_i,
    input logic [NR_PORTS-1:0][DATA_WIDTH/8-1:0] data_be_i,
    input logic [NR_PORTS-1:0][1:0] data_size_i,
    output logic [NR_PORTS-1:0] data_gnt_o,
    output logic [NR_PORTS-1:0] data_rvalid_o,
    output logic [NR_PORTS-1:0][DATA_WIDTH-1:0] data_rdata_o,

    input logic [$clog2(NR_PORTS)-1:0] id_i,
    output logic [$clog2(NR_PORTS)-1:0] id_o,
    input logic [$clog2(NR_PORTS)-1:0] gnt_id_i,
    output logic data_req_o,
    output logic [63:0] address_o,
    output logic [DATA_WIDTH-1:0] data_wdata_o,
    output logic data_we_o,
    output logic [DATA_WIDTH/8-1:0] data_be_o,
    output logic [1:0] data_size_o,
    input logic data_gnt_i,
    input logic data_rvalid_i,
    input logic [DATA_WIDTH-1:0] data_rdata_i
);

  typedef enum logic [1:0] {
    IDLE,
    REQ,
    SERVING
  } state_t;
  state_t state_d;
  state_t state_q;

  typedef struct packed {
    logic [$clog2(NR_PORTS)-1:0] id;
    logic [63:0]                 address;
    logic [63:0]                 data;
    logic [1:0]                  size;
    logic [DATA_WIDTH/8-1:0]     be;
    logic                        we;
  } req_t;
  req_t req_d;
  req_t req_q;

  always_comb begin
    automatic logic [$clog2(NR_PORTS)-1:0] request_index;
    request_index          = 0;

    state_d                = state_q;
    req_d                  = req_q;

    data_req_o             = 1'b0;
    address_o              = req_q.address;
    data_wdata_o           = req_q.data;
    data_be_o              = req_q.be;
    data_size_o            = req_q.size;
    data_we_o              = req_q.we;
    id_o                   = req_q.id;
    data_gnt_o             = '0;

    data_rvalid_o          = '0;
    data_rdata_o           = '0;
    data_rdata_o[req_q.id] = data_rdata_i;

    case (state_q)

      IDLE: begin

        for (int unsigned i = 0; i < NR_PORTS; i++) begin
          if (data_req_i[i] == 1'b1) begin
            data_req_o    = data_req_i[i];
            data_gnt_o[i] = data_req_i[i];
            request_index = i[$bits(request_index)-1:0];

            req_d.address = address_i[i];
            req_d.id = i[$bits(req_q.id)-1:0];
            req_d.data = data_wdata_i[i];
            req_d.size = data_size_i[i];
            req_d.be = data_be_i[i];
            req_d.we = data_we_i[i];
            state_d = SERVING;
            break;
          end
        end

        address_o    = address_i[request_index];
        data_wdata_o = data_wdata_i[request_index];
        data_be_o    = data_be_i[request_index];
        data_size_o  = data_size_i[request_index];
        data_we_o    = data_we_i[request_index];
        id_o         = request_index;
      end

      SERVING: begin
        data_req_o = 1'b1;
        if (data_rvalid_i) begin
          data_rvalid_o[req_q.id] = 1'b1;
          state_d = IDLE;
        end
      end

      default: begin
        state_d = IDLE;
      end
    endcase
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      state_q <= IDLE;
      req_q   <= '0;
    end else begin
      state_q <= state_d;
      req_q   <= req_d;
    end
  end

endmodule


module axi_adapter #(
    parameter int unsigned DATA_WIDTH            = 256,
    parameter logic        CRITICAL_WORD_FIRST   = 0,
    parameter int unsigned AXI_ID_WIDTH          = 10,
    parameter int unsigned CACHELINE_BYTE_OFFSET = 8
) (
    input logic clk_i,
    input logic rst_ni,

    input  logic                                                req_i,
    input  ariane_axi_pkg::ad_req_t                             type_i,
    output logic                                                gnt_o,
    output logic                    [   AXI_ID_WIDTH-1:0]       gnt_id_o,
    input  logic                    [               63:0]       addr_i,
    input  logic                                                we_i,
    input  logic                    [(DATA_WIDTH/64)-1:0][63:0] wdata_i,
    input  logic                    [(DATA_WIDTH/64)-1:0][ 7:0] be_i,
    input  logic                    [                1:0]       size_i,
    input  logic                    [   AXI_ID_WIDTH-1:0]       id_i,

    output logic                             valid_o,
    output logic [(DATA_WIDTH/64)-1:0][63:0] rdata_o,
    output logic [   AXI_ID_WIDTH-1:0]       id_o,

    output logic [63:0] critical_word_o,
    output logic        critical_word_valid_o,

    output ariane_axi_pkg::m_req_t  axi_req_o,
    input  ariane_axi_pkg::m_resp_t axi_resp_i
);
  localparam BURST_SIZE = DATA_WIDTH / 64 - 1;
  localparam ADDR_INDEX = ($clog2(DATA_WIDTH / 64) > 0) ? $clog2(DATA_WIDTH / 64) : 1;

  enum logic [3:0] {
    IDLE,
    WAIT_B_VALID,
    WAIT_AW_READY,
    WAIT_LAST_W_READY,
    WAIT_LAST_W_READY_AW_READY,
    WAIT_AW_READY_BURST,
    WAIT_R_VALID,
    WAIT_R_VALID_MULTIPLE,
    COMPLETE_READ
  }
      state_q, state_d;

  logic [ADDR_INDEX-1:0] cnt_d, cnt_q;
  logic [(DATA_WIDTH/64)-1:0][63:0] cache_line_d, cache_line_q;

  logic [(DATA_WIDTH/64)-1:0] addr_offset_d, addr_offset_q;
  logic [AXI_ID_WIDTH-1:0] id_d, id_q;
  logic [ADDR_INDEX-1:0] index;

  always_comb begin : axi_fsm

    axi_req_o.aw_valid = 1'b0;
    axi_req_o.aw.addr = addr_i;
    axi_req_o.aw.prot = 3'b0;
    axi_req_o.aw.region = 4'b0;
    axi_req_o.aw.len = 8'b0;
    axi_req_o.aw.size = {1'b0, size_i};
    axi_req_o.aw.burst = (type_i == ariane_axi_pkg::SINGLE_REQ) ? 2'b00 : 2'b01;
    axi_req_o.aw.lock = 1'b0;
    axi_req_o.aw.cache = 4'b0;
    axi_req_o.aw.qos = 4'b0;
    axi_req_o.aw.id = id_i;
    axi_req_o.aw.atop = '0;

    axi_req_o.ar_valid = 1'b0;

    axi_req_o.ar.addr   = (CRITICAL_WORD_FIRST || type_i == ariane_axi_pkg::SINGLE_REQ) ? addr_i : { addr_i[63:CACHELINE_BYTE_OFFSET], {{CACHELINE_BYTE_OFFSET}{1'b0}}};
    axi_req_o.ar.prot = 3'b0;
    axi_req_o.ar.region = 4'b0;
    axi_req_o.ar.len = 8'b0;
    axi_req_o.ar.size = {1'b0, size_i};
    axi_req_o.ar.burst  = (type_i == ariane_axi_pkg::SINGLE_REQ) ? 2'b00 : (CRITICAL_WORD_FIRST ? 2'b10 : 2'b01);
    axi_req_o.ar.lock = 1'b0;
    axi_req_o.ar.cache = 4'b0;
    axi_req_o.ar.qos = 4'b0;
    axi_req_o.ar.id = id_i;

    axi_req_o.w_valid = 1'b0;
    axi_req_o.w.data = wdata_i[0];
    axi_req_o.w.strb = be_i[0];
    axi_req_o.w.last = 1'b0;

    axi_req_o.b_ready = 1'b0;
    axi_req_o.r_ready = 1'b0;

    gnt_o = 1'b0;
    gnt_id_o = id_i;
    valid_o = 1'b0;
    id_o = axi_resp_i.r.id;

    critical_word_o = axi_resp_i.r.data;
    critical_word_valid_o = 1'b0;
    rdata_o = cache_line_q;

    state_d = state_q;
    cnt_d = cnt_q;
    cache_line_d = cache_line_q;
    addr_offset_d = addr_offset_q;
    id_d = id_q;
    index = '0;

    case (state_q)

      IDLE: begin
        cnt_d = '0;

        if (req_i) begin

          if (we_i) begin

            axi_req_o.aw_valid = 1'b1;
            axi_req_o.w_valid  = 1'b1;

            if (type_i == ariane_axi_pkg::SINGLE_REQ) begin

              axi_req_o.w.last = 1'b1;

              gnt_o = axi_resp_i.aw_ready & axi_resp_i.w_ready;
              case ({
                axi_resp_i.aw_ready, axi_resp_i.w_ready
              })
                2'b11:   state_d = WAIT_B_VALID;
                2'b01:   state_d = WAIT_AW_READY;
                2'b10:   state_d = WAIT_LAST_W_READY;
                default: state_d = IDLE;
              endcase

            end else begin
              axi_req_o.aw.len = BURST_SIZE;
              axi_req_o.w.data = wdata_i[0];
              axi_req_o.w.strb = be_i[0];

              if (axi_resp_i.w_ready) cnt_d = BURST_SIZE - 1;
              else cnt_d = BURST_SIZE;

              case ({
                axi_resp_i.aw_ready, axi_resp_i.w_ready
              })
                2'b11:   state_d = WAIT_LAST_W_READY;
                2'b01:   state_d = WAIT_LAST_W_READY_AW_READY;
                2'b10:   state_d = WAIT_LAST_W_READY;
                default: ;
              endcase
            end

          end else begin

            axi_req_o.ar_valid = 1'b1;
            gnt_o = axi_resp_i.ar_ready;
            if (type_i != ariane_axi_pkg::SINGLE_REQ) begin
              axi_req_o.ar.len = BURST_SIZE;
              cnt_d = BURST_SIZE;
            end

            if (axi_resp_i.ar_ready) begin
              state_d = (type_i == ariane_axi_pkg::SINGLE_REQ) ? WAIT_R_VALID : WAIT_R_VALID_MULTIPLE;
              addr_offset_d = addr_i[ADDR_INDEX-1+3:3];
            end
          end
        end
      end

      WAIT_AW_READY: begin
        axi_req_o.aw_valid = 1'b1;

        if (axi_resp_i.aw_ready) begin
          gnt_o   = 1'b1;
          state_d = WAIT_B_VALID;
        end
      end

      WAIT_LAST_W_READY_AW_READY: begin
        axi_req_o.w_valid = 1'b1;
        axi_req_o.w.last  = (cnt_q == '0);
        if (type_i == ariane_axi_pkg::SINGLE_REQ) begin
          axi_req_o.w.data = wdata_i[0];
          axi_req_o.w.strb = be_i[0];
        end else begin
          axi_req_o.w.data = wdata_i[BURST_SIZE-cnt_q];
          axi_req_o.w.strb = be_i[BURST_SIZE-cnt_q];
        end
        axi_req_o.aw_valid = 1'b1;

        axi_req_o.aw.len   = BURST_SIZE;

        case ({
          axi_resp_i.aw_ready, axi_resp_i.w_ready
        })

          2'b01: begin

            if (cnt_q == 0) state_d = WAIT_AW_READY_BURST;
            else cnt_d = cnt_q - 1;
          end
          2'b10:   state_d = WAIT_LAST_W_READY;
          2'b11: begin

            if (cnt_q == 0) begin
              state_d = WAIT_B_VALID;
              gnt_o   = 1'b1;

            end else begin
              state_d = WAIT_LAST_W_READY;
              cnt_d   = cnt_q - 1;
            end
          end
          default: ;
        endcase

      end

      WAIT_AW_READY_BURST: begin
        axi_req_o.aw_valid = 1'b1;
        axi_req_o.aw.len   = BURST_SIZE;

        if (axi_resp_i.aw_ready) begin
          state_d = WAIT_B_VALID;
          gnt_o   = 1'b1;
        end
      end

      WAIT_LAST_W_READY: begin
        axi_req_o.w_valid = 1'b1;

        if (type_i != ariane_axi_pkg::SINGLE_REQ) begin
          axi_req_o.w.data = wdata_i[BURST_SIZE-cnt_q];
          axi_req_o.w.strb = be_i[BURST_SIZE-cnt_q];
        end

        if (cnt_q == '0) begin
          axi_req_o.w.last = 1'b1;
          if (axi_resp_i.w_ready) begin
            state_d = WAIT_B_VALID;
            gnt_o   = 1'b1;
          end
        end else if (axi_resp_i.w_ready) begin
          cnt_d = cnt_q - 1;
        end
      end

      WAIT_B_VALID: begin
        axi_req_o.b_ready = 1'b1;
        id_o = axi_resp_i.b.id;

        if (axi_resp_i.b_valid) begin
          state_d = IDLE;
          valid_o = 1'b1;
        end
      end

      WAIT_R_VALID_MULTIPLE, WAIT_R_VALID: begin
        if (CRITICAL_WORD_FIRST) index = addr_offset_q + (BURST_SIZE - cnt_q);
        else index = BURST_SIZE - cnt_q;

        axi_req_o.r_ready = 1'b1;

        if (axi_resp_i.r_valid) begin
          if (CRITICAL_WORD_FIRST) begin

            if (state_q == WAIT_R_VALID_MULTIPLE && cnt_q == BURST_SIZE) begin
              critical_word_valid_o = 1'b1;
              critical_word_o       = axi_resp_i.r.data;
            end
          end else begin

            if (index == addr_offset_q) begin
              critical_word_valid_o = 1'b1;
              critical_word_o       = axi_resp_i.r.data;
            end
          end

          if (axi_resp_i.r.last) begin
            id_d    = axi_resp_i.r.id;
            state_d = COMPLETE_READ;
          end

          if (state_q == WAIT_R_VALID_MULTIPLE) begin
            cache_line_d[index] = axi_resp_i.r.data;

          end else cache_line_d[0] = axi_resp_i.r.data;

          cnt_d = cnt_q - 1;
        end
      end

      COMPLETE_READ: begin
        valid_o = 1'b1;
        state_d = IDLE;
        id_o    = id_q;
      end
    endcase
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin

      state_q       <= IDLE;
      cnt_q         <= '0;
      cache_line_q  <= '0;
      addr_offset_q <= '0;
      id_q          <= '0;
    end else begin
      state_q       <= state_d;
      cnt_q         <= cnt_d;
      cache_line_q  <= cache_line_d;
      addr_offset_q <= addr_offset_d;
      id_q          <= id_d;
    end
  end

endmodule


module amo_alu (
    input  ariane_pkg::amo_t        amo_op_i,
    input  logic             [63:0] amo_operand_a_i,
    input  logic             [63:0] amo_operand_b_i,
    output logic             [63:0] amo_result_o
);

  logic [64:0] adder_sum;
  logic [64:0] adder_operand_a, adder_operand_b;

  assign adder_sum = adder_operand_a + adder_operand_b;

  always_comb begin

    adder_operand_a = $signed(amo_operand_a_i);
    adder_operand_b = $signed(amo_operand_b_i);

    amo_result_o = amo_operand_b_i;

    unique case (amo_op_i)

      ariane_pkg::AMO_SC: ;
      ariane_pkg::AMO_SWAP: ;
      ariane_pkg::AMO_ADD: amo_result_o = adder_sum[63:0];
      ariane_pkg::AMO_AND: amo_result_o = amo_operand_a_i & amo_operand_b_i;
      ariane_pkg::AMO_OR: amo_result_o = amo_operand_a_i | amo_operand_b_i;
      ariane_pkg::AMO_XOR: amo_result_o = amo_operand_a_i ^ amo_operand_b_i;
      ariane_pkg::AMO_MAX: begin
        adder_operand_b = -$signed(amo_operand_b_i);
        amo_result_o = adder_sum[64] ? amo_operand_b_i : amo_operand_a_i;
      end
      ariane_pkg::AMO_MIN: begin
        adder_operand_b = -$signed(amo_operand_b_i);
        amo_result_o = adder_sum[64] ? amo_operand_a_i : amo_operand_b_i;
      end
      ariane_pkg::AMO_MAXU: begin
        adder_operand_a = $unsigned(amo_operand_a_i);
        adder_operand_b = -$unsigned(amo_operand_b_i);
        amo_result_o = adder_sum[64] ? amo_operand_b_i : amo_operand_a_i;
      end
      ariane_pkg::AMO_MINU: begin
        adder_operand_a = $unsigned(amo_operand_a_i);
        adder_operand_b = -$unsigned(amo_operand_b_i);
        amo_result_o = adder_sum[64] ? amo_operand_a_i : amo_operand_b_i;
      end
      default: amo_result_o = '0;
    endcase
  end
endmodule


import ariane_pkg::*;
import std_cache_pkg::*;module miss_handler #(
    parameter int unsigned NR_PORTS         = 3
)(
    input  logic                                        clk_i,
    input  logic                                        rst_ni,
    input  logic                                        flush_i,
    output logic                                        flush_ack_o,
    output logic                                        miss_o,
    input  logic                                        busy_i,

    input  logic [NR_PORTS-1:0][$bits(miss_req_t)-1:0]  miss_req_i,

    output logic [NR_PORTS-1:0]                         bypass_gnt_o,
    output logic [NR_PORTS-1:0]                         bypass_valid_o,
    output logic [NR_PORTS-1:0][63:0]                   bypass_data_o,

    output ariane_axi_pkg::m_req_t                            axi_bypass_o,
    input  ariane_axi_pkg::m_resp_t                           axi_bypass_i,

    output logic [NR_PORTS-1:0]                         miss_gnt_o,
    output logic [NR_PORTS-1:0]                         active_serving_o,

    output logic [63:0]                                 critical_word_o,
    output logic                                        critical_word_valid_o,
    output ariane_axi_pkg::m_req_t                            axi_data_o,
    input  ariane_axi_pkg::m_resp_t                           axi_data_i,

    input  logic [NR_PORTS-1:0][55:0]                   mshr_addr_i,
    output logic [NR_PORTS-1:0]                         mshr_addr_matches_o,
    output logic [NR_PORTS-1:0]                         mshr_index_matches_o,

    input  amo_req_t                                    amo_req_i,
    output amo_resp_t                                   amo_resp_o,

    output logic  [DCACHE_SET_ASSOC-1:0]                req_o,
    output logic  [DCACHE_INDEX_WIDTH-1:0]              addr_o,
    output cache_line_t                                 data_o,
    output cl_be_t                                      be_o,
    input  cache_line_t [DCACHE_SET_ASSOC-1:0]          data_i,
    output logic                                        we_o
);

    enum logic [3:0] {
        IDLE,
        FLUSHING,
        FLUSH,
        WB_CACHELINE_FLUSH,
        FLUSH_REQ_STATUS,
        WB_CACHELINE_MISS,
        WAIT_GNT_SRAM,
        MISS,
        REQ_CACHELINE,
        MISS_REPL,
        SAVE_CACHELINE,
        INIT,
        AMO_LOAD,
        AMO_SAVE_LOAD,
        AMO_STORE
    } state_d, state_q;

    mshr_t                                  mshr_d, mshr_q;
    logic [DCACHE_INDEX_WIDTH-1:0]          cnt_d, cnt_q;
    logic [DCACHE_SET_ASSOC-1:0]            evict_way_d, evict_way_q;

    cache_line_t                            evict_cl_d, evict_cl_q;

    logic serve_amo_d, serve_amo_q;

    logic [NR_PORTS-1:0]                    miss_req_valid;
    logic [NR_PORTS-1:0]                    miss_req_bypass;
    logic [NR_PORTS-1:0][63:0]              miss_req_addr;
    logic [NR_PORTS-1:0][63:0]              miss_req_wdata;
    logic [NR_PORTS-1:0]                    miss_req_we;
    logic [NR_PORTS-1:0][7:0]               miss_req_be;
    logic [NR_PORTS-1:0][1:0]               miss_req_size;

    logic                                    req_fsm_miss_valid;
    logic [63:0]                             req_fsm_miss_addr;
    logic [DCACHE_LINE_WIDTH-1:0]            req_fsm_miss_wdata;
    logic                                    req_fsm_miss_we;
    logic [(DCACHE_LINE_WIDTH/8)-1:0]        req_fsm_miss_be;
    ariane_axi_pkg::ad_req_t                 req_fsm_miss_req;
    logic [1:0]                              req_fsm_miss_size;

    logic                                    gnt_miss_fsm;
    logic                                    valid_miss_fsm;
    logic [(DCACHE_LINE_WIDTH/64)-1:0][63:0] data_miss_fsm;

    logic                                  lfsr_enable;
    logic [DCACHE_SET_ASSOC-1:0]           lfsr_oh;
    logic [$clog2(DCACHE_SET_ASSOC-1)-1:0] lfsr_bin;

    ariane_pkg::amo_t amo_op;
    logic [63:0] amo_operand_a, amo_operand_b, amo_result_o;

    struct packed {
        logic [63:3] address;
        logic        valid;
    } reservation_d, reservation_q;

    always_comb begin : cache_management
        automatic logic [DCACHE_SET_ASSOC-1:0] evict_way, valid_way;

        for (int unsigned i = 0; i < DCACHE_SET_ASSOC; i++) begin
            evict_way[i] = data_i[i].valid & data_i[i].dirty;
            valid_way[i] = data_i[i].valid;
        end

        req_o  = '0;
        addr_o = '0;
        data_o = '0;
        be_o   = '0;
        we_o   = '0;

        miss_gnt_o = '0;

        lfsr_enable = 1'b0;

        req_fsm_miss_valid  = 1'b0;
        req_fsm_miss_addr   = '0;
        req_fsm_miss_wdata  = '0;
        req_fsm_miss_we     = 1'b0;
        req_fsm_miss_be     = '0;
        req_fsm_miss_req    = ariane_axi_pkg::CACHE_LINE_REQ;
        req_fsm_miss_size   = 2'b11;

        flush_ack_o         = 1'b0;
        miss_o              = 1'b0;
        serve_amo_d         = serve_amo_q;

        state_d      = state_q;
        cnt_d        = cnt_q;
        evict_way_d  = evict_way_q;
        evict_cl_d   = evict_cl_q;
        mshr_d       = mshr_q;

        active_serving_o[mshr_q.id] = mshr_q.valid;

        amo_resp_o.ack = 1'b0;
        amo_resp_o.result = '0;

        amo_op = amo_req_i.amo_op;
        amo_operand_a = '0;
        amo_operand_b = '0;

        reservation_d = reservation_q;
        case (state_q)

            IDLE: begin

                if (amo_req_i.req && !busy_i) begin

                    if (!serve_amo_q) begin
                        state_d = FLUSH_REQ_STATUS;
                        serve_amo_d = 1'b1;

                    end else begin
                        state_d = AMO_LOAD;
                        serve_amo_d = 1'b0;
                    end
                end

                if (flush_i && !busy_i) begin
                    state_d = FLUSH_REQ_STATUS;
                    cnt_d = '0;
                end

                for (int unsigned i = 0; i < NR_PORTS; i++) begin

                    if (miss_req_valid[i] && !miss_req_bypass[i]) begin
                        state_d      = MISS;

                        serve_amo_d  = 1'b0;

                        mshr_d.valid = 1'b1;
                        mshr_d.we    = miss_req_we[i];
                        mshr_d.id    = i;
                        mshr_d.addr  = miss_req_addr[i][DCACHE_TAG_WIDTH+DCACHE_INDEX_WIDTH-1:0];
                        mshr_d.wdata = miss_req_wdata[i];
                        mshr_d.be    = miss_req_be[i];
                        break;
                    end
                end
            end

            MISS: begin

                req_o = '1;
                addr_o = mshr_q.addr[DCACHE_INDEX_WIDTH-1:0];
                state_d = MISS_REPL;
                miss_o = 1'b1;
            end

            MISS_REPL: begin

                if (&valid_way) begin
                    lfsr_enable = 1'b1;
                    evict_way_d = lfsr_oh;

                    if (data_i[lfsr_bin].dirty) begin
                        state_d = WB_CACHELINE_MISS;
                        evict_cl_d.tag = data_i[lfsr_bin].tag;
                        evict_cl_d.data = data_i[lfsr_bin].data;
                        cnt_d = mshr_q.addr[DCACHE_INDEX_WIDTH-1:0];

                    end else
                        state_d = REQ_CACHELINE;

                end else begin

                    evict_way_d = get_victim_cl(~valid_way);
                    state_d = REQ_CACHELINE;
                end
            end

            REQ_CACHELINE: begin
                req_fsm_miss_valid  = 1'b1;
                req_fsm_miss_addr   = mshr_q.addr;

                if (gnt_miss_fsm) begin
                    state_d = SAVE_CACHELINE;
                    miss_gnt_o[mshr_q.id] = 1'b1;
                end
            end

            SAVE_CACHELINE: begin

                automatic logic [$clog2(DCACHE_LINE_WIDTH)-1:0] cl_offset;
                cl_offset = mshr_q.addr[DCACHE_BYTE_OFFSET-1:3] << 6;

                if (valid_miss_fsm) begin

                    addr_o       = mshr_q.addr[DCACHE_INDEX_WIDTH-1:0];
                    req_o        = evict_way_q;
                    we_o         = 1'b1;
                    be_o         = '1;
                    be_o.vldrty  = evict_way_q;
                    data_o.tag   = mshr_q.addr[DCACHE_TAG_WIDTH+DCACHE_INDEX_WIDTH-1:DCACHE_INDEX_WIDTH];
                    data_o.data  = data_miss_fsm;
                    data_o.valid = 1'b1;
                    data_o.dirty = 1'b0;

                    if (mshr_q.we) begin

                        for (int i = 0; i < 8; i++) begin

                            if (mshr_q.be[i])
                                data_o.data[(cl_offset + i*8) +: 8] = mshr_q.wdata[i];
                        end

                        data_o.dirty = 1'b1;
                    end

                    mshr_d.valid = 1'b0;

                    state_d = IDLE;
                end
            end

            WB_CACHELINE_FLUSH, WB_CACHELINE_MISS: begin

                req_fsm_miss_valid  = 1'b1;
                req_fsm_miss_addr   = {evict_cl_q.tag, cnt_q[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET], {{DCACHE_BYTE_OFFSET}{1'b0}}};
                req_fsm_miss_be     = '1;
                req_fsm_miss_we     = 1'b1;
                req_fsm_miss_wdata  = evict_cl_q.data;

                if (gnt_miss_fsm) begin

                    addr_o     = cnt_q;
                    req_o      = 1'b1;
                    we_o       = 1'b1;
                    data_o.valid = INVALIDATE_ON_FLUSH ? 1'b0 : 1'b1;

                    be_o.vldrty = evict_way_q;

                    state_d = (state_q == WB_CACHELINE_MISS) ? MISS : FLUSH_REQ_STATUS;
                end
            end

            FLUSH_REQ_STATUS: begin
                req_o   = '1;
                addr_o  = cnt_q;
                state_d = FLUSHING;
            end

            FLUSHING: begin

                if (|evict_way) begin

                    evict_way_d = get_victim_cl(evict_way);
                    evict_cl_d  = data_i[one_hot_to_bin(evict_way)];
                    state_d     = WB_CACHELINE_FLUSH;

                end else begin

                    cnt_d       = cnt_q + (1'b1 << DCACHE_BYTE_OFFSET);
                    state_d     = FLUSH_REQ_STATUS;
                    addr_o      = cnt_q;
                    req_o       = 1'b1;
                    be_o.vldrty = INVALIDATE_ON_FLUSH ? '1 : '0;
                    we_o        = 1'b1;

                    if (cnt_q[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET] == std_cache_pkg::DCACHE_NUM_WORDS-1) begin

                        flush_ack_o = ~serve_amo_q;
                        state_d     = IDLE;
                    end
                end
            end

            INIT: begin

                addr_o = cnt_q;
                req_o  = 1'b1;
                we_o   = 1'b1;

                be_o.vldrty = '1;
                cnt_d       = cnt_q + (1'b1 << DCACHE_BYTE_OFFSET);

                if (cnt_q[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET] == std_cache_pkg::DCACHE_NUM_WORDS-1)
                    state_d = IDLE;
            end

            AMO_LOAD: begin
                req_fsm_miss_valid = 1'b1;

                req_fsm_miss_addr = amo_req_i.operand_a;
                req_fsm_miss_req = ariane_axi_pkg::SINGLE_REQ;
                req_fsm_miss_size = amo_req_i.size;

                if (gnt_miss_fsm) begin
                    state_d = AMO_SAVE_LOAD;
                end
            end

            AMO_SAVE_LOAD: begin
                if (valid_miss_fsm) begin

                    mshr_d.wdata = data_miss_fsm[0];
                    state_d = AMO_STORE;
                end
            end

            AMO_STORE: begin
                automatic logic [63:0] load_data;

                load_data = data_align(amo_req_i.operand_a[2:0], mshr_q.wdata);

                if (amo_req_i.size == 2'b10) begin
                    amo_operand_a = sext32(load_data[31:0]);
                    amo_operand_b = sext32(amo_req_i.operand_b[31:0]);
                end else begin
                    amo_operand_a = load_data;
                    amo_operand_b = amo_req_i.operand_b;
                end

                if (amo_req_i.amo_op == AMO_LR ||
                   (amo_req_i.amo_op == AMO_SC &&
                   ((reservation_q.valid && reservation_q.address != amo_req_i.operand_a[63:3]) || !reservation_q.valid))) begin
                    req_fsm_miss_valid = 1'b0;
                    state_d = IDLE;
                    amo_resp_o.ack = 1'b1;

                    amo_resp_o.result = amo_operand_a;

                    if (amo_req_i.amo_op == AMO_SC) begin
                        amo_resp_o.result = 1'b1;

                        reservation_d.valid = 1'b0;
                    end
                end else begin
                    req_fsm_miss_valid = 1'b1;
                end

                req_fsm_miss_we   = 1'b1;
                req_fsm_miss_req  = ariane_axi_pkg::SINGLE_REQ;
                req_fsm_miss_size = amo_req_i.size;
                req_fsm_miss_addr = amo_req_i.operand_a;

                req_fsm_miss_wdata = data_align(amo_req_i.operand_a[2:0], amo_result_o);
                req_fsm_miss_be = be_gen(amo_req_i.operand_a[2:0], amo_req_i.size);

                if (amo_req_i.amo_op == AMO_LR) begin
                    reservation_d.address = amo_req_i.operand_a[63:3];
                    reservation_d.valid = 1'b1;
                end

                if (valid_miss_fsm) begin
                    state_d = IDLE;
                    amo_resp_o.ack = 1'b1;

                    amo_resp_o.result = amo_operand_a;

                    if (amo_req_i.amo_op == AMO_SC) begin
                        amo_resp_o.result = 1'b0;

                        reservation_d.valid = 1'b0;
                    end
                end
            end
        endcase
    end

    always_comb begin

        mshr_addr_matches_o  = 'b0;
        mshr_index_matches_o = 'b0;

        for (int i = 0; i < NR_PORTS; i++) begin

            if (mshr_q.valid && mshr_addr_i[i][55:DCACHE_BYTE_OFFSET] == mshr_q.addr[55:DCACHE_BYTE_OFFSET]) begin
                mshr_addr_matches_o[i] = 1'b1;
            end

            if (mshr_q.valid && mshr_addr_i[i][DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET] == mshr_q.addr[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET]) begin
                mshr_index_matches_o[i] = 1'b1;
            end
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            mshr_q        <= '0;
            state_q       <= INIT;
            cnt_q         <= '0;
            evict_way_q   <= '0;
            evict_cl_q    <= '0;
            serve_amo_q   <= 1'b0;
            reservation_q <= '0;
        end else begin
            mshr_q        <= mshr_d;
            state_q       <= state_d;
            cnt_q         <= cnt_d;
            evict_way_q   <= evict_way_d;
            evict_cl_q    <= evict_cl_d;
            serve_amo_q   <= serve_amo_d;
            reservation_q <= reservation_d;
        end
    end

    logic                        req_fsm_bypass_valid;
    logic [63:0]                 req_fsm_bypass_addr;
    logic [63:0]                 req_fsm_bypass_wdata;
    logic                        req_fsm_bypass_we;
    logic [7:0]                  req_fsm_bypass_be;
    logic [1:0]                  req_fsm_bypass_size;
    logic                        gnt_bypass_fsm;
    logic                        valid_bypass_fsm;
    logic [63:0]                 data_bypass_fsm;
    logic [$clog2(NR_PORTS)-1:0] id_fsm_bypass;
    logic [3:0]                  id_bypass_fsm;
    logic [3:0]                  gnt_id_bypass_fsm;

    arbiter #(
        .NR_PORTS       ( NR_PORTS                                 ),
        .DATA_WIDTH     ( 64                                       )
    ) i_bypass_arbiter (

        .data_req_i     ( miss_req_valid & miss_req_bypass         ),
        .address_i      ( miss_req_addr                            ),
        .data_wdata_i   ( miss_req_wdata                           ),
        .data_we_i      ( miss_req_we                              ),
        .data_be_i      ( miss_req_be                              ),
        .data_size_i    ( miss_req_size                            ),
        .data_gnt_o     ( bypass_gnt_o                             ),
        .data_rvalid_o  ( bypass_valid_o                           ),
        .data_rdata_o   ( bypass_data_o                            ),

        .id_i           ( id_bypass_fsm[$clog2(NR_PORTS)-1:0]      ),
        .id_o           ( id_fsm_bypass                            ),
        .gnt_id_i       ( gnt_id_bypass_fsm[$clog2(NR_PORTS)-1:0]  ),
        .address_o      ( req_fsm_bypass_addr                      ),
        .data_wdata_o   ( req_fsm_bypass_wdata                     ),
        .data_req_o     ( req_fsm_bypass_valid                     ),
        .data_we_o      ( req_fsm_bypass_we                        ),
        .data_be_o      ( req_fsm_bypass_be                        ),
        .data_size_o    ( req_fsm_bypass_size                      ),
        .data_gnt_i     ( gnt_bypass_fsm                           ),
        .data_rvalid_i  ( valid_bypass_fsm                         ),
        .data_rdata_i   ( data_bypass_fsm                          ),
        .*
    );

    axi_adapter #(
        .DATA_WIDTH            ( 64                 ),
        .AXI_ID_WIDTH          ( 4                  ),
        .CACHELINE_BYTE_OFFSET ( DCACHE_BYTE_OFFSET )
    ) i_bypass_axi_adapter (
        .clk_i,
        .rst_ni,
        .req_i                 ( req_fsm_bypass_valid   ),
        .type_i                ( ariane_axi_pkg::SINGLE_REQ ),
        .gnt_o                 ( gnt_bypass_fsm         ),
        .addr_i                ( req_fsm_bypass_addr    ),
        .we_i                  ( req_fsm_bypass_we      ),
        .wdata_i               ( req_fsm_bypass_wdata   ),
        .be_i                  ( req_fsm_bypass_be      ),
        .size_i                ( req_fsm_bypass_size    ),
        .id_i                  ( {2'b10, id_fsm_bypass} ),
        .valid_o               ( valid_bypass_fsm       ),
        .rdata_o               ( data_bypass_fsm        ),
        .gnt_id_o              ( gnt_id_bypass_fsm      ),
        .id_o                  ( id_bypass_fsm          ),
        .critical_word_o       (                        ),
        .critical_word_valid_o (                        ),
        .axi_req_o             ( axi_bypass_o           ),
        .axi_resp_i            ( axi_bypass_i           )
    );

    axi_adapter  #(
        .DATA_WIDTH            ( DCACHE_LINE_WIDTH  ),
        .AXI_ID_WIDTH          ( 4                  ),
        .CACHELINE_BYTE_OFFSET ( DCACHE_BYTE_OFFSET )
    ) i_miss_axi_adapter (
        .clk_i,
        .rst_ni,
        .req_i               ( req_fsm_miss_valid ),
        .type_i              ( req_fsm_miss_req   ),
        .gnt_o               ( gnt_miss_fsm       ),
        .addr_i              ( req_fsm_miss_addr  ),
        .we_i                ( req_fsm_miss_we    ),
        .wdata_i             ( req_fsm_miss_wdata ),
        .be_i                ( req_fsm_miss_be    ),
        .size_i              ( req_fsm_miss_size  ),
        .id_i                ( 4'b1100            ),
        .gnt_id_o            (                    ),
        .valid_o             ( valid_miss_fsm     ),
        .rdata_o             ( data_miss_fsm      ),
        .id_o                (                    ),
        .critical_word_o,
        .critical_word_valid_o,
        .axi_req_o           ( axi_data_o         ),
        .axi_resp_i          ( axi_data_i         )
    );

    lfsr_8bit #(.WIDTH (DCACHE_SET_ASSOC)) i_lfsr (
        .en_i           ( lfsr_enable ),
        .refill_way_oh  ( lfsr_oh     ),
        .refill_way_bin ( lfsr_bin    ),
        .*
    );

    amo_alu i_amo_alu (
        .amo_op_i        ( amo_op        ),
        .amo_operand_a_i ( amo_operand_a ),
        .amo_operand_b_i ( amo_operand_b ),
        .amo_result_o    ( amo_result_o  )
    );

    always_comb begin
        automatic miss_req_t miss_req;

        for (int unsigned i = 0; i < NR_PORTS; i++) begin
            miss_req =  miss_req_t'(miss_req_i[i]);
            miss_req_valid  [i]  = miss_req.valid;
            miss_req_bypass [i]  = miss_req.bypass;
            miss_req_addr   [i]  = miss_req.addr;
            miss_req_wdata  [i]  = miss_req.wdata;
            miss_req_we     [i]  = miss_req.we;
            miss_req_be     [i]  = miss_req.be;
            miss_req_size   [i]  = miss_req.size;
        end
    end
endmodule



module tag_cmp #(
    parameter int unsigned NR_PORTS         = 3,
    parameter int unsigned ADDR_WIDTH       = 64,
    parameter type         l_data_t         = std_cache_pkg::cache_line_t,
    parameter type         l_be_t           = std_cache_pkg::cl_be_t,
    parameter int unsigned DCACHE_SET_ASSOC = 8
) (
    input logic clk_i,
    input logic rst_ni,

    input  logic    [        NR_PORTS-1:0][            DCACHE_SET_ASSOC-1:0] req_i,
    output logic    [        NR_PORTS-1:0]                                   gnt_o,
    input  logic    [        NR_PORTS-1:0][                  ADDR_WIDTH-1:0] addr_i,
    input  l_data_t [        NR_PORTS-1:0]                                   wdata_i,
    input  logic    [        NR_PORTS-1:0]                                   we_i,
    input  l_be_t   [        NR_PORTS-1:0]                                   be_i,
    output l_data_t [DCACHE_SET_ASSOC-1:0]                                   rdata_o,
    input  logic    [        NR_PORTS-1:0][ariane_pkg::DCACHE_TAG_WIDTH-1:0] tag_i,
    output logic    [DCACHE_SET_ASSOC-1:0]                                   hit_way_o,

    output logic    [DCACHE_SET_ASSOC-1:0] req_o,
    output logic    [      ADDR_WIDTH-1:0] addr_o,
    output l_data_t                        wdata_o,
    output logic                           we_o,
    output l_be_t                          be_o,
    input  l_data_t [DCACHE_SET_ASSOC-1:0] rdata_i
);

  assign rdata_o = rdata_i;

  logic [NR_PORTS-1:0] id_d, id_q;
  logic [ariane_pkg::DCACHE_TAG_WIDTH-1:0] sel_tag;

  always_comb begin : tag_sel
    sel_tag = '0;
    for (int unsigned i = 0; i < NR_PORTS; i++) if (id_q[i]) sel_tag = tag_i[i];
  end

  for (genvar j = 0; j < DCACHE_SET_ASSOC; j++) begin : tag_cmp
    assign hit_way_o[j] = (sel_tag == rdata_i[j].tag) ? rdata_i[j].valid : 1'b0;
  end

  always_comb begin

    gnt_o   = '0;
    id_d    = '0;
    wdata_o = '0;
    req_o   = '0;
    addr_o  = '0;
    be_o    = '0;
    we_o    = '0;

    for (int unsigned i = 0; i < NR_PORTS; i++) begin
      req_o    = req_i[i];
      id_d     = (1'b1 << i);
      gnt_o[i] = 1'b1;
      addr_o   = addr_i[i];
      be_o     = be_i[i];
      we_o     = we_i[i];
      wdata_o  = wdata_i[i];

      if (req_i[i]) break;
    end

  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      id_q <= 0;
    end else begin
      id_q <= id_d;
    end
  end

endmodule


import ariane_pkg::*;
import std_cache_pkg::*;
module std_nbdcache #(
    parameter logic [63:0] CACHE_START_ADDR = 64'h8000_0000
) (
    input logic clk_i,
    input logic rst_ni,

    input  logic enable_i,
    input  logic flush_i,
    output logic flush_ack_o,
    output logic miss_o,

    input  amo_req_t  amo_req_i,
    output amo_resp_t amo_resp_o,

    input  dcache_req_i_t [2:0] req_ports_i,
    output dcache_req_o_t [2:0] req_ports_o,

    output ariane_axi_pkg::m_req_t  axi_data_o,
    input  ariane_axi_pkg::m_resp_t axi_data_i,
    output ariane_axi_pkg::m_req_t  axi_bypass_o,
    input  ariane_axi_pkg::m_resp_t axi_bypass_i
);

  logic        [                   3:0][  DCACHE_SET_ASSOC-1:0] req;
  logic        [                   3:0][DCACHE_INDEX_WIDTH-1:0] addr;
  logic        [                   3:0]                         gnt;
  cache_line_t [  DCACHE_SET_ASSOC-1:0]                         rdata;
  logic        [                   3:0][  DCACHE_TAG_WIDTH-1:0] tag;

  cache_line_t [                   3:0]                         wdata;
  logic        [                   3:0]                         we;
  cl_be_t      [                   3:0]                         be;
  logic        [  DCACHE_SET_ASSOC-1:0]                         hit_way;

  logic        [                   2:0]                         busy;
  logic        [                   2:0][                  55:0] mshr_addr;
  logic        [                   2:0]                         mshr_addr_matches;
  logic        [                   2:0]                         mshr_index_matches;
  logic        [                  63:0]                         critical_word;
  logic                                                         critical_word_valid;

  logic        [                   2:0][ $bits(miss_req_t)-1:0] miss_req;
  logic        [                   2:0]                         miss_gnt;
  logic        [                   2:0]                         active_serving;

  logic        [                   2:0]                         bypass_gnt;
  logic        [                   2:0]                         bypass_valid;
  logic        [                   2:0][                  63:0] bypass_data;

  logic        [  DCACHE_SET_ASSOC-1:0]                         req_ram;
  logic        [DCACHE_INDEX_WIDTH-1:0]                         addr_ram;
  logic                                                         we_ram;
  cache_line_t                                                  wdata_ram;
  cache_line_t [  DCACHE_SET_ASSOC-1:0]                         rdata_ram;
  cl_be_t                                                       be_ram;

  generate
    for (genvar i = 0; i < 3; i++) begin : master_ports
      cache_ctrl #(
          .CACHE_START_ADDR(CACHE_START_ADDR)
      ) i_cache_ctrl (
          .bypass_i(~enable_i),
          .busy_o  (busy[i]),

          .req_port_i(req_ports_i[i]),
          .req_port_o(req_ports_o[i]),

          .req_o    (req[i+1]),
          .addr_o   (addr[i+1]),
          .gnt_i    (gnt[i+1]),
          .data_i   (rdata),
          .tag_o    (tag[i+1]),
          .data_o   (wdata[i+1]),
          .we_o     (we[i+1]),
          .be_o     (be[i+1]),
          .hit_way_i(hit_way),

          .miss_req_o           (miss_req[i]),
          .miss_gnt_i           (miss_gnt[i]),
          .active_serving_i     (active_serving[i]),
          .critical_word_i      (critical_word),
          .critical_word_valid_i(critical_word_valid),
          .bypass_gnt_i         (bypass_gnt[i]),
          .bypass_valid_i       (bypass_valid[i]),
          .bypass_data_i        (bypass_data[i]),

          .mshr_addr_o         (mshr_addr[i]),
          .mshr_addr_matches_i (mshr_addr_matches[i]),
          .mshr_index_matches_i(mshr_index_matches[i]),
          .*
      );
    end
  endgenerate

  miss_handler #(
      .NR_PORTS(3)
  ) i_miss_handler (
      .flush_i(flush_i),
      .busy_i (|busy),

      .amo_req_i            (amo_req_i),
      .amo_resp_o           (amo_resp_o),
      .miss_req_i           (miss_req),
      .miss_gnt_o           (miss_gnt),
      .bypass_gnt_o         (bypass_gnt),
      .bypass_valid_o       (bypass_valid),
      .bypass_data_o        (bypass_data),
      .critical_word_o      (critical_word),
      .critical_word_valid_o(critical_word_valid),
      .mshr_addr_i          (mshr_addr),
      .mshr_addr_matches_o  (mshr_addr_matches),
      .mshr_index_matches_o (mshr_index_matches),
      .active_serving_o     (active_serving),
      .req_o                (req[0]),
      .addr_o               (addr[0]),
      .data_i               (rdata),
      .be_o                 (be[0]),
      .data_o               (wdata[0]),
      .we_o                 (we[0]),
      .axi_bypass_o,
      .axi_bypass_i,
      .axi_data_o,
      .axi_data_i,
      .*
  );

  assign tag[0] = '0;

  for (genvar i = 0; i < DCACHE_SET_ASSOC; i++) begin : sram_block
    sram #(
        .DATA_WIDTH(DCACHE_LINE_WIDTH),
        .NUM_WORDS (DCACHE_NUM_WORDS)
    ) data_sram (
        .req_i  (req_ram[i]),
        .rst_ni (rst_ni),
        .we_i   (we_ram),
        .addr_i (addr_ram[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET]),
        .wdata_i(wdata_ram.data),
        .be_i   (be_ram.data),
        .rdata_o(rdata_ram[i].data),
        .*
    );

    sram #(
        .DATA_WIDTH(DCACHE_TAG_WIDTH),
        .NUM_WORDS (DCACHE_NUM_WORDS)
    ) tag_sram (
        .req_i  (req_ram[i]),
        .rst_ni (rst_ni),
        .we_i   (we_ram),
        .addr_i (addr_ram[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET]),
        .wdata_i(wdata_ram.tag),
        .be_i   (be_ram.tag),
        .rdata_o(rdata_ram[i].tag),
        .*
    );

  end

  logic [4*DCACHE_DIRTY_WIDTH-1:0] dirty_wdata, dirty_rdata;

  for (genvar i = 0; i < DCACHE_SET_ASSOC; i++) begin
    assign dirty_wdata[8*i]   = wdata_ram.dirty;
    assign dirty_wdata[8*i+1] = wdata_ram.valid;
    assign rdata_ram[i].dirty = dirty_rdata[8*i];
    assign rdata_ram[i].valid = dirty_rdata[8*i+1];
  end

  sram #(
      .DATA_WIDTH(4 * DCACHE_DIRTY_WIDTH),
      .NUM_WORDS (DCACHE_NUM_WORDS)
  ) valid_dirty_sram (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      .req_i  (|req_ram),
      .we_i   (we_ram),
      .addr_i (addr_ram[DCACHE_INDEX_WIDTH-1:DCACHE_BYTE_OFFSET]),
      .wdata_i(dirty_wdata),
      .be_i   (be_ram.vldrty),
      .rdata_o(dirty_rdata)
  );

  tag_cmp #(
      .NR_PORTS        (4),
      .ADDR_WIDTH      (DCACHE_INDEX_WIDTH),
      .DCACHE_SET_ASSOC(DCACHE_SET_ASSOC)
  ) i_tag_cmp (
      .req_i    (req),
      .gnt_o    (gnt),
      .addr_i   (addr),
      .wdata_i  (wdata),
      .we_i     (we),
      .be_i     (be),
      .rdata_o  (rdata),
      .tag_i    (tag),
      .hit_way_o(hit_way),

      .req_o  (req_ram),
      .addr_o (addr_ram),
      .wdata_o(wdata_ram),
      .we_o   (we_ram),
      .be_o   (be_ram),
      .rdata_i(rdata_ram),
      .*
  );

  initial begin
    assert ($bits(axi_data_o.aw.addr) == 64)
    else $fatal(1, "Ariane needs a 64-bit bus");
    assert (DCACHE_LINE_WIDTH / 64 inside {2, 4, 8, 16})
    else $fatal(1, "Cache line size needs to be a power of two multiple of 64");
  end

endmodule


module stream_arbiter_flushable #(
    parameter type    DATA_T  = logic,
    parameter integer N_INP   = -1,
    parameter         ARBITER = "rr"
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,

    input  DATA_T [N_INP-1:0] inp_data_i,
    input  logic  [N_INP-1:0] inp_valid_i,
    output logic  [N_INP-1:0] inp_ready_o,

    output DATA_T oup_data_o,
    output logic  oup_valid_o,
    input  logic  oup_ready_i
);

  if (ARBITER == "rr") begin : gen_rr_arb
    rr_arb_tree #(
        .NumIn    (N_INP),
        .DataType (DATA_T),
        .ExtPrio  (1'b0),
        .AxiVldRdy(1'b1),
        .LockIn   (1'b1)
    ) i_arbiter (
        .clk_i,
        .rst_ni,
        .flush_i,
        .rr_i  ('0),
        .req_i (inp_valid_i),
        .gnt_o (inp_ready_o),
        .data_i(inp_data_i),
        .gnt_i (oup_ready_i),
        .req_o (oup_valid_o),
        .data_o(oup_data_o),
        .idx_o ()
    );

  end else if (ARBITER == "prio") begin : gen_prio_arb
    rr_arb_tree #(
        .NumIn    (N_INP),
        .DataType (DATA_T),
        .ExtPrio  (1'b1),
        .AxiVldRdy(1'b1),
        .LockIn   (1'b0)
    ) i_arbiter (
        .clk_i,
        .rst_ni,
        .flush_i,
        .rr_i  ('0),
        .req_i (inp_valid_i),
        .gnt_o (inp_ready_o),
        .data_i(inp_data_i),
        .gnt_i (oup_ready_i),
        .req_o (oup_valid_o),
        .data_o(oup_data_o),
        .idx_o ()
    );

  end else begin : gen_arb_error
`ifndef SYNTHESIS
    $fatal(1, "Invalid value for parameter 'ARBITER'!");
`endif
  end

endmodule


module stream_arbiter #(
    parameter type    DATA_T  = logic,
    parameter integer N_INP   = -1,
    parameter         ARBITER = "rr"
) (
    input logic clk_i,
    input logic rst_ni,

    input  DATA_T [N_INP-1:0] inp_data_i,
    input  logic  [N_INP-1:0] inp_valid_i,
    output logic  [N_INP-1:0] inp_ready_o,

    output DATA_T oup_data_o,
    output logic  oup_valid_o,
    input  logic  oup_ready_i
);

  stream_arbiter_flushable #(
      .DATA_T (DATA_T),
      .N_INP  (N_INP),
      .ARBITER(ARBITER)
  ) i_arb (
      .clk_i      (clk_i),
      .rst_ni     (rst_ni),
      .flush_i    (1'b0),
      .inp_data_i (inp_data_i),
      .inp_valid_i(inp_valid_i),
      .inp_ready_o(inp_ready_o),
      .oup_data_o (oup_data_o),
      .oup_valid_o(oup_valid_o),
      .oup_ready_i(oup_ready_i)
  );

endmodule


module stream_mux #(
  parameter type DATA_T = logic,
  parameter integer N_INP = 0,

  parameter integer LOG_N_INP = $clog2(N_INP)
) (
  input  DATA_T [N_INP-1:0]     inp_data_i,
  input  logic  [N_INP-1:0]     inp_valid_i,
  output logic  [N_INP-1:0]     inp_ready_o,

  input  logic  [LOG_N_INP-1:0] inp_sel_i,

  output DATA_T                 oup_data_o,
  output logic                  oup_valid_o,
  input  logic                  oup_ready_i
);

  always_comb begin
    inp_ready_o = '0;
    inp_ready_o[inp_sel_i] = oup_ready_i;
  end
  assign oup_data_o   = inp_data_i[inp_sel_i];
  assign oup_valid_o  = inp_valid_i[inp_sel_i];

endmodule


module stream_demux #(

    parameter int unsigned N_OUP = 32'd1,

    parameter int unsigned LOG_N_OUP = (N_OUP > 32'd1) ? unsigned'($clog2(N_OUP)) : 1'b1
) (
    input  logic inp_valid_i,
    output logic inp_ready_o,

    input logic [LOG_N_OUP-1:0] oup_sel_i,

    output logic [N_OUP-1:0] oup_valid_o,
    input  logic [N_OUP-1:0] oup_ready_i
);

  always_comb begin
    oup_valid_o = '0;
    oup_valid_o[oup_sel_i] = inp_valid_i;
  end
  assign inp_ready_o = oup_ready_i[oup_sel_i];

endmodule


import ariane_pkg::*;
import std_cache_pkg::*;
module std_cache_subsystem #(
    parameter logic [63:0] CACHE_START_ADDR = 64'h4000_0000
) (
    input logic                 clk_i,
    input logic                 rst_ni,
    input riscv_pkg::priv_lvl_t priv_lvl_i,

    input  logic icache_en_i,
    input  logic icache_flush_i,
    output logic icache_miss_o,

    input  icache_areq_i_t icache_areq_i,
    output icache_areq_o_t icache_areq_o,

    input  icache_dreq_i_t icache_dreq_i,
    output icache_dreq_o_t icache_dreq_o,

    input  amo_req_t  amo_req_i,
    output amo_resp_t amo_resp_o,

    input  logic dcache_enable_i,
    input  logic dcache_flush_i,
    output logic dcache_flush_ack_o,
    output logic dcache_miss_o,
    output logic wbuffer_empty_o,

    input  dcache_req_i_t [2:0] dcache_req_ports_i,
    output dcache_req_o_t [2:0] dcache_req_ports_o,

    output ariane_axi_pkg::m_req_t  axi_req_o,
    input  ariane_axi_pkg::m_resp_t axi_resp_i
);

  assign wbuffer_empty_o = 1'b1;

  ariane_axi_pkg::m_req_t  axi_req_icache;
  ariane_axi_pkg::m_resp_t axi_resp_icache;
  ariane_axi_pkg::m_req_t  axi_req_bypass;
  ariane_axi_pkg::m_resp_t axi_resp_bypass;
  ariane_axi_pkg::m_req_t  axi_req_data;
  ariane_axi_pkg::m_resp_t axi_resp_data;

  std_icache i_icache (
      .clk_i     (clk_i),
      .rst_ni    (rst_ni),
      .priv_lvl_i(priv_lvl_i),
      .flush_i   (icache_flush_i),
      .en_i      (icache_en_i),
      .miss_o    (icache_miss_o),
      .areq_i    (icache_areq_i),
      .areq_o    (icache_areq_o),
      .dreq_i    (icache_dreq_i),
      .dreq_o    (icache_dreq_o),
      .axi_req_o (axi_req_icache),
      .axi_resp_i(axi_resp_icache)
  );

  std_nbdcache #(
      .CACHE_START_ADDR(CACHE_START_ADDR)
  ) i_nbdcache (
      .clk_i,
      .rst_ni,
      .enable_i    (dcache_enable_i),
      .flush_i     (dcache_flush_i),
      .flush_ack_o (dcache_flush_ack_o),
      .miss_o      (dcache_miss_o),
      .axi_bypass_o(axi_req_bypass),
      .axi_bypass_i(axi_resp_bypass),
      .axi_data_o  (axi_req_data),
      .axi_data_i  (axi_resp_data),
      .req_ports_i (dcache_req_ports_i),
      .req_ports_o (dcache_req_ports_o),
      .amo_req_i,
      .amo_resp_o
  );

  logic [1:0] w_select, w_select_fifo, w_select_arbiter;
  logic w_fifo_empty;

  stream_arbiter #(
      .DATA_T(ariane_axi_pkg::m_ar_chan_t),
      .N_INP (3)
  ) i_stream_arbiter_ar (
      .clk_i,
      .rst_ni,
      .inp_data_i ({axi_req_icache.ar, axi_req_bypass.ar, axi_req_data.ar}),
      .inp_valid_i({axi_req_icache.ar_valid, axi_req_bypass.ar_valid, axi_req_data.ar_valid}),
      .inp_ready_o({axi_resp_icache.ar_ready, axi_resp_bypass.ar_ready, axi_resp_data.ar_ready}),
      .oup_data_o (axi_req_o.ar),
      .oup_valid_o(axi_req_o.ar_valid),
      .oup_ready_i(axi_resp_i.ar_ready)
  );

  stream_arbiter #(
      .DATA_T(ariane_axi_pkg::m_aw_chan_t),
      .N_INP (3)
  ) i_stream_arbiter_aw (
      .clk_i,
      .rst_ni,
      .inp_data_i ({axi_req_icache.aw, axi_req_bypass.aw, axi_req_data.aw}),
      .inp_valid_i({axi_req_icache.aw_valid, axi_req_bypass.aw_valid, axi_req_data.aw_valid}),
      .inp_ready_o({axi_resp_icache.aw_ready, axi_resp_bypass.aw_ready, axi_resp_data.aw_ready}),
      .oup_data_o (axi_req_o.aw),
      .oup_valid_o(axi_req_o.aw_valid),
      .oup_ready_i(axi_resp_i.aw_ready)
  );

  always_comb begin
    w_select = 0;
    unique case (axi_req_o.aw.id)
      4'b1100:                            w_select = 2;
      4'b1000, 4'b1001, 4'b1010, 4'b1011: w_select = 1;
      default:                            w_select = 0;
    endcase
  end

  fifo_v3 #(
      .DATA_WIDTH(2),

      .DEPTH(4)
  ) i_fifo_w_channel (
      .clk_i     (clk_i),
      .rst_ni    (rst_ni),
      .flush_i   (1'b0),
      .testmode_i(1'b0),
      .full_o    (),
      .empty_o   (w_fifo_empty),
      .usage_o   (),
      .data_i    (w_select),

      .push_i(axi_req_o.aw_valid & axi_resp_i.aw_ready),

      .data_o(w_select_fifo),

      .pop_i(axi_req_o.w_valid & axi_resp_i.w_ready & axi_req_o.w.last)
  );

  assign w_select_arbiter = (w_fifo_empty) ? 0 : w_select_fifo;

  stream_mux #(
      .DATA_T(ariane_axi_pkg::m_w_chan_t),
      .N_INP (3)
  ) i_stream_mux_w (
      .inp_data_i ({axi_req_data.w, axi_req_bypass.w, axi_req_icache.w}),
      .inp_valid_i({axi_req_data.w_valid, axi_req_bypass.w_valid, axi_req_icache.w_valid}),
      .inp_ready_o({axi_resp_data.w_ready, axi_resp_bypass.w_ready, axi_resp_icache.w_ready}),
      .inp_sel_i  (w_select_arbiter),
      .oup_data_o (axi_req_o.w),
      .oup_valid_o(axi_req_o.w_valid),
      .oup_ready_i(axi_resp_i.w_ready)
  );

  assign axi_resp_icache.r = axi_resp_i.r;
  assign axi_resp_bypass.r = axi_resp_i.r;
  assign axi_resp_data.r   = axi_resp_i.r;

  logic [1:0] r_select;

  always_comb begin
    r_select = 0;
    unique case (axi_resp_i.r.id)
      4'b1100:                            r_select = 0;
      4'b1000, 4'b1001, 4'b1010, 4'b1011: r_select = 1;
      4'b0000:                            r_select = 2;
      default:                            r_select = 0;
    endcase
  end

  stream_demux #(
      .N_OUP(3)
  ) i_stream_demux_r (
      .inp_valid_i(axi_resp_i.r_valid),
      .inp_ready_o(axi_req_o.r_ready),
      .oup_sel_i  (r_select),
      .oup_valid_o({axi_resp_icache.r_valid, axi_resp_bypass.r_valid, axi_resp_data.r_valid}),
      .oup_ready_i({axi_req_icache.r_ready, axi_req_bypass.r_ready, axi_req_data.r_ready})
  );

  logic [1:0] b_select;

  assign axi_resp_icache.b = axi_resp_i.b;
  assign axi_resp_bypass.b = axi_resp_i.b;
  assign axi_resp_data.b   = axi_resp_i.b;

  always_comb begin
    b_select = 0;
    unique case (axi_resp_i.b.id)
      4'b1100:                            b_select = 0;
      4'b1000, 4'b1001, 4'b1010, 4'b1011: b_select = 1;
      4'b0000:                            b_select = 2;
      default:                            b_select = 0;
    endcase
  end

  stream_demux #(
      .N_OUP(3)
  ) i_stream_demux_b (
      .inp_valid_i(axi_resp_i.b_valid),
      .inp_ready_o(axi_req_o.b_ready),
      .oup_sel_i  (b_select),
      .oup_valid_o({axi_resp_icache.b_valid, axi_resp_bypass.b_valid, axi_resp_data.b_valid}),
      .oup_ready_i({axi_req_icache.b_ready, axi_req_bypass.b_ready, axi_req_data.b_ready})
  );

endmodule


import ariane_pkg::*;
module ariane #(
    parameter logic [63:0] DmBaseAddress = 64'h0,
    parameter logic [63:0] CachedAddrBeg = 64'h00_8000_0000
) (
    input logic clk_i,
    input logic rst_ni,

    input logic [63:0] boot_addr_i,
    input logic [63:0] hart_id_i,

    input logic [1:0] irq_i,
    input logic       ipi_i,

    input logic time_irq_i,
    input logic debug_req_i,

    output ariane_axi_pkg::m_req_t  axi_req_o,
    input  ariane_axi_pkg::m_resp_t axi_resp_i
);

  riscv_pkg::priv_lvl_t                             priv_lvl;
  exception_t                                       ex_commit;
  branchpredict_t                                   resolved_branch;
  logic                 [               63:0]       pc_commit;
  logic                                             eret;
  logic                 [NR_COMMIT_PORTS-1:0]       commit_ack;

  logic                 [               63:0]       trap_vector_base_commit_pcgen;
  logic                 [               63:0]       epc_commit_pcgen;

  frontend_fetch_t                                  fetch_entry_if_id;
  logic                                             fetch_valid_if_id;
  logic                                             decode_ack_id_if;

  scoreboard_entry_t                                issue_entry_id_issue;
  logic                                             issue_entry_valid_id_issue;
  logic                                             is_ctrl_fow_id_issue;
  logic                                             issue_instr_issue_id;

  fu_data_t                                         fu_data_id_ex;
  logic                 [               63:0]       pc_id_ex;
  logic                                             is_compressed_instr_id_ex;

  logic                                             flu_ready_ex_id;
  logic                 [  TRANS_ID_BITS-1:0]       flu_trans_id_ex_id;
  logic                                             flu_valid_ex_id;
  logic                 [               63:0]       flu_result_ex_id;
  exception_t                                       flu_exception_ex_id;

  logic                                             alu_valid_id_ex;

  logic                                             branch_valid_id_ex;

  branchpredict_sbe_t                               branch_predict_id_ex;
  logic                                             resolve_branch_ex_id;

  logic                                             lsu_valid_id_ex;
  logic                                             lsu_ready_ex_id;

  logic                 [  TRANS_ID_BITS-1:0]       load_trans_id_ex_id;
  logic                 [               63:0]       load_result_ex_id;
  logic                                             load_valid_ex_id;
  exception_t                                       load_exception_ex_id;

  logic                 [               63:0]       store_result_ex_id;
  logic                 [  TRANS_ID_BITS-1:0]       store_trans_id_ex_id;
  logic                                             store_valid_ex_id;
  exception_t                                       store_exception_ex_id;

  logic                                             mult_valid_id_ex;

  logic                                             fpu_ready_ex_id;
  logic                                             fpu_valid_id_ex;
  logic                 [                1:0]       fpu_fmt_id_ex;
  logic                 [                2:0]       fpu_rm_id_ex;
  logic                 [  TRANS_ID_BITS-1:0]       fpu_trans_id_ex_id;
  logic                 [               63:0]       fpu_result_ex_id;
  logic                                             fpu_valid_ex_id;
  exception_t                                       fpu_exception_ex_id;

  logic                                             csr_valid_id_ex;

  logic                                             csr_commit_commit_ex;
  logic                                             dirty_fp_state;

  logic                                             lsu_commit_commit_ex;
  logic                                             lsu_commit_ready_ex_commit;
  logic                                             no_st_pending_ex;
  logic                                             no_st_pending_commit;
  logic                                             amo_valid_commit;

  scoreboard_entry_t    [NR_COMMIT_PORTS-1:0]       commit_instr_id_commit;

  logic                 [NR_COMMIT_PORTS-1:0][ 4:0] waddr_commit_id;
  logic                 [NR_COMMIT_PORTS-1:0][63:0] wdata_commit_id;
  logic                 [NR_COMMIT_PORTS-1:0]       we_gpr_commit_id;
  logic                 [NR_COMMIT_PORTS-1:0]       we_fpr_commit_id;

  logic                 [                4:0]       fflags_csr_commit;
  riscv_pkg::xs_t                                   fs;
  logic                 [                2:0]       frm_csr_id_issue_ex;
  logic                 [                6:0]       fprec_csr_ex;
  logic                                             enable_translation_csr_ex;
  logic                                             en_ld_st_translation_csr_ex;
  riscv_pkg::priv_lvl_t                             ld_st_priv_lvl_csr_ex;
  logic                                             sum_csr_ex;
  logic                                             mxr_csr_ex;
  logic                 [               43:0]       satp_ppn_csr_ex;
  logic                 [                0:0]       asid_csr_ex;
  logic                 [               11:0]       csr_addr_ex_csr;
  fu_op                                             csr_op_commit_csr;
  logic                 [               63:0]       csr_wdata_commit_csr;
  logic                 [               63:0]       csr_rdata_csr_commit;
  exception_t                                       csr_exception_csr_commit;
  logic                                             tvm_csr_id;
  logic                                             tw_csr_id;
  logic                                             tsr_csr_id;
  logic                                             dcache_en_csr_nbdcache;
  logic                                             csr_write_fflags_commit_cs;
  logic                                             icache_en_csr;
  logic                                             debug_mode;
  logic                                             single_step_csr_commit;

  logic                 [                4:0]       addr_csr_perf;
  logic [63:0] data_csr_perf, data_perf_csr;
  logic           we_csr_perf;

  logic           icache_flush_ctrl_cache;
  logic           itlb_miss_ex_perf;
  logic           dtlb_miss_ex_perf;
  logic           dcache_miss_cache_perf;
  logic           icache_miss_cache_perf;

  logic           set_pc_ctrl_pcgen;
  logic           flush_csr_ctrl;
  logic           flush_unissued_instr_ctrl_id;
  logic           flush_ctrl_if;
  logic           flush_ctrl_id;
  logic           flush_ctrl_ex;
  logic           flush_tlb_ctrl_ex;
  logic           fence_i_commit_controller;
  logic           fence_commit_controller;
  logic           sfence_vma_commit_controller;
  logic           halt_ctrl;
  logic           halt_csr_ctrl;
  logic           dcache_flush_ctrl_cache;
  logic           dcache_flush_ack_cache_ctrl;
  logic           set_debug_pc;
  logic           flush_commit;

  icache_areq_i_t icache_areq_ex_cache;
  icache_areq_o_t icache_areq_cache_ex;
  icache_dreq_i_t icache_dreq_if_cache;
  icache_dreq_o_t icache_dreq_cache_if;

  amo_req_t       amo_req;
  amo_resp_t      amo_resp;
  logic           sb_full;

  logic           debug_req;

  assign debug_req = debug_req_i & ~amo_valid_commit;

  dcache_req_i_t [2:0] dcache_req_ports_ex_cache;
  dcache_req_o_t [2:0] dcache_req_ports_cache_ex;
  logic                dcache_commit_wbuffer_empty;

  frontend #(
      .DmBaseAddress(DmBaseAddress)
  ) i_frontend (
      .flush_i            (flush_ctrl_if),
      .flush_bp_i         (1'b0),
      .debug_mode_i       (debug_mode),
      .boot_addr_i        (boot_addr_i),
      .icache_dreq_i      (icache_dreq_cache_if),
      .icache_dreq_o      (icache_dreq_if_cache),
      .resolved_branch_i  (resolved_branch),
      .pc_commit_i        (pc_commit),
      .set_pc_commit_i    (set_pc_ctrl_pcgen),
      .set_debug_pc_i     (set_debug_pc),
      .epc_i              (epc_commit_pcgen),
      .eret_i             (eret),
      .trap_vector_base_i (trap_vector_base_commit_pcgen),
      .ex_valid_i         (ex_commit.valid),
      .fetch_entry_o      (fetch_entry_if_id),
      .fetch_entry_valid_o(fetch_valid_if_id),
      .fetch_ack_i        (decode_ack_id_if),
      .*
  );

  id_stage id_stage_i (
      .flush_i(flush_ctrl_if),

      .fetch_entry_i      (fetch_entry_if_id),
      .fetch_entry_valid_i(fetch_valid_if_id),
      .decoded_instr_ack_o(decode_ack_id_if),

      .issue_entry_o      (issue_entry_id_issue),
      .issue_entry_valid_o(issue_entry_valid_id_issue),
      .is_ctrl_flow_o     (is_ctrl_fow_id_issue),
      .issue_instr_ack_i  (issue_instr_issue_id),

      .priv_lvl_i  (priv_lvl),
      .fs_i        (fs),
      .frm_i       (frm_csr_id_issue_ex),
      .debug_mode_i(debug_mode),
      .tvm_i       (tvm_csr_id),
      .tw_i        (tw_csr_id),
      .tsr_i       (tsr_csr_id),
      .*
  );

  issue_stage #(
      .NR_ENTRIES (NR_SB_ENTRIES),
      .NR_WB_PORTS(NR_WB_PORTS)
  ) issue_stage_i (
      .clk_i,
      .rst_ni,
      .sb_full_o(sb_full),
      .flush_unissued_instr_i(flush_unissued_instr_ctrl_id),
      .flush_i(flush_ctrl_id),

      .decoded_instr_i(issue_entry_id_issue),
      .decoded_instr_valid_i(issue_entry_valid_id_issue),
      .is_ctrl_flow_i(is_ctrl_fow_id_issue),
      .decoded_instr_ack_o(issue_instr_issue_id),

      .fu_data_o(fu_data_id_ex),
      .pc_o(pc_id_ex),
      .is_compressed_instr_o(is_compressed_instr_id_ex),

      .flu_ready_i(flu_ready_ex_id),

      .alu_valid_o(alu_valid_id_ex),

      .branch_valid_o  (branch_valid_id_ex),
      .branch_predict_o(branch_predict_id_ex),
      .resolve_branch_i(resolve_branch_ex_id),

      .lsu_ready_i(lsu_ready_ex_id),
      .lsu_valid_o(lsu_valid_id_ex),

      .mult_valid_o(mult_valid_id_ex),

      .fpu_ready_i(fpu_ready_ex_id),
      .fpu_valid_o(fpu_valid_id_ex),
      .fpu_fmt_o(fpu_fmt_id_ex),
      .fpu_rm_o(fpu_rm_id_ex),

      .csr_valid_o(csr_valid_id_ex),

      .resolved_branch_i(resolved_branch),
      .trans_id_i({
        flu_trans_id_ex_id, load_trans_id_ex_id, store_trans_id_ex_id, fpu_trans_id_ex_id
      }),
      .wbdata_i({flu_result_ex_id, load_result_ex_id, store_result_ex_id, fpu_result_ex_id}),
      .ex_ex_i({
        flu_exception_ex_id, load_exception_ex_id, store_exception_ex_id, fpu_exception_ex_id
      }),
      .wb_valid_i({flu_valid_ex_id, load_valid_ex_id, store_valid_ex_id, fpu_valid_ex_id}),

      .waddr_i       (waddr_commit_id),
      .wdata_i       (wdata_commit_id),
      .we_gpr_i      (we_gpr_commit_id),
      .we_fpr_i      (we_fpr_commit_id),
      .commit_instr_o(commit_instr_id_commit),
      .commit_ack_i  (commit_ack),
      .*
  );

  ex_stage ex_stage_i (
      .clk_i                (clk_i),
      .rst_ni               (rst_ni),
      .flush_i              (flush_ctrl_ex),
      .fu_data_i            (fu_data_id_ex),
      .pc_i                 (pc_id_ex),
      .is_compressed_instr_i(is_compressed_instr_id_ex),

      .flu_result_o   (flu_result_ex_id),
      .flu_trans_id_o (flu_trans_id_ex_id),
      .flu_valid_o    (flu_valid_ex_id),
      .flu_exception_o(flu_exception_ex_id),
      .flu_ready_o    (flu_ready_ex_id),

      .alu_valid_i(alu_valid_id_ex),

      .branch_valid_i   (branch_valid_id_ex),
      .branch_predict_i (branch_predict_id_ex),
      .resolved_branch_o(resolved_branch),
      .resolve_branch_o (resolve_branch_ex_id),

      .csr_valid_i (csr_valid_id_ex),
      .csr_addr_o  (csr_addr_ex_csr),
      .csr_commit_i(csr_commit_commit_ex),

      .mult_valid_i(mult_valid_id_ex),

      .lsu_ready_o(lsu_ready_ex_id),
      .lsu_valid_i(lsu_valid_id_ex),

      .load_result_o   (load_result_ex_id),
      .load_trans_id_o (load_trans_id_ex_id),
      .load_valid_o    (load_valid_ex_id),
      .load_exception_o(load_exception_ex_id),

      .store_result_o   (store_result_ex_id),
      .store_trans_id_o (store_trans_id_ex_id),
      .store_valid_o    (store_valid_ex_id),
      .store_exception_o(store_exception_ex_id),

      .lsu_commit_i      (lsu_commit_commit_ex),
      .lsu_commit_ready_o(lsu_commit_ready_ex_commit),
      .no_st_pending_o   (no_st_pending_ex),

      .fpu_ready_o       (fpu_ready_ex_id),
      .fpu_valid_i       (fpu_valid_id_ex),
      .fpu_fmt_i         (fpu_fmt_id_ex),
      .fpu_rm_i          (fpu_rm_id_ex),
      .fpu_frm_i         (frm_csr_id_issue_ex),
      .fpu_prec_i        (fprec_csr_ex),
      .fpu_trans_id_o    (fpu_trans_id_ex_id),
      .fpu_result_o      (fpu_result_ex_id),
      .fpu_valid_o       (fpu_valid_ex_id),
      .fpu_exception_o   (fpu_exception_ex_id),
      .amo_valid_commit_i(amo_valid_commit),
      .amo_req_o         (amo_req),
      .amo_resp_i        (amo_resp),

      .itlb_miss_o(itlb_miss_ex_perf),
      .dtlb_miss_o(dtlb_miss_ex_perf),

      .enable_translation_i  (enable_translation_csr_ex),
      .en_ld_st_translation_i(en_ld_st_translation_csr_ex),
      .flush_tlb_i           (flush_tlb_ctrl_ex),
      .priv_lvl_i            (priv_lvl),
      .ld_st_priv_lvl_i      (ld_st_priv_lvl_csr_ex),
      .sum_i                 (sum_csr_ex),
      .mxr_i                 (mxr_csr_ex),
      .satp_ppn_i            (satp_ppn_csr_ex),
      .asid_i                (asid_csr_ex),
      .icache_areq_i         (icache_areq_cache_ex),
      .icache_areq_o         (icache_areq_ex_cache),

      .dcache_req_ports_i(dcache_req_ports_cache_ex),
      .dcache_req_ports_o(dcache_req_ports_ex_cache)
  );

  assign no_st_pending_commit = no_st_pending_ex & dcache_commit_wbuffer_empty;

  commit_stage commit_stage_i (
      .clk_i,
      .rst_ni,
      .halt_i            (halt_ctrl),
      .flush_dcache_i    (dcache_flush_ctrl_cache),
      .exception_o       (ex_commit),
      .dirty_fp_state_o  (dirty_fp_state),
      .debug_mode_i      (debug_mode),
      .debug_req_i       (debug_req),
      .single_step_i     (single_step_csr_commit),
      .commit_instr_i    (commit_instr_id_commit),
      .commit_ack_o      (commit_ack),
      .no_st_pending_i   (no_st_pending_commit),
      .waddr_o           (waddr_commit_id),
      .wdata_o           (wdata_commit_id),
      .we_gpr_o          (we_gpr_commit_id),
      .we_fpr_o          (we_fpr_commit_id),
      .commit_lsu_o      (lsu_commit_commit_ex),
      .commit_lsu_ready_i(lsu_commit_ready_ex_commit),
      .amo_valid_commit_o(amo_valid_commit),
      .amo_resp_i        (amo_resp),
      .commit_csr_o      (csr_commit_commit_ex),
      .pc_o              (pc_commit),
      .csr_op_o          (csr_op_commit_csr),
      .csr_wdata_o       (csr_wdata_commit_csr),
      .csr_rdata_i       (csr_rdata_csr_commit),
      .csr_write_fflags_o(csr_write_fflags_commit_cs),
      .csr_exception_i   (csr_exception_csr_commit),
      .fence_i_o         (fence_i_commit_controller),
      .fence_o           (fence_commit_controller),
      .sfence_vma_o      (sfence_vma_commit_controller),
      .flush_commit_o    (flush_commit),
      .*
  );

  csr_regfile #(
      .AsidWidth    (ASID_WIDTH),
      .DmBaseAddress(DmBaseAddress)
  ) csr_regfile_i (
      .flush_o               (flush_csr_ctrl),
      .halt_csr_o            (halt_csr_ctrl),
      .commit_instr_i        (commit_instr_id_commit),
      .commit_ack_i          (commit_ack),
      .ex_i                  (ex_commit),
      .csr_op_i              (csr_op_commit_csr),
      .csr_write_fflags_i    (csr_write_fflags_commit_cs),
      .dirty_fp_state_i      (dirty_fp_state),
      .csr_addr_i            (csr_addr_ex_csr),
      .csr_wdata_i           (csr_wdata_commit_csr),
      .csr_rdata_o           (csr_rdata_csr_commit),
      .pc_i                  (pc_commit),
      .csr_exception_o       (csr_exception_csr_commit),
      .epc_o                 (epc_commit_pcgen),
      .eret_o                (eret),
      .set_debug_pc_o        (set_debug_pc),
      .trap_vector_base_o    (trap_vector_base_commit_pcgen),
      .priv_lvl_o            (priv_lvl),
      .fs_o                  (fs),
      .fflags_o              (fflags_csr_commit),
      .frm_o                 (frm_csr_id_issue_ex),
      .fprec_o               (fprec_csr_ex),
      .ld_st_priv_lvl_o      (ld_st_priv_lvl_csr_ex),
      .en_translation_o      (enable_translation_csr_ex),
      .en_ld_st_translation_o(en_ld_st_translation_csr_ex),
      .sum_o                 (sum_csr_ex),
      .mxr_o                 (mxr_csr_ex),
      .satp_ppn_o            (satp_ppn_csr_ex),
      .asid_o                (asid_csr_ex),
      .tvm_o                 (tvm_csr_id),
      .tw_o                  (tw_csr_id),
      .tsr_o                 (tsr_csr_id),
      .debug_mode_o          (debug_mode),
      .single_step_o         (single_step_csr_commit),
      .dcache_en_o           (dcache_en_csr_nbdcache),
      .icache_en_o           (icache_en_csr),
      .perf_addr_o           (addr_csr_perf),
      .perf_data_o           (data_csr_perf),
      .perf_data_i           (data_perf_csr),
      .perf_we_o             (we_csr_perf),
      .debug_req_i           (debug_req),
      .ipi_i,
      .irq_i,
      .time_irq_i,
      .*
  );

  perf_counters i_perf_counters (
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .debug_mode_i  (debug_mode),
      .addr_i        (addr_csr_perf),
      .we_i          (we_csr_perf),
      .data_i        (data_csr_perf),
      .data_o        (data_perf_csr),
      .commit_instr_i(commit_instr_id_commit),
      .commit_ack_i  (commit_ack),

      .l1_icache_miss_i (icache_miss_cache_perf),
      .l1_dcache_miss_i (dcache_miss_cache_perf),
      .itlb_miss_i      (itlb_miss_ex_perf),
      .dtlb_miss_i      (dtlb_miss_ex_perf),
      .sb_full_i        (sb_full),
      .if_empty_i       (~fetch_valid_if_id),
      .ex_i             (ex_commit),
      .eret_i           (eret),
      .resolved_branch_i(resolved_branch)
  );

  controller controller_i (

      .set_pc_commit_o       (set_pc_ctrl_pcgen),
      .flush_unissued_instr_o(flush_unissued_instr_ctrl_id),
      .flush_if_o            (flush_ctrl_if),
      .flush_id_o            (flush_ctrl_id),
      .flush_ex_o            (flush_ctrl_ex),
      .flush_tlb_o           (flush_tlb_ctrl_ex),
      .flush_dcache_o        (dcache_flush_ctrl_cache),
      .flush_dcache_ack_i    (dcache_flush_ack_cache_ctrl),

      .halt_csr_i(halt_csr_ctrl),
      .halt_o    (halt_ctrl),

      .eret_i           (eret),
      .ex_valid_i       (ex_commit.valid),
      .set_debug_pc_i   (set_debug_pc),
      .flush_csr_i      (flush_csr_ctrl),
      .resolved_branch_i(resolved_branch),
      .fence_i_i        (fence_i_commit_controller),
      .fence_i          (fence_commit_controller),
      .sfence_vma_i     (sfence_vma_commit_controller),
      .flush_commit_i   (flush_commit),

      .flush_icache_o(icache_flush_ctrl_cache),
      .*
  );

  std_cache_subsystem #(
      .CACHE_START_ADDR(CachedAddrBeg)
  ) i_cache_subsystem (

      .clk_i     (clk_i),
      .rst_ni    (rst_ni),
      .priv_lvl_i(priv_lvl),

      .icache_en_i   (icache_en_csr),
      .icache_flush_i(icache_flush_ctrl_cache),
      .icache_miss_o (icache_miss_cache_perf),
      .icache_areq_i (icache_areq_ex_cache),
      .icache_areq_o (icache_areq_cache_ex),
      .icache_dreq_i (icache_dreq_if_cache),
      .icache_dreq_o (icache_dreq_cache_if),

      .dcache_enable_i   (dcache_en_csr_nbdcache),
      .dcache_flush_i    (dcache_flush_ctrl_cache),
      .dcache_flush_ack_o(dcache_flush_ack_cache_ctrl),

      .amo_req_i    (amo_req),
      .amo_resp_o   (amo_resp),
      .dcache_miss_o(dcache_miss_cache_perf),

      .wbuffer_empty_o(dcache_commit_wbuffer_empty),

      .dcache_req_ports_i(dcache_req_ports_ex_cache),
      .dcache_req_ports_o(dcache_req_ports_cache_ex),

      .axi_req_o (axi_req_o),
      .axi_resp_i(axi_resp_i)
  );

  int f;
  logic [63:0] cycles;

  initial begin
    f = $fopen("trace_hart_00.dasm", "w");
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      cycles <= 0;
    end else begin
      automatic string mode = "";
      if (debug_mode) mode = "D";
      else begin
        case (priv_lvl)
          riscv_pkg::PRIV_LVL_M: mode = "M";
          riscv_pkg::PRIV_LVL_S: mode = "S";
          riscv_pkg::PRIV_LVL_U: mode = "U";
        endcase
      end
      for (int i = 0; i < NR_COMMIT_PORTS; i++) begin
        if (commit_ack[i] && !commit_instr_id_commit[i].ex.valid) begin
          $fwrite(f, "%d 0x%0h %s (0x%h) DASM(%h)\n", cycles, commit_instr_id_commit[i].pc, mode,
                  commit_instr_id_commit[i].ex.tval[31:0], commit_instr_id_commit[i].ex.tval[31:0]);
        end else if (commit_ack[i] && commit_instr_id_commit[i].ex.valid) begin
          if (commit_instr_id_commit[i].ex.cause == 2) begin
            $fwrite(f, "Exception Cause: Illegal Instructions, DASM(%h) PC=%h\n",
                    commit_instr_id_commit[i].ex.tval[31:0], commit_instr_id_commit[i].pc);
          end else begin
            if (debug_mode) begin
              $fwrite(f, "%d 0x%0h %s (0x%h) DASM(%h)\n", cycles, commit_instr_id_commit[i].pc,
                      mode, commit_instr_id_commit[i].ex.tval[31:0],
                      commit_instr_id_commit[i].ex.tval[31:0]);
            end else begin
              $fwrite(f, "Exception Cause: %5d, DASM(%h) PC=%h\n",
                      commit_instr_id_commit[i].ex.cause, commit_instr_id_commit[i].ex.tval[31:0],
                      commit_instr_id_commit[i].pc);
            end
          end
        end
      end
      cycles <= cycles + 1;
    end
  end

  final begin
    $fclose(f);
  end

endmodule

