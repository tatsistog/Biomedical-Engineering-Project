function array = deletecolumns(array)
[m,n] = size(array);

for j = 1:1:n
    if(array(:,j) == zeros(m,1))
        break;
    end
end
array = array(:,1:j-1);
end