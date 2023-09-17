
function [fusion] = main(ImgIr, ImgVis,ImgSuper,FusionPath,c)


   src1=ImgSuper;
     if size(src1, 3)~=1
         src1  = rgb2gray(src1);
     end
 
    A=cell(1,2);
    A{1} = ImgVis;    %   Visible image
    A{2} = ImgIr;     %   Infrared image


    Lrr_img=cell(1,2); 
    Sal_img=cell(1,2);
    

      sigma2 = 3;

     parfor i = 1:2  
        Lrr_img{i} = interval_filtering(A{i},sigma2); 
        Sal_img{i} = A{i}-Lrr_img{i};
       
     end
 

    gray_img = im2gray(A{1});


    mean_val = mean2(gray_img);




 if c == 0

    gamma_value = mean_val*4;
    
    gamma_corrected = imadjust(Lrr_img{2}, [], [], gamma_value);
    
    weight1 = Visual_Weight_M1ap(Lrr_img{1});
    weight2 = Visual_Weight_M1ap(Lrr_img{2});

    Lrr =(0.5+0.5*(weight1-weight2)).*Lrr_img{1} + (0.5+0.5*(weight2-weight1)).*gamma_corrected; 
    [CAscore,CBscore] = Relevancy(A{1}, A{2});
  

    offset = 400*CAscore.*(0.5+0.5*(weight1-weight2))-400*CBscore.*((0.5+0.5*(weight2-weight1))) ;

    
 else
     
   

       weight2 = Visual_Weight_M1ap(Lrr_img{2});
      
       Lrr =(1-weight2).*Lrr_img{1} + (weight2).*Lrr_img{2};
      
     [CAscore,CBscore] = Relevancy(A{1}, src1);
       offset = 500*CAscore.*(1-weight2)-500*CBscore.*(weight2);

       
 end

     Weight = 0.5 + offset;
     Weight(Weight>1) = 1;
     Weight(Weight<0) = 0;


    Sal1 = Sal_img{1}.*(Weight)+Sal_img{2}.*((1-Weight));


    image = Lrr+Sal1; 
      fusion = max(min(image,255), 0);

    imwrite(fusion,FusionPath);
   

    end
