function [  ] = PhysElecLab2CALC(  )
% Using DATA collected in Lab this funcion will calculate the current in
% the junction of the base and collector of a bjt
%where:
%VBE, VBC = the base to emitter and base to collector voltages (V) 
%IE, IC, IB = the emitter, collector and base currents (A) 
%IEs, ICs = the emitter and collector saturation currents (A) 
%?F, ?R = the forward and reverse collector to emitter current ratios 
%nE, nC = emitter and collector ideality (or slope) factors
clear
clc
close all

GradIC = 37.1;
GradIE= 37.3;
invGradIC = 1/GradIC;
invGradIE= 1/GradIE;


format long g
Vt = 0.0259;
Ne= invGradIE/Vt;
Ies = 1.3996*10^-14;
Nc= invGradIC/Vt;
Ics = 3.11488*10^-14;
alphaF = 0.9939;
alphaR = 0.463;
Vbe= 0.67;

Ic = @(Vbc) CollectorCurrent(Vbe,Vt,Ies,Ne,Vbc,Ics,Nc,alphaF );

Ib = @(Vbc) BaseCurrent( Vbe,Vt,Ies,Ne,Vbc,Ics,Nc,alphaF,alphaR );

figure(1)
xlabel('Vbc [V] VB-VC')
ylabel('Ic (A)    Ib (A) /r--/')
title(' BJT I-V Characteristics')
grid on
hold on
fplot(Ic, [0 0.67])
fplot(Ib, [0 0.67], 'r')


Vbc=0.04:0.09:0.76;
Ic=ones(size(Vbc));
Ib=ones(size(Vbc));
fprintf('  Vbc             Ic            Ib\n')
for k= 1:1:length(Vbc)
    Ic(k)= CollectorCurrent(Vbe,Vt,Ies,Ne,Vbc(k),Ics,Nc,alphaF );
    Ib(k)= BaseCurrent( Vbe,Vt,Ies,Ne,Vbc(k),Ics,Nc,alphaF,alphaR );
fprintf(' %.8f    %.8f    %.8f\n', Vbc(k),Ic(k),Ib(k))
end 


xlabel('Vbc [V] VB-VC')
ylabel('Ic (A)    Ib (A) /r--/')
title(' BJT I-V Characteristics')
grid on

plot(Vbc,Ic, 'bv' )
plot(Vbc,Ib, 'rs')
hold off



end



function [ Ic ] = CollectorCurrent(Vbe,Vt,Ies,Ne,Vbc,Ics,Nc,alphaF )

Ic = (exp(Vbe/(Ne*Vt))-1)*Ies*alphaF - Ics*(exp(Vbc/(Nc*Vt))-1);

end


function [ Ib ] = BaseCurrent( Vbe,Vt,Ies,Ne,Vbc,Ics,Nc,alphaF,alphaR )

Ib = (exp(Vbe/(Ne*Vt))-1)*(1-alphaF)*Ies + (1-alphaR)*Ics*(exp(Vbc/(Nc*Vt))-1);
end