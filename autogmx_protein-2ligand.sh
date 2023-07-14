#!/bin/bash
#Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 2 ligands. File protein dan kedua ligand dari setiap kompleks berada dalam direktori terpisah, dan setiap direktori berada pada direktori kerja.
#Tempatkan skrip ini bersama ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direkrori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG"
#Pastikan nama ligand memiliki awalan "lig" sehingga terbaca "lig*"
#Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
#Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG
#Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
#Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 1. 
#Untuk simulasi MD kompleks protein-ligan dengan 1 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.
#Selamat ber_MD :)

# Membuat topology protein dan ligan
for dir in */; do
    cd "$dir"
    topol="topol.top"
    rm "$topol"
    cd ..
wait
done

for dir in */; do
    cd "$dir"
    echo -e "6\n1" | gmx pdb2gmx -f rec*.pdb -o protein.pdb -ignh 
    cd ..
wait
done

for dir in */; do
    cd "$dir"   
    for lig_file in lig*.pdb; do
        acpype -i "$lig_file" -c gas
    done
    cd ..
wait
done

for dir in */; do
    cd "$dir"   
    grep -h ATOM protein.pdb lig1.acpype/lig1_NEW.pdb lig2.acpype/lig2_NEW.pdb >| complex.pdb;
    cd ..
wait
done

# MENGEDIT FILE TOPOL.TOP
for dir in */; do
    cd "$dir"   

    # Menyimpan isi file topol.top dalam variabel
    topol_content=$(cat "$topol")

    # Menambahkan baris baru sebelum [ moleculetype ]
    modified_content=$(echo "$topol_content" | sed '/\[ moleculetype \]/i\
; Include ligand topology\
#include "lig.itp"\
')

    # Menambahkan baris baru sebelum #include "posre.itp"
    modified_content=$(echo "$modified_content" | sed '/#include "posre.itp"/a\
#include "lig1-posre.itp"\
#include "lig2-posre.itp"')

    # Mendapatkan ID ligan
    lig1="lig1.acpype/lig1_NEW.pdb"
    lig2="lig2.acpype/lig2_NEW.pdb"
    lig1_id=$(awk 'NR==4{print $4}' "$lig1")
    lig2_id=$(awk 'NR==4{print $4}' "$lig2")

    jml_lig1=1
    jml_lig2=1

    # Menambahkan nilai lig1_id dan jml_lig1 pada baris terakhir
    modified_content=$(echo "$modified_content" | sed -e '$a\
'"$lig1_id\t$jml_lig1"'')

    # Menambahkan nilai lig2_id dan jml_lig2 pada baris terakhir
    modified_content=$(echo "$modified_content" | sed -e '$a\
'"$lig2_id\t$jml_lig2"'')

    # Menyimpan hasil edit ke dalam file topol.top
    echo "$modified_content" > "$topol"
    cd ..
wait
done

#MEMBUAT FILE LIG.ITP SEBAGAI GABUNGAN lig1.itp dan lig2.itp

for dir in */; do
    cd "$dir"

    # Mendapatkan ID ligan
    lig1="lig1.acpype/lig1_NEW.pdb"
    lig2="lig2.acpype/lig2_NEW.pdb"
    lig1_id=$(awk 'NR==4{print $4}' "$lig1")
    lig2_id=$(awk 'NR==4{print $4}' "$lig2")
    
    file1="lig1.acpype/lig1_GMX.itp"
    file2="lig2.acpype/lig2_GMX.itp"

    # Langkah 1: Menggabungkan isi file1 dan file2 sebelum [ atomtypes ] dan menghapus baris yang berulang
    output1=$(awk '/\[ atomtypes \]/{flag=1} !a[$0]++ && !flag' "$file1" "$file2")

    # Langkah 2: Menggabungkan isi file1 dan file2 sesudah [ atomtypes ] dan sebelum [ moleculetype ] dan menghapus baris yang berulang
    output2=$(awk '/\[ atomtypes \]/{flag=1} /\[ moleculetype \]/{flag=0} flag' "$file1" "$file2" | awk '!a[$0]++')

    # Menghapus baris kosong dari output2
    output2=$(echo "$output2" | sed '/^$/d')
    # Langkah 3: Menambahkan isi file1 sesudah baris [ moleculetype ] ke dalam variabel output3
    output3=$(awk '/\[ moleculetype \]/{flag=1} flag' "$file1")

    # Langkah 4: Menambahkan isi file2 sesudah baris [ moleculetype ] ke dalam variabel output4
    output4=$(awk '/\[ moleculetype \]/{flag=1} flag' "$file2")

    # Langkah 5: Menggabungkan output1, baris [ atomtypes ], output2, baris [ moleculetype ], output3, dan output4 ke dalam file lig.itp
    echo "$output1" > "lig.itp"
    echo >> "lig.itp"
    echo "$output2" >> "lig.itp"
    echo >> "lig.itp"
    echo "$output3" >> "lig.itp"
    echo >> "lig.itp"
    echo "$output4" >> "lig.itp"

    # Mengganti teks "lig1" dan lig2 dengan ID
    sed -i "s/lig1/$lig1_id /g" "lig.itp"

    # Mengganti teks "lig2" dengan nilai dari variabel $lig2_id
    sed -i "s/lig2/$lig2_id /g" "lig.itp"

    # Menampilkan pesan berhasil
    echo "File lig.itp berhasil dibuat."
    cd ..
wait
done

# BOX, IONISASI DAN MINIMISASI
for dir in */; do
    cd $dir
    gmx editconf -f complex.pdb -o box.pdb -bt triclinic -d 1.2 -c
    cd ..
wait
done

for dir in */; do
    cd $dir
    gmx solvate -cp box.pdb -cs spc216.gro -p topol.top -o solv.pdb
    cd ..
wait
done

for dir in */; do
    cd $dir
    gmx grompp -f ../ions.mdp -c solv.pdb -p topol.top -o ions.tpr -maxwarn 1 && \
    echo 16 | gmx genion -s ions.tpr -o ions.pdb -p topol.top -pname NA -nname CL -neutral
    cd ..
wait
done

for dir in */; do
    cd $dir
    gmx grompp -f ../em.mdp -c ions.pdb -p topol.top -o em.tpr -maxwarn 1 && \
    gmx mdrun -v -deffnm em
    cd ..
wait
done

for dir in */; do
    cd $dir
    echo -e "10\n0" | gmx energy -f em.edr -o potential.xvg
    cd ..
wait
done
    
for dir in */; do
    cd $dir
    echo -e "2\nq" | gmx make_ndx -f lig1.acpype/lig1_NEW.pdb -o lig1-index.ndx
    cd ..
wait
done
    
for dir in */; do
    cd $dir
    echo -e "3\nq" | gmx genrestr -f lig1.acpype/lig1_NEW.pdb -n lig1-index.ndx -o lig1-posre.itp -fc 1000 1000 1000
    cd ..
wait
done

for dir in */; do
    cd $dir
    echo -e "2\nq" | gmx make_ndx -f lig2.acpype/lig2_NEW.pdb -o lig2-index.ndx
    cd ..
wait
done
    
for dir in */; do
    cd $dir
    echo -e "3\nq" | gmx genrestr -f lig2.acpype/lig2_NEW.pdb -n lig2-index.ndx -o lig2-posre.itp -fc 1000 1000 1000
    cd ..
wait
done

for dir in */; do
    cd $dir
    echo -e "1 | 13 | 14\nq" | gmx make_ndx -f em.gro -o index.ndx    
    cd ..
wait
done

# NVT, NPT DAN PRODUKSI
for dir in */; do
    cd $dir
    # Menyalin file mdp
    cp ../md.mdp .
    cp ../nvt.mdp .
    cp ../npt.mdp .
    cd ..
wait
done

for dir in */; do
    cd $dir
    # Mengganti teks "Protein_LIG" menjadi "Protein_$lig1_id_$lig2_id"
    sed -i "s/Protein_LIG/Protein_${lig1_id}_${lig2_id}/g" nvt.mdp
    sed -i "s/Protein_LIG/Protein_${lig1_id}_${lig2_id}/g" npt.mdp
    sed -i "s/Protein_LIG/Protein_${lig1_id}_${lig2_id}/g" md.mdp
    cd ..
wait
done

for dir in */; do
    cd $dir
    gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -n index.ndx -o nvt.tpr -maxwarn 1 && \
    gmx mdrun -v -s nvt.tpr -deffnm nvt
    cd ..
wait
done

for dir in */; do
    cd $dir
    gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -r nvt.gro -p topol.top -n index.ndx -o npt.tpr -maxwarn 1 && \
    gmx mdrun -v -s npt.tpr -deffnm npt
    cd ..
wait
done

for dir in */; do
    cd $dir
    gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -n index.ndx -o md.tpr -maxwarn 1 && \
    gmx mdrun -v -s md.tpr -deffnm md
    cd ..
wait
done

for dir in */; do
    cd $dir
    find . -type f -name '*#*' -delete
    cd ..
wait
done

echo Succesfully
echo This script written by La Ode Aman, laode_aman@ung.ac.id, Universitas Negeri Gorontalo
