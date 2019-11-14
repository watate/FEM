%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   In this function we update the ENL matrix based on the prescribed displacements.  %%%%%
%%%%   The columns number 9 and 10 correspond to the x- and y-component of the           %%%%%
%%%%   displacement at each node, respectively.                                          %%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [ Up ] = assemble_displacements( ENL , NL )

NoN = size(NL,1);
DOCs = 0;
PD = size(NL,2);



for i= 1:NoN
    for j= 1:PD
        if (ENL(i, j + PD) == -1)
            DOCs = DOCs + 1;
            Up(DOCs, 1) = ENL(i, 4*PD + j);
            
        end
    end
end


end