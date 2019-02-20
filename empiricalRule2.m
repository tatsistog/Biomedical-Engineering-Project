function k = empiricalRule2(sigma)
%% Calculate kappa given sigma
k = 2.4107 + 1.3253 * exp( (-23.2699) * (sigma^2));
end