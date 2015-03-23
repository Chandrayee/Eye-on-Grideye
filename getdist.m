%compute histogram
[X,Y] = meshgrid(1:8);
[Xq,Yq] = meshgrid(1:0.25:8);
interpixeldict = {};
for i = 1:n
    pixeldict{i} = double(pixeldict{i});
    Vq = interp2(X,Y,pixeldict{i},Xq,Yq);
    interpixeldict{i} = Vq;
    imagesc(interpixeldict{i})
    %HeatMap hot
    colorbar
    pause(0.002)
end


for i = 1:n
    [x,y,val] = find(interpixeldict{i} == max(max(interpixeldict{i})));
    if (x(1) >1 && y(1)>1  && x(1)<28 && y(1)<28)
        getdata = [interpixeldict{i}(x(1)-1,y(1)-1:y(1)+1),interpixeldict{i}(x(1)+1,y(1)-1:y(1)+1),interpixeldict{i}(x(1),y(1)+1),interpixeldict{i}(x(1),y(1)-1)];
        hist(getdata,4);
        axis([100 112 0 10])
        title([x(1),y(1)])
        pause(2)
        
    end
    
end
