function [X_1, Y_1, stress_xx, stress_xy, stress_yx,stress_yy...
    ,strain_xx,strain_xy,strain_yx,strain_yy, disp_x,disp_y ] = post_process(NL,EL,ENL,scale)


GPE = getGlobalgpe;

PD = 2;
NPE = size(EL, 2);
NoN = size(ENL, 1);
NoE = size(EL, 1);

[disp, stress, strain] = element_pp(NL, EL, ENL);
X_1 = [];
Y_1 = [];
switch NPE
    case 3
        %to be done by us
        for i = 1:NoE
            %nl = EL(i, 1, NPE);
            nl = EL(i, 1:NPE);
            
            for j = 1:NPE
                X_1(j, i) = ENL(nl(j), 1) + scale*ENL(nl(j), 4*PD+1);
                Y_1(j, i) = ENL(nl(j), 2) + scale*ENL(nl(j), 4*PD+2);
            end
            
            for j = 1:NPE
                val = stress(i, :, 1, 1); %for stress
                val = [val, val, val];
                stress_xx(j,i) = val(1, j);
                
%                 vald = disp(i,:,1,1); %for displacement
%                 disp_xx(j,i) = vald(1,j);
                
                valn = strain(i,:,1,1); %for strain
                valn = [valn, valn, valn];
                strain_xx(j,i) = valn(1,j);
                %strain_xx = [strain_xx; strain_xx; strain_xx];
                
            end
            
            for j = 1:NPE
                val = stress(i, :, 1, 2);
                val = [val, val, val];
                stress_xy(j,i) = val(1, j);
                
%                 vald = disp(i,:,1,2);
%                 disp_xy(j,i) = vald(1,j);
                
                valn = strain(i,:,1,2);
                valn = [valn, valn, valn];
                strain_xy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 1);
                val = [val, val, val];
                stress_yx(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,1);
%                 disp_yx(j,i) = vald(1,j);
                
                valn = strain(i,:,2,1);
                valn = [valn, valn, valn];
                strain_yx(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 2);
                val = [val, val, val];
                stress_yy(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,2);
%                 disp_yy(j,i) = vald(1,j);
                
                valn = strain(i,:,2,2);
                valn = [valn, valn, valn];
                strain_yy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                disp_y(j, i) = abs(ENL(nl(j), 4*PD + 2));
                disp_x(j, i) = abs(ENL(nl(j), 4*PD + 1));
            end
            
        end
%     case 9
%         for i = 1:NoE
%             %nl = EL(i, 1, NPE);
%             nl = EL(i, 1:NPE);
%             
%             Ele = EL(i,1:NPE); %identify all the nodes connected to that element
%            
%             nl(1) = Ele(1);
%             nl(2) = Ele(5);
%             nl(3) = Ele(2);
%             nl(4) = Ele(6);
%             nl(5) = Ele(3);
%             nl(6) = Ele(7);
%             nl(7) = Ele(4);
%             nl(8) = Ele(8);
%             
%             for j = 1:NPE-1
%                 X_1(j, i) = ENL(nl(j), 1) + scale*ENL(nl(j), 4*PD+1);
%                 Y_1(j, i) = ENL(nl(j), 2) + scale*ENL(nl(j), 4*PD+2);
%             end
% %             for j=1:NPE  %getting the coordinates of each node
% %                 x_1(j,i) = ENL(nl(j),1);
% %                 y_1(j,i) = ENL(nl(j),2);
% %             end
% %             
% %             X_1_int = [x_1(1) x_1(5) x_1(8) x_1(9); 
% %                         x_1(5) x_1(2) x_1(9) x_1(6);
% %                         x_1(9) x_1(6) x_1(7) x_1(3);
% %                         x_1(8) x_1(9) x_1(4) x_1(7)];
% %             X_1 = [X_1 X_1_int];
% %             Y_1_int = [y_1(1) y_1(5) y_1(8) y_1(9); 
% %                         y_1(5) y_1(2) y_1(9) y_1(6);
% %                         y_1(9) y_1(6) y_1(7) y_1(3);
% %                         y_1(8) y_1(9) y_1(4) y_1(7)];
% %             Y_1 = [Y_1 Y_1_int];
% 
%             
%             
%             for j = 1:NPE-1
%                 val = stress(i, :, 1, 1); %for stress
%                 stress_xx(j,i) = val(1, j);
%                 
% %                 vald = disp(i,:,1,1); %for displacement
% %                 disp_xx(j,i) = vald(1,j);
%                 
%                 valn = strain(i,:,1,1); %for strain
%                 strain_xx(j,i) = valn(1,j);
%                 
%             end
%             
%             for j = 1:NPE-1
%                 val = stress(i, :, 1, 2);
%                 stress_xy(j,i) = val(1, j);
%                 
% %                 vald = disp(i,:,1,2);
% %                 disp_xy(j,i) = vald(1,j);
%                 
%                 valn = strain(i,:,1,2);
%                 strain_xy(j,i) = valn(1,j);
%             end
%             
%             for j = 1:NPE-1
%                 val = stress(i, :, 2, 1);
%                 stress_yx(j,i) = val(1, j);
%                 
% %                 vald = disp(i,:,2,1);
% %                 disp_yx(j,i) = vald(1,j);
%                 
%                 valn = strain(i,:,2,1);
%                 strain_yx(j,i) = valn(1,j);
%             end
%             
%             for j = 1:NPE-1
%                 val = stress(i, :, 2, 2);
%                 stress_yy(j,i) = val(1, j);
%                 
% %                 vald = disp(i,:,2,2);
% %                 disp_yy(j,i) = vald(1,j);
%                 
%                 valn = strain(i,:,2,2);
%                 strain_yy(j,i) = valn(1,j);
%             end
%             
%             for j = 1:NPE-1
%                 disp_y(j, i) = abs(ENL(nl(j), 4*PD + 2));
%                 disp_x(j, i) = abs(ENL(nl(j), 4*PD + 1));
%             end
%             
%         end
%         

    case 9
         for i = 1:NoE
            nl = EL(i,1:NPE);  
            for j=1:9  %getting the coordinates of each node);
                X_1(j, i) = ENL(nl(j), 1) + scale*ENL(nl(j), 4*PD+1);
                Y_1(j, i) = ENL(nl(j), 2) + scale*ENL(nl(j), 4*PD+2);
%                 Y_1(j, i) = ENL(nl(j), 2);
%                 X_1(j, i) = ENL(nl(j), 1);
                
            end
            for j = 1:9
                val = stress(i, :, 1, 1);
                stress_xx(j,i) = val(1, j);
            end
            for j = 1:9
                val = stress(i, :, 1, 2);
                stress_xy(j,i) = val(1, j);
            end
            for j = 1:9
                val = stress(i, :, 2, 1);
                stress_yx(j,i) = val(1, j);
            end
            for j = 1:9
                val = stress(i, :, 2, 2);
                stress_yy(j,i) = val(1, j);
            end
            
            for j = 1:NPE
                disp_y(j, i) = abs(ENL(nl(j), 4*PD + 2));
            end  
            for j = 1:NPE
                disp_x(j, i) = abs(ENL(nl(j), 4*PD + 1));
            end
            
            for j = 1:9
                val = strain(i, :, 1, 1);
                strain_xx(j,i) = val(1, j);
            end
            for j = 1:9
                val = strain(i, :, 1, 2);
                strain_xy(j,i) = val(1, j);
            end
            for j = 1:9
                val = strain(i, :, 2, 1);
                strain_yx(j,i) = val(1, j);
            end
            for j = 1:9
                val = strain(i, :, 2, 2);
                strain_yy(j,i) = val(1, j);
            end
         end
        cc=1;
        for i = 1:size(X_1,2)
             r0 = X_1(:,i);
             r0 = [r0(1) r0(5) r0(6) r0(7); r0(5) r0(2) r0(3) r0(4); r0(9) r0(6) r0(7) r0(8); r0(8) r0(9) r0(9) r0(9)];
             X_1new(:,cc:cc+3) = r0;
             
             r0 = Y_1(:,i);
             r0 = [r0(1) r0(5) r0(6) r0(7); r0(5) r0(2) r0(3) r0(4); r0(9) r0(6) r0(7) r0(8); r0(8) r0(9) r0(9) r0(9)];
             Y_1new(:,cc:cc+3) = r0;
             
             r = stress_xx(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             stress_xxnew(:,cc:cc+3) = r;
             
             r = stress_xy(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             stress_xynew(:,cc:cc+3) = r;
             
             r = stress_yx(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             stress_yxnew(:,cc:cc+3) = r;
             
             r = stress_yy(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             stress_yynew(:,cc:cc+3) = r;
             
             r = strain_xx(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             strain_xxnew(:,cc:cc+3) = r;
             
             r = strain_xy(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             strain_xynew(:,cc:cc+3) = r;
             
             r = strain_yx(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             strain_yxnew(:,cc:cc+3) = r;
             
             r = strain_yy(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             strain_yynew(:,cc:cc+3) = r;
             
             r = disp_x(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             disp_xnew(:,cc:cc+3) = r;
             
             r = disp_y(:,i);
             r = [r(1) r(5) r(6) r(7); r(5) r(2) r(3) r(4); r(9) r(6) r(7) r(8); r(8) r(9) r(9) r(9)];
             disp_ynew(:,cc:cc+3) = r;
             cc=cc+4;
        end
             X_1=X_1new;
             Y_1=Y_1new;
             stress_xx=stress_xxnew;
             stress_xy=stress_xynew;
             stress_yx=stress_yxnew;
             stress_yy=stress_yynew;
             strain_xx=strain_xxnew;
             strain_xy=strain_xynew;
             strain_yx=strain_yxnew;
             strain_yy=strain_yynew;
             disp_x=disp_xnew;
             disp_y=disp_ynew;

    case 4 
            for i = 1:NoE
            %nl = EL(i, 1, NPE);
            nl = EL(i, 1:NPE);
            
            for j = 1:NPE
                X_1(j, i) = ENL(nl(j), 1) + scale*ENL(nl(j), 4*PD+1);
                Y_1(j, i) = ENL(nl(j), 2) + scale*ENL(nl(j), 4*PD+2);
            end
            
            for j = 1:NPE
                val = stress(i, :, 1, 1); %for stress
                stress_xx(j,i) = val(1, j);
                
%                 vald = disp(i,:,1,1); %for displacement
%                 disp_xx(j,i) = vald(1,j);
                
                valn = strain(i,:,1,1); %for strain
                strain_xx(j,i) = valn(1,j);
                
            end
            
            for j = 1:NPE
                val = stress(i, :, 1, 2);
                stress_xy(j,i) = val(1, j);
                
%                 vald = disp(i,:,1,2);
%                 disp_xy(j,i) = vald(1,j);
                
                valn = strain(i,:,1,2);
                strain_xy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 1);
                stress_yx(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,1);
%                 disp_yx(j,i) = vald(1,j);
                
                valn = strain(i,:,2,1);
                strain_yx(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 2);
                stress_yy(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,2);
%                 disp_yy(j,i) = vald(1,j);
                
                valn = strain(i,:,2,2);
                strain_yy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                disp_y(j, i) = abs(ENL(nl(j), 4*PD + 2));
                disp_x(j, i) = abs(ENL(nl(j), 4*PD + 1));
            end
            
            end
    case 8
        for i = 1:NoE
            %nl = EL(i, 1, NPE);
            nl = EL(i, 1:NPE);
            
            Ele = EL(i,1:NPE); %identify all the nodes connected to that element
           
            nl(1) = Ele(1);
            nl(2) = Ele(5);
            nl(3) = Ele(2);
            nl(4) = Ele(6);
            nl(5) = Ele(3);
            nl(6) = Ele(7);
            nl(7) = Ele(4);
            nl(8) = Ele(8);
            
            for j = 1:NPE
                X_1(j, i) = ENL(nl(j), 1) + scale*ENL(nl(j), 4*PD+1);
                Y_1(j, i) = ENL(nl(j), 2) + scale*ENL(nl(j), 4*PD+2);
            end
%             for j=1:NPE  %getting the coordinates of each node
%                 x_1(j,i) = ENL(nl(j),1);
%                 y_1(j,i) = ENL(nl(j),2);
%             end
%             
%             X_1_int = [x_1(1) x_1(5) x_1(8) x_1(9); 
%                         x_1(5) x_1(2) x_1(9) x_1(6);
%                         x_1(9) x_1(6) x_1(7) x_1(3);
%                         x_1(8) x_1(9) x_1(4) x_1(7)];
%             X_1 = [X_1 X_1_int];
%             Y_1_int = [y_1(1) y_1(5) y_1(8) y_1(9); 
%                         y_1(5) y_1(2) y_1(9) y_1(6);
%                         y_1(9) y_1(6) y_1(7) y_1(3);
%                         y_1(8) y_1(9) y_1(4) y_1(7)];
%             Y_1 = [Y_1 Y_1_int];

            
            
            for j = 1:NPE
                val = stress(i,:,1,1); %for stress
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(4))/2 val(4) (val(4)+val(1))/2];
                stress_xx(j,i) = val(1,j);
                
%                 vald = disp(i,:,1,1); %for displacement
%                 disp_xx(j,i) = vald(1,j);
                
                valn = strain(i,:,1,1); %for strain
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(4))/2 valn(4) (valn(4)+valn(1))/2];
                strain_xx(j,i) = valn(1,j);
                
            end
            
            for j = 1:NPE
                val = stress(i, :, 1, 2);
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(4))/2 val(4) (val(4)+val(1))/2];
                stress_xy(j,i) = val(1, j);
                
%                 vald = disp(i,:,1,2);
%                 disp_xy(j,i) = vald(1,j);
                
                valn = strain(i,:,1,2);
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(4))/2 valn(4) (valn(4)+valn(1))/2];
                strain_xy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 1);
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(4))/2 val(4) (val(4)+val(1))/2];
                stress_yx(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,1);
%                 disp_yx(j,i) = vald(1,j);
                
                valn = strain(i,:,2,1);
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(4))/2 valn(4) (valn(4)+valn(1))/2];
                strain_yx(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 2);
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(4))/2 val(4) (val(4)+val(1))/2];
                stress_yy(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,2);
%                 disp_yy(j,i) = vald(1,j);
                
                valn = strain(i,:,2,2);
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(4))/2 valn(4) (valn(4)+valn(1))/2];
                strain_yy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                disp_y(j, i) = abs(ENL(nl(j), 4*PD + 2));
                disp_x(j, i) = abs(ENL(nl(j), 4*PD + 1));
            end
            
        end
        
    case 6
        for i = 1:NoE
            %nl = EL(i, 1, NPE);
            nl = EL(i, 1:NPE);
            
            Ele = EL(i,1:NPE); %identify all the nodes connected to that element
           
            nl(1) = Ele(1);
            nl(2) = Ele(4);
            nl(3) = Ele(2);
            nl(4) = Ele(5);
            nl(5) = Ele(3);
            nl(6) = Ele(6);
            
            for j = 1:NPE
                X_1(j, i) = ENL(nl(j), 1) + scale*ENL(nl(j), 4*PD+1);
                Y_1(j, i) = ENL(nl(j), 2) + scale*ENL(nl(j), 4*PD+2);
            end
%             for j=1:NPE  %getting the coordinates of each node
%                 x_1(j,i) = ENL(nl(j),1);
%                 y_1(j,i) = ENL(nl(j),2);
%             end
%             
%             X_1_int = [x_1(1) x_1(5) x_1(8) x_1(9); 
%                         x_1(5) x_1(2) x_1(9) x_1(6);
%                         x_1(9) x_1(6) x_1(7) x_1(3);
%                         x_1(8) x_1(9) x_1(4) x_1(7)];
%             X_1 = [X_1 X_1_int];
%             Y_1_int = [y_1(1) y_1(5) y_1(8) y_1(9); 
%                         y_1(5) y_1(2) y_1(9) y_1(6);
%                         y_1(9) y_1(6) y_1(7) y_1(3);
%                         y_1(8) y_1(9) y_1(4) y_1(7)];
%             Y_1 = [Y_1 Y_1_int];

            
            
            for j = 1:NPE
                val = stress(i,:,1,1); %for stress
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(1))/2];
                stress_xx(j,i) = val(1,j);
                
%                 vald = disp(i,:,1,1); %for displacement
%                 disp_xx(j,i) = vald(1,j);
                
                valn = strain(i,:,1,1); %for strain
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(1))/22];
                strain_xx(j,i) = valn(1,j);
                
            end
            
            for j = 1:NPE
                val = stress(i, :, 1, 2);
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(1))/2];
                stress_xy(j,i) = val(1, j);
                
%                 vald = disp(i,:,1,2);
%                 disp_xy(j,i) = vald(1,j);
                
                valn = strain(i,:,1,2);
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(1))/22];
                strain_xy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 1);
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(1))/2];
                stress_yx(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,1);
%                 disp_yx(j,i) = vald(1,j);
                
                valn = strain(i,:,2,1);
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(1))/22];
                strain_yx(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                val = stress(i, :, 2, 2);
                val = [val(1) (val(1)+val(2))/2 val(2) (val(2)+val(3))/2 val(3) (val(3)+val(1))/2];
                stress_yy(j,i) = val(1, j);
                
%                 vald = disp(i,:,2,2);
%                 disp_yy(j,i) = vald(1,j);
                
                valn = strain(i,:,2,2);
                valn = [valn(1) (valn(1)+valn(2))/2 valn(2) (valn(2)+valn(3))/2 valn(3) (valn(3)+valn(1))/2];
                strain_yy(j,i) = valn(1,j);
            end
            
            for j = 1:NPE
                disp_y(j, i) = abs(ENL(nl(j), 4*PD + 2));
                disp_x(j, i) = abs(ENL(nl(j), 4*PD + 1));
            end
            
        end
        
end
% 
% f1 = figure(1);
% % subplot(3,1,1)
% switch plotType
%     case 'xx'
%         
%         patch(X_1, Y_1, stress_xx, 'FaceColor' , 'interp');
%     case 'xy'
%         
%         patch(X_1, Y_1, stress_xy, 'FaceColor' , 'interp');
%     case 'yx'
%         
%         patch(X_1, Y_1, stress_yx, 'FaceColor' , 'interp');
%     case 'yy'
%         
%         patch(X_1, Y_1, stress_yy, 'FaceColor' , 'interp');
% end
% colormap jet;
% colorbar;
% title(['stress ' plotType])
% 
% f2 = figure(2);
% % subplot(3,1,2)
% switch plotType
%     case 'xx'
%         
%         patch(X_1, Y_1, strain_xx, 'FaceColor' , 'interp');
%     case 'xy'
%         
%         patch(X_1, Y_1, strain_xy, 'FaceColor' , 'interp');
%     case 'yx'
%         
%         patch(X_1, Y_1, strain_yx, 'FaceColor' , 'interp');
%     case 'yy'
%         
%         patch(X_1, Y_1, strain_yy, 'FaceColor' , 'interp');
% end
% colormap jet;
% colorbar;
% title(['strain ' plotType])
% 
% 
% f3 = figure(3);
% % subplot(3,1,3)
% switch plotType
%     case 'xx'
%         
%         patch(X_1, Y_1, disp_x, 'FaceColor' , 'interp');
%     case 'yy'
%         
%         patch(X_1, Y_1, disp_y, 'FaceColor' , 'interp');
% end
% colormap jet;
% colorbar;
% title(['displacement ' plotType])

end

function [disp, stress, strain] = element_pp(NL, EL, ENL)


GPE = getGlobalgpe;
nu = getGlobalV;
E = getGlobalE;

NoN = size(ENL, 1);
NoE = size(EL, 1);
NPE = size(EL, 2);
PD = size(NL, 2);
%NNL = zeros(NoN, 9);

switch NPE
    case 3
        GPE = 1;
    case 4
        GPE = 4;
    case 6
        GPE = 3;
    case 8
        GPE = 4;
    case 9
        GPE = 9;
end

%we write displacements on the corners, stress and strain on gauss points
disp = zeros(NoE, NPE, PD, 1);
%look at contents of stress matrix
%we choose the element
%the element has a set number of gauss points (e.g. 4)
%each gauss point has a matrix of PD * PD
stress = zeros(NoE, GPE, PD, PD);
strain = zeros(NoE, GPE, PD, PD);

for e = 1:NoE
    
    nl = EL(e, 1:NPE); %node numbers connected to each element
    coor = zeros(PD, NPE);
    
    for i = 1:NPE
        for j = 1:PD
            coor(j, i) = NL(nl(i), j);
        end
    end
    
    u = zeros(PD, NoE);
    for i = 1:NPE
        for j = 1:PD
            u(j,i) = ENL(nl(i), 4*PD + j);
        end
    end
    
    for i = 1:NPE
        for j = 1:PD
            disp(e,i,j,1) = ENL(nl(i), 4*PD + j);
        end
    end
    
    for gp = 1:GPE
        epsilon = zeros(PD, PD);
        for i = 1:NPE
            J = zeros(PD, PD);
            grad = zeros(PD, NPE);
        end
    end
    
    
    for gp = 1:GPE
        
        epsilon = zeros(PD, PD);
        
        for i = 1:NPE
            
            J = zeros(PD, PD);
            grad = zeros(PD, NPE);
            [xi, eta, alpha] = GaussPoint(NPE, GPE, gp);
            grad_nat = grad_N_nat(NPE,xi,eta);
            J = coor*grad_nat';
            grad = inv(J)' * grad_nat;
            
            epsilon = epsilon + 1/2 * (dyad(u(:, i), grad(:, i)) + dyad(grad(:, i), u(:, i)));
        end
        
        sigma = zeros(PD, PD);
        for a = 1:PD
            for b = 1:PD
                for c = 1:PD
                    for d = 1:PD
                        sigma(a, b) = sigma(a, b) + constitutive(a, b, c, d, E, nu) * epsilon(c, d);
                    end
                end
            end
        end
        
        for a = 1:PD
            for b = 1:PD
                strain(e,gp,a,b) = epsilon(a,b);
                stress(e,gp,a,b) = sigma(a,b);
            end
        end
        
    end
    
end


end



function result = grad_N_nat( NPE, xi , eta)
%returns matrix representing the gradient of the shape functions in natural
%domain evaluated at xi and eta

    PD = 2; 
    
    result = zeros(PD,NPE);
    
    if (NPE ==3) %triangular
        
        result(1,1) = 1;
        result(1,2) = 0;
        result(1,3) = -1;
        
        result(2,1) = 0;
        result(2,2) = 1;
        result(2,3) = -1;
        
    elseif(NPE == 4)
        
        result(1,1) = -1/4*(1-eta);
        result(1,2) =  1/4*(1-eta);
        result(1,3) =  1/4*(1+eta);
        result(1,4) = -1/4*(1+eta);
        
        result(2,1) = -1/4*(1-xi);
        result(2,2) = -1/4*(1+xi);
        result(2,3) =  1/4*(1+xi);
        result(2,4) =  1/4*(1-xi);
        
    elseif(NPE == 6)
        
       result(1,1)=-1 +(4*xi);
       result(1,2)=0;
       result(1,3)=-3+(4*xi)+(4*eta);
       result(1,4)=4*eta;
       result(1,5)=-4*eta;
       result (1,6)= -4*(-1+eta+(2*xi));
       
       result(2,1)=0;
       result(2,2)=-1 +(4*eta);
       result(2,3)=-3+(4*xi)+(4*eta);
       result(2,4)=4*xi;
       result(2,5)=-4*(-1+xi+(2*eta));
       result(2,6)= -4*xi;
        
    elseif (NPE == 9)
        
        result(1,1) = (1/4)*(1-2*xi)*(1-eta)*eta;
        result(1,2) = -(1/4)*(1+2*xi)*(1-eta)*eta;
        result(1,3) = (1/4)*(1+2*xi)*(1+eta)*eta;
        result(1,4) = -(1/4)*(1-2*xi)*(1+eta)*eta;
        result(1,5) = xi*(1-eta)*eta;
        result(1,6) = (1/2)*(1+2*xi)*(1-eta)*(1+eta);
        result(1,7) = -xi*(1-eta)*eta;
        result(1,8) = -(1/2)*(1-2*xi)*(1-eta)*(1+eta);
        result(1,9) = -2*xi*(1-eta)*(1+eta);
        
        result(2,1) = (1/4)*(1-2*eta)*(1-xi)*xi;
        result(2,2) = -(1/4)*(1-2*eta)*(1+xi)*xi;
        result(2,3) = (1/4)*(1+2*eta)*(1+xi)*xi;
        result(2,4) = -(1/4)*(1+2*eta)*(1-xi)*xi;
        result(2,6) = -xi*(1+xi)*eta;
        result(2,5) = (1/2)*(-1+2*eta)*(1-xi)*(1+xi);
        result(2,8) = -eta*(1-eta)*eta;
        result(2,7) = (1/2)*(1+2*eta)*(1-xi)*(1+xi);
        result(2,9) = -2*eta*(1-xi)*(1+xi);
        
        
    elseif (NPE == 8)
        
        result(1,1) = (1/4)*(2*xi+eta)*(1-eta);
        result(1,2) = (1/4)*(2*xi-eta)*(1-eta);
        result(1,3) = (1/4)*(2*xi+eta)*(1+eta);
        result(1,4) = (1/4)*(2*xi-eta)*(1+eta);
        result(1,5) = -xi*(1-eta);
        result(1,6) = (1/2)*(1+eta)*(1-eta);
        result(1,7) = -xi*(1+eta);
        result(1,8) = (-1/2)*(1+eta)*(1-eta);
        
        result(2,1) = (1/4)*(2*eta+xi)*(1-xi);
        result(2,2) = (1/4)*(2*eta-xi)*(1+xi);
        result(2,3) = (1/4)*(2*eta+xi)*(1+xi);
        result(2,4) = (1/4)*(2*eta-xi)*(1-xi);
        result(2,6) = -eta*(1+xi);
        result(2,5) = -(1/2)*(1+xi)*(1-xi);
        result(2,8) = -eta*(1-xi);
        result(2,7) = (1/2)*(1+xi)*(1-xi);

    end
end


function [ xi , eta, alpha ] = GaussPoint( NPE , GPE , gp)

        if (NPE == 3 || NPE == 6)  %D2TR3N
            
            if GPE == 1
            
            xi = 1/3; eta = 1/3 ; alpha = 1 * (1/2) ; 
            
            elseif GPE == 3
                
                if gp == 1
                    xi = 1/6; eta = 1/6 ; alpha = (1/3) * (1/2) ;
                elseif gp == 2
                    xi = 2/3; eta = 1/6 ; alpha = (1/3) * (1/2) ;
                elseif gp == 3
                    xi = 1/6; eta = 2/3 ; alpha = (1/3) * (1/2) ;
                end
            end
        
        elseif (NPE == 4 || NPE == 8)  %D2QU4N (or any D2QU
            
            if (GPE == 1) %if 1 gauss points
                
                xi = 0 ; eta = 0; alpha = 4;
                
            elseif (GPE == 4) %if 4 gauss points
                
                if (gp == 1)  %first gp
                    
                    xi = -1/sqrt(3); eta= -1/sqrt(3); alpha = 1;
                    
                elseif (gp == 2)
                    
                    xi =  1/sqrt(3); eta= -1/sqrt(3); alpha = 1;
                    
                elseif (gp == 3)
                    
                    xi =  1/sqrt(3); eta= 1/sqrt(3); alpha = 1;
                elseif (gp == 4)
                    
                    xi = -1/sqrt(3); eta= 1/sqrt(3); alpha = 1;
                end
            end
            
                  
        elseif NPE==9
            if (GPE == 1) %if 1 gauss points
                xi = 0 ; eta = 0; alpha = 4;
            elseif (GPE == 9)
                if gp==1
                    xi = -sqrt(3/5); eta = -sqrt(3/5); alpha = (5/9)*(5/9);
                elseif gp==2
                    xi = +sqrt(3/5); eta = -sqrt(3/5); alpha = (5/9)*(5/9);
                elseif gp==3
                    xi = +sqrt(3/5); eta = sqrt(3/5); alpha = (5/9)*(5/9);
                elseif gp==4
                    xi = -sqrt(3/5); eta = +sqrt(3/5); alpha = (5/9)*(5/9);
                elseif gp==5
                    xi = 0; eta = -sqrt(3/5); alpha = (5/9)*(8/9);
                elseif gp==6
                    xi = +sqrt(3/5); eta =0; alpha = (5/9)*(8/9);
                elseif gp==7
                    xi = 0; eta = sqrt(3/5); alpha = (5/9)*(8/9);
                elseif gp==8
                    xi = -sqrt(3/5); eta = 0; alpha = (5/9)*(8/9);
                elseif gp==9
                    xi = 0; eta = 0; alpha = (5/9)*(8/9);    
                end
            end
        end
end


function C = constitutive(i, j, k, l, E, nu)
C = (E/(2*(1+nu))) * ((i==l)*(j==k) + (i==k)*(j==l)) + E*nu/(1-nu^2) * (i==j)*(k==l);
end


function A = dyad(u, v)



PD = 2;
A = zeros(PD, PD);
for i = 1:PD
    for j = 1:PD
        A(i, j) = u(i) * v(j);
    end
end


end


function GPE = getGlobalgpe
global gpe
GPE = gpe;
end


function v = getGlobalV
global V
v = V;
end

function e = getGlobalE
global E
e = E;
end