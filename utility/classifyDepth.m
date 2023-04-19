function label = classifyDepth(pc)
% 0 is bottle
% 1 is can
    % stupid check to see how large is the biggest eigenvalue of the pc
    % bottles are longer than cans so it has to be bigger
    label = max(eig(cov(pc))) <= 0.0023;

    % TODO fit the pc with the 3d model of the obj?
end

