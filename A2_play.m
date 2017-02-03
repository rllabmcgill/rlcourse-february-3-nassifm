function trace = A2_play(gamma, initial_state)
% A2_PLAY Execute one simulation and returns the trajectory
%    The simulation consist of moving between the digits 0 to 9.
%    The initial state is given as a parameter.
%    The terminal state is 0.
%    There are 2 actions, moving left (-) or right (+).
%    The resulting movement depends on a random variable between 1 and 8.
%    If a move result in overflow, it wraps around.
%    The parameter gamma is the probability of surviving each round.

trace = []; % trace of simulation (sequence of state-action-state-...)
x = initial_state; % current state
while x ~= 0
    dir = choose_action(x);
    trace = [trace x dir];
    x = mod(x + A2_model(dir), 10);
    if rand > gamma
        break
    end
end
end

function dir = choose_action(state)
% CHOOSE_ACTION Select action according to behavior_policy
global behavior_policy
dir = (rand < behavior_policy(state)); % selects left or right according to policy
dir = dir * 2 - 1; % transformation to -1 or +1
end