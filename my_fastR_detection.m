function fastR_corners = my_fastR_detection(rgb_im, image, output, fast_corners)
    threshold = 0.0002;

    sobel = [-1 0 1; -2 0 2; -1 0 1];
    gaus = fspecial('gaussian', 5, 1);
    dog = conv2(gaus, sobel);

    ix = imfilter(image, dog);
    iy = imfilter(image, dog');
    ix2g = imfilter(ix.*ix, gaus);
    iy2g = imfilter(iy.*iy, gaus);
    ixiyg = imfilter(ix.*iy, gaus);
    harcor = ix2g .* iy2g - ixiyg .* ixiyg - 0.05 * (ix2g + iy2g).^2;

    corners = harcor > threshold;
    fastR_corners = corners .* fast_corners;

    figure;
    imshow(rgb_im);
    hold on;
    [y, x] = find(fastR_corners);
    plot(x, y, 'g.');
    saveas(gcf, output);

end