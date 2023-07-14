# autogmx_protein-2ligands
Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 2 ligands. File protein dan kedua ligand dari setiap kompleks berada dalam direktori terpisah, dan setiap direktori berada pada direktori kerja.

1. Tempatkan skrip ini bersama file ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direktori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG"
2. Pastikan nama file dari ligand memiliki awalan "lig" sehingga terbaca "lig*"
3. Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
4. Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG
5. Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
6. Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 2. Untuk simulasi MD kompleks protein-ligan dengan 1 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.
7. Selamat ber_MD :)
