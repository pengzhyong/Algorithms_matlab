clear all
data.imagename = 'images\elephant_2.pgm';
data.orientation = 0;
data.nroriens = 12;
data.sigma = 2.0;
data.wavelength = 10;%data.sigma / 0.56;
data.bandwidth = 1;
data.phaseoffset = [0,90];
data.aspectratio = 0.8;
data.hwstate = 1;
data.halfwave = 0;
data.supPhases = 2;
data.inhibMethod = 3;% 2 means ins, 3 means antins
data.supIsoinhib = 3;%L1 norm (SUPINHIB == 1), L2 norm (SUPINHIB == 2) or L_INF norm (SUPINHIB == 3, this is maximum superposition)
data.alpha = 1.0;
data.k1 = 1;
data.k2 = 4;
data.thinning = 1;% 1 means do thingning, or do nothing
data.hyst = 1;% 1 means use hypersist-tholding, 0 means do nothing
data.tlow = 0.1;
data.thigh = 0.2;
data.invertOutput = 1;
data.groundtruth = imread('images\gt\elephant_2_gt_binary.pgm');
if(size(data.groundtruth, 3) ~= 1)
    data.groundtruth = rgb2gray(data.groundtruth);
end
data.groundtruth = im2double(data.groundtruth);

% figure(1)
% imshow(data.imagename);
% figure(2)
% imshow(data.groundtruth);

% initialization and calculation of convolutions
% note that the list of orientations is sorted and contains no
% duplicate values
[data.img, data.orienslist, data.sigmaC] = readandinit(data.imagename, data.orientation, data.nroriens, data.sigma, data.wavelength, data.bandwidth); % initialisation
data.selection = (1:size(data.orienslist,2));
data.convResult = gaborfilter(data.img, data.wavelength, data.sigma, data.orienslist, data.phaseoffset, data.aspectratio, data.bandwidth);

% calculation of half-wave rectification
if (data.hwstate == 1)
data.hwResult = calc_halfwaverect(data.convResult, data.orienslist, data.phaseoffset, data.halfwave);
else
data.hwResult = data.convResult;
end

% calculation of the superposition of phases
data.superposResult = calc_phasessuppos(data.hwResult, data.orienslist, data.phaseoffset, data.supPhases);

% calculation of the surround inhibition
data.inhibResult = calc_inhibition(data.superposResult, data.inhibMethod, data.supIsoinhib, data.sigmaC, data.alpha, data.k1, data.k2);

% calculation of the orientationmatrix (maximum orientation response
% per point) and merges the images per orientation to one image
[data.viewResult, data.oriensMatrix] = calc_viewimage(data.inhibResult, data.selection, data.orienslist);

% calculation of the thinned image
data.thinResult = calc_thinning(data.viewResult, data.oriensMatrix, data.thinning);

% calculation of the hysteresis thresholded image
data.hystResult = calc_hysteresis(data.thinResult, data.hyst, data.tlow, data.thigh);

if (data.invertOutput == 1) % the image should be inverted
data.result = 0 - data.hystResult;
else
data.result = data.hystResult;
end

% to create an image file the result should first be scaled between 0 and 1
minimum = min(min(data.result));
maximum = max(max(data.result));
if (minimum ~= maximum)
data.saveResult = (data.result - minimum) / (maximum - minimum);
else
data.saveResult = 0;
end
figure(3)
imshow(data.saveResult);
[data.efp, data.efn, data.p] = evaluate(data.saveResult, data.groundtruth, 5);