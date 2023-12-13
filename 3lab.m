clear all
close all
clc

x=0.1:(1/22):1;%funkcijos x reiksmiu vektorius

d=(1+0.6*sin(2*pi*x/0.7))+0.3*sin(2*pi*x)/2;%pradine funkcija(desired output)

% Rankiniu budu parenku apskritimu centrus(pagal pradines f-jos islinkius) ir spindulius
c_1=0.2;%parinkus centrus betkaip, RBF aproksimuoja prastai
r_1=0.2;%spindulius parenku pagal f-jos islinkiu dydi
c_2=0.9;
r_2=0.2;
%inicializuoju pradinius svorius
w_1=randn(1);%pirmo RBF svoris
w_2=randn(1);%antro RBF svoris
w_0=randn(1); %bias 

eta=0.01;%mokymo zingsnis


%mokymas
for j=1:100000
    for i=1:length(x)
       
        phi1=exp(-(x(i)-c_1)^2/(2*r_1^2));%1-ojo RBF isejimas prie c1 ir r1
        phi2=exp(-(x(i)-c_2)^2/(2*r_2^2));%2-ojo RBF isejimas prie c2 ir r2
        
        y=w_1*phi1+w_2*phi2+w_0;%tinklo isejimas tiesiskai priklauso nuo RBF isejimu
        
        % atnaujinu svorius kiekviena iteracija
        w_1=w_1+eta*(d(i)-y)*phi1;%atnaujintas pirmo RBF svoris
        w_2=w_2+eta*(d(i)-y)*phi2;%atnaujintas antro RBF svoris
        w_0=w_0+eta*(d(i)-y);%tinklo bias atnaujinimas
    end
end

x_2=0.1:(1/200):1;%naujas x vektorius
y_aprox=zeros(size(x_2));%uzpildau nuliais
%testuoju RBF tinklo aproksimavima
for i = 1:length(x_2)
    phi1=exp(-(x_2(i)-c_1)^2/(2*r_1^2));
    phi2=exp(-(x_2(i)-c_2)^2/(2*r_2^2));
    
    y_aprox(i)=w_1*phi1+w_2*phi2+w_0;%tinklo isejimas
end

figure (1)
plot(x,d,'b-o')%vaizduoju pradine f-ja
hold on
title('Aproksimacija RBF tinklu')
ylabel('pradine,aproksimuota')
xlabel('x,x_2')
plot(x_2,y_aprox,'g--o')%vaizduoju RBF tinklo aproksimuota varianta
legend('Duota f-ja (desired output)', 'Aproksimuota f-ja (approximated output)')


