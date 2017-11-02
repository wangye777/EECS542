
list = importdata('val.txt');
gt = zeros(20,1);
tp = zeros(20,1);
union = zeros(20,1);
per_obj_info = {};%#ofimage(list#),class#,#of obj in that class,area,pixel_iou; 
cnt=1;
fp = 1;
for i = 1 : size(list,1)
    name = list{i};
    disp(name);
    output = uint8(load(['./output/',name,'.txt']));
    label = imread(['./Label/',name,'.png']);
    objectlabel = imread(['./Objectlabel/',name,'.png']);
    objectlabel(objectlabel==255) = 0;
    max_o = max(objectlabel(:));
    cplxt = 0.0;
        for k = 1:max_o
            oj = (objectlabel==k);
            cplxt = cplxt+complexity(oj);
        end
     cplxt=double(cplxt/double(max_o));
%         gt_flag = (label==j);
%         op_flag = (output==j);
%         tp_flag = (gt_flag.*op_flag);
%         u_flag = ((gt_flag+op_flag)>0);
%         gt(j) = gt(j) + sum(gt_flag(:));
%         tp(j) = tp(j) + sum(tp_flag(:));
%         union(j) = union(j) + sum(u_flag(:));
    
 %   per_obj_info{i}.complexity = cplxt;
 %   per_obj_info{i}.name = name;
 if name == fp_metrics{fp,2}
     fp_metrics{fp,7}=cplxt;
     fp =fp +1;
 end
     
end
% iou = tp./union;
% pix = tp./gt;




    