%Kmeans clustering of scenes, output type of number of people
X = [datmat12(:,1:3);datmat21(:,1:3);datmat31(:,1:3);datmat41(:,1:3)];
Y = [datmat12(:,5);datmat21(:,5);datmat31(:,5);datmat41(:,5)];

%perform kmeans clustering
[idx,cent] = kmeans(X,4);

%select which cluster represents which occupancy
class = ones(4,1);
acc = ones(4,1);
for i = 1:4
    [ind,val] = find(idx == i);
    classes = unique(Y(ind));
    major = mode(Y(ind));
    [id,v] = find(Y(ind) == major);
    if length(id)/length(ind)>0.5
        class(i,1) = major;
    else
        class(i,1) = classes(classes ~= major); 
    end
    
    acc(i,1) = length(Y(Y(ind)==class(i,1)))/length(ind);
end

%find misclassification








