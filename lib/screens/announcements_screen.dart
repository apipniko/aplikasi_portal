import 'package:flutter/material.dart';

const _page = Color(0xFFF9F9FF);
const _ink = Color(0xFF111C2D);
const _green = Color(0xFF08492A);
const _primary = Color(0xFF0D6E3F);
const _blue = Color(0xFF004C76);
const _gold = Color(0xFFFBBF24);
const _brown = Color(0xFF855300);

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  bool ptsExpanded = false;
  String selectedCategory = 'all';

  static const categories = [
    ('all', 'Semua Agenda'),
    ('resmi', 'Pengumuman Resmi'),
    ('kesiswaan', 'Kegiatan Kesiswaan'),
    ('tarbiyah', 'Kemuhammadiyahan & Tarbiyah'),
    ('ujian', 'Jadwal Ujian'),
  ];

  @override
  Widget build(BuildContext context) {
    final agendas = _agendaData.where((item) {
      return selectedCategory == 'all' ||
          item.categories.contains(selectedCategory);
    }).toList();

    return Scaffold(
      backgroundColor: _page,
      body: Column(
        children: [
          const _InfoHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              children: [
                const _ContextBadge(),
                const SizedBox(height: 12),
                _PtsHero(
                  expanded: ptsExpanded,
                  onPressed: () => setState(() => ptsExpanded = !ptsExpanded),
                ),
                if (ptsExpanded) ...[
                  const SizedBox(height: 8),
                  _PtsRules(
                    onClose: () {
                      setState(() => ptsExpanded = false);
                    },
                  ),
                ],
                const SizedBox(height: 12),
                const _UniformCard(),
                const SizedBox(height: 16),
                const Text(
                  'Kategori & Topik',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (_, index) {
                      final category = categories[index];
                      final active = category.$1 == selectedCategory;
                      return InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () =>
                            setState(() => selectedCategory = category.$1),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: active ? _primary : const Color(0xFFE7EEFF),
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
                if (agendas.isEmpty)
                  const _EmptyAgenda()
                else
                  for (var i = 0; i < agendas.length; i++) ...[
                    _AgendaCard(
                      item: agendas[i],
                      onPressed: () => _showDetail(context, agendas[i].title),
                    ),
                    if (i != agendas.length - 1) const SizedBox(height: 12),
                  ],
                const SizedBox(height: 12),
                const _ContactCard(),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7EEFF),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Text(
                    'Data Contoh Prototipe • Portal Informasi Akademik Siswa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
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

void _showDetail(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Membuka rincian: $title'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

class _InfoHeader extends StatelessWidget {
  const _InfoHeader();

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
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 21),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Info Pengumuman',
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

class _ContextBadge extends StatelessWidget {
  const _ContextBadge();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
              child: _SmallPill(
                text: 'Portal Warta & Agenda Sekolah',
                background: Color(0xFFE8F5EE),
                foreground: _primary,
                icon: Icons.campaign,
              ),
            ),
            SizedBox(width: 8),
            _SmallPill(
              text: 'Genap 2024/2025',
              background: Color(0xFFDEE8FF),
              foreground: Color(0xFF3F4941),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF059669),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                'Pusat pengumuman resmi & kalender kegiatan siswa',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SmallPill extends StatelessWidget {
  const _SmallPill({
    required this.text,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String text;
  final Color background, foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 15, color: foreground),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration get _cardDecoration => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(14),
  boxShadow: const [
    BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
  ],
);

class _PtsHero extends StatelessWidget {
  const _PtsHero({required this.expanded, required this.onPressed});

  final bool expanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00542D), _primary],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: _SmallPill(
                  text: 'PENGUMUMAN PENTING',
                  background: _gold,
                  foreground: _ink,
                  icon: Icons.priority_high,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'No: 114/SDM-TMT/II/2025',
                style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 9),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Persiapan Penilaian Tengah Semester (PTS) Genap 2024/2025',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              height: 1.25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0x1AFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.event, size: 18, color: _gold),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    '03 - 07 Maret 2025 (Senin - Jumat)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Expanded(
                child: _HeroSpec(icon: Icons.groups, text: 'Kelas 1 - 6'),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _HeroSpec(
                  icon: Icons.schedule,
                  text: 'Sesi Pagi & Siang',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              icon: Icon(expanded ? Icons.close : Icons.description, size: 20),
              label: Text(
                expanded
                    ? 'Tutup Panduan PTS'
                    : 'Lihat Panduan & Tata Tertib PTS',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSpec extends StatelessWidget {
  const _HeroSpec({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PtsRules extends StatelessWidget {
  const _PtsRules({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    const rules = [
      'Siswa hadir di madrasah 15 menit sebelum bel masuk (07.00 WIB).',
      'Membawa kartu peserta ujian cetak dan alat tulis pensil 2B.',
      'Mengenakan seragam rapi lengkap sesuai jadwal harian madrasah.',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE7EEFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fact_check, color: _primary, size: 20),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Ringkasan Tata Tertib PTS',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onClose,
                icon: const Icon(Icons.close, size: 18),
              ),
            ],
          ),
          for (final rule in rules) ...[
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 16,
                  color: Color(0xFF059669),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    rule,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _UniformCard extends StatelessWidget {
  const _UniformCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        children: [
          const Row(
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5EE),
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  child: Icon(Icons.checkroom, color: _primary, size: 21),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tata Tertib Seragam Pekan Ini',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Panduan pakaian seragam harian siswa',
                      style: TextStyle(color: Colors.black54, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Icon(Icons.info, size: 20, color: _primary),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: _UniformItem(
                  day: 'Senin - Rabu',
                  name: 'Baju Merah Putih',
                  color: _primary,
                  background: Color(0xFFE8F5EE),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _UniformItem(
                  day: 'Kamis',
                  name: 'Batik Muhammadiyah',
                  color: _primary,
                  background: Color(0xFFE8F5EE),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const _UniformItem(
            day: 'Jumat',
            name: 'Seragam Hizbul Wathan (HW)',
            color: _brown,
            background: Color(0xFFFEF3C7),
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _UniformItem extends StatelessWidget {
  const _UniformItem({
    required this.day,
    required this.name,
    required this.color,
    required this.background,
    this.fullWidth = false,
  });

  final String day, name;
  final Color color, background;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 74),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              day,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            name,
            style: const TextStyle(
              color: _ink,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgendaItem {
  const _AgendaItem({
    required this.categories,
    required this.tag,
    required this.tagIcon,
    required this.tagColor,
    required this.tagBackground,
    required this.date,
    required this.duration,
    required this.title,
    required this.description,
    required this.location,
    required this.locationIcon,
    required this.target,
    required this.targetIcon,
    required this.action,
    required this.topColor,
  });

  final List<String> categories;
  final String tag, date, duration, title, description;
  final String location, target, action;
  final IconData tagIcon, locationIcon, targetIcon;
  final Color tagColor, tagBackground, topColor;
}

const _agendaData = [
  _AgendaItem(
    categories: ['tarbiyah', 'kesiswaan'],
    tag: 'Tarbiyah Ramadhan',
    tagIcon: Icons.mosque,
    tagColor: _primary,
    tagBackground: Color(0xFFE8F5EE),
    date: '20 - 22 Maret 2025',
    duration: '3 Hari Intensif',
    title: 'Baitul Arqam Cilik & Pesantren Kilat Ramadhan 1446 H',
    description: 'Penguatan karakter akhlak mulia, pembiasaan sholat berjamaah, hafalan doa harian, dan kisah teladan.',
    location: 'Masjid Al-Ittihad & Gedung Utama Madrasah',
    locationIcon: Icons.location_on,
    target: 'Sasaran: Kelas 3, 4, 5 (Wajib Hadir)',
    targetIcon: Icons.groups,
    action: 'Rincian Perlengkapan Siswa',
    topColor: Color(0xFF059669),
  ),
  _AgendaItem(
    categories: ['kesiswaan'],
    tag: 'Kepanduan HW',
    tagIcon: Icons.flag,
    tagColor: _brown,
    tagBackground: Color(0xFFFEF3C7),
    date: 'Sabtu, 12 April 2025',
    duration: '07.30 - 14.00',
    title: 'Gebyar Pandu Athfal Hizbul Wathan (HW) Se-Tamantirto',
    description: 'Lomba baris-berbaris, tali temali pionering, semapur, dan pentas seni kepanduan cilik.',
    location: 'Lapangan Olahraga Tamantirto, Kasihan',
    locationIcon: Icons.sports_soccer,
    target: 'Peserta: Qabilah HW Kelas 4 & 5',
    targetIcon: Icons.military_tech,
    action: 'Lihat Rundown Acara & Kesiapan',
    topColor: Color(0xFF38A3A5),
  ),
  _AgendaItem(
    categories: ['tarbiyah', 'resmi'],
    tag: "Tahfidzul Qur'an",
    tagIcon: Icons.auto_stories,
    tagColor: _primary,
    tagBackground: Color(0xFFE8F5EE),
    date: 'Sabtu, 10 Mei 2025',
    duration: 'Juz 30 & 29',
    title: "Wisuda Tahfidz Juz 30 & Uji Tasmi' Qur'an",
    description: 'Apresiasi kelulusan hafalan Al-Qur’an dan pengujian bil-ghaib dihadapan para asatidz.',
    location: 'Aula Utama SD Muhammadiyah Tamantirto',
    locationIcon: Icons.account_balance,
    target: 'Peserta: Siswa Terdaftar Lulus Tasmi’',
    targetIcon: Icons.verified,
    action: 'Cek Daftar Nama Calon Wisudawan',
    topColor: Color(0xFF08785A),
  ),
  _AgendaItem(
    categories: ['resmi', 'ujian'],
    tag: 'Wali Murid',
    tagIcon: Icons.school,
    tagColor: _ink,
    tagBackground: Color(0xFFDEE8FF),
    date: 'Jumat, 20 Juni 2025',
    duration: 'Wali Murid',
    title: 'Pembagian Rapor Semester Genap & Musyawarah POTM',
    description: 'Penyampaian capaian belajar kurikulum terintegrasi tahun ajaran 2024/2025.',
    location: 'Ruang Kelas Masing-Masing',
    locationIcon: Icons.school,
    target: 'Sesi 1: 08.00 - 10.00 | Sesi 2: 10.30 - 11.30',
    targetIcon: Icons.schedule,
    action: 'Unduh Surat Undangan Wali Murid',
    topColor: Color(0xFF00542D),
  ),
];

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({required this.item, required this.onPressed});

  final _AgendaItem item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 118,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [item.topColor.withValues(alpha: .72), item.topColor],
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 18,
                  bottom: -4,
                  child: Icon(
                    item.tagIcon,
                    size: 78,
                    color: Colors.white.withValues(alpha: .25),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: _SmallPill(
                    text: item.tag,
                    background: item.tagBackground,
                    foreground: item.tagColor,
                    icon: item.tagIcon,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 15, color: _brown),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  item.date,
                  style: const TextStyle(
                    color: _brown,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: item.tagBackground,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  item.duration,
                  style: TextStyle(
                    color: item.tagColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: const TextStyle(
              color: _ink,
              fontSize: 16,
              height: 1.25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item.description,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _AgendaInfo(icon: item.locationIcon, text: item.location),
          const SizedBox(height: 5),
          _AgendaInfo(icon: item.targetIcon, text: item.target),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFF0F3FF),
                foregroundColor: _primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              icon: const Icon(Icons.arrow_forward, size: 18),
              iconAlignment: IconAlignment.end,
              label: Text(
                item.action,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgendaInfo extends StatelessWidget {
  const _AgendaInfo({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 17, color: _primary),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _ink,
              fontSize: 11,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyAgenda extends StatelessWidget {
  const _EmptyAgenda();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration,
      child: const Column(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFE8F5EE),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search_off, color: _primary, size: 28),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Belum Ada Agenda untuk Kategori Ini',
            style: TextStyle(
              color: _ink,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Silakan pilih kategori lain atau kembali ke Semua Agenda.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5EE),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(Icons.location_on, color: _primary, size: 22),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SD Muhammadiyah Tamantirto',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Kasihan, Bantul, D.I. Yogyakarta',
                      style: TextStyle(color: Colors.black54, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8F5EE), Color(0xFFCFE4D8)],
              ),
            ),
            child: const Stack(
              children: [
                Positioned(
                  right: 20,
                  bottom: 18,
                  child: Icon(
                    Icons.location_city,
                    size: 82,
                    color: Color(0x660D6E3F),
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 18,
                  child: Icon(Icons.location_on, size: 32, color: _primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const _ContactRow(
            icon: Icons.place,
            text: 'Geblagan, Tamantirto, Kec. Kasihan, Kabupaten Bantul, D.I. Yogyakarta 55183',
          ),
          const SizedBox(height: 6),
          const _ContactRow(
            icon: Icons.call,
            text: '(0274) 387642 • Layanan Tata Usaha Madrasah',
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 17, color: _primary),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 11,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
