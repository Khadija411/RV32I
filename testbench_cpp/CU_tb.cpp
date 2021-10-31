// Control Unit test
#include "Vcontrol_unit.h"
#include "verilated.h"
#include "iostream"
#include<bits/stdc++.h>
#include "stdlib.h"
using namespace std;


int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vcontrol_unit* cu = new Vcontrol_unit;
    cu->opcode=bitset<8>("0110011").to_ulong();
    cu->fun3=000;
    cu->func7=0;
    cu->eval();  // eval will start always block
    cout<<"Result= "<<cu->ALU_C<<endl;
    cu->final();
    delete cu;
    exit(0);
}