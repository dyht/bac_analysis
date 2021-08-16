function out=run_ave(data,wind)
windowSize=wind;
out=filter(ones(1,windowSize)/windowSize,1,data);
