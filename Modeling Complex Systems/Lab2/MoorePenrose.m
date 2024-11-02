
imageX = imread("x1.bmp");
initialX = double(imageX);

%Extending initialX matrix with row of 1
extendedXMatr = [initialX; ones(size(initialX, 2), 1)'];

Y = imread("y2.bmp");
Y = double(Y);

%Moore-Penrose method for pseudoinv
A = extendedXMatr;
delta = 1;
epsilon = 0.000001;
previousPseudoInv = A'*(inv(A*A'+power(delta,2)*eye(size(A,1))));
currentPseudoInv = [];
while(true)
    delta = delta/2;
    currentPseudoInv = A'*inv(A*A'+power(delta,2)*eye(size(A,1)));
    if ((norm(currentPseudoInv-previousPseudoInv,inf)) < epsilon)
        break
    end
    previousPseudoInv = currentPseudoInv;
end

MoorePenrosePseudoInverse = currentPseudoInv;

V = zeros(size(Y,1),size(A,1));

resultedTranformMoorePenrose = Y * MoorePenrosePseudoInverse + V * ((eye(size(extendedXMatr,1))-extendedXMatr*MoorePenrosePseudoInverse));

XTransformedMoorePenrose = resultedTranformMoorePenrose * extendedXMatr;

figure
imshow(uint8(XTransformedMoorePenrose))

%checking the accuracy of pseudoinv for Greville
pseudoInvTheoretical = MoorePenrosePseudoInverse * extendedXMatr * MoorePenrosePseudoInverse;
thereoticalXMatr = extendedXMatr*MoorePenrosePseudoInverse*extendedXMatr;
disp("Mean square eroor between TheoreticalPseudoInverse and ActualPseudoInverse: ");
disp(norm(pseudoInvTheoretical-MoorePenrosePseudoInverse,'fro')^2/(size(MoorePenrosePseudoInverse,1)*size(MoorePenrosePseudoInverse,2)));
disp("Mean square eroor between TheoreticalA and ActualBasedOnPseudInverseA: ");
disp(norm(extendedXMatr-thereoticalXMatr,'fro')^2/(size(extendedXMatr,1)*size(extendedXMatr,2)));
disp("Mean square eroor between Y and X*TransformationBasedOnMoorePenrosePseudoInv: ");
fprintf('%.10f\n',norm(double(Y-XTransformedMoorePenrose),inf)^2/numel(Y));

figure
imshow(uint8(Y));
