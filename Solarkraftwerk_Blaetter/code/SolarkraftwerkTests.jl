module Solarkraftwerk

using Plots


export reflektion


function reflektion(alpha,gamma)
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
    plot!([0],[1.2], seriestype = :scatter, label = "Rohr")
end


end


