// Generator : SpinalHDL v1.3.3    git head : 8b8cd335eecbea3b5f1f970f218a982dbdb12d99
// Date      : 27/04/2019, 11:38:02
// Component : VexRiscv


`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define EnvCtrlEnum_defaultEncoding_type [0:0]
`define EnvCtrlEnum_defaultEncoding_NONE 1'b0
`define EnvCtrlEnum_defaultEncoding_XRET 1'b1

`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

module InstructionCache (
      input   io_flush,
      input   io_cpu_prefetch_isValid,
      output reg  io_cpu_prefetch_haltIt,
      input  [31:0] io_cpu_prefetch_pc,
      input   io_cpu_fetch_isValid,
      input   io_cpu_fetch_isStuck,
      input   io_cpu_fetch_isRemoved,
      input  [31:0] io_cpu_fetch_pc,
      output [31:0] io_cpu_fetch_data,
      input   io_cpu_fetch_dataBypassValid,
      input  [31:0] io_cpu_fetch_dataBypass,
      output  io_cpu_fetch_mmuBus_cmd_isValid,
      output [31:0] io_cpu_fetch_mmuBus_cmd_virtualAddress,
      output  io_cpu_fetch_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_fetch_mmuBus_rsp_physicalAddress,
      input   io_cpu_fetch_mmuBus_rsp_isIoAccess,
      input   io_cpu_fetch_mmuBus_rsp_allowRead,
      input   io_cpu_fetch_mmuBus_rsp_allowWrite,
      input   io_cpu_fetch_mmuBus_rsp_allowExecute,
      input   io_cpu_fetch_mmuBus_rsp_exception,
      input   io_cpu_fetch_mmuBus_rsp_refilling,
      output  io_cpu_fetch_mmuBus_end,
      input   io_cpu_fetch_mmuBus_busy,
      output [31:0] io_cpu_fetch_physicalAddress,
      output  io_cpu_fetch_haltIt,
      input   io_cpu_decode_isValid,
      input   io_cpu_decode_isStuck,
      input  [31:0] io_cpu_decode_pc,
      output [31:0] io_cpu_decode_physicalAddress,
      output [31:0] io_cpu_decode_data,
      output  io_cpu_decode_cacheMiss,
      output  io_cpu_decode_error,
      output  io_cpu_decode_mmuRefilling,
      output  io_cpu_decode_mmuException,
      input   io_cpu_decode_isUser,
      input   io_cpu_fill_valid,
      input  [31:0] io_cpu_fill_payload,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [2:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_10_;
  reg [31:0] _zz_11_;
  wire  _zz_12_;
  wire  _zz_13_;
  wire [0:0] _zz_14_;
  wire [0:0] _zz_15_;
  wire [21:0] _zz_16_;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  lineLoader_fire;
  reg  lineLoader_valid;
  reg [31:0] lineLoader_address;
  reg  lineLoader_hadError;
  reg  lineLoader_flushPending;
  reg [7:0] lineLoader_flushCounter;
  reg  _zz_3_;
  reg  lineLoader_cmdSent;
  reg  lineLoader_wayToAllocate_willIncrement;
  wire  lineLoader_wayToAllocate_willClear;
  wire  lineLoader_wayToAllocate_willOverflowIfInc;
  wire  lineLoader_wayToAllocate_willOverflow;
  reg [2:0] lineLoader_wordIndex;
  wire  lineLoader_write_tag_0_valid;
  wire [6:0] lineLoader_write_tag_0_payload_address;
  wire  lineLoader_write_tag_0_payload_data_valid;
  wire  lineLoader_write_tag_0_payload_data_error;
  wire [19:0] lineLoader_write_tag_0_payload_data_address;
  wire  lineLoader_write_data_0_valid;
  wire [9:0] lineLoader_write_data_0_payload_address;
  wire [31:0] lineLoader_write_data_0_payload_data;
  wire  _zz_4_;
  wire [6:0] _zz_5_;
  wire  _zz_6_;
  wire  fetchStage_read_waysValues_0_tag_valid;
  wire  fetchStage_read_waysValues_0_tag_error;
  wire [19:0] fetchStage_read_waysValues_0_tag_address;
  wire [21:0] _zz_7_;
  wire [9:0] _zz_8_;
  wire  _zz_9_;
  wire [31:0] fetchStage_read_waysValues_0_data;
  wire  fetchStage_hit_hits_0;
  wire  fetchStage_hit_valid;
  wire  fetchStage_hit_error;
  wire [31:0] fetchStage_hit_data;
  wire [31:0] fetchStage_hit_word;
  reg [31:0] io_cpu_fetch_data_regNextWhen;
  reg [31:0] decodeStage_mmuRsp_physicalAddress;
  reg  decodeStage_mmuRsp_isIoAccess;
  reg  decodeStage_mmuRsp_allowRead;
  reg  decodeStage_mmuRsp_allowWrite;
  reg  decodeStage_mmuRsp_allowExecute;
  reg  decodeStage_mmuRsp_exception;
  reg  decodeStage_mmuRsp_refilling;
  reg  decodeStage_hit_valid;
  reg  decodeStage_hit_error;
  reg [21:0] ways_0_tags [0:127];
  reg [31:0] ways_0_datas [0:1023];
  assign _zz_12_ = (! lineLoader_flushCounter[7]);
  assign _zz_13_ = (lineLoader_flushPending && (! (lineLoader_valid || io_cpu_fetch_isValid)));
  assign _zz_14_ = _zz_7_[0 : 0];
  assign _zz_15_ = _zz_7_[1 : 1];
  assign _zz_16_ = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_2_) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_16_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_6_) begin
      _zz_10_ <= ways_0_tags[_zz_5_];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1_) begin
      ways_0_datas[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_9_) begin
      _zz_11_ <= ways_0_datas[_zz_8_];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(lineLoader_write_data_0_valid)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if(lineLoader_write_tag_0_valid)begin
      _zz_2_ = 1'b1;
    end
  end

  assign io_cpu_fetch_haltIt = io_cpu_fetch_mmuBus_busy;
  always @ (*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid)begin
      if((lineLoader_wordIndex == (3'b111)))begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  always @ (*) begin
    io_cpu_prefetch_haltIt = (lineLoader_valid || lineLoader_flushPending);
    if(_zz_12_)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if((! _zz_3_))begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],(5'b00000)};
  assign io_mem_cmd_payload_size = (3'b101);
  always @ (*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if(lineLoader_fire)begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1;
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  assign _zz_4_ = 1'b1;
  assign lineLoader_write_tag_0_valid = ((_zz_4_ && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && _zz_4_);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign _zz_5_ = io_cpu_prefetch_pc[11 : 5];
  assign _zz_6_ = (! io_cpu_fetch_isStuck);
  assign _zz_7_ = _zz_10_;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_14_[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_15_[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_7_[21 : 2];
  assign _zz_8_ = io_cpu_prefetch_pc[11 : 2];
  assign _zz_9_ = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_11_;
  assign fetchStage_hit_hits_0 = (fetchStage_read_waysValues_0_tag_valid && (fetchStage_read_waysValues_0_tag_address == io_cpu_fetch_mmuBus_rsp_physicalAddress[31 : 12]));
  assign fetchStage_hit_valid = (fetchStage_hit_hits_0 != (1'b0));
  assign fetchStage_hit_error = fetchStage_read_waysValues_0_tag_error;
  assign fetchStage_hit_data = fetchStage_read_waysValues_0_data;
  assign fetchStage_hit_word = fetchStage_hit_data[31 : 0];
  assign io_cpu_fetch_data = (io_cpu_fetch_dataBypassValid ? io_cpu_fetch_dataBypass : fetchStage_hit_word);
  assign io_cpu_decode_data = io_cpu_fetch_data_regNextWhen;
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_fetch_mmuBus_end = ((! io_cpu_fetch_isStuck) || io_cpu_fetch_isRemoved);
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuBus_rsp_physicalAddress;
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = decodeStage_hit_error;
  assign io_cpu_decode_mmuRefilling = decodeStage_mmuRsp_refilling;
  assign io_cpu_decode_mmuException = ((! decodeStage_mmuRsp_refilling) && (decodeStage_mmuRsp_exception || (! decodeStage_mmuRsp_allowExecute)));
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress;
  always @ (posedge clk) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushPending <= 1'b1;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wordIndex <= (3'b000);
    end else begin
      if(lineLoader_fire)begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire)begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid)begin
        lineLoader_valid <= 1'b1;
      end
      if(io_flush)begin
        lineLoader_flushPending <= 1'b1;
      end
      if(_zz_13_)begin
        lineLoader_flushPending <= 1'b0;
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire)begin
        lineLoader_cmdSent <= 1'b0;
      end
      if(io_mem_rsp_valid)begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + (3'b001));
        if(io_mem_rsp_payload_error)begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @ (posedge clk) begin
    if(io_cpu_fill_valid)begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    if(_zz_12_)begin
      lineLoader_flushCounter <= (lineLoader_flushCounter + (8'b00000001));
    end
    _zz_3_ <= lineLoader_flushCounter[7];
    if(_zz_13_)begin
      lineLoader_flushCounter <= (8'b00000000);
    end
    if((! io_cpu_decode_isStuck))begin
      io_cpu_fetch_data_regNextWhen <= io_cpu_fetch_data;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuBus_rsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuBus_rsp_isIoAccess;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuBus_rsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuBus_rsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuBus_rsp_allowExecute;
      decodeStage_mmuRsp_exception <= io_cpu_fetch_mmuBus_rsp_exception;
      decodeStage_mmuRsp_refilling <= io_cpu_fetch_mmuBus_rsp_refilling;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_valid <= fetchStage_hit_valid;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_error <= fetchStage_hit_error;
    end
  end

endmodule

module DataCache (
      input   io_cpu_execute_isValid,
      input  [31:0] io_cpu_execute_address,
      input   io_cpu_execute_args_wr,
      input  [31:0] io_cpu_execute_args_data,
      input  [1:0] io_cpu_execute_args_size,
      input   io_cpu_memory_isValid,
      input   io_cpu_memory_isStuck,
      input   io_cpu_memory_isRemoved,
      output  io_cpu_memory_isWrite,
      input  [31:0] io_cpu_memory_address,
      output  io_cpu_memory_mmuBus_cmd_isValid,
      output [31:0] io_cpu_memory_mmuBus_cmd_virtualAddress,
      output  io_cpu_memory_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_memory_mmuBus_rsp_physicalAddress,
      input   io_cpu_memory_mmuBus_rsp_isIoAccess,
      input   io_cpu_memory_mmuBus_rsp_allowRead,
      input   io_cpu_memory_mmuBus_rsp_allowWrite,
      input   io_cpu_memory_mmuBus_rsp_allowExecute,
      input   io_cpu_memory_mmuBus_rsp_exception,
      input   io_cpu_memory_mmuBus_rsp_refilling,
      output  io_cpu_memory_mmuBus_end,
      input   io_cpu_memory_mmuBus_busy,
      input   io_cpu_writeBack_isValid,
      input   io_cpu_writeBack_isStuck,
      input   io_cpu_writeBack_isUser,
      output reg  io_cpu_writeBack_haltIt,
      output  io_cpu_writeBack_isWrite,
      output reg [31:0] io_cpu_writeBack_data,
      input  [31:0] io_cpu_writeBack_address,
      output  io_cpu_writeBack_mmuException,
      output  io_cpu_writeBack_unalignedAccess,
      output reg  io_cpu_writeBack_accessError,
      output reg  io_cpu_redo,
      input   io_cpu_flush_valid,
      output reg  io_cpu_flush_ready,
      output reg  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output reg  io_mem_cmd_payload_wr,
      output reg [31:0] io_mem_cmd_payload_address,
      output [31:0] io_mem_cmd_payload_data,
      output [3:0] io_mem_cmd_payload_mask,
      output reg [2:0] io_mem_cmd_payload_length,
      output reg  io_mem_cmd_payload_last,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_10_;
  reg [31:0] _zz_11_;
  wire  _zz_12_;
  wire  _zz_13_;
  wire  _zz_14_;
  wire [0:0] _zz_15_;
  wire [0:0] _zz_16_;
  wire [0:0] _zz_17_;
  wire [2:0] _zz_18_;
  wire [1:0] _zz_19_;
  wire [21:0] _zz_20_;
  reg  _zz_1_;
  reg  _zz_2_;
  wire  haltCpu;
  reg  tagsReadCmd_valid;
  reg [6:0] tagsReadCmd_payload;
  reg  tagsWriteCmd_valid;
  reg [0:0] tagsWriteCmd_payload_way;
  reg [6:0] tagsWriteCmd_payload_address;
  reg  tagsWriteCmd_payload_data_valid;
  reg  tagsWriteCmd_payload_data_error;
  reg [19:0] tagsWriteCmd_payload_data_address;
  reg  tagsWriteLastCmd_valid;
  reg [0:0] tagsWriteLastCmd_payload_way;
  reg [6:0] tagsWriteLastCmd_payload_address;
  reg  tagsWriteLastCmd_payload_data_valid;
  reg  tagsWriteLastCmd_payload_data_error;
  reg [19:0] tagsWriteLastCmd_payload_data_address;
  reg  dataReadCmd_valid;
  reg [9:0] dataReadCmd_payload;
  reg  dataWriteCmd_valid;
  reg [0:0] dataWriteCmd_payload_way;
  reg [9:0] dataWriteCmd_payload_address;
  reg [31:0] dataWriteCmd_payload_data;
  reg [3:0] dataWriteCmd_payload_mask;
  wire  _zz_3_;
  wire  ways_0_tagsReadRsp_valid;
  wire  ways_0_tagsReadRsp_error;
  wire [19:0] ways_0_tagsReadRsp_address;
  wire [21:0] _zz_4_;
  wire  _zz_5_;
  wire [31:0] ways_0_dataReadRsp;
  reg [3:0] _zz_6_;
  wire [3:0] stage0_mask;
  wire [0:0] stage0_colisions;
  reg  stageA_request_wr;
  reg [31:0] stageA_request_data;
  reg [1:0] stageA_request_size;
  reg [3:0] stageA_mask;
  wire  stageA_wayHits_0;
  reg [0:0] stage0_colisions_regNextWhen;
  wire [0:0] _zz_7_;
  wire [0:0] stageA_colisions;
  reg  stageB_request_wr;
  reg [31:0] stageB_request_data;
  reg [1:0] stageB_request_size;
  reg  stageB_mmuRspFreeze;
  reg [31:0] stageB_mmuRsp_physicalAddress;
  reg  stageB_mmuRsp_isIoAccess;
  reg  stageB_mmuRsp_allowRead;
  reg  stageB_mmuRsp_allowWrite;
  reg  stageB_mmuRsp_allowExecute;
  reg  stageB_mmuRsp_exception;
  reg  stageB_mmuRsp_refilling;
  reg  stageB_tagsReadRsp_0_valid;
  reg  stageB_tagsReadRsp_0_error;
  reg [19:0] stageB_tagsReadRsp_0_address;
  reg [31:0] stageB_dataReadRsp_0;
  wire [0:0] _zz_8_;
  reg [0:0] stageB_waysHits;
  wire  stageB_waysHit;
  wire [31:0] stageB_dataMux;
  reg [3:0] stageB_mask;
  reg [0:0] stageB_colisions;
  reg  stageB_loaderValid;
  reg  stageB_flusher_valid;
  wire [31:0] stageB_requestDataBypass;
  wire  stageB_isAmo;
  reg  stageB_memCmdSent;
  wire [0:0] _zz_9_;
  reg  loader_valid;
  reg  loader_counter_willIncrement;
  wire  loader_counter_willClear;
  reg [2:0] loader_counter_valueNext;
  reg [2:0] loader_counter_value;
  wire  loader_counter_willOverflowIfInc;
  wire  loader_counter_willOverflow;
  reg [0:0] loader_waysAllocator;
  reg  loader_error;
  reg [21:0] ways_0_tags [0:127];
  reg [7:0] ways_0_data_symbol0 [0:1023];
  reg [7:0] ways_0_data_symbol1 [0:1023];
  reg [7:0] ways_0_data_symbol2 [0:1023];
  reg [7:0] ways_0_data_symbol3 [0:1023];
  reg [7:0] _zz_21_;
  reg [7:0] _zz_22_;
  reg [7:0] _zz_23_;
  reg [7:0] _zz_24_;
  assign _zz_12_ = (loader_valid && io_mem_rsp_valid);
  assign _zz_13_ = ((((io_cpu_flush_valid && (! io_cpu_execute_isValid)) && (! io_cpu_memory_isValid)) && (! io_cpu_writeBack_isValid)) && (! io_cpu_redo));
  assign _zz_14_ = ((! io_cpu_writeBack_isStuck) && (! stageB_mmuRspFreeze));
  assign _zz_15_ = _zz_4_[0 : 0];
  assign _zz_16_ = _zz_4_[1 : 1];
  assign _zz_17_ = loader_counter_willIncrement;
  assign _zz_18_ = {2'd0, _zz_17_};
  assign _zz_19_ = {loader_waysAllocator,loader_waysAllocator[0]};
  assign _zz_20_ = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_2_) begin
      ways_0_tags[tagsWriteCmd_payload_address] <= _zz_20_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_3_) begin
      _zz_10_ <= ways_0_tags[tagsReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_11_ = {_zz_24_, _zz_23_, _zz_22_, _zz_21_};
  end
  always @ (posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_1_) begin
      ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_1_) begin
      ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_1_) begin
      ways_0_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_1_) begin
      ways_0_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(_zz_5_) begin
      _zz_21_ <= ways_0_data_symbol0[dataReadCmd_payload];
      _zz_22_ <= ways_0_data_symbol1[dataReadCmd_payload];
      _zz_23_ <= ways_0_data_symbol2[dataReadCmd_payload];
      _zz_24_ <= ways_0_data_symbol3[dataReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if((dataWriteCmd_valid && dataWriteCmd_payload_way[0]))begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if((tagsWriteCmd_valid && tagsWriteCmd_payload_way[0]))begin
      _zz_2_ = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  assign _zz_3_ = (tagsReadCmd_valid && (! io_cpu_memory_isStuck));
  assign _zz_4_ = _zz_10_;
  assign ways_0_tagsReadRsp_valid = _zz_15_[0];
  assign ways_0_tagsReadRsp_error = _zz_16_[0];
  assign ways_0_tagsReadRsp_address = _zz_4_[21 : 2];
  assign _zz_5_ = (dataReadCmd_valid && (! io_cpu_memory_isStuck));
  assign ways_0_dataReadRsp = _zz_11_;
  always @ (*) begin
    tagsReadCmd_valid = 1'b0;
    tagsReadCmd_payload = (7'bxxxxxxx);
    dataReadCmd_valid = 1'b0;
    dataReadCmd_payload = (10'bxxxxxxxxxx);
    if((io_cpu_execute_isValid && (! io_cpu_memory_isStuck)))begin
      tagsReadCmd_valid = 1'b1;
      dataReadCmd_valid = 1'b1;
      tagsReadCmd_payload = io_cpu_execute_address[11 : 5];
      dataReadCmd_payload = io_cpu_execute_address[11 : 2];
    end
  end

  always @ (*) begin
    tagsWriteCmd_valid = 1'b0;
    tagsWriteCmd_payload_way = (1'bx);
    tagsWriteCmd_payload_address = (7'bxxxxxxx);
    tagsWriteCmd_payload_data_valid = 1'bx;
    tagsWriteCmd_payload_data_error = 1'bx;
    tagsWriteCmd_payload_data_address = (20'bxxxxxxxxxxxxxxxxxxxx);
    dataWriteCmd_valid = 1'b0;
    dataWriteCmd_payload_way = (1'bx);
    dataWriteCmd_payload_address = (10'bxxxxxxxxxx);
    dataWriteCmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    dataWriteCmd_payload_mask = (4'bxxxx);
    stageB_loaderValid = 1'b0;
    io_cpu_writeBack_haltIt = io_cpu_writeBack_isValid;
    if(stageB_flusher_valid)begin
      tagsWriteCmd_valid = stageB_flusher_valid;
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
      tagsWriteCmd_payload_way = (1'b1);
      tagsWriteCmd_payload_data_valid = 1'b0;
      io_cpu_writeBack_haltIt = 1'b1;
    end
    io_cpu_redo = 1'b0;
    io_mem_cmd_valid = 1'b0;
    io_mem_cmd_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    io_mem_cmd_payload_length = (3'bxxx);
    io_mem_cmd_payload_last = 1'bx;
    io_mem_cmd_payload_wr = stageB_request_wr;
    if(io_cpu_writeBack_isValid)begin
      if(stageB_mmuRsp_isIoAccess)begin
        if((stageB_request_wr ? io_mem_cmd_ready : io_mem_rsp_valid))begin
          io_cpu_writeBack_haltIt = 1'b0;
        end
        io_mem_cmd_valid = (! stageB_memCmdSent);
        io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 2],(2'b00)};
        io_mem_cmd_payload_length = (3'b000);
        io_mem_cmd_payload_last = 1'b1;
      end else begin
        if((stageB_waysHit || (stageB_request_wr && (! stageB_isAmo))))begin
          if((stageB_request_wr && stageB_waysHit))begin
            dataWriteCmd_valid = 1'b1;
          end
          dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 2];
          dataWriteCmd_payload_data = stageB_requestDataBypass;
          dataWriteCmd_payload_mask = stageB_mask;
          dataWriteCmd_payload_way = stageB_waysHits;
          if(stageB_request_wr)begin
            io_mem_cmd_valid = 1'b1;
          end
          io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 2],(2'b00)};
          io_mem_cmd_payload_length = (3'b000);
          io_mem_cmd_payload_last = 1'b1;
          if(((! stageB_request_wr) || io_mem_cmd_ready))begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
          if((((! stageB_request_wr) || stageB_isAmo) && ((stageB_colisions & stageB_waysHits) != (1'b0))))begin
            io_cpu_redo = 1'b1;
          end
        end else begin
          if((! stageB_memCmdSent))begin
            io_mem_cmd_valid = 1'b1;
          end
          io_mem_cmd_payload_wr = 1'b0;
          io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 5],(5'b00000)};
          io_mem_cmd_payload_length = (3'b111);
          io_mem_cmd_payload_last = 1'b1;
          if(io_mem_cmd_ready)begin
            stageB_loaderValid = 1'b1;
          end
        end
      end
    end
    if((((stageB_mmuRsp_refilling || io_cpu_writeBack_accessError) || io_cpu_writeBack_mmuException) || io_cpu_writeBack_unalignedAccess))begin
      io_mem_cmd_valid = 1'b0;
      tagsWriteCmd_valid = 1'b0;
      dataWriteCmd_valid = 1'b0;
      stageB_loaderValid = 1'b0;
      io_cpu_writeBack_haltIt = 1'b0;
    end
    if((io_cpu_writeBack_isValid && stageB_mmuRsp_refilling))begin
      io_cpu_redo = 1'b1;
    end
    loader_counter_willIncrement = 1'b0;
    if(_zz_12_)begin
      dataWriteCmd_valid = 1'b1;
      dataWriteCmd_payload_address = {stageB_mmuRsp_physicalAddress[11 : 5],loader_counter_value};
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
      dataWriteCmd_payload_mask = (4'b1111);
      dataWriteCmd_payload_way = loader_waysAllocator;
      loader_counter_willIncrement = 1'b1;
    end
    if(loader_counter_willOverflow)begin
      tagsWriteCmd_valid = 1'b1;
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
      tagsWriteCmd_payload_data_valid = 1'b1;
      tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 12];
      tagsWriteCmd_payload_data_error = (loader_error || io_mem_rsp_payload_error);
      tagsWriteCmd_payload_way = loader_waysAllocator;
    end
    if(loader_valid)begin
      io_cpu_redo = 1'b1;
    end
  end

  always @ (*) begin
    case(io_cpu_execute_args_size)
      2'b00 : begin
        _zz_6_ = (4'b0001);
      end
      2'b01 : begin
        _zz_6_ = (4'b0011);
      end
      default : begin
        _zz_6_ = (4'b1111);
      end
    endcase
  end

  assign stage0_mask = (_zz_6_ <<< io_cpu_execute_address[1 : 0]);
  assign stage0_colisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == io_cpu_execute_address[11 : 2])) && ((stage0_mask & dataWriteCmd_payload_mask) != (4'b0000)));
  assign io_cpu_memory_mmuBus_cmd_isValid = io_cpu_memory_isValid;
  assign io_cpu_memory_mmuBus_cmd_virtualAddress = io_cpu_memory_address;
  assign io_cpu_memory_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_memory_mmuBus_end = ((! io_cpu_memory_isStuck) || io_cpu_memory_isRemoved);
  assign io_cpu_memory_isWrite = stageA_request_wr;
  assign stageA_wayHits_0 = ((io_cpu_memory_mmuBus_rsp_physicalAddress[31 : 12] == ways_0_tagsReadRsp_address) && ways_0_tagsReadRsp_valid);
  assign _zz_7_[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == io_cpu_memory_address[11 : 2])) && ((stageA_mask & dataWriteCmd_payload_mask) != (4'b0000)));
  assign stageA_colisions = (stage0_colisions_regNextWhen | _zz_7_);
  always @ (*) begin
    stageB_mmuRspFreeze = 1'b0;
    if((stageB_loaderValid || loader_valid))begin
      stageB_mmuRspFreeze = 1'b1;
    end
  end

  assign _zz_8_[0] = stageA_wayHits_0;
  assign stageB_waysHit = (stageB_waysHits != (1'b0));
  assign stageB_dataMux = stageB_dataReadRsp_0;
  always @ (*) begin
    io_cpu_flush_ready = 1'b0;
    if(_zz_13_)begin
      io_cpu_flush_ready = 1'b1;
    end
  end

  assign stageB_requestDataBypass = stageB_request_data;
  assign stageB_isAmo = 1'b0;
  always @ (*) begin
    io_cpu_writeBack_accessError = 1'b0;
    if(stageB_mmuRsp_isIoAccess)begin
      io_cpu_writeBack_data = io_mem_rsp_payload_data;
      io_cpu_writeBack_accessError = (io_mem_rsp_valid && io_mem_rsp_payload_error);
    end else begin
      io_cpu_writeBack_data = stageB_dataMux;
      io_cpu_writeBack_accessError = ((stageB_waysHits & _zz_9_) != (1'b0));
    end
  end

  assign io_cpu_writeBack_mmuException = (io_cpu_writeBack_isValid && ((stageB_mmuRsp_exception || ((! stageB_mmuRsp_allowWrite) && stageB_request_wr)) || ((! stageB_mmuRsp_allowRead) && ((! stageB_request_wr) || stageB_isAmo))));
  assign io_cpu_writeBack_unalignedAccess = (io_cpu_writeBack_isValid && (((stageB_request_size == (2'b10)) && (stageB_mmuRsp_physicalAddress[1 : 0] != (2'b00))) || ((stageB_request_size == (2'b01)) && (stageB_mmuRsp_physicalAddress[0 : 0] != (1'b0)))));
  assign io_cpu_writeBack_isWrite = stageB_request_wr;
  assign io_mem_cmd_payload_mask = stageB_mask;
  assign io_mem_cmd_payload_data = stageB_requestDataBypass;
  assign _zz_9_[0] = stageB_tagsReadRsp_0_error;
  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == (3'b111));
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @ (*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_18_);
    if(loader_counter_willClear)begin
      loader_counter_valueNext = (3'b000);
    end
  end

  always @ (posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid;
    tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if((! io_cpu_memory_isStuck))begin
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_data <= io_cpu_execute_args_data;
      stageA_request_size <= io_cpu_execute_args_size;
    end
    if((! io_cpu_memory_isStuck))begin
      stageA_mask <= stage0_mask;
    end
    if((! io_cpu_memory_isStuck))begin
      stage0_colisions_regNextWhen <= stage0_colisions;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_request_wr <= stageA_request_wr;
      stageB_request_data <= stageA_request_data;
      stageB_request_size <= stageA_request_size;
    end
    if(_zz_14_)begin
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuBus_rsp_isIoAccess;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuBus_rsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuBus_rsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuBus_rsp_allowExecute;
      stageB_mmuRsp_exception <= io_cpu_memory_mmuBus_rsp_exception;
      stageB_mmuRsp_refilling <= io_cpu_memory_mmuBus_rsp_refilling;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid;
      stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error;
      stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_dataReadRsp_0 <= ways_0_dataReadRsp;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_waysHits <= _zz_8_;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_mask <= stageA_mask;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_colisions <= stageA_colisions;
    end
    if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
      $display("ERROR writeBack stuck by another plugin is not allowed");
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      stageB_flusher_valid <= 1'b1;
      stageB_mmuRsp_physicalAddress <= (32'b00000000000000000000000000000000);
      stageB_memCmdSent <= 1'b0;
      loader_valid <= 1'b0;
      loader_counter_value <= (3'b000);
      loader_waysAllocator <= (1'b1);
      loader_error <= 1'b0;
    end else begin
      if(_zz_14_)begin
        stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuBus_rsp_physicalAddress;
      end
      if(stageB_flusher_valid)begin
        if((stageB_mmuRsp_physicalAddress[11 : 5] != (7'b1111111)))begin
          stageB_mmuRsp_physicalAddress[11 : 5] <= (stageB_mmuRsp_physicalAddress[11 : 5] + (7'b0000001));
        end else begin
          stageB_flusher_valid <= 1'b0;
        end
      end
      if(_zz_13_)begin
        stageB_mmuRsp_physicalAddress[11 : 5] <= (7'b0000000);
        stageB_flusher_valid <= 1'b1;
      end
      if(io_mem_cmd_ready)begin
        stageB_memCmdSent <= 1'b1;
      end
      if((! io_cpu_writeBack_isStuck))begin
        stageB_memCmdSent <= 1'b0;
      end
      if(stageB_loaderValid)begin
        loader_valid <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(_zz_12_)begin
        loader_error <= (loader_error || io_mem_rsp_payload_error);
      end
      if(loader_counter_willOverflow)begin
        loader_valid <= 1'b0;
        loader_waysAllocator <= _zz_19_[0:0];
        loader_error <= 1'b0;
      end
    end
  end

endmodule

module VexRiscv (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input   softwareInterrupt,
      input  [31:0] externalInterruptArray,
      output reg  iBusWishbone_CYC,
      output reg  iBusWishbone_STB,
      input   iBusWishbone_ACK,
      output  iBusWishbone_WE,
      output [29:0] iBusWishbone_ADR,
      input  [31:0] iBusWishbone_DAT_MISO,
      output [31:0] iBusWishbone_DAT_MOSI,
      output [3:0] iBusWishbone_SEL,
      input   iBusWishbone_ERR,
      output [1:0] iBusWishbone_BTE,
      output [2:0] iBusWishbone_CTI,
      output  dBusWishbone_CYC,
      output  dBusWishbone_STB,
      input   dBusWishbone_ACK,
      output  dBusWishbone_WE,
      output [29:0] dBusWishbone_ADR,
      input  [31:0] dBusWishbone_DAT_MISO,
      output [31:0] dBusWishbone_DAT_MOSI,
      output [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   clk,
      input   reset);
  wire  _zz_218_;
  wire  _zz_219_;
  wire  _zz_220_;
  wire  _zz_221_;
  wire  _zz_222_;
  wire [31:0] _zz_223_;
  wire  _zz_224_;
  wire  _zz_225_;
  wire  _zz_226_;
  reg  _zz_227_;
  wire  _zz_228_;
  wire [31:0] _zz_229_;
  wire  _zz_230_;
  wire [31:0] _zz_231_;
  reg  _zz_232_;
  wire  _zz_233_;
  wire  _zz_234_;
  wire [31:0] _zz_235_;
  wire  _zz_236_;
  wire  _zz_237_;
  reg [31:0] _zz_238_;
  reg [31:0] _zz_239_;
  reg [31:0] _zz_240_;
  wire  IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_data;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_haltIt;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end;
  wire  IBusCachedPlugin_cache_io_cpu_decode_error;
  wire  IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling;
  wire  IBusCachedPlugin_cache_io_cpu_decode_mmuException;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_data;
  wire  IBusCachedPlugin_cache_io_cpu_decode_cacheMiss;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
  wire  IBusCachedPlugin_cache_io_mem_cmd_valid;
  wire [31:0] IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  wire [2:0] IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  wire  dataCache_1__io_cpu_memory_isWrite;
  wire  dataCache_1__io_cpu_memory_mmuBus_cmd_isValid;
  wire [31:0] dataCache_1__io_cpu_memory_mmuBus_cmd_virtualAddress;
  wire  dataCache_1__io_cpu_memory_mmuBus_cmd_bypassTranslation;
  wire  dataCache_1__io_cpu_memory_mmuBus_end;
  wire  dataCache_1__io_cpu_writeBack_haltIt;
  wire [31:0] dataCache_1__io_cpu_writeBack_data;
  wire  dataCache_1__io_cpu_writeBack_mmuException;
  wire  dataCache_1__io_cpu_writeBack_unalignedAccess;
  wire  dataCache_1__io_cpu_writeBack_accessError;
  wire  dataCache_1__io_cpu_writeBack_isWrite;
  wire  dataCache_1__io_cpu_flush_ready;
  wire  dataCache_1__io_cpu_redo;
  wire  dataCache_1__io_mem_cmd_valid;
  wire  dataCache_1__io_mem_cmd_payload_wr;
  wire [31:0] dataCache_1__io_mem_cmd_payload_address;
  wire [31:0] dataCache_1__io_mem_cmd_payload_data;
  wire [3:0] dataCache_1__io_mem_cmd_payload_mask;
  wire [2:0] dataCache_1__io_mem_cmd_payload_length;
  wire  dataCache_1__io_mem_cmd_payload_last;
  wire  _zz_241_;
  wire  _zz_242_;
  wire  _zz_243_;
  wire  _zz_244_;
  wire  _zz_245_;
  wire [1:0] _zz_246_;
  wire  _zz_247_;
  wire  _zz_248_;
  wire  _zz_249_;
  wire  _zz_250_;
  wire [1:0] _zz_251_;
  wire  _zz_252_;
  wire [1:0] _zz_253_;
  wire [1:0] _zz_254_;
  wire [4:0] _zz_255_;
  wire [2:0] _zz_256_;
  wire [31:0] _zz_257_;
  wire [11:0] _zz_258_;
  wire [31:0] _zz_259_;
  wire [19:0] _zz_260_;
  wire [11:0] _zz_261_;
  wire [31:0] _zz_262_;
  wire [31:0] _zz_263_;
  wire [19:0] _zz_264_;
  wire [11:0] _zz_265_;
  wire [2:0] _zz_266_;
  wire [2:0] _zz_267_;
  wire [0:0] _zz_268_;
  wire [0:0] _zz_269_;
  wire [0:0] _zz_270_;
  wire [0:0] _zz_271_;
  wire [0:0] _zz_272_;
  wire [0:0] _zz_273_;
  wire [0:0] _zz_274_;
  wire [0:0] _zz_275_;
  wire [0:0] _zz_276_;
  wire [0:0] _zz_277_;
  wire [0:0] _zz_278_;
  wire [0:0] _zz_279_;
  wire [0:0] _zz_280_;
  wire [0:0] _zz_281_;
  wire [0:0] _zz_282_;
  wire [0:0] _zz_283_;
  wire [0:0] _zz_284_;
  wire [0:0] _zz_285_;
  wire [2:0] _zz_286_;
  wire [4:0] _zz_287_;
  wire [11:0] _zz_288_;
  wire [11:0] _zz_289_;
  wire [31:0] _zz_290_;
  wire [31:0] _zz_291_;
  wire [31:0] _zz_292_;
  wire [31:0] _zz_293_;
  wire [31:0] _zz_294_;
  wire [31:0] _zz_295_;
  wire [31:0] _zz_296_;
  wire [32:0] _zz_297_;
  wire [31:0] _zz_298_;
  wire [32:0] _zz_299_;
  wire [11:0] _zz_300_;
  wire [19:0] _zz_301_;
  wire [11:0] _zz_302_;
  wire [31:0] _zz_303_;
  wire [31:0] _zz_304_;
  wire [31:0] _zz_305_;
  wire [11:0] _zz_306_;
  wire [19:0] _zz_307_;
  wire [11:0] _zz_308_;
  wire [2:0] _zz_309_;
  wire [1:0] _zz_310_;
  wire [1:0] _zz_311_;
  wire [51:0] _zz_312_;
  wire [51:0] _zz_313_;
  wire [51:0] _zz_314_;
  wire [32:0] _zz_315_;
  wire [51:0] _zz_316_;
  wire [49:0] _zz_317_;
  wire [51:0] _zz_318_;
  wire [49:0] _zz_319_;
  wire [51:0] _zz_320_;
  wire [65:0] _zz_321_;
  wire [65:0] _zz_322_;
  wire [31:0] _zz_323_;
  wire [31:0] _zz_324_;
  wire [0:0] _zz_325_;
  wire [5:0] _zz_326_;
  wire [32:0] _zz_327_;
  wire [32:0] _zz_328_;
  wire [31:0] _zz_329_;
  wire [31:0] _zz_330_;
  wire [32:0] _zz_331_;
  wire [32:0] _zz_332_;
  wire [32:0] _zz_333_;
  wire [0:0] _zz_334_;
  wire [32:0] _zz_335_;
  wire [0:0] _zz_336_;
  wire [32:0] _zz_337_;
  wire [0:0] _zz_338_;
  wire [31:0] _zz_339_;
  wire [0:0] _zz_340_;
  wire [0:0] _zz_341_;
  wire [0:0] _zz_342_;
  wire [0:0] _zz_343_;
  wire [0:0] _zz_344_;
  wire [0:0] _zz_345_;
  wire [26:0] _zz_346_;
  wire  _zz_347_;
  wire  _zz_348_;
  wire [2:0] _zz_349_;
  wire  _zz_350_;
  wire  _zz_351_;
  wire  _zz_352_;
  wire  _zz_353_;
  wire [0:0] _zz_354_;
  wire [2:0] _zz_355_;
  wire [31:0] _zz_356_;
  wire [31:0] _zz_357_;
  wire  _zz_358_;
  wire [0:0] _zz_359_;
  wire [0:0] _zz_360_;
  wire  _zz_361_;
  wire [0:0] _zz_362_;
  wire [24:0] _zz_363_;
  wire [31:0] _zz_364_;
  wire [31:0] _zz_365_;
  wire [31:0] _zz_366_;
  wire  _zz_367_;
  wire  _zz_368_;
  wire [31:0] _zz_369_;
  wire [31:0] _zz_370_;
  wire [31:0] _zz_371_;
  wire [0:0] _zz_372_;
  wire [0:0] _zz_373_;
  wire [0:0] _zz_374_;
  wire [0:0] _zz_375_;
  wire  _zz_376_;
  wire [0:0] _zz_377_;
  wire [21:0] _zz_378_;
  wire [31:0] _zz_379_;
  wire [31:0] _zz_380_;
  wire  _zz_381_;
  wire [0:0] _zz_382_;
  wire [1:0] _zz_383_;
  wire [0:0] _zz_384_;
  wire [3:0] _zz_385_;
  wire [1:0] _zz_386_;
  wire [1:0] _zz_387_;
  wire  _zz_388_;
  wire [0:0] _zz_389_;
  wire [18:0] _zz_390_;
  wire [31:0] _zz_391_;
  wire [31:0] _zz_392_;
  wire [31:0] _zz_393_;
  wire [31:0] _zz_394_;
  wire [31:0] _zz_395_;
  wire [31:0] _zz_396_;
  wire [31:0] _zz_397_;
  wire  _zz_398_;
  wire [0:0] _zz_399_;
  wire [0:0] _zz_400_;
  wire [31:0] _zz_401_;
  wire [31:0] _zz_402_;
  wire [31:0] _zz_403_;
  wire [31:0] _zz_404_;
  wire  _zz_405_;
  wire [4:0] _zz_406_;
  wire [4:0] _zz_407_;
  wire  _zz_408_;
  wire [0:0] _zz_409_;
  wire [15:0] _zz_410_;
  wire [31:0] _zz_411_;
  wire [31:0] _zz_412_;
  wire [31:0] _zz_413_;
  wire [31:0] _zz_414_;
  wire [31:0] _zz_415_;
  wire [31:0] _zz_416_;
  wire  _zz_417_;
  wire [0:0] _zz_418_;
  wire [2:0] _zz_419_;
  wire [0:0] _zz_420_;
  wire [1:0] _zz_421_;
  wire [0:0] _zz_422_;
  wire [0:0] _zz_423_;
  wire  _zz_424_;
  wire [0:0] _zz_425_;
  wire [13:0] _zz_426_;
  wire [31:0] _zz_427_;
  wire  _zz_428_;
  wire [0:0] _zz_429_;
  wire [0:0] _zz_430_;
  wire [31:0] _zz_431_;
  wire [31:0] _zz_432_;
  wire  _zz_433_;
  wire  _zz_434_;
  wire [31:0] _zz_435_;
  wire [31:0] _zz_436_;
  wire [0:0] _zz_437_;
  wire [1:0] _zz_438_;
  wire [0:0] _zz_439_;
  wire [0:0] _zz_440_;
  wire  _zz_441_;
  wire [0:0] _zz_442_;
  wire [11:0] _zz_443_;
  wire [31:0] _zz_444_;
  wire [31:0] _zz_445_;
  wire [31:0] _zz_446_;
  wire [31:0] _zz_447_;
  wire [31:0] _zz_448_;
  wire [31:0] _zz_449_;
  wire [31:0] _zz_450_;
  wire [31:0] _zz_451_;
  wire [31:0] _zz_452_;
  wire  _zz_453_;
  wire  _zz_454_;
  wire [31:0] _zz_455_;
  wire [31:0] _zz_456_;
  wire [0:0] _zz_457_;
  wire [0:0] _zz_458_;
  wire [1:0] _zz_459_;
  wire [1:0] _zz_460_;
  wire  _zz_461_;
  wire [0:0] _zz_462_;
  wire [9:0] _zz_463_;
  wire [31:0] _zz_464_;
  wire [31:0] _zz_465_;
  wire [31:0] _zz_466_;
  wire [31:0] _zz_467_;
  wire [31:0] _zz_468_;
  wire  _zz_469_;
  wire [1:0] _zz_470_;
  wire [1:0] _zz_471_;
  wire  _zz_472_;
  wire [0:0] _zz_473_;
  wire [6:0] _zz_474_;
  wire [31:0] _zz_475_;
  wire [31:0] _zz_476_;
  wire [31:0] _zz_477_;
  wire [31:0] _zz_478_;
  wire  _zz_479_;
  wire  _zz_480_;
  wire  _zz_481_;
  wire [0:0] _zz_482_;
  wire [0:0] _zz_483_;
  wire  _zz_484_;
  wire [0:0] _zz_485_;
  wire [3:0] _zz_486_;
  wire [31:0] _zz_487_;
  wire  _zz_488_;
  wire [0:0] _zz_489_;
  wire [0:0] _zz_490_;
  wire [0:0] _zz_491_;
  wire [0:0] _zz_492_;
  wire  _zz_493_;
  wire [0:0] _zz_494_;
  wire [0:0] _zz_495_;
  wire [31:0] _zz_496_;
  wire [31:0] _zz_497_;
  wire [31:0] _zz_498_;
  wire [31:0] _zz_499_;
  wire  _zz_500_;
  wire [0:0] _zz_501_;
  wire [0:0] _zz_502_;
  wire [31:0] _zz_503_;
  wire [31:0] _zz_504_;
  wire [31:0] _zz_505_;
  wire  _zz_506_;
  wire [0:0] _zz_507_;
  wire [11:0] _zz_508_;
  wire [31:0] _zz_509_;
  wire [31:0] _zz_510_;
  wire [31:0] _zz_511_;
  wire  _zz_512_;
  wire [0:0] _zz_513_;
  wire [5:0] _zz_514_;
  wire [31:0] _zz_515_;
  wire [31:0] _zz_516_;
  wire [31:0] _zz_517_;
  wire  _zz_518_;
  wire  _zz_519_;
  wire  _zz_520_;
  wire  _zz_521_;
  wire  _zz_522_;
  wire  memory_MEMORY_WR;
  wire  decode_MEMORY_WR;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_1_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_2_;
  wire `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_3_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_4_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_5_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_6_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_7_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_8_;
  wire  execute_BRANCH_DO;
  wire `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_9_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_10_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_11_;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire [31:0] execute_SHIFT_RIGHT;
  wire  decode_IS_RS2_SIGNED;
  wire  decode_CSR_READ_OPCODE;
  wire  decode_IS_RS1_SIGNED;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire [51:0] memory_MUL_LOW;
  wire  decode_IS_DIV;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire [31:0] memory_PC;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] execute_MUL_LL;
  wire [33:0] execute_MUL_LH;
  wire  decode_MEMORY_MANAGMENT;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  decode_CSR_WRITE_OPCODE;
  wire  decode_SRC2_FORCE_ZERO;
  wire `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_12_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_13_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_14_;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire  decode_IS_CSR;
  wire [33:0] execute_MUL_HL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_15_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_16_;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_17_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_18_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_19_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_20_;
  wire `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_21_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_22_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_23_;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_24_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_25_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_26_;
  wire  decode_SRC_LESS_UNSIGNED;
  wire  execute_IS_RS1_SIGNED;
  wire  execute_IS_DIV;
  wire  execute_IS_RS2_SIGNED;
  wire  memory_IS_DIV;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_27_;
  wire [33:0] _zz_28_;
  wire [33:0] _zz_29_;
  wire [33:0] _zz_30_;
  wire [31:0] _zz_31_;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire  execute_IS_CSR;
  wire `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_32_;
  wire `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_33_;
  wire  _zz_34_;
  wire  _zz_35_;
  wire `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_36_;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_37_;
  wire [31:0] execute_PC;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_38_;
  wire [31:0] execute_RS1;
  wire  execute_BRANCH_COND_RESULT;
  wire `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_39_;
  wire  _zz_40_;
  wire  _zz_41_;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  reg [31:0] _zz_42_;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_RS2;
  reg [31:0] decode_RS1;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _zz_43_;
  wire `ShiftCtrlEnum_defaultEncoding_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_44_;
  wire [31:0] _zz_45_;
  wire `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_46_;
  wire  _zz_47_;
  wire [31:0] _zz_48_;
  wire [31:0] _zz_49_;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC2_FORCE_ZERO;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_50_;
  wire `Src2CtrlEnum_defaultEncoding_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_51_;
  wire [31:0] _zz_52_;
  wire `Src1CtrlEnum_defaultEncoding_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_53_;
  wire [31:0] _zz_54_;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_SRC_ADD_ZERO;
  wire  _zz_55_;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_56_;
  wire [31:0] _zz_57_;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_58_;
  wire [31:0] _zz_59_;
  wire  _zz_60_;
  reg  _zz_61_;
  wire [31:0] _zz_62_;
  wire [31:0] _zz_63_;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire  _zz_64_;
  wire  _zz_65_;
  wire  _zz_66_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_67_;
  wire  _zz_68_;
  wire  _zz_69_;
  wire  _zz_70_;
  wire  _zz_71_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_72_;
  wire  _zz_73_;
  wire  _zz_74_;
  wire  _zz_75_;
  wire  _zz_76_;
  wire  _zz_77_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_78_;
  wire  _zz_79_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_80_;
  wire  _zz_81_;
  wire  _zz_82_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_83_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_84_;
  wire  _zz_85_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_86_;
  wire  _zz_87_;
  wire  _zz_88_;
  reg [31:0] _zz_89_;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire  writeBack_MEMORY_WR;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire  writeBack_MEMORY_ENABLE;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  memory_MEMORY_ENABLE;
  wire [1:0] _zz_90_;
  wire  execute_MEMORY_MANAGMENT;
  wire [31:0] execute_RS2;
  wire  execute_MEMORY_WR;
  wire [31:0] execute_SRC_ADD;
  wire  execute_MEMORY_ENABLE;
  wire [31:0] execute_INSTRUCTION;
  wire  decode_MEMORY_ENABLE;
  wire  decode_FLUSH_ALL;
  reg  IBusCachedPlugin_rsp_issueDetected;
  reg  _zz_91_;
  reg  _zz_92_;
  reg  _zz_93_;
  wire [31:0] _zz_94_;
  wire `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_95_;
  wire [31:0] decode_INSTRUCTION;
  reg [31:0] _zz_96_;
  reg [31:0] _zz_97_;
  wire [31:0] decode_PC;
  wire [31:0] _zz_98_;
  wire [31:0] _zz_99_;
  wire [31:0] _zz_100_;
  wire [31:0] writeBack_PC;
  wire [31:0] writeBack_INSTRUCTION;
  reg  decode_arbitration_haltItself;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushAll;
  wire  decode_arbitration_isValid;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  wire  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  reg  memory_arbitration_flushAll;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  reg  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  reg  writeBack_arbitration_flushAll;
  reg  writeBack_arbitration_isValid;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring;
  wire [31:0] lastStageInstruction /* verilator public */ ;
  wire [31:0] lastStagePc /* verilator public */ ;
  wire  lastStageIsValid /* verilator public */ ;
  wire  lastStageIsFiring /* verilator public */ ;
  reg  IBusCachedPlugin_fetcherHalt;
  wire  IBusCachedPlugin_fetcherflushIt;
  reg  IBusCachedPlugin_incomingInstruction;
  wire  IBusCachedPlugin_predictionJumpInterface_valid;
  (* keep , syn_keep *) wire [31:0] IBusCachedPlugin_pcs_4 /* synthesis syn_keep = 1 */ ;
  reg  IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  wire  IBusCachedPlugin_decodePrediction_rsp_wasWrong;
  wire  IBusCachedPlugin_pcValids_0;
  wire  IBusCachedPlugin_pcValids_1;
  wire  IBusCachedPlugin_pcValids_2;
  wire  IBusCachedPlugin_pcValids_3;
  wire  IBusCachedPlugin_redoBranch_valid;
  wire [31:0] IBusCachedPlugin_redoBranch_payload;
  reg  IBusCachedPlugin_decodeExceptionPort_valid;
  reg [3:0] IBusCachedPlugin_decodeExceptionPort_payload_code;
  wire [31:0] IBusCachedPlugin_decodeExceptionPort_payload_badAddr;
  wire  IBusCachedPlugin_mmuBus_cmd_isValid;
  wire [31:0] IBusCachedPlugin_mmuBus_cmd_virtualAddress;
  wire  IBusCachedPlugin_mmuBus_cmd_bypassTranslation;
  wire [31:0] IBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire  IBusCachedPlugin_mmuBus_rsp_isIoAccess;
  wire  IBusCachedPlugin_mmuBus_rsp_allowRead;
  wire  IBusCachedPlugin_mmuBus_rsp_allowWrite;
  wire  IBusCachedPlugin_mmuBus_rsp_allowExecute;
  wire  IBusCachedPlugin_mmuBus_rsp_exception;
  wire  IBusCachedPlugin_mmuBus_rsp_refilling;
  wire  IBusCachedPlugin_mmuBus_end;
  wire  IBusCachedPlugin_mmuBus_busy;
  wire  DBusCachedPlugin_mmuBus_cmd_isValid;
  wire [31:0] DBusCachedPlugin_mmuBus_cmd_virtualAddress;
  wire  DBusCachedPlugin_mmuBus_cmd_bypassTranslation;
  wire [31:0] DBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire  DBusCachedPlugin_mmuBus_rsp_isIoAccess;
  wire  DBusCachedPlugin_mmuBus_rsp_allowRead;
  wire  DBusCachedPlugin_mmuBus_rsp_allowWrite;
  wire  DBusCachedPlugin_mmuBus_rsp_allowExecute;
  wire  DBusCachedPlugin_mmuBus_rsp_exception;
  wire  DBusCachedPlugin_mmuBus_rsp_refilling;
  wire  DBusCachedPlugin_mmuBus_end;
  wire  DBusCachedPlugin_mmuBus_busy;
  reg  DBusCachedPlugin_redoBranch_valid;
  wire [31:0] DBusCachedPlugin_redoBranch_payload;
  reg  DBusCachedPlugin_exceptionBus_valid;
  reg [3:0] DBusCachedPlugin_exceptionBus_payload_code;
  wire [31:0] DBusCachedPlugin_exceptionBus_payload_badAddr;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  BranchPlugin_jumpInterface_valid;
  wire [31:0] BranchPlugin_jumpInterface_payload;
  wire  BranchPlugin_branchExceptionPort_valid;
  wire [3:0] BranchPlugin_branchExceptionPort_payload_code;
  wire [31:0] BranchPlugin_branchExceptionPort_payload_badAddr;
  reg  CsrPlugin_jumpInterface_valid;
  reg [31:0] CsrPlugin_jumpInterface_payload;
  wire  CsrPlugin_exceptionPendings_0;
  wire  CsrPlugin_exceptionPendings_1;
  wire  CsrPlugin_exceptionPendings_2;
  wire  CsrPlugin_exceptionPendings_3;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] CsrPlugin_privilege;
  wire  CsrPlugin_forceMachineWire;
  wire  CsrPlugin_allowInterrupts;
  wire  CsrPlugin_allowException;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [4:0] _zz_101_;
  wire [4:0] _zz_102_;
  wire  _zz_103_;
  wire  _zz_104_;
  wire  _zz_105_;
  wire  _zz_106_;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_107_;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg  IBusCachedPlugin_fetchPc_propagatePc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_108_;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_0_inputSample;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_1_inputSample;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload;
  reg  IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_inputSample;
  wire  _zz_109_;
  wire  _zz_110_;
  wire  _zz_111_;
  wire  _zz_112_;
  wire  _zz_113_;
  reg  _zz_114_;
  wire  _zz_115_;
  reg  _zz_116_;
  reg [31:0] _zz_117_;
  reg  IBusCachedPlugin_iBusRsp_readyForError;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_valid;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_decodeInput_payload_pc;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_inst;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_payload_isRvc;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_0;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_1;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_2;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_3;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_4;
  reg  IBusCachedPlugin_injector_decodeRemoved;
  wire  _zz_118_;
  reg [18:0] _zz_119_;
  wire  _zz_120_;
  reg [10:0] _zz_121_;
  wire  _zz_122_;
  reg [18:0] _zz_123_;
  reg  _zz_124_;
  wire  _zz_125_;
  reg [10:0] _zz_126_;
  wire  _zz_127_;
  reg [18:0] _zz_128_;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  IBusCachedPlugin_s0_tightlyCoupledHit;
  reg  IBusCachedPlugin_s1_tightlyCoupledHit;
  reg  IBusCachedPlugin_s2_tightlyCoupledHit;
  wire  IBusCachedPlugin_rsp_iBusRspOutputHalt;
  reg  IBusCachedPlugin_rsp_redoFetch;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [3:0] dBus_cmd_payload_mask;
  wire [2:0] dBus_cmd_payload_length;
  wire  dBus_cmd_payload_last;
  wire  dBus_rsp_valid;
  wire [31:0] dBus_rsp_payload_data;
  wire  dBus_rsp_payload_error;
  wire  dataCache_1__io_mem_cmd_s2mPipe_valid;
  wire  dataCache_1__io_mem_cmd_s2mPipe_ready;
  wire  dataCache_1__io_mem_cmd_s2mPipe_payload_wr;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_payload_address;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_payload_data;
  wire [3:0] dataCache_1__io_mem_cmd_s2mPipe_payload_mask;
  wire [2:0] dataCache_1__io_mem_cmd_s2mPipe_payload_length;
  wire  dataCache_1__io_mem_cmd_s2mPipe_payload_last;
  reg  _zz_129_;
  reg  _zz_130_;
  reg [31:0] _zz_131_;
  reg [31:0] _zz_132_;
  reg [3:0] _zz_133_;
  reg [2:0] _zz_134_;
  reg  _zz_135_;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_ready;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  wire [31:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  wire [3:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  wire [2:0] dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_length;
  wire  dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  reg  _zz_136_;
  reg  _zz_137_;
  reg [31:0] _zz_138_;
  reg [31:0] _zz_139_;
  reg [3:0] _zz_140_;
  reg [2:0] _zz_141_;
  reg  _zz_142_;
  wire [1:0] execute_DBusCachedPlugin_size;
  reg [31:0] _zz_143_;
  reg [31:0] writeBack_DBusCachedPlugin_rspShifted;
  wire  _zz_144_;
  reg [31:0] _zz_145_;
  wire  _zz_146_;
  reg [31:0] _zz_147_;
  reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
  wire [30:0] _zz_148_;
  wire  _zz_149_;
  wire  _zz_150_;
  wire  _zz_151_;
  wire  _zz_152_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_153_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_154_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_155_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_156_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_157_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_158_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_159_;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  reg  lastStageRegFileWrite_valid /* verilator public */ ;
  wire [4:0] lastStageRegFileWrite_payload_address /* verilator public */ ;
  wire [31:0] lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg  _zz_160_;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_161_;
  reg [31:0] _zz_162_;
  wire  _zz_163_;
  reg [19:0] _zz_164_;
  wire  _zz_165_;
  reg [19:0] _zz_166_;
  reg [31:0] _zz_167_;
  reg [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrelShifterPlugin_amplitude;
  reg [31:0] _zz_168_;
  wire [31:0] execute_FullBarrelShifterPlugin_reversed;
  reg [31:0] _zz_169_;
  reg  _zz_170_;
  reg  _zz_171_;
  wire  _zz_172_;
  reg  _zz_173_;
  reg [4:0] _zz_174_;
  reg [31:0] _zz_175_;
  wire  _zz_176_;
  wire  _zz_177_;
  wire  _zz_178_;
  wire  _zz_179_;
  wire  _zz_180_;
  wire  _zz_181_;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_182_;
  reg  _zz_183_;
  reg  _zz_184_;
  wire  _zz_185_;
  reg [19:0] _zz_186_;
  wire  _zz_187_;
  reg [10:0] _zz_188_;
  wire  _zz_189_;
  reg [18:0] _zz_190_;
  reg  _zz_191_;
  wire  execute_BranchPlugin_missAlignedTarget;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_192_;
  reg [19:0] _zz_193_;
  wire  _zz_194_;
  reg [10:0] _zz_195_;
  wire  _zz_196_;
  reg [18:0] _zz_197_;
  wire [31:0] execute_BranchPlugin_branchAdder;
  wire [1:0] CsrPlugin_misa_base;
  wire [25:0] CsrPlugin_misa_extensions;
  reg [1:0] CsrPlugin_mtvec_mode;
  reg [29:0] CsrPlugin_mtvec_base;
  reg [31:0] CsrPlugin_mepc;
  reg  CsrPlugin_mstatus_MIE;
  reg  CsrPlugin_mstatus_MPIE;
  reg [1:0] CsrPlugin_mstatus_MPP;
  reg  CsrPlugin_mip_MEIP;
  reg  CsrPlugin_mip_MTIP;
  reg  CsrPlugin_mip_MSIP;
  reg  CsrPlugin_mie_MEIE;
  reg  CsrPlugin_mie_MTIE;
  reg  CsrPlugin_mie_MSIE;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mtval;
  reg [63:0] CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg [63:0] CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire [1:0] _zz_198_;
  wire  _zz_199_;
  reg  CsrPlugin_interrupt;
  reg [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  reg [1:0] CsrPlugin_interruptTargetPrivilege;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_lastStageWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  CsrPlugin_hadException;
  reg [1:0] CsrPlugin_targetPrivilege;
  reg [3:0] CsrPlugin_trapCause;
  reg [1:0] CsrPlugin_xtvec_mode;
  reg [29:0] CsrPlugin_xtvec_base;
  wire  execute_CsrPlugin_inWfi /* verilator public */ ;
  wire  execute_CsrPlugin_blockedBySideEffects;
  reg  execute_CsrPlugin_illegalAccess;
  reg  execute_CsrPlugin_illegalInstruction;
  reg [31:0] execute_CsrPlugin_readData;
  wire  execute_CsrPlugin_writeInstruction;
  wire  execute_CsrPlugin_readInstruction;
  wire  execute_CsrPlugin_writeEnable;
  wire  execute_CsrPlugin_readEnable;
  wire [31:0] execute_CsrPlugin_readToWriteData;
  reg [31:0] execute_CsrPlugin_writeData;
  wire [11:0] execute_CsrPlugin_csrAddress;
  reg  execute_MulPlugin_aSigned;
  reg  execute_MulPlugin_bSigned;
  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg [32:0] memory_DivPlugin_rs1;
  reg [31:0] memory_DivPlugin_rs2;
  reg [64:0] memory_DivPlugin_accumulator;
  reg  memory_DivPlugin_div_needRevert;
  reg  memory_DivPlugin_div_counter_willIncrement;
  reg  memory_DivPlugin_div_counter_willClear;
  reg [5:0] memory_DivPlugin_div_counter_valueNext;
  reg [5:0] memory_DivPlugin_div_counter_value;
  wire  memory_DivPlugin_div_counter_willOverflowIfInc;
  wire  memory_DivPlugin_div_counter_willOverflow;
  reg  memory_DivPlugin_div_done;
  reg [31:0] memory_DivPlugin_div_result;
  wire [31:0] _zz_200_;
  wire [32:0] _zz_201_;
  wire [32:0] _zz_202_;
  wire [31:0] _zz_203_;
  wire  _zz_204_;
  wire  _zz_205_;
  reg [32:0] _zz_206_;
  reg [31:0] _zz_207_;
  reg [31:0] externalInterruptArray_regNext;
  wire [31:0] _zz_208_;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg `Src2CtrlEnum_defaultEncoding_type decode_to_execute_SRC2_CTRL;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg [33:0] execute_to_memory_MUL_HL;
  reg  decode_to_execute_IS_CSR;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg [31:0] decode_to_execute_RS2;
  reg `Src1CtrlEnum_defaultEncoding_type decode_to_execute_SRC1_CTRL;
  reg  decode_to_execute_SRC2_FORCE_ZERO;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg [31:0] decode_to_execute_RS1;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg  decode_to_execute_MEMORY_MANAGMENT;
  reg [33:0] execute_to_memory_MUL_LH;
  reg [31:0] execute_to_memory_MUL_LL;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg [31:0] execute_to_memory_SHIFT_RIGHT;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg  execute_to_memory_BRANCH_DO;
  reg `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg `ShiftCtrlEnum_defaultEncoding_type execute_to_memory_SHIFT_CTRL;
  reg  decode_to_execute_MEMORY_WR;
  reg  execute_to_memory_MEMORY_WR;
  reg  memory_to_writeBack_MEMORY_WR;
  reg [2:0] _zz_209_;
  reg  _zz_210_;
  reg [31:0] iBusWishbone_DAT_MISO_regNext;
  reg [2:0] _zz_211_;
  wire  _zz_212_;
  wire  _zz_213_;
  wire  _zz_214_;
  wire  _zz_215_;
  wire  _zz_216_;
  reg  _zz_217_;
  reg [31:0] dBusWishbone_DAT_MISO_regNext;
  `ifndef SYNTHESIS
  reg [71:0] _zz_1__string;
  reg [71:0] _zz_2__string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_3__string;
  reg [71:0] _zz_4__string;
  reg [71:0] _zz_5__string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_6__string;
  reg [39:0] _zz_7__string;
  reg [39:0] _zz_8__string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_9__string;
  reg [63:0] _zz_10__string;
  reg [63:0] _zz_11__string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_12__string;
  reg [95:0] _zz_13__string;
  reg [95:0] _zz_14__string;
  reg [31:0] _zz_15__string;
  reg [31:0] _zz_16__string;
  reg [31:0] _zz_17__string;
  reg [31:0] _zz_18__string;
  reg [31:0] _zz_19__string;
  reg [31:0] _zz_20__string;
  reg [31:0] decode_ENV_CTRL_string;
  reg [31:0] _zz_21__string;
  reg [31:0] _zz_22__string;
  reg [31:0] _zz_23__string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_24__string;
  reg [23:0] _zz_25__string;
  reg [23:0] _zz_26__string;
  reg [31:0] memory_ENV_CTRL_string;
  reg [31:0] _zz_32__string;
  reg [31:0] execute_ENV_CTRL_string;
  reg [31:0] _zz_33__string;
  reg [31:0] writeBack_ENV_CTRL_string;
  reg [31:0] _zz_36__string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_39__string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_44__string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_46__string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_51__string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_53__string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_56__string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_58__string;
  reg [39:0] _zz_67__string;
  reg [31:0] _zz_72__string;
  reg [23:0] _zz_78__string;
  reg [31:0] _zz_80__string;
  reg [63:0] _zz_83__string;
  reg [95:0] _zz_84__string;
  reg [71:0] _zz_86__string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_95__string;
  reg [71:0] _zz_153__string;
  reg [95:0] _zz_154__string;
  reg [63:0] _zz_155__string;
  reg [31:0] _zz_156__string;
  reg [23:0] _zz_157__string;
  reg [31:0] _zz_158__string;
  reg [39:0] _zz_159__string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  reg [31:0] decode_to_execute_ENV_CTRL_string;
  reg [31:0] execute_to_memory_ENV_CTRL_string;
  reg [31:0] memory_to_writeBack_ENV_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign _zz_241_ = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_242_ = (! memory_DivPlugin_div_done);
  assign _zz_243_ = ({decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid} != (2'b00));
  assign _zz_244_ = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign _zz_245_ = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign _zz_246_ = writeBack_INSTRUCTION[29 : 28];
  assign _zz_247_ = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_248_ = (! memory_arbitration_isStuck);
  assign _zz_249_ = (iBus_cmd_valid || (_zz_209_ != (3'b000)));
  assign _zz_250_ = (_zz_237_ && (! dataCache_1__io_mem_cmd_s2mPipe_ready));
  assign _zz_251_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_252_ = execute_INSTRUCTION[13];
  assign _zz_253_ = execute_INSTRUCTION[13 : 12];
  assign _zz_254_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_255_ = (_zz_101_ - (5'b00001));
  assign _zz_256_ = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_257_ = {29'd0, _zz_256_};
  assign _zz_258_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_259_ = {{_zz_119_,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_260_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_261_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_262_ = {{_zz_121_,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz_263_ = {{_zz_123_,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_264_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_265_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_266_ = (writeBack_MEMORY_WR ? (3'b111) : (3'b101));
  assign _zz_267_ = (writeBack_MEMORY_WR ? (3'b110) : (3'b100));
  assign _zz_268_ = _zz_148_[0 : 0];
  assign _zz_269_ = _zz_148_[3 : 3];
  assign _zz_270_ = _zz_148_[8 : 8];
  assign _zz_271_ = _zz_148_[9 : 9];
  assign _zz_272_ = _zz_148_[11 : 11];
  assign _zz_273_ = _zz_148_[14 : 14];
  assign _zz_274_ = _zz_148_[15 : 15];
  assign _zz_275_ = _zz_148_[16 : 16];
  assign _zz_276_ = _zz_148_[18 : 18];
  assign _zz_277_ = _zz_148_[19 : 19];
  assign _zz_278_ = _zz_148_[22 : 22];
  assign _zz_279_ = _zz_148_[23 : 23];
  assign _zz_280_ = _zz_148_[24 : 24];
  assign _zz_281_ = _zz_148_[25 : 25];
  assign _zz_282_ = _zz_148_[28 : 28];
  assign _zz_283_ = _zz_148_[29 : 29];
  assign _zz_284_ = _zz_148_[30 : 30];
  assign _zz_285_ = execute_SRC_LESS;
  assign _zz_286_ = (3'b100);
  assign _zz_287_ = execute_INSTRUCTION[19 : 15];
  assign _zz_288_ = execute_INSTRUCTION[31 : 20];
  assign _zz_289_ = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_290_ = ($signed(_zz_291_) + $signed(_zz_294_));
  assign _zz_291_ = ($signed(_zz_292_) + $signed(_zz_293_));
  assign _zz_292_ = execute_SRC1;
  assign _zz_293_ = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_294_ = (execute_SRC_USE_SUB_LESS ? _zz_295_ : _zz_296_);
  assign _zz_295_ = (32'b00000000000000000000000000000001);
  assign _zz_296_ = (32'b00000000000000000000000000000000);
  assign _zz_297_ = ($signed(_zz_299_) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_298_ = _zz_297_[31 : 0];
  assign _zz_299_ = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_300_ = execute_INSTRUCTION[31 : 20];
  assign _zz_301_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_302_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_303_ = {_zz_186_,execute_INSTRUCTION[31 : 20]};
  assign _zz_304_ = {{_zz_188_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz_305_ = {{_zz_190_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_306_ = execute_INSTRUCTION[31 : 20];
  assign _zz_307_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_308_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_309_ = (3'b100);
  assign _zz_310_ = (_zz_198_ & (~ _zz_311_));
  assign _zz_311_ = (_zz_198_ - (2'b01));
  assign _zz_312_ = ($signed(_zz_313_) + $signed(_zz_318_));
  assign _zz_313_ = ($signed(_zz_314_) + $signed(_zz_316_));
  assign _zz_314_ = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_315_ = {1'b0,memory_MUL_LL};
  assign _zz_316_ = {{19{_zz_315_[32]}}, _zz_315_};
  assign _zz_317_ = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_318_ = {{2{_zz_317_[49]}}, _zz_317_};
  assign _zz_319_ = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_320_ = {{2{_zz_319_[49]}}, _zz_319_};
  assign _zz_321_ = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_322_ = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_323_ = writeBack_MUL_LOW[31 : 0];
  assign _zz_324_ = writeBack_MulPlugin_result[63 : 32];
  assign _zz_325_ = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_326_ = {5'd0, _zz_325_};
  assign _zz_327_ = {1'd0, memory_DivPlugin_rs2};
  assign _zz_328_ = {_zz_200_,(! _zz_202_[32])};
  assign _zz_329_ = _zz_202_[31:0];
  assign _zz_330_ = _zz_201_[31:0];
  assign _zz_331_ = _zz_332_;
  assign _zz_332_ = _zz_333_;
  assign _zz_333_ = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_203_) : _zz_203_)} + _zz_335_);
  assign _zz_334_ = memory_DivPlugin_div_needRevert;
  assign _zz_335_ = {32'd0, _zz_334_};
  assign _zz_336_ = _zz_205_;
  assign _zz_337_ = {32'd0, _zz_336_};
  assign _zz_338_ = _zz_204_;
  assign _zz_339_ = {31'd0, _zz_338_};
  assign _zz_340_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_341_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_342_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_343_ = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_344_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_345_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_346_ = (iBus_cmd_payload_address >>> 5);
  assign _zz_347_ = 1'b1;
  assign _zz_348_ = 1'b1;
  assign _zz_349_ = {_zz_104_,{_zz_106_,_zz_105_}};
  assign _zz_350_ = decode_INSTRUCTION[31];
  assign _zz_351_ = decode_INSTRUCTION[31];
  assign _zz_352_ = decode_INSTRUCTION[7];
  assign _zz_353_ = ((decode_INSTRUCTION & (32'b00000000000000000001000000010000)) == (32'b00000000000000000001000000010000));
  assign _zz_354_ = ((decode_INSTRUCTION & _zz_364_) == (32'b00000000000000000010000000010000));
  assign _zz_355_ = {(_zz_365_ == _zz_366_),{_zz_367_,_zz_368_}};
  assign _zz_356_ = (decode_INSTRUCTION & (32'b00000010000000000100000001110100));
  assign _zz_357_ = (32'b00000010000000000000000000110000);
  assign _zz_358_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001100100)) == (32'b00000000000000000000000000100100));
  assign _zz_359_ = ((decode_INSTRUCTION & _zz_369_) == (32'b00000000000000000001000000000000));
  assign _zz_360_ = (1'b0);
  assign _zz_361_ = ((_zz_370_ == _zz_371_) != (1'b0));
  assign _zz_362_ = ({_zz_372_,_zz_373_} != (2'b00));
  assign _zz_363_ = {(_zz_374_ != _zz_375_),{_zz_376_,{_zz_377_,_zz_378_}}};
  assign _zz_364_ = (32'b00000000000000000010000000010000);
  assign _zz_365_ = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_366_ = (32'b00000000000000000000000000010000);
  assign _zz_367_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000001100)) == (32'b00000000000000000000000000000100));
  assign _zz_368_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000101000)) == (32'b00000000000000000000000000000000));
  assign _zz_369_ = (32'b00000000000000000001000000000000);
  assign _zz_370_ = (decode_INSTRUCTION & (32'b00000000000000000011000000000000));
  assign _zz_371_ = (32'b00000000000000000010000000000000);
  assign _zz_372_ = ((decode_INSTRUCTION & _zz_379_) == (32'b00000000000000000000000000100000));
  assign _zz_373_ = ((decode_INSTRUCTION & _zz_380_) == (32'b00000000000000000000000000100000));
  assign _zz_374_ = _zz_149_;
  assign _zz_375_ = (1'b0);
  assign _zz_376_ = ({_zz_381_,{_zz_382_,_zz_383_}} != (4'b0000));
  assign _zz_377_ = ({_zz_384_,_zz_385_} != (5'b00000));
  assign _zz_378_ = {(_zz_386_ != _zz_387_),{_zz_388_,{_zz_389_,_zz_390_}}};
  assign _zz_379_ = (32'b00000000000000000000000000110100);
  assign _zz_380_ = (32'b00000000000000000000000001100100);
  assign _zz_381_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000000));
  assign _zz_382_ = ((decode_INSTRUCTION & _zz_391_) == (32'b00000000000000000000000000000000));
  assign _zz_383_ = {(_zz_392_ == _zz_393_),(_zz_394_ == _zz_395_)};
  assign _zz_384_ = _zz_151_;
  assign _zz_385_ = {(_zz_396_ == _zz_397_),{_zz_398_,{_zz_399_,_zz_400_}}};
  assign _zz_386_ = {_zz_152_,(_zz_401_ == _zz_402_)};
  assign _zz_387_ = (2'b00);
  assign _zz_388_ = ((_zz_403_ == _zz_404_) != (1'b0));
  assign _zz_389_ = (_zz_405_ != (1'b0));
  assign _zz_390_ = {(_zz_406_ != _zz_407_),{_zz_408_,{_zz_409_,_zz_410_}}};
  assign _zz_391_ = (32'b00000000000000000000000000011000);
  assign _zz_392_ = (decode_INSTRUCTION & (32'b00000000000000000110000000000100));
  assign _zz_393_ = (32'b00000000000000000010000000000000);
  assign _zz_394_ = (decode_INSTRUCTION & (32'b00000000000000000101000000000100));
  assign _zz_395_ = (32'b00000000000000000001000000000000);
  assign _zz_396_ = (decode_INSTRUCTION & (32'b00000000000000000010000000110000));
  assign _zz_397_ = (32'b00000000000000000010000000010000);
  assign _zz_398_ = ((decode_INSTRUCTION & _zz_411_) == (32'b00000000000000000000000000010000));
  assign _zz_399_ = (_zz_412_ == _zz_413_);
  assign _zz_400_ = (_zz_414_ == _zz_415_);
  assign _zz_401_ = (decode_INSTRUCTION & (32'b00000000000000000000000000011100));
  assign _zz_402_ = (32'b00000000000000000000000000000100);
  assign _zz_403_ = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_404_ = (32'b00000000000000000000000001000000);
  assign _zz_405_ = ((decode_INSTRUCTION & _zz_416_) == (32'b00000000000000000000000000000000));
  assign _zz_406_ = {_zz_417_,{_zz_418_,_zz_419_}};
  assign _zz_407_ = (5'b00000);
  assign _zz_408_ = ({_zz_420_,_zz_421_} != (3'b000));
  assign _zz_409_ = (_zz_422_ != _zz_423_);
  assign _zz_410_ = {_zz_424_,{_zz_425_,_zz_426_}};
  assign _zz_411_ = (32'b00000000000000000001000000110000);
  assign _zz_412_ = (decode_INSTRUCTION & (32'b00000010000000000010000001100000));
  assign _zz_413_ = (32'b00000000000000000010000000100000);
  assign _zz_414_ = (decode_INSTRUCTION & (32'b00000010000000000011000000100000));
  assign _zz_415_ = (32'b00000000000000000000000000100000);
  assign _zz_416_ = (32'b00000000000000000000000001011000);
  assign _zz_417_ = ((decode_INSTRUCTION & _zz_427_) == (32'b00000000000000000000000001000000));
  assign _zz_418_ = _zz_151_;
  assign _zz_419_ = {_zz_428_,{_zz_429_,_zz_430_}};
  assign _zz_420_ = (_zz_431_ == _zz_432_);
  assign _zz_421_ = {_zz_433_,_zz_434_};
  assign _zz_422_ = (_zz_435_ == _zz_436_);
  assign _zz_423_ = (1'b0);
  assign _zz_424_ = ({_zz_437_,_zz_438_} != (3'b000));
  assign _zz_425_ = (_zz_439_ != _zz_440_);
  assign _zz_426_ = {_zz_441_,{_zz_442_,_zz_443_}};
  assign _zz_427_ = (32'b00000000000000000000000001000000);
  assign _zz_428_ = ((decode_INSTRUCTION & _zz_444_) == (32'b00000000000000000100000000100000));
  assign _zz_429_ = (_zz_445_ == _zz_446_);
  assign _zz_430_ = (_zz_447_ == _zz_448_);
  assign _zz_431_ = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_432_ = (32'b00000000000000000000000001000000);
  assign _zz_433_ = ((decode_INSTRUCTION & _zz_449_) == (32'b00000000000000000000000001000000));
  assign _zz_434_ = ((decode_INSTRUCTION & _zz_450_) == (32'b00000000000000000000000000000000));
  assign _zz_435_ = (decode_INSTRUCTION & (32'b00000010000000000100000001100100));
  assign _zz_436_ = (32'b00000010000000000100000000100000);
  assign _zz_437_ = (_zz_451_ == _zz_452_);
  assign _zz_438_ = {_zz_453_,_zz_454_};
  assign _zz_439_ = (_zz_455_ == _zz_456_);
  assign _zz_440_ = (1'b0);
  assign _zz_441_ = ({_zz_457_,_zz_458_} != (2'b00));
  assign _zz_442_ = (_zz_459_ != _zz_460_);
  assign _zz_443_ = {_zz_461_,{_zz_462_,_zz_463_}};
  assign _zz_444_ = (32'b00000000000000000100000000100000);
  assign _zz_445_ = (decode_INSTRUCTION & (32'b00000000000000000000000000110000));
  assign _zz_446_ = (32'b00000000000000000000000000010000);
  assign _zz_447_ = (decode_INSTRUCTION & (32'b00000010000000000000000000100000));
  assign _zz_448_ = (32'b00000000000000000000000000100000);
  assign _zz_449_ = (32'b00000000000000000011000001000000);
  assign _zz_450_ = (32'b00000000000000000000000000111000);
  assign _zz_451_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_452_ = (32'b00000000000000000000000001000000);
  assign _zz_453_ = ((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000));
  assign _zz_454_ = ((decode_INSTRUCTION & (32'b01000000000000000000000000110100)) == (32'b01000000000000000000000000110000));
  assign _zz_455_ = (decode_INSTRUCTION & (32'b00000000000000000000000000100000));
  assign _zz_456_ = (32'b00000000000000000000000000100000);
  assign _zz_457_ = _zz_151_;
  assign _zz_458_ = ((decode_INSTRUCTION & _zz_464_) == (32'b00000000000000000000000000100000));
  assign _zz_459_ = {_zz_151_,(_zz_465_ == _zz_466_)};
  assign _zz_460_ = (2'b00);
  assign _zz_461_ = ((_zz_467_ == _zz_468_) != (1'b0));
  assign _zz_462_ = (_zz_469_ != (1'b0));
  assign _zz_463_ = {(_zz_470_ != _zz_471_),{_zz_472_,{_zz_473_,_zz_474_}}};
  assign _zz_464_ = (32'b00000000000000000000000001110000);
  assign _zz_465_ = (decode_INSTRUCTION & (32'b00000000000000000000000000100000));
  assign _zz_466_ = (32'b00000000000000000000000000000000);
  assign _zz_467_ = (decode_INSTRUCTION & (32'b00000000000000000101000001001000));
  assign _zz_468_ = (32'b00000000000000000001000000001000);
  assign _zz_469_ = ((decode_INSTRUCTION & (32'b00000000000000000011000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_470_ = {(_zz_475_ == _zz_476_),(_zz_477_ == _zz_478_)};
  assign _zz_471_ = (2'b00);
  assign _zz_472_ = ({_zz_479_,_zz_480_} != (2'b00));
  assign _zz_473_ = (_zz_481_ != (1'b0));
  assign _zz_474_ = {(_zz_482_ != _zz_483_),{_zz_484_,{_zz_485_,_zz_486_}}};
  assign _zz_475_ = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_476_ = (32'b00000000000000000001000001010000);
  assign _zz_477_ = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_478_ = (32'b00000000000000000010000001010000);
  assign _zz_479_ = ((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000000000));
  assign _zz_480_ = ((decode_INSTRUCTION & (32'b00000000000000000101000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_481_ = ((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000100000000010000));
  assign _zz_482_ = ((decode_INSTRUCTION & _zz_487_) == (32'b00000000000000000010000000010000));
  assign _zz_483_ = (1'b0);
  assign _zz_484_ = ({_zz_488_,_zz_150_} != (2'b00));
  assign _zz_485_ = ({_zz_489_,_zz_490_} != (2'b00));
  assign _zz_486_ = {(_zz_491_ != _zz_492_),{_zz_493_,{_zz_494_,_zz_495_}}};
  assign _zz_487_ = (32'b00000000000000000110000000010100);
  assign _zz_488_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_489_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100));
  assign _zz_490_ = _zz_150_;
  assign _zz_491_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001001000)) == (32'b00000000000000000100000000001000));
  assign _zz_492_ = (1'b0);
  assign _zz_493_ = ({(_zz_496_ == _zz_497_),(_zz_498_ == _zz_499_)} != (2'b00));
  assign _zz_494_ = ({_zz_500_,{_zz_501_,_zz_502_}} != (3'b000));
  assign _zz_495_ = (_zz_149_ != (1'b0));
  assign _zz_496_ = (decode_INSTRUCTION & (32'b00000000000000000111000000110100));
  assign _zz_497_ = (32'b00000000000000000101000000010000);
  assign _zz_498_ = (decode_INSTRUCTION & (32'b00000010000000000111000001100100));
  assign _zz_499_ = (32'b00000000000000000101000000100000);
  assign _zz_500_ = ((decode_INSTRUCTION & (32'b01000000000000000011000001010100)) == (32'b01000000000000000001000000010000));
  assign _zz_501_ = ((decode_INSTRUCTION & (32'b00000000000000000111000000110100)) == (32'b00000000000000000001000000010000));
  assign _zz_502_ = ((decode_INSTRUCTION & (32'b00000010000000000111000001010100)) == (32'b00000000000000000001000000010000));
  assign _zz_503_ = (32'b00000000000000000001000001111111);
  assign _zz_504_ = (decode_INSTRUCTION & (32'b00000000000000000010000001111111));
  assign _zz_505_ = (32'b00000000000000000010000001110011);
  assign _zz_506_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011));
  assign _zz_507_ = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_508_ = {((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_509_) == (32'b00000000000000000000000000000011)),{(_zz_510_ == _zz_511_),{_zz_512_,{_zz_513_,_zz_514_}}}}}};
  assign _zz_509_ = (32'b00000000000000000101000001011111);
  assign _zz_510_ = (decode_INSTRUCTION & (32'b00000000000000000111000001111011));
  assign _zz_511_ = (32'b00000000000000000000000001100011);
  assign _zz_512_ = ((decode_INSTRUCTION & (32'b00000000000000000110000001111111)) == (32'b00000000000000000000000000001111));
  assign _zz_513_ = ((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_514_ = {((decode_INSTRUCTION & (32'b00000001111100000111000001111111)) == (32'b00000000000000000101000000001111)),{((decode_INSTRUCTION & (32'b10111100000000000111000001111111)) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & _zz_515_) == (32'b00000000000000000001000000010011)),{(_zz_516_ == _zz_517_),{_zz_518_,_zz_519_}}}}};
  assign _zz_515_ = (32'b11111100000000000011000001111111);
  assign _zz_516_ = (decode_INSTRUCTION & (32'b10111110000000000111000001111111));
  assign _zz_517_ = (32'b00000000000000000101000000110011);
  assign _zz_518_ = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_519_ = ((decode_INSTRUCTION & (32'b11011111111111111111111111111111)) == (32'b00010000001000000000000001110011));
  assign _zz_520_ = execute_INSTRUCTION[31];
  assign _zz_521_ = execute_INSTRUCTION[31];
  assign _zz_522_ = execute_INSTRUCTION[7];
  always @ (posedge clk) begin
    if(_zz_61_) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_347_) begin
      _zz_238_ <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_348_) begin
      _zz_239_ <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush(_zz_218_),
    .io_cpu_prefetch_isValid(_zz_219_),
    .io_cpu_prefetch_haltIt(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt),
    .io_cpu_prefetch_pc(IBusCachedPlugin_iBusRsp_stages_0_input_payload),
    .io_cpu_fetch_isValid(_zz_220_),
    .io_cpu_fetch_isStuck(_zz_221_),
    .io_cpu_fetch_isRemoved(_zz_222_),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_stages_1_input_payload),
    .io_cpu_fetch_data(IBusCachedPlugin_cache_io_cpu_fetch_data),
    .io_cpu_fetch_dataBypassValid(IBusCachedPlugin_s1_tightlyCoupledHit),
    .io_cpu_fetch_dataBypass(_zz_223_),
    .io_cpu_fetch_mmuBus_cmd_isValid(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(IBusCachedPlugin_mmuBus_rsp_physicalAddress),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(IBusCachedPlugin_mmuBus_rsp_isIoAccess),
    .io_cpu_fetch_mmuBus_rsp_allowRead(IBusCachedPlugin_mmuBus_rsp_allowRead),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(IBusCachedPlugin_mmuBus_rsp_allowWrite),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(IBusCachedPlugin_mmuBus_rsp_allowExecute),
    .io_cpu_fetch_mmuBus_rsp_exception(IBusCachedPlugin_mmuBus_rsp_exception),
    .io_cpu_fetch_mmuBus_rsp_refilling(IBusCachedPlugin_mmuBus_rsp_refilling),
    .io_cpu_fetch_mmuBus_end(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end),
    .io_cpu_fetch_mmuBus_busy(IBusCachedPlugin_mmuBus_busy),
    .io_cpu_fetch_physicalAddress(IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress),
    .io_cpu_fetch_haltIt(IBusCachedPlugin_cache_io_cpu_fetch_haltIt),
    .io_cpu_decode_isValid(_zz_224_),
    .io_cpu_decode_isStuck(_zz_225_),
    .io_cpu_decode_pc(IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload),
    .io_cpu_decode_physicalAddress(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
    .io_cpu_decode_data(IBusCachedPlugin_cache_io_cpu_decode_data),
    .io_cpu_decode_cacheMiss(IBusCachedPlugin_cache_io_cpu_decode_cacheMiss),
    .io_cpu_decode_error(IBusCachedPlugin_cache_io_cpu_decode_error),
    .io_cpu_decode_mmuRefilling(IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling),
    .io_cpu_decode_mmuException(IBusCachedPlugin_cache_io_cpu_decode_mmuException),
    .io_cpu_decode_isUser(_zz_226_),
    .io_cpu_fill_valid(_zz_227_),
    .io_cpu_fill_payload(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
    .io_mem_cmd_valid(IBusCachedPlugin_cache_io_mem_cmd_valid),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(IBusCachedPlugin_cache_io_mem_cmd_payload_address),
    .io_mem_cmd_payload_size(IBusCachedPlugin_cache_io_mem_cmd_payload_size),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  DataCache dataCache_1_ ( 
    .io_cpu_execute_isValid(_zz_228_),
    .io_cpu_execute_address(_zz_229_),
    .io_cpu_execute_args_wr(execute_MEMORY_WR),
    .io_cpu_execute_args_data(_zz_143_),
    .io_cpu_execute_args_size(execute_DBusCachedPlugin_size),
    .io_cpu_memory_isValid(_zz_230_),
    .io_cpu_memory_isStuck(memory_arbitration_isStuck),
    .io_cpu_memory_isRemoved(memory_arbitration_removeIt),
    .io_cpu_memory_isWrite(dataCache_1__io_cpu_memory_isWrite),
    .io_cpu_memory_address(_zz_231_),
    .io_cpu_memory_mmuBus_cmd_isValid(dataCache_1__io_cpu_memory_mmuBus_cmd_isValid),
    .io_cpu_memory_mmuBus_cmd_virtualAddress(dataCache_1__io_cpu_memory_mmuBus_cmd_virtualAddress),
    .io_cpu_memory_mmuBus_cmd_bypassTranslation(dataCache_1__io_cpu_memory_mmuBus_cmd_bypassTranslation),
    .io_cpu_memory_mmuBus_rsp_physicalAddress(DBusCachedPlugin_mmuBus_rsp_physicalAddress),
    .io_cpu_memory_mmuBus_rsp_isIoAccess(_zz_232_),
    .io_cpu_memory_mmuBus_rsp_allowRead(DBusCachedPlugin_mmuBus_rsp_allowRead),
    .io_cpu_memory_mmuBus_rsp_allowWrite(DBusCachedPlugin_mmuBus_rsp_allowWrite),
    .io_cpu_memory_mmuBus_rsp_allowExecute(DBusCachedPlugin_mmuBus_rsp_allowExecute),
    .io_cpu_memory_mmuBus_rsp_exception(DBusCachedPlugin_mmuBus_rsp_exception),
    .io_cpu_memory_mmuBus_rsp_refilling(DBusCachedPlugin_mmuBus_rsp_refilling),
    .io_cpu_memory_mmuBus_end(dataCache_1__io_cpu_memory_mmuBus_end),
    .io_cpu_memory_mmuBus_busy(DBusCachedPlugin_mmuBus_busy),
    .io_cpu_writeBack_isValid(_zz_233_),
    .io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
    .io_cpu_writeBack_isUser(_zz_234_),
    .io_cpu_writeBack_haltIt(dataCache_1__io_cpu_writeBack_haltIt),
    .io_cpu_writeBack_isWrite(dataCache_1__io_cpu_writeBack_isWrite),
    .io_cpu_writeBack_data(dataCache_1__io_cpu_writeBack_data),
    .io_cpu_writeBack_address(_zz_235_),
    .io_cpu_writeBack_mmuException(dataCache_1__io_cpu_writeBack_mmuException),
    .io_cpu_writeBack_unalignedAccess(dataCache_1__io_cpu_writeBack_unalignedAccess),
    .io_cpu_writeBack_accessError(dataCache_1__io_cpu_writeBack_accessError),
    .io_cpu_redo(dataCache_1__io_cpu_redo),
    .io_cpu_flush_valid(_zz_236_),
    .io_cpu_flush_ready(dataCache_1__io_cpu_flush_ready),
    .io_mem_cmd_valid(dataCache_1__io_mem_cmd_valid),
    .io_mem_cmd_ready(_zz_237_),
    .io_mem_cmd_payload_wr(dataCache_1__io_mem_cmd_payload_wr),
    .io_mem_cmd_payload_address(dataCache_1__io_mem_cmd_payload_address),
    .io_mem_cmd_payload_data(dataCache_1__io_mem_cmd_payload_data),
    .io_mem_cmd_payload_mask(dataCache_1__io_mem_cmd_payload_mask),
    .io_mem_cmd_payload_length(dataCache_1__io_mem_cmd_payload_length),
    .io_mem_cmd_payload_last(dataCache_1__io_mem_cmd_payload_last),
    .io_mem_rsp_valid(dBus_rsp_valid),
    .io_mem_rsp_payload_data(dBus_rsp_payload_data),
    .io_mem_rsp_payload_error(dBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_349_)
      3'b000 : begin
        _zz_240_ = DBusCachedPlugin_redoBranch_payload;
      end
      3'b001 : begin
        _zz_240_ = CsrPlugin_jumpInterface_payload;
      end
      3'b010 : begin
        _zz_240_ = BranchPlugin_jumpInterface_payload;
      end
      3'b011 : begin
        _zz_240_ = IBusCachedPlugin_redoBranch_payload;
      end
      default : begin
        _zz_240_ = IBusCachedPlugin_pcs_4;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_1_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_1__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_1__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_1__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_1__string = "SRA_1    ";
      default : _zz_1__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_2_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_2__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_2__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_2__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_2__string = "SRA_1    ";
      default : _zz_2__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_3_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_3__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_3__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_3__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_3__string = "SRA_1    ";
      default : _zz_3__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_4_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_4__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_4__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_4__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_4__string = "SRA_1    ";
      default : _zz_4__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_5_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_5__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_5__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_5__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_5__string = "SRA_1    ";
      default : _zz_5__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_6_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_6__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_6__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_6__string = "AND_1";
      default : _zz_6__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_7_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_7__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_7__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_7__string = "AND_1";
      default : _zz_7__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_8_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_8__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_8__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_8__string = "AND_1";
      default : _zz_8__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_9_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_9__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_9__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_9__string = "BITWISE ";
      default : _zz_9__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_10_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_10__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_10__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_10__string = "BITWISE ";
      default : _zz_10__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_11_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_11__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_11__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_11__string = "BITWISE ";
      default : _zz_11__string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_12_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_12__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_12__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_12__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_12__string = "URS1        ";
      default : _zz_12__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_13_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_13__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_13__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_13__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_13__string = "URS1        ";
      default : _zz_13__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_14_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_14__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_14__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_14__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_14__string = "URS1        ";
      default : _zz_14__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_15_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_15__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_15__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_15__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_15__string = "JALR";
      default : _zz_15__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_16_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_16__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_16__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_16__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_16__string = "JALR";
      default : _zz_16__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_17_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_17__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_17__string = "XRET";
      default : _zz_17__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_18_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_18__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_18__string = "XRET";
      default : _zz_18__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_19_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_19__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_19__string = "XRET";
      default : _zz_19__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_20_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_20__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_20__string = "XRET";
      default : _zz_20__string = "????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_ENV_CTRL_string = "XRET";
      default : decode_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_21_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_21__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_21__string = "XRET";
      default : _zz_21__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_22_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_22__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_22__string = "XRET";
      default : _zz_22__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_23_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_23__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_23__string = "XRET";
      default : _zz_23__string = "????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_24_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_24__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_24__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_24__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_24__string = "PC ";
      default : _zz_24__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_25_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_25__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_25__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_25__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_25__string = "PC ";
      default : _zz_25__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_26_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_26__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_26__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_26__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_26__string = "PC ";
      default : _zz_26__string = "???";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_ENV_CTRL_string = "XRET";
      default : memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_32_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_32__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_32__string = "XRET";
      default : _zz_32__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_ENV_CTRL_string = "XRET";
      default : execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_33_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_33__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_33__string = "XRET";
      default : _zz_33__string = "????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : writeBack_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : writeBack_ENV_CTRL_string = "XRET";
      default : writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_36_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_36__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_36__string = "XRET";
      default : _zz_36__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_39_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_39__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_39__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_39__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_39__string = "JALR";
      default : _zz_39__string = "????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_44_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_44__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_44__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_44__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_44__string = "SRA_1    ";
      default : _zz_44__string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_46_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_46__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_46__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_46__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_46__string = "SRA_1    ";
      default : _zz_46__string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_51_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_51__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_51__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_51__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_51__string = "PC ";
      default : _zz_51__string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_53_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_53__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_53__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_53__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_53__string = "URS1        ";
      default : _zz_53__string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_56_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_56__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_56__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_56__string = "BITWISE ";
      default : _zz_56__string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_58_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_58__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_58__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_58__string = "AND_1";
      default : _zz_58__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_67_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_67__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_67__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_67__string = "AND_1";
      default : _zz_67__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_72_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_72__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_72__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_72__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_72__string = "JALR";
      default : _zz_72__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_78_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_78__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_78__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_78__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_78__string = "PC ";
      default : _zz_78__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_80_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_80__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_80__string = "XRET";
      default : _zz_80__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_83_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_83__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_83__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_83__string = "BITWISE ";
      default : _zz_83__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_84_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_84__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_84__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_84__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_84__string = "URS1        ";
      default : _zz_84__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_86_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_86__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_86__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_86__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_86__string = "SRA_1    ";
      default : _zz_86__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_95_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_95__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_95__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_95__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_95__string = "JALR";
      default : _zz_95__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_153_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_153__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_153__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_153__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_153__string = "SRA_1    ";
      default : _zz_153__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_154_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_154__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_154__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_154__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_154__string = "URS1        ";
      default : _zz_154__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_155_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_155__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_155__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_155__string = "BITWISE ";
      default : _zz_155__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_156_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_156__string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_156__string = "XRET";
      default : _zz_156__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_157_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_157__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_157__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_157__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_157__string = "PC ";
      default : _zz_157__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_158_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_158__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_158__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_158__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_158__string = "JALR";
      default : _zz_158__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_159_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_159__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_159__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_159__string = "AND_1";
      default : _zz_159__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_to_execute_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_to_execute_ENV_CTRL_string = "XRET";
      default : decode_to_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_to_memory_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_to_memory_ENV_CTRL_string = "XRET";
      default : execute_to_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET";
      default : memory_to_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  `endif

  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_77_;
  assign _zz_1_ = _zz_2_;
  assign decode_SHIFT_CTRL = _zz_3_;
  assign _zz_4_ = _zz_5_;
  assign decode_ALU_BITWISE_CTRL = _zz_6_;
  assign _zz_7_ = _zz_8_;
  assign execute_BRANCH_DO = _zz_38_;
  assign decode_ALU_CTRL = _zz_9_;
  assign _zz_10_ = _zz_11_;
  assign execute_REGFILE_WRITE_DATA = _zz_57_;
  assign execute_SHIFT_RIGHT = _zz_45_;
  assign decode_IS_RS2_SIGNED = _zz_87_;
  assign decode_CSR_READ_OPCODE = _zz_34_;
  assign decode_IS_RS1_SIGNED = _zz_69_;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_28_;
  assign memory_MUL_LOW = _zz_27_;
  assign decode_IS_DIV = _zz_75_;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_74_;
  assign memory_PC = execute_to_memory_PC;
  assign execute_BRANCH_CALC = _zz_37_;
  assign execute_MUL_LL = _zz_31_;
  assign execute_MUL_LH = _zz_30_;
  assign decode_MEMORY_MANAGMENT = _zz_85_;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_71_;
  assign decode_CSR_WRITE_OPCODE = _zz_35_;
  assign decode_SRC2_FORCE_ZERO = _zz_55_;
  assign decode_SRC1_CTRL = _zz_12_;
  assign _zz_13_ = _zz_14_;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_65_;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_41_;
  assign decode_IS_CSR = _zz_81_;
  assign execute_MUL_HL = _zz_29_;
  assign _zz_15_ = _zz_16_;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_98_;
  assign _zz_17_ = _zz_18_;
  assign _zz_19_ = _zz_20_;
  assign decode_ENV_CTRL = _zz_21_;
  assign _zz_22_ = _zz_23_;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_90_;
  assign decode_SRC2_CTRL = _zz_24_;
  assign _zz_25_ = _zz_26_;
  assign decode_SRC_LESS_UNSIGNED = _zz_82_;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_32_;
  assign execute_ENV_CTRL = _zz_33_;
  assign writeBack_ENV_CTRL = _zz_36_;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_BRANCH_COND_RESULT = _zz_40_;
  assign execute_BRANCH_CTRL = _zz_39_;
  assign decode_RS2_USE = _zz_68_;
  assign decode_RS1_USE = _zz_70_;
  always @ (*) begin
    _zz_42_ = execute_REGFILE_WRITE_DATA;
    execute_arbitration_haltItself = 1'b0;
    if((_zz_236_ && (! dataCache_1__io_cpu_flush_ready)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(((dataCache_1__io_cpu_redo && execute_arbitration_isValid) && execute_MEMORY_ENABLE))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_42_ = execute_CsrPlugin_readData;
      if(execute_CsrPlugin_blockedBySideEffects)begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_62_;
    decode_RS1 = _zz_63_;
    if(_zz_173_)begin
      if((_zz_174_ == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_175_;
      end
      if((_zz_174_ == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_175_;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(1'b1)begin
        if(_zz_176_)begin
          decode_RS1 = _zz_89_;
        end
        if(_zz_177_)begin
          decode_RS2 = _zz_89_;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_178_)begin
          decode_RS1 = _zz_43_;
        end
        if(_zz_179_)begin
          decode_RS2 = _zz_43_;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_180_)begin
          decode_RS1 = _zz_42_;
        end
        if(_zz_181_)begin
          decode_RS2 = _zz_42_;
        end
      end
    end
  end

  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @ (*) begin
    _zz_43_ = memory_REGFILE_WRITE_DATA;
    memory_arbitration_haltItself = 1'b0;
    if(memory_arbitration_isValid)begin
      case(memory_SHIFT_CTRL)
        `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
          _zz_43_ = _zz_169_;
        end
        `ShiftCtrlEnum_defaultEncoding_SRL_1, `ShiftCtrlEnum_defaultEncoding_SRA_1 : begin
          _zz_43_ = memory_SHIFT_RIGHT;
        end
        default : begin
        end
      endcase
    end
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_241_)begin
      if(_zz_242_)begin
        memory_arbitration_haltItself = 1'b1;
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_43_ = memory_DivPlugin_div_result;
    end
  end

  assign memory_SHIFT_CTRL = _zz_44_;
  assign execute_SHIFT_CTRL = _zz_46_;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_50_ = execute_PC;
  assign execute_SRC2_CTRL = _zz_51_;
  assign execute_SRC1_CTRL = _zz_53_;
  assign decode_SRC_USE_SUB_LESS = _zz_76_;
  assign decode_SRC_ADD_ZERO = _zz_66_;
  assign execute_SRC_ADD_SUB = _zz_49_;
  assign execute_SRC_LESS = _zz_47_;
  assign execute_ALU_CTRL = _zz_56_;
  assign execute_SRC2 = _zz_52_;
  assign execute_SRC1 = _zz_54_;
  assign execute_ALU_BITWISE_CTRL = _zz_58_;
  assign _zz_59_ = writeBack_INSTRUCTION;
  assign _zz_60_ = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_61_ = 1'b0;
    if(lastStageRegFileWrite_valid)begin
      _zz_61_ = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_94_;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_64_;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_88_;
  assign decode_INSTRUCTION_READY = 1'b1;
  always @ (*) begin
    _zz_89_ = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_89_ = writeBack_DBusCachedPlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_254_)
        2'b00 : begin
          _zz_89_ = _zz_323_;
        end
        default : begin
          _zz_89_ = _zz_324_;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_SRC_ADD = _zz_48_;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign decode_MEMORY_ENABLE = _zz_73_;
  assign decode_FLUSH_ALL = _zz_79_;
  always @ (*) begin
    IBusCachedPlugin_rsp_issueDetected = _zz_91_;
    _zz_92_ = _zz_93_;
    IBusCachedPlugin_decodeExceptionPort_valid = 1'b0;
    IBusCachedPlugin_decodeExceptionPort_payload_code = (4'bxxxx);
    if(((_zz_224_ && IBusCachedPlugin_cache_io_cpu_decode_mmuException) && (! _zz_93_)))begin
      _zz_92_ = 1'b1;
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
      IBusCachedPlugin_decodeExceptionPort_payload_code = (4'b1100);
    end
    if(((_zz_224_ && IBusCachedPlugin_cache_io_cpu_decode_error) && (! _zz_91_)))begin
      IBusCachedPlugin_rsp_issueDetected = 1'b1;
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
      IBusCachedPlugin_decodeExceptionPort_payload_code = (4'b0001);
    end
    if(IBusCachedPlugin_fetcherHalt)begin
      IBusCachedPlugin_decodeExceptionPort_valid = 1'b0;
    end
  end

  always @ (*) begin
    _zz_91_ = _zz_92_;
    _zz_93_ = 1'b0;
    IBusCachedPlugin_rsp_redoFetch = 1'b0;
    _zz_227_ = (IBusCachedPlugin_rsp_redoFetch && (! IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling));
    if(((_zz_224_ && IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling) && (! 1'b0)))begin
      _zz_93_ = 1'b1;
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
    if(((_zz_224_ && IBusCachedPlugin_cache_io_cpu_decode_cacheMiss) && (! _zz_92_)))begin
      _zz_91_ = 1'b1;
      _zz_227_ = 1'b1;
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
    if((! IBusCachedPlugin_iBusRsp_readyForError))begin
      IBusCachedPlugin_rsp_redoFetch = 1'b0;
    end
    if((! IBusCachedPlugin_iBusRsp_readyForError))begin
      _zz_227_ = 1'b0;
    end
  end

  assign decode_BRANCH_CTRL = _zz_95_;
  assign decode_INSTRUCTION = _zz_99_;
  always @ (*) begin
    _zz_96_ = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid)begin
      _zz_96_ = BranchPlugin_jumpInterface_payload;
    end
  end

  always @ (*) begin
    _zz_97_ = decode_FORMAL_PC_NEXT;
    if(IBusCachedPlugin_predictionJumpInterface_valid)begin
      _zz_97_ = IBusCachedPlugin_pcs_4;
    end
    if(IBusCachedPlugin_redoBranch_valid)begin
      _zz_97_ = IBusCachedPlugin_redoBranch_payload;
    end
  end

  assign decode_PC = _zz_100_;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    if(((DBusCachedPlugin_mmuBus_busy && decode_arbitration_isValid) && decode_MEMORY_ENABLE))begin
      decode_arbitration_haltItself = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if((decode_arbitration_isValid && (_zz_170_ || _zz_171_)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_interrupt)begin
      decode_arbitration_haltByOther = decode_arbitration_isValid;
    end
    if(({(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))}} != (3'b000)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(_zz_243_)begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushAll = 1'b0;
  assign execute_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(BranchPlugin_jumpInterface_valid)begin
      execute_arbitration_flushAll = 1'b1;
    end
    if(BranchPlugin_branchExceptionPort_valid)begin
      execute_arbitration_flushAll = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(BranchPlugin_branchExceptionPort_valid)begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_flushAll = 1'b0;
    writeBack_arbitration_removeIt = 1'b0;
    IBusCachedPlugin_fetcherHalt = 1'b0;
    CsrPlugin_jumpInterface_valid = 1'b0;
    CsrPlugin_jumpInterface_payload = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(DBusCachedPlugin_exceptionBus_valid)begin
      memory_arbitration_flushAll = 1'b1;
      writeBack_arbitration_removeIt = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
    end
    if(writeBack_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode}}} != (4'b0000)))begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(_zz_244_)begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
      CsrPlugin_jumpInterface_valid = 1'b1;
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,(2'b00)};
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_245_)begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
      CsrPlugin_jumpInterface_valid = 1'b1;
      memory_arbitration_flushAll = 1'b1;
      case(_zz_246_)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        default : begin
        end
      endcase
    end
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(dataCache_1__io_cpu_writeBack_haltIt)begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_flushAll = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid)begin
      writeBack_arbitration_flushAll = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  assign IBusCachedPlugin_fetcherflushIt = 1'b0;
  always @ (*) begin
    IBusCachedPlugin_incomingInstruction = 1'b0;
    if((IBusCachedPlugin_iBusRsp_stages_1_input_valid || IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid))begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
  end

  assign CsrPlugin_forceMachineWire = 1'b0;
  assign CsrPlugin_allowInterrupts = 1'b1;
  assign CsrPlugin_allowException = 1'b1;
  assign IBusCachedPlugin_jump_pcLoad_valid = ({CsrPlugin_jumpInterface_valid,{BranchPlugin_jumpInterface_valid,{DBusCachedPlugin_redoBranch_valid,{IBusCachedPlugin_redoBranch_valid,IBusCachedPlugin_predictionJumpInterface_valid}}}} != (5'b00000));
  assign _zz_101_ = {IBusCachedPlugin_predictionJumpInterface_valid,{IBusCachedPlugin_redoBranch_valid,{BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,DBusCachedPlugin_redoBranch_valid}}}};
  assign _zz_102_ = (_zz_101_ & (~ _zz_255_));
  assign _zz_103_ = _zz_102_[3];
  assign _zz_104_ = _zz_102_[4];
  assign _zz_105_ = (_zz_102_[1] || _zz_103_);
  assign _zz_106_ = (_zz_102_[2] || _zz_103_);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_240_;
  assign _zz_107_ = (! IBusCachedPlugin_fetcherHalt);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_107_);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_107_);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_propagatePc = 1'b0;
    if((IBusCachedPlugin_iBusRsp_stages_1_input_valid && IBusCachedPlugin_iBusRsp_stages_1_input_ready))begin
      IBusCachedPlugin_fetchPc_propagatePc = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_257_);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_fetchPc_propagatePc)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_247_)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
    IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_108_;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_inputSample = 1'b1;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt)begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_109_ = (! IBusCachedPlugin_iBusRsp_stages_0_halt);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_output_ready && _zz_109_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_109_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_fetch_haltIt)begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_110_ = (! IBusCachedPlugin_iBusRsp_stages_1_halt);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_output_ready && _zz_110_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_110_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt = 1'b0;
    if((IBusCachedPlugin_rsp_issueDetected || IBusCachedPlugin_rsp_iBusRspOutputHalt))begin
      IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt = 1'b1;
    end
  end

  assign _zz_111_ = (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready && _zz_111_);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid && _zz_111_);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload = IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = _zz_112_;
  assign _zz_112_ = ((1'b0 && (! _zz_113_)) || IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_113_ = _zz_114_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_113_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! _zz_115_)) || IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready);
  assign _zz_115_ = _zz_116_;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid = _zz_115_;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload = _zz_117_;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
    if((! IBusCachedPlugin_pcValids_0))begin
      IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusCachedPlugin_pcValids_0 = IBusCachedPlugin_injector_nextPcCalc_valids_1;
  assign IBusCachedPlugin_pcValids_1 = IBusCachedPlugin_injector_nextPcCalc_valids_2;
  assign IBusCachedPlugin_pcValids_2 = IBusCachedPlugin_injector_nextPcCalc_valids_3;
  assign IBusCachedPlugin_pcValids_3 = IBusCachedPlugin_injector_nextPcCalc_valids_4;
  assign IBusCachedPlugin_iBusRsp_decodeInput_ready = (! decode_arbitration_isStuck);
  assign decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_decodeInput_valid && (! IBusCachedPlugin_injector_decodeRemoved));
  assign _zz_100_ = IBusCachedPlugin_iBusRsp_decodeInput_payload_pc;
  assign _zz_99_ = IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_inst;
  assign _zz_98_ = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_118_ = _zz_258_[11];
  always @ (*) begin
    _zz_119_[18] = _zz_118_;
    _zz_119_[17] = _zz_118_;
    _zz_119_[16] = _zz_118_;
    _zz_119_[15] = _zz_118_;
    _zz_119_[14] = _zz_118_;
    _zz_119_[13] = _zz_118_;
    _zz_119_[12] = _zz_118_;
    _zz_119_[11] = _zz_118_;
    _zz_119_[10] = _zz_118_;
    _zz_119_[9] = _zz_118_;
    _zz_119_[8] = _zz_118_;
    _zz_119_[7] = _zz_118_;
    _zz_119_[6] = _zz_118_;
    _zz_119_[5] = _zz_118_;
    _zz_119_[4] = _zz_118_;
    _zz_119_[3] = _zz_118_;
    _zz_119_[2] = _zz_118_;
    _zz_119_[1] = _zz_118_;
    _zz_119_[0] = _zz_118_;
  end

  always @ (*) begin
    IBusCachedPlugin_decodePrediction_cmd_hadBranch = ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_B) && _zz_259_[31]));
    if(_zz_124_)begin
      IBusCachedPlugin_decodePrediction_cmd_hadBranch = 1'b0;
    end
  end

  assign _zz_120_ = _zz_260_[19];
  always @ (*) begin
    _zz_121_[10] = _zz_120_;
    _zz_121_[9] = _zz_120_;
    _zz_121_[8] = _zz_120_;
    _zz_121_[7] = _zz_120_;
    _zz_121_[6] = _zz_120_;
    _zz_121_[5] = _zz_120_;
    _zz_121_[4] = _zz_120_;
    _zz_121_[3] = _zz_120_;
    _zz_121_[2] = _zz_120_;
    _zz_121_[1] = _zz_120_;
    _zz_121_[0] = _zz_120_;
  end

  assign _zz_122_ = _zz_261_[11];
  always @ (*) begin
    _zz_123_[18] = _zz_122_;
    _zz_123_[17] = _zz_122_;
    _zz_123_[16] = _zz_122_;
    _zz_123_[15] = _zz_122_;
    _zz_123_[14] = _zz_122_;
    _zz_123_[13] = _zz_122_;
    _zz_123_[12] = _zz_122_;
    _zz_123_[11] = _zz_122_;
    _zz_123_[10] = _zz_122_;
    _zz_123_[9] = _zz_122_;
    _zz_123_[8] = _zz_122_;
    _zz_123_[7] = _zz_122_;
    _zz_123_[6] = _zz_122_;
    _zz_123_[5] = _zz_122_;
    _zz_123_[4] = _zz_122_;
    _zz_123_[3] = _zz_122_;
    _zz_123_[2] = _zz_122_;
    _zz_123_[1] = _zz_122_;
    _zz_123_[0] = _zz_122_;
  end

  always @ (*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_124_ = _zz_262_[1];
      end
      default : begin
        _zz_124_ = _zz_263_[1];
      end
    endcase
  end

  assign IBusCachedPlugin_predictionJumpInterface_valid = (IBusCachedPlugin_decodePrediction_cmd_hadBranch && decode_arbitration_isFiring);
  assign _zz_125_ = _zz_264_[19];
  always @ (*) begin
    _zz_126_[10] = _zz_125_;
    _zz_126_[9] = _zz_125_;
    _zz_126_[8] = _zz_125_;
    _zz_126_[7] = _zz_125_;
    _zz_126_[6] = _zz_125_;
    _zz_126_[5] = _zz_125_;
    _zz_126_[4] = _zz_125_;
    _zz_126_[3] = _zz_125_;
    _zz_126_[2] = _zz_125_;
    _zz_126_[1] = _zz_125_;
    _zz_126_[0] = _zz_125_;
  end

  assign _zz_127_ = _zz_265_[11];
  always @ (*) begin
    _zz_128_[18] = _zz_127_;
    _zz_128_[17] = _zz_127_;
    _zz_128_[16] = _zz_127_;
    _zz_128_[15] = _zz_127_;
    _zz_128_[14] = _zz_127_;
    _zz_128_[13] = _zz_127_;
    _zz_128_[12] = _zz_127_;
    _zz_128_[11] = _zz_127_;
    _zz_128_[10] = _zz_127_;
    _zz_128_[9] = _zz_127_;
    _zz_128_[8] = _zz_127_;
    _zz_128_[7] = _zz_127_;
    _zz_128_[6] = _zz_127_;
    _zz_128_[5] = _zz_127_;
    _zz_128_[4] = _zz_127_;
    _zz_128_[3] = _zz_127_;
    _zz_128_[2] = _zz_127_;
    _zz_128_[1] = _zz_127_;
    _zz_128_[0] = _zz_127_;
  end

  assign IBusCachedPlugin_pcs_4 = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_126_,{{{_zz_350_,decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_128_,{{{_zz_351_,_zz_352_},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid;
  always @ (*) begin
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  end

  assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0;
  assign _zz_219_ = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && (! IBusCachedPlugin_s0_tightlyCoupledHit));
  assign _zz_222_ = (IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt);
  assign _zz_223_ = (32'b00000000000000000000000000000000);
  assign _zz_220_ = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && (! IBusCachedPlugin_s1_tightlyCoupledHit));
  assign _zz_221_ = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_224_ = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid && (! IBusCachedPlugin_s2_tightlyCoupledHit));
  assign _zz_225_ = (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready);
  assign _zz_226_ = (CsrPlugin_privilege == (2'b00));
  assign _zz_94_ = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusCachedPlugin_cache_io_cpu_fetch_data);
  assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0;
  assign IBusCachedPlugin_decodeExceptionPort_payload_badAddr = {IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload[31 : 2],(2'b00)};
  assign IBusCachedPlugin_redoBranch_valid = IBusCachedPlugin_rsp_redoFetch;
  assign IBusCachedPlugin_redoBranch_payload = IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  assign IBusCachedPlugin_iBusRsp_decodeInput_valid = IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready = IBusCachedPlugin_iBusRsp_decodeInput_ready;
  assign IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_decode_data;
  assign IBusCachedPlugin_iBusRsp_decodeInput_payload_pc = IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload;
  assign IBusCachedPlugin_mmuBus_cmd_isValid = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid;
  assign IBusCachedPlugin_mmuBus_cmd_virtualAddress = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress;
  assign IBusCachedPlugin_mmuBus_cmd_bypassTranslation = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation;
  assign IBusCachedPlugin_mmuBus_end = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end;
  assign _zz_218_ = (decode_arbitration_isValid && decode_FLUSH_ALL);
  assign dataCache_1__io_mem_cmd_s2mPipe_valid = (dataCache_1__io_mem_cmd_valid || _zz_129_);
  assign _zz_237_ = (! _zz_129_);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_wr = (_zz_129_ ? _zz_130_ : dataCache_1__io_mem_cmd_payload_wr);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_address = (_zz_129_ ? _zz_131_ : dataCache_1__io_mem_cmd_payload_address);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_data = (_zz_129_ ? _zz_132_ : dataCache_1__io_mem_cmd_payload_data);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_mask = (_zz_129_ ? _zz_133_ : dataCache_1__io_mem_cmd_payload_mask);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_length = (_zz_129_ ? _zz_134_ : dataCache_1__io_mem_cmd_payload_length);
  assign dataCache_1__io_mem_cmd_s2mPipe_payload_last = (_zz_129_ ? _zz_135_ : dataCache_1__io_mem_cmd_payload_last);
  assign dataCache_1__io_mem_cmd_s2mPipe_ready = ((1'b1 && (! dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid)) || dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_ready);
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid = _zz_136_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_wr = _zz_137_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_address = _zz_138_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_data = _zz_139_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_mask = _zz_140_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_length = _zz_141_;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_last = _zz_142_;
  assign dBus_cmd_valid = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_valid;
  assign dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_ready = dBus_cmd_ready;
  assign dBus_cmd_payload_wr = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  assign dBus_cmd_payload_address = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  assign dBus_cmd_payload_data = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  assign dBus_cmd_payload_mask = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  assign dBus_cmd_payload_length = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_length;
  assign dBus_cmd_payload_last = dataCache_1__io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  assign _zz_228_ = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
  assign _zz_229_ = execute_SRC_ADD;
  always @ (*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_143_ = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_143_ = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_143_ = execute_RS2[31 : 0];
      end
    endcase
  end

  assign _zz_236_ = (execute_arbitration_isValid && execute_MEMORY_MANAGMENT);
  assign _zz_90_ = _zz_229_[1 : 0];
  assign _zz_230_ = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
  assign _zz_231_ = memory_REGFILE_WRITE_DATA;
  assign DBusCachedPlugin_mmuBus_cmd_isValid = dataCache_1__io_cpu_memory_mmuBus_cmd_isValid;
  assign DBusCachedPlugin_mmuBus_cmd_virtualAddress = dataCache_1__io_cpu_memory_mmuBus_cmd_virtualAddress;
  assign DBusCachedPlugin_mmuBus_cmd_bypassTranslation = dataCache_1__io_cpu_memory_mmuBus_cmd_bypassTranslation;
  always @ (*) begin
    _zz_232_ = DBusCachedPlugin_mmuBus_rsp_isIoAccess;
    if((1'b0 && (! dataCache_1__io_cpu_memory_isWrite)))begin
      _zz_232_ = 1'b1;
    end
  end

  assign DBusCachedPlugin_mmuBus_end = dataCache_1__io_cpu_memory_mmuBus_end;
  assign _zz_233_ = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_234_ = (CsrPlugin_privilege == (2'b00));
  assign _zz_235_ = writeBack_REGFILE_WRITE_DATA;
  always @ (*) begin
    DBusCachedPlugin_redoBranch_valid = 1'b0;
    DBusCachedPlugin_exceptionBus_valid = 1'b0;
    DBusCachedPlugin_exceptionBus_payload_code = (4'bxxxx);
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      if(dataCache_1__io_cpu_writeBack_accessError)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_266_};
      end
      if(dataCache_1__io_cpu_writeBack_unalignedAccess)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_267_};
      end
      if(dataCache_1__io_cpu_writeBack_mmuException)begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
        DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? (4'b1111) : (4'b1101));
      end
      if(dataCache_1__io_cpu_redo)begin
        DBusCachedPlugin_redoBranch_valid = 1'b1;
        DBusCachedPlugin_exceptionBus_valid = 1'b0;
      end
    end
  end

  assign DBusCachedPlugin_redoBranch_payload = writeBack_PC;
  assign DBusCachedPlugin_exceptionBus_payload_badAddr = writeBack_REGFILE_WRITE_DATA;
  always @ (*) begin
    writeBack_DBusCachedPlugin_rspShifted = dataCache_1__io_cpu_writeBack_data;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = dataCache_1__io_cpu_writeBack_data[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusCachedPlugin_rspShifted[15 : 0] = dataCache_1__io_cpu_writeBack_data[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = dataCache_1__io_cpu_writeBack_data[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_144_ = (writeBack_DBusCachedPlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_145_[31] = _zz_144_;
    _zz_145_[30] = _zz_144_;
    _zz_145_[29] = _zz_144_;
    _zz_145_[28] = _zz_144_;
    _zz_145_[27] = _zz_144_;
    _zz_145_[26] = _zz_144_;
    _zz_145_[25] = _zz_144_;
    _zz_145_[24] = _zz_144_;
    _zz_145_[23] = _zz_144_;
    _zz_145_[22] = _zz_144_;
    _zz_145_[21] = _zz_144_;
    _zz_145_[20] = _zz_144_;
    _zz_145_[19] = _zz_144_;
    _zz_145_[18] = _zz_144_;
    _zz_145_[17] = _zz_144_;
    _zz_145_[16] = _zz_144_;
    _zz_145_[15] = _zz_144_;
    _zz_145_[14] = _zz_144_;
    _zz_145_[13] = _zz_144_;
    _zz_145_[12] = _zz_144_;
    _zz_145_[11] = _zz_144_;
    _zz_145_[10] = _zz_144_;
    _zz_145_[9] = _zz_144_;
    _zz_145_[8] = _zz_144_;
    _zz_145_[7 : 0] = writeBack_DBusCachedPlugin_rspShifted[7 : 0];
  end

  assign _zz_146_ = (writeBack_DBusCachedPlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_147_[31] = _zz_146_;
    _zz_147_[30] = _zz_146_;
    _zz_147_[29] = _zz_146_;
    _zz_147_[28] = _zz_146_;
    _zz_147_[27] = _zz_146_;
    _zz_147_[26] = _zz_146_;
    _zz_147_[25] = _zz_146_;
    _zz_147_[24] = _zz_146_;
    _zz_147_[23] = _zz_146_;
    _zz_147_[22] = _zz_146_;
    _zz_147_[21] = _zz_146_;
    _zz_147_[20] = _zz_146_;
    _zz_147_[19] = _zz_146_;
    _zz_147_[18] = _zz_146_;
    _zz_147_[17] = _zz_146_;
    _zz_147_[16] = _zz_146_;
    _zz_147_[15 : 0] = writeBack_DBusCachedPlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_251_)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_145_;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_147_;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspShifted;
      end
    endcase
  end

  assign IBusCachedPlugin_mmuBus_rsp_physicalAddress = IBusCachedPlugin_mmuBus_cmd_virtualAddress;
  assign IBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
  assign IBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
  assign IBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
  assign IBusCachedPlugin_mmuBus_rsp_isIoAccess = IBusCachedPlugin_mmuBus_rsp_physicalAddress[31];
  assign IBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
  assign IBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
  assign IBusCachedPlugin_mmuBus_busy = 1'b0;
  assign DBusCachedPlugin_mmuBus_rsp_physicalAddress = DBusCachedPlugin_mmuBus_cmd_virtualAddress;
  assign DBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
  assign DBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
  assign DBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
  assign DBusCachedPlugin_mmuBus_rsp_isIoAccess = DBusCachedPlugin_mmuBus_rsp_physicalAddress[31];
  assign DBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
  assign DBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
  assign DBusCachedPlugin_mmuBus_busy = 1'b0;
  assign _zz_149_ = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_150_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001010000)) == (32'b00000000000000000100000001010000));
  assign _zz_151_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_152_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_148_ = {({_zz_152_,{_zz_353_,{_zz_354_,_zz_355_}}} != (6'b000000)),{((_zz_356_ == _zz_357_) != (1'b0)),{(_zz_358_ != (1'b0)),{(_zz_359_ != _zz_360_),{_zz_361_,{_zz_362_,_zz_363_}}}}}};
  assign _zz_88_ = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_503_) == (32'b00000000000000000001000001110011)),{(_zz_504_ == _zz_505_),{_zz_506_,{_zz_507_,_zz_508_}}}}}}} != (19'b0000000000000000000));
  assign _zz_87_ = _zz_268_[0];
  assign _zz_153_ = _zz_148_[2 : 1];
  assign _zz_86_ = _zz_153_;
  assign _zz_85_ = _zz_269_[0];
  assign _zz_154_ = _zz_148_[5 : 4];
  assign _zz_84_ = _zz_154_;
  assign _zz_155_ = _zz_148_[7 : 6];
  assign _zz_83_ = _zz_155_;
  assign _zz_82_ = _zz_270_[0];
  assign _zz_81_ = _zz_271_[0];
  assign _zz_156_ = _zz_148_[10 : 10];
  assign _zz_80_ = _zz_156_;
  assign _zz_79_ = _zz_272_[0];
  assign _zz_157_ = _zz_148_[13 : 12];
  assign _zz_78_ = _zz_157_;
  assign _zz_77_ = _zz_273_[0];
  assign _zz_76_ = _zz_274_[0];
  assign _zz_75_ = _zz_275_[0];
  assign _zz_74_ = _zz_276_[0];
  assign _zz_73_ = _zz_277_[0];
  assign _zz_158_ = _zz_148_[21 : 20];
  assign _zz_72_ = _zz_158_;
  assign _zz_71_ = _zz_278_[0];
  assign _zz_70_ = _zz_279_[0];
  assign _zz_69_ = _zz_280_[0];
  assign _zz_68_ = _zz_281_[0];
  assign _zz_159_ = _zz_148_[27 : 26];
  assign _zz_67_ = _zz_159_;
  assign _zz_66_ = _zz_282_[0];
  assign _zz_65_ = _zz_283_[0];
  assign _zz_64_ = _zz_284_[0];
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION;
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_238_;
  assign decode_RegFilePlugin_rs2Data = _zz_239_;
  assign _zz_63_ = decode_RegFilePlugin_rs1Data;
  assign _zz_62_ = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    lastStageRegFileWrite_valid = (_zz_60_ && writeBack_arbitration_isFiring);
    if(_zz_160_)begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  assign lastStageRegFileWrite_payload_address = _zz_59_[11 : 7];
  assign lastStageRegFileWrite_payload_data = _zz_89_;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_161_ = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_161_ = {31'd0, _zz_285_};
      end
      default : begin
        _zz_161_ = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_57_ = _zz_161_;
  assign _zz_55_ = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_162_ = execute_RS1;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_162_ = {29'd0, _zz_286_};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_162_ = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
      default : begin
        _zz_162_ = {27'd0, _zz_287_};
      end
    endcase
  end

  assign _zz_54_ = _zz_162_;
  assign _zz_163_ = _zz_288_[11];
  always @ (*) begin
    _zz_164_[19] = _zz_163_;
    _zz_164_[18] = _zz_163_;
    _zz_164_[17] = _zz_163_;
    _zz_164_[16] = _zz_163_;
    _zz_164_[15] = _zz_163_;
    _zz_164_[14] = _zz_163_;
    _zz_164_[13] = _zz_163_;
    _zz_164_[12] = _zz_163_;
    _zz_164_[11] = _zz_163_;
    _zz_164_[10] = _zz_163_;
    _zz_164_[9] = _zz_163_;
    _zz_164_[8] = _zz_163_;
    _zz_164_[7] = _zz_163_;
    _zz_164_[6] = _zz_163_;
    _zz_164_[5] = _zz_163_;
    _zz_164_[4] = _zz_163_;
    _zz_164_[3] = _zz_163_;
    _zz_164_[2] = _zz_163_;
    _zz_164_[1] = _zz_163_;
    _zz_164_[0] = _zz_163_;
  end

  assign _zz_165_ = _zz_289_[11];
  always @ (*) begin
    _zz_166_[19] = _zz_165_;
    _zz_166_[18] = _zz_165_;
    _zz_166_[17] = _zz_165_;
    _zz_166_[16] = _zz_165_;
    _zz_166_[15] = _zz_165_;
    _zz_166_[14] = _zz_165_;
    _zz_166_[13] = _zz_165_;
    _zz_166_[12] = _zz_165_;
    _zz_166_[11] = _zz_165_;
    _zz_166_[10] = _zz_165_;
    _zz_166_[9] = _zz_165_;
    _zz_166_[8] = _zz_165_;
    _zz_166_[7] = _zz_165_;
    _zz_166_[6] = _zz_165_;
    _zz_166_[5] = _zz_165_;
    _zz_166_[4] = _zz_165_;
    _zz_166_[3] = _zz_165_;
    _zz_166_[2] = _zz_165_;
    _zz_166_[1] = _zz_165_;
    _zz_166_[0] = _zz_165_;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_167_ = execute_RS2;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_167_ = {_zz_164_,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_167_ = {_zz_166_,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_167_ = _zz_50_;
      end
    endcase
  end

  assign _zz_52_ = _zz_167_;
  always @ (*) begin
    execute_SrcPlugin_addSub = _zz_290_;
    if(execute_SRC2_FORCE_ZERO)begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_49_ = execute_SrcPlugin_addSub;
  assign _zz_48_ = execute_SrcPlugin_addSub;
  assign _zz_47_ = execute_SrcPlugin_less;
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (*) begin
    _zz_168_[0] = execute_SRC1[31];
    _zz_168_[1] = execute_SRC1[30];
    _zz_168_[2] = execute_SRC1[29];
    _zz_168_[3] = execute_SRC1[28];
    _zz_168_[4] = execute_SRC1[27];
    _zz_168_[5] = execute_SRC1[26];
    _zz_168_[6] = execute_SRC1[25];
    _zz_168_[7] = execute_SRC1[24];
    _zz_168_[8] = execute_SRC1[23];
    _zz_168_[9] = execute_SRC1[22];
    _zz_168_[10] = execute_SRC1[21];
    _zz_168_[11] = execute_SRC1[20];
    _zz_168_[12] = execute_SRC1[19];
    _zz_168_[13] = execute_SRC1[18];
    _zz_168_[14] = execute_SRC1[17];
    _zz_168_[15] = execute_SRC1[16];
    _zz_168_[16] = execute_SRC1[15];
    _zz_168_[17] = execute_SRC1[14];
    _zz_168_[18] = execute_SRC1[13];
    _zz_168_[19] = execute_SRC1[12];
    _zz_168_[20] = execute_SRC1[11];
    _zz_168_[21] = execute_SRC1[10];
    _zz_168_[22] = execute_SRC1[9];
    _zz_168_[23] = execute_SRC1[8];
    _zz_168_[24] = execute_SRC1[7];
    _zz_168_[25] = execute_SRC1[6];
    _zz_168_[26] = execute_SRC1[5];
    _zz_168_[27] = execute_SRC1[4];
    _zz_168_[28] = execute_SRC1[3];
    _zz_168_[29] = execute_SRC1[2];
    _zz_168_[30] = execute_SRC1[1];
    _zz_168_[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SLL_1) ? _zz_168_ : execute_SRC1);
  assign _zz_45_ = _zz_298_;
  always @ (*) begin
    _zz_169_[0] = memory_SHIFT_RIGHT[31];
    _zz_169_[1] = memory_SHIFT_RIGHT[30];
    _zz_169_[2] = memory_SHIFT_RIGHT[29];
    _zz_169_[3] = memory_SHIFT_RIGHT[28];
    _zz_169_[4] = memory_SHIFT_RIGHT[27];
    _zz_169_[5] = memory_SHIFT_RIGHT[26];
    _zz_169_[6] = memory_SHIFT_RIGHT[25];
    _zz_169_[7] = memory_SHIFT_RIGHT[24];
    _zz_169_[8] = memory_SHIFT_RIGHT[23];
    _zz_169_[9] = memory_SHIFT_RIGHT[22];
    _zz_169_[10] = memory_SHIFT_RIGHT[21];
    _zz_169_[11] = memory_SHIFT_RIGHT[20];
    _zz_169_[12] = memory_SHIFT_RIGHT[19];
    _zz_169_[13] = memory_SHIFT_RIGHT[18];
    _zz_169_[14] = memory_SHIFT_RIGHT[17];
    _zz_169_[15] = memory_SHIFT_RIGHT[16];
    _zz_169_[16] = memory_SHIFT_RIGHT[15];
    _zz_169_[17] = memory_SHIFT_RIGHT[14];
    _zz_169_[18] = memory_SHIFT_RIGHT[13];
    _zz_169_[19] = memory_SHIFT_RIGHT[12];
    _zz_169_[20] = memory_SHIFT_RIGHT[11];
    _zz_169_[21] = memory_SHIFT_RIGHT[10];
    _zz_169_[22] = memory_SHIFT_RIGHT[9];
    _zz_169_[23] = memory_SHIFT_RIGHT[8];
    _zz_169_[24] = memory_SHIFT_RIGHT[7];
    _zz_169_[25] = memory_SHIFT_RIGHT[6];
    _zz_169_[26] = memory_SHIFT_RIGHT[5];
    _zz_169_[27] = memory_SHIFT_RIGHT[4];
    _zz_169_[28] = memory_SHIFT_RIGHT[3];
    _zz_169_[29] = memory_SHIFT_RIGHT[2];
    _zz_169_[30] = memory_SHIFT_RIGHT[1];
    _zz_169_[31] = memory_SHIFT_RIGHT[0];
  end

  always @ (*) begin
    _zz_170_ = 1'b0;
    _zz_171_ = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! 1'b1)))begin
        if(_zz_176_)begin
          _zz_170_ = 1'b1;
        end
        if(_zz_177_)begin
          _zz_171_ = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_178_)begin
          _zz_170_ = 1'b1;
        end
        if(_zz_179_)begin
          _zz_171_ = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_180_)begin
          _zz_170_ = 1'b1;
        end
        if(_zz_181_)begin
          _zz_171_ = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_170_ = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_171_ = 1'b0;
    end
  end

  assign _zz_172_ = (_zz_60_ && writeBack_arbitration_isFiring);
  assign _zz_176_ = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_177_ = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_178_ = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_179_ = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_180_ = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_181_ = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_41_ = IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_182_ = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_182_ == (3'b000))) begin
        _zz_183_ = execute_BranchPlugin_eq;
    end else if((_zz_182_ == (3'b001))) begin
        _zz_183_ = (! execute_BranchPlugin_eq);
    end else if((((_zz_182_ & (3'b101)) == (3'b101)))) begin
        _zz_183_ = (! execute_SRC_LESS);
    end else begin
        _zz_183_ = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_184_ = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_184_ = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_184_ = 1'b1;
      end
      default : begin
        _zz_184_ = _zz_183_;
      end
    endcase
  end

  assign _zz_40_ = _zz_184_;
  assign _zz_185_ = _zz_300_[11];
  always @ (*) begin
    _zz_186_[19] = _zz_185_;
    _zz_186_[18] = _zz_185_;
    _zz_186_[17] = _zz_185_;
    _zz_186_[16] = _zz_185_;
    _zz_186_[15] = _zz_185_;
    _zz_186_[14] = _zz_185_;
    _zz_186_[13] = _zz_185_;
    _zz_186_[12] = _zz_185_;
    _zz_186_[11] = _zz_185_;
    _zz_186_[10] = _zz_185_;
    _zz_186_[9] = _zz_185_;
    _zz_186_[8] = _zz_185_;
    _zz_186_[7] = _zz_185_;
    _zz_186_[6] = _zz_185_;
    _zz_186_[5] = _zz_185_;
    _zz_186_[4] = _zz_185_;
    _zz_186_[3] = _zz_185_;
    _zz_186_[2] = _zz_185_;
    _zz_186_[1] = _zz_185_;
    _zz_186_[0] = _zz_185_;
  end

  assign _zz_187_ = _zz_301_[19];
  always @ (*) begin
    _zz_188_[10] = _zz_187_;
    _zz_188_[9] = _zz_187_;
    _zz_188_[8] = _zz_187_;
    _zz_188_[7] = _zz_187_;
    _zz_188_[6] = _zz_187_;
    _zz_188_[5] = _zz_187_;
    _zz_188_[4] = _zz_187_;
    _zz_188_[3] = _zz_187_;
    _zz_188_[2] = _zz_187_;
    _zz_188_[1] = _zz_187_;
    _zz_188_[0] = _zz_187_;
  end

  assign _zz_189_ = _zz_302_[11];
  always @ (*) begin
    _zz_190_[18] = _zz_189_;
    _zz_190_[17] = _zz_189_;
    _zz_190_[16] = _zz_189_;
    _zz_190_[15] = _zz_189_;
    _zz_190_[14] = _zz_189_;
    _zz_190_[13] = _zz_189_;
    _zz_190_[12] = _zz_189_;
    _zz_190_[11] = _zz_189_;
    _zz_190_[10] = _zz_189_;
    _zz_190_[9] = _zz_189_;
    _zz_190_[8] = _zz_189_;
    _zz_190_[7] = _zz_189_;
    _zz_190_[6] = _zz_189_;
    _zz_190_[5] = _zz_189_;
    _zz_190_[4] = _zz_189_;
    _zz_190_[3] = _zz_189_;
    _zz_190_[2] = _zz_189_;
    _zz_190_[1] = _zz_189_;
    _zz_190_[0] = _zz_189_;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_191_ = (_zz_303_[1] ^ execute_RS1[1]);
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_191_ = _zz_304_[1];
      end
      default : begin
        _zz_191_ = _zz_305_[1];
      end
    endcase
  end

  assign execute_BranchPlugin_missAlignedTarget = (execute_BRANCH_COND_RESULT && _zz_191_);
  assign _zz_38_ = ((execute_PREDICTION_HAD_BRANCHED2 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_193_,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_195_,{{{_zz_520_,execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_197_,{{{_zz_521_,_zz_522_},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
        if(execute_PREDICTION_HAD_BRANCHED2)begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_309_};
        end
      end
    endcase
  end

  assign _zz_192_ = _zz_306_[11];
  always @ (*) begin
    _zz_193_[19] = _zz_192_;
    _zz_193_[18] = _zz_192_;
    _zz_193_[17] = _zz_192_;
    _zz_193_[16] = _zz_192_;
    _zz_193_[15] = _zz_192_;
    _zz_193_[14] = _zz_192_;
    _zz_193_[13] = _zz_192_;
    _zz_193_[12] = _zz_192_;
    _zz_193_[11] = _zz_192_;
    _zz_193_[10] = _zz_192_;
    _zz_193_[9] = _zz_192_;
    _zz_193_[8] = _zz_192_;
    _zz_193_[7] = _zz_192_;
    _zz_193_[6] = _zz_192_;
    _zz_193_[5] = _zz_192_;
    _zz_193_[4] = _zz_192_;
    _zz_193_[3] = _zz_192_;
    _zz_193_[2] = _zz_192_;
    _zz_193_[1] = _zz_192_;
    _zz_193_[0] = _zz_192_;
  end

  assign _zz_194_ = _zz_307_[19];
  always @ (*) begin
    _zz_195_[10] = _zz_194_;
    _zz_195_[9] = _zz_194_;
    _zz_195_[8] = _zz_194_;
    _zz_195_[7] = _zz_194_;
    _zz_195_[6] = _zz_194_;
    _zz_195_[5] = _zz_194_;
    _zz_195_[4] = _zz_194_;
    _zz_195_[3] = _zz_194_;
    _zz_195_[2] = _zz_194_;
    _zz_195_[1] = _zz_194_;
    _zz_195_[0] = _zz_194_;
  end

  assign _zz_196_ = _zz_308_[11];
  always @ (*) begin
    _zz_197_[18] = _zz_196_;
    _zz_197_[17] = _zz_196_;
    _zz_197_[16] = _zz_196_;
    _zz_197_[15] = _zz_196_;
    _zz_197_[14] = _zz_196_;
    _zz_197_[13] = _zz_196_;
    _zz_197_[12] = _zz_196_;
    _zz_197_[11] = _zz_196_;
    _zz_197_[10] = _zz_196_;
    _zz_197_[9] = _zz_196_;
    _zz_197_[8] = _zz_196_;
    _zz_197_[7] = _zz_196_;
    _zz_197_[6] = _zz_196_;
    _zz_197_[5] = _zz_196_;
    _zz_197_[4] = _zz_196_;
    _zz_197_[3] = _zz_196_;
    _zz_197_[2] = _zz_196_;
    _zz_197_[1] = _zz_196_;
    _zz_197_[0] = _zz_196_;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_37_ = {execute_BranchPlugin_branchAdder[31 : 1],(1'b0)};
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && (! memory_arbitration_isStuckByOthers)) && memory_BRANCH_DO);
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign BranchPlugin_branchExceptionPort_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && memory_BRANCH_CALC[1]));
  assign BranchPlugin_branchExceptionPort_payload_code = (4'b0000);
  assign BranchPlugin_branchExceptionPort_payload_badAddr = memory_BRANCH_CALC;
  assign IBusCachedPlugin_decodePrediction_rsp_wasWrong = BranchPlugin_jumpInterface_valid;
  always @ (*) begin
    CsrPlugin_privilege = (2'b11);
    if(CsrPlugin_forceMachineWire)begin
      CsrPlugin_privilege = (2'b11);
    end
  end

  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b11);
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign _zz_198_ = {decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid};
  assign _zz_199_ = _zz_310_[0];
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(_zz_243_)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(BranchPlugin_branchExceptionPort_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  always @ (*) begin
    CsrPlugin_interrupt = 1'b0;
    CsrPlugin_interruptCode = (4'bxxxx);
    CsrPlugin_interruptTargetPrivilege = (2'bxx);
    if((CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < (2'b11))))begin
      if((((CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE) && 1'b1) && (! 1'b0)))begin
        CsrPlugin_interrupt = 1'b1;
        CsrPlugin_interruptCode = (4'b0111);
        CsrPlugin_interruptTargetPrivilege = (2'b11);
      end
      if((((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) && 1'b1) && (! 1'b0)))begin
        CsrPlugin_interrupt = 1'b1;
        CsrPlugin_interruptCode = (4'b0011);
        CsrPlugin_interruptTargetPrivilege = (2'b11);
      end
      if((((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) && 1'b1) && (! 1'b0)))begin
        CsrPlugin_interrupt = 1'b1;
        CsrPlugin_interruptCode = (4'b1011);
        CsrPlugin_interruptTargetPrivilege = (2'b11);
      end
    end
    if((! CsrPlugin_allowInterrupts))begin
      CsrPlugin_interrupt = 1'b0;
    end
  end

  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  assign CsrPlugin_lastStageWasWfi = 1'b0;
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ({writeBack_arbitration_isValid,{memory_arbitration_isValid,execute_arbitration_isValid}} != (3'b000))) && IBusCachedPlugin_pcValids_3);
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != (3'b000)))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException)begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  always @ (*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interruptTargetPrivilege;
    if(CsrPlugin_hadException)begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @ (*) begin
    CsrPlugin_trapCause = CsrPlugin_interruptCode;
    if(CsrPlugin_hadException)begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @ (*) begin
    CsrPlugin_xtvec_mode = (2'bxx);
    CsrPlugin_xtvec_base = (30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign _zz_35_ = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_34_ = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  assign execute_CsrPlugin_inWfi = 1'b0;
  assign execute_CsrPlugin_blockedBySideEffects = ({writeBack_arbitration_isValid,memory_arbitration_isValid} != (2'b00));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_207_;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b001100000101 : begin
        if(execute_CSR_WRITE_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
      end
      12'b110011000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[12 : 0] = (13'b1000000000000);
        execute_CsrPlugin_readData[25 : 20] = (6'b100000);
      end
      12'b001101000011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtval;
      end
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_208_;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b001101000010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      default : begin
      end
    endcase
    if((CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(((! execute_arbitration_isValid) || (! execute_IS_CSR)))begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @ (*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)))begin
      if((CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]))begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  assign execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
  assign execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
  assign execute_CsrPlugin_writeEnable = ((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readEnable = ((execute_CsrPlugin_readInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readToWriteData = execute_CsrPlugin_readData;
  always @ (*) begin
    case(_zz_252_)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_SRC1;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_253_)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign _zz_31_ = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_30_ = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_29_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_28_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_27_ = ($signed(_zz_312_) + $signed(_zz_320_));
  assign writeBack_MulPlugin_result = ($signed(_zz_321_) + $signed(_zz_322_));
  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_248_)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_counter_willOverflowIfInc = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_counter_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_326_);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_200_ = memory_DivPlugin_rs1[31 : 0];
  assign _zz_201_ = {memory_DivPlugin_accumulator[31 : 0],_zz_200_[31]};
  assign _zz_202_ = (_zz_201_ - _zz_327_);
  assign _zz_203_ = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_204_ = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_205_ = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_206_[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_206_[31 : 0] = execute_RS1;
  end

  assign _zz_208_ = (_zz_207_ & externalInterruptArray_regNext);
  assign externalInterrupt = (_zz_208_ != (32'b00000000000000000000000000000000));
  assign _zz_26_ = decode_SRC2_CTRL;
  assign _zz_24_ = _zz_78_;
  assign _zz_51_ = decode_to_execute_SRC2_CTRL;
  assign _zz_23_ = decode_ENV_CTRL;
  assign _zz_20_ = execute_ENV_CTRL;
  assign _zz_18_ = memory_ENV_CTRL;
  assign _zz_21_ = _zz_80_;
  assign _zz_33_ = decode_to_execute_ENV_CTRL;
  assign _zz_32_ = execute_to_memory_ENV_CTRL;
  assign _zz_36_ = memory_to_writeBack_ENV_CTRL;
  assign _zz_16_ = decode_BRANCH_CTRL;
  assign _zz_95_ = _zz_72_;
  assign _zz_39_ = decode_to_execute_BRANCH_CTRL;
  assign _zz_14_ = decode_SRC1_CTRL;
  assign _zz_12_ = _zz_84_;
  assign _zz_53_ = decode_to_execute_SRC1_CTRL;
  assign _zz_11_ = decode_ALU_CTRL;
  assign _zz_9_ = _zz_83_;
  assign _zz_56_ = decode_to_execute_ALU_CTRL;
  assign _zz_8_ = decode_ALU_BITWISE_CTRL;
  assign _zz_6_ = _zz_67_;
  assign _zz_58_ = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_5_ = decode_SHIFT_CTRL;
  assign _zz_2_ = execute_SHIFT_CTRL;
  assign _zz_3_ = _zz_86_;
  assign _zz_46_ = decode_to_execute_SHIFT_CTRL;
  assign _zz_44_ = execute_to_memory_SHIFT_CTRL;
  assign decode_arbitration_isFlushed = ({writeBack_arbitration_flushAll,{memory_arbitration_flushAll,{execute_arbitration_flushAll,decode_arbitration_flushAll}}} != (4'b0000));
  assign execute_arbitration_isFlushed = ({writeBack_arbitration_flushAll,{memory_arbitration_flushAll,execute_arbitration_flushAll}} != (3'b000));
  assign memory_arbitration_isFlushed = ({writeBack_arbitration_flushAll,memory_arbitration_flushAll} != (2'b00));
  assign writeBack_arbitration_isFlushed = (writeBack_arbitration_flushAll != (1'b0));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign iBusWishbone_ADR = {_zz_346_,_zz_209_};
  assign iBusWishbone_CTI = ((_zz_209_ == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    iBusWishbone_CYC = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_249_)begin
      iBusWishbone_CYC = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_210_;
  assign iBus_rsp_payload_data = iBusWishbone_DAT_MISO_regNext;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_216_ = (dBus_cmd_payload_length != (3'b000));
  assign _zz_212_ = dBus_cmd_valid;
  assign _zz_214_ = dBus_cmd_payload_wr;
  assign _zz_215_ = (_zz_211_ == dBus_cmd_payload_length);
  assign dBus_cmd_ready = (_zz_213_ && (_zz_214_ || _zz_215_));
  assign dBusWishbone_ADR = ((_zz_216_ ? {{dBus_cmd_payload_address[31 : 5],_zz_211_},(2'b00)} : {dBus_cmd_payload_address[31 : 2],(2'b00)}) >>> 2);
  assign dBusWishbone_CTI = (_zz_216_ ? (_zz_215_ ? (3'b111) : (3'b010)) : (3'b000));
  assign dBusWishbone_BTE = (2'b00);
  assign dBusWishbone_SEL = (_zz_214_ ? dBus_cmd_payload_mask : (4'b1111));
  assign dBusWishbone_WE = _zz_214_;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_payload_data;
  assign _zz_213_ = (_zz_212_ && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_212_;
  assign dBusWishbone_STB = _zz_212_;
  assign dBus_rsp_valid = _zz_217_;
  assign dBus_rsp_payload_data = dBusWishbone_DAT_MISO_regNext;
  assign dBus_rsp_payload_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_108_ <= 1'b0;
      _zz_114_ <= 1'b0;
      _zz_116_ <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      _zz_129_ <= 1'b0;
      _zz_136_ <= 1'b0;
      _zz_160_ <= 1'b1;
      _zz_173_ <= 1'b0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      _zz_207_ <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_209_ <= (3'b000);
      _zz_210_ <= 1'b0;
      _zz_211_ <= (3'b000);
      _zz_217_ <= 1'b0;
    end else begin
      if(IBusCachedPlugin_fetchPc_propagatePc)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_247_)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_108_ <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        _zz_114_ <= 1'b0;
      end
      if(_zz_112_)begin
        _zz_114_ <= IBusCachedPlugin_iBusRsp_stages_0_output_valid;
      end
      if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
        _zz_116_ <= IBusCachedPlugin_iBusRsp_stages_1_output_valid;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        _zz_116_ <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_stages_1_input_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || IBusCachedPlugin_fetcherflushIt))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      if(dataCache_1__io_mem_cmd_s2mPipe_ready)begin
        _zz_129_ <= 1'b0;
      end
      if(_zz_250_)begin
        _zz_129_ <= dataCache_1__io_mem_cmd_valid;
      end
      if(dataCache_1__io_mem_cmd_s2mPipe_ready)begin
        _zz_136_ <= dataCache_1__io_mem_cmd_s2mPipe_valid;
      end
      _zz_160_ <= 1'b0;
      _zz_173_ <= _zz_172_;
      if((! decode_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(_zz_244_)begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(_zz_245_)begin
        case(_zz_246_)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= (2'b00);
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
          end
          default : begin
          end
        endcase
      end
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_43_;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_207_ <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_340_[0];
            CsrPlugin_mstatus_MIE <= _zz_341_[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
        end
        12'b110011000000 : begin
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_343_[0];
            CsrPlugin_mie_MTIE <= _zz_344_[0];
            CsrPlugin_mie_MSIE <= _zz_345_[0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_249_)begin
        if(iBusWishbone_ACK)begin
          _zz_209_ <= (_zz_209_ + (3'b001));
        end
      end
      _zz_210_ <= (iBusWishbone_CYC && iBusWishbone_ACK);
      if((_zz_212_ && _zz_213_))begin
        _zz_211_ <= (_zz_211_ + (3'b001));
        if(_zz_215_)begin
          _zz_211_ <= (3'b000);
        end
      end
      _zz_217_ <= ((_zz_212_ && (! dBusWishbone_WE)) && dBusWishbone_ACK);
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
      _zz_117_ <= IBusCachedPlugin_iBusRsp_stages_1_output_payload;
    end
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready)begin
      IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit;
    end
    if(IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready)begin
      IBusCachedPlugin_s2_tightlyCoupledHit <= IBusCachedPlugin_s1_tightlyCoupledHit;
    end
    if(_zz_250_)begin
      _zz_130_ <= dataCache_1__io_mem_cmd_payload_wr;
      _zz_131_ <= dataCache_1__io_mem_cmd_payload_address;
      _zz_132_ <= dataCache_1__io_mem_cmd_payload_data;
      _zz_133_ <= dataCache_1__io_mem_cmd_payload_mask;
      _zz_134_ <= dataCache_1__io_mem_cmd_payload_length;
      _zz_135_ <= dataCache_1__io_mem_cmd_payload_last;
    end
    if(dataCache_1__io_mem_cmd_s2mPipe_ready)begin
      _zz_137_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_wr;
      _zz_138_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_address;
      _zz_139_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_data;
      _zz_140_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_mask;
      _zz_141_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_length;
      _zz_142_ <= dataCache_1__io_mem_cmd_s2mPipe_payload_last;
    end
    if(_zz_172_)begin
      _zz_174_ <= _zz_59_[11 : 7];
      _zz_175_ <= _zz_89_;
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(_zz_243_)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (_zz_199_ ? IBusCachedPlugin_decodeExceptionPort_payload_code : decodeExceptionPort_payload_code);
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= (_zz_199_ ? IBusCachedPlugin_decodeExceptionPort_payload_badAddr : decodeExceptionPort_payload_badAddr);
    end
    if(BranchPlugin_branchExceptionPort_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= BranchPlugin_branchExceptionPort_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= BranchPlugin_branchExceptionPort_payload_badAddr;
    end
    if(DBusCachedPlugin_exceptionBus_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusCachedPlugin_exceptionBus_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusCachedPlugin_exceptionBus_payload_badAddr;
    end
    if(_zz_244_)begin
      case(CsrPlugin_targetPrivilege)
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mepc <= writeBack_PC;
          if(CsrPlugin_hadException)begin
            CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        default : begin
        end
      endcase
    end
    if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
      memory_DivPlugin_div_done <= 1'b1;
    end
    if((! memory_arbitration_isStuck))begin
      memory_DivPlugin_div_done <= 1'b0;
    end
    if(_zz_241_)begin
      if(_zz_242_)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_328_[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_202_[32]) ? _zz_329_ : _zz_330_);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_331_[31:0];
        end
      end
    end
    if(_zz_248_)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_205_ ? (~ _zz_206_) : _zz_206_) + _zz_337_);
      memory_DivPlugin_rs2 <= ((_zz_204_ ? (~ execute_RS2) : execute_RS2) + _zz_339_);
      memory_DivPlugin_div_needRevert <= ((_zz_205_ ^ (_zz_204_ && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == (32'b00000000000000000000000000000000)) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    externalInterruptArray_regNext <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_25_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_22_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_19_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_17_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_97_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_96_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_15_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_13_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_50_;
    end
    if(((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack)))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_42_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_10_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_7_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_4_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_CTRL <= _zz_1_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
      end
      12'b001100000000 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec_base <= execute_CsrPlugin_writeData[31 : 2];
          CsrPlugin_mtvec_mode <= execute_CsrPlugin_writeData[1 : 0];
        end
      end
      12'b001101000100 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mip_MSIP <= _zz_342_[0];
        end
      end
      12'b110011000000 : begin
      end
      12'b001101000011 : begin
      end
      12'b111111000000 : begin
      end
      12'b001100000100 : begin
      end
      12'b001101000010 : begin
      end
      default : begin
      end
    endcase
    iBusWishbone_DAT_MISO_regNext <= iBusWishbone_DAT_MISO;
    dBusWishbone_DAT_MISO_regNext <= dBusWishbone_DAT_MISO;
  end

endmodule

