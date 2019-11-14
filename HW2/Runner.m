clc;
clear all;
close all;

% PD : Problem Dimension
% NPE : Number of Nodes per Element

% NoN : Number of Nodes
% NoE : Number of Elements

% NL : Nodes List [ NoN X PD ]
% EL : Elements List [ NoE X NPE ]

% ENL : Extended Node List [ NoN X (6xPD) ]
    %ENL has 6PD because it consists of coordinates, boundary condition,
    %temp degree, global degree, displacements, and force
    
    %each PD is for each dimension (e.g. x and y coordinates)

% DOFs : Degrees of Freedom
% DOCs : Degrees of Constraint

% Up : Prescribed Displacements [ DOCs X 1 ]
% U : Unknown Displacements [ DOFs X 1 ]

% K_reduced : Reduced Stiffness [ DOFs X DOFs ]
% Fp : Prescribed Forces [ DOFs X 1 ]
% F : Right-hand Sided [ DOFs X 1 ]

% mag : Magnification Factor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%   PRE-PROCESS.   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format long

%Node list consists of x and y coordinates
    %NL=[0 0; 1 0; 2 0; 0 1; 1 1];
NL = [0 0; 1 0; 0 1; 1 1];

%Element list
    %Look at which nodes the element is connected to
    % Node 2 ====[1]===== Node 3 ======[2]===== Node 1
    % In the above case, we have EL = [2 3; 3 1];
    % Another example: EL=[1 5; 2 5; 2 3; 3 5; 4 5; 1 2];
EL = [1 3; 2 3; 2 4; 3 4];

A=1;  % Cross section area of each element

E=10; % Young's modulus of each element

%Notes
    % L can be derived from the coordinates of the elements

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   PROCESS.   %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This line assigns the boundary conditions
[ENL,DOFs,DOCs] = assign_BCs(NL);

K = assemble_stiffness(ENL,EL,NL,E,A);

Fp = assemble_forces(ENL, NL);

Up = assemble_displacements(ENL, NL);

K_reduced = K(1:DOFs,1:DOFs);

K_test = K(1:DOFs,DOFs+1:(DOFs+DOCs));

F = Fp - K(1:DOFs,DOFs+1:(DOFs+DOCs)) * Up;

U = K_reduced \ F;

Fu = K(DOFs+1:DOFs+DOCs,1:DOFs) * U + K(DOFs+1:(DOFs+DOCs),DOFs+1:(DOFs+DOCs)) * Up;

ENL = update_nodes(ENL,U,NL,Fu);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   POST-PROCESS.   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To be completed by the student