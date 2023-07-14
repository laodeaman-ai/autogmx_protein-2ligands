# autogmx_protein-2ligands
Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 2 ligands. 

1. File protein dan kedua ligand dari setiap kompleks berada dalam direktori terpisah, dan setiap direktori berada pada direktori kerja.
2. Tempatkan skrip ini bersama file ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direktori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG".
3. Pastikan nama file dari ligand memiliki awalan "lig" sehingga terbaca "lig*"
4. Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
5. Pastikan ID molekul setiap ligan format pdb merupakan khas ligand, sehingga kedua ligand memiliki ID yang berbeda.
6. Pastikan pada mesin anda telah terinstal gromacs, acpype dan paket-paket dependensinya.
7. Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 2. Untuk simulasi MD kompleks protein-ligan dengan 1 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.

Selamat ber_MD :)
