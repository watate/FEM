function M = plotMatrix(NL, EL)

NL = [0 0; 40 0; 40 30; 0 30];

EL = [1 2; 2 3; 1 3; 4 3];

k = 1;
for i = 1:size(EL,1) %loops over each EL row (corresponds to M row)
    k = 1; %initialize k so we start a new column
    for j = 1:size(EL,2)
        %this j-loop is to loop over/go through the EL columns
        for l = 1:size(NL,2)
            %this l-loop is to loop over the NL columns while in the same
            %EL-node
            
            M(i, k) = NL(EL(i,j), l); %EL(i,j) is node number
         
            
            k = k + 1;
        end
    end
end