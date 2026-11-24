import 'package:flutter/material.dart';

import 'material_detail_screen.dart';
import 'pending_assignments_screen.dart';

const _page = Color(0xFFF9F9FF);
const _ink = Color(0xFF111C2D);
const _green = Color(0xFF08492A);
const _primary = Color(0xFF0D6E3F);
const _blue = Color(0xFF004C76);
const _gold = Color(0xFFFBBF24);
const _brown = Color(0xFF855300);

class StudentMaterialsScreen extends StatefulWidget {
  const StudentMaterialsScreen({super.key});

  @override
  State<StudentMaterialsScreen> createState() => _StudentMaterialsScreenState();
}

class _StudentMaterialsScreenState extends State<StudentMaterialsScreen> {
  bool showMaterials = true;
  String selectedCategory = 'all';
  String search = '';
  final searchController = TextEditingController();

  final categories = const [
    ('all', 'Semua Mapel'),
    ('islam', 'Al-Islam/KMD'),
    ('ipas', 'IPAS'),
    ('matematika', 'Matematika'),
    ('indonesia', 'Bhs Indonesia'),
  ];

  List<_MaterialItem> get filteredMaterials {
    final query = search.toLowerCase();
    return _materials.where((item) {
      final matchesCategory =
          selectedCategory == 'all' || item.category == selectedCategory;
      final matchesSearch =
          query.isEmpty || item.searchText.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _page,
      body: Column(
        children: [
          const _MaterialsHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              children: [
                _ContextBanner(),
                const SizedBox(height: 12),
                _TabSelector(
                  showMaterials: showMaterials,
                  onMaterials: () => setState(() => showMaterials = true),
                  onTasks: () => setState(() => showMaterials = false),
                ),
                const SizedBox(height: 12),
                const _MetricStrip(),
                const SizedBox(height: 12),
                _SearchField(
                  controller: searchController,
                  onChanged: (value) => setState(() => search = value),
                  onClear: () {
                    searchController.clear();
                    setState(() => search = '');
                  },
                ),
                if (showMaterials) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (_, index) {
                        final category = categories[index];
                        final active = selectedCategory == category.$1;
                        return InkWell(
                          onTap: () =>
                              setState(() => selectedCategory = category.$1),
                          borderRadius: BorderRadius.circular(999),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: active
                                  ? _primary
                                  : const Color(0xFFDEE8FF),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              category.$2,
                              style: TextStyle(
                                color: active
                                    ? Colors.white
                                    : const Color(0xFF3F4941),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (filteredMaterials.isEmpty)
                    _EmptyState(
                      onReset: () {
                        searchController.clear();
                        setState(() {
                          search = '';
                          selectedCategory = 'all';
                        });
                      },
                    )
                  else
                    for (var i = 0; i < filteredMaterials.length; i++) ...[
                      _MaterialCard(
                        item: filteredMaterials[i],
                        onPressed: () {
                          final material = filteredMaterials[i];
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => MaterialDetailScreen(
                                title: material.title,
                                subject: material.subject,
                                teacher: material.teacher,
                                format: material.format,
                                size: material.category == 'islam'
                                    ? '4.2 MB'
                                    : 'Online',
                                pageCount: material.category == 'islam'
                                    ? 12
                                    : 1,
                                subjectIcon: material.icon,
                              ),
                            ),
                          );
                        },
                      ),
                      if (i != filteredMaterials.length - 1)
                        const SizedBox(height: 10),
                    ],
                ] else ...[
                  const SizedBox(height: 12),
                  _TaskCard(
                    deadline: 'Besok, 17:00 WIB',
                    deadlineColor: Color(0xFF855300),
                    deadlineBackground: Color(0xFFFEF3C7),
                    subject: 'Matematika',
                    subjectColor: _brown,
                    subjectBackground: Color(0xFFE8F5EE),
                    title: 'Latihan Menghitung Pecahan Sederhana Halaman 42',
                    description: 'Kerjakan soal latihan 1 sampai 10 di buku tulis halus, lalu unggah foto jawaban.',
                    format: 'Format: Foto / PDF',
                    action: 'Kirim Jawaban',
                    actionIcon: Icons.cloud_upload,
                    urgent: true,
                    onPressed: () => _openAssignment(
                      context,
                      title: 'Latihan Menghitung Pecahan Sederhana Halaman 42',
                      subject: 'Matematika',
                      teacher: 'Bpk. Hendra Saputra',
                      deadline: 'Besok, 17.00 WIB',
                      instructions: 'Kerjakan soal latihan 1 sampai 10 di buku tulis halus, lalu unggah foto jawaban dengan jelas.',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _TaskCard(
                    deadline: 'Sabtu, 12:00 WIB',
                    deadlineColor: Color(0xFF93000A),
                    deadlineBackground: Color(0xFFFFDAD6),
                    subject: 'IPAS',
                    subjectColor: _blue,
                    subjectBackground: Color(0xFFE0F2FE),
                    title: 'Pengamatan Sumber Air Bersih di Lingkungan Rumah',
                    description: 'Catat sumber air di rumahmu, amati kejernihan, dan tulis 3 cara menghemat air.',
                    format: 'Formulir Singkat',
                    action: 'Isi Lembar Kerja',
                    actionIcon: Icons.edit_note,
                    onPressed: () => _openAssignment(
                      context,
                      title: 'Pengamatan Sumber Air Bersih di Lingkungan Rumah',
                      subject: 'IPAS',
                      teacher: 'Ibu Rina Wulandari',
                      deadline: 'Sabtu, 12.00 WIB',
                      instructions: 'Catat sumber air di rumahmu, amati kejernihannya, dan tulis tiga cara menghemat air.',
                      isAudio: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const _CompletedTaskCard(),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => const PendingAssignmentsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.assignment_outlined),
                      label: const Text(
                        'Lihat Semua Tugas Perlu Dikirim',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _primary,
                        side: const BorderSide(color: Color(0xFFBFCED0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _openAssignment(
  BuildContext context, {
  required String title,
  required String subject,
  required String teacher,
  required String deadline,
  required String instructions,
  bool isAudio = true,
}) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) => PendingAssignmentsScreen(
        title: title,
        subject: subject,
        teacher: teacher,
        deadline: deadline,
        instructions: instructions,
        isAudio: isAudio,
      ),
    ),
  );
}

class _MaterialsHeader extends StatelessWidget {
  const _MaterialsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xF2F9F9FF),
        boxShadow: [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/school_logo.png',
              width: 38,
              height: 38,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Materi dan Tugas',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    SizedBox(
                      width: 6,
                      height: 6,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'SD Muh Tamantirto',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'Siswa',
              style: TextStyle(
                color: _blue,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

class _ContextBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFDEE8FF),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_user, size: 14, color: _blue),
              SizedBox(width: 5),
              Text(
                'Data Simulasi/Contoh Prototipe Akademik',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Materi & Tugas',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Kelas 4A • Semester Genap 2024/2025',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 44,
              height: 44,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5EE),
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
                child: Icon(Icons.auto_stories, color: _primary, size: 24),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector({
    required this.showMaterials,
    required this.onMaterials,
    required this.onTasks,
  });

  final bool showMaterials;
  final VoidCallback onMaterials, onTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE7EEFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              active: showMaterials,
              icon: Icons.library_books,
              text: 'Modul Ajar (5)',
              onTap: onMaterials,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _TabButton(
              active: !showMaterials,
              icon: Icons.assignment_late,
              text: 'Tugas Siswa (2)',
              onTap: onTasks,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.active,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final bool active;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _primary : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: active ? Colors.white : Colors.black54),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: active ? Colors.white : Colors.black54,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricStrip extends StatelessWidget {
  const _MetricStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5EE),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Icon(Icons.menu_book, size: 16, color: _primary),
                  ),
                ),
                SizedBox(width: 7),
                Flexible(
                  child: Text(
                    '5 Modul Lengkap',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _gold,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Icon(Icons.schedule, size: 16, color: _brown),
                  ),
                ),
                SizedBox(width: 7),
                Flexible(
                  child: Text(
                    '2 Tugas Perlu Dikirim',
                    style: TextStyle(
                      color: _brown,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: _ink, fontSize: 13),
      decoration: InputDecoration(
        hintText: 'Cari topik pembelajaran atau tugas...',
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 12),
        prefixIcon: const Icon(Icons.search, size: 20, color: Colors.black45),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.cancel, size: 18, color: Colors.black45),
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _MaterialItem {
  const _MaterialItem({
    required this.category,
    required this.subject,
    required this.format,
    required this.title,
    required this.teacher,
    required this.status,
    required this.statusIcon,
    required this.action,
    required this.actionIcon,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.searchText,
  });

  final String category, subject, format, title, teacher, status, action;
  final String searchText;
  final IconData statusIcon, actionIcon, icon;
  final Color iconColor, iconBackground;
}

const _materials = [
  _MaterialItem(
    category: 'islam',
    subject: 'Al-Islam & KMD',
    format: 'PDF • 4.2 MB',
    title: 'Mengenal Tokoh Teladan K.H. Ahmad Dahlan',
    teacher: 'Ust. Fajar Anshori, S.Pd.I',
    status: 'Tersedia Offline',
    statusIcon: Icons.check_circle,
    action: 'Buka Materi',
    actionIcon: Icons.arrow_forward,
    icon: Icons.mosque,
    iconColor: _primary,
    iconBackground: Color(0xFFE8F5EE),
    searchText:
        'Mengenal Tokoh Teladan K.H. Ahmad Dahlan Al-Islam Kemuhammadiyahan',
  ),
  _MaterialItem(
    category: 'ipas',
    subject: 'IPAS (Sains & Sosial)',
    format: '18 Slide Interaktif',
    title: 'Siklus Air & Kelestarian Lingkungan Tamantirto',
    teacher: 'Ibu Rina Wulandari, S.Pd.',
    status: 'Presentasi Web',
    statusIcon: Icons.slideshow,
    action: 'Buka Materi',
    actionIcon: Icons.play_circle,
    icon: Icons.water_drop,
    iconColor: _blue,
    iconBackground: Color(0xFFE0F2FE),
    searchText: 'Siklus Air Kelestarian Lingkungan Tamantirto IPAS',
  ),
  _MaterialItem(
    category: 'matematika',
    subject: 'Matematika',
    format: 'Video • 12 Menit',
    title: 'Petualangan Pecahan Senilai & Sederhana',
    teacher: 'Bpk. Hendra Saputra, M.Pd.',
    status: 'Kuis Terintegrasi',
    statusIcon: Icons.smart_display,
    action: 'Buka Materi',
    actionIcon: Icons.play_arrow,
    icon: Icons.calculate,
    iconColor: _brown,
    iconBackground: Color(0xFFFEF3C7),
    searchText: 'Petualangan Pecahan Senilai Sederhana Matematika',
  ),
  _MaterialItem(
    category: 'indonesia',
    subject: 'Bhs Indonesia',
    format: 'Cerita & Kuis',
    title: 'Menemukan Gagasan Pokok Cerita Rakyat Bantul',
    teacher: 'Ibu Siti Nurjanah, S.Pd.',
    status: 'Membaca Cepat',
    statusIcon: Icons.menu_book,
    action: 'Buka Materi',
    actionIcon: Icons.menu_book,
    icon: Icons.history_edu,
    iconColor: Color(0xFFE11D48),
    iconBackground: Color(0xFFFFDAD6),
    searchText: 'Menemukan Gagasan Pokok Cerita Rakyat Bantul Bahasa Indonesia',
  ),
];

BoxDecoration get _cardDecoration => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(14),
  boxShadow: const [
    BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
  ],
);

class _MaterialCard extends StatelessWidget {
  const _MaterialCard({required this.item, required this.onPressed});

  final _MaterialItem item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: item.iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.iconColor, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: item.iconBackground,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            item.subject,
                            style: TextStyle(
                              color: item.iconColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7EEFF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            item.format,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: item.iconColor),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            item.teacher,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE7EEFF))),
            ),
            child: Row(
              children: [
                Icon(item.statusIcon, size: 16, color: item.iconColor),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item.status,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: FilledButton.icon(
                    onPressed: onPressed,
                    style: FilledButton.styleFrom(
                      backgroundColor: _primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    icon: Icon(item.actionIcon, size: 17),
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      item.action,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: _cardDecoration,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFDEE8FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off,
              size: 30,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Belum Ada Materi Ditemukan',
            style: TextStyle(
              color: _ink,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Coba gunakan kata kunci lain atau pilih Semua Mapel.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onReset,
            style: FilledButton.styleFrom(
              backgroundColor: _primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: const Text(
              'Tampilkan Semua Materi',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.deadline,
    required this.deadlineColor,
    required this.deadlineBackground,
    required this.subject,
    required this.subjectColor,
    required this.subjectBackground,
    required this.title,
    required this.description,
    required this.format,
    required this.action,
    required this.actionIcon,
    required this.onPressed,
    this.urgent = false,
  });

  final String deadline, subject, title, description, format, action;
  final Color deadlineColor, deadlineBackground, subjectColor;
  final Color subjectBackground;
  final IconData actionIcon;
  final VoidCallback onPressed;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _TaskPill(
                  text: 'Batas: $deadline',
                  color: deadlineColor,
                  background: deadlineBackground,
                  icon: urgent ? Icons.schedule : Icons.event,
                ),
              ),
              const SizedBox(width: 6),
              _TaskPill(
                text: subject,
                color: subjectColor,
                background: subjectBackground,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 15,
              height: 1.25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE7EEFF))),
            ),
            child: Row(
              children: [
                Icon(
                  format.contains('Foto')
                      ? Icons.upload_file
                      : Icons.description,
                  size: 16,
                  color: Colors.black45,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    format,
                    style: const TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: FilledButton.icon(
                    onPressed: onPressed,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFEA619),
                      foregroundColor: _ink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    icon: Icon(actionIcon, size: 18),
                    label: Text(
                      action,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskPill extends StatelessWidget {
  const _TaskPill({
    required this.text,
    required this.color,
    required this.background,
    this.icon,
  });

  final String text;
  final Color color, background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedTaskCard extends StatelessWidget {
  const _CompletedTaskCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5EE),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: _primary),
                    SizedBox(width: 4),
                    Text(
                      'Sudah Dinilai: 95/100',
                      style: TextStyle(
                        color: _primary,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EEFF),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Al-Islam',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Text(
            'Hafalan Surat At-Tin & Terjemahan Singkat',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Catatan Ustadz: "Alhamdulillah makhraj huruf sangat baik dan lancar, pertahankan ya nak!"',
            style: TextStyle(color: Colors.black54, fontSize: 11, height: 1.35),
          ),
        ],
      ),
    );
  }
}
