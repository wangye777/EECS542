test = [];
for i=1:1111
    test(i,:)=[fp_metrics{i,3} fp_metrics{i,4} fp_metrics{i,5} fp_metrics{i,7}];
end

n = 90
m_iou = [];
[counts,centers] = hist(test(:,4),n+1);
for i = 1 : n
    l = centers(i) - 0.5*(centers(i+1)-centers(i));
    r = centers(i) + 0.5*(centers(i+1)-centers(i));
    m_iou(i) = mean(test(find(test(:,4)>l&test(:,4)<r),1));
end
plot(centers(1:n),m_iou,'*');  
grid on;
hold on;
xlabel('average complexity');
ylabel('mean IOU');