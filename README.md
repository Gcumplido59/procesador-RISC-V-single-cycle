Objetivo
Implementar una arquitectura de procesador RISC-V con diseño de ciclo único (single-cycle) en Verilog, integrando todos los bloques funcionales necesarios, verificando su comportamiento mediante simulación y analizando su funcionamiento instrucción por instrucción.

🛠️ Requerimientos
Conocimientos básicos de arquitectura de computadores (etapas de ejecución de instrucciones).

Familiaridad con el conjunto de instrucciones RISC-V RV32I.

Conocimientos en diseño digital con Verilog.

Herramientas recomendadas: ModelSim, Quartus.

🧩 Bloques funcionales requeridos
Debes implementar los siguientes módulos en Verilog, de forma estructurada:

Módulo	Función principal
ProgramCounter	Mantiene la dirección de la instrucción actual.
InstructionMemory	Memoria ROM que almacena el conjunto de instrucciones del programa.
RegisterFile	Banco de registros (32 registros de 32 bits), con dos lecturas y una escritura.
ImmediateGenerator	Extrae e interpreta los campos inmediatos según el tipo de instrucción (I, S, B…).
ALUControl	Genera la señal de operación de la ALU a partir de la instrucción.
ALU	Unidad lógica-aritmética que ejecuta operaciones según la instrucción.
ControlUnit	Genera señales de control globales según el opcode.
DataMemory	Memoria RAM para operaciones de carga/almacenamiento.
Mux (multiplexores)	Permiten seleccionar entradas hacia la ALU o direcciones.
Adder	Suma de direcciones para el cálculo del siguiente PC.
BranchComparator	Compara registros para instrucciones de salto condicional.
📂 Estructura del proyecto (sugerida)
/riscv_single_cycle/ │ ├── src/ │ ├── top.v ← Módulo principal (interconexión de todos los bloques) │ ├── program_counter.v │ ├── instruction_memory.v │ ├── control_unit.v │ ├── register_file.v │ ├── alu.v │ ├── alu_control.v │ ├── immediate_generator.v │ ├── data_memory.v │ ├── mux.v │ ├── branch_comparator.v │ └── adder.v │ ├── testbench/ │ └── top_tb.v ← Testbench para simular │ ├── program/ │ └── test_program.mem ←
Código ensamblado para ejecutar
📑 Instrucciones de desarrollo
Diseñar cada módulo por separado. Verifica su funcionamiento mediante módulos de prueba individuales (unit testing).

Conectar todos los bloques en el módulo principal top.v, respetando el camino de datos típico de una arquitectura de un solo ciclo.

Cargar el programa de prueba en la memoria de instrucciones (.mem en formato hexadecimal o binario).

Simular el procesador completo con el testbench top_tb.v. Observa señales clave: PC, instruction, ALUResult, RegWrite, MemRead, MemWrite, Branch, etc.

Verificar ejecución correcta de instrucciones: operaciones aritméticas, carga/almacenamiento (lw, sw), ramas (beq, bne) y saltos (jal, jalr).
