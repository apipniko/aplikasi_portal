import 'package:flutter/material.dart';

import '../portal_screen.dart';

class TeacherScheduleScreen extends StatelessWidget {
  const TeacherScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Jadwal & Agenda Guru',
    subtitle: 'Agenda mengajar hari Rabu · 3 sesi aktif',
    icon: Icons.calendar_month,
    search: false,
    form: false,
    primaryAction: null,
    cards: [
      PortalCardData(
        '07.30–09.00 · Sesi 1',
        'Kemuhammadiyahan · Kelas 4A · Ruang K-202 · Modul Bab 4 siap',
        Icons.menu_book,
        action: 'Buka materi',
      ),
      PortalCardData(
        '09.30–10.15 · Sesi 2',
        'Bimbingan Adab & Shalat Dhuha · Mushola utama',
        Icons.mosque,
      ),
      PortalCardData(
        '10.30–11.45 · Sesi 3',
        'Kemuhammadiyahan · Kelas 4B · Ruang K-203 · bahan ajar terhubung',
        Icons.menu_book,
        action: 'Buka materi',
      ),
      PortalCardData(
        'Agenda mendatang',
        'Jadwal kegiatan dan agenda kelas berikutnya',
        Icons.event,
        action: 'Semua agenda',
      ),
    ],
  );
}
