pragma circom 2.0.0;

/*This circuit template checks the working of the logic gates*/  

template devizkcircuit () {  

  // Declaration of signals.  

// input signals 

  signal input a;  
  signal input b; 

// gate signals

   signal x;
   signal y;

// output signal

   signal output q;  

 // AND GATE 
   x <== a * b;  

// NOT GATE
   y <== 1 + b - 2*b;

//OR GATE
   q <== x+y-x*y;
}

component main = devizkcircuit();