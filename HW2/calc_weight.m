%this function calculates the weight of the structure

function weight = calc_weight(EL, ENL, density, A)

%initialize weight to 0
weight = 0;

%Get x and y components of length
for i = 1:size(EL, 1)
        for j = 1:size(EL, 2)
            %Calculate x2 - x1
            disp(i, 1) = ENL(EL(i, 2), 1) - ENL(EL(i, 1), 1);
            %Calculate y2 - y1
            disp(i, 2) = ENL(EL(i, 2), 2) - ENL(EL(i, 1), 2);
        end
end

%Obtain length of each element
length = sqrt( (disp(:, 1)).^2 + (disp(:, 2)).^2);

for i = 1:size(length, 1)
    weight = weight + length(i) * A * density;
end


end