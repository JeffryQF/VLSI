
DatosNMOS=load('/home/jeffryqf/TEC/II_Semestre_2015/VLSI/RepositorioTarea/VLSI/Simulacion_Electric/NMOS_Valores.txt');
DatosPMOS=load('/home/jeffryqf/TEC/II_Semestre_2015/VLSI/RepositorioTarea/VLSI/Simulacion_Electric/PMOS_Valores.txt');

ResistenciaPMOS=0;
ResistenciaNMOS=0;
j=1;
k=1;

for j=1:1:1650
	ResistenciaPMOS=ResistenciaPMOS + DatosPMOS(j,2)/DatosPMOS(j,3);
endfor

for k=1:1:18
	ResistenciaNMOS=ResistenciaNMOS + DatosNMOS(k,2)/DatosNMOS(k,3);
endfor

Resistencia_pMOS=abs(ResistenciaPMOS/j)
Resistencia_nMOS=abs(ResistenciaNMOS/k)
