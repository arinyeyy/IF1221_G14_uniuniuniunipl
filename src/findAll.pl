findKartu(Input, Input) :- \+ (kartu(W,J), \+ isMember(kartu(W,J),Input)).
findKartu(Input, Output) :- kartu(W,J), \+ isMember(kartu(W,J),Input), !, findKartu([kartu(W,J)|Input], Output).
findAllKartu(List) :- findKartu([], List).

findPemain(Input, Input) :- \+ (pemain(X), \+ isMember(X,Input)).
findPemain(Input, Output) :- pemain(X), \+ isMember(X,Input), !, findPemain([X|Input], Output).
findAllPemain(List) :- findPemain([], List).

findTangan(Nama, Input, Input) :- \+ (kartuPemain(Nama, kartu(W, J)), \+ isMember(kartu(W, J), Input)).
findTangan(Nama, Input, Output) :- kartuPemain(Nama, kartu(W, J)), \+ isMember(kartu(W, J), Input), !, findTangan(Nama, [kartu(W, J)|Input], Output).
findAllTangan(Nama, List) :- findTangan(Nama, [], List).

/* Sumber Kode: https://stackoverflow.com/questions/72682057/implementing-a-simple-version-of-prolog-findall-without-using-the-built-in-finda */