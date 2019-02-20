function array = deleterows(array)
[m,n] = size(array);

for i = 1:1:m
    if(array(i,:) == zeros(1,n))
        break;
    end
end
array = array(1:i-1,:);
end