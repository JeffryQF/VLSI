%Programa para graficar comportamiento ideal del un inversor
%ITCR/Introducci?n al dise?o de circuitos integrados
%Prof. Dr.-Ing. Alfonso Chac?n Rodr?guez
%Estudiantes: Francis L?pez Montero /Jeffry Quir?s Fallas

%Par?metros MOSFET

wn=3.0e-6;
ln=0.6e-6;
%Voltaje Umbral N 
Vthn=0.77;

%Voltaje Umbral P
Vthp=(-0.89);

%Beta umbral
Bn=58.4e-6;
%Bp=-19.0e-6;

tox=1.41e-8;
e0=8.854e-12;%Permitividad del vac?o
Cox=3.6*e0/tox;


%Voltaje cr?tico
vsatn=10e7; %velocidad saturacion electrones
vsatp=8e6; %velocidad saturacion huecos


r=0;%proporcion ancho pmos respecto a nmos

%Voltaje Drain saturaci?n PMOS
m=1;
for Vgs=abs(Vthp):0.2:2.6
    n=1;
    for Vds=0:0.1:3.3
        %PMOS
        
        up=(185)/(1+(abs(Vgs+1.5*Vthp)/(0.338e9 * tox)));%Efectividad de canal
        Vcp=ln*(2*vsatp/up);
        VGTp=Vgs-Vthp;
        Vdpsat=(VGTp*Vcp)/(VGTp+Vcp);
        Vdsgraf(n)=Vds;
        if(Vgs<Vthp)
            Idps(n,m)=0;
        end
        if(Vds<=Vdpsat)
            Idps(n,m)=(up/(1+(Vds/Vcp)))*Cox*r*(wn/ln)*(VGTp-(Vds/2))*Vds;
        end
        if(Vds>Vdpsat)
            Idps(n,m)=Cox*r*wn*(VGTp-Vdpsat)*vsatp;
        end
        n=n+1;
    end
    m=m+1;
end
        
%Voltaje Drain saturaci?n NMOS
m=1;
for Vgs=Vthn:0.2:2.6
    n=1;
    for Vds=0:0.1:3.3
        %NMOS
        un=(540)/(1+((Vgs+Vthn)/(0.54e9 * tox))^1.85);
        Vcn=ln*(2*vsatn/un);
        VGTn=Vgs-Vthn;
        Vdnsat=(VGTn*Vcn)/(VGTn+Vcn);
        Vdsgraf(n)=Vds;
        if(Vgs<Vthn)
            Idns(n,m)=0;
        end
        if(Vds<=Vdnsat)
            Idns(n,m)=(un/(1+(Vds/Vcn)))*Cox*(wn/ln)*(VGTn-(Vds/2))*Vds;
        end
        if(Vds>Vdnsat)
            Idns(n,m)=Cox*wn*(VGTn-Vdnsat)*vsatn;
        end
        n=n+1;
    end
    m=m+1;
end


plot(Vdsgraf,Idns,'b',Vdsgraf,Idps,'r')
xlabel('Vds(V)')
ylabel('Ids(A)')
axis on
grid on
box off
