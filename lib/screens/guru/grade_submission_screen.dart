import 'package:flutter/material.dart';

import '../portal_screen.dart';

class GradeSubmissionScreen extends StatelessWidget {
  const GradeSubmissionScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Koreksi & Nilai Tugas',
    subtitle: 'Kemuhammadiyahan · Semester Genap 2024/2025 · Tepat waktu',
    icon: Icons.grading,
    search: false,
    form: true,
    primaryAction: 'Simpan penilaian',
    cards: [
      PortalCardData(
        'Berkas tugas siswa',
        'Resume_AhmadDahlan_Farhan.pdf · PDF · 1,2 MB',
        Icons.picture_as_pdf,
        action: 'Buka pratinjau',
      ),
      PortalCardData(
        'Pratinjau lembar kerja',
        'Ringkasan perjuangan K.H. Ahmad Dahlan mendirikan Muhammadiyah pada 1912 di Kauman, Yogyakarta.',
        Icons.description,
        action: 'Buka dokumen',
      ),
      PortalCardData(
        'Nilai tugas',
        'Masukkan nilai dan komentar yang membangun untuk siswa',
        Icons.grade,
        action: 'Beri nilai',
      ),
      PortalCardData(
        'Kirim umpan balik',
        'Simpan hasil koreksi pada akun siswa',
        Icons.send,
        action: 'Simpan koreksi',
      ),
    ],
  );
}
