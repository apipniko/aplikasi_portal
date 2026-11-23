import 'package:flutter/material.dart';

import '../portal_screen.dart';

class SubmissionsScreen extends StatelessWidget {
  const SubmissionsScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Tugas Masuk Siswa',
    subtitle: 'Kelas 4A aktif · Semester Genap 2024/2025',
    icon: Icons.inbox,
    search: true,
    form: false,
    primaryAction: null,
    cards: [
      PortalCardData(
        'Ringkasan pengumpulan',
        '18 dari 21 terkumpul · 3 perlu dinilai · 15 selesai',
        Icons.assignment_turned_in,
        action: 'Lihat ringkasan',
      ),
      PortalCardData(
        'Kemuhammadiyahan · Tugas 2',
        'Resume biografi K.H. Ahmad Dahlan · 3 kiriman baru',
        Icons.menu_book,
        action: 'Periksa kiriman',
      ),
      PortalCardData(
        'Tenggat & status',
        'Tenggat kemarin pukul 14.00 · 19/21 terkumpul · 2 belum',
        Icons.schedule,
        action: 'Lihat siswa',
      ),
      PortalCardData(
        'Prioritas hari ini',
        'Urutkan kiriman berdasarkan waktu dan status koreksi',
        Icons.pending_actions,
        action: 'Mulai koreksi',
      ),
      PortalCardData(
        'Buat penugasan baru',
        'Tambahkan tugas untuk rombongan belajar',
        Icons.add_task,
        action: 'Buat tugas',
      ),
    ],
  );
}
