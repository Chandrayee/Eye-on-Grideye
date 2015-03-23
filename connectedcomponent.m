%connected component analysis
% this code computes the total number of connected components and size of
% the largest connected component and total number of active pixels

% Number of active pixels
noactivepixel = [];
CC = {};
numPixels = {};
bin_image = {};
biggestcomp = zeros(n,1);
numobjects = [];

for i  = 1:n
    [x,y,val] = find(minusbackground{i}==0);
    noactivepixel = [noactivepixel;(64-length(x))];
end

%create binary image
for i  = 1:n
    for j = 1:8
        for k = 1:8
            if minusbackground{i}(k,j)>0
               bin_image{i}(k,j)=100;
            end
        end
    end
end

%connected component analysis
for i = 1:n
    CC{i} = bwconncomp(bin_image{i});
    numPixels{i} = cellfun(@numel,CC{i}.PixelIdxList);
    numobjects = [numobjects;CC{i}.NumObjects];
    [biggest,idx] = max(numPixels{i});
    %disp(biggest)
    if size(biggest,2)==0
        biggestcomp(i,1) = 0;
    else
        biggestcomp(i,1) = biggest;
    end
end
