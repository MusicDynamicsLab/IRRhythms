%% genPts
Pts = [];
for i1 = .15:.025:.85
    for i2 = .15:.025:.85-i1
            Pts = [Pts; [i1, i2, 1-i1-i2]];
    end
end
Pts = Pts  + .0075*randn(size(Pts));
Pts = Pts ./ sum(Pts,2);

% Check this
nRhythms = [];
iRhythms = [];
thisRhythm = [1 1 1];
for pti = 1:size(Pts,1)
    mindist = 1;
    for rhi = 1:length(Rhythms)
        eucldist = sqrt(sum((Pts(pti,:)-Rhythms{rhi}/sum(Rhythms{rhi})).^2));
        if eucldist < mindist
            mindist = eucldist;
            thisRhythm = Rhythms{rhi};
            idx = rhi;
        end
    end
    nRhythms = [nRhythms; thisRhythm];
    iRhythms = [iRhythms; idx];

end

[nr1 ir1] = sort(iRhythms);

% Pts      = Pts(ir1,:);
% nRhythms = nRhythms(ir1,:);
% iRhythms = iRhythms(ir1,:);

figure(4); clf
simplex(Pts)

% size(Pts)
