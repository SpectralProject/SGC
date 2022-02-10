# SGC
Spectral Graphics Compiler
- Compiles vulkan shader code to an ELF like binary that can be run in a Spectral Graphics GPU
- Like any other compiler but less emphasis on optimisations since most of it should be in the hardware and vulkan code itself. Not to mention a lot of the code is simply number crunching so no branch prediction or any complex phenomena like in CPUs
- Can be invoked as a service `sgc <vulkan_file.shader> > vulkan_file.spectralelf` 
- The `.spectralelf` objects can then be linked with other `.spectralelf` objects/libraries to form a library executable. For most purposes, its prob better to not try to share libraries. Instead just compile as executables and then transfer to GPU at any time

## Phantasm Graphics
A low level IR for Spectral Graphics ISA that can be assembled into an ELF64 binary
- Same idea as phantasm rv, @script annotations and labels

|instruction|details|
|---|---|
| load | |
| store | |
| add | |
| sub | |
| mult | |
| div | |
| matmult | |
| tensormult | |
| inv | |
| sin | |
| sample2d | |
| dotprod | |
| multaccum | |
| pushb/h/w/i | |
| popb/h/w/i | |
| jump/nlink | |
| branchn/eq | |
| branchlt/e | |
| branchgt/e | |
| and | |
| or | |
| not | |
| xor | |
