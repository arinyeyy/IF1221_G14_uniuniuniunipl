mainkanKartu(Index) :-
    gameStarted -> (
        giliran(Pemain), !,
        findAllKartuPemain(Pemain, ListKartu),
        Indexriil is Index-1,
        getElement(ListKartu, Indexriil, Kartu),
        discardPileTop([KartuAtas|_]), 
        (
            valid(Kartu, KartuAtas) ->
            ( Kartu = kartu(W,J),
            write(Pemain), format(' memainkan kartu: ~w-~w~n', [W, J]),
            deleteElement(ListKartu, Indexriil, SisaKartu),
            retract(kartuPemain(Pemain, Kartu)), !,
            temp(ListLama),
            retractall(temp(_)),
            asserta(temp([KartuAtas|ListLama])),
            retractall(discardPileTop(_)),
            assertz(discardPileTop([Kartu])),
            efek_kartu(Kartu))
            ;
            write('Kartu tidak valid!'), nl, nl, fail
        )
    );
    write('Permainan belum dimulai!'), nl, nl, fail.

efek_kartu(kartu(_, J)) :- integer(J), !,
                           nomorGiliran(Num),
                           beriGiliranNormal(Num).

efek_kartu(kartu(_, reverse)) :- allPemain(AllPemain),
                                 giliran(Pemain),
                                 reverse(AllPemain, NewList),
                                 retractall(allPemain(_)),
                                 asserta(allPemain(NewList)),
                                 getIndex(NewList, Pemain, Num),
                                 listLength(NewList, Len),
                                 Num1 is (Num + 1) mod Len,
                                 getElement(NewList, Num1, NextP),
                                 retractall(nomorGiliran(_)),
                                 asserta(nomorGiliran(Num1)),
                                 retract(giliran(_)),
                                 asserta(giliran(NextP)),

                                 write('Arah permainan dibalik!'), nl,
                                 format('Giliran ~w.~n', [NextP]).

efek_kartu(kartu(_, skip)) :- nomorGiliran(Num),
                              beriGiliranSkip(Num).

efek_kartu(kartu(_,draw_two)):- nomorGiliran(Num),
                                allPemain(AllPemain),
                                listLength(AllPemain, Len),
                                Num1 is (Num + 1) mod Len,
                                getElement(AllPemain, Num1, PemainSelanjutnya),
                                ambilBeberapaKartu(PemainSelanjutnya, 2),
                                beriGiliranSkip(Num).

efek_kartu(kartu(_, wild)) :- nomorGiliran(Num),
                              pilihWarna,
                              beriGiliranNormal(Num).

efek_kartu(kartu(_, wild_draw_four)) :- nomorGiliran(Num),
                                        asserta(activateTantang),
                                        pilihWarna,
                                        beriGiliranNormal(Num).

valid(Kartu, KartuAtas) :- Kartu = kartu(W, J), KartuAtas = kartu(WAtas, JAtas),
                            (JAtas \== wild, JAtas \== wild-draw-four) ->
                            (
                                (WAtas \== W, J == draw-two) -> fail;
                                (WAtas == W) -> true;
                                (JAtas == J) -> true;
                                (J == wild) -> true;
                                (J == wild-draw-four) -> true;
                                fail
                            );
                            (
                                warnaWildTerpilih(Warna), /*mau ganti jadi warna aktif?*/
                                (Warna == W) -> true;
                                fail
                            ).
                            
pilihWarna :- retractall(warnaWildTerpilih(_)),
              write('Pilih warna (merah/biru/kuning/hijau): '),
              read(Warna),
              (Warna == 'merah') -> asserta(warnaWildTerpilih(merah));
              (Warna == 'biru') -> asserta(warnaWildTerpilih(biru));
              (Warna == 'kuning') -> asserta(warnaWildTerpilih(kuning));
              (Warna == 'hijau') -> asserta(warnaWildTerpilih(hijau));
              nl, write('Warna tidak tersedia!'), nl, pilihWarna.