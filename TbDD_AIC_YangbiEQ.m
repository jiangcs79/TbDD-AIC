clc
clear all
close all

%------Parameters that need to be updated -----------------

%------for Yangbi aftershock sequence. start---------------------
cat=load('Cat_aftershock_YangbiEQ.txt');

t0= datenum(2021,05,18,08,00,00);
t1= datenum(2021,05,26,15,30,00);

time0=datenum(cat(:,1),cat(:,2),cat(:,3),cat(:,4),cat(:,5),cat(:,6));
ik=find(time0<t1 & time0>t0 & cat(:,7)>99.7 & cat(:,7)<100.15 & cat(:,8)>25.45 & cat(:,8)<25.83);
time=time0(ik);
cat1=[time,cat(ik,9)];
%------for Yangbi aftershock sequence. end---------------------


% %-----for Syntehtic catalog. start-------------------------------
%  cat=load('SynCat_test.txt');
% 
% t0=datenum(2021,04,01,00,00,00);
% t1=datenum(2021,06,01,00,00,00);
% 
% time=cat(:,1);
% cat1=cat(find(time<=t1 & time>=t0),:);
%-----for Syntehtic catalog. end-------------------------------

%------------------------------------------------------------------------

node0=1:25;
randthrow= 1000;

%------------------------------------------------------------------------
%-------Calculate the b-value using data-driven algorithm 
%------------------------------------------------------------------------
tlen= t1-t0;
modelnum=0;
for nd=1:size(node0,2)
    nd
    node=node0(nd);
    modelnum=0;
    tnode1=[];
    while modelnum< randthrow
        tnode=[]; zz=[];
        tnode= [0; sort(rand(node,1)); 1].*tlen+t0; 
        for jj=1:length(tnode)-1
            zz(jj)= length(find(time>tnode(jj) & time<tnode(jj+1)));
        end
        zzn=length(find(zz>=20));
        if zzn==length(tnode)-1
            tnode1=[tnode1; tnode'];
        end
        modelnum= size(tnode1,1);
    end
    ttnode{nd} = tnode1;
end


parfor nd=1:size(node0,2)
    node=node0(nd);
    tnode1=ttnode{nd};
    for k=1: randthrow    
        k
        %-----------------------------------------------------------
        MLtotal=0; seedNum=0;
        for i=1:node+1
            %         clear cat in para0 fval ML;
            cat=0; para0=0; fval=0; ML=0;
            cat= cat1(find(time>tnode1(k,i) & time<tnode1(k,i+1)), :);
            seedNum = seedNum+1;     
            %--------------------------------------------------------
            x0 = [1.7, -0.1, 0.2];  %³õÖµ²Â²â
            LB = [log(10)*0.1,min(cat(:,2)),0.01]; UB = [log(10)*10.0, max(cat(:,2)), 2]; %²ÎÊý·¶Î§
            [para0,fval] = fminsearchbnd(@(x)LLFun(x,cat(:,2)),x0,LB,UB);
            ML = -1* LLFun(para0,cat(:,2)) ; %Log Likelihood value
            MLtotal=MLtotal+ML;
            
            result{nd,k}.voriresult{seedNum}.ML=ML;
            result{nd,k}.voriresult{seedNum}.core=[tnode1(k,i)  tnode1(k,i+1)];
            result{nd,k}.voriresult{seedNum}.para0=para0;    
        end
        result{nd,k}.seedNum=seedNum;
        result{nd,k}.MLtotal=MLtotal;  

         result{nd,k}.AIC=-2.*MLtotal+(seedNum*5)*2;  
    end
end

 save KKresult_1000times_25nodes.mat result;

%------------------------------------------------------------------------
%------Drawing of the result picture --------------------------
%------------------------------------------------------------------------
time=cat1(:,1);
tlen= t1-t0;
%-----------------------------------------------------------

seedN=[]; AIC=[]; MLtotal=[];
for i=1:size(node0,2)
    for j=1 : randthrow
        seedN=[seedN; result{i,j}.seedNum];
        AIC=[AIC; result{i,j}.AIC];
        MLtotal = [MLtotal; result{i,j}. MLtotal];
    end
end

bestNUM=size(node0,2)*randthrow*0.05;

sortAIC= sort(AIC,'ascend');
threholdAIC=sortAIC(bestNUM);

%================================================================
figure(1)
axes('position',[.1 .1 .28 .705],'tickdir','out')
box on;
hold on 
plot(seedN, AIC, 'k.','color',[.7 .7 .7])

AICseed=seedN(find(AIC~=-inf & AIC~=inf));
MLseed=seedN(find(MLtotal~=-inf & MLtotal~=inf));
AIC=AIC(find(AIC~=-inf & AIC~=inf));
MLtotal=MLtotal(find(MLtotal~=-inf & MLtotal~=inf));


CB=[];
for i=node0+1
    kk=0;
    kk=find(AICseed>i-0.05 & AICseed<i+0.05);
    CB=[CB mean(AIC(kk))];
    plot(i, mean(AIC(kk)),'mo','markersize',3)
    plot([i-0.2 i+0.2],[mean(AIC(kk))-std(AIC(kk))  mean(AIC(kk))-std(AIC(kk))],'m-')
    plot([i-0.2 i+0.2],[mean(AIC(kk))+std(AIC(kk))  mean(AIC(kk))+std(AIC(kk))],'m-')
    plot([i i],[mean(AIC(kk))-std(AIC(kk))  mean(AIC(kk))+std(AIC(kk))],'m-')
    
end

plot(node0+1,CB,'m-')
plot([node0(1)+1,node0(end)+1],[threholdAIC,threholdAIC],'k--')
xlim([0,node0(end)+1])
set(gca,'xtick',[0:5:25])

xlabel('Time segment')
ylabel('AIC')

%=========================================================
%=========================================================
bound =[];
core=[];
pararesult=[];
rr=0;

for i=1:size(node0,2)
    for j=1 : randthrow

    if result{i,j}.AIC<=threholdAIC
        for cellNUM = 1 : result{i,j}.seedNum
            if  result{i,j}.voriresult{1, cellNUM}.ML ~=-inf &  result{i,j}.voriresult{1, cellNUM}.ML~=inf
                rr=rr+1;
                core{rr}=[result{i,j}.voriresult{1, cellNUM}.core];
                pararesult{rr}=[result{i,j}.voriresult{1, cellNUM}.para0];
            end
        end
      
    end
end
end

X =[t0 : 0.01: t1];

node_matrx=zeros(size(X));
std_beta_matrx=zeros(size(X));
std_sigma_matrx=zeros(size(X));
std_mu_matrx=zeros(size(X));
mean_beta_matrx=zeros(size(X));
mean_sigma_matrx=zeros(size(X));
mean_mu_matrx=zeros(size(X));

iqr_beta_matrx=zeros(size(X));
iqr_sigma_matrx=zeros(size(X));
iqr_mu_matrx=zeros(size(X));
median_beta_matrx=zeros(size(X));
median_sigma_matrx=zeros(size(X));
median_mu_matrx=zeros(size(X));

for i= 1:size(X,2)
    beta_temp=[];
    mu_temp=[];
    sigma_temp=[];
    for j = 1:  length(core)
        if X(i)>=core{1,j}(:,1) & X(i)<core{1,j}(:,2)
            beta_temp=[beta_temp; pararesult{1,j}(:,1)];
            mu_temp=[mu_temp; pararesult{1,j}(:,2)];
            sigma_temp=[sigma_temp; pararesult{1,j}(:,3)];
        end
    end
    median_beta_matrx(i)=median(beta_temp);
    median_sigma_matrx(i)=median(sigma_temp);
    median_mu_matrx(i)=median(mu_temp);    
    iqr_beta_matrx(i)=abs(prctile(beta_temp,25)-prctile(beta_temp,75));
    iqr_sigma_matrx(i)=abs(prctile(sigma_temp,25)-prctile(sigma_temp,75));
    iqr_mu_matrx(i)=abs(prctile(mu_temp,25)-prctile(mu_temp,75));
end
 
 mean_mu_matrx =  median_mu_matrx;
 mean_sigma_matrx =  median_sigma_matrx;
 mean_beta_matrx =  median_beta_matrx;

 mean_beta_matrx =  median_beta_matrx ./log(10);

 iqr_beta_matrx=  iqr_beta_matrx ./log(10);
 iqr_beta_matrx=  iqr_beta_matrx./2;

% %-----------------------------------------------------------
figure(2)
axes('position',[.15 .15 .64 .32],'tickdir','out')

box on
hold on

stdbound(1: length(mean_beta_matrx)) = mean_beta_matrx- iqr_beta_matrx;
AB = mean_beta_matrx + iqr_beta_matrx;
stdbound(length(mean_beta_matrx)+1 : length(mean_beta_matrx)+ length(mean_beta_matrx)) = AB (length(mean_beta_matrx):-1: 1);
fill([t0:0.01:t1,t1: -0.01: t0], stdbound,'c')

plot(t0:0.01:t1, mean_beta_matrx,'k-','linewidth',2)

%2021-05-21	21:48:35.00	25.700	99.880	10	Ms	6.5	YangbiEQ
ori=datenum(2021,05,21,21,48,35.00);
plot([ori ori],[0.0 1.5],'--r');

xlabel('Date [month/day]')
ylabel('b value')
% 
axis([t0, t1, 0.0,1.5])
dateaxis('x',6)

%----------------------------------------------------------

