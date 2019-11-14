NL = [0 0; 40 0; 40 30; 0 30];

columns = size(NL, 2);

k = 1;
for i = 1:size(NL,1)
    for j = 1:size(NL,2)
        M(1, k) = NL(i, j);
        k = k + 1;
    end
end