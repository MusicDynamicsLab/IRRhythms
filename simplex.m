function simplex(pts, marker)

if nargin < 2
    marker = 'k.';
end

Rhythms = {[1 1 1]; 
           [2 1 1]; [1 2 1]; [1 1 2]; 
           [3 1 1]; [1 3 1]; [1 1 3]; 
           [2 2 1]; [1 2 2]; [2 1 2]; 
           [3 2 1]; [1 3 2]; [2 1 3]; 
           [3 1 2]; [2 3 1]; [1 2 3]; 
           [3 2 2]; [2 3 2]; [2 2 3]; 
           [3 3 2]; [2 3 3]; [3 2 3]};

%% Transform to put points in the 2D triangle
M = [0 0; 1 0; 1/2, sqrt(3/4)];

% Vertices in 3D
V3 = [1, 0, 0; 0, 1, 0; 0, 0, 1; 1, 0, 0];
V2 = V3*M;
f = 0.15;
% Vertices of smaller simplex
V3s= [1-f*2, 0, 0; 0, 1-f*2, 0; 0, 0, 1-f*2; 1-f*2, 0, 0; ];
V2s= V3s*M;
% Shift it over
V2s(:,1)=V2s(:,1)+f;
V2s(:,2)=V2s(:,2)+f/2;
% X and Y limits for printing
xl = [V2s(1,1) V2s(2,1)]; yl = [V2s(1,2) V2s(3,2)];

plot(V2s(:,1), V2s(:,2), 'k', 'LineWidth', 1.5); % V2(:,1), V2(:,2), 'k' , 
patch(V2s(:,1), V2s(:,2), 'w');
hold on

pts = pts ./ sum(pts,2);
pts = pts*M;
plot(pts(:,1), pts(:,2), marker, 'MarkerSize', 12, 'LineWidth', 1);
set(gca, 'XLim', xl, 'YLim', yl, 'Visible', 'off')

for rr = 1:length(Rhythms)
    rhythm  = Rhythms{rr};
    rhynorm = rhythm / sum(rhythm);
    pt      = rhynorm*M;

%     hold on
    plot(pt(1), pt(2), 'b+', 'MarkerSize', 16, 'LineWidth', 2);
    text(pt(1)-.012, pt(2)+.015, sprintf('%d %d %d', rhythm), 'Color', [0 0 .75]);
end
hold off


%% This should work too, but need to rethink it
% V3sa= [1-f, f/2, f/2; f/2, 1-f, f/2; f/2, f/2, 1-f; 1-f/2, f/2, f/2; ];
% V2sa= V3sa*M;
