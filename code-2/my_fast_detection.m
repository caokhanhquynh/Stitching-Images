function corners = my_fast_detection(rgb_im, image, output)
    [rows, cols] = size(image);
    threshold = 0.4;

    % shifts for pixel
    shifts = [3 0; 0 3; -3 0; 0 -3];

    % image matrix for corners
    corners = zeros(rows, cols);

    for i = 1:size(shifts, 1)
        shifted_image = imtranslate(image, shifts(i, :));
        
        brighter_pixels = image - shifted_image > threshold;
        darker_pixels = image - shifted_image < -threshold;
        corners = 0 | (brighter_pixels | darker_pixels);
    end

    imshow(rgb_im);
    hold on;
    [y, x] = find(corners);
    plot(x, y, 'r.');
    saveas(gcf, output);

end