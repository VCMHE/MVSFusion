
function [ca,cb] = Relevancy(img1,img2)

AImg = padarray(img1,[7,7],'symmetric','both');
BImg = padarray(img2,[7,7],'symmetric','both');


[M,N]= size(AImg);



i = 1:M-15+1;
j = 1:N-15+1;
[I,J] = meshgrid(i,j); 
parfor i = 1:numel(I)  
       
        A1 = AImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        B1 = BImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );

          Cascore(i) =metricsSpatial_frequency(A1);
          Cbscore(i) =metricsSpatial_frequency(B1);
         
end

cbscore = reshape(Cbscore,length(j),length(i));
cb = transpose(cbscore);
cascore = reshape(Cascore,length(j),length(i));
ca = transpose(cascore);

end