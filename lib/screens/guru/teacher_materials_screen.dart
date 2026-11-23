import 'package:flutter/material.dart';

import '../portal_screen.dart';

class TeacherMaterialsScreen extends StatelessWidget {
  const TeacherMaterialsScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Kelola Materi & Tugas',
    subtitle: 'Kelola bahan ajar, tugas masuk, dan mata pelajaran.',
    icon: Icons.folder,
    search: true,
    form: false,
    primaryAction: null,
    cards: [
      PortalCardData(
        'Ringkasan kelas',
        '21 murid · 14 materi ajar · 3 tugas perlu diperiksa',
        Icons.groups,
        action: 'Lihat tugas',
      ),
      PortalCardData(
        'Kemuhammadiyahan · Bab 4',
        'PDF · Biografi tokoh K.H. Ahmad Dahlan · terbit 12 Februari',
        Icons.menu_book,
        action: 'Pratinjau',
      ),
      PortalCardData(
        'IPAS · Bab 5',
        'Slide web · Ekosistem & air Tamantirto',
        Icons.science,
        action: 'Pratinjau',
      ),
      PortalCardData(
        'Matematika',
        'Kelola modul ajar dan tugas untuk kelas',
        Icons.calculate,
        action: 'Kelola',
      ),
      PortalCardData(
        'Unggah materi',
        'Bagikan modul, presentasi, atau video untuk siswa',
        Icons.upload_file,
        action: 'Unggah materi',
      ),
      PortalCardData(
        'Buat penugasan',
        'Susun tugas baru dengan tenggat dan instruksi',
        Icons.add_task,
        action: 'Buat tugas',
      ),
    ],
  );
}
