function panorama_for_2_FAST2(im1, im2, matchedPoints, matchedPointsPrev, output)
    numImages = 2;
    tforms(numImages) = projtform2d;
    imageSize = zeros(numImages,2);   
    
    I = im2;
    grayImage = im2gray(I); 
    imageSize(2,:) = size(grayImage);

    % Estimate the transformation between I(n) and I(n-1).
    tforms(2) = estgeotform2d(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);
    
    % Compute T(1) * T(2) * ... * T(n-1) * T(n).
    tforms(2).A = tforms(1).A * tforms(2).A;

    for i = 1:numel(tforms)          
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
    end
    avgXLim = mean(xlim, 2);
    [~,idx] = sort(avgXLim);
    centerIdx = floor((numel(tforms)+1)/2);
    centerImageIdx = idx(centerIdx);
    
    Tinv = invert(tforms(centerImageIdx));
    for i = 1:numel(tforms)    
        tforms(i).A = Tinv.A * tforms(i).A;
    end
    for i = 1:numel(tforms)           
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
    end

    maxImageSize = max(imageSize);

    xMin = min([1; xlim(:)]);
    xMax = max([maxImageSize(2); xlim(:)]);
    
    yMin = min([1; ylim(:)]);
    yMax = max([maxImageSize(1); ylim(:)]);

    width  = round(xMax - xMin);
    height = round(yMax - yMin);
    
    % Initialize
    panorama = zeros([height width 3], 'like', im2);
    blender = vision.AlphaBlender('Operation', 'Binary mask', ...
        'MaskSource', 'Input port');  

    xLimits = [xMin xMax];
    yLimits = [yMin yMax];
    panoramaView = imref2d([height width], xLimits, yLimits);
    
    % Create the panorama.
    I = im1;   
    warpedImage = imwarp(I, tforms(1), 'OutputView', panoramaView);            
    mask = imwarp(true(size(I,1),size(I,2)), tforms(1), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);

    I = im2; 
    warpedImage = imwarp(I, tforms(2), 'OutputView', panoramaView);
    mask = imwarp(true(size(I,1),size(I,2)), tforms(2), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);

    figure
    imshow(panorama)
    imwrite(panorama, output, "png");
end
