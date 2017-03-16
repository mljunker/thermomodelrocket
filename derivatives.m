function [ instant ] = derivatives( t, vals )
%Sets up the derivative situation necessary for running through ode45

%Each phase calculates its own dVOLdt dMRdt and dMRdat
%Thrust and drag force calculated in each phase for use in calculating dXdt
%dZdt dVELdt and dThetadt later.
global g gamma R volumebottle pressureatmosphere areathroat ...
    areabottle massairinitial Cd volumeairinitial totalpressure ...
    rhowater rhoair tempairinitial CD
%CD
%% Prepping Output
    dXdt = vals(1);
    dZdt = vals(2);
    dVELdt = vals(3);
    dTHETAdt = vals(4);
    dVOLdt = vals(5);
    dMRdt = vals(6);
    dMAdt = vals(7);
instant = [
    dXdt;
    dZdt;
    dVELdt;
    dTHETAdt;
    dVOLdt;
    dMRdt;
    dMAdt;
];
%% Phase 1 - Before the water is exhausted
% Determined by air not taking up all bottle volume yet
if dVOLdt < volumebottle
    presstmp = ((volumeairinitial/dVOLdt)^gamma)*totalpressure; %3 
    velocityexhaust = sqrt((presstmp-pressureatmosphere)*(2/rhowater));%7
    massflow = Cd*rhowater*areathroat*velocityexhaust; %4
    thrust = 2*Cd*(presstmp-pressureatmosphere)*areathroat; %8
    pressdynamic = 0.5*rhoair*(dVELdt^2);    
    dragforce = pressdynamic*CD*areabottle; %2
    instant(5) = Cd*areathroat*velocityexhaust; %10, change of volume of air
    instant(6) = -rhowater*Cd*areathroat*velocityexhaust; %11, change of rocket mass
    instant(7) = 0; %mass of air not changing, no air escaping
end
%% Phase 2 - After the water is exhausted
% Determined by air taking up all bottle volume and escaping
if dVOLdt >= volumebottle
    presstmptransition = totalpressure*((volumeairinitial/volumebottle)^gamma);
    %13 pressure in bottle when all water is gone
    temptmptransition = tempairinitial*((volumeairinitial/volumebottle)^(gamma-1));
    %13 temperature in bottle when all water is gone
    presstmp2 = presstmptransition*((dMAdt/massairinitial)^gamma);
    %14 pressure at any time in phase 2
    rhoairtmp2 = dMAdt/volumebottle; %15, density of air
    tempairtmp2 = presstmp2/(rhoairtmp2*R); %15
    presscrit = presstmp2*((2/(gamma+1))^(gamma/(gamma-1))); % 16, critical pressure
    if presscrit > pressureatmosphere
        %choked flow
        tempexit = tempairtmp2*(2/(gamma+1));  % 18
        pressexit = presscrit;
        rhoexit = pressexit/(R*tempexit);
        velocityexit = sqrt(gamma*R*tempexit);% 17 exit velocity
    else    
        %not choked
        pressexit = pressureatmosphere; %19
        machexit = sqrt((((presstmp2/pressexit)^((gamma-1)/gamma))-1)*(2/(gamma-1)));
        %20 rearragned to separate mach number
        tempexit = tempairtmp2*(1+((gamma-1)/2)*(machexit^2)); %21
        rhoexit = pressureatmosphere/(R*tempexit);
        velocityexit = machexit*sqrt(gamma*R*tempexit);
    end
    massflow = Cd*rhoexit*areathroat*velocityexit;
    thrust = massflow*velocityexit+(pressexit-pressureatmosphere)*areathroat;
    %23 thrust in both choked and non-choked cases
    
    instant(5) = 0; %volume of air in bottle remains constant
    instant(6) = -massflow; %26 change in rocket mass
    instant(7) = -massflow; %change in air mass inside rocker- same as above 
    %as change in rocket mass only caused by change in air mass
    
    pressdynamic = 0.5*rhoair*(dVELdt^2);    
    dragforce = pressdynamic*CD*areabottle; %2
    %reintroduce presstmp to check for phase 3
    presstmp = presstmp2;
end
%% Phase 3 - Ballistic Phase
% Ballistic phase, pressure inside bottle now atmospheric
% Uses Equation 1
if presstmp <= pressureatmosphere
    thrust = 0;
    instant(5) = 0;
    instant(6) = 0;
    instant(7) = 0;
    %No masses or volumes changing
    pressdynamic = 0.5*rhoair*(dVELdt^2);    
    dragforce = pressdynamic*CD*areabottle; %2
end
%% True for all phases - Equation 1
instant(1) = dVELdt*cos(dTHETAdt);
instant(2) = dVELdt*sin(dTHETAdt);
instant(3) = (thrust-dragforce-dMRdt*g*sin(dTHETAdt))/dMRdt;
instant(4) = (-g*cos(dTHETAdt))/dVELdt;
%Included to avoid NaN
%At low speeds such as the very beginning, the angle of the flight will not
%be changing, dVELdt approaching zero produced dTHETAdt approaching
%infinity, which is not physically feasible
%From mutliple trials, 1 appears to produce accurate results.
if dVELdt < 1
    instant(4) = 0;
end
%% After Finish - On Ground
%Nothing changing after ground is reached
if dZdt < .1
    instant(:) = 0;
end
%% End
end

