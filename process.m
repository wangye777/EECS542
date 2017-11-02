list = importdata('val.txt');
gt = zeros(20,1);
tp = zeros(20,1);
union = zeros(20,1);
per_obj_info = [];%#ofimage(list#),class#,#of obj in that class,area,pixel_iou; 
cnt=1;
for i = 1 : size(list,1)
    name = list{i};
    disp(name);
    output = uint8(load(['./output/',name,'.txt']));
    label = imread(['./Label/',name,'.png']);
    objectlabel = imread(['./Objectlabel/',name,'.png']);
    objectlabel(objectlabel==255) = 0;
    max_o = max(objectlabel(:));
    for j = 1:20
        num = 0;
        gt_flag = (label==j);
        op_flag = (output==j);
        for k = 1:max_o
            oj = (objectlabel==k);
            ojtimesgt = gt_flag.*oj;
            num = num + 1;
            if sum(ojtimesgt(:))~=0
                tp_flag = (oj.*op_flag);
                interest = uint8(tp_flag).*output;
                interest = (interest(find(interest~=0)));
                pre_cls=[];
                for k = 1:20
                    pre_cls(k) = sum(interest==k);
                end
                gt_area = sum(oj(:));
                tp_area = sum(tp_flag(:));
                per_obj_info(cnt,:) = [i j num gt_area complexity(oj) tp_area/gt_area double(pre_cls)];
%                 per_obj_info(cnt,1) = i;
%                 per_obj_info(cnt,2) = j;
%                 per_obj_info(cnt,3) = num;
%                 per_obj_info(cnt,4) = gt_area;
%                 per_obj_info(cnt,5) = tp_area/gt_area;
                cnt = cnt + 1;
            end
        end
%         gt_flag = (label==j);
%         op_flag = (output==j);
%         tp_flag = (gt_flag.*op_flag);
%         u_flag = ((gt_flag+op_flag)>0);
%         gt(j) = gt(j) + sum(gt_flag(:));
%         tp(j) = tp(j) + sum(tp_flag(:));
%         union(j) = union(j) + sum(u_flag(:));
    
    end
end
% iou = tp./union;
% pix = tp./gt;
n = 400
m_iou = [];
[counts,centers] = hist(per_obj_info(:,5),n+1);
for i = 1 : n
    l = centers(i) - 0.5*(centers(i+1)-centers(i));
    r = centers(i) + 0.5*(centers(i+1)-centers(i));
    m_iou(i) = mean(per_obj_info(find(per_obj_info(:,5)>l&per_obj_info(:,5)<r),6));
end
plot(centers(1:n),m_iou,'*');  
grid on;



    