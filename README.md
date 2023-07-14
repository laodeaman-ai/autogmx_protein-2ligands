# autogmx_protein-2ligand
Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk banyak kompleks protein-ligand dimana setiap kompleks terdiri dari reseptor dan 2 ligand. 

1. Setiap kompleks berada dalam direktori berbeda, dan setiap direktori kompoleks berada pada direktori kerja.
2. Direktori kompleks berisi file protein dan 2 file ligand format pdb.
3. Tempatkan skrip ini bersama file ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direktori kerja
4. Atur pasangan protein_ligand pada file mdp sebagai "Protein_LIG".
5. Pastikan nama file dari ligand memiliki awalan "lig" sehingga terbaca "lig*".
6. Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
7. Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG.
8. Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
9. Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 1. Untuk simulasi MD kompleks protein-ligan dengan 2 ligan dalam satu sistem, gunakan skrip lain yang telah kami sediakan.
10. Selamat ber_MD :)
