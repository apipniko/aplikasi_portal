import 'package:flutter/material.dart';

import '../portal_screen.dart';

class CreateAssignmentScreen extends StatelessWidget {
  const CreateAssignmentScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Buat Penugasan Baru',
    subtitle: 'Susun penugasan bermakna yang memotivasi siswa.',
    icon: Icons.assignment_add,
    search: false,
    form: true,
    primaryAction: 'Terbitkan penugasan',
    cards: [
      PortalCardData(
        'Target pembelajaran',
        'Pilih mata pelajaran · Kemuhammadiyahan, Al-Islam, Al-Qur’an Hadits, Matematika, IPAS',
        Icons.menu_book,
        action: 'Pilih mapel',
      ),
      PortalCardData(
        'Sasaran murid',
        'Semua (21 siswa) atau kelompok remedial/khusus',
        Icons.groups,
        action: 'Pilih siswa',
      ),
      PortalCardData(
        'Rincian tugas',
        'Judul penugasan · kategori formatif, LKPD, proyek, atau kuis',
        Icons.edit_note,
        action: 'Isi rincian',
      ),
      PortalCardData(
        'Petunjuk untuk siswa',
        'Baca modul Bab 3 halaman 24–28, tulis ringkasan, hias judul, unggah foto tugas.',
        Icons.notes,
        action: 'Ubah instruksi',
      ),
      PortalCardData(
        'Jadwal & tenggat waktu',
        'Atur waktu mulai tayang dan batas pengumpulan',
        Icons.event,
        action: 'Atur tenggat',
      ),
      PortalCardData(
        'Terbitkan penugasan',
        'Simpan draf atau bagikan ke seluruh siswa kelas 4A',
        Icons.send,
        action: 'Terbitkan tugas',
      ),
    ],
  );
}
