// ALU_test
#include "VALU.h"
#include "verilated.h"
#include "iostream"
using namespace std;
int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VALU* alu = new VALU;
    alu->A=5;
    alu->B=5;
    alu->Data_sel=0000;
    alu->eval();
    cout<<"Result= "<<alu->res<<endl;
    alu->final();
    delete alu;
    exit(0);
}