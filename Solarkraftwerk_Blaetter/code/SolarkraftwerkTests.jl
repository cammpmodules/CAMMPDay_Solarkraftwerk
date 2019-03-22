module Solarkraftwerk

using Plots


export reflektion
export Video
export pruefe_e
export pruefe_e1e2e3
export pruefe_P_M
export pruefe_PMt
export pruefe_A0
export pruefe_A
export pruefe_A1A2A3
export pruefe_P_R
export pruefe_PRt
export pruefe_tmax
export pruefe_beta
export outbeta
export pruefe_gamma
export makeplot
export pruefe_e_strich
export pruefe_a
export pruefe_PR

function reflektion(alpha,gamma)
    if ~(alpha >= 0 && alpha <= pi)
		@warn "Alpha liegt nicht zwische 0 und pi!"
    end
    gammaML = (alpha + pi/2)/2;
    eps = 0.00001;
    if abs(gamma-gammaML) > eps
		@warn "Deine Formel zur Berechnung von gamma ist falsch! Korrigiere sie in Teil b)."
    else
        println("Es ist gamma = $(gamma/pi*180) Grad.")
    end
    y1 = cos(alpha);
    y2 = sin(alpha);
    z1 = cos(gamma);
    z2 = sin(gamma);
    beta = alpha+2*(gamma-alpha);
    v1 = cos(beta);
    v2 = sin(beta);
    plot([0;y1],[0;y2], seriestype = :path, color = :red, linewidth = 4, xlims = (-1.5,1.5), ylims = (-.5,1.5), label = "einfallender Strahl", title = "Strahlengang für alpha = $(alpha/pi*180) Grad")
    plot!([0;0.25*z1],[0;0.25*z2], color = :black, seriestype = :path, label = "Spiegelnormale")
    plot!([0.25*z2;-0.25*z2],[-0.25*z1;0.25*z1], color = :black, linewidth = 4, seriestype = :path, label = "Spiegel")
    plot!([0;v1],[0;v2],color = :green, linewidth = 4; seriestype = :path, label = "reflektierter Strahl")
    plot!([0],[1.2], seriestype = :scatter, markersize = 8, label = "Rohr")
    plot!([-1.5;1.5],[0;0], linestyle = :dot, color = :black, seriestype = :path, label = "Boden")
end

function Video(t,gamma)
    if ~(t >= 7.07 && t <= 18.89)
		@warn "t liegt nicht in dem Bereich, in dem die Formel gültig ist! Dieser ist gegeben durch [7.07, 18.89]."
    end
    alpha = (14.2076 + 15.221* (t-8))*pi/180;
    gammaML = (alpha + pi/2)/2;
    eps = 0.00001;
    if abs(gamma-gammaML) > eps
		@warn "Deine Formel zur Berechnung von gamma ist falsch! Korrigiere sie. Eventuell ist der Fehler auch in den Funktionen `berechne_alpha` oder `grad2rad` zu finden."
    else
        println("Es gilt alpha = $(alpha/pi*180) Grad und gamma = $(gamma/pi*180) Grad.")
    end
    y1 = cos(alpha);
    y2 = sin(alpha);
    z1 = cos(gamma);
    z2 = sin(gamma);
    beta = alpha+2*(gamma-alpha);
    v1 = cos(beta);
    v2 = sin(beta);
    plot([0;y1],[0;y2], seriestype = :path, color = :red, linewidth = 4, xlims = (-1.5,1.5), ylims = (-.5,1.5), label = "einfallender Strahl", title = "Strahlengang zur Zeit t = $(t)")
    plot!([0;0.25*z1],[0;0.25*z2], color = :black, seriestype = :path, label = "Spiegelnormale")
    plot!([0.25*z2;-0.25*z2],[-0.25*z1;0.25*z1], color = :black, linewidth = 4, seriestype = :path, label = "Spiegel")
    plot!([0;v1],[0;v2],color = :green, linewidth = 4; seriestype = :path, label = "reflektierter Strahl")
    plot!([0],[1.2], seriestype = :scatter, markersize = 8, label = "Rohr")
    plot!([-1.5;1.5],[0;0], linestyle = :dot, color = :black, seriestype = :path, label = "Boden")
end

function pruefe_e(berechne_e)
    a1 = pi/5;
    t1 = berechne_e(2,a1,(pi/2+a1)/2);
    MU1 = 2*cos((pi/2+a1)/2 - a1);
    a2 = pi/3;
    t2 = berechne_e(2,a2,(pi/2+a2)/2);
    MU2 = 2*cos((pi/2+a2)/2 - a2);
    a3 = 2*pi/3;
    t3 = berechne_e(3,a3,(pi/2+a3)/2);
    MU3 = 3*cos((pi/2+a3)/2 - a3);
    a4 = 6*pi/7;
    t4 = berechne_e(2,a4,(pi/2+a4)/2);
    MU4 = 2*cos((pi/2+a4)/2 - a4);   
        
    eps = 0.00001;
    t = [t1, t2, t3, t4];
    MU = [MU1, MU2, MU3, MU4];
    if maximum(abs.(t - MU)) > eps
        @warn "Die Formel zur Berechnung von e ist nicht korrekt!"
    else
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function pruefe_e1e2e3(e1, e2, e3)
    e1MU = 1.1*cos((pi/2+20/180*pi)/2 - 20/180*pi);
    e2MU = 1.1*cos((pi/2+pi/2)/2 - pi/2);
    e3MU = 1.1*cos((pi/2+130/180*pi)/2 - 130/180*pi);
    
    eps = 0.00001;
    if abs(e1 - e1MU) > eps
        @warn "Dein Ergebnis für e1 ist falsch!"
    end
    if abs(e2 - e2MU) > eps
        @warn "Dein Ergebnis für e2 ist falsch!"
    end
    if abs(e3 - e3MU) > eps
        @warn "Dein Ergebnis für e3 ist falsch!"
    end
    e = [e1, e2, e3];
    MU = [e1MU, e2MU, e3MU];
    if maximum(abs.(e-MU)) <= eps
        println("e1 = $(e1) \ne2 = $(e2) \ne3 = $(e3)")
    end
end

function pruefe_P_M(berechne_P_M)
    PS1 = 700;
    a1 = pi/4;
    PM1 = berechne_P_M(PS1, a1);
    PM1MU = PS1 * 1.1 * cos((pi/2+a1)/2 - a1);
    PS2 = 500;
    a2 = pi/8;
    PM2 = berechne_P_M(PS2, a2);
    PM2MU = PS2 * 1.1 * cos((pi/2+a2)/2 - a2);    
    PS3 = 896;
    a3 = 7*pi/8;
    PM3 = berechne_P_M(PS3, a3);
    PM3MU = PS3 * 1.1 * cos((pi/2+a3)/2 - a3);    
    
    eps = 0.00001;
    PM = [PM1, PM2, PM3];
    MU = [PM1MU, PM2MU, PM3MU];
    if maximum(abs.(PM - MU)) > eps
        @warn "Die Formel zur Berechnung von P_M ist nicht korrekt!"
    else
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function pruefe_PMt(berechne_P_M_t)
    t = [8; 10; 12; 14; 16; 18];
    s = 1.1;
    alpha = (14.2076 .+ 15.221 .* (t .- 8)) .* pi/180;
    gamma = (alpha .+ pi/2) ./ 2;
    e =  s .* cos.(gamma .- alpha);
    P_S = (- 3580.0058) .+ 696.1063 .* t .- 26.8157 .* t.^2;
    P_MMU = P_S .* e;
    P_M = berechne_P_M_t.(t);
    eps = 0.00001;
    if maximum(abs.(P_M - P_MMU)) > eps
		@warn "Deine Formel zur Berechnung von P_M ist falsch! Korrigiere sie. Eventuell ist der Fehler auch in der Funktion `berechne_P_S` zu finden."
        else 
        t = range(7.07, stop = 18.89, length = 1000);
        y = berechne_P_M_t.(t);
        plot(t,y,linewidth = 3, title = "Leistung am Spiegel im Tagesverlauf", xlabel = "Zeit t (in Stunden nach Tagesbeginn)", ylabel = "P_M (in Watt)", label = "")
    end
end


function pruefe_A0(berechne_A0)
    e = [5;6;10;20;3];
    b = [2;1;4;19;3];
    A_MU = b./e.*100;
    A = berechne_A0.(e,b);
    eps = 0.00001;
    if maximum(abs.(A_MU - A)) > eps
		@warn "Deine Formel zur Berechnung von A ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function pruefe_A(berechne_A)
    e = [5;6;10;20;3;2;8];
    b = [2;1;4;19;3;5;9];
    A_MU = min.(b./e, ones(7,1))*100;
    A = berechne_A.(e,b);
    eps = 0.00001;
    if maximum(abs.(A_MU - A)) > eps
		@warn "Deine Formel zur Berechnung von A ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end


function pruefe_A1A2A3(A1, A2, A3)
    b = 0.8;
    e1MU = 1.1*cos((pi/2+35/180*pi)/2 - 35/180*pi);
    A1MU = min(b/e1MU,1)*100;
    e2MU = 1.1*cos((pi/2+95/180*pi)/2 - 95/180*pi);
    A2MU = min(b/e2MU,1)*100;
    e3MU = 1.1*cos((pi/2+175/180*pi)/2 - 175/180*pi);
    A3MU = min(b/e3MU,1)*100;
    
    eps = 0.00001;
    if abs(A1 - A1MU) > eps
        @warn "Dein Ergebnis für A1 ist falsch!"
    end
    if abs(A2 - A2MU) > eps
        @warn "Dein Ergebnis für A2 ist falsch!"
    end
    if abs(A3 - A3MU) > eps
        @warn "Dein Ergebnis für A3 ist falsch!"
    end
    A = [A1, A2, A3];
    MU = [A1MU, A2MU, A3MU];
    if maximum(abs.(A-MU)) <= eps
        println("A1 = $(A1) \nA2 = $(A2) \nA3 = $(A3) \nDie obigen Ergebnisse kann man qualitativ so erklären: Je spitzer bzw. stumpfer der Einfallswinkel, desto kleiner ist e und desto größer ist b/e.")
    end
end

function pruefe_P_R(berechne_P_R)
    P_M = [1500;1278;789;566];
    A = [80.5; 77; 94; 60];
    P_R_MU = A ./ 100 .* P_M
    P_R = berechne_P_R.(P_M, A);
    eps = 0.00001;
    if maximum(abs.(P_R_MU - P_R)) > eps
		@warn "Deine Formel zur Berechnung von P_M ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function pruefe_PRt(berechne_P_R_t)
    t = [8; 10; 12; 14; 16; 18];
    s = 1.1;
    b = 0.8;
    alpha = (14.2076 .+ 15.221 .* (t .- 8)) .* pi/180;
    gamma = (alpha .+ pi/2) ./ 2;
    e =  s .* cos.(gamma .- alpha);
    P_S = (- 3580.0058) .+ 696.1063 .* t .- 26.8157 .* t.^2;
    P_M = P_S .* e;
    A = min.(b ./ e, ones(6,1)).*100;
    P_RMU = A ./ 100 .* P_M;
    P_R = berechne_P_R_t.(t);
    eps = 0.00001;
    if maximum(abs.(P_R - P_RMU)) > eps
		@warn "Deine Formel zur Berechnung von P_M ist falsch! Korrigiere sie. Eventuell ist der Fehler auch in den Funktionen `berechne_e_t` oder `berechne_A_t` zu finden."
        else 
        t = range(7.07, stop = 18.89, length = 1000);
        y = berechne_P_R_t.(t);
        plot(t,y,linewidth = 3, title = "Leistung am Absorberrohr im Tagesverlauf", xlabel = "Zeit t (in Stunden nach Tagesbeginn)", xticks = 7:19, ylabel = "P_R (in Watt)", label = "")
    end
end

function pruefe_tmax(t_max)
    eps = 0.00001;
    if abs(t_max -13) > eps
		@warn "Deine Eingabe für t_max ist falsch! Korrigiere dich."
    else 
        println("Genau, um $(t_max) Uhr arbeitet das Kraftwerk am effektivsten!")
    end
end

function pruefe_beta(berechne_beta)
    x = [-1;-2;0;0.6;14.5];
    h = [4;5;3.5;6;3];
    
    function berechne_betaMU(x,h)
    if (x < 0)
        beta = atan(h/(-x));
    elseif (x > 0)
        beta = pi-atan(h/x);
    elseif (x == 0)
        beta = pi/2;
    end
    return beta;
    end
    
    beta_MU = berechne_betaMU.(x,h);
    beta = berechne_beta.(x,h);
    eps = 0.00001;
    if maximum(abs.(beta_MU - beta)) > eps
		@warn "Deine Funktion zur Berechnung von beta ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function outbeta(x,h,beta)
    if h <= 0
        println("h muss positiv sein!")
    else
        println("Bei einer Spiegelposition von x = $(x) Metern und einer Höhe von h = $(h) Metern ist der gesuchte Winkel gegeben durch \n\nbeta = $(beta) (= $(beta/pi*180) Grad).")
    end
end

function pruefe_gamma(berechne_gamma)
    alpha = rand(5,1) * pi;
    beta = rand(5,1) * pi;
    gammaMU = (alpha + beta)/2;
    gamma = berechne_gamma.(alpha,beta);
    eps = 0.00001;
    if maximum(abs.(gammaMU - gamma)) > eps
		@warn "Deine Funktion zur Berechnung von gamma ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end


function makeplot(x,h,alpha,beta,gamma)
     if ~(alpha >= 0 && alpha <= pi)
		@warn "Alpha liegt nicht zwische 0 und pi!"
    end
    if h <= 0
		@warn "h ist nicht positiv!"
    end
    
    if (x < 0)
        betaMU = atan(h/(-x));
    elseif (x > 0)
        betaMU = pi-atan(h/x);
    elseif (x == 0)
        betaMU = pi/2;
    end
    
    gammaMU = (alpha + betaMU)/2;
    eps = 0.00001;
    if abs(gamma-gammaMU) > eps
		@warn "Deine Eingabe zur Berechnung von beta und gamma ist falsch! Korrigiere sie."
    else
        println("Es ist beta = $(beta/pi*180) Grad und gamma = $(gamma/pi*180) Grad.")
    end
    xlength = 3*abs(x);
    ylength = h+2;
    length = max(xlength, ylength);
    l = sqrt((x)^2+(h)^2);
    y1 = x + 0.95*l*cos(alpha);
    y2 = 0 + 0.95*l*sin(alpha);
    z1 = x + 0.15*l*cos(gamma);
    z2 = 0 + 0.15*l*sin(gamma);
    v1 = x + 0.95*l*cos(beta);
    v2 = 0 + 0.95*l*sin(beta);
    SA1 = x + 0.2*l*cos(gamma+pi/2);
    SA2 = 0 + 0.2*l*sin(gamma+pi/2);
    SE1 = x + 0.2*l*cos(gamma-pi/2);
    SE2 = 0 + 0.2*l*sin(gamma-pi/2);
    plot([x;y1],[0;y2], seriestype = :path, color = :red, linewidth = 4, xlims = (x-length/2, x+length/2); ylims = (-1,length-1), label = "einfallender Strahl", title = "Strahlengang für alpha = $(alpha/pi*180) Grad", size = (500,500))
    plot!([x;z1],[0;z2], color = :black, seriestype = :path, label="")
    plot!([SA1;SE1],[SA2;SE2], color = :black, linewidth = 4, seriestype = :path, label = "")
    plot!([x;v1],[0;v2],color = :green, linewidth = 4; seriestype = :path, label = "reflektierter Strahl")
    plot!([0],[h], seriestype = :scatter, markersize = 8, label = "")
    plot!([x-length/2, x+length/2],[0;0], linestyle = :dot, color = :black, seriestype = :path, label = "")
end

function pruefe_e_strich(berechne_e_strich)
    b = 10 * rand(5,1);
    beta = pi * rand(5,1);
    eMU = cos.(pi/2 * ones(5,1) - beta) .* b;
    e = berechne_e_strich.(b, beta);
    eps = 0.00001;
    if maximum(abs.(eMU - e)) > eps
		@warn "Deine Funktion zur Berechnung von e' ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function pruefe_a(berechne_a)
    e = rand(5,1);
    es = rand(5,1);
    aMU = min.(ones(5,1),es./e) .* 100;
    a = berechne_a.(e,es);
    eps = 0.00001;
    if maximum(abs.(aMU - a)) > eps
		@warn "Deine Funktion zur Berechnung von a ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end

function pruefe_PR(berechne_P_R)
    t = 7 * ones(5,1) + 12 * rand(5,1);
    x = (-10) * ones(5,1) + 20 * rand(5,1);
    s = rand(5,1);
    h = 6 * rand(5,1);
    b = 0.7 * rand(5,1);
    
    alpha = (14.2076 * ones(5,1) + 15.221 * (t - 8 * ones(5,1)))/180*pi;
    P_S = (-3580.0058) * ones(5,1) + 696.1063 * t - 26.8157 * t.^2;
    beta = zeros(5,1);
    for i = 1:5
        if (x[i] < 0)
            beta[i] = atan(h[i]/(-x[i]));
        elseif (x[i] > 0)
            beta[i] = pi-atan(h[i]/x[i]);
        elseif (x[i] == 0)
            beta[i] = pi/2;# Ersetze NaN durch einen Ausdruck für den Winkel beta im Fall x=0
        end
    end
    gamma = (alpha+beta)/2;
    e = s .* cos.(gamma-alpha);
    P_M = e .* P_S;
    es = b .* cos.(pi/2 * ones(5,1) - beta);
    a = min.(ones(5,1),es./e);
    P_R = a .* P_M;
    
    p_r = berechne_P_R.(t,x,s,h,b);
    
    eps = 0.00001;
    if maximum(abs.(P_R - p_r)) > eps
		@warn "Deine Funktion zur Berechnung von P_R ist falsch! Korrigiere sie."
    else 
        println("Deine Formel scheint korrekt zu sein!")
    end
end


    
    
    
    
    
    
    
    
end


