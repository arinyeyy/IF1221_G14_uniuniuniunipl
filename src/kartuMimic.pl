:- dynamic kartuAksiTerakhir/2.
:- dynamic giliranAksiTerakhir/2.
:- dynamic riwayatAksi/3.

giliranAksiTerakhir(kosong, 0).

updateKartuAksi(W, J) :-
    giliran(PemainAksi),
    giliranAksiTerakhir(PemainAksi, Count),
    assertz(riwayatAksi(Count, W, J)),
    retract(giliranAksiTerakhir(PemainAksi, Count)),
    assertz(giliranAksiTerakhir(PemainAksi, 0)),
    retractall(kartuAksiTerakhir(_, _)),
    assertz(kartuAksiTerakhir(W, J)).

updateGiliranMimic :-
    retract(giliranAksiTerakhir(PemainAksi, Count)),
    Count1 is (Count + 1),
    assertz(giliranAksiTerakhir(PemainAksi, Count1)).

kartuMimic(PemainTerkini) :-
    write('Menelusuri riwayat permainan.'),
    (   kartuAksiTerakhir(_, J)->  
        Efek = J
    ;   
        Efek = wild
    ),

    (   kartuAksiTerakhir(W, J), giliranAksiTerakhir(PemainAksi, Count) ->  
        format('Kartu aksi terakhir yang dimainkan: ~w-~w (oleh ~w, ~w giliran lalu)~n', 
        [W, J, PemainAksi, Count]), 
        % format('Kartu mimic menyalin efek ~w!~n', [J])
    ;   
        write('Tidak ada kartu aksi sebelumnya, kartu mimic menyalin efek Wild.~n')
    ),

    pilihWarna,
    warnaWildTerpilih(Warna),
    format('Warna aktif sekarang: ~w.~n', [Warna]),

    nomorGiliran(Num),
    pemainNext(Num, PemainSelanjutnya),
    eksekusiEfek(Efek, PemainSelanjutnya),
    beriGiliranSkip(Num),
    format('Giliran ~w.~n~n', [PemainSelanjutnya]).
    

eksekusiEfek(skip, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Skip! Pemain berikutnya diskip.~n').

eksekusiEfek(draw_two, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Draw Two! Pemain berikutnya +2.~n'),
    ambilBeberapaKartu(PemainSelanjutnya, 2).

eksekusiEfek(reverse, _) :-
    write('Kartu mimic menyalin efek Reverse! Arah permainan dibalik.~n'),
    allPemain(AllPemain),
    giliran(PemainTerkini),
    balik(AllPemain, NewList),
    retractall(allPemain(_)),
    asserta(allPemain(NewList)),
    getIndex(NewList, PemainTerkini, Num),
    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(Num)).

eksekusiEfek(wild, _) :-
    write('Kartu mimic menyalin efek Wild! Warna sudah dipilih.~n').

eksekusiEfek(wild_draw_four, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Wild Draw Four! Pemain berikutnya +4.~n'),
    asserta(activateTantang),
    ambilBeberapaKartu(PemainSelanjutnya, 4).
