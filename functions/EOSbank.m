function varargout = EOSbank(nRods, problemOpt)
%%            [EOS, K, n] = EOSbank(nRods, problemOpt)
%
% Generates the Equations Of State calculated in the Mathematica notebook 
% in the caller workspace.
%
%_________________________________________________________________________ 
% Output:
%
%   - EOS ( function handle )  @X [EOS(1); ...; EOS(n)] 
%       ( X -> [X(1); ...; X(n)]   represents the system state   ) 
%  
%   - K  ( vector of double ) parameters of the control force 
% 
%   - n               ( int ) number of system states
%


n = 2*(nRods + 1);

% write data
writeOptions(problemOpt,[1,6])

switch nRods
% Separate definition of equations 
    case 1
        EOS = @(t,X) [  ...
            X(3); ...
            ...
            X(4); ...
            ...
            ((-1).*m+(-2).*M+m.*cos(2.*X(2))).^(-1).*((-1).*h.*((-3)+cos(2.*X( ...
            2))).*X(3)+2.*l.*m.*sin(X(2)).*X(4).^2+2.*((-1).*g.*m.*cos(X(2)).* ...
            sin(X(2))+h.^2.*l.*m.^(-2).*M.*X(2)+g.*(m+M).*X(2)+3.*domEig.*l.* ...
            M.*(domEig.*X(2)+X(4))+g.^(-1).*l.*m.^(-3).*(h+(-1).*domEig.*m) ...
            .^3.*M.*(X(3)+(-1).*l.*X(4))+(-1).*h.*m.^(-1).*(m.*X(3)+M.*(3.* ...
            domEig.*l.*X(2)+(-1).*X(3)+2.*l.*X(4))))); ...
            ...
            g.^(-1).*l.^(-1).*m.^(-3).*((-1).*m+(-2).*M+m.*cos(2.*X(2))).^(-1) ...
            .*(g.*m.^2.*((-2).*g.*m.*(m+M).*sin(X(2))+(-1).*h.*l.*m.*cos(2.*X( ...
            2)).*X(4)+l.*X(4).*(h.*m+2.*h.*M+m.^2.*sin(2.*X(2)).*X(4)))+2.* ...
            cos(X(2)).*(g.^2.*m.^3.*(m+M).*X(2)+l.*(h+(-1).*domEig.*m).^3.*M.* ...
            (X(3)+(-1).*l.*X(4))+g.*l.*m.*M.*(h.^2.*X(2)+3.*domEig.*m.^2.*( ...
            domEig.*X(2)+X(4))+(-1).*h.*m.*(3.*domEig.*X(2)+2.*X(4))))) ...
            ];

        K = [ 0, ...
            ...
            (-1).*l.*m.^(-2).*(h.^2+(-3).*domEig.*h.*m+3.*domEig.^2.*m.^2).* ...
            M+(-1).*g.*(m+M), ...
            ...
            h+(-1).*h.*m.^(-1).*M+g.^(-1).*l.*m.^(-3).*((-1) ...
            .*h+domEig.*m).^3.*M, ...
            ...
            g.^(-1).*l.*m.^(-3).*(h.^3.*l+(-3).*domEig.* ...
            h.^2.*l.*m+h.*(2.*g+3.*domEig.^2.*l).*m.^2+(-1).*domEig.*(3.*g+ ...
            domEig.^2.*l).*m.^3).*M ...
            ];
    case 2
        EOS = @(t,X) [...
            X(4); ...
            ...
            X(5); ...
            ...
            X(6); ...
            ...
            (1/2).*g.^(-2).*m.^(-5).*((-2).*m+(-3).*M+2.*m.* ...
            cos(2.*X(2))+M.*cos(2.*(X(2)+(-1).*X(3)))).^(-1).*((-4).*g.^3.* ...
            m.^6.*sin(2.*X(2))+12.*g.^3.*m.^6.*X(2)+18.*g.^2.*h.^2.*l.*m.^3.* ...
            M.*X(2)+(-60).*domEig.*g.^2.*h.*l.*m.^4.*M.*X(2)+24.*g.^3.*m.^5.* ...
            M.*X(2)+60.*domEig.^2.*g.^2.*l.*m.^5.*M.*X(2)+(-3).*g.*h.^4.* ...
            l.^2.*m.*M.*X(3)+15.*domEig.*g.*h.^3.*l.^2.*m.^2.*M.*X(3)+(-18).* ...
            g.^2.*h.^2.*l.*m.^3.*M.*X(3)+(-30).*domEig.^2.*g.*h.^2.*l.^2.* ...
            m.^3.*M.*X(3)+60.*domEig.*g.^2.*h.*l.*m.^4.*M.*X(3)+30.* ...
            domEig.^3.*g.*h.*l.^2.*m.^4.*M.*X(3)+(-18).*g.^3.*m.^5.*M.*X(3)+( ...
            -60).*domEig.^2.*g.^2.*l.*m.^5.*M.*X(3)+(-15).*domEig.^4.*g.* ...
            l.^2.*m.^5.*M.*X(3)+4.*g.^2.*h.*m.^5.*X(4)+(-3).*h.^5.*l.^2.*M.*X( ...
            4)+15.*domEig.*h.^4.*l.^2.*m.*M.*X(4)+(-30).*domEig.^2.*h.^3.* ...
            l.^2.*m.^2.*M.*X(4)+30.*domEig.^3.*h.^2.*l.^2.*m.^3.*M.*X(4)+6.* ...
            g.^2.*h.*m.^4.*M.*X(4)+(-15).*domEig.^4.*h.*l.^2.*m.^4.*M.*X(4)+ ...
            3.*domEig.^5.*l.^2.*m.^5.*M.*X(4)+(-4).*g.^2.*h.*m.^5.*cos(2.*X(2) ...
            ).*X(4)+3.*h.^5.*l.^3.*M.*X(5)+(-15).*domEig.*h.^4.*l.^3.*m.*M.*X( ...
            5)+30.*domEig.^2.*h.^3.*l.^3.*m.^2.*M.*X(5)+(-30).*domEig.^3.* ...
            h.^2.*l.^3.*m.^3.*M.*X(5)+(-18).*g.^2.*h.*l.*m.^4.*M.*X(5)+15.* ...
            domEig.^4.*h.*l.^3.*m.^4.*M.*X(5)+30.*domEig.*g.^2.*l.*m.^5.*M.*X( ...
            5)+(-3).*domEig.^5.*l.^3.*m.^5.*M.*X(5)+8.*g.^2.*l.*m.^6.*sin(X(2) ...
            ).*X(5).^2+3.*h.^5.*l.^3.*M.*X(6)+(-15).*domEig.*h.^4.*l.^3.*m.* ...
            M.*X(6)+12.*g.*h.^3.*l.^2.*m.^2.*M.*X(6)+30.*domEig.^2.*h.^3.* ...
            l.^3.*m.^2.*M.*X(6)+(-45).*domEig.*g.*h.^2.*l.^2.*m.^3.*M.*X(6)+( ...
            -30).*domEig.^3.*h.^2.*l.^3.*m.^3.*M.*X(6)+18.*g.^2.*h.*l.*m.^4.* ...
            M.*X(6)+60.*domEig.^2.*g.*h.*l.^2.*m.^4.*M.*X(6)+15.*domEig.^4.* ...
            h.*l.^3.*m.^4.*M.*X(6)+(-30).*domEig.*g.^2.*l.*m.^5.*M.*X(6)+(-30) ...
            .*domEig.^3.*g.*l.^2.*m.^5.*M.*X(6)+(-3).*domEig.^5.*l.^3.*m.^5.* ...
            M.*X(6)+2.*g.^2.*l.*m.^6.*sin(2.*X(2)+(-1).*X(3)).*X(6).^2+2.* ...
            g.^2.*l.*m.^6.*sin(X(3)).*X(6).^2+cos(2.*(X(2)+(-1).*X(3))).*((-2) ...
            .*g.^3.*m.^5.*(2.*m.*X(2)+4.*M.*X(2)+(-3).*M.*X(3))+l.^2.*(h+(-1) ...
            .*domEig.*m).^5.*M.*(X(4)+(-1).*l.*(X(5)+X(6)))+g.*l.^2.*m.*M.*( ...
            h.^4.*X(3)+(-10).*domEig.^2.*h.*m.^3.*(domEig.*X(3)+2.*X(6))+5.* ...
            domEig.^3.*m.^4.*(domEig.*X(3)+2.*X(6))+5.*domEig.*h.^2.*m.^2.*( ...
            2.*domEig.*X(3)+3.*X(6))+(-1).*h.^3.*m.*(5.*domEig.*X(3)+4.*X(6))) ...
            +(-2).*g.^2.*m.^3.*M.*(3.*h.^2.*l.*(X(2)+(-1).*X(3))+5.*domEig.* ...
            l.*m.^2.*(2.*domEig.*(X(2)+(-1).*X(3))+X(5)+(-1).*X(6))+h.*m.*(X( ...
            4)+l.*(10.*domEig.*((-1).*X(2)+X(3))+(-3).*X(5)+3.*X(6)))))); ...
            ....
            (1/2) ...
            .*l.^(-1).*m.^(-1).*((-2).*m+(-3).*M+2.*m.*cos(2.*X(2))+M.*cos(2.* ...
            (X(2)+(-1).*X(3)))).^(-1).*((-8).*g.*m.^2.*sin(X(2))+(-6).*g.*m.* ...
            M.*sin(X(2))+(-2).*g.*m.*M.*sin(X(2)+(-2).*X(3))+2.*m.*(l.*m.^(-2) ...
            .*((-3).*h.^2+10.*domEig.*h.*m+(-10).*domEig.^2.*m.^2).*M+(-2).* ...
            g.*(m+2.*M)).*cos(X(2)+(-2).*X(3)).*X(2)+g.^(-1).*m.^(-3).*(h.^4.* ...
            l.^2+(-5).*domEig.*h.^3.*l.^2.*m+2.*h.^2.*l.*(3.*g+5.*domEig.^2.* ...
            l).*m.^2+(-10).*domEig.*h.*l.*(2.*g+domEig.^2.*l).*m.^3+(6.*g.^2+ ...
            20.*domEig.^2.*g.*l+5.*domEig.^4.*l.^2).*m.^4).*M.*cos(X(2)+(-2).* ...
            X(3)).*X(3)+(-2).*h.*m.*cos(X(2)+(-2).*X(3)).*X(4)+2.*h.*M.*cos(X( ...
            2)+(-2).*X(3)).*X(4)+2.*m.*(h+(-1).*h.*m.^(-1).*M+(1/2).*g.^(-2).* ...
            l.^2.*m.^(-5).*(h+(-1).*domEig.*m).^5.*M).*cos(X(2)+(-2).*X(3)).* ...
            X(4)+4.*h.*l.*m.*X(5)+6.*h.*l.*M.*X(5)+(-4).*h.*l.*m.*cos(2.*X(2)) ...
            .*X(5)+g.^(-2).*l.*m.^(-4).*((-1).*h.^5.*l.^2+5.*domEig.*h.^4.* ...
            l.^2.*m+(-10).*domEig.^2.*h.^3.*l.^2.*m.^2+10.*domEig.^3.*h.^2.* ...
            l.^2.*m.^3+h.*(6.*g.^2+(-5).*domEig.^4.*l.^2).*m.^4+domEig.*((-10) ...
            .*g.^2+domEig.^4.*l.^2).*m.^5).*M.*cos(X(2)+(-2).*X(3)).*X(5)+(-2) ...
            .*h.*l.*M.*cos(2.*(X(2)+(-1).*X(3))).*X(5)+4.*l.*m.^2.*sin(2.*X(2) ...
            ).*X(5).^2+2.*l.*m.*M.*sin(2.*(X(2)+(-1).*X(3))).*X(5).^2+g.^(-2) ...
            .*l.*m.^(-4).*((-1).*h.^5.*l.^2+5.*domEig.*h.^4.*l.^2.*m+(-2).* ...
            h.^3.*l.*(2.*g+5.*domEig.^2.*l).*m.^2+5.*domEig.*h.^2.*l.*(3.*g+ ...
            2.*domEig.^2.*l).*m.^3+(-1).*h.*(6.*g.^2+20.*domEig.^2.*g.*l+5.* ...
            domEig.^4.*l.^2).*m.^4+domEig.*(10.*g.^2+10.*domEig.^2.*g.*l+ ...
            domEig.^4.*l.^2).*m.^5).*M.*cos(X(2)+(-2).*X(3)).*X(6)+2.*l.* ...
            m.^2.*sin(X(2)+(-1).*X(3)).*X(6).^2+4.*l.*m.*M.*sin(X(2)+(-1).*X( ...
            3)).*X(6).^2+2.*l.*m.^2.*sin(X(2)+X(3)).*X(6).^2+3.*g.^(-2).*m.^( ...
            -4).*cos(X(2)).*(2.*g.^3.*m.^5.*(2.*m.*X(2)+4.*M.*X(2)+(-3).*M.*X( ...
            3))+l.^2.*(h+(-1).*domEig.*m).^5.*M.*((-1).*X(4)+l.*(X(5)+X(6)))+ ...
            2.*g.^2.*l.*m.^3.*M.*(3.*h.^2.*(X(2)+(-1).*X(3))+5.*domEig.*m.^2.* ...
            (2.*domEig.*(X(2)+(-1).*X(3))+X(5)+(-1).*X(6))+h.*m.*(10.*domEig.* ...
            ((-1).*X(2)+X(3))+(-3).*X(5)+3.*X(6)))+(-1).*g.*l.^2.*m.*M.*( ...
            h.^4.*X(3)+(-10).*domEig.^2.*h.*m.^3.*(domEig.*X(3)+2.*X(6))+5.* ...
            domEig.^3.*m.^4.*(domEig.*X(3)+2.*X(6))+5.*domEig.*h.^2.*m.^2.*( ...
            2.*domEig.*X(3)+3.*X(6))+(-1).*h.^3.*m.*(5.*domEig.*X(3)+4.*X(6))) ...
            )); ...
            ...
            2.*l.^(-1).*m.^(-1).*((-2).*m+(-3).*M+2.*m.*cos(2.*X(2))+M.* ...
            cos(2.*(X(2)+(-1).*X(3)))).^(-1).*((-2).*l.*m.*M.*sin(X(2)+(-1).* ...
            X(3)).*X(5).^2+(-1/2).*h.*l.*((-2).*m+(-3).*M+2.*m.*cos(2.*X(2))+ ...
            M.*cos(2.*(X(2)+(-1).*X(3)))).*X(6)+(-1/2).*l.*m.*M.*sin(2.*(X(2)+ ...
            (-1).*X(3))).*X(6).^2+g.^(-2).*m.^(-4).*sin(X(2)+(-1).*X(3)).*(2.* ...
            g.^3.*m.^5.*M.*cos(X(2))+sin(X(2)).*(2.*g.^3.*m.^5.*(2.*m.*X(2)+ ...
            4.*M.*X(2)+(-3).*M.*X(3))+l.^2.*(h+(-1).*domEig.*m).^5.*M.*((-1).* ...
            X(4)+l.*(X(5)+X(6)))+2.*g.^2.*l.*m.^3.*M.*(3.*h.^2.*(X(2)+(-1).*X( ...
            3))+5.*domEig.*m.^2.*(2.*domEig.*(X(2)+(-1).*X(3))+X(5)+(-1).*X(6) ...
            )+h.*m.*(10.*domEig.*((-1).*X(2)+X(3))+(-3).*X(5)+3.*X(6)))+(-1).* ...
            g.*l.^2.*m.*M.*(h.^4.*X(3)+(-10).*domEig.^2.*h.*m.^3.*(domEig.*X( ...
            3)+2.*X(6))+5.*domEig.^3.*m.^4.*(domEig.*X(3)+2.*X(6))+5.*domEig.* ...
            h.^2.*m.^2.*(2.*domEig.*X(3)+3.*X(6))+(-1).*h.^3.*m.*(5.*domEig.* ...
            X(3)+4.*X(6)))))) ...
            ];

        K = [0, ...
            ...
            l.*m.^(-2).*((-3).*h.^2+10.*domEig.*h.*m+(-10).*domEig.^2.*m.^2) ...
            .*M+(-2).*g.*(m+2.*M), ...
            ...
            (1/2).*g.^(-1).*m.^(-4).*(h.^4.*l.^2+(-5).* ...
            domEig.*h.^3.*l.^2.*m+2.*h.^2.*l.*(3.*g+5.*domEig.^2.*l).*m.^2+( ...
            -10).*domEig.*h.*l.*(2.*g+domEig.^2.*l).*m.^3+(6.*g.^2+20.* ...
            ...
            domEig.^2.*g.*l+5.*domEig.^4.*l.^2).*m.^4).*M, ...
            h+(-1).*h.*m.^(-1).* ...
            M+(1/2).*g.^(-2).*l.^2.*m.^(-5).*(h+(-1).*domEig.*m).^5.*M, ...
            ...
            (1/2).* ...
            g.^(-2).*l.*m.^(-5).*((-1).*h.^5.*l.^2+5.*domEig.*h.^4.*l.^2.*m+( ...
            -10).*domEig.^2.*h.^3.*l.^2.*m.^2+10.*domEig.^3.*h.^2.*l.^2.*m.^3+ ...
            h.*(6.*g.^2+(-5).*domEig.^4.*l.^2).*m.^4+domEig.*((-10).*g.^2+ ...
            domEig.^4.*l.^2).*m.^5).*M, ...
            ...
            (1/2).*g.^(-2).*l.*m.^(-5).*((-1).* ...
            h.^5.*l.^2+5.*domEig.*h.^4.*l.^2.*m+(-2).*h.^3.*l.*(2.*g+5.* ...
            domEig.^2.*l).*m.^2+5.*domEig.*h.^2.*l.*(3.*g+2.*domEig.^2.*l).* ...
            m.^3+(-1).*h.*(6.*g.^2+20.*domEig.^2.*g.*l+5.*domEig.^4.*l.^2).* ...
            m.^4+domEig.*(10.*g.^2+10.*domEig.^2.*g.*l+domEig.^4.*l.^2).*m.^5) ...
            .*M];

    otherwise
        error(' incorrect number of rods')

end

% save .mat files
filePath = ['functions\EOS\EOS_',num2str(n/2-1,fix(log10(n)))];
save(filePath, "n","K","EOS")

% get the desired output diectly
varargout = { EOS, ...
                n, ...
                K };
