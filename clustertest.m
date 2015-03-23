%assign cluster to new data point based on euclidean distance

Xtest = datmat31(:,1:3);
Ytest = datmat31(:,5);
testres = ones(size(Ytest));
dist = ones(4,1);

% for i = 1:size(cent,1)
%     dist(i,1) = norm((Xtest-cent(i,:)),2);
% end
% 
% [val1,ind1] = min(dist);
% occ = class(ind1,1);
% 
% disp(occ)

dist = ones(4,1);
for j = 1:size(Xtest,1)
    for i = 1:size(cent,1)
        dist(i,1) = norm((Xtest(j,:)-cent(i,:)),2);
    end

    [val1,ind1] = min(dist);
    occ = class(ind1,1);
    %disp(occ)
    testres(j,1) = occ;
end

[in,v] = find(testres==Ytest);
per_acc = length(in)/size(Ytest,1);
disp(per_acc)