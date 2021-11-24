path1 = '/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Centered/';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
savePath = '/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Centered_Alinged/';
rImage = double(imread('/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Centered/333/MVI_1019/image0252.jpg'));
max1 = max(rImage(:));
rImage = rImage/max1;
rImage = imcrop(rImage,[1 1 200 50]);
y1
for f_no=126:y1
    list2 = dir(char(strcat(path1,fName1(f_no),'/')));
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=3:y2
        list3 = dir(char(strcat(path1,fName1(f_no),'/',fName2(ff_no),'/')));
        fName3 = {list3.name};
        [~,y3]=size(fName3);
        fName2(ff_no)
        for fff_no=3:y3
            
            img1 = double(imread(char(strcat(path1,fName1(f_no),'/',fName2(ff_no),'/',fName3(fff_no)))));
            img1 = double(imresize(img1,[200 200]));
            max1 = max(img1(:));
            img1 = img1/max1;
            img_1 = imcrop(img1,[1 1 200 50]);
            temp1 = 0.0;
            shift = 0;
            for number2=1:131
                img = imtranslate(img_1,[-66+number2, 0]);
                v = corr2(img,rImage);
                max2 = v;
                if temp1 < max2
                    temp1 = max2;
                    shift = number2-66;
                end
            end
            %                 shift
            img2 = imtranslate(img1,[shift, 0]);
            if ~exist(char(strcat(savePath,fName1(f_no),'/',fName2(ff_no),'/')),'dir')
                mkdir(char(strcat(savePath,fName1(f_no),'/',fName2(ff_no),'/')));
            end
            %arr = split(fName4(ffff_no),'.');
            imwrite(img2,char(strcat(savePath,fName1(f_no),'/',fName2(ff_no),'/',fName3(fff_no))));
            
        end
    end
end