findKartu(Input, Input) :- \+ (kartu(W,J), \+ isMember(kartu(W,J),Input)).
findKartu(Input, Output) :- kartu(W,J), \+ isMember(kartu(W,J),Input), !, findKartu([kartu(W,J)|Input], Output).
findAllKartu(List) :- findKartu([], List).

findPemain(Input, Input) :- \+ (pemain(X), \+ isMember(X,Input)).
findPemain(Input, Output) :- pemain(X), \+ isMember(X,Input), !, findPemain([X|Input], Output).
findAllPemain(List) :- findPemain([], List).

findNomorGiliran(Input, Input) :- \+ (nomorGiliran(X), isMember(X,Input)).
findNomorGiliran(Input, Output) :- giliran(X), \+ isMember(X,Input), !, findNomorGiliran([X|Input], Output).
findAllNomorGiliran(List) :- findNomorGiliran([], List).

findKartuPemain(Nama, Input, Input) :- \+ (kartuPemain(Nama, K), \+ isMember(K, Input)).
findKartuPemain(Nama, Input, Output) :- kartuPemain(Nama, K), \+ isMember(K, Input), !, findKartuPemain(Nama, [K|Input], Output).
findAllKartuPemain(Nama, List) :- findKartuPemain(Nama, [], List).

/* Sumber Kode: https://stackoverflow.com/questions/72682057/implementing-a-simple-version-of-prolog-findall-without-using-the-built-in-finda */
