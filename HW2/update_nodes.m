%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   In this function we update the ENL matrix based on the solution of      %%%%
%%%%   our problem. The unknown displacement and forces that have been sought  %%%%  
%%%%   are put in the correct position.                                        %%%%       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ENL ] = update_nodes( ENL , U, NL , Fu )

NoN = size(NL, 1);
DOFs = 0;
DOCs = 0;
PD = size(NL, 2);

for i = 1:NoN
    for j = 1:PD
        if(ENL(i,j + PD) == 1)
            DOFs = DOFs + 1;
            ENL(i, j+4*PD) = U(DOFs);
        end
    end
end
for i = 1:NoN
    for j = 1: PD
        if(ENL(i, j+PD) == -1)
            DOCs = DOCs + 1;
            ENL(i,j+ 5*PD) = Fu(DOCs);
        end
    end
end



end