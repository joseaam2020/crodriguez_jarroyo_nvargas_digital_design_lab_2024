module FSM_Gato (
    input logic [1:0] PC,
    input logic t0,
    input logic [3:0] interrupt,
    input logic enfila, valido, todoLleno,
    input logic Reset,
    
    output logic [2:0] Arduino,
    output logic Actualizar,
    output logic [1:0] Gano,
    output logic Reiniciar,
    output logic Reset_timer,
    output logic Jug,
    output logic random,
    input logic clk
);

logic [2:0] state, next_state;
logic tiempo_jug1;
logic tiempo_jug2;
logic interrupt_mayor0;

typedef enum logic [2:0] {
    state0   = 3'b000,  // Inicio
    state1   = 3'b001,
    state2   = 3'b010,
    state3   = 3'b011,
    state4   = 3'b100,
    GANAR    = 3'b101
} state_t;

// Sequential logic: handles state transitions and clock-dependent variables
always_ff @(posedge clk or posedge Reset) begin
    if (Reset) begin
        state <= state0;
        Jug <= 0;
        Reiniciar <= 0;
    end else begin
        state <= next_state;

        // Update Jug based on current state and conditions
        if (((enfila == 0) || valido == 0) && (state == state2)) begin
            Jug <= valido;
        end else if (((enfila == 0) || valido == 0) && (state == state3)) begin
            Jug <= !valido;
        end else if ((enfila == 0) && (state == state4)) begin
            Jug <= !Jug;
        end

        // Handle Reiniciar logic based on state
        if ((interrupt > 0) && (state == GANAR)) begin
            Reiniciar <= 1;
        end else if ((todoLleno == 1) && (state == state1)) begin
            Reiniciar <= 1;
        end else begin
            Reiniciar <= 0;
        end
    end  
end

// Combinational logic: handles state transition and output logic
always_comb begin
    // Default assignments to avoid latches
    next_state = state0;
    Reset_timer = 1'b0;
    Actualizar = 1'b0;
    Gano = 2'b00;
    Arduino = 3'b000;
    tiempo_jug1 = 0;
    tiempo_jug2 = 0;
    interrupt_mayor0 = 0;
    random = 0;
    

    // Combinational logic for state transitions
    case (state)
        state0: begin
            if (PC == 1 || PC == 2) begin
                next_state = state1;
            end else begin
                next_state = state0;
            end
        end
        
        state1: begin
            tiempo_jug1 = (t0 == 0) && (Jug == 0);
            tiempo_jug2 = (t0 == 0) && (Jug == 1);
            interrupt_mayor0 = interrupt > 0;

            if (todoLleno == 1) begin
                next_state = state0;
            end else if (interrupt_mayor0) begin
                if (tiempo_jug1) begin
                    next_state = state2; 
                end else if (tiempo_jug2) begin
                    next_state = state3; 
                end else begin
                    next_state = state4;
                end
            end else begin
                if(t0) begin
                    next_state = state4;
                end else begin
                    next_state = state1;
                end
            end
        end

        state2: begin
            if ((enfila == 0) || valido == 0) begin
                next_state = state1;
            end else if ((enfila == 1) && (valido == 1)) begin
                next_state = GANAR;
            end else begin
                next_state = state2;
            end
        end

        state3: begin
            if ((enfila == 0) || (valido == 0)) begin
                next_state = state1;
            end else if ((enfila == 1) && (valido == 1)) begin
                next_state = GANAR;
            end else begin
                next_state = state3;
            end
        end

        state4: begin
            if (enfila == 1) begin
                next_state = GANAR;
            end else begin
                next_state = state1;
            end
        end

        GANAR: begin
            if (interrupt == 0) begin
                next_state = GANAR;
            end else if (interrupt > 0) begin
                next_state = state0;
            end
        end

        default: begin
            next_state = state0;
        end
    endcase

    // Additional combinational logic for signals
    if ((PC == 1 || PC == 2) && (state == state0)) begin
        Arduino = PC;
        Reset_timer = 1;
    end else begin
        Arduino = 0;
        Reset_timer = 0;
    end

    if (((enfila == 0) || valido == 0) && (state == state2 || state == state3)) begin
        Actualizar = 1;
    end else if ((enfila == 0) && (state == state4)) begin
        Actualizar = 1;
    end else begin
        Actualizar = 0;
    end

    if ((enfila == 1 && valido == 1) && (state == state2 || state == state3)) begin
        Gano = Jug + 1;
    end else if (enfila == 1 && state == state4) begin
        Actualizar = 1;
    end else begin
        Gano = 0;
    end

    if ((enfila == 0) && (state == state4)) begin
        random = 1;
    end else begin
        random = 0;
    end
end

endmodule
