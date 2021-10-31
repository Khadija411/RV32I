// without vcd file
// memory_test
#include "Vmemory.h"
#include "verilated.h"
#include "iostream"
#include "stdlib.h"

using namespace std;

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vmemory* inst_mem = new Vmemory;

    while (!Verilated::gotFinish())
    {
        inst_mem->address=2048;
        inst_mem->eval();
        cout<<"Instruction= "<<inst_mem->instruction;
        cout<<" At Address= "<<inst_mem->address<<endl;
        inst_mem->address++;
    }
    inst_mem->final();
    delete inst_mem;
    exit(0);
}