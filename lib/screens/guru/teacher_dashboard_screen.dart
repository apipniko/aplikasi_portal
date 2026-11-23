import 'package:flutter/material.dart';

import '../portal_screen.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Beranda Guru',
    subtitle: 'Assalamu’alaikum Warahmatullah · Rabu Berkah, 05 Maret 2025',
    icon: Icons.school,
    search: false,
    form: false,
    primaryAction: null,
    cards: [
      PortalCardData(
        'Beban mengajar',
        '24 JP per pekan · 100% terpenuhi',
        Icons.menu_book,
      ),
      PortalCardData(
        'Rombel binaan',
        '2 rombel · Kelas 4A & 4B · 41 siswa',
        Icons.groups,
        action: 'Lihat kelas',
      ),
      PortalCardData(
        'Tugas masuk',
        '18 dari 21 berkas · perlu diperiksa',
        Icons.pending_actions,
        action: 'Periksa tugas',
      ),
      PortalCardData(
        'Rerata nilai 4A',
        '86,8 PTS · 95,2% di atas KKM 75',
        Icons.analytics,
        action: 'Input nilai',
      ),
      PortalCardData(
        'Menu tindakan pendidik',
        'Kelola materi, input nilai, jadwal mengajar, dan warta kelas',
        Icons.apps,
        action: 'Buka menu',
      ),
      PortalCardData(
        'Jadwal hari ini · 07.30–09.00',
        'Kemuhammadiyahan kelas 4A · Ruang K-202 · Bab 4 siap',
        Icons.calendar_month,
        action: 'Semua jadwal',
      ),
    ],
  );
}
