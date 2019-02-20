function[] = Abbildung(alpharad,nrad)

% Das Argument "drawE" gibt an, ob die für die Verschiebungsaufgabe
% relevante Darstellung der "energieproduzierenden" orthogonalen Projektion
% sowie die Begrenzungen des reflektierten, energieliefernden Lichtanteils
% mitgezeichnet werden. Für alle Aufgaben der ersten 3 Aufgabenblätter sollte
% drawE=0 sein, nur zum Testen der Aufgabe 4c) wird die Zeichnung benötigt und
% drawE=1 gesetzt (siehe auch: check_eNeu)

% Fix Data
t = 0;
h = 2;
w1 = 1.1;
w2 = 0.8;
figNum = 1;
drawE = 0;

% Data for the incident ray
x(1) = t;
y(1) = 0;
x(2) = x(1) + 2 * cos(alpharad); % 1 being arbitrary length of the sun ray
y(2) = y(1) + 2 * sin(alpharad);

% Data for the reflecting ray

x1(1) = t;
y1(1) = 0;
x1(2) = x1(1) + 0.5*h * cos(2*nrad-alpharad) * sqrt( t*t + h*h );
y1(2) = y1(1) + 0.5*h * sin(2*nrad-alpharad) * sqrt( t*t + h*h );

% Data for the parallel rays of the reflecting ray originating at the tips
% of the mirror to show where the light hits
x9(1) = t - cos(abs(pi/2-nrad))*w1/2;
y9(1) = sin(abs(pi/2-nrad))*w1/2*sign(pi/2-nrad);
x9(2) = x1(2) - ( cos( nrad-alpharad ) * w1) / sin(2*nrad-alpharad) / 2;
y9(2) = 0.5*h * sin(2*nrad-alpharad) * sqrt( t*t + h*h );
x10(1) = t + cos(abs(pi/2-nrad))*w1/2;;
y10(1) = -1*sin(abs(pi/2-nrad))*w1/2*sign(pi/2-nrad);
x10(2) = x1(2) + ( cos( nrad-alpharad ) * w1) / sin(2*nrad-alpharad) / 2;
y10(2) = 0.5*h * sin(2*nrad-alpharad) * sqrt( t*t + h*h );

%Data for the normal to the mirror
x2(1) = t;
y2(1) = 0;
x2(2) = x2(1) + cos(nrad)/4; % 0.25 being arbitrary length of the normal
y2(2) = y2(1) + sin(nrad)/4; 

% %Horizontal Line at the collecting tube
x4 = [-w2/2 -w2/2];
y4 = [h h+w2/2];
%These lines which make the  inner rectangle at the top
x5 = [w2/2 w2/2];
y5 = [h h+w2/2];

x6 = [-w2/2 w2/2];
y6 = [h+w2/2 h+w2/2];

%primary reflecting mirror
x7(1) = t + w1/2*cos(pi/2+nrad);
y7(1) = 0 + w1/2*sin(pi/2+nrad);
x7(2) = t + w1/2*cos(nrad-pi/2);
y7(2) = 0 + w1/2*sin(nrad-pi/2);

%Datum line
x8 = [t-2*h 2*h-t];
y8 = [0 0];


if (drawE==1)
%eNeu Energieerzeugender Anteil
Beta=2*nrad-alpharad;
eNeu=w2*sin(Beta);
%e ist Länge des orthogonalen Reflexionsanteils
e=w1*cos(nrad-alpharad);



if(t<0)
x9(1)= -w2/2;
x9(2)= -w2/2+eNeu*sin(Beta);
y9(1)= h;
y9(2)= h-eNeu*cos(Beta);

x10(1)=-w2/2+eNeu*sin(Beta);
x10(2)=w2/2;
y10(1)= h-eNeu*cos(Beta);
y10(2)=h;
elseif (t>0)
x9(1)= w2/2;
x9(2)= w2/2-eNeu*sin(Beta);
y9(1)= h;
y9(2)= h+eNeu*cos(Beta);

x10(1)=-w2/2+eNeu*sin(Beta);
x10(2)=w2/2;
y10(1)= h-eNeu*cos(Beta);
y10(2)=h;
elseif(t==0)
x9(1)=-w2/2;
x9(2)=w2/2;
y9(1)=h;
y9(2)=h;
end


%Linien, die die energierelevante Länge eNeu begrenzen:


u=Beta-nrad;
l=(eNeu/2)/cos(u);
xRel=l*cos(pi/2-nrad);
yRel=l*sin(pi/2-nrad);

        x11(1)=t+xRel;
        y11(1)=0-yRel;  
        x12(1)=t-xRel;
        y12(1)=0+yRel;
        x11(2)=w2/2;
        y11(2)=h;
        x12(2)=-w2/2;
        y12(2)=h;

if (alpharad<nrad)
    G=w1*sin(pi/2-nrad+Beta);
    x13(1)=t-w1/2*sin(nrad);
    x13(2)=t+(G*cos(pi/2-Beta)-w1/2*cos(pi/2-nrad));
    y13(1)=0+w1/2*sin(pi/2-nrad);
    y13(2)=0-G*sin(pi/2-Beta)+y13(1);
else
    G=w1*sin(pi/2-nrad+Beta);
    x13(1)=t+w1/2*sin(nrad);
    x13(2)=t-(G*cos(pi/2-Beta)-w1/2*cos(pi/2-nrad));
    y13(1)=0-w1/2*sin(pi/2-nrad);
    y13(2)=0+G*sin(pi/2-Beta)+y13(1);
end

if (e<eNeu)
%Für große Neigungswinkel kann es passieren,
%dass die orthogonale e am Spiegel kleiner ist als die Länge, 
%die den Lichteinfall am Absorberrohr begrenzt (eNeu)

        x9(1)= w2/2;
        x9(2)= w2/2-eNeu*sin(Beta);
        y9(1)= h;
        y9(2)= h+eNeu*cos(Beta);


        u=Beta-nrad;
        l=(e/2)/cos(u);
        xRel=l*cos(pi/2-nrad);
        yRel=l*sin(pi/2-nrad);

        x11(1)=t+xRel;
        y11(1)=0-yRel;  
        x12(1)=t-xRel;
        y12(1)=0+yRel;
        y11(2)=h;
        y12(2)=h;
        
        topRel=(e/2)/cos(Beta-pi/2);

        x11(2)=topRel;
        x12(2)=-topRel;
end

end

figure(figNum)
set( figNum, 'units', 'normalized', 'position', [ 0 0 1 1 ] )
hold on;

plot(x,y,'r');
plot(x1,y1,'g');
plot(x2,y2,'k');
rectangle('Position',[-0-0.1/2,2,0.1,0.1],'Curvature',[0.8,0.6]);
plot(x4,y4,'k');
plot(x5,y5,'k');
plot(x6,y6,'k');
plot(x7,y7,'k','LineWidth',3);
plot(x8,y8,'k')

if (drawE==1)
     plot(x9,y9,'g--');
    plot(x11,y11,'g--');
    plot(x12,y12,'g--');
    plot(x13,y13,'g');
end

daspect([1 1 1])