function m = A2_model(action)
% A2_MODEL Represents the model of the game.
%     The possible actions are left (-1) and right (+1).
%     This function will compute the number of places to move.
%     Currently, the model is a probability distribution based
%     on the following distribution: 1 (90%), 2 (10%)

distribution = [0.9 0.1];
r = rand;
cummul = 0;
m = 0;
for i=1:length(distribution)
    cummul = cummul + distribution(i);
    if r < cummul
        m = i;
        break;
    end
end
m = m * action;
end