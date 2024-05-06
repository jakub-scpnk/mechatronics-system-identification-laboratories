% author: Jakub Szczepaniak
% date: 25/04/2024

addpath("toolbox-for-lab-8\");

%% Task 2.1

modelFR = createpde('structural','frequency-solid');

modelFR.Geometry = modelM.Geometry;
modelFR.Mesh = modelM.Mesh;
structuralProperties(modelFR,'YoungsModulus',E,'PoissonsRatio', ...
nu,'MassDensity', rho);
structuralBC(modelFR,'Face',6,'Constraint','fixed');

structuralDamping(modelFR,'Zeta',0.001);

% parameters
Fx = 0;
Fy = 0;
Fz = 1;
VertexNo = 8;

structuralBoundaryLoad(modelFR,'Vertex',VertexNo,'Force',[Fx,Fy,Fz]);


flist = linspace(0,999,1000)*2*pi;
resFreq = solve(modelFR,flist,'ModalResults',resModal);

XYZ = [-0.05, 0.15, 0.01];

[FRF_disp,Freq] = DisplayFRF(resFreq, XYZ, 'displacement');
[FRF_vel,Freq] = DisplayFRF(resFreq, XYZ, 'velocity');
[FRF_acc ,Freq] = DisplayFRF(resFreq, XYZ, 'acceleration');

% displaying the point
XN = XYZ(1);
YN = XYZ(2);
ZN = XYZ(3);

figure
pdeplot3D(modelM);
hold on
plot3(XN,YN,ZN,'ro')
hold off
axis equal

%% Task 2.2

vel_deri = FRF_disp(:,3)*2*pi*1i.*Freq';
acc_deri = vel_deri*2*pi*1i.*Freq';

figure
subplot(211)
semilogx(Freq, 20*log10(abs(FRF_disp(:,3))));
title('Displacement');
ylabel('Amplitude [dB]');
subplot(2,1,2)
semilogx(Freq, phase(FRF_disp(:,3)));
ylabel('Phase [deg]');
xlabel('Frequency [Hz]');

figure
subplot(211)
semilogx(Freq, 20*log10(abs(FRF_vel(:,3))));
hold on
semilogx(Freq, 20*log10(abs(vel_deri)),'--');
hold off
title('Velocity');
ylabel('Amplitude [dB]');
legend('FRF', 'derivative', 'Location', 'northwest');
subplot(212)
semilogx(Freq, phase(FRF_vel(:,3)));
hold on
semilogx(Freq, phase(vel_deri),'--');
hold off
ylabel('Phase [deg]');
xlabel('Frequency [Hz]');
legend('FRF', 'derivative', 'Location', 'southwest');

figure
subplot(211)
semilogx(Freq, 20*log10(abs(FRF_acc(:,3))));
hold on
semilogx(Freq, 20*log10(abs(acc_deri)),'--');
hold off
title('Acceleration');
ylabel('Amplitude [dB]');
legend('FRF', 'derivative', 'Location', 'northwest');
subplot(212)
semilogx(Freq, phase(FRF_acc(:,3)));
hold on
semilogx(Freq, phase(acc_deri),'--');
hold off
ylabel('Phase [deg]');
xlabel('Frequency [Hz]');
legend('FRF', 'derivative', 'Location', 'southwest');


%% Task 2.3
Zlayer = 0.01;
Axis = 3;

[~,ModeShape,Xv,Yv,Zv] = DisplayMode(resFreq,modelFR,Zlayer,Axis,fc);

ModeZ = imag(ModeShape);
scale = max(Xv)./max(abs(ModeZ(:)));
figure
tri = delaunay(Xv,Yv);
trisurf(tri,Xv,Yv,ModeZ*scale);
axis equal
shading flat
xlabel('x (m)'); ylabel('y (m)'); zlabel('imag (FRF)');

%% Task 2.4

% for the test - logscale how to use it, how it works
% each of us will have different set of questions