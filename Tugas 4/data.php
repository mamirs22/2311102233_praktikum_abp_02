<?php
header('Content-Type: application/json');

// Data simulasi database sederhana
$profil = [
    'nama' => 'Budi',
    'pekerjaan' => 'Web Developer',
    'lokasi' => 'Jakarta'
];

// Mengubah data menjadi format JSON
echo json_encode($profil);
?>