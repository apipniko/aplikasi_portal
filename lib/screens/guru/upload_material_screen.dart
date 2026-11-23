import 'package:flutter/material.dart';

import '../portal_screen.dart';

class UploadMaterialScreen extends StatelessWidget {
  const UploadMaterialScreen({super.key});
  @override
  Widget build(BuildContext context) => PortalScreen(
    title: 'Unggah Materi Baru',
    subtitle: 'Bahan ajar ramah anak untuk pembelajaran di kelas atau belajar mandiri.',
    icon: Icons.upload_file,
    search: false,
    form: true,
    primaryAction: 'Simpan & terbitkan materi',
    cards: [
      PortalCardData(
        'Informasi mata pelajaran',
        'Pilih mapel, bab/tema, dan rombongan belajar',
        Icons.school,
        action: 'Pilih mata pelajaran',
      ),
      PortalCardData(
        'Sasaran rombongan belajar',
        'Kelas 4A Abu Bakar · 21 siswa aktif · otomatis terhubung',
        Icons.groups,
        action: 'Pilih kelas',
      ),
      PortalCardData(
        'Rincian dan petunjuk',
        'Judul materi · deskripsi ramah murid SD',
        Icons.edit_note,
        action: 'Isi rincian',
      ),
      PortalCardData(
        'Format dokumen',
        'Buku/PDF · slide PPTX · video/audio · tautan web',
        Icons.category,
        action: 'Pilih format',
      ),
      PortalCardData(
        'Berkas materi',
        'Pilih dokumen atau media untuk diunggah',
        Icons.attach_file,
        action: 'Pilih berkas',
      ),
      PortalCardData(
        'Publikasi',
        'Tinjau materi sebelum dibagikan ke akun siswa',
        Icons.publish,
        action: 'Terbitkan materi',
      ),
    ],
  );
}
