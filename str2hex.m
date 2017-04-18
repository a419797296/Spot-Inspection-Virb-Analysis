function pbDest = str2hex(pbSrc)
len=size(pbSrc,2)/2;
pbDest=zeros(1,len);
for i=1:len
        h1 = pbSrc(i*2-1);
        h2 = pbSrc(i*2);

        s1 = upper(h1) - 48;
        if (s1 > 9) 
            s1 = s1 -7;
        end

        s2 = upper(h2) - 48;
        if (s2 > 9) 
            s2 = s2 -7;
        end

        pbDest(i) = s1*16+ s2;
end