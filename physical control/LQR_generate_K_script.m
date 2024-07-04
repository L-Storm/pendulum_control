        dt = 0.002;
        q = 6; 
        A = [
         0         0    1.0000         0;
         0         0         0    1.0000;
         0   -9.0602   -0.0630    0.0111;
         0   20.2744   -0.0360   -0.0249];
        

        B = [       0;
                    0;
                  0.2299;
                  -0.1314];
        C = [   1 0 0 0;
                0 1 0 0];
        D = [0;0];

        Q = [     q*2     0     0     0;
          0     q     0     0;
          0     0     q     0;
          0     0     0     q];
        R = 1;

        sys = ss(A,B,C,D,dt);

        K = lqr(sys,Q,R);
        disp(K)