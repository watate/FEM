%this function returns the result of our optimization criteria

function op_criteria = check_criteria(weight, U)

%initialize op_criteria
op_criteria = 0;

%calculate
for i = 1:size(U, 1)
    op_criteria = op_criteria + weight * abs(U(i));
end
