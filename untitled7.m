list = importdata('val.txt');
gt = zeros(20,1);
tp = zeros(20,1);
union = zeros(20,1);
per_obj_info = [];%#ofimage(list#),class#,#of obj in that class,area,pixel_iou; 
cnt=1;
comp=[]
for i = 1372
    
    name = list{i};
    disp(name);
    output = uint8(load(['./output/',name,'.txt']));
    label = imread(['./Label/',name,'.png']);
    objectlabel = imread(['./Objectlabel/',name,'.png']);
    objectlabel(objectlabel==255) = 0;
    max_o = max(objectlabel(:));
        for k = 1
            oj = (objectlabel==k);
            complexity(oj)
            imshow(uint8(oj)*256);
        end
    
end

%116,1

%1372,1

%,71,4





    