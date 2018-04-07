%% Learn Z by 
%   min_{Z} \|X-XZ\|_{2,1}+lambda\|Z\|_F
function Z = Robust_LearnZ(X,lambda)
%% Input: X, data matrix
%          lambda: regularization parameter
%   Output: Z, the similarity matrix
disp(['The regularization parameter is:' num2str(lambda)]);
[dim,n] = size(X);
iter = 5;
D = eye(n);
XtX = X'*X;
for i =1:iter
    disp(i)
    % update Z
    temp = lambda*diag(1./diag(D));
    Z = lyap(XtX,temp,-XtX);
    % update D
    temp = X*Z-X;
    temp = temp.*temp;
    d = 0.5*1./sqrt(sum(temp,1));
    D = diag(d);
    obj(i) = sum(sqrt(sum(temp,1))) + lambda*norm(Z,'fro')^2;
end
plot(obj)