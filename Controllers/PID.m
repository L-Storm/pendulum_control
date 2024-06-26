function [otpt_v, status,P1,P2]= PID(arm1_ang,arm2_ang)

% Declare persistent variables 
persistent previous_arm1_inpt
persistent previous_arm2_inpt
persistent i1
persistent i2
status = true; 


    if abs(arm2_ang) < 20
        if(isempty(previous_arm1_inpt))
            previous_arm1_inpt = 0; 
            previous_arm2_inpt = 0;
        end
        
        if(isempty(i1))
            i1 = 0; 
            i2 = 0;
        end
        
        %tunable values 
        Kp1 = 2.047; 
        Ki1 = 0.9;
        Kd1 = 0.0;
        Kp2 = 10.47;
        Ki2 = 2.4532925;
        Kd2 = 0;
        rate = 0.002;
        
        % I values 
        i1 = i1 + (previous_arm1_inpt + arm1_ang)*rate/2;
        i2 = i2 + (previous_arm2_inpt + arm2_ang)*rate/2;
        
        % D values 
        d2 = (previous_arm2_inpt- arm2_ang)/rate;
        d1 = (previous_arm1_inpt - arm1_ang)/rate; 
        
        %PID otpt 
        P1 = arm1_ang*Kp1 + Ki1*i1 + Kd1*d1;
        P2 = arm2_ang*Kp2 + Ki2*i2 + Kd2*d2;
        otpt_v = P2;
        
        
        previous_arm1_inpt = arm1_ang; 
        previous_arm2_inpt = arm2_ang; 
    else 
        otpt_v = 0;
        status = false;
        P1 = 0;
        P2 = 0;
    end
end