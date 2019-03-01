module Solarkraftwerk

using Plots


export reflektion
export Video
export pruefe_e
export pruefe_e1e2e3
export pruefe_P_M

function reflektion(alpha,gamma)
    if ~(alpha >= 0 && alpha <= pi)
		@warn "Alpha liegt nicht zwische 0 und pi!"
    end
    gammaML = (alpha + pi/2)/2;
    eps = 0.00001;
    if abs(gamma-gammaML) > eps
		@warn "Deine Formel zur Berechnung von gamma ist falsch! Korrigiere sie in Teil b)."
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

end


