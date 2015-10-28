function [seq]=mseq(connections,registers,len,a)
%***************************************************
% 此函数用来生成最大长度线性移位寄存器序列
% connections为特征多项式向量，registers为初始值向量
% len为所需序列长度，若为0则输出一个周期
% a为幅值
%***************************************************
m=length(connections);
L=2^m-1;     %周期长度
if len==0
    len=L;
end
fan=0;
seq= false(len,1);
for i=1:len
    %异或运算
    for j=1:m
        fan=fan +connections(j)*registers(j);
        fan=(mod(fan,2));
    end
    %寄存器移位
    registers(2:m)=registers(1:m-1);
    registers(1)=fan;
    seq(i)=logical(fan);
    fan=0;
end
seq=(seq*2-1)*a;