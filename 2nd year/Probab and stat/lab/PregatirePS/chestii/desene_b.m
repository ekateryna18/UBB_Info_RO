function desene_b(N)
	clf
	hold on
	axis square
	axis off
	pkg load statistics
	k = 0;
	rectangle('Position', [0 0 100 100])
	for step=1:N
		x0 = rand()*98;
		y0 = rand()*98;
        d_centru = pdist([[x0,y0];[50,50]]);
		if  pdist([[x0,y0];[0,0]]) > d_centru
			plot(x0, y0, '*r','MarkerSize', 5)
			k = k + 1;
		elseif  pdist([[x0,y0];[0,50]]) > d_centru
			plot(x0, y0, '*r','MarkerSize', 5)
			k = k + 1;
        elseif  pdist([[x0,y0];[50,0]]) > d_centru
			plot(x0, y0, '*r','MarkerSize', 5)
			k = k + 1;
        elseif  pdist([[x0,y0];[50,50]]) > d_centru
			plot(x0, y0, '*r','MarkerSize', 5)
			k = k + 1;
		end
	end
	k/N
end