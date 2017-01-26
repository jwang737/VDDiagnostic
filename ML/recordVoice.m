function [ x, fs ] = recordVoice(t, fs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

recObj = audiorecorder(fs, 16, 1);
disp('Sing "Ahh"....')
pause(2)
disp('Start')
pause(1)
recordblocking(recObj, t);
pause(0.5)
disp('End of Recording.');
x = getaudiodata(recObj);

end

