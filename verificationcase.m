function [ t,vals ] = verificationcase( dragcoef,watervolume, airpressure, angle, time)
%Takes as arguments:initial pressure of air, initial volume fraction of water, drag
    %coefficient, and launch angle
%Using other conditions given in verification case, uses ode45 to determine
%the trajectory with the new argument

    global g gamma R volumebottle pressureatmosphere areathroat ...
    areabottle massairinitial Cd volumeairinitial totalpressure ...
    rhowater rhoair tempairinitial CD
%% Given
%To be modified to change distance:initial pressure of air, initial volume fraction of water, drag
    %coefficient, and launch angle
g = 9.81; %m/s^2 acceleration due to gravity
Cd = 0.8; %discharge coefficient
rhoair = 0.961; %kg/m^3 ambient air density
volumebottle = 0.002; %m^3 volume of empty bottle
pressureatmosphere = 12.03 * 6900; %psi to Pa
gamma = 1.4; %ratio of specific heats for air
rhowater = 1000; %kg/m^3 density of water
diameterthroat = 2.1/100; %cm to m diameter of throat
diameterbottle = 10.5/100; % cm to m diameter of bottle
R = 287; %J/kgK
massbottle = 0.07; %kg, mass of empty bottle
CD = dragcoef; %drag coeffiecient
pressuregage = airpressure * 6900; %psi to Pa
volumewaterinitial = watervolume; %m^3 initial volume of water in bottle
tempairinitial = 300; %K, initial temperature of air
v0 = 0; %m/s initial velocity of rocket
theta = angle*(pi/180); %initial angle of rocket
x0 = 0; %initial horizontal distance
y0 = 0.1; %initial vertical height
%% Additional Preliminary Calculations
areathroat = (pi/4)*(diameterthroat^2);
areabottle = (pi/4)*(diameterbottle^2);
totalpressure = pressureatmosphere+pressuregage;
volumeairinitial = volumebottle - volumewaterinitial;
massairinitial = (totalpressure*volumeairinitial)/(R*tempairinitial);
masswaterinitial = rhowater*volumewaterinitial;
totalmassinitial = massbottle + massairinitial + masswaterinitial;
%% ODE 45
[t, vals] = ode45(@(t,vals) derivatives(t,vals),[0 time],[x0 y0 v0 theta volumeairinitial totalmassinitial massairinitial ]);
end

