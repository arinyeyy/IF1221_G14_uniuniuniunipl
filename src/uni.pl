aktifkanUniJika(Pemain) :- findAllKartuPemain(Pemain, ListKartu),
                           listLength(ListKartu, Len),
                           (
                            (Len =:= 2) -> (asserta(uniActivated(Pemain)), true);
                            true
                           ).

uni(Index) :- 
    gameStarted -> 
        (
            giliran(Pemain), !,
            uniActivated(Pemain) ->
                (
                    findAllKartuPemain(Pemain, ListKartu),
                    Indexriil is Index - 1,
                    getElement(ListKartu, Indexriil, Kartu),
                    discardPileTop([KartuAtas|_]),
                    (
                        valid(Kartu, KartuAtas) ->
                            (
                                Kartu = kartu(W, J),
                                format('~w memaikan kartu: ~w-~w~n', [Pemain, W, J]),
                                format('~w menyerukan UNI!~n~n', [Pemain]),
                                riwayatUNI(PemainSudahUNI),
                                appendElement(PemainSudahUNI,Pemain,NewPemainSudahUNI),
                                retract(riwayatUNI(PemainSudahUNI)),
                                asserta(riwayatUNI(NewPemainSudahUNI)),
                                retract(uniActivated(Pemain)),
                                deleteElement(ListKartu, Indexriil, SisaKartu),
                                retract(kartuPemain(Pemain, Kartu)), !,
                                retractall(discardPileTop(_)),
                                assertz(discardPileTop([Kartu])),
                                efek_kartu(Kartu),
                                !
                            );
                        write('Kartu tidak valid!'), nl, nl, fail
                    )
                );
                write('Kartumu tidak menjadi satu di giliran ini!'), nl,
                write('Kamu mendapat 1 kartu sebagai penalti'), nl, nl,
                ambil(Pemain, 1), !
        );
    write('Permainan belum dimulai!'), nl, nl, fail.
