function [matchedPoints_FASTR_im1, matchedPoints_FASTR_im2] = fastR_matching(rgb_im1, rgb_im2, im1, FASTR_im1, im2, FASTR_im2, output);
    points_im1 = detectSURFFeatures(FASTR_im1);
    points_im2 = detectSURFFeatures(FASTR_im2);

    [features_FASTR_im1, validPoints_FASTR_im1] = extractFeatures(im1, points_im1);
    [features_FASTR_im2, validPoints_FASTR_im2] = extractFeatures(im2, points_im2);
    
    indexPairs_FASTR = matchFeatures(features_FASTR_im1, features_FASTR_im2);
    
    matchedPoints_FASTR_im1 = validPoints_FASTR_im1(indexPairs_FASTR(:, 1), :);
    matchedPoints_FASTR_im2 = validPoints_FASTR_im2(indexPairs_FASTR(:, 2), :);
    
    figure;
    showMatchedFeatures(rgb_im1, rgb_im2, matchedPoints_FASTR_im1, matchedPoints_FASTR_im2, "montag");
    saveas(gcf, output);
end