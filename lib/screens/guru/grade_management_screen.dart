import 'package:flutter/material.dart';

import '../portal_screen.dart';

class GradeManagementScreen extends StatelessWidget {
  const GradeManagementScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Buku Nilai Kurikulum ISMUBA',
    subtitle: 'KKM 75 · Mata pelajaran Kemuhammadiyahan · Genap 2024/2025',
    icon: Icons.grade,
    search: true,
    form: false,
    primaryAction: null,
    cards: [
      PortalCardData(
        'Rekap hasil formatif & PTS',
        'Rata-rata 86,8 · ketuntasan 95,2% · tertinggi 98,0',
        Icons.analytics,
        action: 'Lihat rekap',
      ),
      PortalCardData(
        'Komponen penilaian',
        'Formatif 1 & 2 · tugas portofolio · PTS & PAS Genap',
        Icons.check_circle,
        action: 'Pilih komponen',
      ),
      PortalCardData(
        'Farhan Pratama · 4A',
        'NISN 00142981 · laki-laki · predikat Mumtaz (A) · nilai 95',
        Icons.person,
        action: 'Edit nilai',
      ),
      PortalCardData(
        'Input nilai siswa',
        'Cari siswa dan isi nilai per komponen',
        Icons.edit_note,
        action: 'Input nilai',
      ),
      PortalCardData(
        'Simpan perubahan',
        'Validasi nilai sebelum menyimpan rapor',
        Icons.save,
        action: 'Simpan nilai',
      ),
    ],
  );
}
