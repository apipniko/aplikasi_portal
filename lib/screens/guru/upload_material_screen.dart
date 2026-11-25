import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);

class UploadMaterialScreen extends StatefulWidget {
  const UploadMaterialScreen({super.key});
  @override
  State<UploadMaterialScreen> createState() => _UploadMaterialScreenState();
}

class _UploadMaterialScreenState extends State<UploadMaterialScreen> {
  String subject = 'Kemuhammadiyahan';
  PlatformFile? selectedFile;
  bool pickingFile = false;
  final subjectOptions = const [
    'Kemuhammadiyahan',
    'Pendidikan Agama Islam',
    'Matematika',
    'Bahasa Indonesia',
    'IPAS',
  ];

  Future<void> _pickMaterialFile() async {
    setState(() => pickingFile = true);
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const [
          'pdf',
          'ppt',
          'pptx',
          'doc',
          'docx',
          'mp4',
          'mp3',
          'm4a',
          'jpg',
          'png',
        ],
      );
      if (!mounted) return;
      if (files.isEmpty) return;

      final file = files.first;
      final sizeInBytes = file.lengthSync() ?? await file.length() ?? 0;
      if (!mounted) return;
      if (sizeInBytes > 25 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ukuran berkas melebihi batas 25 MB.')),
        );
        return;
      }
      setState(() => selectedFile = file);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Berkas gagal dibuka: $error')));
    } finally {
      if (mounted) setState(() => pickingFile = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF9F9FF),
    appBar: AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        tooltip: 'Kembali',
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unggah Materi Baru',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Kelas 4A • Semester Genap',
            style: TextStyle(color: _muted, fontSize: 11),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Text(
            'Draf Materi',
            style: TextStyle(
              color: Color(0xFF855300),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE8F5EE), Color(0xFFF0F3FF)],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.auto_stories, color: _green),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assalamu’alaikum, Ustadzah Rahma',
                      style: TextStyle(
                        color: _green,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Unggah modul atau media ajar interaktif untuk mendukung pembelajaran ananda.',
                      style: TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _FormSection(
          number: '1',
          title: 'Informasi Mata Pelajaran',
          children: [
            const Text(
              'Mata Pelajaran',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: subject,
              decoration: _fieldDecoration(Icons.mosque),
              items: subjectOptions
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => subject = value!),
            ),
            const SizedBox(height: 12),
            const Text(
              'Bab / Tema Pokok Pembelajaran',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              initialValue:
                  'Bab 4: Riwayat KH. Ahmad Dahlan & Perjuangan Hizbul Wathan',
              decoration: _fieldDecoration(Icons.topic),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5EE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.groups, color: _green, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelas 4A Abu Bakar',
                          style: TextStyle(
                            color: _green,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Terdaftar 21 Siswa Aktif',
                          style: TextStyle(color: _muted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Otomatis Terhubung',
                    style: TextStyle(
                      color: _green,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _FormSection(
          number: '2',
          title: 'Rincian & Petunjuk Materi',
          children: [
            const Text(
              'Judul Lengkap Materi',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              initialValue: 'Modul Lengkap Biografi KH Ahmad Dahlan & Nilai Kepedulian Sosial',
              decoration: _fieldDecoration(Icons.title),
            ),
            const SizedBox(height: 12),
            const Text(
              'Petunjuk Belajar Murid',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              initialValue:
                  '1. Bismillah, ananda dapat membaca lembar halaman 1-12.\n'
                  '2. Temukan dan diskusikan 3 teladan perjuangan KH. Ahmad Dahlan.\n'
                  '3. Catat kata-kata baru pada buku catatan ISMUBA.',
              maxLines: 5,
              decoration: _fieldDecoration(Icons.notes),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _FormSection(
          number: '3',
          title: 'Unggah Berkas & Dokumen',
          children: [
            InkWell(
              onTap: pickingFile ? null : _pickMaterialFile,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 22),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F3FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E3FB)),
                ),
                child: Column(
                  children: [
                    Icon(
                      selectedFile == null
                          ? Icons.cloud_upload_outlined
                          : Icons.description_outlined,
                      color: _green,
                      size: 34,
                    ),
                    SizedBox(height: 6),
                    Text(
                      pickingFile
                          ? 'Membuka pemilih berkas...'
                          : '${selectedFile!.name} • ${selectedFile!.extension?.toUpperCase() ?? 'BERKAS'}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'PDF, PPTX, DOC, atau MP4 • Maks. 25 MB',
                      style: TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () {
            if (selectedFile == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pilih berkas materi terlebih dahulu.'),
                ),
              );
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Materi berhasil diterbitkan.')),
            );
          },
          icon: const Icon(Icons.cloud_done),
          label: const Text('Simpan & Terbitkan Materi'),
          style: FilledButton.styleFrom(
            backgroundColor: _green,
            minimumSize: const Size.fromHeight(52),
          ),
        ),
      ],
    ),
  );

  InputDecoration _fieldDecoration(IconData icon) => InputDecoration(
    prefixIcon: Icon(icon, color: _green, size: 20),
    filled: true,
    fillColor: const Color(0xFFF0F3FF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}

class _FormSection extends StatelessWidget {
  const _FormSection({
    required this.number,
    required this.title,
    required this.children,
  });
  final String number, title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: _green,
              foregroundColor: Colors.white,
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: _ink,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...children,
      ],
    ),
  );
}
