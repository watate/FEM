%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   In this function we assign the boundary conditions required in the problem    %%%%%
%%%%   and we construct the ENL matrix based on the boundary conditions.             %%%%%
%%%%   Additionally we determine the degrees of freedom and degrees of constratint.  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ENL , DOFs , DOCs ] = assign_BCs( NL)

% size(NL,1) means its counting the rows
    % size(NL, 2) would mean counting columns
NoN = size(NL,1);
PD = size(NL, 2);

ENL = zeros(NoN, 6*PD);

% ENL all of the rows, first and second column equals the node list
ENL(:,1:2) = NL;

for i = 1:NoN
    if(ENL(i,1) == 0 && ENL(i,2) == 0)
        ENL(i,3) = 1;
        ENL(i,4) = -1;
        ENL(i,10) = 0;
        ENL(i,11) = 0;
        
    elseif(ENL(i,1) == 1 && ENL(i,2) == 0)
        ENL(i,3) = -1;
        ENL(i,4) = -1;
        ENL(i,9) = 0;
        ENL(i,10) = 0;
        
    elseif(ENL(i,1) == 0 && ENL(i,2) == 1)
        ENL(i,3) = 1;
        ENL(i,4) = 1;
        ENL(i,11) = 0;
        ENL(i,12) = -10;
        
    elseif(ENL(i,1) == 1 && ENL(i,2) == 1)
        ENL(i,3) = 1;
        ENL(i,4) = 1;
        ENL(i,11) = 0;
        ENL(i,12) = 5;
    
    else
        ENL(i,3) = 1;
        ENL(i,4) = 1;
        ENL(i,11) = 0;
        ENL(i,12) = 0;

    end
end

DOFs = 0;
DOCs = 0;

for i = 1:NoN
    
    %this loop goes over each boundary condition and assigns a temporary
    %degree to each entry in the ENL array
    for j = 1:PD
        if ENL(i, PD+j) == -1
            DOCs = DOCs - 1;
            ENL(i,2*PD + j) = DOCs;
            
        else
            DOFs = DOFs + 1;
            ENL(i, 2*PD + j) = DOFs;
        end
    end
end

%he does this here because he only wants to deal with the positive value of
%degree of freedoms (which he later passes into the function output)
DOFs = abs(DOFs);

for i = 1:NoN
    for j = 1:PD
        if ENL(i, j + 2*PD) < 0
            ENL(i, j +3*PD) = abs(ENL(i, j + 2*PD)) + DOFs;
        else
            ENL(i, j + 3*PD) = ENL(i, j + 2*PD);
        end
    end
end

    
    
        


end