clear all,close all

win1=150;    % t(s)
win2=1300; % t(s)
% read the data 

X = rdmseed('./Rot_z.mseed');

wz0 = cat(1,X.d);
X = rdmseed('./Rot_x.mseed');
wx0 = cat(1,X.d);
X = rdmseed('./Rot_y.mseed');
wy0 = cat(1,X.d);

X = rdmseed('./Tra_z.mseed');
az0 = cat(1,X.d);
X = rdmseed('./Tra_x.mseed');
ax0 = cat(1,X.d);
X = rdmseed('./Tra_y.mseed');
ay0 = cat(1,X.d);
t0 = cat(1,X.t);

nt=length(t0);
dt=0.025;
t=(0:nt-1)*dt;

% decrease sampling
nt0=10;


ax=ax0(1:nt0:end);
ay=ay0(1:nt0:end);
az=az0(1:nt0:end);

wx=wx0(1:nt0:end);
wy=wy0(1:nt0:end);
wz=wz0(1:nt0:end);

dt=dt*nt0;
nt=length(ax);
t=(0:nt-1)*dt;
% plot
scale=1e-5;
scale1=1e-8;


t_slip=round((1:3000)/dt);



% cut window


indx1=round(win1/dt);
indx2=round(win2/dt);

ax1=ax(indx1:indx2);
ay1=ay(indx1:indx2);
az1=az(indx1:indx2);

wx1=wx(indx1:indx2);
wy1=wy(indx1:indx2);
wz1=wz(indx1:indx2);

nt=length(ax1);
t=(0:nt-1)*dt;
scale=1e-3/1.5;
scale1=1e-9/1.;

% % correlation coefficient
% 
figure('Color','wh')
slip=(1:round(win2-win1)/dt);
%
cR=corrcoef(wy1(slip),az1(slip));
cL=corrcoef(wz1(slip),ay1(slip));

subplot(211)
hold on
h1=plot(t(slip),ay1(slip)/max(abs(ay1)),'k-',LineWidth=1.1);
h2=plot(t(slip),wz1(slip)/max(abs(wz1)),'r-',LineWidth=1.1);
xlabel('t(s)','FontSize',15);
ylabel('Normalized Amp','FontSize',15);
s=sprintf('Corr=%.4f',abs(cL(1,2)));
text(30,0.5,s,'FontSize',15);
box on;grid on;axis tight;
legend([h1,h2],'At','Rz','fontsize',18);
set(gca,'fontsize',15,'FontWeight','normal');

subplot(212)
hold on
h1=plot(t(slip),az1(slip)/max(abs(az1)),'k-',LineWidth=1.1);
h2=plot(t(slip),-wy1(slip)/max(abs(wy1)),'r-',LineWidth=1.1);
xlabel('t(s)','FontSize',15);
ylabel('Normalized Amp','FontSize',15);
s=sprintf('Corr=%.4f',abs(cR(1,2)));
text(30,0.5,s,'FontSize',15);
box on;grid on;axis tight;
legend([h1,h2],'Az','Rt','fontsize',18);
set(gca,'fontsize',15,'FontWeight','normal');


% extract dispersion
% parameters 
fs=1/dt;               % frequency sampling
fp=1./[1:1:600];
wcf=1.1;               % wavelet centrel frequency (unit:Hz)(recommend: 1~3)


% cwt

paz=cwt_cmor(az1,1,wcf,fp,fs);
pwt=cwt_cmor(wy1,1,wcf,fp,fs);
pwr=cwt_cmor(wx1,1,wcf,fp,fs);

tempx=paz*0;

for i=1:length(fp)
    tempx(i,:)=max(abs(pwt(i,:)));
end

figure('Color','wh');


paz0=paz;
paz1=paz;

pwt0=pwt;
pwt1=pwt;

pwr0=pwr;
% pwr1=pwr;



for i=1:10:length(fp)
    hold on
h1=plot(t,real(paz(i,:))/max(max(abs((paz(i,:)))))*11+i,'k-','LineWidth',1.0);
h2=plot(t,-real(pwt(i,:))/max(max(abs((pwt(i,:)))))*11+i,'r-','LineWidth',1.0);
end
box on;grid on; axis tight;
xlabel('t(s)');
ylabel('Period(s)');
legend([h1,h2],'Acceleration(Az)','Rotation(Rt)','fontsize',15)
set(gca,'fontsize',13,'FontWeight','normal');
% axis([0 1100 0 350])




%%
clear cursor_info1 cursor_info2
figure('Color','wh');
pcolor(abs(pwt)./tempx);

shading interp 
colormap("turbo");
xlabel('t(s)');
ylabel('Period(s)');
set(gca,'fontsize',18,'FontWeight','normal');
paz0=paz;
paz1=paz;

pwt0=pwt;
pwt1=pwt;
pwr0=pwr;





%%
for i=1:length(cursor_info1(:))
    st2=cursor_info1(i).Position(1);
    st1=cursor_info1(i).Position(2);
    

    
%     paz1(st1:end,1:st2)=0;
%     pwt1(st1:end,1:st2)=0;
    paz0(1:st1,st2:end)=0;
    pwt0(1:st1,st2:end)=0;
    pwr0(1:st1,st2:end)=0;



%     paz0(1:st1,st2:end)=0;

%     pwt0(1:st1,st2:end)=0;
%     pwr0(1:st1,st2:end)=0;

   
end



for i=1:length(cursor_info2(:))
    st2=cursor_info2(i).Position(1);
    st1=cursor_info2(i).Position(2);

%     paz0(1:st1,1:st2)=0;
%     pwt0(1:st1,1:st2)=0;
%     pwr0(1:st1,1:st2)=0;
    paz0(st1:end,1:st2)=0;
    pwt0(st1:end,1:st2)=0;
    pwr0(st1:end,1:st2)=0;
   
end

%

figure('Color','wh');
% subplot(211)
pcolor(t,1./fp,abs(paz0)/max(max(abs(paz0(:)))));
shading interp 
colormap("turbo");
xlabel('t(s)');
ylabel('Period(s)');
set(gca,'fontsize',18,'FontWeight','normal');

%%

clear dispersion0 dispersion1 Azi


[dispersion0,co_coeff]=est_disp(fp,paz0,pwt0,pwr0);


clear v_mean temp v_var
figure('Color','wh')
for i=1:length(fp)
   
    v_mean(i)=mean(dispersion0(:,i));
    temp=sum((dispersion0(:,i)-v_mean(i)).^2)/(length(dispersion0(:,i))-1);
    v_var(i)=sqrt(temp);
end

slip=1:9:length(fp);
hold on
errorbar(1./fp(slip),v_mean(slip)/1000,v_var(slip)/1000,'k-o','LineWidth',1.2,'MarkerSize',1);
axis([50 550  3.8 6.3])
set(gca,'fontsize',18,'FontWeight','normal');

xlabel('Period(s)');
ylabel('Phase velocity(km/s)');
box on;
grid on;
load PREM_disp.mat
h1=plot(1./f0,v0./1000,'r-','LineWidth',2);


%
figure('Color','wh')
[Azi]=est_azimuth(fp,pwr0,pwt0,0.01);
hold on
plot(1./fp(slip),Azi(slip),'o-','markersize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
xlabel('Period(s)');
ylabel('BackAzimuth deviation(deg)');
set(gca,'Fontsize',15);
box on;
grid on;
axis([80 400  -10 10])


