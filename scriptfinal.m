%script

load('background_pixelmean.mat')
pixelmatrix
connectedcomponent
peaksearch
labels = 3*ones(n,1);
datmat42 = [noactivepixel,numobjects,biggestcomp,nopeak',labels];
save('dat42.mat','datmat42');