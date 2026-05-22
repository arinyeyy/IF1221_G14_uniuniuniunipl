:- dynamic kartuAksiTerakhir/2.
:- dynamic giliranAksiTerakhir/1.
:- dynamic riwayatAksi/3.

giliranAksiTerakhir(0).
listLength(AllPemain, Len),
Num1 is (Num + 1) mod Len,
getElement(AllPemain, Num1, PemainSelanjutnya),

updateKartuAksi(W, J) :-
    giliranAksiTerakhir(Count),
    assertz(riwayatAksi(Count, W, J)),
    retract(giliranAksiTerakhir(Count)),
    assertz(giliranAksiTerakhir(0)),
    retractall(kartuAksiTerakhir(_, _)),
    assertz(kartuAksiTerakhir(W, J)).

updateGiliran :-
    retract(giliranAksiTerakhir(Count)),
    Count1 is (Count + 1),
    assertz(giliranAksiTerakhir(Count1)).

kartuMimic(PemainTerkini) :-
    write('Menelusuri riwayat permainan.'),
    (   kartuAksiTerakhir(_, J)->  
        Efek = J
    ;   
        Efek = wild
    ),

    (   kartuAksiTerakhir(W, J), giliranAksiTerakhir(Count) ->  
        format('Kartu aksi terakhir yang dimainkan: ~w-~w (oleh ~w, ~w giliran lalu)~n', 
        [W, J, Pemain, Count]), % ini gatau nemu nama pemain caranya gimana
        % format('Kartu mimic menyalin efek ~w!~n', [J])
    ;   
        write('Tidak ada kartu aksi sebelumnya, kartu mimic menyalin efek Wild.~n')
    ),

    pilihWarna,
    warnaWildTerpilih(Warna)
    format('Warna aktif sekarang: ~w.~n', [Warna]),

    eksekusiEfek(Efek, PemainSelanjutnya),
    giliran(PemainSelanjutnya),
    format('Giliran ~w.~n~n', [PemainSelanjutnya]),


eksekusiEfek(skip, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Skip! Pemain berikutnya diskip.~n'),
    beriGiliranSkip(PemainTerkini).

eksekusiEfek(draw_two, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Draw Two! Pemain berikutnya +2.~n'),
    ambilBeberapaKartu(PemainSelanjutnya, 2).

eksekusiEfek(reverse, _) :-
    write('Kartu mimic menyalin efek Reverse! Arah permainan dibalik.~n'),
    efek_kartu(kartu(_, reverse)).

eksekusiEfek(wild, _) :-
    write('Kartu mimic menyalin efek Wild! Warna sudah dipilih.~n').

eksekusiEfek(wild_draw_four, PemainSelanjutnya) :-
    write('Kartu mimic menyalin efek Wild Draw Four! Pemain berikutnya +4.~n'),
    ambilBeberapaKartu(PemainSelanjutnya, 4).
