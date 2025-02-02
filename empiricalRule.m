function k = empiricalRule(sigma)
%% Calculate kappa given sigma
k = 2.987054158916228 + 25.729507944619690*sigma -3.297076438109245*(10^2)*sigma^2+ ...
    1.545106292732301*(10^3)*sigma^3 -3.271458033961444e+03*sigma^4 +...
    2.613703309203967e+03*sigma^5;
end