updateKartuAksi(W, J) :-
    giliran(PemainAksi),
    (giliranAksiTerakhir(_, Count) -> true ; Count = 0),  
    assertz(riwayatAksi(Count, W, J)),
    retractall(giliranAksiTerakhir(_, _)),
    assertz(giliranAksiTerakhir(PemainAksi, 0)),
    retractall(kartuAksiTerakhir(_, _)),
    assertz(kartuAksiTerakhir(W, J)).

updateGiliranMimic :-
    (giliranAksiTerakhir(PemainAksi, Count) -> true ; PemainAksi = kosong, Count = 0),
    Count1 is (Count + 1),
    retractall(giliranAksiTerakhir(_, _)),
    assertz(giliranAksiTerakhir(PemainAksi, Count1)).

kartuMimic(Num) :-
    write('Menelusuri riwayat permainan.'), nl, nl,
    (   kartuAksiTerakhir(_, J)->  
        Efek = J
    ;   
        Efek = wild
    ),

    (   kartuAksiTerakhir(W, J), giliranAksiTerakhir(PemainAksi, Count) ->  
        format('Kartu aksi terakhir yang dimainkan: ~w-~w (oleh ~w, ~w giliran lalu)~n~n', 
        [W, J, PemainAksi, Count])
        ;   
        write('Tidak ada kartu aksi sebelumnya, kartu mimic menyalin efek kartu wild.'), nl, nl
    ),

    pilihWarna,
    warnaWildTerpilih(Warna),
    format('Warna aktif sekarang: ~w.~n~n', [Warna]),
    
    nomorGiliran(Num),
    pemainNext(Num, PemainSelanjutnya),
    eksekusiEfek(Efek, PemainSelanjutnya).

eksekusiEfek(skip, _) :-
    write('Kartu mimic menyalin efek Skip! Pemain berikutnya diskip.'), nl, nl,
    nomorGiliran(Num),
    beriGiliranSkip(Num).

eksekusiEfek(draw_two, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Draw Two! Pemain berikutnya +2.'), nl, nl,
    ambilBeberapaKartu(PemainSelanjutnya, 2),
    nomorGiliran(Num),
    beriGiliranSkip(Num).

eksekusiEfek(reverse, _) :-
    write('Kartu mimic menyalin efek Reverse! Arah permainan dibalik.'), nl, nl,
    allPemain(AllPemain),
    giliran(PemainTerkini),
    balik(AllPemain, NewList),
    retractall(allPemain(_)),
    asserta(allPemain(NewList)),
    getIndex(NewList, PemainTerkini, Num),
    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(Num)),
    beriGiliranNormal(Num).

eksekusiEfek(wild, _) :-
    write('Kartu mimic menyalin efek Wild! Warna sudah dipilih.'), nl, nl,
    nomorGiliran(Num),
    beriGiliranNormal(Num).

eksekusiEfek(wild_draw_four, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Wild Draw Four! Pemain berikutnya +4.'), nl, nl,
    asserta(activateTantang),
    ambilBeberapaKartu(PemainSelanjutnya, 4),
    nomorGiliran(Num),
    beriGiliranSkip(Num).
