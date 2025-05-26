module fsm_control (
    input clk,
    input reset,
    input start,
    input [6:0] opcode,
    output [3:0] state
);

    typedef enum logic [3:0] {
        IDLE     = 4'd0,
        FETCH    = 4'd1,
        DECODE   = 4'd2,
        MEMADR   = 4'd3,
        MEMREAD  = 4'd4,
        MEMWB    = 4'd5,
        MEMWRITE = 4'd6,
        EXECUTER = 4'd7,
        ALUWB    = 4'd8,
        EXECUTEI = 4'd9,
        JAL      = 4'd10,
        BEQ      = 4'd11
    } state_t;

    state_t current_state, next_state;

    // actual
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // entre estados
    always_comb begin
        case (current_state)
            IDLE:      next_state = (start) ? FETCH : IDLE;
            FETCH:     next_state = DECODE;

            DECODE: begin
                case (opcode)
                    7'b0110011: next_state = EXECUTER;    // R-type
                    7'b0000011: next_state = MEMADR;      // lw
                    7'b0100011: next_state = MEMADR;      // sw
                    7'b0010011: next_state = EXECUTEI;    // addi
                    7'b1101111: next_state = JAL;         // jal
                    7'b1100011: next_state = BEQ;         // beq
                    default:    next_state = IDLE;        // instrucción no reconocida
                endcase
            end

            MEMADR:    next_state = (opcode == 7'b0000011) ? MEMREAD : MEMWRITE;
            MEMREAD:   next_state = MEMWB;
            MEMWB:     next_state = FETCH;
            MEMWRITE:  next_state = FETCH;
            EXECUTER:  next_state = ALUWB;
            EXECUTEI:  next_state = ALUWB;
            ALUWB:     next_state = FETCH;
            JAL:       next_state = FETCH;
            BEQ:       next_state = FETCH;

            default:   next_state = IDLE;
        endcase
    end

    assign state = current_state;

endmodule
