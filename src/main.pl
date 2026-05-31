:- use_module(library(random)).
:- include('miscellaneous.pl').
:- include('mainkanKartu.pl').
:- include('ambilKartu.pl').
:- include('cekInfo.pl').
:- include('lihatCommand.pl').
:- include('lihatKartu.pl').
:- include('lihatCommand.pl').
:- include('findAll.pl').
:- include('kartuMimic.pl').
:- include('kartuTersembunyi.pl').
:- include('turn.pl').
:- include('uni.pl').
:- include('tangkap.pl').
:- include('tantang.pl').
:- include('swapKartu.pl').
:- include('endGame.pl').
:- include('saveGame.pl').
:- include('loadGame.pl').
:- include('godsHand.pl').


:- dynamic(gameStarted/0).
:- dynamic(jumlahPemain/1).
:- dynamic(pemain/1).
:- dynamic(kartuPemain/2).
:- dynamic(allPemain/1).
:- dynamic(allKartu/1).
:- dynamic(tumpukanKartu/1).
:- dynamic(discardPileTop/1).
:- dynamic(nomorGiliran/1).
:- dynamic(prevDiscardPileTop/1).
:- dynamic(giliran/1).
:- dynamic(prevgiliran/1).
:- dynamic(temp/1).
:- dynamic(kartuAksiTerakhir/2).
:- dynamic(giliranAksiTerakhir/2).
:- dynamic(riwayatAksi/3).
:- dynamic(kartuTersembunyi/2).
:- dynamic(arahMain/1).
:- dynamic(riwayatUNI/1).
:- dynamic(mode/1).
:- dynamic(tim/2).
:- dynamic(setim/2).
:- dynamic(aksiYangDapatDilakukan/2).
:- dynamic(swapKartuDilakukan/0).
:- dynamic(pemainRandom/2).
:- dynamic(temporaryList/1).

/* State Game */
:- dynamic(gameStarted/0).
:- dynamic(tantangActivated/1).
:- dynamic(uniActivated/1).
%:- dynamic(tangkap/1).
:- dynamic(tangkapActivated/1).
/* state game ini nyala kalau ada kondisi tertentu, lalu mati di giliran selanjutnya (tiap mainkanKartu hrs dimatiin) */
/* nyalain: asserta; matiin: retractall */
:- dynamic(warnaWildTerpilih/1).

/*Fakta Kartu*/
kartu(merah, 0). 
kartu(merah, 1). 
kartu(merah, 2). 
kartu(merah, 3). 
kartu(merah, 4).
kartu(merah, 5). 
kartu(merah, 6). 
kartu(merah, 7). 
kartu(merah, 8). 
kartu(merah, 9).
kartu(hijau, 0). 
kartu(hijau, 1). 
kartu(hijau, 2). 
kartu(hijau, 3). 
kartu(hijau, 4).
kartu(hijau, 5). 
kartu(hijau, 6). 
kartu(hijau, 7). 
kartu(hijau, 8). 
kartu(hijau, 9).
kartu(biru, 0). 
kartu(biru, 1). 
kartu(biru, 2). 
kartu(biru, 3). 
kartu(biru, 4).
kartu(biru, 5). 
kartu(biru, 6). 
kartu(biru, 7). 
kartu(biru, 8). 
kartu(biru, 9).
kartu(kuning, 0). 
kartu(kuning, 1). 
kartu(kuning, 2). 
kartu(kuning, 3). 
kartu(kuning, 4).
kartu(kuning, 5). 
kartu(kuning, 6). 
kartu(kuning, 7). 
kartu(kuning, 8). 
kartu(kuning, 9).
kartu(merah, skip). 
kartu(hijau, skip). 
kartu(biru, skip). 
kartu(kuning, skip).
kartu(merah, reverse). 
kartu(hijau, reverse). 
kartu(biru, reverse). 
kartu(kuning, reverse).
kartu(merah, draw_two). 
kartu(hijau, draw_two). 
kartu(biru, draw_two). 
kartu(kuning, draw_two).
kartu(hitam, wild). 
kartu(hitam, wild_draw_four). 
kartu(hitam, mimic).

startGame :-  \+gameStarted -> (
                                    retractall(jumlahPemain(_)),
                                    retractall(pemain(_)),
                                    retractall(kartuPemain(_,_)),
                                    retractall(allPemain(_)),
                                    retractall(tumpukanKartu(_)),
                                    retractall(discardPileTop(_)),
                                    retractall(nomorGiliran(_)),
                                    retractall(prevDiscardPileTop(_)),
                                    retractall(giliran(_)),
                                    retractall(prevGiliran(_)),
                                    retractall(mode(_)),
                                    retractall(arahMain(_)),
                                    retractall(temp(_)),
                                    asserta(temp([])),
                                    assertz(riwayatUNI([])),
                                    asserta(gameStarted),
                                    pilihanMode,
                                    inputJumlahPemain
                                ).
                gameStarted -> write('Permainan sudah dimulai!'), nl, nl;
                fail.

inputJumlahPemain :- (mode(1) -> write('Masukkan jumlah pemain: '), read(Jml), nl
                    ; Jml is 4),
                    ((Jml > 1, Jml < 5) -> (asserta(jumlahPemain(Jml)), nl, tambahPemain(Jml));
                    (write('Jumlah pemain harus di antara 2 sampai 4!'), nl, inputJumlahPemain)).

helpTambahPemain(_,0) :- randomizeUrutan. 

helpTambahPemain(X,N) :- N > 0, format('Masukkan nama pemain ~w: ', [X]), read(Nama),
                   (\+pemain(Nama) -> assertz(pemain(Nama)),
                    N1 is N - 1, X1 is X + 1, helpTambahPemain(X1, N1);
                   (pemain(Nama), sudahAdaPemain(X, N))).

sudahAdaPemain(X, N) :- N > 0, write('Pemain sudah ada! Masukkan nama lain: '), read(Nama),
                        (\+pemain(Nama) -> assertz(pemain(Nama)), X1 is X + 1, N1 is N - 1, helpTambahPemain(X1, N1);
                        pemain(Nama), sudahAdaPemain(X, N)).

tambahPemain(N) :- N > 0, X is 1, helpTambahPemain(X,N).

kocokKartu:-
    findAllKartu(AllCards),
    randomizeList(AllCards, Kocok),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(Kocok)).

kocokTumpukan :-
    tumpukanKartu(Cards),
    randomizeList(Cards, NewCards),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(NewCards)).

bagiKartu([]).
bagiKartu([Nama|Sisa]) :-
    ambilTujuh(Nama, 7),
    bagiKartu(Sisa).
 
ambilTujuh(_, 0) :- !.
ambilTujuh(Nama, N) :-
    retract(tumpukanKartu([KartuTeratas|Sisa])),
    KartuTeratas = kartu(W, J),
    assertz(kartuPemain(Nama, KartuTeratas)),
    asserta(tumpukanKartu(Sisa)),
    N1 is N - 1,
    ambilTujuh(Nama, N1).

discardPile :-
    retract(tumpukanKartu([kartu(W, J) | Sisa])),
    (number(J) -> 
    asserta(discardPileTop([kartu(W, J)])),asserta(tumpukanKartu(Sisa));
    append(Sisa, [kartu(W, J)], Baru),asserta(tumpukanKartu(Baru)),
    discardPile).

randomizeUrutan :- findAllPemain(Daftar),
                   randomizeList(Daftar, RandomizedDaftar),
                   asserta(allPemain(RandomizedDaftar)), nl,
                   kocokKartu,
                   bagiKartu(RandomizedDaftar),
                   (mode(2)->bikinTim; true),
                   write('Urutan Pemain: '),
                   writeList(RandomizedDaftar),
                   nl,
                   write('Setiap pemain mendapatkan 7 kartu acak.'),
                   nl, nl,
                   discardPile,
                   writeDiscardTop,
                   asserta(nomorGiliran(0)),
                   asserta(arahMain(kanan)),
                   beriGiliranPertama, !.

writeDiscardTop :- discardPileTop([kartu(W,J)]),
                   format('Kartu Discard Top: ~w-~w~n~n', [W, J]).

beriGiliranPertama :- allPemain(AllPemain),
                      nomorGiliran(Num),
                      getElement(AllPemain, Num, PemainTerkini),
                      asserta(giliran(PemainTerkini)),
                      format('Giliran ~w~n~n', [PemainTerkini]),
                      tentukanAksi(PemainTerkini).

beriGiliranNormal(Num) :-   allPemain(AllPemain),
                            nomorGiliran(Num),
                            
                            listLength(AllPemain, Len),
                            Num1 is (Num + 1) mod Len,

                            getElement(AllPemain, Num1, PemainTerkini),

                            (giliran(PemainSebelum),
                            retractall(prevGiliran(_)),
                            asserta(prevGiliran(PemainSebelum)),

                            retractall(giliran(_)),
                            asserta(giliran(PemainTerkini)),

                            retractall(nomorGiliran(_)),
                            asserta(nomorGiliran(Num1))),

                            format('Giliran ~w.~n', [PemainTerkini]),
                            
                            aktifkanUniJika(PemainTerkini),
                            tentukanAksi(PemainTerkini).

beriGiliranSkip(Num) :- allPemain(AllPemain),
                        nomorGiliran(Num),
                            
                        listLength(AllPemain, Len),
                        Num1 is (Num + 2) mod Len,

                        getElement(AllPemain, Num1, PemainTerkini),

                        (giliran(PemainSebelum),
                        retractall(prevGiliran(_)),
                        asserta(prevGiliran(PemainSebelum)),

                        retractall(giliran(_)),
                        asserta(giliran(PemainTerkini)),

                        retractall(nomorGiliran(_)),
                        asserta(nomorGiliran(Num1))),

                        format('Giliran ~w.~n', [PemainTerkini]),
                        
                        aktifkanUniJika(PemainTerkini),
                        tentukanAksi(PemainTerkini).

pilihanMode:- write('Tersedia 2 mode permainan'),nl,
              write('1. Mode klasik'),nl,
              write('2. Mode turnamen'),nl,
              write('Pilih mode permainan: '),
              read(Mode),nl,
              asserta(mode(Mode)),
              (mode(1) ->
                write('Permainan dimulai dalam mode klasik'),nl
                ;
                mode(2)->
                write('Permainan dimulai dalam mode turnamen'),nl
                ;
                write('Input tidak valid!'), nl, nl, pilihanMode).

bikinTim :- mode(2),
    write('Membentuk tim secara acak...'),nl,nl,
    allPemain(Daftar),
    Daftar=[Pemain1, Pemain2, Pemain3, Pemain4],
    asserta(tim(1, [Pemain1, Pemain3])),
    asserta(tim(2, [Pemain2, Pemain4])),
    asserta(setim(Pemain1, Pemain3)),
    asserta(setim(Pemain3, Pemain1)),
    asserta(setim(Pemain2, Pemain4)),
    asserta(setim(Pemain4, Pemain2)),
    format('Tim 1 : ~w, ~w~n', [Pemain1, Pemain3]),
    format('Tim 2 : ~w, ~w~n', [Pemain2, Pemain4]).

exitGame :- retractall(gameStarted).