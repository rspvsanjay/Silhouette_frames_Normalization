path1 = '/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Selected/';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1] = size(fName1);
path1
y1

save_path = '/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Selected_big_blob_Extracted/';
for f_no=116:y1
    path2 = char(strcat(path1,fName1(f_no),'/'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2] = size(fName2);
    fName1(f_no)
    for ff_no=3:4%3:y2
        path3 = char(strcat(path2,fName2(ff_no),'/'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3] = size(fName3);
        fName2(ff_no)
        for fff_no=3:y3
            path4 = char(strcat(path3,fName3(fff_no)));
            image = imread(path4);
            max1 = max(image(:));
            image = image/max1;
            image = image==1;
            im=image;
            length1 = length(nonzeros(im));
            
            if length1>10000
                outim1 = zeros(size(im));
                outim2 = zeros(size(im));
                outim3 = zeros(size(im));
                outim4 = zeros(size(im));
                outim = bwlargestblob(im,4);
                outim1 = outim;
                im = double(im) - double(outim);
                im = im==1;
                length1 = length(nonzeros(im));
                
                if length1>1000
                    outim = bwlargestblob(im,4);
                    outim2 = outim;
                    im = double(im) - double(outim);
                    im = im==1;
                end
                %             length1 = length(nonzeros(im));
                %             length1
                %             if length1>1000
                %                 outim = bwlargestblob(im,4);
                %                 outim3 = outim;
                %                 im = double(im) - double(outim);
                %                 im = im==1;
                %             end
                length1 = length(nonzeros(im));
                
                if length1>1000
                    outim = bwlargestblob(im,4);
                    outim4 = outim;
                end
                outim = double(outim1)+double(outim2)+double(outim3)+double(outim4);
                outim = 255*outim;
%                 figure,imshow(outim)
                if ~exist(char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/')),'dir')
                    mkdir(char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/')));
                end
                imwrite(outim,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/',fName3(fff_no))));
            end
        end
    end
end

function [outim] = bwlargestblob(im,connectivity)
%
% 'bwlargestblob' reads in a 2-d binary image and outputs a binary image, retaining only the largest blob.
%
% Usage: [outim] = bwlargestblob(im,connectivity)
%
% im - 2-d binary image
% conenctivity - Accepts 4/8 connectivity
% outim - Output binary image (with 1s and 0s)
%
% Example:
%
% im = imread('text.png');
% outim = bwlargestblob(im,8);
% figure;
% subplot(1,2,1); imshow(im);
% subplot(1,2,2); imshow(255*outim);
if size(im,3)>1,
    error('bwlargestblob accepts only 2 dimensional images');
end
[imlabel totalLabels] = bwlabel(im,connectivity);
sizeBlob = zeros(1,totalLabels);
for i=1:totalLabels
    sizeblob(i) = length(find(imlabel==i));
end
[maxno largestBlobNo] = max(sizeblob);
outim = zeros(size(im),'uint8');
outim(find(imlabel==largestBlobNo)) = 1;
end