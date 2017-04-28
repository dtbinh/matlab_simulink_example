clear

simulink_parameter

s = tf('s')
P = Ks/(s*taup+1)
A = 1/(s*taua+1)
S = 1/(s*taus+1)

L0 = A*P*S

figure(1)
clf
bode(L0)
grid on

figure(2)
clf
step(L0)
grid on

wco_desired = 100 % approx 90° phase margin
Kp1=0.1 % pull down amplitude of -20dB
L1 = Kp1*L0
% synthesize PI for no static error and better tracking
%1/Ti = 0.1 * wco_desired
Ti_inv = 0.1*wco_desired
Ti2 = 1/Ti_inv
R2 = (s*Ti2+1)/(s*Ti2)
L2 = R2*L1

figure(3)
clf
bode (L0)
hold on
bode (L1, 'r')
bode (R2, 'g--')
bode (L2, 'g')
grid on

%ws > 2*wco_desired > 2/Ti
sampling_margin = 2;
ws = 2*wco_desired * sampling_margin;
fs = ws/(2*pi); % fs minimum
% round sampling frequency (Einfache Zahl nehmen)
fs = 1000; %Muss grösser als fs sein, die vorher berechnet wurde
            %Achtung: Z-Transform Koeffizenten sind abhängig von
            %Abtastfrequenz

Ts = 1/fs;
R2z = c2d(R2,Ts)

G2 = L2/(1+L2)

figure(4)
clf
step (G2)
grid on
