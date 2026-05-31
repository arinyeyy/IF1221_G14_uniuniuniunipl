# IF1221_G14_uniuniuniunipl

## Gambaran Proyek
Proyek ini merupakan sebuah proyek permainan yang bernama UNI; versi prolog dari UNO. Dalam proyek ini, terdapat banyak command yang dapat dilakukan, mulai dari startGame, ambilKartu, mainkanKartu, sampai godsHand. Dalam permainan ini, terdapat dua mode, yakni mode klasik dan mode turnamen. Mode klasik menyajikan permainan yang dapat dimainkan 2-4 orang dan dimainkan secara individu. Sementara itu, mode turnamen dimainkan oleh 4 orang; 4 orang tersebut akan dibagi secara acak ke dalam 2 tim. Dalam mode klasik, seorang pemain dapat menang apabila ia menghabiskan kartunya sementara dalam mode turnamen, sebuah tim dapat menang jika salah satu anggota menghabiskan kartunya.

## Cara Menjalankan Program
Jika belum memiliki file dari saveGame sebelumnya, program dapat dijalankan dengan command startGame. Jika memiliki file dari saveGame, gunakan command loadGame untuk melanjutkan permainan sebelumnya. Permainan yang sudah dimulai tidak dapat dimulai kembali.

## Struktur Repository
src terdiri atas main.pl dan file-file lainnya yang diinclude ke dalam main. docs terdiri atas dokumen penting seperti milestone 1, 2, dan laporan. Berikut ini struktur repository.
```
.
├── README.md
├── docs/
│   ├── Milestone1_G14.pdf
│   ├── Milestone2_G14.pdf
│   └── Laporan_G14.pdf
└── src/
    ├── ambilkartu.pl            /* berisi kebutuhan command ambilKartu */
    ├── cekInfo.pl               /* berisi kebutuhan command cekInfo */
    ├── endGame.pl               /* berisi kebutuhan endGame (mengakhiri permainan) */
    ├── findAll.pl               /* berisi findAll yang dibuat tanpa findall bawaan */
    ├── godsHand.pl              /* berisi kebutuhan command godsHand */
    ├── kartuMimic.pl            /* berisi kebutuhan kartu mimic */
    ├── kartuTersembunyi.pl      /* berisi kebutuhan command sembunyikan/tampilkanKartu */
    ├── lihatCommand.pl          /* berisi kebutuhan command lihatCommand */
    ├── lihatKartu.pl            /* berisi kebutuhan command lihatKartu */
    ├── loadGame.pl              /* berisi kebutuhan command loadGame */
    ├── main.pl                  /* file executable */
    ├── mainkanKartu.pl          /* berisi kebutuhan command mainkanKartu */
    ├── miscellaneous.pl         /* berisi kebutuhan manipulasi list (deleteElement dsb) */
    ├── saveGame.pl              /* berisi kebutuhan command saveGame */
    ├── swapKartu.pl             /* berisi kebutuhan command swapKartu */
    ├── tangkap.pl               /* berisi kebutuhan command tangkap */
    ├── tantang.pl               /* berisi kebutuhan command tantang */
    ├── turn.pl                  /* berisi kebutuhan untuk giliran-giliran seperti skip */
    └── uni.pl                   /* berisi kebutuhan untuk command uni */
```

## Fitur Utama yang Tersedia
* startGame.
* mainkanKartu.
* ambilKartu.
* tantang.
* lihatCommand.
* lihatKartu.
* cekInfo.
* uni.
* tangkap.
* godsHand.
* sembunyikanKartu.
* tampilkanKartu.
* saveGame.
* loadGame.
* endGame.

## Anggota Kelompok:
* 13525043 Aufa Tatsbita Zahra
* 13525097 Arini Karimatunnikmah
* 13525103 Ravinka Fathia Adinegara
* 13525150 Livy Chandra
