matrix = zeros(20,20);
for i=1:size(per_obj_info,1);
    for j=1:20
        matrix(per_obj_info(i,2),j)=matrix(per_obj_info(i,2),j)+per_obj_info(i,6+j);
    end
end
for j=1:20
        matrix(per_obj_info(i,2),j)=matrix(per_obj_info(i,2),j)+per_obj_info(i,6+j);
    end