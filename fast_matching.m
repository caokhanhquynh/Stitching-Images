function [matchedPoints_FAST_im1, matchedPoints_FAST_im2] = fast_matching(rgb_im1, rgb_im2, im1, FAST_im1, im2, FAST_im2, output)
    points_im1 = detectSURFFeatures(FAST_im1);
    points_im2 = detectSURFFeatures(FAST_im2);

    [features_FAST_im1, validPoints_FAST_im1] = extractFeatures(im1, points_im1);
    [features_FAST_im2, validPoints_FAST_im2] = extractFeatures(im2, points_im2);

    indexPairs_FAST = matchFeatures(features_FAST_im1, features_FAST_im2);
    
    matchedPoints_FAST_im1 = validPoints_FAST_im1(indexPairs_FAST(:, 1), :);
    matchedPoints_FAST_im2 = validPoints_FAST_im2(indexPairs_FAST(:, 2), :);
    
    figure;
    showMatchedFeatures(rgb_im1, rgb_im2, matchedPoints_FAST_im1, matchedPoints_FAST_im2, "montag");
    saveas(gcf, output);
end