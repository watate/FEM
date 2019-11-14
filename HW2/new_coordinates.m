%This function recalculates the structure's coordinates based on the
%displacements obtained.

function U_final = new_coordinates(ENL, U, NL)

d = -1; %dirichlet
n = 1; %neumann

%initialize U_final
U_final = NL;

k = 1;
for i = 1:size(ENL, 1)
    for j = 1:size(NL, 2)
        %if we encounter neumann BC, add displacement
        if(ENL(i,j + 2) == n) %(j+2) because BC starts at col 3
            U_final(i, j) = U_final(i, j) + U(k);
            k = k + 1;
        end
        
    end
end
