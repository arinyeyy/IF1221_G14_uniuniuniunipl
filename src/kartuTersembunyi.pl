sembunyikanKartu(Index) :-
    giliran(PemainTerkini),
    \+ kartuTersembunyi(PemainTerkini, _),
    findAllKartuPemain(PemainTerkini, ListKartuAwal),
    listLength(ListKartuAwal, LenAwal),
    LenAwal > 1,
    Indexriil is (Index - 1),
    getElement(ListKartuAwal, Indexriil, KartuYGTersembunyi),
    retract(kartuPemain(PemainTerkini, KartuYGTersembunyi)),
    retractall(kartuTersembunyi(_,_)),
    asserta(kartuTersembunyi(PemainTerkini, KartuYGTersembunyi)).

tampilkanKartu :-
    giliran(PemainTerkini),
    kartuTersembunyi(PemainTerkini, KartuYGTersembunyi),
    asserta(kartuPemain(PemainTerkini, KartuYGTersembunyi)),
    retractall(kartuTersembunyi(_,_)).

% cekInfo, uni, tangkap perlu tambahan.
/*flow: 
pemain yang sembunyiin kartu harus:
1. ga pernah sembunyiin kartu sebelumnya
2. punya kartu > 1
kalo valid baru kartu di Index dihapus dari listKartuPemain, di masukkan ke kartuTersembunyi.

tampilkan kartu: KartuYGTersembunyi dipindah dari kartuTersembunyi ke tangan pemain,
bisa keliatan di cekInfo & lihatKartu*/