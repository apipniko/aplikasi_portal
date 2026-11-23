import 'package:flutter/material.dart';

const _primary = Color(0xFF0D6E3F);
const _ink = Color(0xFF1E293B);
const _background = Color(0xFFF9F9FF);
const _border = Color(0xFFE2E8F0);
const _sky = Color(0xFF0284C7);
const _amber = Color(0xFFF59E0B);

class StudentGradesScreen extends StatefulWidget {
  const StudentGradesScreen({super.key});

  @override
  State<StudentGradesScreen> createState() => _StudentGradesScreenState();
}

class _StudentGradesScreenState extends State<StudentGradesScreen> {
  final Set<int> _expanded = {0, 1};

  static const subjects = [
    _Subject(
      'Al-Islam & Kemuhammadiyahan',
      'Ust. Zulkifli, S.Pd.I.',
      '93.5',
      '+18.5 dari KKM',
      Icons.mosque,
      Color(0xFFE8F5EE),
      true,
      ['90.0', '92.0', '90.0', '91.0', '93.0', '91.0'],
      'Sangat antusias saat praktikum dan menunjukkan pemahaman yang baik terhadap nilai-nilai Muhammadiyah.',
    ),
    _Subject(
      'IPAS (Sains & Sosial)',
      'Ibu Ratna Dewi, M.Pd.',
      '91.0',
      '+16.0 dari KKM',
      Icons.science,
      Color(0xFFE0F2FE),
      true,
      ['89.0', '91.0', '91.0', '90.0', '92.0', '90.5'],
      'Hasil karya dan pemahaman materi kearifan lokal Tamantirto sangat baik.',
    ),
    _Subject(
      'SBdP (Batik Bantul)',
      'Pak Haryono, S.Sn.',
      '90.5',
      '+15.5 dari KKM',
      Icons.palette,
      Color(0xFFFEF3C7),
      true,
      ['87.0', '88.0', '89.0', '87.0', '89.0', '88.0'],
      'Kreatif dan teliti dalam menghasilkan motif serta karya seni.',
    ),
    _Subject(
      'Bahasa Indonesia',
      'Ustzh. Siti Aminah, S.Pd.',
      '88.0',
      '+13.0 dari KKM',
      Icons.auto_stories,
      Color(0xFFEEF2FF),
      false,
      ['86.0', '87.0', '86.0', '86.0', '90.0', '87.0'],
      'Lancar menyusun paragraf deskripsi dan berani membacakan karya di depan kelas.',
    ),
    _Subject(
      'Pendidikan Pancasila',
      'Pak Wahyudi, S.Pd.',
      '87.0',
      '+12.0 dari KKM',
      Icons.balance,
      Color(0xFFEEF2FF),
      false,
      ['85.0', '86.0', '88.0', '85.0', '89.0', '86.5'],
      'Memahami hak dan kewajiban serta menerapkan gotong royong dengan baik.',
    ),
    _Subject(
      'Bahasa Jawa (Mulok Wajib)',
      'Ibu Endang Sri, S.Pd.',
      '86.5',
      '+11.5 dari KKM',
      Icons.temple_buddhist,
      Color(0xFFFEF3C7),
      false,
      ['84.0', '85.0', '84.0', '85.0', '87.0', '85.0'],
      'Unggah-ungguh bahasa Jawa berkembang baik dan tulisan rapi.',
    ),
    _Subject(
      'Matematika',
      'Pak Budi Santoso, S.Pd.',
      '85.0',
      '+10.0 dari KKM',
      Icons.calculate,
      Color(0xFFEEF2FF),
      false,
      ['84.0', '86.0', '-', '-', '-', '85.0'],
      'Menguasai operasi pecahan senilai serta keliling dan luas bangun datar dengan cermat.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _background,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _header(),
          const SizedBox(height: 12),
          _metrics(),
          const SizedBox(height: 12),
          _teacherNote(),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rincian Capaian Mapel',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Klik kartu untuk melihat rincian',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                'KKM: 75',
                style: TextStyle(
                  color: _primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < subjects.length; i++) ...[
            _SubjectCard(
              subject: subjects[i],
              expanded: _expanded.contains(i),
              onTap: () => setState(
                () => _expanded.contains(i)
                    ? _expanded.remove(i)
                    : _expanded.add(i),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE8F5EE), Color(0xFFE0F2FE)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.lightbulb, color: _primary),
                SizedBox(height: 8),
                Text(
                  '“Menuntut ilmu adalah ibadah,\nmengamalkannya adalah dakwah nyata.”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _primary,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Pendidikan Karakter Islami Menuju Generasi Ulama Berkemajuan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF00542D), _primary, Color(0xFF08492A)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x180D6E3F),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5EE),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              alignment: Alignment.center,
              child: const Text(
                'FP',
                style: TextStyle(
                  color: _primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Farhan Pratama',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    'NISN: 0124859302',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kelas 4A • Semester Genap 2024/2025',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: .14),
              ),
              icon: const Icon(Icons.share, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(color: Colors.white24, height: 1),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.supervisor_account, color: _amber, size: 18),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'Wali Kelas: Ustzh. Siti Aminah',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(width: 6),
            Text(
              'Fase B',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _metrics() => GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.45,
    children: [
      _metricCard(
        'Rata-Rata',
        '88.4',
        '/ 100',
        '+2.1 dari PTS',
        Icons.analytics,
        const Color(0xFFE8F5EE),
        const Color(0xFF059669),
        _primary,
      ),
      _metricCard(
        'Predikat Mutu',
        'Mumtaz (A)',
        '',
        'Sangat Baik',
        Icons.stars,
        const Color(0xFFFEF3C7),
        const Color(0xFF855300),
        const Color(0xFF855300),
      ),
      _metricCard(
        'Nilai Tertinggi',
        '94.0',
        'Poin',
        'Al-Islam & Kemuhammadiyahan',
        Icons.workspace_premium,
        const Color(0xFFE0F2FE),
        _sky,
        _sky,
      ),
      _metricCard(
        'Ketuntasan',
        '7 / 7',
        'Mapel',
        '100% di atas KKM 75',
        Icons.task_alt,
        const Color(0xFFE8F5EE),
        _primary,
        _primary,
      ),
    ],
  );

  Widget _metricCard(
    String label,
    String value,
    String suffix,
    String note,
    IconData icon,
    Color iconBg,
    Color valueColor,
    Color accent,
  ) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: accent, size: 16),
            ),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: valueColor,
                  fontSize: value == 'Mumtaz (A)' ? 18 : 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            if (suffix.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                suffix,
                style: const TextStyle(color: Colors.black54, fontSize: 10),
              ),
            ],
          ],
        ),
        const SizedBox(height: 3),
        Text(
          note,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: value == 'Mumtaz (A)' ? const Color(0xFF855300) : accent,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );

  Widget _teacherNote() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F3FF),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.format_quote, color: _primary),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Catatan Wali Kelas',
                style: TextStyle(
                  color: _ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              'Sangat Terpuji',
              style: TextStyle(
                color: _primary,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '“Ananda Farhan aktif, tekun, dan menunjukkan akhlak karimah yang mulia dalam pembelajaran. Selalu istiqomah dalam sholat dhuha berjamaah dan ramah bergaul.”',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            height: 1.6,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: Color(0xFFDEE8FF)),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ustzh. Siti Aminah, S.Pd.',
              style: TextStyle(
                color: _ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '21 Juni 2025',
              style: TextStyle(color: Colors.black54, fontSize: 11),
            ),
          ],
        ),
      ],
    ),
  );
}

class _Subject {
  const _Subject(
    this.title,
    this.teacher,
    this.score,
    this.progress,
    this.icon,
    this.iconBg,
    this.excellent,
    this.values,
    this.note,
  );

  final String title, teacher, score, progress, note;
  final IconData icon;
  final Color iconBg;
  final bool excellent;
  final List<String> values;
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    required this.subject,
    required this.expanded,
    required this.onTap,
  });

  final _Subject subject;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Formatif 1',
      'Formatif 2',
      'Tugas',
      'PTS',
      'PAS',
      'Rata-rata',
    ];
    final score = double.parse(subject.score);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: subject.iconBg,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      subject.icon,
                      color: subject.excellent ? _primary : _sky,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subject.teacher,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 11,
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
                        subject.score,
                        style: TextStyle(
                          color: subject.excellent ? _primary : _ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        subject.excellent ? 'Sangat Baik' : 'Baik',
                        style: TextStyle(
                          color: subject.excellent
                              ? const Color(0xFF059669)
                              : _sky,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black45,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Capaian Materi',
                    style: TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                  Text(
                    subject.progress,
                    style: TextStyle(
                      color: subject.excellent ? _primary : _sky,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: score / 100,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE7EEFF),
                  valueColor: AlwaysStoppedAnimation(
                    subject.excellent ? _primary : _sky,
                  ),
                ),
              ),
              if (expanded) ...[
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    childAspectRatio: 1.55,
                  ),
                  itemCount: labels.length,
                  itemBuilder: (_, i) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          labels[i],
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 9,
                          ),
                        ),
                        Text(
                          subject.values[i],
                          style: TextStyle(
                            color: i == 5 ? _primary : _ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subject.note,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
