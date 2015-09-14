%Programa para graficar comportamiento ideal del un inversor
%ITCR/Introducci?n al dise?o de circuitos integrados
%Prof. Dr.-Ing. Alfonso Chac?n Rodr?guez
%Estudiantes: Francis L?pez Montero /Jeffry Quir?s Fallas

%Par?metros NMOS

lambda=0.3*10^-6;
wn=12*lambda;
ln=2*lambda;

%Par?metros PMOS
x=2.418;
lp=ln;
wp=x*wn;
%Voltaje Umbral N 
Vtn=0.77;

%Voltaje Umbral P
Vtp=(-0.89);

%Tension alimentacion
Vdd=3.3;

%tox=1.41;
%e0=8.854e-12;%Permitividad del vac?o
%Cox=3.6*e0/(tox*10^-9);

betan=58.4*10^-6;
betap=(-19.0*10^-6);

r=(-betap*(wp/lp))/(betan*(wn/ln));%relaci?n betas

Vinv=(Vdd+Vtp+Vtn*sqrt(1/r))/(1+sqrt(1/r));

n=1;

for Vin=0:0.5:Vdd
    Vingraf(n)=Vin;
    m=1;
    VGTp=abs(Vin-Vdd) + Vtp;    
    VGTn=Vin-Vtn;
    
    for Vout=0:0.3:Vdd
        Voutgraf(m)=Vout;
     

        %Ecuaciones region PMOS
        if(Vin>Vdd + Vtp)
            Idp=0;
        elseif((Vin<Vdd + Vtp) && (Vout>Vin - Vtp))
            Vdsp=abs(Vout-Vdd);
            Idp=betap*(wp/lp)*(2*VGTp-Vdsp)*Vdsp;
        elseif((Vin<Vdd + Vtp) && (Vout<Vin - Vtp))
            Idp=betap*(wp/lp)*(VGTp)^2;
        end
        Idsp(m,n)=abs(Idp);
%_-------------------------------------------------------------------------        
        %Ecuaciones region NMOS
        if(Vin<Vtn)
            Idsn(m,n)=0;
        elseif((Vin>Vtn)&&(Vout<Vin - Vtn))
            Vdsn=Vout;
            Idsn(m,n)=betan*(wn/ln)*((2*VGTn)-Vdsn)*Vdsn;
        elseif((Vin>Vtn)&&(Vout>Vin - Vtn))
            Idsn(m,n)=betan*(wn/ln)*(VGTn)^2;
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
        