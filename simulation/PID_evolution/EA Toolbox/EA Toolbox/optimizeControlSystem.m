function [offspring,HV] = optimizeControlSystem(P)
    n = 250;
    i = 0;
    HV = zeros(1,n);
    g = [1, -6, 20, 2, 10, 10, 8, 20, 1, 0.67]; % goals 
    p = [3, 2, 2, 1, 0, 1, 0, 0, 1, 2];
    while i < n

        results = evaluateControlSystem(P);
        %% non-dom sorting 
        %calculate dom ranks 
        dominance = rank_prf(results,g, p);
       
        % invert them
        invertedDominance  = max(dominance) - dominance;
        %% crowding distance
        crowdDist = crowding(P,invertedDominance);

        %% performance selection-for-variation 
        selectionIdx = btwr(crowdDist);
        selection = P(selectionIdx,:);
        
        

        %% perform variation 
        % Inputs: preMute   - parent population (rows of individuals)
        % bounds    - decision variable bounds (lower; upper)
        % nm        - mutation parameter
        % prob      - probability of mutation of a single phenotype

        bounds = [zeros(1,2); ones(1,2)];
        C = polymut(selection, bounds);

        % results = evaluateControlSystem(C);
        % results = postProcessData(results); 

        %C = postProcessData(C);

        oyako = [P; C];

        oyakoResults = evaluateControlSystem(oyako);

        oyakoDominance = rank_prf(oyakoResults,g, p);
       
        % invert them
        %oyakoDominance  = max(oyakoDominance) - oyakoDominance;

        %% crowding distance
        oyakoCwdDist = crowding(oyako,oyakoDominance);

        new_indices = reducerNSGA_II(oyako, oyakoDominance, oyakoCwdDist,100);

        P = oyako(new_indices,:);
        otpt = P;
        i = i + 1; 
        disp(i)
        %cforHV = evaluateControlSystem(P);
        %cforHV = postProcessData(cforHV); 
        %HV(i) = Hypervolume_MEX(cforHV);
    end
    offspring = otpt;
end