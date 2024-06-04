% Photo Sets
S1_im1 = rgb2gray(im2double(imread('S1-im1.png')));
S1_im2 = rgb2gray(im2double(imread('S1-im2.png')));
S2_im1 = rgb2gray(im2double(imresize(imread('S2-im1.png'), [750 480])));
S2_im2 = rgb2gray(im2double(imresize(imread('S2-im2.png'), [750 480])));
S3_im1 = rgb2gray(im2double(imresize(imread('S3-im1.png'), [750 480])));
S3_im2 = rgb2gray(im2double(imresize(imread('S3-im2.png'), [750 480])));
S4_im1 = rgb2gray(im2double(imresize(imread('S4-im1.png'), [750 480])));
S4_im2 = rgb2gray(im2double(imresize(imread('S4-im2.png'), [750 480])));

% FAST feature detector
tic;
fast_corners_S1_im1 = my_fast_detection(imresize(imread('S1-im1.png'), [750 480]), S1_im1, "S1-fast.png");
fast_corners_S1_im2 = my_fast_detection(imresize(imread('S1-im2.png'), [750 480]), S1_im2, "S1.2-fast.png");
fast_corners_S2_im1 = my_fast_detection(imresize(imread('S2-im1.png'), [750 480]), S2_im1, "S2-fast.png");
fast_corners_S2_im2 = my_fast_detection(imresize(imread('S2-im2.png'), [750 480]), S2_im2, "S2.2-fast.png");
fast_corners_S3_im1 = my_fast_detection(imresize(imread('S3-im1.png'), [750 480]), S3_im1, "S3-fast.png");
fast_corners_S3_im2 = my_fast_detection(imresize(imread('S3-im2.png'), [750 480]), S3_im2, "S3.2-fast.png");
fast_corners_S4_im1 = my_fast_detection(imresize(imread('S4-im1.png'), [750 480]), S4_im1, "S4-fast.png");
fast_corners_S4_im2 = my_fast_detection(imresize(imread('S4-im2.png'), [750 480]), S4_im2, "S4.2-fast.png");
elapsed_time = toc;
average_time = elapsed_time / 8;
disp(['Average time of FAST: ' num2str(average_time) ' seconds/image']);

% Robust FAST using Harris Cornerness metric
tic;
FASTR_S1_im1 = my_fastR_detection(imresize(imread('S1-im1.png'), [750 480]), S1_im1, "S1-fastR.png", fast_corners_S1_im1);
FASTR_S1_im2 = my_fastR_detection(imresize(imread('S1-im2.png'), [750 480]), S1_im2, "S1.2-fastR.png", fast_corners_S1_im2);
FASTR_S2_im1 = my_fastR_detection(imresize(imread('S2-im1.png'), [750 480]), S2_im1, "S2-fastR.png", fast_corners_S2_im1);
FASTR_S2_im2 = my_fastR_detection(imresize(imread('S2-im2.png'), [750 480]), S2_im2, "S2.2-fastR.png", fast_corners_S2_im2);
FASTR_S3_im1 = my_fastR_detection(imresize(imread('S3-im1.png'), [750 480]), S3_im1, "S3-fastR.png", fast_corners_S3_im1);
FASTR_S3_im2 = my_fastR_detection(imresize(imread('S3-im2.png'), [750 480]), S3_im2, "S3.2-fastR.png", fast_corners_S3_im2);
FASTR_S4_im1 = my_fastR_detection(imresize(imread('S4-im1.png'), [750 480]), S4_im1, "S4-fastR.png", fast_corners_S4_im1);
FASTR_S4_im2 = my_fastR_detection(imresize(imread('S4-im2.png'), [750 480]), S4_im2, "S4.2-fastR.png", fast_corners_S4_im2);
elapsed_time = toc;
average_time = elapsed_time / 8;
disp(['Average time of FASTR: ' num2str(average_time) ' seconds/image']);

% Point Description and Matching
    %Photo Set 1
[matchedPoints_FAST_S1_im1, matchedPoints_FAST_S1_im2] = fast_matching(imresize(imread('S1-im1.png'), [750 480]), imresize(imread('S1-im2.png'), [750 480]), S1_im1, fast_corners_S1_im1, S1_im2, fast_corners_S1_im2, 'S1-fastMatch.png');
[matchedPoints_FASTR_S1_im1, matchedPoints_FASTR_S1_im2] = fastR_matching(imresize(imread('S1-im1.png'), [750 480]), imresize(imread('S1-im2.png'), [750 480]), S1_im1, FASTR_S1_im1, S1_im2, FASTR_S1_im2, 'S1-fastRMatch.png');

    %Photo Set 2
[matchedPoints_FAST_S2_im1, matchedPoints_FAST_S2_im2] = fast_matching(imresize(imread('S2-im1.png'), [750 480]), imresize(imread('S2-im2.png'), [750 480]), S2_im1, fast_corners_S2_im1, S2_im2, fast_corners_S2_im2, 'S2-fastMatch.png');
[matchedPoints_FASTR_S2_im1, matchedPoints_FASTR_S2_im2] = fastR_matching(imresize(imread('S2-im1.png'), [750 480]), imresize(imread('S2-im2.png'), [750 480]), S2_im1, FASTR_S2_im1, S2_im2, FASTR_S2_im2, 'S2-fastRMatch.png');

    %Photo Set 3
[matchedPoints_FAST_S3_im1, matchedPoints_FAST_S3_im2] = fast_matching(imresize(imread('S3-im1.png'), [750 480]), imresize(imread('S3-im2.png'), [750 480]), S3_im1, fast_corners_S3_im1, S3_im2, fast_corners_S3_im2, 'S3-fastMatch.png');
[matchedPoints_FASTR_S3_im1, matchedPoints_FASTR_S3_im2] = fastR_matching(imresize(imread('S3-im1.png'), [750 480]), imresize(imread('S3-im2.png'), [750 480]), S3_im1, FASTR_S3_im1, S3_im2, FASTR_S3_im2, 'S3-fastRMatch.png');

    %Phhoto Set 4
[matchedPoints_FAST_S4_im1, matchedPoints_FAST_S4_im2] = fast_matching(imresize(imread('S4-im1.png'), [750 480]), imresize(imread('S4-im2.png'), [750 480]), S4_im1, fast_corners_S4_im1, S4_im2, fast_corners_S4_im2, 'S4-fastMatch.png');
[macthedPoints_FASTR_S4_im1, matchedPoints_FASTR_S4_im2] = fastR_matching(imresize(imread('S4-im1.png'), [750 480]), imresize(imread('S4-im2.png'), [750 480]), S4_im1, FASTR_S4_im1, S4_im2, FASTR_S4_im2, 'S4-fastRMatch.png');

% RANSAC and Panoramas

panorama_for_2_FAST2(imread('S1-im1.png'), imread('S1-im2.png'), matchedPoints_FAST_S1_im2, matchedPoints_FAST_S1_im1, "S1-panorama.png");
panorama_for_2_FAST2(imread('S2-im1.png'), imread('S2-im2.png'), matchedPoints_FASTR_S2_im2, matchedPoints_FASTR_S2_im1, "S2-panorama.png");
panorama_for_2_FAST2(imread('S3-im1.png'), imread('S3-im2.png'), matchedPoints_FASTR_S3_im2, matchedPoints_FASTR_S3_im1, "S3-panorama.png");
panorama_for_2_FAST2(imread('S4-im1.png'), imread('S4-im2.png'), matchedPoints_FASTR_S4_im2, macthedPoints_FASTR_S4_im1, "S4-panorama.png");