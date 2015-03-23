% Find the relevant data search
[ind1,val1] = find(labels==1);
[ind2,val2] = find(labels==-1);
% search for zero movement
ind = [ind1;ind2];
newind = sort(ind,'ascend');
[ind3,val3] = find(labels(newind(1):newind(end),1)==0);


% Normalize sensor data
% maxpoint = double(max(max(sensordata)));
% minpoint = double(min(min(sensordata)));
% normdata = (double(sensordata) - minpoint)./(maxpoint-minpoint);
%z score data
% normdata = (double(sensordata) - mean2(double(sensordata(ind3,:))));
% normdata = zscore(double(sensordata));

% Find threshold by plotting hist of distribution
data1 = [];
data2 = [];

for i = 1:length(ind1)
    data1 = [data1; normdata(ind1(i),:)'];
end
for i = 1:length(ind2)
    data2 = [data2; normdata(ind2(i),:)'];
end

data3 = zeros(length(ind3)*8,1);
for i = 1:length(ind3)
    data3((i-1)*8+1:i*8,1)=normdata(ind3(i),:)';
end

% figure
% hist(data1,20)
% 
% figure
% hist(data2,20)

% figure
% hist(data3,20)

[row, col] = find(sensordata>mean2(double(sensordata(ind3,:)))+std2(double(sensordata(ind3,:))));
get = zeros(size(sensordata,1),8);
for k = 1:length(row)
    get(row(k),col(k)) = 1;
end

figure
for i = 1:8:length(sensordata)
matrix = get(i:i+7,:);
    if unixtime(i) > unixtime(newind(1)) && unixtime(i) <= unixtime(newind(end))
%         disp(i)
%         disp([row,col])
%         disp(labels(i))
%         pause(0.5)
        %imagesc(matrix)
        % colormap(gray)
        if labels(i) ==0
            imagesc(matrix)
            colormap(gray)
            % colorbar
            caxis([0,1])
        %caxis([100,110])
        %format long e
            title(strcat(num2str(labels(i)),'  and unixtime is  ',num2str(utime_round(i))))
            pause(0.5)
        end
    end 
end
