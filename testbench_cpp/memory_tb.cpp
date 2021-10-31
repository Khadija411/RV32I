// memory_test
#include "Vmemory.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "iostream"

using namespace std;
vluint64_t main_time=0;

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vmemory* data_mem = new Vmemory;
    VerilatedVcdC* vcd_file=0;
  
     const char *vcd = Verilated::commandArgsPlusMatch("vcd=");
         if (1) {
          Verilated::traceEverOn(true);
          vcd_file = new VerilatedVcdC;
          data_mem->trace (vcd_file, 99);
          vcd_file->open ("trace_mem.vcd");
        }
    vluint64_t timeout = 0;
    const char *arg_timeout = Verilated::commandArgsPlusMatch("timeout=");
    if (arg_timeout[0]) {
        timeout = atoi(arg_timeout+9);
    }
    vluint64_t vcd_start = 0;
	const char *arg_vcd_start = Verilated::commandArgsPlusMatch("vcd_start=");
	if (arg_vcd_start[0]) {
	  vcd_start = atoi(arg_vcd_start+11);
  }
    bool dump = false;
    data_mem->clk = 0;

    while (!Verilated::gotFinish()) {
        if (vcd_file && !dump && (main_time > vcd_start)) {
            dump = true;
        }
        data_mem->address=2050;
        data_mem->ld=1;
        data_mem->str=0;
        data_mem->data_in=10;//example number
        data_mem->eval();

        if (dump) {
            vcd_file->dump(main_time);
        }
        
        if (timeout && (main_time >= timeout)) {
	        printf("Timeout: Exiting at time %lu\n", main_time);
            break;
	    }
        data_mem->address += 1;
        data_mem->clk = !data_mem->clk;
        main_time += 10;
        cout<<"Data Out     =   "<<data_mem->data_out<<endl;
    }

    if (vcd_file)
	  vcd_file->close();

    data_mem->final();
    delete data_mem;
    exit(0);
}