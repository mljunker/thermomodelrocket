% 9327010bd02f
% Bottle Rocket Trajectory
% ASEN 2012
% Created 11/27/16
% Modified 12/2/16
% Written by 9327010bd02f
% 1:Purpose
% Numerically integrating given differential functions in order to determine
% bottle rocket trajectory, using a verification case to check this
% integration, determining the parameter most dependended upon, and forming
% a set of parameters launching a rocket to within 1 m of 85 m
% Input:
% none at time of running, Verification case inputs already in code
% Output:
% Plots of verification case unaltered and varying with drag
% coefficient, launch angle, initial air pressure, and initial water volume.
% Peak height and landing distance of verification case.
% Change of peak height and landing distance with 10% change in parameters
% Parameters necessary for 85 m goal
% 4: Assumptions
% Isentropic flow from bottle throughout file

clear all;
close all;
%% Calling Verification case function
[ t,vals ] = verificationcase(0.5, 0.001, 50, 45, 5);
%% Sketch: Plots of Unaltered Verification Case
%Plot initially used as sketch to verify code before advancing
%Percentage change calculated at each step to identify most sensitive
%parameter

figure(1);
%Trajectory Plot
plot(vals(:,1),vals(:,2));
title ('Unaltered Verification Case - Trajectory')
xlabel ('Horizontal Position')
ylabel ('Vertical Position')
figure(2);
%Velocity Plot
plot(vals(:,1),vals(:,3));
title ('Unaltered Verification Case - Velocity')
xlabel ('Horizontal Position')
ylabel ('Velocity')
%Important Stats
%Verification Case
peak = max(vals(:,2));
finish = vals(find(vals(:,2)<0.1,1),1);
fprintf('Verification case peaks at %.4f m\n',peak);
fprintf('Verification case lands at %.4f m\n',finish);

%% Trajectory Plot with various drag coefficients 0.45 to 0.55
figure(3)
hold on
%Original Case
plot(vals(:,1),vals(:,2));
%Modifying Verification case
[ t,valsa ] = verificationcase( 0.45,0.001, 50, 45, 5);
plot(valsa(:,1),valsa(:,2));
[ t,valsb ] = verificationcase( 0.55,0.001, 50, 45, 5);
plot(valsb(:,1),valsb(:,2));
%Labeling
legend('CD = 0.5','CD = 0.45','CD = 0.55');
title ('Altered Verification Case - Drag Coefficient Changed 10%')
xlabel ('Horizontal Position')
ylabel ('Vertical Position')
%Percentage change from unmodified verification case
finisha = valsa(find(valsa(:,2)<0.1,1),1);
finishb = valsb(find(valsb(:,2)<0.1,1),1);
changea = ((finisha-finish)/finish)*100;
changeb = ((finishb-finish)/finish)*100;
peaka = max(valsa(:,2));
peakb = max(valsb(:,2));
dpa = ((peaka-peak)/peak)*100;
dpb = ((peakb-peak)/peak)*100;
hold off
%Outputs
fprintf('\nA 10%% decrease in CD gives a %.3f change in final distance \n',changea);
fprintf('A 10%% increase in CD gives a %.3f change in final distance \n',changeb);
fprintf('A 10%% decrease in CD gives a %.3f change in peak height \n',dpa);
fprintf('A 10%% increase in CD gives a %.3f change in peak height \n',dpb);

%% Trajectory Plot with various launch angles
figure(4)
hold on
%Original Case
plot(vals(:,1),vals(:,2));
%Modifying Verification case
[ t,valsc ] = verificationcase( 0.5,0.001, 50, 40.5, 5);
plot(valsc(:,1),valsc(:,2));
[ t,valsd ] = verificationcase( 0.5,0.001, 50, 49.5, 5);
plot(valsd(:,1),valsd(:,2));
%Labeling
legend('Theta = 45','Theta = 40.5','Theta = 49.5');
title ('Altered Verification Case - Launch Angle Changed 10%')
xlabel ('Horizontal Position')
ylabel ('Vertical Position')
%Percentage change from unmodified verification case
finishc = valsc(find(valsc(:,2)<0.1,1),1);
finishd = valsd(find(valsd(:,2)<0.1,1),1);
changec = ((finishc-finish)/finish)*100;
changed = ((finishd-finish)/finish)*100;
peakc = max(valsc(:,2));
peakd = max(valsd(:,2));
dpc = ((peakc-peak)/peak)*100;
dpd = ((peakd-peak)/peak)*100;
hold off
%Outputs
fprintf('\nA 10%% decrease in Theta gives a %.3f change in final distance \n',changec);
fprintf('A 10%% increase in Theta gives a %.3f change in final distance \n',changed);
fprintf('A 10%% decrease in Theta gives a %.3f change in peak height \n',dpc);
fprintf('A 10%% increase in Theta gives a %.3f change in peak height \n',dpd);

%% Trajectory Plot with various initial water volumes
figure(5)
hold on
%Original Case
plot(vals(:,1),vals(:,2));
%Modifying Verification case
[t,valse] = verificationcase( 0.5,0.0009, 50, 45, 5);
plot(valse(:,1),valse(:,2));
[ t,valsf ] = verificationcase( 0.5,0.0011, 50, 45, 5);
plot(valsf(:,1),valsf(:,2));
%Labeling
legend('Water Volume = 0.001','Water Volume = 0.0009','Water Volume = 0.0011');
title ('Altered Verification Case - Initial Water Volume')
xlabel ('Horizontal Position')
ylabel ('Vertical Position')
%Percentage change from unmodified verification case
finishe = valse(find(valse(:,2)<0.1,1),1);
finishf = valsf(find(valsf(:,2)<0.1,1),1);
changee = ((finishe-finish)/finish)*100;
changef = ((finishf-finish)/finish)*100;
peake   = max(valse(:,2));
peakf   = max(valsf(:,2));
dpe     = ((peake-peak)/peak)*100;
dpf     = ((peakf-peak)/peak)*100;
hold off
%Outputs
fprintf('\nA 10%% decrease in initial water volume gives a %.3f change in final distance \n',changee);
fprintf('A 10%% increase in initial water volume gives a %.3f change in final distance \n',changef);
fprintf('A 10%% decrease in initial water volume gives a %.3f change in peak height \n',dpe);
fprintf('A 10%% increase in initial water volume gives a %.3f change in peak height \n',dpf);

%% Trajectory Plot with various initial air pressure
figure(6)
hold on
%Original Case
plot(vals(:,1),vals(:,2));
%Modifying Verification case
[t,valsg] = verificationcase( 0.5,0.001, 45, 45, 5);
plot(valsg(:,1),valsg(:,2));
[ t,valsh ] = verificationcase( 0.5,0.001, 55, 45, 5);
plot(valsh(:,1),valsh(:,2));
%Labeling
legend('Gage Pressure = 50','Gage Pressure = 45','Gage Pressure = 55');
title('Altered Verification Case - Initial Air Pressure')
xlabel('Horizontal Position')
ylabel('Vertical Position')
%Percentage change from unmodified verification case
finishg = valsg(find(valsg(:,2)<0.1,1),1);
finishh = valsh(find(valsh(:,2)<0.1,1),1);
changeg = ((finishg-finish)/finish)*100;
changeh = ((finishh-finish)/finish)*100;
peakg   = max(valsg(:,2));
peakh   = max(valsh(:,2));
dpg     = ((peakg-peak)/peak)*100;
dph     = ((peakh-peak)/peak)*100;
hold off
%Outputs
fprintf('\nA 10%% decrease in initial air pressure gives a %.3f change in final distance \n',changeg);
fprintf('A 10%% increase in initial air pressure gives a %.3f change in final distance \n',changeh);
fprintf('A 10%% decrease in initial air pressure gives a %.3f change in peak height \n',dpg);
fprintf('A 10%% increase in initial air pressure gives a %.3f change in peak height \n',dph);
%% Most Sensitive Parameter
%From the above outputs, initial water volume is seem to have the largest
%effect on horizontal distance in any case of increase/decrease of
%parameter

%Theta is seen to have the largest effect on vertical distance
%% Optimization of initial water volume from verification case
figure(7)
volumes = [0.000001:0.00002:0.002];
maxdis = 0;
maxloc = 0;
hold on
%for loop running verificationcase function with variation of initial water
%volume
for i = 1: length(volumes)
    [t,valstmp] = verificationcase( 0.5,volumes(i), 50, 45, 5);
    if valstmp(find(valstmp(:,2)<0.1,1),1) >= maxdis
        maxdis = valstmp(find(valstmp(:,2)<0.1,1),1);
        maxloc = i;
        plot(valstmp(:,1),valstmp(:,2));
    end
end
title ('Trajectory Maximization with Respect to Initial Water Volume')
xlabel ('Horizontal Position')
ylabel ('Vertical Position')
hold off
%Outputs
fprintf('\nThe distance is maximized with respect to initial water volume at %.5f m^3 and %.2f m\n',volumes(maxloc),maxdis);
%% 85 Feet Case
a = 0.33;
b = volumes(maxloc);
c = 57;
d = 45;
[t,valsfin] = verificationcase( a,b,c,d,7.5);
figure(8)
hold on
plot(valsfin(:,1),valsfin(:,2));
%Labeling
title ('85 Foot Target Case')
xlabel ('Horizontal Position')
ylabel ('Vertical Position')
peak85 = max(valsfin(:,2));
finish85 = valsfin(find(valsfin(:,2)<0.1,1),1);
%Plotting points
scatter(valsfin(find(valsfin(:,2)==peak85,1)),peak85,'*');
scatter(finish85,0,'*');
x1 = valsfin(find(valsfin(:,2)==peak85,1))+5;
y1 = peak85;
txt1 = sprintf('(%.2f,%.2f)',valsfin(find(valsfin(:,2)==peak85,1)),peak85);
text(x1,y1,txt1)
x2 = finish85-17;
y2 = 2;
txt2 = sprintf('(%.2f,%.2f)',0,finish85);
text(x2,y2,txt2)

hold off
%Outputs
fprintf('\n85 m goal case peaks at %.4f m\n',peak85);
fprintf('85 m goal case lands at %.4f m\n',finish85);
fprintf('Drag coefficient = %.2f\n',a);
fprintf('Initial water volume = %.4f m^3\n',b);
fprintf('Initial air pressure = %.0f psi\n',c);
fprintf('Launch Angle = %.0f degrees\n',d);
%% End
