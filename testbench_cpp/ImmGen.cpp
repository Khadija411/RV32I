// ALU_test
#include "VImmediate.h"
#include "verilated.h"
#include "iostream"
using namespace std;
int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VImmediate* imm = new VImmediate;
    imm->inst=00000000000100101000001010010011;
    imm->PC=00000000000000000000000000001100;
    imm->eval();
    cout<<"Sb type= "<<imm->Sb<<endl;
    imm->final();
    delete imm;
    exit(0);
}