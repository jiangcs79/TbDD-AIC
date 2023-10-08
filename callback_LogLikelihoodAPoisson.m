function [fProbability] = callback_LogLikelihoodAPoisson(fAValue, mCatalog, belta, mu, sigma);
% Determine the limits of calculation
fMinMag_ = min(mCatalog(:,1));
fMaxMag_ = max(mCatalog(:,1));

vCnt_ = (fMinMag_:0.1:fMaxMag_+0.1)'; % Add one more magnitude bin for later use of diff()
% Compute the cumulative FMD

n=0;
syms t
for x=fMinMag_:0.1:fMaxMag_
n=n+1;
g(n)=normcdf(x,mu,sigma);
f(n)=fAValue*exp(-belta*x);
end

% Determine the number of events in each magnitude bin
mPredictionFMD_ = f.*g
% Create the FMD for the period of observation
vObservedFMD_ = hist(mCatalog(:,1), fMinMag_:0.1:fMaxMag_);  
% Calculate the likelihoods for both of the models
vProb_ = calc_log10poisspdf(vObservedFMD_', mPredictionFMD_');
% Return the values (multiply by -1 to return the lowest value for the highest probability
fProbability = (-1) * sum(vProb_);
end
