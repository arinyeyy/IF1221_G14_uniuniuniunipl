sembunyikanKartu(Index) :-
    giliran(PemainTerkini),
    \+ kartuTersembunyi(PemainTerkini, _),
    findAllKartuPemain(PemainTerkini, ListKartuAwal),
    listLength(ListKartuAwal, LenAwal),
    LenAwal > 1,
    Indexriil is (Index - 1),
    getElement(ListKartuAwal, Indexriil, KartuYGTersembunyi),
    retractall(kartuTersembunyi(_,_)),
    asserta(kartuTersembunyi(PemainTerkini, KartuYGTersembunyi)),
    
    nomorGiliran(Num),
    beriGiliranNormal(Num).

tampilkanKartu :-
    giliran(PemainTerkini),
    kartuTersembunyi(PemainTerkini, _),
    retractall(kartuTersembunyi(_,_)),

    nomorGiliran(Num),
    beriGiliranNormal(Num).

% cekInfo perlu tambahan,  uni & tangkap aman selama cek pake len.
/*flow: 
pemain yang sembunyiin kartu harus:
1. ga pernah sembunyiin kartu sebelumnya
2. punya kartu > 1
kalo valid baru kartu di masukkan ke kartuTersembunyi, lihatKartu normal.

tampilkan kartu: KartuYGTersembunyi dihapus, cekInfo balik normal jumlahnya*/