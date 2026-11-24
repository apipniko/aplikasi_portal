import 'package:flutter/material.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);

class GradeManagementScreen extends StatefulWidget {
  const GradeManagementScreen({super.key});
  @override
  State<GradeManagementScreen> createState() => _GradeManagementScreenState();
}

class _GradeManagementScreenState extends State<GradeManagementScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final students =
        [
          (
            'Farhan Pratama',
            '00142981',
            'FP',
            '95.0',
            'Mumtaz (A)',
            [95, 92, 94, 98, 96],
          ),
          (
            'Aisyah Putri Ramadhani',
            '00142982',
            'AP',
            '92.6',
            'Mumtaz (A)',
            [92, 94, 90, 92, 95],
          ),
          (
            'Fatih Al-Farisi',
            '00142983',
            'FA',
            '88.4',
            'Jayyid Jiddan (B)',
            [88, 90, 86, 89, 89],
          ),
        ].where(
          (student) =>
              student.$1.toLowerCase().contains(query.toLowerCase()) ||
              student.$2.contains(query),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_stories, color: _green, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Buku Nilai Kurikulum ISMUBA',
                    style: TextStyle(
                      color: _muted,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Kelas 4A Abu Bakar',
                style: TextStyle(
                  color: _ink,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Text(
                'Wali Kelas: Ustadzah Rahma, S.Pd. • 21 Siswa',
                style: TextStyle(color: _muted, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _SelectBox(
                      label: 'Mata Pelajaran',
                      value: 'Kemuhammadiyahan',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SelectBox(
                      label: 'Semester',
                      value: 'Genap 2024/2025',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF08492A), Color(0xFF0D6E3F)],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rekap Hasil Formatif & PTS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _GradeStat('Rata-rata', '86.8', '+2.1')),
                  SizedBox(width: 6),
                  Expanded(
                    child: _GradeStat('Ketuntasan', '95.2%', '20 Tuntas'),
                  ),
                  SizedBox(width: 6),
                  Expanded(child: _GradeStat('Tertinggi', '98.0', 'Farhan P.')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          onChanged: (value) => setState(() => query = value),
          decoration: InputDecoration(
            hintText: 'Cari nama siswa atau NISN...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Input Nilai Siswa',
          style: TextStyle(
            color: _ink,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        for (final student in students) ...[
          _StudentGradeCard(
            name: student.$1,
            nisn: student.$2,
            initials: student.$3,
            average: student.$4,
            predicate: student.$5,
            values: student.$6,
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _SelectBox extends StatelessWidget {
  const _SelectBox({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Container(
    height: 58,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F3FF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: _muted, fontSize: 10)),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _green,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

class _GradeStat extends StatelessWidget {
  const _GradeStat(this.label, this.value, this.note);
  final String label, value, note;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(note, style: const TextStyle(color: Colors.white70, fontSize: 9)),
      ],
    ),
  );
}

class _StudentGradeCard extends StatelessWidget {
  const _StudentGradeCard({
    required this.name,
    required this.nisn,
    required this.initials,
    required this.average,
    required this.predicate,
    required this.values,
  });
  final String name, nisn, initials, average, predicate;
  final List<int> values;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: const Border(left: BorderSide(color: _green, width: 4)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE8F5EE),
              foregroundColor: _green,
              child: Text(
                initials,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'NISN: $nisn',
                    style: const TextStyle(color: _muted, fontSize: 11),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  predicate,
                  style: const TextStyle(
                    color: _green,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
                Text(
                  average,
                  style: const TextStyle(
                    color: _green,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (var i = 0; i < values.length; i++) ...[
              Expanded(
                child: Column(
                  children: [
                    Text(
                      const ['F1', 'F2', 'Tgs', 'PTS', 'PAS'][i],
                      style: const TextStyle(color: _muted, fontSize: 9),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F3FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${values[i]}',
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < values.length - 1) const SizedBox(width: 5),
            ],
          ],
        ),
      ],
    ),
  );
}
