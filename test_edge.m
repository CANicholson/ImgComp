clear all;
I = imread('U:\com_vision\Images\test_model\sun_bzlmgeqekovfaecg.jpg');



thr = 5;
sig = 2;
    
BW = edge(rgb2gray(I),'canny',thr/255,sig);



[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);

imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal;
hold on;

P  = houghpeaks(H,5);
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');


lines = houghlines(BW,T,R,P);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


function edw = edgepixel(img)
%%%Calculate number of pixel of edges
    thr = 10;
    sig = 2;
    
    ed = edge(rgb2gray(img),'canny',thr/255,sig);
    
    [H,T,R] = hough(ed,'RhoResolution',0.5,'Theta',-90:0.5:89);
    
    
    figure(1), hold on;
    subplot(1,3,1), imshow(img);
    subplot(1,3,2), imshow(ed);
    subplot(1,3,3);
    imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
    title('Hough transform of gantrycrane.png');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal;
    hold off;
    
    ed = imhist(ed); 
    ed = ed./sum(ed(:)); %% normalisation
    edw = ed(2);
end