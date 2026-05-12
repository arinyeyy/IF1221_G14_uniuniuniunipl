getAllCards(AllCards) :-
    Angka = [merah-0, merah-1, merah-2, merah-3, merah-4, merah-5, merah-6, merah-7, merah-8, merah-9,
             hijau-0, hijau-1, hijau-2, hijau-3, hijau-4, hijau-5, hijau-6, hijau-7, hijau-8, hijau-9,
             biru-0, biru-1, biru-2, biru-3, biru-4, biru-5, biru-6, biru-7, biru-8, biru-9,
             kuning-0, kuning-1, kuning-2, kuning-3, kuning-4, kuning-5, kuning-6, kuning-7, kuning-8, kuning-9],
    
    Aksi = [merah-skip, hijau-skip, biru-skip, kuning-skip,
            merah-reverse, hijau-reverse, biru-reverse, kuning-reverse,
            merah-draw_two, hijau-draw_two, biru-draw_two, kuning-draw_two],
    
    Wild = [hitam-wild,hitam-wild_draw_four],

    append(Angka, Aksi, Temp),
    append(Temp, Wild, AllCards).

initDeck :-
    % Ambil list kartu yang sudah kita definisikan secara manual
    getAllCards(AllCards),
    
    % Tetap gunakan randomizeList agar urutan pembagian kartu tidak selalu sama
    randomizeList(AllCards, ShuffledDeck),
    
    % Simpan ke memori dinamis
    retractall(deck(_)),
    asserta(deck(ShuffledDeck)).

initDiscardPile :-
    retract(deck([Top|Rest])),
    % Cek apakah kartu angka (misal formatnya Warna-Angka, bukan Warna-Aksi)
    (   (Top = _-Angka, number(Angka)) -> 
        asserta(discardPile([Top])), assertz(deck(Rest))
    ;   % Jika bukan kartu angka, masukkan lagi ke bawah deck dan cari lagi
        append(Rest, [Top], NewDeck),
        retractall(deck(_)),
        asserta(deck(NewDeck)),
        initDiscardPile
    ).