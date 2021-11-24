bd=double(0);
bi=double(0);
b2=double(0);
b1=double(0);
path='/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Selected_big_blob_Extracted/';%data path
save_path='/DATA/Sanjay/data_from_aryabhutt_hostel_Silhouette_frames_Selected_big_blob_Extracted_Centered/'; % path where to save new frames after synthesized
list = dir(path);
fName = {list.name};
[~,y]=size(fName);
c=0;
% sumimage=double(zeros(250,200));
for f_no=3:y
    c=c+1;
    listin = dir(char(strcat(path,fName(f_no),'/')));
    fNamein = {listin.name};
    [~,y1]=size(fNamein);
    fName(f_no)
    for ff_no=3:y1
        listinin = dir(char(strcat(path,fName(f_no),'/',fNamein(ff_no),'/')));
        fNameinin = {listinin.name};
        [~,y2]=size(fNameinin);
        path2=char(strcat(path,fName(f_no),'/',fNamein(ff_no),'/'));
        fNamein(ff_no)
        for fff_no=3:y2
            path6=char(strcat(path2,fNameinin(fff_no)));
            x = [];
            y = [];
            img=imread(path6);
            %size(img)
            image1 = img;
            image1=imresize(image1,0.3);
            [j k]=size(image1);
            
            for xx=1:j
                for yy=1:k
                    if image1(xx,yy)>0
                        x=[x xx];
                        y=[y yy];
                    end
                end
            end
            x_maxp=max(x);
            x_minp=min(x);
            y_maxp=max(y);
            y_minp=min(y);
            yy1_minp = (y_minp/30)*100-1;
            %y_minp
            %yy1_minp
            xx1_minp = (x_minp/30)*100-1;
            %x_minp
            %xx1_minp            
            yy2_mp = ((y_maxp-y_minp)/30)*100+1;
            %(y_maxp-y_minp)
            %yy2_mp
            xx2_mp = ((x_maxp-x_minp)/30)*100+1;
            %(x_maxp-x_minp)
            %xx2_mp
            A= [yy1_minp xx1_minp yy2_mp xx2_mp];   
            img=imcrop(img,A);
            [b1,b2]=size(img);
            bd=720-b1;
            b1=b1+bd;
            bd=bd/720;
            bi=b2*bd;
            b2=round(b2+bi);
            if (b1>0)&&(b2>0)
                img=imresize(img,[b1 b2]);
            end
            %             figure,
            %             imshow(img);
            result=zeros(720,720);
            [j,k]=size(img);
            jj=360-round(j/2)-1;
            kk=360-round(k/2)-1;
            for x=1:j
                for y=1:k
                    if ((x+jj)>0)&&((y+kk)>0)
                        result(x+jj,y+kk)=img(x,y);
                    end
                end
            end
            max1=max(result(:));
            result=result/max1;
            result=imresize(result,[256 256]);
            if ~exist(char(strcat(save_path,fName(f_no),'/',fNamein(ff_no),'/')),'dir')
                mkdir(char(strcat(save_path,fName(f_no),'/',fNamein(ff_no),'/')));
            end
            imwrite(result,char(strcat(save_path,fName(f_no),'/',fNamein(ff_no),'/',fNameinin(fff_no))));
        end
    end
end
