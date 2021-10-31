#include "Vreg_file.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "iostream"

using namespace std;
vluint64_t main_time=0;

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vreg_file cache = new Vreg_file;
    VerilatedVcdC* vcd_file=0;
  
     const char *vcd = Verilated::commandArgsPlusMatch("vcd=");
         if (vcd[0]) {
          Verilated::traceEverOn(true);
          vcd_file = new VerilatedVcdC;
          cache->trace (vcd_file, 99);
          vcd_file->open ("trace.vcd");
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
    cache->clk = 0;

    while (!Verilated::gotFinish()){
        if (vcd_file && !dump && (main_time > vcd_start)) {
            dump = true;
        }
        cache->rs1=1;
        cache->rs2=3;
        cache->rd=3;
        cache->wen=1;
        cache->wdata=10;
        cache->rst=0;
        cache->eval();

        if (dump) {
            vcd_file->dump(main_time);
        }
        
        if (timeout && (main_time >= timeout)) {
	        printf("Timeout: Exiting at time %lu\n", main_time);
	    }
        cache->clk = !cache->clk;
        main_time += 10;
    }
    cout<<"operand A= "<<cache->rdata1<<endl;
    cout<<"operand B= "<<cache->rdata2;
    if (vcd_file)
	  vcd_file->close();

    cache->final();
    delete cache;
    exit(0);
}