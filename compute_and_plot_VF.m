function [slope] = compute_and_plot_VF(X,id,plotall,dt)

% colorpalette;
colors = {[110 180 200]/255;
          [244 177 131]/255;
          [255 129 129]/255;
          [170 100 170]/255;
          [0 0 0]/255};
col = colors{id};

r = mean(X,1);
delta_r = r(2:end) - r(1:end-1);
r = r(1:end-1);

mr = mean(r);
mdr = mean(delta_r);

% center
r = r - mr;

p = polyfit(r,delta_r,1);
slope = -p(1)/dt;

if plotall == 1

    rmin = min(r); rmax = max(r);
    xaxis = rmin:.1:rmax;
    figure(1111);
    plot(r,delta_r,'.'); hold on;
    plot(xaxis, p(1)*xaxis + p(2),'LineWidth',2,'color',col); hold on;
    plot(mr,mdr,'.','markersize',20,'color',col);
    axis square;
    xlabel('m(t)'); ylabel('\Delta m(t)');
    set(gca,'fontsize',15);
end

if plotall == 1

    figure; plot(r);

    n = 20;
    redges = linspace(min(r),max(r),n);
    Yr = discretize(r,redges);
    dr_edges = linspace(min(delta_r), max(delta_r), n);
    Ydr = discretize(delta_r,dr_edges);

    mLen = zeros(n-1,1);
    dLen = zeros(n-1,n-1);
    mdelta_r = zeros(n-1,1);
    ddelta_r = zeros(n-1,n-1);

    for i = 1:n-1
        Ir = Yr==i;
        Idr = Ydr==i;
        mLen(i) = mean(r(Ir));
        mdelta_r(i) = mean(delta_r(Idr));
        for j=1:n-1
            Idr = Ydr==j;
            I = logical(Ir .* Idr);

            dLen(i,j) = mean(r(circshift(I,1)) - r(I));
            ddelta_r(i,j) = mean(delta_r(circshift(I,1)) - delta_r(I));
        end
    end

    [x,y] = meshgrid(mLen,mdelta_r);
    u = dLen';
    v = ddelta_r';

    figure;
    quiver(x,y,u,v,'color',[.5 .5 .5]); axis square; hold on; set(gca,'FontSize',15);
    plot(mean(r),mean(delta_r),'.','markersize',20,'Color', 'k');
    xlabel('r(t)'); ylabel('\Delta r(t)');
    plot(r, p(1)*r + p(2),'LineWidth',2,'color', 'k');
    box off;
end

if size(X,1) == 0
    slope = 0;
end

end
