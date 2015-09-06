%Programa para graficar comportamiento ideal del un inversor
%ITCR/Introducci?n al dise?o de circuitos integrados
%Prof. Dr.-Ing. Alfonso Chac?n Rodr?guez
%Estudiantes: Francis L?pez Montero /Jeffry Quir?s Fallas

%Par?metros MOSFET

wn=3.0e-6;
ln=0.6e-6;
%Voltaje Umbral N 
Vtn=0.77;

%Voltaje Umbral P
Vtp=(-0.89);

%Tension alimentacion
Vdd=3.3;

tox=1.41e-8;
e0=8.854e-12;%Permitividad del vac?o
Cox=3.6*e0/tox;

%Voltaje cr?tico
vsatn=10e7; %velocidad saturacion electrones
vsatp=8e6; %velocidad saturacion huecos
n=1;

r=2;%Proporcion beta PMOS respecto a NMOS

for Vin=0:0.3:Vdd
    Vingraf(n)=Vin;
    m=1;
    for Vout=0:0.3:Vdd
        Voutgraf(m)=Vout;
 
        %Par?metros PMOS
        up=(185)/(1+(abs(Vin+1.5*Vtp)/(0.338e9 * tox)));%Efectividad de canal
        Vcp=ln*(2*vsatp/up);
        VGTp=Vin+Vtp;
        Vdpsat=(VGTp*Vcp)/(VGTp+Vcp);

        %Ecuaciones region PMOS
        if(Vin>Vtp + Vdd)
            Idsp(m,n)=0;
        elseif((Vin<Vtp + Vdd) && (Vout>Vdpsat))
            Vds=Vdd-Vout;
            Idsp(m,n)=(up/(1+(Vds/Vcp)))*Cox*r*(wn/ln)*(VGTp-(Vds/2))*Vds;
        elseif((Vin<Vtp + Vdd) && (Vout<=Vdpsat))
            Idsp(m,n)=Cox*r*wn*(VGTp-Vdpsat)*vsatp;
        end
%_-------------------------------------------------------------------------        
        %Parametros NMOS
        un=(540)/(1+((Vin+Vtn)/(0.54e9 * tox))^1.85);
        Vcn=ln*(2*vsatn/un);
        VGTn=Vin-Vtn;
        Vdnsat=(VGTn*Vcn)/(VGTn+Vcn);

        if(Vin<Vtn)
            Idsn(m,n)=0;
        elseif((Vin>Vtn)&&(Vout<Vdpsat))
            Vds=Vout;
            Idsn(m,n)=(un/(1+(Vds/Vcn)))*Cox*(wn/ln)*(VGTn-(Vds/2))*Vds;
        elseif((Vin>Vtn)&&(Vout>=Vdpsat))
            Idsn(m,n)=Cox*wn*(VGTn-Vdnsat)*vsatn;
        end
        m=m+1;
    end
    n=n+1;
end

plot(Vingraf,Idsn,'b',Vingraf,Idsp,'r')
xlabel('Vds(V)')
ylabel('Ids(A)')
axis on
grid on
box off

    %Region de corte
    %Vin<Vtn; NMOS
    %Vin>Vtp + Vdd; PMOS

    %Region lineal NMOS
    %Vin>Vtn;
    %Vout<Vin-Vtn;

    %Region lineal PMOS
    %Vin<Vtp + Vdd;
    %Vout>Vin-Vtp;

    %Region saturacion NMOS
    %Vin>Vtn;
    %Vout>Vin-Vtn;

    %Region saturacion PMOS
    %Vin<Vtp + Vdd;
    %Vout<Vin-Vtp;

