%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   In this function we assign the boundary conditions required in the problem    %%%%%
%%%%   and we construct the ENL matrix based on the boundary conditions.             %%%%%
%%%%   Additionally we determine the degrees of freedom and degrees of constratint.  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ENL , DOFs , DOCs ] = assign_BCs( NL)

% size(NL,1) means its counting the rows
    % size(NL, 2) would mean counting columns
NoN = size(NL, 1);
PD = size(NL, 2);

%initialize the ENL array with zeros
    %note that ENL looks like:
    % |Coord|BC|TempDeg|GlobalDeg|Disp|Forces|
    % |1,2| 3,4| 5 , 6 | 7 ,  8  |9,10|11,12|
ENL = zeros(NoN, 6*PD);

%Column 1 and 2 of ENL gets the node list (which contains the coordinates)
ENL(:,1:2) = NL;

%Here we fill in the boundary conditions
    %For each if statement, we have a node (with coor in the if statements)
    %We also assign boundary conditions and their values
    % -1 = Dirichlet (values 9,10), 1 = Neumann (values 11,12)
    
%to make things simpler lets define Dirichlet and Neumann
d = -1; n = 1; F = 10^3; L = 2;

for i = 1:NoN %not sure why we have for loop but he says its important
    %Example
    %if(ENL(i,1) == 0 && ENL(i,2) == 0)
        %ENL(i,3) = 1;
        %ENL(i,4) = -1;
        %ENL(i,10) = 0;
        %ENL(i,11) = 5;
    
    %follow up with elseif statements and an else statement
    if(ENL(i, 1) == 1 && ENL(i,2) == tan(60*pi/180))
        ENL(i,3) = n;
        ENL(i,4) = n;
        ENL(i, 9) = 0;
        ENL(i, 10) = 0;
        ENL(i, 11) = 0;
        ENL(i, 12) = 0;
        
    elseif(ENL(i,1) == L*2 && ENL(i,2) == L*tan(45*pi/180))
        ENL(i,3) = n;
        ENL(i,4) = n;
        ENL(i, 9) = 0;
        ENL(i, 10) = 0;
        ENL(i, 11) = F;
        ENL(i, 12) = 0;
        
    elseif(ENL(i,1) == 0 && ENL(i,2) == 0)
        ENL(i,3) = d;
        ENL(i,4) = d;
        ENL(i, 9) = 0;
        ENL(i, 10) = 0;
        ENL(i, 11) = 0;
        ENL(i, 12) = 0;
        
    elseif(ENL(i,1) == L && ENL(i,2) == 0)
        ENL(i,3) = d;
        ENL(i,4) = d;
        ENL(i, 9) = 0;
        ENL(i, 10) = 0;
        ENL(i, 11) = 0;
        ENL(i, 12) = 0;
        
    elseif(ENL(i,1) == 2*L && ENL(i,2) == 0)
        ENL(i,3) = d;
        ENL(i,4) = d;
        ENL(i, 9) = 0;
        ENL(i, 10) = 0;
        ENL(i, 11) = 0;
        ENL(i, 12) = 0;
    
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
DOCs = abs(DOCs);

%this loop goes over the temp degrees, and converts them into positive and 
    %adds the DOFs (to complete Degree Assignment process)
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