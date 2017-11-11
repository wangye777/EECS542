clear
clc
img_dir = './VOC2012/JPEGImages/';
seg_dir = './VOC2012/SegmentationObject/';
seg_dir_ = './VOC2012/SegmentationClass/';
aug_dir = '\\engin-labs.m.storage.umich.edu\umwangye\windat.v2\Desktop\aug_data/image_aug/';
aug_lb_dir = '\\engin-labs.m.storage.umich.edu\umwangye\windat.v2\Desktop\aug_data/label_intance_aug/';
aug_lb_dir_ = '\\engin-labs.m.storage.umich.edu\umwangye\windat.v2\Desktop\aug_data/label_class_aug/';
img_name = dir([img_dir,'*.jpg']);
seg_name = dir([seg_dir,'*.png']);
seg_name_ = dir([seg_dir_,'*.png']);

for ind = 1 : size(seg_name,1)
    count = 0;
    disp([seg_name(ind).folder ,'\', seg_name(ind).name]);
    img = imread([img_name(1).folder ,'\', strcat(erase(seg_name(ind).name,'.png'),'.jpg')]);
    label = imread([seg_name(ind).folder ,'\', seg_name(ind).name]);
    label_ = imread([seg_name_(ind).folder ,'\', seg_name_(ind).name]);
    label(label==255) = 0;
    imwrite(img,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
    imwrite(label,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
    imwrite(label_,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
    count = count + 1;
    if round(rand)
        [o1,o2,o3] = flipimage(img,label,label_);
        imwrite(o1,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
        imwrite(o2,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
        imwrite(o3,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
        count = count + 1;
    end
    % different background color, 2 random new color (right?)
    rand_int_1 = [1 2 3];
    while rand_int_1 == [1 2 3]
        rand_int_1 = randperm(3);
    end
    rand_int_2 = rand_int_1;
    %     while rand_int_2 == rand_int_1 && rand_int_2 == [1 2 3]
    %         rand_int_2 = randperm(3);
    %     end
    img_1 = img;
    img_2 = img;
    for i = 1 : size(label,1)
        for j = 1 : size(label,2)
            for k = 1 : 3
                if label(i,j)==0
                    img_1(i,j,k) = img(i,j,rand_int_1(k));
                    img_1(i,j,k) = img(i,j,rand_int_1(k));
                end
            end
        end
    end
    imwrite(img_1,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
    imwrite(label,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
    imwrite(label_,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
    count = count + 1;
    if round(rand)
        [o1,o2,o3] = flipimage(img_1,label,label_);
        imwrite(o1,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
        imwrite(o2,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
        imwrite(o3,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
        count = count + 1;
    end
    %     imwrite(img_2,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
    %     imwrite(label,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
    %     imwrite(label_,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
    %     count = count + 1;
    % different resolution
    
    num_obj =  max(label(:));
    cen_obj = zeros(num_obj,2);
    area_obj = zeros(num_obj,1);
    for i = 1 : size(label,1)
        for j = 1 : size(label,2)
            for k = 1 : num_obj
                if label(i,j)==k
                    cen_obj(k,:) = cen_obj(k,:) + [i j];
                    area_obj(k) = area_obj(k)+1;
                end
            end
        end
    end
    cen_obj = cen_obj./repmat(area_obj,1,2);
    for i = 1 : num_obj
        rsl = round(1/(100/sqrt(area_obj(i)+1)-1));
        if rsl < 2
            rsl = 2;
        end
        for j = 1 : 2
            % need modify in the future(according to the real size of object)
            x = cen_obj(i,1);
            y = cen_obj(i,2);
            img_3_ = imcrop(img,[(x-(x-1)*(rsl+1-j)/(rsl+1)) (y-(y-1)*(rsl+1-j)/(rsl+1))...
                (x+(size(label,1)-x)*(rsl+1-j)/(rsl+1)) (y+(size(label,2)-y)*(rsl+1-j)/(rsl+1))]);
            img_3_lb_ = imcrop(label,[(x-(x-1)*(rsl+1-j)/(rsl+1)) (y-(y-1)*(rsl+1-j)/(rsl+1))...
                (x+(size(label,1)-x)*(rsl+1-j)/(rsl+1)) (y+(size(label,2)-y)*(rsl+1-j)/(rsl+1))]);
            img_3_lb_c_ = imcrop(label_,[(x-(x-1)*(rsl+1-j)/(rsl+1)) (y-(y-1)*(rsl+1-j)/(rsl+1))...
                (x+(size(label,1)-x)*(rsl+1-j)/(rsl+1)) (y+(size(label,2)-y)*(rsl+1-j)/(rsl+1))]);
            if size(img_3_)~=0
                img_3 = imresize(img_3_,[size(label,1) size(label,2)]);
                img_3_lb = imresize(img_3_lb_,[size(label,1) size(label,2)]);
                img_3_lb_c = imresize(img_3_lb_c_,[size(label,1) size(label,2)]);
                imwrite(img_3,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
                imwrite(img_3_lb,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
                imwrite(img_3_lb_c,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
                count = count + 1;
                if round(rand)
                    [o1,o2,o3] = flipimage(img_3,img_3_lb,img_3_lb_c);
                    imwrite(o1,[aug_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.jpg']);
                    imwrite(o2,[aug_lb_dir,strcat(erase(seg_name(ind).name,'.png'),'_'),num2str(count),'.png']);
                    imwrite(o3,[aug_lb_dir_,strcat(erase(seg_name_(ind).name,'.png'),'_'),num2str(count),'.png']);
                    count = count + 1;
                end
            end
        end
    end
    
end