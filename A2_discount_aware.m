function values = A2_discount_aware(gamma, weighted, time, fixed_init)
% A2_DISCOUNT_AWARE Calculates values using discount-aware methods
%   Uses every-visit methodology.
%   gamma (real [0,1]): discount factor
%   weighted (logical): use weighted (or ordinary) importance sampling
%   time (integer): limit number of iterations (from one state to the next)
%   fixed_init (logical): fix initial state to 5 or select randomly

% records
values = zeros(1,9);
counts = zeros(1,9);
% time counter
i = 0;
% initial state (5 or random)
if fixed_init
    init = 5;
else
    init = ceil(rand * 9); % initial value (uniform between 1 and 9)
end
% trace of the last play
trace = A2_play(1,init);
% length of the trace (number of actions taken)
l = length(trace) / 2;

i = i + l;
while i <= time
    rho = importance_ratio(trace);
    for t=1:l
        s = trace(2*t-1);
        incr = (1 - gamma) * sum((gamma.^(0:(l-t-1))).*cumprod(rho(t:(l-1))).*(-1:-1:(t-l))) + gamma^(l-t)*prod(rho(t:l))*(t-l-1);
        values(s) = values(s) + incr;
        if weighted
            incr = (1 - gamma) * sum((gamma.^(0:(l-t-1))).*cumprod(rho(t:(l-1)))) + gamma^(l-t)*prod(rho(t:l));
            counts(s) = counts(s) + incr;
        else
            counts(s) = counts(s) + 1;
        end
    end
    
    % reset for next play
    if fixed_init
        init = 5;
    else
        init = ceil(rand * 9);
    end
    trace = A2_play(1,init);
    l = length(trace) / 2;
    i = i + l;
end
values = values ./ counts;
end

function r = importance_ratio(trace)
global behavior_policy target_policy
r = zeros(1,length(trace)/2);
for i=2:2:length(trace)
    state = trace(i-1);
    if trace(i) < 0 % left
        r(i/2) = target_policy(state) / behavior_policy(state);
    else % right
        r(i/2) = (1 - target_policy(state)) / (1 - behavior_policy(state));
    end
end
end