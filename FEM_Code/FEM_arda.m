clc;
clear all;
close all;

setGlobalV(V)
setGlobalgpe(GPE)
setGlobalE(E)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%   PRE-PROCESS.   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d1 = 1;    % horizontal dimension of the domain
d2 = 1;    % vertical dimension of the domain
p  = 5;    % number of partitions in the horizontal and vertical directions
m  = 5;    % number of partitions in the diagonal direction
R  = 0.2;  % Radius of the void
[NL , EL] = mesh_2(d1,d2,p,m,R);  % D2QU4N mesh generator
%[NL ,EL] = mesh_6(d1,d2,p,m,R);  % D2TR3N mesh generator
% 
% q = [0.5-d1/2 0.5-d2/2; 0.5+d1/2 0.5-d2/2; 0.5-d1/2 0.5+d2/2; 0.5+d1/2 0.5+d2/2];
% a = (q(2,1) - q(1,1))/p;
% b = (q(3,2) - q(1,2))/p;

%[NL2, EL2] = mesh_2_fill(d1, d2,p,m,R);

% 
% NL = [(NL); (NL2)];
% EL = [(EL); (EL2)];

BC_flag = 'Shear'; %Horizontal  Diagonal  Vertical

[ENL,DOFs,DOCs] = assign_BCs_arda(NL,BC_flag);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   PROCESS.   %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E = 8/3;
nu = 1/3;

K = assemble_stiffness_new(ENL,EL,NL,E,nu,E,nu);

Fp = assemble_forces(ENL,NL);

Up = assemble_displacements(ENL,NL);

K_reduced = K(1:DOFs,1:DOFs);

F = Fp - K(1:DOFs,DOFs+1:(DOFs+DOCs)) * Up;

U = K_reduced \ F;

ENL = update_nodes(ENL,U,NL);

Fu = K(DOFs+1:DOFs+DOCs,1:DOFs) * U + K(DOFs+1:(DOFs+DOCs),DOFs+1:(DOFs+DOCs)) * Up;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   POST-PROCESS.   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
post_process_arda(NL,EL,ENL,'xx'); % sig_AA , eps_AA , disp_A
%post_process2(NL,EL,ENL);
