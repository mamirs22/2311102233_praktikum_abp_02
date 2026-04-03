<?php

//  Array Asosiatif
$mahasiswa = [
    [
        "nama"        => "Raisa",
        "nim"         => "1111111111",
        "nilai_tugas" => 85,
        "nilai_uts"   => 78,
        "nilai_uas"   => 82,
    ],
    [
        "nama"        => "Muhammad",
        "nim"         => "2222222222",
        "nilai_tugas" => 70,
        "nilai_uts"   => 65,
        "nilai_uas"   => 60,
    ],
    [
        "nama"        => "Amir",
        "nim"         => "3333333333",
        "nilai_tugas" => 100,
        "nilai_uts"   => 100,
        "nilai_uas"   => 100,
    ],
    [
        "nama"        => "Saleh",
        "nim"         => "4444444444",
        "nilai_tugas" => 55,
        "nilai_uts"   => 50,
        "nilai_uas"   => 48,
    ],
    [
        "nama"        => "Dimas",
        "nim"         => "5555555555",
        "nilai_tugas" => 78,
        "nilai_uts"   => 82,
        "nilai_uas"   => 75,
    ],
];

// FUNCTION: Hitung Nilai Akhir (Tugas 30% | UTS 35% | UAS 35%)
function hitungNilaiAkhir(float $tugas, float $uts, float $uas): float
{
    return ($tugas * 0.30) + ($uts * 0.35) + ($uas * 0.35);
}

// FUNCTION: Tentukan Grade
function tentukanGrade(float $nilai): string
{
    if ($nilai >= 85)      return "A";
    elseif ($nilai >= 75)  return "B";
    elseif ($nilai >= 65)  return "C";
    elseif ($nilai >= 55)  return "D";
    else                   return "E";
}

// FUNCTION: Tentukan Status Kelulusan
function tentukanStatus(float $nilai): string
{
    return ($nilai >= 55) ? "Lulus" : "Tidak Lulus";
}

// PROSES DATA dengan Loop
$totalNilai       = 0;
$nilaiTertinggi   = 0;
$mahasiswaDenganNilaiTertinggi = "";
$hasil = [];

foreach ($mahasiswa as $mhs) {
    $nilaiAkhir = hitungNilaiAkhir($mhs["nilai_tugas"], $mhs["nilai_uts"], $mhs["nilai_uas"]);
    $grade      = tentukanGrade($nilaiAkhir);
    $status     = tentukanStatus($nilaiAkhir);

    $totalNilai += $nilaiAkhir;

    if ($nilaiAkhir > $nilaiTertinggi) {
        $nilaiTertinggi   = $nilaiAkhir;
        $mahasiswaDenganNilaiTertinggi = $mhs["nama"];
    }

    $hasil[] = [
        "nama"        => $mhs["nama"],
        "nim"         => $mhs["nim"],
        "tugas"       => $mhs["nilai_tugas"],
        "uts"         => $mhs["nilai_uts"],
        "uas"         => $mhs["nilai_uas"],
        "nilai_akhir" => round($nilaiAkhir, 2),
        "grade"       => $grade,
        "status"      => $status,
    ];
}

$jumlahMahasiswa = count($mahasiswa);
$rataRata        = round($totalNilai / $jumlahMahasiswa, 2);

?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Nilai Mahasiswa</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 14px;
            background: #fff;
            color: #000;
            padding: 30px;
        }
        h2 { margin-bottom: 4px; }
        p.sub { margin: 0 0 20px; font-size: 12px; color: #555; }

        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #000; padding: 7px 10px; text-align: center; }
        th { background: #000; color: #fff; }
        td:nth-child(2) { text-align: left; }
        tr:nth-child(even) td { background: #f5f5f5; }

        .tidak { color: #666; }

        .info {
            border: 1px solid #000;
            padding: 8px 14px;
            display: inline-block;
            margin-right: 10px;
            margin-bottom: 10px;
            font-size: 13px;
        }
        .info span { font-weight: bold; font-size: 16px; display: block; }

        .keterangan { font-size: 12px; color: #444; margin-top: 10px; }
    </style>
</head>
<body>

<h2>Data Nilai Mahasiswa</h2>
<p class="sub">Bobot: Tugas 30% &nbsp;|&nbsp; UTS 35% &nbsp;|&nbsp; UAS 35%</p>

<table>
    <thead>
        <tr>
            <th>No</th>
            <th>Nama</th>
            <th>NIM</th>
            <th>Tugas</th>
            <th>UTS</th>
            <th>UAS</th>
            <th>Nilai Akhir</th>
            <th>Grade</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($hasil as $i => $row) : ?>
        <tr>
            <td><?= $i + 1 ?></td>
            <td><?= htmlspecialchars($row['nama']) ?></td>
            <td><?= $row['nim'] ?></td>
            <td><?= $row['tugas'] ?></td>
            <td><?= $row['uts'] ?></td>
            <td><?= $row['uas'] ?></td>
            <td><strong><?= number_format($row['nilai_akhir'], 2) ?></strong></td>
            <td><strong><?= $row['grade'] ?></strong></td>
            <td class="<?= $row['status'] === 'Lulus' ? '' : 'tidak' ?>">
                <?= $row['status'] ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<div class="info">
    Rata-rata Kelas<span><?= $rataRata ?></span>
</div>
<div class="info">
    Nilai Tertinggi<span><?= $nilaiTertinggi ?></span>
</div>
<div class="info">
    Mahasiswa Dengan Nilai Tertinggi<span><?= htmlspecialchars($mahasiswaDenganNilaiTertinggi) ?></span>
</div>

<p class="keterangan">
    Keterangan: A &ge; 85 &nbsp;|&nbsp; B &ge; 75 &nbsp;|&nbsp; C &ge; 65 &nbsp;|&nbsp; D &ge; 55 &nbsp;|&nbsp; E &lt; 55 (Tidak Lulus)
</p>

</body>
</html>
