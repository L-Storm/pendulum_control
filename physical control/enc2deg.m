function [otptEncoderDegs] = enc2deg(encoderInpt)
%ENC2DEG converts raw encnder readings to degreess. it handles wraparound +
%conversion. 

%constants 
encoderCPR = 4096;
conterBits = 32; 

%remove wraparound 
wraparoundThresh = 2^(conterBits-1);
encoderInpt(encoderInpt > wraparoundThresh) = encoderInpt(encoderInpt > wraparoundThresh) - 2^conterBits;

%convert to deg 
otptEncoderDegs = encoderInpt*360/encoderCPR;
end