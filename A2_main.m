% This script evaluates three off-policy Monte-Carlo methods:
% using ordinary importance sampling,
% using weighted importance sampling and
% using the discount factor as a random time horizon.
% It compares the convergence as well as the variance.

% Policies
global behavior_policy target_policy
behavior_policy = ones(1,9) / 2; % uniform
target_policy = [1 1 1 1 0.5 0 0 0 0]; % closest

% Evaluation parameters
limits = 10.^(3:5);
trials = 100;
gamma = 0.9;
fixed_initial_value = true;
% Evaluation results
disc_aware_or = zeros(length(limits),9);
disc_aware_we = zeros(length(limits),9);
random_horizon_or = zeros(length(limits),9);
random_horizon_we = zeros(length(limits),9);
var_disc_aware_or = zeros(length(limits),9);
var_disc_aware_we = zeros(length(limits),9);
var_random_horizon_or = zeros(length(limits),9);
var_random_horizon_we = zeros(length(limits),9);

for i=1:length(limits)
    results = zeros(trials,9);
    % Discount-aware method with ordinary sampling
    for t=1:trials
        results(t,:) = A2_discount_aware(gamma,false,limits(i),fixed_initial_value);
        disp([1,t,i]);
    end
    disc_aware_or(i,:) = mean(results);
    var_disc_aware_or(i,:) = var(results);
    
    % Discount-aware method with weighted sampling
    for t=1:trials
        results(t,:) = A2_discount_aware(gamma,true,limits(i),fixed_initial_value);
        disp([2,t,i]);
    end
    disc_aware_we(i,:) = mean(results);
    var_disc_aware_we(i,:) = var(results);
    
    % Random horizon method with ordinary sampling
    for t=1:trials
        results(t,:) = A2_random_horizon(gamma,false,limits(i),fixed_initial_value);
        disp([3,t,i]);
    end
    random_horizon_or(i,:) = mean(results);
    var_random_horizon_or(i,:) = var(results);
    
    % Random horizon method with ordinary sampling
    for t=1:trials
        results(t,:) = A2_random_horizon(gamma,true,limits(i),fixed_initial_value);
        disp([4,t,i]);
    end
    random_horizon_we(i,:) = mean(results);
    var_random_horizon_we(i,:) = var(results);
end