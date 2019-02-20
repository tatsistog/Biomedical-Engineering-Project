function number = findzerosBolzano(array)
number = 0;
n = length(array);

for i=2:1:n
    if(array(i)*array(i-1)<0)
        number = number + 1;
    end
end
end