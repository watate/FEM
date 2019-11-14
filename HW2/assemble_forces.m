%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   In this function we update the ENL matrix based on the prescribed forces.  %%%%%
%%%%   The columns number 11 and 12 correspond to the x- and y-component of the   %%%%%
%%%%   force vectors at each node, respectively.                                  %%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Fp ] = assemble_forces( ENL , NL )

NoN = size(NL,1);
DOCs = 0;
DOFs = 0;
PD = size(NL,2);


%here he attempts to create the reduced versions of the force and
    %displacement matrices
%basically, only include the prescribed forces and displacements in the
%matrix/vector
for i= 1:NoN
    for j= 1:PD
        if (ENL(i, j + PD) == 1)
            DOFs = DOFs + 1;
            Fp(DOFs, 1) = ENL(i, 5*PD + j);
            
        end
    end
end


for i= 1:NoN
    for j= 1:PD
        if (ENL(i, j + PD) == -1)
            DOCs = DOCs + 1;
            Up(DOCs, 1) = ENL(i, 4*PD + j);
            
        end
    end
end




end