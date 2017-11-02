function [ C_dist_min ] = complexity( input_args )
res_min = 2;
res_max = 60;

IM = int8(input_args);
IM_dilated = imdilate(IM,ones(3,3));
IM_boundary = int8(IM + IM_dilated == 1);

[bd_ind_col, bd_ind_row] = find(IM_boundary == 1);
num_bd_pt = size(bd_ind_col,1);

bd_ind = [bd_ind_col bd_ind_row zeros(num_bd_pt,1)];
% closed and single connected
seq_bd_ind = [];
% while 
% bd_ind(i,3) = 1;
% c_ind = bd_ind(i,1);
% r_ind = bd_ind(i,2);
% slct = bd_ind((bd_ind(:,1)<c_ind+2 & bd_ind(:,1)>c_ind-2 & bd_ind(:,2)==r_ind)...
%     | (bd_ind(:,2)<r_ind+2 & bd_ind(:,2)>r_ind-2 & bd_ind(:,1)==c_ind),:);
% slct_notin = slct(slct(:,3)==0,:);
% new_pos = find(bd_ind(:,1)==slct_notin(1,1) & bd_ind(:,2)==slct_notin(1,2));
% c_ind = bd_ind(i,1);
% r_ind = bd_ind(i,2);


center = [mean(bd_ind_col) mean(bd_ind_row)];
dist = sqrt(sum(([bd_ind_col bd_ind_row] - repmat(center,num_bd_pt,1)).^2,2));
C_dist = [];
for i = res_min:res_max
    [counts,centers] = hist(dist,i);
    p = counts/num_bd_pt;
    H_dist_norm = - sum(p.*log2(p))/log2(num_bd_pt);
    e_j_dist = sqrt(sum(min((repmat(centers,size(dist,1),1)-repmat(dist,1,i))...
        .^2,[],2))/size(dist,1));
    if i==2
        e_init_dist = e_j_dist;
    end
    e_j_dist_norm = e_j_dist/e_init_dist;
    C_dist(i) = H_dist_norm + e_j_dist_norm;
end
C_dist_min = min(C_dist(2:end));

