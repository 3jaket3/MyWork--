
B=400;
fc=1000;
H= [0.01:0.005:0.16];
f= ones(size(H));
fprintf('responce         frequency\n')
for k=1:1:length(H)
    
    f(k)=bess1(H(k),fc,B);
    fprintf('%f         %f\n',H(k),f(k))
end

plot(H,f)
ylabel('response')
xlabel('frequency')
title('frequency vs responce')
grid on
