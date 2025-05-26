`timescale 1ns/1ps

module top_tb;
    reg clk = 0;
    reg reset;

    // Instancia del CPU
    singleCycle cpu (
        .clk(clk)
    );

    // Generador de reloj 100 MHz
    always #5 clk = ~clk;

    initial begin
        // Fase de reset
        reset = 1;
        #20;
        reset = 0;

        // Dump de señales
        $dumpfile("waves.vcd");
        $dumpvars(0, top_tb);

        // Espera para ejecutar suficientes ciclos
        #200;

        // Mostrar resultados
        $display("Registro x3 = %0d, x4 = %0d", cpu.RF.regs[3], cpu.RF.regs[4]);
        if (cpu.RF.regs[4] == 15)
            $display(">>> TEST PASSED: x4 == 15");
        else
            $display(">>> TEST FAILED: x4 != 15");

        $finish;
    end
endmodule
