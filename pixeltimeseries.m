%time series of pixel values
% pixelbytime = ones(8,8,n);
% for t = 1:n
%     
%     pixelbytime(:,:,t) = minusbackground{t};
%         
% end
saveval = zeros(8,8);
savedelay = zeros(8,8);
for i = 1:8
    for j = 1:8
        [c, lags] = xcorr(pixelbytime(1,4,:),pixelbytime(i,j,:));
        [val, ind2] = max(abs(c));
        delay = lags(ind2);
        %disp([delay,i,j])
        savedelay(i,j) = delay;
        saveval(i,j) = val;
    end
end
        
%A2 = pixelbytime(1,2,:);
%B2 = reshape(A2,1,n);
%[c, lags] = xcorr(B1,B2);





