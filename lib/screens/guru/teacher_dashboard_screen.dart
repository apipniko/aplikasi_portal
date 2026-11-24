import 'package:flutter/material.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D6E3F),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Badge('Sem. Genap 2024/2025 • Kampus Geblagan'),
            SizedBox(height: 10),
            Text(
              "Assalamu'alaikum Warahmatullah",
              style: TextStyle(color: Color(0xFF96EDB2), fontSize: 13),
            ),
            Text(
              'Ustadzah Rahma, S.Pd.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Wali Kelas 4A • Pengampu Rumpun ISMUBA',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.wb_sunny_rounded,
                  color: Color(0xFFFBBF24),
                  size: 18,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Rabu Berkah, 05 Maret 2025',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Text(
                  'Pekan Aktif KBM',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const _SectionTitle(
        icon: Icons.analytics_outlined,
        title: 'Kilas Beban & Capaian Pendidik',
      ),
      const SizedBox(height: 8),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.45,
        children: const [
          _StatCard(
            label: 'Beban Mengajar',
            value: '24',
            unit: 'JP / Pekan',
            note: '100% Terpenuhi',
            icon: Icons.menu_book,
            tone: Color(0xFFE8F5EE),
          ),
          _StatCard(
            label: 'Rombel Binaan',
            value: '2',
            unit: 'Rombel',
            note: 'Kelas 4A & 4B · 41 Siswa',
            icon: Icons.groups,
            tone: Color(0xFFE0F2FE),
          ),
          _StatCard(
            label: 'Tugas Masuk',
            value: '18',
            unit: '/ 21 Berkas',
            note: 'Perlu Diperiksa',
            icon: Icons.pending_actions,
            tone: Color(0xFFFEF3C7),
          ),
          _StatCard(
            label: 'Rerata Nilai 4A',
            value: '86.8',
            unit: 'PTS',
            note: '95.2% KKM (75)',
            icon: Icons.verified_outlined,
            tone: Color(0xFFE8F5EE),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text(
        'Menu Tindakan Pendidik',
        style: TextStyle(fontWeight: FontWeight.w800, color: _ink),
      ),
      const SizedBox(height: 8),
      const Row(
        children: [
          Expanded(child: _QuickAction(Icons.auto_stories, 'Kelola Materi')),
          SizedBox(width: 8),
          Expanded(child: _QuickAction(Icons.edit_square, 'Input Nilai')),
          SizedBox(width: 8),
          Expanded(child: _QuickAction(Icons.calendar_today, 'Jadwal')),
          SizedBox(width: 8),
          Expanded(child: _QuickAction(Icons.campaign, 'Warta 4A')),
        ],
      ),
      const SizedBox(height: 16),
      const _SectionTitle(
        icon: Icons.schedule,
        title: 'Jadwal Mengajar Hari Ini',
      ),
      const SizedBox(height: 8),
      const _ScheduleCard(
        time: '07.30 - 09.00 WIB',
        title: 'Kemuhammadiyahan Kelas 4A',
        subtitle: 'Ruang K-202',
        status: 'Materi Bab 4 & Lembar Diskusi Siap',
        icon: Icons.co_present,
        accent: _green,
      ),
      const SizedBox(height: 8),
      const _ScheduleCard(
        time: '09.30 - 10.15 WIB',
        title: 'Sholat Dhuha & Adab Pelajar Muhammadiyah',
        subtitle: 'Musholla Utama • Kelas 4A & 4B',
        status: 'Pembiasaan Ibadah',
        icon: Icons.mosque,
        accent: Color(0xFF004C76),
      ),
      const SizedBox(height: 16),
      const _SectionTitle(
        icon: Icons.assignment_late,
        title: 'Perlu Koreksi Segera',
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8)],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tugas 4 • Kemuhammadiyahan',
              style: TextStyle(
                color: _green,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Mengenal Tokoh Pendiri Muhammadiyah',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: .857,
              minHeight: 8,
              borderRadius: BorderRadius.all(Radius.circular(999)),
              backgroundColor: Color(0xFFE2E8F0),
              color: _green,
            ),
            SizedBox(height: 6),
            Text(
              'Pengumpulan: 18 dari 21 Siswa • 85%',
              style: TextStyle(color: _muted, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

class _Badge extends StatelessWidget {
  const _Badge(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0x1FFFFFFF),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 11),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: _green, size: 20),
      const SizedBox(width: 6),
      Text(
        title,
        style: const TextStyle(
          color: _ink,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    ],
  );
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.note,
    required this.icon,
    required this.tone,
  });
  final String label, value, unit, note;
  final IconData icon;
  final Color tone;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: _muted, fontSize: 11),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: tone,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: _green, size: 16),
            ),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: _ink,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                unit,
                style: const TextStyle(color: _muted, fontSize: 10),
              ),
            ),
          ],
        ),
        Text(note, style: const TextStyle(color: _green, fontSize: 10)),
      ],
    ),
  );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction(this.icon, this.label);
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => Container(
    height: 78,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: _green, size: 22),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _ink,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.icon,
    required this.accent,
  });
  final String time, title, subtitle, status;
  final IconData icon;
  final Color accent;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: accent, width: 5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        Text(subtitle, style: const TextStyle(color: _muted, fontSize: 12)),
        const SizedBox(height: 8),
        Text(
          status,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}
