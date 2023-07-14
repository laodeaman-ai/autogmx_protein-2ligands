# autogmx_protein-2ligands
Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 2 ligands. File protein dan kedua ligand dari setiap kompleks berada dalam direktori terpisah, dan setiap direktori berada pada direktori kerja.

#Tempatkan skrip ini bersama ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direkrori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG"
#Pastikan nama ligand memiliki awalan "lig" sehingga terbaca "lig*"
#Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
#Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG
#Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
#Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 2. 
#Untuk simulasi MD kompleks protein-ligan dengan 1 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.
#Selamat ber_MD :)
