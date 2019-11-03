%This is for our circle

function [NL , EL] = mesh_3_fill(a,b,p,m, R)

NL = [1.5 1.5];
NL2 = [];
SEL = [0 0 0 0];
EL2 = [];

node_array = [1.5 1.5 1];
node_array(1,:) = [];
node_array2 = [];

theta_step = 90/p;
node_count = 0;
node_count2 = 0;
d1 = 1;
d2 = 1;

for theta = 45 : theta_step : 45+(360-theta_step)
    
    if theta >= 45 && theta <= 135
        r_final = (d2/2)/sind(theta);
    end
    if theta > 135 && theta < 225
        r_final = -(d1/2)/cosd(theta);
    end
    if theta >= 225 && theta <= 315
        r_final = -(d2/2)/sind(theta);
    end
    if theta > 315 && theta < 405
        r_final = (d1/2)/cosd(theta);
    end
    
    if theta >= 45 && theta <= 135
        r_i = (0.3*R)/sind(theta);
    end
    if theta > 135 && theta < 225
        r_i = -(0.3*R)/cosd(theta);
    end
    if theta >= 225 && theta <= 315
        r_i = -(0.3*R)/sind(theta);
    end
    if theta > 315 && theta < 405
        r_i = (0.3*R)/cosd(theta);
    end
    
        
    for r = R : ((r_final - R)/(m)) : r_final
        
        %node = [r*cosd(theta) r*sind(theta)];
        NL = [NL ; [r*cosd(theta) r*sind(theta)]];
        node_count = node_count + 1;
        node_a = [node_count [r*cosd(theta) r*sind(theta)]];
        node_array = [node_array ; node_a];
    
    end
    
    for r = r_i : ((R - r_i)/(m)) : R-((R - r_i)/(m))
        
        %node = [r*cosd(theta) r*sind(theta)];
        NL2 = [NL2 ; [r*cosd(theta) r*sind(theta)]];
        node_count2 = node_count2 + 1;
        node_a = [node_count2 [r*cosd(theta) r*sind(theta)]];
        node_array2 = [node_array2 ; node_a];
    
    end
        
end


NL(1,:) = [];
SEL(1,:) = [];

NL3 = [];
X_pos = [];
Y_pos = [];
naap = size(NL,1);
NL = [NL ; NL2];


for i = naap+m+1:m:(naap+m+1)+(m)*(p-2)  %m+2:m+2:
    %i
    X_pos = [X_pos ; NL(i)];
    
end

Y_pos = X_pos;
% Y_pos
% X_pos

for i = 1 : size(Y_pos)
    for j = 1 : size(X_pos)
        NL3 = [NL3 ; [X_pos(j) Y_pos(i)]];  
    end
end


NL = [NL ; NL3];
%%%%%%%%%%%%%%%%%%% EL %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
node_array = [node_array ; node_array2];

so = zeros(size(node_array,1) , 1);
node_array = [node_array so];

for i = 1:size(node_array,1)
    node_array(i,4) = rem(node_array(i,1) , m+1);   
end

num_of_elements = 4*p*m;
n_c = 0;

for e = 1 : num_of_elements - m
    
    n_c = n_c + 1;
    
    if node_array(n_c , 4) == 0
        n_c = n_c + 1;
    end
    el_1 = n_c    ;
    el_2 = n_c + 1;
    el_3 = n_c + (m+2);
    el_4 = n_c + (m+1);
    
    %element = [el_1 el_2 el_3 el_4];
    SEL = [SEL ; [el_1 el_2 el_3 el_4]];
    
end

n_c = n_c + 1;

for i = 1:m
    
    n_c = n_c + 1;
    
    el_1 = n_c    ;
    el_2 = n_c + 1;
    el_3 = i + 1;
    el_4 = i    ;
    
    %element = [el_1 el_2 el_3 el_4];
    SEL = [SEL ; [el_1 el_2 el_3 el_4]];
    
end








%%%%%%%%%%% for EL2 %%%%%%%%%%%%%%%%%%%%%

num_of_elements = 4*p*m;
n_c2 = 0;
count = 1;
first = n_c + 2;
n_c = n_c + 1;
for e = 1 : num_of_elements - m
    n_c2 = n_c2 + 1;
    n_c = n_c + 1;
%     if n_c > 112
%         n_c = 110
%     end
    if n_c2 == m
        el_1 = n_c    ;
        el_2 = count;
        el_3 = count + (m+1);
        el_4 = n_c + (m);
        EL2 = [EL2 ; [el_1 el_2 el_3 el_4]];
        
        n_c2 = 0;
        count = count + (m+1);
        continue
    end
        
      
    el_1 = n_c    ;
    el_2 = n_c + 1;
    el_3 = n_c + (m+1);
    el_4 = n_c + (m);
    
    %element = [el_1 el_2 el_3 el_4];
    EL2 = [EL2 ; [el_1 el_2 el_3 el_4]];
    
end


for i = first:(first+m-2)
    
    n_c = n_c + 1;
    
    el_1 = n_c    ;
    el_2 = n_c + 1;
    el_3 = i + 1;
    el_4 = i    ;
    
    %element = [el_1 el_2 el_3 el_4];
    EL2 = [EL2 ; [el_1 el_2 el_3 el_4]];
    
end

n_c = n_c + 1;

el_1 = n_c    ;
el_2 = first - (m+1);
el_3 = 1;
el_4 = first + m - 1;
EL2 = [EL2 ; [el_1 el_2 el_3 el_4]];




%%%%%%%%%%% for EL3 %%%%%%%%%%%%%%%%%%%%%
EL3 = [];
count = 0;
n_cc = n_c;
for i = 1 : (p-2)*(p-2)+(p-2-1)
        count = count + 1;
        
        if count == p-1 
            n_c = n_c + 1;
            count = 0;
            %i = i-1;
            continue
        end
        n_c = n_c + 1;
        
        el_1 = n_c    ;
        el_2 = n_c + 1;
        el_3 = n_c + p;
        el_4 = n_c + p - 1;
        EL3 = [EL3 ; [el_1 el_2 el_3 el_4]];
        
    
end




%%%%%%%%%%% for EL4 %%%%%%%%%%%%%%%%%%%%%
EL4 = [];
n_c = n_cc ;
for i = 1 : (p-2)
                
        n_c = n_c + 1;
        
        el_1 = n_c    ;
        el_2 = (first) + (i*m);
        el_3 = el_2 + m ;
        el_4 = n_c + 1;
        EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];
        
    
end


for i = 1 : p-2
                
        n_c = n_cc + (p-2)*(p-1);
        
        el_1 = first + (2*p+i) * m ;
        el_2 = el_1 + m;
        el_3 = size(NL,1)-i;
        el_4 = el_3 + 1;
        EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];
        
    
end

n_c = n_cc + (p-1);
%n_c = n_c - 1;
for i = 1 : p-2
                
        el_1 = n_c  ;
        el_2 = first + (p+i) * m ;
        el_3 = el_2 + m;
        el_4 = el_1 + (p-1);
        EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];
        
        n_c = n_c + (p-1);
    
end

n_c = n_cc + 1;
%n_c = n_c - 1;
for i = 1 : p-2
                
        el_1 = n_c ;
        el_2 = n_c + (p-1);
        el_4 = first + (4*p-i) * m;
        el_3 = el_4 - m;
        
        EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];
        
        n_c = n_c + (p-1);
    
end

el_1 = n_cc + 1;
el_2 = first + (4*p-1) * m;
el_3 = first ;
el_4 = el_3 + m;

EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];


el_1 = n_cc + 1 + (p-2) ;
el_2 = first + (p-1) * m;
el_3 = el_2 + m ;
el_4 = el_3 + m;

EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];


el_1 = size(NL,1) ;
el_2 = first + (2*p-1) * m;
el_3 = el_2 + m ;
el_4 = el_3 + m;

EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];


el_1 = size(NL,1) - (p-2) ;
el_2 = first + (3*p-1) * m;
el_3 = el_2 + m ;
el_4 = el_3 + m;

EL4 = [EL4 ; [el_1 el_2 el_3 el_4]];




NL(:,1) = a*NL(:,1);
NL(:,2) = b*NL(:,2);
% 
NL(:,1) = NL(:,1)+ 1/2;
NL(:,2) = NL(:,2)+ 1/2;
% 
% NL2(:,1) = a*NL2(:,1);
% NL2(:,2) = b*NL2(:,2);
% 
% NL2(:,1) = NL2(:,1)+ a/2;
% NL2(:,2) = NL2(:,2)+ b/2;
% 
% NL3(:,1) = a*NL3(:,1);
% NL3(:,2) = b*NL3(:,2);
% 
% NL3(:,1) = NL3(:,1)+ a/2;
% NL3(:,2) = NL3(:,2)+ b/2;

SEL = [SEL ; EL2 ; EL3 ; EL4];
EL = [];
for i = 1:size(SEL,1)
    
    EL = [EL ; [SEL(i,1) SEL(i,2) SEL(i,4)]];
    EL = [EL ; [SEL(i,2) SEL(i,3) SEL(i,4)]];
      
end

setGlobalFirst(first);
    
end



function setGlobalFirst(val)
    global First
    First = val;
    
end