module Solarkraftwerk

using Plots


export reflektion
export Video


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
    plot([0;y1],[0;y2], seriestype = :path, color = :red, linewidth = 4, xlims = (-1.5,1.5), ylims = (-.5,1.5), label = "einfallender Strahl")
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
    plot([0;y1],[0;y2], seriestype = :path, color = :red, linewidth = 4, xlims = (-1.5,1.5), ylims = (-.5,1.5), label = "einfallender Strahl")
    plot!([0;0.25*z1],[0;0.25*z2], color = :black, seriestype = :path, label = "Spiegelnormale")
    plot!([0.25*z2;-0.25*z2],[-0.25*z1;0.25*z1], color = :black, linewidth = 4, seriestype = :path, label = "Spiegel")
    plot!([0;v1],[0;v2],color = :green, linewidth = 4; seriestype = :path, label = "reflektierter Strahl")
    plot!([0],[1.2], seriestype = :scatter, markersize = 8, label = "Rohr")
    plot!([-1.5;1.5],[0;0], linestyle = :dot, color = :black, seriestype = :path, label = "Boden")
end





end


