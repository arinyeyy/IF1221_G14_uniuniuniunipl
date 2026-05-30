tantang :-
    giliran(PemainTerkini),
    nomorGiliran(Num),
    pemainPrev(Num, PemainSebelum),
    retractall(tantangActivated(_)),    
    
    write('Tantangan dilakukan!'), nl,
    format('Memeriksa kartu ~w...~n', [PemainSebelum]), nl,

    (tantangValid(PemainSebelum) -> 
        format('Tantangan berhasil. ~w mendapatkan 4 kartu acak.~n', [PemainSebelum]), nl,
        ambilBeberapaKartu(PemainSebelum, 4), 
        beriGiliranNormal(Num), !
    ;
        format('Tantangan gagal. ~w mendapatkan 6 kartu acak.~n', [PemainTerkini]), nl,
        ambilBeberapaKartu(PemainTerkini, 6), 
        beriGiliranNormal(Num), !
    ).

tantangValid(PemainSebelum) :- /* baca: tantang ke pemain sebelumnya valid*/
    prevDiscardPileTop([PrevCard]),
    punyaKartuValid(PemainSebelum, PrevCard).

cariKartuValid([], _) :- fail.
cariKartuValid([H|T], PrevCard) :-
    (valid(H, PrevCard) -> true ; cariKartuValid(T, PrevCard)).

punyaKartuValid(Pemain, PrevCard) :-
    findAllKartuPemain(Pemain, ListKartu),
    cariKartuValid(ListKartu, PrevCard).