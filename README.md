# autogmx_protein-2ligand
Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk banyak kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 2 ligand. 

1. Satu kompleks berada satu direktori kompleks pada direktori kerja.
2. Satu file protein dan dua file ligand berada dalam satu direktori kompleks.
3. Tempatkan skrip ini bersama file ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direktori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG".
4. Pastikan nama file dari ligand memiliki awalan "lig" sehingga terbaca "lig*"
5. Pastikan nama file resepetor memiliki awalan "rec" sehingga terbaca "rec*"
6. Pastikan ID molekul setiap ligan format pdb merupakan khas ligand, sehingga kedua ligand memiliki ID yang berbeda.
7. Pastikan pada mesin anda telah terinstal gromacs, acpype dan paket-paket dependensinya.
8. Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 2. Untuk simulasi MD kompleks protein-ligan dengan 1 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.

Selamat ber_MD :)
