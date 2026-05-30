godsHand :-
    findAllPemain(ListPemain),
    listLength(ListPemain, Len),
    randomize,
    random(0, 5, N),
    (
            N =:= 0 ->
            pilihPemainRandom1,
            pilihPemainRandom2,
            pemainRandom(1, Pemain1),
            pemainRandom(2, Pemain2),
            findAllKartuPemain(Pemain1, ListKartuPemain1),
            listLength(ListKartuPemain1, Length1),
            (   Length1 > 1 ->
                random(0, Length1, Rand1),
                getElement(ListKartuPemain1, Rand1, Kartu1),
                retract(kartuPemain(Pemain1, Kartu1)),
                asserta(kartuPemain(Pemain2, Kartu1)),
                Kartu1 = kartu(W, J),
                format('Tuhan telah berkehendak.~n', []),
                format('Kartu ~w-~w milik ~w telah berpindah ke tangan ~w!~n~n', [W, J, Pemain1, Pemain2])
                ;
                format('Kalian berbuat baik!~nTuhan tidak marah, seluruh kartu aman.~n~n', [])
            )
        ;
        format('Kalian berbuat baik!~nTuhan tidak marah, seluruh kartu aman.~n~n', [])
    ),
    retractall(pemainRandom(_,_)),
    retractall(temp(_)),
    nomorGiliran(Num),
    beriGiliranNormal(Num).

pilihPemainRandom1 :-
    retractall(temp(_)),
    findAllPemain(ListPemain),
    asserta(temp(ListPemain)),
    lanjutanPPR1.

lanjutanPPR1 :-
    temp(ListPemain),
    listLength(ListPemain, Len),
    random(0, Len, Rand),
    getElement(ListPemain, Rand, Pemain),
    deleteElement(ListPemain, Rand, ListBaru),
    retractall(temp(_)),
    asserta(temp(ListBaru)),
    asserta(pemainRandom(1, Pemain)).

pilihPemainRandom2 :-
    temp(ListPemain),
    listLength(ListPemain, Len),
    random(0, Len, Rand),
    getElement(ListPemain, Rand, Pemain),
    asserta(pemainRandom(2, Pemain)).