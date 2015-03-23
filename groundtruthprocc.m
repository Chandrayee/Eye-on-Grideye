hour = zeros(size(data,1),1);
minutes = zeros(size(data,1),1);
rawocc = zeros(size(data,1),1);

for i = 1:size(data,1)
    rawocc(i,1) = str2num(textdata{i,6});
    hour(i,1) = str2num(textdata{i,3}(1,1:2));
    minutes(i,1) = str2num(textdata{i,3}(1,4:5));
end

[findzero,zeroval] = find(rawocc==0);

actualind = zeros(length(findzero),1);

%find indices for which value is zero
for i = 1:length(findzero)
    if strcmp(textdata{findzero(i),2},'Tuesday') == 1 
        actualind(i,1) = hour(findzero(i))*60+minutes(findzero(i));
    elseif strcmp(textdata{findzero(i),2},'Wednesday') == 1
        actualind(i,1) = (24+hour(findzero(i)))*60+minutes(findzero(i));
    end
end

prococc = zeros(48*60,1);

for i = 1:size(rawocc,1)
    if strcmp(textdata{i,2},'Tuesday') == 1 
        prococc(hour(i,1)*60+minutes(i,1),1) = rawocc(i,1);
    elseif strcmp(textdata{i,2},'Wednesday') == 1
        prococc((24+hour(i,1))*60+minutes(i,1),1) = rawocc(i,1);
    end
end

%find indices for which the value is not zero
[ind,val] = find(prococc>0);

%add them up
finalind = sort([ind;actualind],'ascend');



for i = 1:length(finalind)-1
    prococc(finalind(i)+1:(finalind(i+1)-1),1) = prococc(finalind(i),1);
end
prococc = int64(prococc);



disp('done')