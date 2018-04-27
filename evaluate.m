 function [efp, efn, p] = evaluate(result, groundtruth, windowsize)
[rows, cols] = size(result);
padrows = rows + (windowsize-1)/2;
padcols = cols + (windowsize-1)/2;
rst = padarray(result, [(windowsize-1)/2, (windowsize-1)/2]);
gt = padarray(groundtruth, [(windowsize-1)/2, (windowsize-1)/2]);
rst(1:(windowsize-1)/2,:) = 1;
rst(padrows:padrows+(windowsize-1)/2,:) = 1;
rst(:, 1:(windowsize-1)/2) = 1;
rst(:,padcols:padcols+(windowsize-1)/2) = 1;
gt(1:(windowsize-1)/2,:) = 1;
gt(padrows:padrows+(windowsize-1)/2,:) = 1;
gt(:, 1:(windowsize-1)/2) = 1;
gt(:,padcols:padcols+(windowsize-1)/2) = 1;
E = 0;
Efp = 0;
for r=1:rows
    for c=1:cols
        if rst(r,c) == 0
            flag = 0;
            for x=-(windowsize-1)/2:(windowsize-1)/2
                for y=-(windowsize-1)/2:(windowsize-1)/2
                    if gt(r+x,c+y)==0
                        E=E+1;
                        flag = 1;
                        gt(r+x, c+y) = 1;
                        break;
                    end
                end
            end
            if flag == 0
                Efp = Efp + 1;
            end
        end
    end
end
Efn = size(find(gt==0),1);
p = E / (E + Efp + Efn);
efp = Efp / E;
Egt = size(find(groundtruth==0),1);
efn = Efn / Egt;

% figure(4)
% imshow(min(result,  groundtruth));
% figure(5)
% imshow(gt);
end