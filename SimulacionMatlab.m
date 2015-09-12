%Programa para graficar comportamiento ideal del un inversor
%ITCR/Introducci?n al dise?o de circuitos integrados
%Prof. Dr.-Ing. Alfonso Chac?n Rodr?guez
%Estudiantes: Francis L?pez Montero /Jeffry Quir?s Fallas

%Par?metros NMOST

lambda=0.3*10^-6;
wn=12*lambda;
ln=2*lambda;

%Parámetros PMOS
x=1;
lp=ln;
wp=x*wn;
%Voltaje Umbral N 
Vtn=0.77;

%Voltaje Umbral P
Vtp=(-0.89);

%Tension alimentacion
Vdd=3.3;

tox=1.41;
e0=8.854e-12;%Permitividad del vac?o
Cox=3.6*e0/(tox*10^-9);

%Voltaje cr?tico
vsatn=10^7; %velocidad saturacion electrones
vsatp=8e6; %velocidad saturacion huecos
n=1;

r=3;%Proporcion beta PMOS respecto a NMOS

for Vin=0:0.5:Vdd
    Vingraf(n)=Vin;
    m=1;
    %Par?metros PMOS
    up=(185)/(1+(abs(Vin-1.5*Vtp)/(0.338 * tox)));%Efectividad de canal
    Vcp=lp*(2*vsatp/up);
    VGTp=Vin + Vtp;
    Vdpsat=(VGTp*Vcp)/(VGTp+Vcp);
    
    %Parametros NMOS
    un=(540)/(1+((Vin+Vtn)/(0.54 * tox))^1.85);
    Vcn=ln*(2*vsatn/un);
    VGTn=Vin-Vtn;
    Vdnsat=(VGTn*Vcn)/(VGTn+Vcn);
    
    for Vout=0:0.3:Vdd
        Voutgraf(m)=Vout;
     

        %Ecuaciones region PMOS
        if(Vin>Vdd + Vtp)
            Idp=0;
        elseif((Vin<Vdd + Vtp) && (Vout>Vdpsat))
            Vds=Vdd-Vout;
            Idp=(up/(1+(Vds/Vcp)))*Cox*r*(wp/lp)*(VGTp-(Vds/2))*Vds;
        elseif((Vin<Vdd + Vtp) && (Vout<=Vdpsat))
            Idp=Cox*r*wp*(VGTp-Vdpsat)*vsatp;
        end
        Idsp(m,n)=abs(Idp);
%_-------------------------------------------------------------------------        
        %Ecuaciones region NMOS
        if(Vin<Vtn)
            Idsn(m,n)=0;
        elseif((Vin>Vtn)&&(Vout<Vdnsat))
            Vds=Vout;
            Idsn(m,n)=(un/(1+(Vds/Vcn)))*Cox*(wn/ln)*(VGTn-(Vds/2))*Vds;
        elseif((Vin>Vtn)&&(Vout>=Vdnsat))
            Idsn(m,n)=Cox*wn*(VGTn-Vdnsat)*vsatn;
        end
        m=m+1;
    end
    n=n+1;
end

plot(Voutgraf,Idsn,'b',Voutgraf,Idsp,'r')
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

