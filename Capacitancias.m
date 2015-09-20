%Calculo de capacitancias Tarea 1 - VLSI

Cgdon=1.82*10^-10;
Cgdop=2.34*10^-10;
Cjswn=3.43*10^-10;
Cjswp=2.15*10^-10;
Cgso=2.34*10^-10;
Cjn=4.13*10^-4;
Cjp=7.20*10^-4;
delta=0.3*10^-6;
ADn=19*delta^2;
ADp=45*delta^2;
PDn=15*delta;
PDp=19*delta;

Bn=58.4*10^-6;
Bp=19.0*10^-6;

Coxn=2*Bn/455.1710;
Coxp=2*Bp/201.36;

Won=1*10^-8;
Wop=5.866*10^-7;

CGD1=2*Won*Cgdon;
CGD2=2*Wop*Cgdop;
CDB1=(ADn*Cjn)+(PDn*Cjswn);
CDB2=(ADp*Cjp)+(PDp*Cjswp);
CG3=(Cgdon+Cgso)*Won+Coxn*Won*2*delta;
CG4=(Cgdop+Cgso)*Wop+Coxp*Wop*2*delta;
Cl=CGD1+CGD2+CDB1+CDB2+CG3+CG4+0.12*10^-15;
