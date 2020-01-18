function [cvData] = crossValidate(input, target, nFolds, option)

if (nargin < 4)
    option  = 's';  % default is stratified cross validation
end

nPatterns = size(input, 1);

if (nPatterns ~= size(target, 1));
    error('Inconsistent number of samples');
elseif (nFolds < 1)
    error('Incorrect number of folds');
end

reset(RandStream.getGlobalStream); % reset random seed for reproducability
rows = randperm(nPatterns);
cvData = cell(nFolds, 2);

if (option == 's')
    targetList = [];

    for p = 1 : nPatterns
        found = 0;

        for m = 1 : size(targetList, 1)
            if (target(rows(p), :) == targetList(m, :))
                found = 1;
                break;
            end
        end

        if (found == 0)
            targetList = [targetList; target(rows(p), :)];
        end
    end

    nTargets = size(targetList, 1);
    counts = zeros(nTargets, nFolds);

    for p = 1 : nPatterns    
        for m = 1 : nTargets  
            if (target(rows(p), :) == targetList(m, :))
                break;
            end
        end

        [minCount, fold] = min(counts(m, :));
        sumCount = sum(counts, 1);
        minSum = nPatterns; % reset

        for k = 1 : nFolds  % correct fold index if there are multiple minimums          
            if (minCount == counts(m, k) && minSum > sumCount(k))
                minSum = sumCount(k);
                fold = k;
            end
        end

        cvData{fold, 1} = [cvData{fold, 1}; input(rows(p), :)];
        cvData{fold, 2} = [cvData{fold, 2}; target(rows(p), :)];
        counts(m, fold) = counts(m, fold) + 1;
    end
elseif (option == 'n')
    for p = 1 : nPatterns    
        fold = mod(rows(p) - 1, nFolds) + 1;
        cvData{fold, 1} = [cvData{fold, 1}; input(rows(p), :)];
        cvData{fold, 2} = [cvData{fold, 2}; target(rows(p), :)];
    end
end