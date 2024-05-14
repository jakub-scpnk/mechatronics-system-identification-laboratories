% author: Jakub Szczepaniak
% date: 25/04/2024

clear

addpath("toolbox-for-lab-8");
load('lab_8_task_1_workspace.mat')

%% Task 2.1

modelFR = createpde('structural','frequency-solid');

modelFR.Geometry = modelM.Geometry;
modelFR.Mesh = modelM.Mesh;
structuralProperties(modelFR,'YoungsModulus',E,'PoissonsRatio', ...
nu,'MassDensity', rho);
structuralBC(modelFR,'Face',6,'Constraint','fixed');

% structuralDamping(modelFR,'Zeta',0.001);
% FOR TASK 2.4 - following line of code + repet procedure 2.1 and 2.3:
structuralDamping(modelFR,'Zeta',0.03);

% parameters
Fx = 0;
Fy = 0;
Fz = 1;
VertexNo = 8;

structuralBoundaryLoad(modelFR,'Vertex',VertexNo,'Force',[Fx,Fy,Fz]);


flist = linspace(0,999,1000)*2*pi;
resFreq = solve(modelFR,flist,'ModalResults',resModal);

XYZ = [-0.05, 0.15, 0.01];
%XYZ = [-0.05, 0.0866, 0.01];
%XYZ = [0, 0.15, 0.01];

[FRF_disp,Freq] = DisplayFRF(resFreq, XYZ, 'displacement');

figure()
semilogx(Freq, 20*log10(abs(FRF_disp)))
xlabel 'frequency [Hz]'
ylabel 'amplitude [dB]'
title 'Displacement frequency response function'
legend('X axis', 'Y axis', 'Z axis');
grid on

[FRF_vel,Freq] = DisplayFRF(resFreq, XYZ, 'velocity');

figure()
semilogx(Freq, 20*log10(abs(FRF_vel)))
xlabel 'Frequency [Hz]'
ylabel 'amplitude [dB]'
title 'Velocity frequency response function'
legend('X axis', 'Y axis', 'Z axis');
grid on

[FRF_acc ,Freq] = DisplayFRF(resFreq, XYZ, 'acceleration');

figure()
semilogx(Freq, 20*log10(abs(FRF_acc)))
xlabel 'Frequency [Hz]'
ylabel 'amplitude [dB]'
title 'Acceleration frequency response function'
legend('X axis', 'Y axis', 'Z axis');
grid on

% % displaying the point
% XN = XYZ(1);
% YN = XYZ(2);
% ZN = XYZ(3);
% 
% figure
% pdeplot3D(modelM);
% hold on
% plot3(XN,YN,ZN,'ro')
% hold off
% axis equal

%% Task 2.2

vel_deri = FRF_disp(:,3)*2*pi*1i.*Freq';
acc_deri = vel_deri*2*pi*1i.*Freq';

figure()
subplot(211)
semilogx(Freq, 20*log10(abs(FRF_disp(:,3))));
title('Displacement');ylabel('Amplitude [dB]');
grid on

subplot(212)
semilogx(Freq, phase(FRF_disp(:,3)));
ylabel('Phase [deg]'); xlabel('Frequency [Hz]')
grid on

figure()
subplot(211)
semilogx(Freq, 20*log10(abs(FRF_vel(:,3))));
grid on; hold on
semilogx(Freq, 20*log10(abs(vel_deri)),'--');
hold off
title('Velocity'); ylabel('Amplitude [dB]');
legend('FRF', 'derivative', 'Location', 'northwest');

subplot(212)
semilogx(Freq, phase(FRF_vel(:,3)));
grid on
hold on
semilogx(Freq, phase(vel_deri),'--');
hold off
ylabel('Phase [deg]'); xlabel('Frequency [Hz]');
legend('FRF', 'derivative', 'Location', 'southwest');

figure
subplot(211)
semilogx(Freq, 20*log10(abs(FRF_acc(:,3))));
grid on
hold on
semilogx(Freq, 20*log10(abs(acc_deri)),'--');
hold off
title('Acceleration'); ylabel('Amplitude [dB]');
legend('FRF', 'derivative', 'Location', 'northwest');

subplot(212)
semilogx(Freq, phase(FRF_acc(:,3)));
grid on
hold on
semilogx(Freq, phase(acc_deri),'--');
hold off
ylabel('Phase [deg]'); xlabel('Frequency [Hz]');
legend('FRF', 'derivative', 'Location', 'southwest');


%% Task 2.3
Zlayer = 0.01;
Axis = 3;

% task 2.3
%for fc = [94.804, 565.48, 589.72]
% task 2.4
for fc = [94, 312, 566]
    [~,ModeShape,Xv,Yv,Zv] = DisplayMode(resFreq,modelFR,Zlayer,Axis, fc);

    ModeZ = imag(ModeShape);
    scale = max(Xv)./max(abs(ModeZ(:)));
    figure
    tri = delaunay(Xv,Yv);
    trisurf(tri,Xv,Yv,ModeZ*scale);
    axis equal
    shading flat
    xlabel('x (m)'); ylabel('y (m)'); zlabel('imag (FRF)');
    title(['Mode shape for frequency = ', int2str(fc), ' [Hz]']);

end
%% Task 2.4

% for the test - logscale how to use it, how it works
% each of us will have different set of questions