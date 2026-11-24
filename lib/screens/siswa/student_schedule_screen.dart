import 'package:flutter/material.dart';

const _page = Color(0xFFF9F9FF);
const _ink = Color(0xFF111C2D);
const _green = Color(0xFF08492A);
const _primary = Color(0xFF0D6E3F);
const _blue = Color(0xFF004C76);
const _gold = Color(0xFFFBBF24);
const _brown = Color(0xFF855300);

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({super.key});

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen> {
  String selectedDay = 'Senin';

  static const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  @override
  Widget build(BuildContext context) {
    final schedule = _scheduleFor(selectedDay);

    return Scaffold(
      backgroundColor: _page,
      body: Column(
        children: [
          const _ScheduleHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              children: [
                const _ClassInfoCard(),
                const SizedBox(height: 12),
                const _SchoolTimeBanner(),
                const SizedBox(height: 12),
                const Text(
                  'Pilih Hari',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final day = days[index];
                      final active = day == selectedDay;
                      return InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () => setState(() => selectedDay = day),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: active ? _primary : const Color(0xFFDEE8FF),
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x12000000),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            day,
                            style: TextStyle(
                              color: active
                                  ? Colors.white
                                  : const Color(0xFF3F4941),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Agenda Belajar Hari $selectedDay',
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      '${schedule.length} Sesi Belajar',
                      style: const TextStyle(
                        color: _primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...schedule.map(
                  (session) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: session.isBreak
                        ? _BreakSession(session: session)
                        : _LearningSession(session: session),
                  ),
                ),
                const SizedBox(height: 4),
                const _SuppliesCard(),
                const SizedBox(height: 12),
                const _ClassProfileCard(),
                const SizedBox(height: 10),
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info_outline, size: 15, color: Colors.black45),
                      SizedBox(width: 5),
                      Text(
                        'Data simulasi terintegrasi • SD Muh Tamantirto',
                        style: TextStyle(color: Colors.black45, fontSize: 10),
                      ),
                    ],
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

class _ScheduleHeader extends StatelessWidget {
  const _ScheduleHeader();

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
                  'Jadwal Pelajaran',
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

class _ClassInfoCard extends StatelessWidget {
  const _ClassInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                right: -22,
                bottom: -22,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Color(0x80E8F5EE),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: const [
                      _SmallPill(
                        text: 'Tahun Ajaran 2024/2025',
                        background: Color(0xFFE8F5EE),
                        foreground: _primary,
                      ),
                      _SmallPill(
                        text: 'Semester Genap',
                        background: Color(0xFFDEE8FF),
                        foreground: Color(0xFF3F4941),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jadwal Belajar Kelas 4A',
                              style: TextStyle(
                                color: _ink,
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: _blue),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Rombel 4A • Ruang Kelas 04 (Gedung Ibnu Sina Lt. 1)',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5EE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.calendar_month,
                          color: _primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: _gold,
                  child: Text(
                    'SA',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wali Kelas',
                        style: TextStyle(color: Colors.black54, fontSize: 10),
                      ),
                      Text(
                        'Ustzh. Siti Aminah, S.Pd.',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: _primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    icon: const Icon(Icons.download, size: 17),
                    label: const Text(
                      'Unduh PDF',
                      style: TextStyle(
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

class _SchoolTimeBanner extends StatelessWidget {
  const _SchoolTimeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0x66FBBF24),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications_active, size: 20, color: _brown),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WAKTU UTAMA SEKOLAH',
                  style: TextStyle(
                    color: _brown,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Bel Masuk: 07.15 WIB • Shalat Dzuhur: 11.45 WIB',
                  style: TextStyle(
                    color: _brown,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
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

class _SmallPill extends StatelessWidget {
  const _SmallPill({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background, foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
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

class _ScheduleSession {
  const _ScheduleSession({
    required this.subject,
    required this.start,
    required this.end,
    required this.title,
    required this.description,
    required this.accent,
    required this.tint,
    required this.icon,
    this.location = 'Ruang Kelas 04',
    this.teacher,
    this.isBreak = false,
  });

  final String subject, start, end, title, description, location;
  final String? teacher;
  final Color accent, tint;
  final IconData icon;
  final bool isBreak;
}

List<_ScheduleSession> _scheduleFor(String day) {
  if (day == 'Senin') {
    return const [
      _ScheduleSession(
        subject: 'Pembiasaan Pagi',
        start: '07.00',
        end: '07.45 WIB',
        title: "Upacara Bendera & Tadarus Al-Qur'an",
        description:
            'Penumbuhan karakter disiplin, doa bersama, dan hafalan Juz 30.',
        accent: _green,
        tint: Color(0xFFE8F5EE),
        icon: Icons.flag,
        location: 'Lapangan Upacara',
      ),
      _ScheduleSession(
        subject: 'Al-Islam & Kemuhammadiyahan',
        start: '07.45',
        end: '09.05 WIB',
        title: "Al-Qur'an Hadits: Hukum Bacaan Idzhar Halqi",
        description: 'Mempelajari 6 huruf idzhar, pelafalan fasih, dan praktik membaca QS. Al-Falaq.',
        accent: _primary,
        tint: Color(0xFFE8F5EE),
        icon: Icons.auto_stories,
        teacher: 'Ustzh. Siti Aminah',
      ),
      _ScheduleSession(
        subject: 'Istirahat Pagi & Snack Sehat',
        start: '09.05',
        end: '09.30',
        title: 'Istirahat Pagi, Snack Sehat & Shalat Dhuha',
        description: 'Area Serambi Musholla & Kantin Sehat',
        accent: _gold,
        tint: Color(0xFFFFF4C7),
        icon: Icons.bakery_dining,
        location: 'Serambi Musholla',
        isBreak: true,
      ),
      _ScheduleSession(
        subject: 'IPAS (Sains Terpadu)',
        start: '09.30',
        end: '10.40 WIB',
        title: 'Ekosistem di Lingkungan Sekolah',
        description:
            'Observasi komponen biotik & abiotik di kolam dan taman botani.',
        accent: _blue,
        tint: Color(0xFFE0F2FE),
        icon: Icons.science,
        location: 'Lab IPA & Taman Edukasi',
        teacher: 'Pak Budi Santoso, M.Pd.',
      ),
      _ScheduleSession(
        subject: 'Bahasa Indonesia',
        start: '10.40',
        end: '11.45 WIB',
        title: 'Menulis Teks Narasi & Paragraf Deskripsi',
        description: 'Membuat karangan singkat tentang pengalaman berlibur bersama keluarga.',
        accent: _brown,
        tint: Color(0xFFFEF3C7),
        icon: Icons.history_edu,
        teacher: 'Bu Rahmawati, S.Pd.',
      ),
      _ScheduleSession(
        subject: 'Shalat Dzuhur & Makan Siang',
        start: '11.45',
        end: '12.35',
        title: 'Shalat Dzuhur Berjamaah & Makan Bersama',
        description: 'Masjid Al-Ikhlas & Gazebo Sekolah',
        accent: _primary,
        tint: Color(0xFFE8F5EE),
        icon: Icons.mosque,
        isBreak: true,
      ),
      _ScheduleSession(
        subject: 'Muatan Lokal (Basa Jawa)',
        start: '12.35',
        end: '13.45 WIB',
        title: 'Unggah-Ungguh & Tembang Dolanan',
        description: 'Praktik dialog basa krama alus dan melagukan tembang Gundhul Pacul.',
        accent: Color(0xFF0D6E3F),
        tint: Color(0xFFE7EEFF),
        icon: Icons.translate,
        teacher: 'Pak Haryadi, S.Pd.',
      ),
    ];
  }

  final base = <String, List<_ScheduleSession>>{
    'Selasa': const [
      _ScheduleSession(
        subject: 'Matematika',
        start: '07.45',
        end: '09.05 WIB',
        title: 'Pecahan Desimal & Bilangan Bulat',
        description: 'Penyelesaian soal pecahan dan operasi bilangan bulat.',
        accent: _blue,
        tint: Color(0xFFE0F2FE),
        icon: Icons.calculate,
        teacher: 'Ibu Wahyuni, M.Pd.',
      ),
      _ScheduleSession(
        subject: 'Istirahat & Shalat Dhuha',
        start: '09.05',
        end: '09.30',
        title: 'Istirahat Pagi',
        description: 'Snack sehat dan shalat dhuha.',
        accent: _gold,
        tint: Color(0xFFFFF4C7),
        icon: Icons.bakery_dining,
        isBreak: true,
      ),
      _ScheduleSession(
        subject: 'Pendidikan Pancasila',
        start: '09.30',
        end: '10.40 WIB',
        title: 'Gotong Royong dalam Kehidupan',
        description: 'Menelaah nilai gotong royong di lingkungan sekolah.',
        accent: _primary,
        tint: Color(0xFFE8F5EE),
        icon: Icons.diversity_3,
        teacher: 'Bu Rahmawati, S.Pd.',
      ),
    ],
  };

  return base[day] ??
      [
        _ScheduleSession(
          subject: 'Pembelajaran Aktif',
          start: '07.45',
          end: '09.05 WIB',
          title: 'Materi sesuai jadwal mingguan',
          description: 'Silakan melihat materi dan tugas pada hari $day.',
          accent: _primary,
          tint: Color(0xFFE8F5EE),
          icon: Icons.school,
          teacher: 'Tim Guru Kelas 4A',
        ),
        _ScheduleSession(
          subject: 'Istirahat',
          start: '09.05',
          end: '09.30',
          title: 'Istirahat Pagi',
          description: 'Snack sehat dan shalat dhuha.',
          accent: _gold,
          tint: Color(0xFFFFF4C7),
          icon: Icons.bakery_dining,
          isBreak: true,
        ),
      ];
}

class _LearningSession extends StatelessWidget {
  const _LearningSession({required this.session});

  final _ScheduleSession session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration.copyWith(
        border: Border(left: BorderSide(color: session.accent, width: 6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: session.tint,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  session.icon,
                                  size: 14,
                                  color: session.accent,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    session.subject,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: session.accent,
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
                    ),
                    const SizedBox(height: 7),
                    Text(
                      session.title,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    session.start,
                    style: TextStyle(
                      color: session.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    session.end,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            session.description,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                session.location.contains('Ruang')
                    ? Icons.meeting_room
                    : Icons.location_on,
                size: 16,
                color: _blue,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  session.location,
                  style: const TextStyle(color: _blue, fontSize: 11),
                ),
              ),
              if (session.teacher != null)
                Flexible(
                  child: Text(
                    session.teacher!,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BreakSession extends StatelessWidget {
  const _BreakSession({required this.session});

  final _ScheduleSession session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x66DEE8FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: session.tint,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(session.icon, size: 20, color: session.accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  session.description,
                  style: const TextStyle(color: Colors.black54, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${session.start} - ${session.end}',
                style: TextStyle(
                  color: session.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Istirahat',
                style: TextStyle(color: Colors.black45, fontSize: 9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuppliesCard extends StatelessWidget {
  const _SuppliesCard();

  @override
  Widget build(BuildContext context) {
    const supplies = [
      (Icons.menu_book, _primary, 'Buku Tulis Qur’an', 'Tajwid & Hafalan'),
      (Icons.science, _blue, 'IPAS Merdeka Bab 5', 'Modul & Alat Tulis'),
      (
        Icons.accessibility_new,
        _brown,
        'Alat Shalat / Mukena',
        'Dzuhur & Dhuha',
      ),
      (Icons.water_drop, _blue, 'Tumbler Air Minum', 'Bawa dari rumah'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5EE),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Icon(Icons.backpack, color: _primary, size: 20),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Perlengkapan Hari Ini',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Wajib Dibawa',
                style: TextStyle(color: Colors.black54, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 2.2,
            children: [
              for (final item in supplies)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(item.$1, size: 19, color: item.$2),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.$3,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _ink,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              item.$4,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClassProfileCard extends StatelessWidget {
  const _ClassProfileCard();

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
                width: 32,
                height: 32,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFDEE8FF),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Icon(Icons.groups, color: _ink, size: 20),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Profil Rombel 4A',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              _SmallPill(
                text: 'Aktif',
                background: Color(0xFFE8F5EE),
                foreground: _primary,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: _ProfileStat(
                  value: '28',
                  label: 'Total Siswa',
                  color: _primary,
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _ProfileStat(
                  value: '15 L',
                  label: 'Laki-laki',
                  color: _blue,
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _ProfileStat(
                  value: '13 P',
                  label: 'Perempuan',
                  color: _brown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, size: 18, color: _brown),
                SizedBox(width: 6),
                Text(
                  'Ketua Kelas:',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  'Muhammad Fatih Al-Farisi',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
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

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value, label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
