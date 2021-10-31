// ALU_test
#include "VBranch.h"
#include "verilated.h"
#include "iostream"
using namespace std;
int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VBranch* branch = new VBranch;
    branch->A=5;
    branch->B=5;
    branch->fun3=000;
    branch->en=1;
    branch->eval();
    cout<<"Result= "<<branch->res<<endl;
    branch->final();
    delete branch;
    exit(0);
}