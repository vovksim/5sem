imageX = imread("x1.bmp");
initialX = double(imageX);

%Extending initialX matrix with row of 1
extendedXMatr = [initialX; ones(1,size(initialX,2))];

Y = imread("y2.bmp");
Y = double(Y);


%Greville method for pseudoinv
pseudoInvA = []; %pseudoinverse on i-th step
A = []; %A matrix on i-th step
for i = 1: size(extendedXMatr,1)
    currentRow = extendedXMatr(i,:);
    %According to 1st step
    if(i == 1)
        dotProd = currentRow' * currentRow;
        if dotProd == 0
            pseudoInvA = [pseudoInvA,zeros(size(extendedXMatr,2),1)];
        elseif dotProd > 0
            pseudoInvA = [pseudoInvA,currentRow' / dotProd];
        end
    else

        Z = eye(size(extendedXMatr,2)) - pseudoInvA * A;
        cond = currentRow * Z * currentRow';
        if cond > 0
            pseudoInvA=[pseudoInvA - (Z * (currentRow') * currentRow * pseudoInvA)/(currentRow * Z * currentRow'),(Z*currentRow')/(currentRow*Z*currentRow')];
        elseif cond == 0
            R = pseudoInvA*pseudoInvA';
            pseudoInvA=[pseudoInvA - (R * (currentRow') * currentRow * pseudoInvA)/(1 + currentRow * R * currentRow'),(R*currentRow')/(1+currentRow*R*currentRow')];
        end
    end
    %adding row to A matrix
    A = [A; currentRow];
end

V = zeros(size(Y,1),size(extendedXMatr,1));

pseudoInvGreville = pseudoInvA;

resultedTranformGreville = Y * pseudoInvGreville + V * ((eye(size(extendedXMatr,1))-extendedXMatr*pseudoInvGreville));

XTransformedGreville = resultedTranformGreville * extendedXMatr;
figure
imshow(uint8(XTransformedGreville));

%checking the accuracy of pseudoinv for Moore-Penrose
pseudoInvTheoretical = pseudoInvGreville * extendedXMatr * pseudoInvGreville;
thereoticalXMatr = extendedXMatr*pseudoInvGreville*extendedXMatr;
disp("Mean square eroor between TheoreticalPseudoInverse and ActualPseudoInverse: ");
disp(norm(pseudoInvTheoretical-pseudoInvGreville,'fro')^2/(size(pseudoInvGreville,1)*size(pseudoInvGreville,2)));
disp("Mean square eroor between TheoreticalA and ActualBasedOnPseudInverseA: ");
disp(norm(extendedXMatr-thereoticalXMatr,'fro')^2/(size(A,1)*size(A,2)));
disp("Mean square eroor between Y and X*TransformationBasedOnGrevilleInv: ");
fprintf('%.10f\n',norm(double(uint8(Y)-uint8(XTransformedGreville)),inf)^2/(numel(Y)));