function filtered = wPngFilter(data, sSize)
XY = imresize(data,[sSize sSize]);
%focusLens = -10 * [0 -1 0; -1 5 -1; 0 -1 0];
complement = imcomplement(XY);
altered = XY*3;
altered = complement - altered;
%focused = imresize(convn(altered, focusLens), [sSize sSize]);
%filtered = uint8(altered -focused);
%filtered = uint8(conv2(altered, focusLens, 'same'));
filtered = altered;
end