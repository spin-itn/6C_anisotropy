function [dispersion0,co_coeff]=est_disp(fp,paz0,pwt0,pwr0)


% for i=1:length(fp)
% [a,z]=shift_corr(abs(paz0(i,:)),abs(pwt0(i,:)));
% paz0(i,:)=z;
% 
% end

num=0;
for ratio=0.2:0.1:0.95
    num=num+1;

for fre=1:1:length(fp)

z=abs(paz0(fre,:));
w=abs((pwt0(fre,:)));
w0=abs(pwr0(fre,:));


slip=1:length(z);

zp=z(slip);
wp=w(slip);

weigth=abs(zp/max(zp));

wp=sqrt(abs(wp.^2+w0.^2));

for ii=1:length(weigth)

    if weigth(ii)<ratio
    weigth(ii)=0;
    else
    weigth(ii)=1;
    end

end


fcr0(fre)=abs((sum((weigth.*wp.*zp))/sum(weigth.*wp.^2)));

A=corrcoef(weigth.*zp,weigth.*wp);
cor_R(fre)=A(1,2);

zp0(fre,:)=zp;
wp0(fre,:)=wp;

zpf(fre,:)=zp.*weigth;
wpf(fre,:)=wp.*weigth;


end


dispersion0(num,:)=fcr0;
co_coeff(num,:)=cor_R;

end



end