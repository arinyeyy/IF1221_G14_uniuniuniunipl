nilaiKartu(kartu(_, 0), 0).
nilaiKartu(kartu(_, 1), 1).
nilaiKartu(kartu(_, 2), 2).
nilaiKartu(kartu(_, 3), 3).
nilaiKartu(kartu(_, 4), 4).
nilaiKartu(kartu(_, 5), 5).
nilaiKartu(kartu(_, 6), 6).
nilaiKartu(kartu(_, 7), 7).
nilaiKartu(kartu(_, 8), 8).
nilaiKartu(kartu(_, 9), 9).
nilaiKartu(kartu(_, skip), 10).
nilaiKartu(kartu(_, reverse), 10).
nilaiKartu(kartu(_, draw_two), 10).
nilaiKartu(kartu(_, wild), 20).
nilaiKartu(kartu(_, wild_draw_four), 20).
nilaiKartu(kartu(_, mimic), 20).

hitungTotalPoin([], Total, Total).
hitungTotalPoin([H|T], TotalSementara, Total) :-
    nilaiKartu(H, Nilai),
    TotalBaru is TotalSementara + Nilai,
    hitungTotalPoin(T, TotalBaru, Total).
hitungPoin(Nama, Poin) :-
    findAllKartuPemain(Nama, Kartu),
    hitungTotalPoin(Kartu, 0, Poin).

tulisNamaKartu([kartu(W,J)]) :- !,
    format('~w-~w', [W, J]).
tulisNamaKartu([kartu(W,J)|T]) :-
    format('~w-~w + ', [W, J]),
    tulisNamaKartu(T).

tulisNilaiKartu([kartu(W,J)]) :- !,
    nilaiKartu(kartu(W,J), N),
    write(N).
tulisNilaiKartu([kartu(W,J)|T]) :-
    nilaiKartu(kartu(W,J), N),
    format('~w + ', [N]),
    tulisNilaiKartu(T).

tampilkanPerhitungan([]).
tampilkanPerhitungan([Nama|T]) :-
    findAllKartuPemain(Nama, Kartu),
    hitungTotalPoin(Kartu, 0, Total),
    write(Nama), write(': '),
    (Kartu = [] ->
        write('kartu habis = 0 poin')
    ;
        tulisNamaKartu(Kartu),
        write(' = '),
        tulisNilaiKartu(Kartu),
        format(' = ~w poin', [Total])
    ), nl,
    tampilkanPerhitungan(T).

cariPosisi([Nama|_], Nama, 0).
cariPosisi([_|T], Nama, Idx) :-
    cariPosisi(T, Nama, Idx1),
    Idx is Idx1 + 1.

buatDataPemain(Nama, data(Poin, JumlahKartu, Idx, Nama)) :-
    hitungPoin(Nama, Poin),
    findAllKartuPemain(Nama, Kartu),
    listLength(Kartu, JumlahKartu),
    allPemain(Semua),
    cariPosisi(Semua, Nama, Idx), !.

ambilNama(data(_, _, _, Nama), Nama).

kumpulkanData([], []).
kumpulkanData([Nama|T], [Data|DataSisa]) :-
    buatDataPemain(Nama, Data),
    kumpulkanData(T, DataSisa).

kumpulkanNama([], []).
kumpulkanNama([Data|T], [Nama|NamaSisa]) :-
    ambilNama(Data, Nama),
    kumpulkanNama(T, NamaSisa).

sisipkanData(Data, [], [Data]).
sisipkanData(Data, [H|T], [Data,H|T]) :-
    Data @=< H, !.
sisipkanData(Data, [H|T], [H|Hasil]) :-
    sisipkanData(Data, T, Hasil).

urutkanData([], []).
urutkanData([H|T], Terurut) :-
    urutkanData(T, TerurutSisa),
    sisipkanData(H, TerurutSisa, Terurut).

urutkanPemenang(Urutan, Terurut) :-
    kumpulkanData(Urutan, SemuaData),
    urutkanData(SemuaData, DataTerurut),
    kumpulkanNama(DataTerurut, Terurut).

tampilkanPemenang([], _).
tampilkanPemenang([Nama|T], Rank) :-
    hitungPoin(Nama, Poin),
    format('~w. ~w (~w poin)~n', [Rank, Nama, Poin]),
    Rank1 is Rank + 1,
    tampilkanPemenang(T, Rank1).

hitungPoinTim(NomorTim, PoinTim) :-
    tim(NomorTim, [P1, P2]),
    hitungPoin(P1, Poin1),
    hitungPoin(P2, Poin2),
    PoinTim is Poin1 + Poin2.

tampilkanPoinTim :-
    write('Berikut perhitungan poin untuk masing-masing tim.'), nl,
    tim(1, [T1P1, T1P2]),
    tim(2, [T2P1, T2P2]),
    hitungPoin(T1P1, PT1P1), hitungPoin(T1P2, PT1P2),
    hitungPoin(T2P1, PT2P1), hitungPoin(T2P2, PT2P2),
    PoinTim1 is PT1P1 + PT1P2,
    PoinTim2 is PT2P1 + PT2P2,
    format('Tim 1 (~w, ~w) : ~w + ~w = ~w poin~n', [T1P1, T1P2, PT1P1, PT1P2, PoinTim1]),
    format('Tim 2 (~w, ~w) : ~w + ~w = ~w poin~n', [T2P1, T2P2, PT2P1, PT2P2, PoinTim2]).

pemenangTim(1) :-
    hitungPoinTim(1, Poin1),
    hitungPoinTim(2, Poin2),
    Poin1 =< Poin2, !.
pemenangTim(2).

endGame :-
    giliran(Pemenang),
    \+kartuPemain(Pemenang, _), !,
    format('Permainan selesai! ~w menghabiskan semua kartunya!~n~n', [Pemenang]),
    allPemain(SemuaPemain),
    write('Berikut perhitungan poin sisa kartu.'), nl,
    tampilkanPerhitungan(SemuaPemain),
    nl,
    (mode(2) ->
        tampilkanPoinTim, nl,
        pemenangTim(TimMenang),
        format('Selamat, Tim ~w menjadi pemenang!~n', [TimMenang])
    ;
        write('Urutan pemenang:'), nl,
        urutkanPemenang(SemuaPemain, Terurut),
        tampilkanPemenang(Terurut, 1),
        nl,
        Terurut = [Juara|_],
        format('Selamat, ~w menjadi pemenang!~n', [Juara])
    ).
