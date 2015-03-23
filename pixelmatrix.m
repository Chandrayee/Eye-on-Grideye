%8x8 matrix from therm
%parsing should start from the end of the file 
%pixelmat is the matrix of pixels from end to beginning of data acquisition
n=length(data(1:656))/8;
pixelmat=zeros(n,8);
%figure
pixelstacked = zeros(8,8,n);
pixeldict = {};
for i=0:n-1
    pixelmat=(data(i*8+1:(i+1)*8,:))';
    pixelstacked(:,:,i+1) = pixelmat;
    pixeldict{i+1} = pixelmat;
%     imagesc(pixelmat)
%     title(unixtime(i*8+1,1))
%     colormap hot
%     colorbar
%     caxis([min(data(:)) max(data(:))])
%     pause(0.002)
end
%compute mean and variance of each pixel
% pixelmean = zeros(8,8);
% pixelvar = zeros(8,8);
% pixelmedian = zeros(8,8);
% for i = 1:8
%     for j = 1:8
%         pixelmean(i,j) = mean(pixelstacked(i,j,:));
%         pixelvar(i,j) = var(pixelstacked(i,j,:));
%         pixelmedian(i,j) = median(pixelstacked(i,j,:));
%     end
% end
%pixelmean is the background image
%background subtraction
%figure
minusbackground = {};
for i = 1:n
    minusbackground{i} = double(pixeldict{i}) - double(pixelmean);
    [row,col] = find(minusbackground{i}<7);
    for j = 1:length(row)
        minusbackground{i}(row(j),col(j)) = 0;
    end
%     imagesc(minusbackground{i})
%     colormap hot
%     colorbar
%     caxis([0 20])
%     pause(0.002)
end







        
        
