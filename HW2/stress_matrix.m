%This function is to calculate the stress in each member and spit out a
%stress matrix

function stress = stress_matrix(NL, EL, ENL, E, U_final)


%Calculate angle of element

    for i = 1:size(EL, 1)
        for j = 1:size(EL, 2)
            %Calculate x2 - x1
            disp(i, 1) = ENL(EL(i, 2), 1) - ENL(EL(i, 1), 1);
            %Calculate y2 - y1
            disp(i, 2) = ENL(EL(i, 2), 2) - ENL(EL(i, 1), 2);
        end
    end
    
    for i = 1:size(disp, 1)
        if(disp(i, 1) == 0 && disp(i, 2) > 0)
            angle(i) = 90;
        elseif(disp(i, 2) == 0 && disp(i, 1) > 0)
            angle(i) = 0;
        else
            angle(i) = atan(disp(i, 2) / disp(i, 1)) * 180/pi;
        end
    end
    
    %loop over angle check for obtuse angles
    for i = 1:size(angle, 1)
        if(angle(i) < 0)
            angle(i) = 180 - angle(i);
        end
    end
    

%Obtain length of element
    length = sqrt( (disp(:, 1)).^2 + (disp(:, 2)).^2);

%Calculate stress of element
for i = 1:size(EL, 1) %for each element
    angle_matrix = [-cos(angle(i)*pi/180), -sin(angle(i)*pi/180), cos(angle(i)*pi/180), sin(angle(i)*pi/180)];
    disp_temp = U_final - NL;
    %x1, y1, x2, y2
    disp_matrix = [disp_temp(EL(i, 1), 1); disp_temp(EL(i, 1), 2); disp_temp(EL(i, 2), 1); disp_temp(EL(i, 2), 2)];
    stress(i) = (E/length(i)) * angle_matrix * disp_matrix;
end
end

