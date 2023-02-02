function [Azi]=est_azimuth(fp,pwx,pwy,ratio)



for fre=1:1:length(fp)

z=real(pwx(fre,:));
w=real((pwy(fre,:)));


slip=1:length(z);

zp=z(slip);
wp=w(slip);

weigth=abs(zp/max(zp));


for ii=1:length(weigth)

    if weigth(ii)<ratio
    weigth(ii)=0;
    else
    weigth(ii)=1;
    end

end


Azi(fre)=atan(((sum((weigth.*wp.*(-zp)))/sum(weigth.*wp.^2))))*180/pi;


end



end