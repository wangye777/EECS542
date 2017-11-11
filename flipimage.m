function [ output_args1 ,output_args2 ,output_args3  ] = flipimage( input_args1,input_args2,input_args3)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
out1 = input_args1;
out2 = input_args2;
out3 = input_args3;
if round(rand)
    for i = 1:size(input_args1,2)
        j = size(input_args1,2)+1-i;
        out1(:,i,:) = input_args1(:,j,:);
        out2(:,i,:) = input_args2(:,j,:);
        out3(:,i,:) = input_args3(:,j,:);
       
    end
else
    for i = 1:size(input_args1,1)
        j = size(input_args1,1)+1-i;
        out1(i,:,:) = input_args1(j,:,:);
        out2(i,:,:) = input_args2(j,:,:);
        out3(i,:,:) = input_args3(j,:,:);
        
    end
end
output_args1 = out1;
output_args2 = out2;
output_args3 = out3;
end

