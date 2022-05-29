\m4_TLV_version 1d: tl-x.org
\SV
   m4_makerchip_module
\TLV
   
   
   $S1 = $A ^ $B;
   $C1 = $A & $B;
   $Sum = $S1 ^ $Cin;
   $C2 = $S1 & $Cin;
   $Cout = $C1 | $C2;
   // Verilog arithmetic operators: +, -, *, /, %, etc.
  
\SV
endmodule
