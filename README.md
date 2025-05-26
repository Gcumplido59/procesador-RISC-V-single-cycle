# RISC-V RV32I Single-Cycle Processor

Este repositorio contiene una implementación de un procesador RISC-V de un solo ciclo (**single-cycle**) en Verilog 2001.

## Estructura del Proyecto
```plaintext
riscv_single_cycle/
├── src/                      # Módulos Verilog
│   ├── program_counter.v     # ProgramCounter
│   ├── instruction_memory.v  # InstructionMemory
│   ├── register_file.v       # RegisterFile
│   ├── immediate_generator.v # ImmediateGenerator
│   ├── alu_control.v         # ALUControl
│   ├── alu.v                 # ALU
│   ├── control_unit.v        # ControlUnit
│   ├── data_memory.v         # DataMemory
│   ├── mux.v                 # Mux2 genérico
│   ├── adder.v               # Adder
│   └── branch_comparator.v   # BranchComparator
├── program.mem               # Programa de prueba en formato hex
├── testbench/                # Bancos de prueba
│   └── top_tb.v              # Testbench para simulación
└── README.md                 # Documentación del proyecto
```

## Descripción de Módulos

- **ProgramCounter**: Mantiene y actualiza el PC.
- **InstructionMemory**: ROM de instrucciones (`program.mem`).
- **RegisterFile**: Banco de 32 registros de 32 bits con dos puertos de lectura y uno de escritura.
- **ImmediateGenerator**: Extrae e interpola el campo inmediato según tipo I, S, B, J.
- **ALUControl**: Decodifica `funct3`/`funct7` y `ALUOp` para generar la señal `ALUControl`.
- **ALU**: Unidad aritmético-lógica.
- **ControlUnit**: Genera señales de control globales (`ALUSrc`, `MemWrite`, etc.) según `opcode`.
- **DataMemory**: RAM para `lw` y `sw`.
- **Mux2**: Multiplexores genéricos de 2 a 1.
- **Adder**: Suma de 32 bits, usado para PC+4 y PC+inmediato.
- **BranchComparator**: Señal de salto condicional (`beq`).

## Requisitos

- **Quartus Prime** (o cualquier herramienta que soporte Verilog 2001)
- **ModelSim** o **QuestaSim** para simulación

## Instrucciones de Síntesis

1. Copiar todos los archivos de `src/` y `program.mem` al directorio de proyecto de Quartus.
2. Asegurarse de agregar `program.mem` en el proyecto (Menú: *Files → Add/Remove Files in Project*).
3. Compilar el proyecto en Quartus.

## Instrucciones de Simulación

```tcl
# En ModelSim/QuestaSim
vlib work
vlog src/*.v testbench/top_tb.v
vsim -c top_tb -do "run 200ns; quit"
```

Para visualizar ondas:

```bash
gtkwave waves.vcd
```

## Testbench

El archivo `testbench/top_tb.v` realiza un programa mínimo de prueba que:

1. Carga inmediatos en `x1` y `x2`.
2. Ejecuta `add x3, x1, x2`.
3. Ejecuta `sw` y `lw` a memoria.
4. Verifica que `x4 == 15`.

## Contribuciones

¡Las contribuciones y mejoras son bienvenidas! Abre un *issue* o un *pull request*.

## Licencia

Este proyecto está bajo la [MIT License](LICENSE).
