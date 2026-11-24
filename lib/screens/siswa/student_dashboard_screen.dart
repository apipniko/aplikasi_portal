import 'package:flutter/material.dart';

const _green = Color(0xFF08492A);
const _primary = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _blue = Color(0xFF004C76);
const _gold = Color(0xFFFBBF24);
const _page = Color(0xFFF9F9FF);

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _page,
      body: Column(
        children: [
          const _StudentHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                const _WelcomeBanner(),
                const SizedBox(height: 16),
                const _StatsGrid(),
                const SizedBox(height: 16),
                _SectionTitle(
                  dot: _primary,
                  title: 'Jadwal Hari Ini (Senin)',
                  trailing: 'Ruang 4A',
                ),
                const SizedBox(height: 8),
                const _ScheduleCard(
                  accent: _primary,
                  tint: Color(0xFFE8F5EE),
                  icon: Icons.menu_book,
                  subject: 'Kemuhammadiyahan',
                  time: '07.30 - 09.00 WIB',
                  title: 'Kisah Keteladanan KH. Ahmad Dahlan',
                  teacher: 'Ust. Budi Santoso, S.Pd.I',
                  subjectColor: _primary,
                ),
                const SizedBox(height: 8),
                const _BreakCard(),
                const SizedBox(height: 8),
                const _ScheduleCard(
                  accent: _blue,
                  tint: Color(0xFFE0F2FE),
                  icon: Icons.calculate,
                  subject: 'Matematika',
                  time: '09.30 - 10.45 WIB',
                  title: 'Pecahan Desimal & Bilangan Bulat',
                  teacher: 'Ibu Wahyuni, M.Pd.',
                  subjectColor: _blue,
                ),
                const SizedBox(height: 8),
                const _ScheduleCard(
                  accent: Color(0xFFFEA619),
                  tint: Color(0xFFFEF3C7),
                  icon: Icons.edit_note,
                  subject: 'Bahasa Indonesia',
                  time: '10.45 - 12.00 WIB',
                  title: 'Menulis Paragraf Deskripsi',
                  teacher: "Pak Ahmad Rifa'i, S.Pd.",
                  subjectColor: Color(0xFF855300),
                ),
                const SizedBox(height: 16),
                _SectionTitle(
                  dot: const Color(0xFFFEA619),
                  title: 'Tugas & Tantangan Belajar',
                  trailingWidget: _Pill(
                    text: '2 Wajib',
                    background: const Color(0xFFFFDAD6),
                    foreground: const Color(0xFF93000A),
                  ),
                ),
                const SizedBox(height: 8),
                _TaskCard(
                  icon: Icons.functions,
                  iconBackground: const Color(0xFFE0F2FE),
                  iconColor: _blue,
                  subject: 'Matematika',
                  subjectColor: _blue,
                  title: 'Latihan Mandiri: Pecahan Campuran',
                  deadline: 'Tenggat: Rabu, 19 Feb',
                  description: 'Buku Paket halaman 42, soal no. 1–10. Kerjakan rapi di buku berpetak.',
                  buttonText: 'Kirim Tugas',
                  buttonColor: _primary,
                  urgent: true,
                  onPressed: () => _showMessage(
                    context,
                    'Membuka formulir pengumpulan tugas Matematika',
                  ),
                ),
                const SizedBox(height: 8),
                _TaskCard(
                  icon: Icons.mic,
                  iconBackground: const Color(0xFFE8F5EE),
                  iconColor: _primary,
                  subject: 'Al-Islam & Kemuhammadiyahan',
                  subjectColor: _primary,
                  title: 'Hafalan Doa Iftitah Muhammadiyah',
                  deadline: 'Sabtu, 22 Feb',
                  description: 'Rekam hafalan doa melalui audio WhatsApp atau unggah rekaman suara.',
                  buttonText: 'Unggah Rekaman Suara',
                  buttonColor: const Color(0xFFFEA619),
                  onPressed: () => _showMessage(
                    context,
                    'Membuka perekam suara tugas hafalan',
                  ),
                ),
                const SizedBox(height: 16),
                const _WisdomCard(),
                const SizedBox(height: 16),
                _SectionTitle(
                  dot: _blue,
                  title: 'Warta & Agenda Sekolah',
                  trailing: 'Tamantirto Ceria',
                ),
                const SizedBox(height: 8),
                const _AgendaCard(
                  icon: Icons.wb_sunny,
                  tag: 'Menyambut Ramadhan',
                  tagBackground: _gold,
                  tagColor: _ink,
                  title: 'Baitul Arqam Cilik & Pesantren Kilat 1446 H',
                  description: 'Pembekalan adab, shalat fardhu berjamaah, dan tadarrus bersama.',
                  date: '10 - 12 Maret 2025 • Kampus Terpadu',
                  topColor: Color(0xFF059669),
                ),
                const SizedBox(height: 8),
                const _AgendaCard(
                  icon: Icons.sports_soccer,
                  tag: 'Pandu Athfal',
                  tagBackground: Color(0xFFE0F2FE),
                  tagColor: _blue,
                  title: 'Gebyar Ceria Pandu Athfal Hizbul Wathan',
                  description: 'Pawai persaudaraan, tali-temali kreatif, dan jelajah alam.',
                  date: 'Sabtu, 15 Maret 2025 • Lapangan Hijau',
                  topColor: Color(0xFF38A3A5),
                ),
                const SizedBox(height: 12),
                const _FooterBadge(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}

class _StudentHeader extends StatelessWidget {
  const _StudentHeader();

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
                  'Beranda Siswa',
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
          _Pill(
            text: 'Siswa',
            background: const Color(0xFFE0F2FE),
            foreground: _blue,
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

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_green, _primary],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A08492A),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -4,
            top: -4,
            child: Opacity(
              opacity: .18,
              child: Icon(Icons.wb_sunny, color: Colors.white, size: 88),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x33E8F5EE),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 8,
                      height: 8,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _gold,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Semangat Belajar Hari Ini!',
                      style: TextStyle(
                        color: Color(0xFFE8F5EE),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Assalamu’alaikum, Ananda Ahmad!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kelas 4A • Abu Bakar Ash-Shiddiq\nSemester Genap 2024/2025',
                style: TextStyle(
                  color: Color(0xFFBDEBCB),
                  fontSize: 12,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: _StatCard(
                icon: Icons.calendar_today,
                iconBackground: Color(0xFFE0F2FE),
                iconColor: _blue,
                badge: 'Hari ini',
                badgeBackground: Color(0xFFE7EEFF),
                badgeColor: _ink,
                value: '3 Mapel',
                detail: '07.00 - 12.00 WIB',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: const _StatCard(
                icon: Icons.assignment,
                iconBackground: Color(0xFFFEF3C7),
                iconColor: Color(0xFF855300),
                badge: 'Aktif',
                badgeBackground: Color(0xFFFEF3C7),
                badgeColor: Color(0xFF855300),
                value: '2 Tugas',
                detail: '1 perlu segera dikirim!',
                detailColor: Color(0xFF855300),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration,
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5EE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.workspace_premium, color: _primary),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capaian Belajar Rata-Rata',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '88.4',
                          style: TextStyle(
                            fontSize: 18,
                            color: _ink,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '/ 100',
                          style: TextStyle(fontSize: 11, color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const _Pill(
                text: 'Sangat Baik',
                background: Color(0xFFE8F5EE),
                foreground: _primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.badge,
    required this.badgeBackground,
    required this.badgeColor,
    required this.value,
    required this.detail,
    this.detailColor = Colors.black54,
  });

  final IconData icon;
  final Color iconBackground,
      iconColor,
      badgeBackground,
      badgeColor,
      detailColor;
  final String badge, value, detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 124),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              _Pill(
                text: badge,
                background: badgeBackground,
                foreground: badgeColor,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: _ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            detail,
            maxLines: 2,
            style: TextStyle(
              fontSize: 11,
              color: detailColor,
              fontWeight: FontWeight.w600,
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

class _Pill extends StatelessWidget {
  const _Pill({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background, foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: foreground,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.dot,
    required this.title,
    this.trailing,
    this.trailingWidget,
  });

  final Color dot;
  final String title;
  final String? trailing;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
          height: 10,
          child: DecoratedBox(
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: _ink,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        if (trailingWidget != null)
          trailingWidget!
        else if (trailing != null)
          Text(
            trailing!,
            style: const TextStyle(
              fontSize: 11,
              color: _primary,
              fontWeight: FontWeight.w800,
            ),
          ),
      ],
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.accent,
    required this.tint,
    required this.icon,
    required this.subject,
    required this.time,
    required this.title,
    required this.teacher,
    required this.subjectColor,
  });

  final Color accent, tint, subjectColor;
  final IconData icon;
  final String subject, time, title, teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration.copyWith(
        border: Border(left: BorderSide(color: accent, width: 6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 14, color: subjectColor),
                    const SizedBox(width: 4),
                    Text(
                      subject,
                      style: TextStyle(
                        fontSize: 11,
                        color: subjectColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: subjectColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: _ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.black45),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  teacher,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BreakCard extends StatelessWidget {
  const _BreakCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE68A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(color: _gold, shape: BoxShape.circle),
              child: Icon(Icons.restaurant, color: _ink, size: 21),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Istirahat Pagi & Shalat Dhuha',
                  style: TextStyle(
                    fontSize: 13,
                    color: _ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Snack sehat, wudhu tertib di masjid sekolah',
                  style: TextStyle(fontSize: 11, color: Color(0xFF855300)),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            '09.00\n09.30',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF855300),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.subject,
    required this.subjectColor,
    required this.title,
    required this.deadline,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
    this.urgent = false,
  });

  final IconData icon;
  final Color iconBackground, iconColor, subjectColor, buttonColor;
  final String subject, title, deadline, description, buttonText;
  final VoidCallback onPressed;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration.copyWith(
        color: urgent ? const Color(0xFFFFFBEB) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: iconColor, size: 19),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: TextStyle(
                        fontSize: 11,
                        color: subjectColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _ink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                deadline,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10,
                  color: urgent ? const Color(0xFF855300) : Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (urgent) ...[
            const SizedBox(height: 8),
            const _Pill(
              text: 'Segera Kumpulkan! (Sisa 1 Hari)',
              background: Color(0xFFFBBF24),
              foreground: _ink,
            ),
          ],
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(urgent ? Icons.upload_file : Icons.mic, size: 20),
              label: Text(buttonText),
              style: FilledButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: urgent ? Colors.white : _ink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WisdomCard extends StatelessWidget {
  const _WisdomCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.format_quote, color: _primary, size: 20),
              SizedBox(width: 6),
              Text(
                'Mutiara Hikmah Pekan Ini',
                style: TextStyle(
                  fontSize: 12,
                  color: _primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              children: [
                Text(
                  'مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ بِهِ طَرِيقًا إِلَى الْجَنَّةِ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: _green,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Barangsiapa menempuh jalan untuk menuntut ilmu, maka Allah akan memudahkan jalannya menuju Surga.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: _ink,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '(HR. Muslim No. 2699)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
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

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({
    required this.icon,
    required this.tag,
    required this.tagBackground,
    required this.tagColor,
    required this.title,
    required this.description,
    required this.date,
    required this.topColor,
  });

  final IconData icon;
  final String tag, title, description, date;
  final Color tagBackground, tagColor, topColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 126,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [topColor.withValues(alpha: .82), topColor],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 20,
                  bottom: 10,
                  child: Icon(
                    icon,
                    size: 82,
                    color: Colors.white.withValues(alpha: .28),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 10,
                  child: _Pill(
                    text: tag,
                    background: tagBackground,
                    foreground: tagColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.event, size: 16, color: _primary),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: _primary,
                          fontWeight: FontWeight.w700,
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
    );
  }
}

class _FooterBadge extends StatelessWidget {
  const _FooterBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFDEE8FF),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.black54),
            SizedBox(width: 5),
            Text(
              'Data Simulasi Akademik • SD Muhammadiyah Tamantirto',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
