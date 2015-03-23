%local peak search in background subtracted image
%window size = 6 pixels
nopeak = [];
for i = 1:n
    count = 0;
    [x1,y1,v1] = find(minusbackground{i}~=0);
    threshold = mean(mean(minusbackground{i}(x1,y1)));
    maxval = max(max(minusbackground{i}(x1,y1)));
    for k = 1:2:6
        %disp(k)
        for l = 1:2:6
            %[x2,y2] = max(max(minusbackground{i}(k:k+3,l:l+3)));
            v2 = max(max(minusbackground{i}(k:k+3,l:l+3)));
            if v2>maxval/1.2
                count = count+1;
                %disp(maxval/v2)
            end
            
        end
    end
    if count > numobjects(i,1)
        nopeak = [nopeak, count/(maxval/threshold)];
        %nopeak = [nopeak, count];
    else
        nopeak = [nopeak,numobjects(i,1)];
    end
end