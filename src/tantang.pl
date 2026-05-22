tantang :-
    allPemain(AllPemain),
    giliran(PemainTerkini),
    nomorGiliran(Num),
    listLength(AllPemain, Len),
    Num1 is (Num + 1) mod Len,
    getElement(AllPemain, Num1, PemainSelanjutnya),
    Num2 is (Num - 1 + Len) mod Len,
    getElement(AllPemain, Num2, PemainSebelum),
    
    write('Tantangan dilakukan!'),
    format('Memeriksa kartu ~w...~n', [PemainSebelum]), nl,

    (tantangValid(PemainSebelum) -> 
        format('Tantangan berhasil. ~w mendapatkan 4 kartu acak.~n', [PemainSebelum]), nl,
        ambilBeberapaKartu(PemainSebelum, 4),
        format('Giliran ~w.~n', [PemainSelanjutnya]), !
    ;
        format('Tantangan gagal. ~w mendapatkan 6 kartu acak.~n', [PemainTerkini]), nl,
        ambilBeberapaKartu(PemainTerkini, 6),
        format('Giliran ~w.~n', [PemainSelanjutnya]), !
    )

tantangValid(PemainSebelum) :- /* baca: tantang ke pemain sebelumnya valid*/
    discardPile(List),
    prevDiscardPileTop(List, PrevCard),
    punyaKartuValid(PemainSebelum, PrevCard).

cariKartuValid([], _) :- fail.
cariKartuValid([H|T], PrevCard) :-
    (valid(H, PrevCard) -> true ; cariKartuValid(T, PrevCard)).

punyaKartuValid(Pemain, PrevCard) :-
    kartuPemain(Pemain, ListKartu),
    cariKartuValid(ListKartu, PrevCard).

prevDiscardPileTop([_,X|_], X).