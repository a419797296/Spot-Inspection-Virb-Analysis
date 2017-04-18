function [h_line]=virb_disp(hObject, eventdata, handles,a_data,Fs,color)
a=a_data;
h_line=zeros(1,4);
% a=a-mean(a)
% Fs = 500;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = size(a,2)            % Length of signal
t = (0:L-1)*T;        % Time vector
nfft=2^nextpow2(L);
df=Fs/nfft;
fmin=2;
fmax=Fs/2-df;


%----------------------------
axes(handles.a_t)
h_line(1)=plot(t,a,'color',color);

% %----------------------------
% axes(handles.a_f)
% 
% A = fft(a,nfft);
% P2 = abs(A/L);
% P1 = P2(1:nfft/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(nfft/2))/nfft;
% h_line(2)=plot(f,P1,'color',color);
% 
% 
% df=Fs/nfft;
% 
% 
% ni=round(fmin/df+1);
% na=round(fmax/df+1);
% dw=2*pi*df;
% w1=0:dw:2*pi*0.5*Fs;
% w2=-2*pi*(0.5*Fs-df):dw:-dw;
% w=[w1,w2];
% 
% a=zeros(1,nfft);
% a(2:nfft-1)=A(2:nfft-1)./w(2:nfft-1);
% a1=imag(a);
% a2=real(a);
% y=a1-a2*i;
% 
% a=zeros(1,nfft);
% a(ni:na)=y(ni:na);
% a(nfft-na+1:nfft-ni+1)=y(nfft-na+1:nfft-ni+1);
% % a(nfft-na+1:nfft-ni+1)=A(nfft-na+1:nfft-ni+1);
% v=ifft(a,nfft);
% v=real(v(1:L));
% % rms=norm(v)/sqrt(L);
% % if color=='r'
% %     set(handles.ch1_norm,'string',num2str(rms))
% %     if rms> 4.5
% %        set(handles.ch1_norm,'foregroundcolor',[1 0 0]) 
% %     else
% %        set(handles.ch1_norm,'foregroundcolor',[0 0 0]) 
% %     end
% % elseif color=='g'
% %     set(handles.ch2_norm,'string',num2str(rms))
% %     if rms> 4.5
% %        set(handles.ch2_norm,'foregroundcolor',[1 0 0]) 
% %     else
% %        set(handles.ch2_norm,'foregroundcolor',[0 0 0]) 
% %     end
% % elseif color=='b'
% %     if rms> 4.5
% %        set(handles.ch3_norm,'foregroundcolor',[1 0 0]) 
% %     else
% %        set(handles.ch3_norm,'foregroundcolor',[0 0 0]) 
% %     end
% %     set(handles.ch3_norm,'string',num2str(rms))    
% % else
% % end
% 
% %----------------------------
% axes(handles.v_t)
% % calc velocity
% % g_a=(a-mean(a))/100*10*1000;s
% % g_a=(a)/100*10*1000;
% % for i=1:L
% %     v(i)=trapz(g_a(1:i))*T;
% % end
% h_line(3)=plot(t,v,'color',color);
% 
% %----------------------------
% axes(handles.v_f)
% V = fft(v,nfft);
% P2 = abs(V/L);
% P1 = P2(1:nfft/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(nfft/2))/nfft;
% % plot(f(1:25/0.1),P1(1:25/0.1))
% h_line(4)=plot(f,P1,'color',color);


