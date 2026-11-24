import 'package:flutter/material.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({super.key});
  @override
  State<TeacherScheduleScreen> createState() => _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {
  int selectedDay = 2;
  final days = const [
    ('Sen', '03'),
    ('Sel', '04'),
    ('Rab', '05'),
    ('Kam', '06'),
    ('Jum', '07'),
  ];

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusBadge('Semester Genap 2024/2025'),
                  SizedBox(height: 8),
                  Text(
                    'Jadwal & Agenda Guru',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Ustadzah Rahma, S.Pd. • Wali Kelas 4A',
                    style: TextStyle(color: _muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            _IconTile(Icons.calendar_month),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'Pilih Hari',
        style: TextStyle(color: _ink, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 68,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: days.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final active = selectedDay == index;
            final day = days[index];
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => setState(() => selectedDay = index),
              child: Container(
                width: 62,
                decoration: BoxDecoration(
                  color: active ? _green : const Color(0xFFE7EEFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.$1,
                      style: TextStyle(
                        color: active ? Colors.white70 : _muted,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      day.$2,
                      style: TextStyle(
                        color: active ? Colors.white : _ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'Jadwal Mengajar Rabu',
        style: TextStyle(color: _ink, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      const _SessionCard(
        time: '07.30 - 09.00 WIB',
        session: 'Sesi 1',
        title: 'Kemuhammadiyahan',
        detail: 'Kelas 4A • Ruang K-202',
        status: 'Modul Bab 4 Siap',
        color: _green,
      ),
      const SizedBox(height: 8),
      const _SessionCard(
        time: '09.30 - 10.15 WIB',
        session: 'Sesi 2 • Ibadah',
        title: 'Bimbingan Adab & Sholat Dhuha',
        detail: 'Musholla Utama',
        status: 'Pembiasaan karakter islami',
        color: Color(0xFFFBBF24),
      ),
      const SizedBox(height: 8),
      const _SessionCard(
        time: '10.30 - 11.45 WIB',
        session: 'Sesi 3',
        title: 'Kemuhammadiyahan',
        detail: 'Kelas 4B • Ruang K-203',
        status: 'Bahan Ajar Terhubung',
        color: _green,
      ),
      const SizedBox(height: 16),
      const Text(
        'Rencana Agenda Mendatang',
        style: TextStyle(color: _ink, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      const _AgendaCard(
        date: '10\nMar',
        title: 'Persiapan PTS Genap',
        detail: 'Penyusunan kisi-kisi dan naskah soal Kemuhammadiyahan.',
      ),
      const SizedBox(height: 8),
      const _AgendaCard(
        date: '🌙',
        title: 'Pendampingan Baitul Arqam Ramadhan',
        detail: 'Tadarus dan halaqah santri kelas 4A.',
      ),
      const SizedBox(height: 12),
      FilledButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.download),
        label: const Text('Unduh Jadwal Lengkap (PDF)'),
        style: FilledButton.styleFrom(
          backgroundColor: _green,
          minimumSize: const Size.fromHeight(48),
        ),
      ),
    ],
  );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5EE),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _green,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _IconTile extends StatelessWidget {
  const _IconTile(this.icon);
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      color: _green,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, color: Colors.white),
  );
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.time,
    required this.session,
    required this.title,
    required this.detail,
    required this.status,
    required this.color,
  });
  final String time, session, title, detail, status;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: color, width: 5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(session, style: const TextStyle(color: _muted, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(detail, style: const TextStyle(color: _muted, fontSize: 12)),
        const SizedBox(height: 8),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({
    required this.date,
    required this.title,
    required this.detail,
  });
  final String date, title, detail;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            date,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF855300),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(detail, style: const TextStyle(color: _muted, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}
