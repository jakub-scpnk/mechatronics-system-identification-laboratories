% author: Jakub Szczepaniak
% date: 25/04/2024

addpath("toolbox-for-lab-8");

%% Task 1

% defining model parameters
E = 2.1e11;     % Yung modulus
rho = 7.8e3;    % density
nu = 0.3;       % poisson's ratio

X = 0.1;        % dimensions
Y = 0.3;
Z = 0.01;

modelM = createpde('structural','modal-solid'); % creating an object
gm = multicuboid(X,Y,Z);                        % adding the geometry
modelM.Geometry = gm;

% displaying the geometry
figure(1)
pdegplot(modelM,'EdgeLabels','on');
axis equal
title 'Model with visible edges'
save_fig2png(gcf,[16 9], 'figures/lab_8_task_1_fig_1');
figure(2)
pdegplot(modelM,'FaceLabels','on');
axis equal
title 'Model with visible surfaces'
save_fig2png(gcf,[16 9], 'figures/lab_8_task_1_fig_2');
figure(3)
pdegplot(modelM,'VertexLabels','on');
axis equal
title 'Model with visible vertexes'
save_fig2png(gcf,[16 9], 'figures/lab_8_task_1_fig_3');

% generating the FEM mesh
hmax = 8e-3; % max length of element edge
msh = generateMesh(modelM,'Hmax',hmax);

% displaying th mesh
figure('Name','Displaying the mesh')
pdeplot3D(modelM);
axis equal
save_fig2png(gcf,[16 9], 'figures/lab_8_task_1_fig_4');

% assingning material properties
structuralProperties(modelM,'YoungsModulus',E, ...
                            'PoissonsRatio',nu, ...
                            'MassDensity',rho);
% defining boundary conditions (here - full restrain on surface)
structuralBC(modelM,'Face',6,'Constraint','fixed');

% performing the simulation
resModal = solve(modelM,'FrequencyRange',[0,1000]*2*pi);

modeID = 1:numel(resModal.NaturalFrequencies);
tmodalResults = table(modeID.',resModal.NaturalFrequencies/(2*pi));
tmodalResults.Properties.VariableNames = {'Mode','Frequency'};
disp(tmodalResults)

save('lab_8_task_1_workspace.mat')

% animation
ModeNumber = 1;
FrameRate = 30;
AnimateModeShape(resModal,ModeNumber,FrameRate)