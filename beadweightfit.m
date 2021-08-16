% bead fit with weight average.

% function [centR,centC] = beadweightfit(frames,sigma)
function [centR,centC] = beadweightfit(movobj,sigma)

if nargin==1, sigma = 5; end %�����ж�������������ĺ��� sigma��ָ����ֵ
nframes=movobj.NumberOfFrames;

% nframes = length(frames);
centR = zeros(nframes,1);
centC = zeros(nframes,1);

% matlabpool %��������
parfor i = 1:nframes
%     frames(:,:,i)=255-frames(:,:,i);
    frames =read(movobj,i); 
    frame=frames(:,:,1);
    Z = frame-min(min(frame))-(max(max(frame))-min(min(frame)))/sigma;
    [R, C] = find(Z~=0);
    Z = double(Z(Z~=0));
    centR(i) = sum(R.*Z)/sum(Z);
    centC(i) = sum(C.*Z)/sum(Z);
end
% matlabpool close
