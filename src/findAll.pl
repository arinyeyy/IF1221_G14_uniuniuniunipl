findKartu(Input, Input) :- \+ (kartu(W,J), \+ isMember(kartu(W,J),Input)).
findKartu(Input, Output) :- kartu(W,J), \+ isMember(kartu(W,J),Input), !, findKartu([kartu(W,J)|Input], Output).
findAllKartu(List) :- findKartu([], List).

findPemain(Input, Input) :- \+ (pemain(X), \+ isMember(X,Input)).
findPemain(Input, Output) :- pemain(X), \+ isMember(X,Input), !, findPemain([X|Input], Output).
findAllPemain(List) :- findPemain([], List).

<<<<<<< HEAD
=======
<<<<<<< HEAD
findKartuPemain(Nama, Input, Input) :- \+ (kartuPemain(Nama, K), \+ isMember(K, Input)).
findKartuPemain(Nama, Input, Output) :- kartuPemain(Nama, K), \+ isMember(K, Input), !, findKartuPemain(Nama, [K|Input], Output).
findAllKartuPemain(Nama, List) :- findKartuPemain(Nama, [], List).

/* Sumber Kode: https://stackoverflow.com/questions/72682057/implementing-a-simple-version-of-prolog-findall-without-using-the-built-in-finda */
=======
>>>>>>> f565163084e7daaac7f8b3a1d34d1ffb0218d6b7
findTangan(Nama, Input, Input) :- \+ (kartuPemain(Nama, kartu(W, J)), \+ isMember(kartu(W, J), Input)).
findTangan(Nama, Input, Output) :- kartuPemain(Nama, kartu(W, J)), \+ isMember(kartu(W, J), Input), !, findTangan(Nama, [kartu(W, J)|Input], Output).
findAllTangan(Nama, List) :- findTangan(Nama, [], List).

<<<<<<< HEAD
/* Sumber Kode: https://stackoverflow.com/questions/72682057/implementing-a-simple-version-of-prolog-findall-without-using-the-built-in-finda */
=======
/* Sumber Kode: https://stackoverflow.com/questions/72682057/implementing-a-simple-version-of-prolog-findall-without-using-the-built-in-finda */
>>>>>>> 068f2b0 (fix: update findAllTangan)
>>>>>>> f565163084e7daaac7f8b3a1d34d1ffb0218d6b7
