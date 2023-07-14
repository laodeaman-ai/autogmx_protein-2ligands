# autogmx_protein-2ligand
Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk banyak kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 2 ligand. 

Setiap kompleks berada dalam direktori berbeda, dan setiap direktori kompoleks berada pada direktori kerja.
Direktori kompleks berisi file protein dan 2 file ligand.
Tempatkan skrip ini bersama file ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direktori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG".
Pastikan nama file dari ligand memiliki awalan "lig" sehingga terbaca "lig*".
Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG.
Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 1. Untuk simulasi MD kompleks protein-ligan dengan 2 ligan dalam satu sistem, gunakan skrip lain yang telah kami sediakan.
Selamat ber_MD :)
