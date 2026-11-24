import 'package:flutter/material.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);

class CreateAssignmentScreen extends StatefulWidget {
  const CreateAssignmentScreen({super.key});
  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  String subject = 'Kemuhammadiyahan';
  int category = 0;
  bool targetAll = true;
  bool allowLate = true;
  int weight = 20;
  final selectedFormats = {0, 1};

  final subjects = const [
    'Kemuhammadiyahan',
    'Al-Islam',
    'Al-Qur’an Hadits',
    'Bahasa Arab',
    'IPAS',
    'Matematika',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF9F9FF),
    appBar: AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        tooltip: 'Kembali',
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buat Penugasan Baru',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Kelas 4A Abu Bakar • Semester Genap',
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
            'Draf',
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
              colors: [Color(0xFFE8F5EE), Color(0xFFE0F2FE)],
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
                      'Susun penugasan bermakna yang memotivasi ananda berakhlak mulia.',
                      style: TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _AssignmentSection(
          number: '1',
          title: 'Target Pembelajaran',
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
              decoration: _fieldDecoration(Icons.menu_book),
              items: subjects
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => subject = value!),
            ),
            const SizedBox(height: 12),
            const Text(
              'Sasaran Murid',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _SegmentButton(
                    active: targetAll,
                    icon: Icons.done_all,
                    label: 'Semua (21 Siswa)',
                    onTap: () => setState(() => targetAll = true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SegmentButton(
                    active: !targetAll,
                    icon: Icons.tune,
                    label: 'Remedial / Khusus',
                    onTap: () => setState(() => targetAll = false),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        _AssignmentSection(
          number: '2',
          title: 'Rincian & Instruksi Tugas',
          children: [
            const Text(
              'Judul Penugasan',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              initialValue: 'Resume Biografi Tokoh Pendiri KH Ahmad Dahlan & Nilai Perjuangan',
              decoration: _fieldDecoration(Icons.edit_note),
            ),
            const SizedBox(height: 12),
            const Text(
              'Kategori Penugasan',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3.1,
              children: [
                _CategoryButton(
                  0,
                  category,
                  Icons.assignment,
                  'Tugas Formatif',
                  (value) => setState(() => category = value),
                ),
                _CategoryButton(
                  1,
                  category,
                  Icons.description,
                  'Latihan LKPD',
                  (value) => setState(() => category = value),
                ),
                _CategoryButton(
                  2,
                  category,
                  Icons.palette,
                  'Proyek Mandiri',
                  (value) => setState(() => category = value),
                ),
                _CategoryButton(
                  3,
                  category,
                  Icons.quiz,
                  'Kuis Pemahaman',
                  (value) => setState(() => category = value),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Petunjuk untuk Siswa',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              initialValue:
                  '1. Bacalah lembar modul Kemuhammadiyahan Bab 3 halaman 24-28.\n'
                  '2. Tuliskan ringkasan 1-2 halaman tentang riwayat berdirinya Muhammadiyah.\n'
                  '3. Beri hiasan kaligrafi sederhana pada judul.\n'
                  '4. Foto catatan dan kirimkan sebelum batas waktu.',
              maxLines: 6,
              decoration: _fieldDecoration(Icons.notes),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _AssignmentSection(
          number: '3',
          title: 'Jadwal & Tenggat Waktu',
          children: [
            const Text(
              'Mulai Tayang',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.play_circle, color: _green, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hari Ini, Langsung Tayang',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text('08:00 WIB', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Batas Akhir Pengumpulan',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.event, color: Color(0xFF855300), size: 20),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Jumat, 28 Feb 2025',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '14:00 WIB',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              tileColor: const Color(0xFFF0F3FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text(
                'Izinkan Pengumpulan Terlambat',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              subtitle: const Text(
                'Tetap memberikan tanda dispensasi waktu',
                style: TextStyle(fontSize: 10),
              ),
              value: allowLate,
              onChanged: (value) => setState(() => allowLate = value),
              activeThumbColor: _green,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _AssignmentSection(
          number: '4',
          title: 'Metode & Bobot Penilaian',
          children: [
            const Text(
              'Format Kiriman Siswa',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final item in [
                  (0, Icons.photo_camera, 'Foto Catatan'),
                  (1, Icons.picture_as_pdf, 'Dokumen PDF'),
                  (2, Icons.edit_note, 'Teks Jawaban'),
                ]) ...[
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() {
                        if (selectedFormats.contains(item.$1)) {
                          selectedFormats.remove(item.$1);
                        } else {
                          selectedFormats.add(item.$1);
                        }
                      }),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 74,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: selectedFormats.contains(item.$1)
                              ? const Color(0xFFE8F5EE)
                              : const Color(0xFFF0F3FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.$2,
                              size: 21,
                              color: selectedFormats.contains(item.$1)
                                  ? _green
                                  : _muted,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.$3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedFormats.contains(item.$1)
                                    ? _green
                                    : _muted,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (item.$1 != 2) const SizedBox(width: 6),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Bobot Nilai',
                    style: TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5EE),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$weight%',
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: weight.toDouble(),
              min: 0,
              max: 100,
              divisions: 20,
              activeColor: _green,
              onChanged: (value) => setState(() => weight = value.round()),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Penugasan berhasil diterbitkan')),
            );
          },
          icon: const Icon(Icons.send),
          label: const Text('Terbitkan Penugasan'),
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

class _AssignmentSection extends StatelessWidget {
  const _AssignmentSection({
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
              backgroundColor: const Color(0xFFE8F5EE),
              foregroundColor: _green,
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

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.active,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final bool active;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      height: 44,
      decoration: BoxDecoration(
        color: active ? _green : const Color(0xFFF0F3FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: active ? Colors.white : _muted),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: active ? Colors.white : _muted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton(
    this.value,
    this.selected,
    this.icon,
    this.label,
    this.onSelected,
  );
  final int value, selected;
  final IconData icon;
  final String label;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) {
    final active = value == selected;
    return InkWell(
      onTap: () => onSelected(value),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _green : const Color(0xFFF0F3FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: active ? Colors.white : _muted),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : _muted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
