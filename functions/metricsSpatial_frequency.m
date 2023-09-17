% The source code is from the Internet
% The interface is modified by the authors of VIFB to integrate it into VIFB. 
%
% Reference for the metric:
% A. M. Eskicioglu and P. S. Fisher, ��Image quality measures and their performance,�� IEEE Transactions on
% communications, vol. 43, no. 12, pp. 2959�C2965, 1995.

function res = metricsSpatial_frequency(fused) %�޲ο�ָ��
 
    fused=double(fused);
    
    [m,n]=size(fused);
    RF=0;
    CF=0;
    
    for fi=1:m
        for fj=2:n
            RF=RF+(fused(fi,fj)-fused(fi,fj-1)).^2;%��Ƶ��
        end
    end

    RF=RF/(m*n);

    for fj=1:n
        for fi=2:m
            CF=CF+(fused(fi,fj)-fused(fi-1,fj)).^2;%��Ƶ��
        end
    end

    CF=CF/(m*n);%�ܵ���˵������ÿ�����ص���Ƶ�ʺ���Ƶ�ʵĲ�

    res=sqrt(RF+CF);