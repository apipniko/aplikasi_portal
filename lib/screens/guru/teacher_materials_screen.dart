import 'package:flutter/material.dart';

import 'upload_material_screen.dart';
import 'create_assignment_screen.dart';
import 'submissions_screen.dart';
import 'grade_submission_screen.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);

class TeacherMaterialsScreen extends StatefulWidget {
  const TeacherMaterialsScreen({super.key});
  @override
  State<TeacherMaterialsScreen> createState() => _TeacherMaterialsScreenState();
}

class _TeacherMaterialsScreenState extends State<TeacherMaterialsScreen> {
  bool showTasks = false;

  @override
  Widget build(BuildContext context) => ListView(
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
            const _StatusBadge('Kelas 4A Aktif'),
            const SizedBox(height: 8),
            const Text(
              'Kelola Materi & Tugas',
              style: TextStyle(
                color: _ink,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              '21 Siswa Binaan • Ustadzah Rahma, S.Pd.',
              style: TextStyle(color: _muted, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const UploadMaterialScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.upload_file, size: 18),
                    label: const Text('Unggah Materi'),
                    style: FilledButton.styleFrom(
                      backgroundColor: _green,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const CreateAssignmentScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.add_task, size: 18),
                    label: const Text('Buat Tugas'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFEA619),
                      foregroundColor: const Color(0xFF684000),
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFE7EEFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: _TabButton(
                active: !showTasks,
                icon: Icons.menu_book,
                label: 'Materi Ajar',
                count: '14',
                onTap: () => setState(() => showTasks = false),
              ),
            ),
            Expanded(
              child: _TabButton(
                active: showTasks,
                icon: Icons.assignment_late,
                label: 'Tugas Masuk',
                count: '3',
                onTap: () => setState(() => showTasks = true),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _FilterChip('Semua', active: true),
            const SizedBox(width: 6),
            _FilterChip('Kemuhammadiyahan'),
            const SizedBox(width: 6),
            _FilterChip('Matematika'),
            const SizedBox(width: 6),
            _FilterChip('IPAS'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      if (!showTasks) ...[
        const _MaterialCard(
          subject: 'Kemuhammadiyahan',
          chapter: 'Bab 4',
          title: 'Biografi Tokoh KH Ahmad Dahlan',
          detail: 'PDF • 4.2 MB • Disusun 12 Feb 2025',
          icon: Icons.picture_as_pdf,
          tone: Color(0xFFE8F5EE),
        ),
        const SizedBox(height: 10),
        const _MaterialCard(
          subject: 'IPAS',
          chapter: 'Bab 5',
          title: 'Ekosistem & Air Tamantirto',
          detail: 'Slide Interaktif • 18 Lembar',
          icon: Icons.slideshow,
          tone: Color(0xFFE0F2FE),
        ),
        const SizedBox(height: 10),
        const _MaterialCard(
          subject: 'Matematika',
          chapter: 'Tema 3',
          title: 'Pecahan Senilai dengan Peraga',
          detail: 'Video 08:45 • Rangkuman Catatan',
          icon: Icons.smart_display,
          tone: Color(0xFFFEF3C7),
        ),
      ] else ...[
        const _SubmissionMetrics(),
        const SizedBox(height: 10),
        const _SubmissionAssignmentCard(),
        const SizedBox(height: 10),
        const _CompletedAssignmentCard(
          subject: 'IPAS',
          title: 'Laporan Pengamatan Siklus Air & Lingkungan Tamantirto',
          progress: '21/21 Terkumpul',
        ),
        const SizedBox(height: 10),
        const _CompletedAssignmentCard(
          subject: 'Matematika',
          title: 'Latihan Pecahan Campuran',
          progress: '21/21 Terkumpul',
        ),
      ],
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

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.active,
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
  });
  final bool active;
  final IconData icon;
  final String label, count;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(9),
    child: Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 17, color: active ? _green : _muted),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: active ? _green : _muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            count,
            style: const TextStyle(
              color: _green,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );
}

class _FilterChip extends StatelessWidget {
  const _FilterChip(this.label, {this.active = false});
  final String label;
  final bool active;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: active ? _green : Colors.white,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: active ? Colors.white : _muted,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _MaterialCard extends StatelessWidget {
  const _MaterialCard({
    required this.subject,
    required this.chapter,
    required this.title,
    required this.detail,
    required this.icon,
    required this.tone,
  });
  final String subject, chapter, title, detail;
  final IconData icon;
  final Color tone;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$subject • $chapter',
              style: const TextStyle(
                color: _green,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const Text('Terbit', style: TextStyle(color: _green, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: tone,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _green, size: 28),
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
                  Text(
                    detail,
                    style: const TextStyle(color: _muted, fontSize: 12),
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

class _SubmissionMetrics extends StatelessWidget {
  const _SubmissionMetrics();
  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(
        child: _MetricCard(
          title: 'Terkumpul',
          value: '18',
          suffix: '/21',
          note: '85% Respon',
          color: _ink,
          icon: Icons.inbox,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: _MetricCard(
          title: 'Perlu Nilai',
          value: '3',
          suffix: 'Berkas',
          note: 'Prioritas Hari Ini',
          color: Color(0xFF855300),
          icon: Icons.pending_actions,
          background: Color(0xFFFEF3C7),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: _MetricCard(
          title: 'Selesai',
          value: '15',
          suffix: 'Siswa',
          note: 'Tuntas Dinilai',
          color: _green,
          icon: Icons.check_circle,
        ),
      ),
    ],
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.suffix,
    required this.note,
    required this.color,
    required this.icon,
    this.background = Colors.white,
  });
  final String title, value, suffix, note;
  final Color color;
  final IconData icon;
  final Color background;
  @override
  Widget build(BuildContext context) => Container(
    height: 104,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(icon, color: color, size: 16),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                suffix,
                style: const TextStyle(color: _muted, fontSize: 9),
              ),
            ),
          ],
        ),
        Text(
          note,
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _SubmissionAssignmentCard extends StatelessWidget {
  const _SubmissionAssignmentCard();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(child: _SubjectBadge('Kemuhammadiyahan • Tugas 2')),
            SizedBox(width: 6),
            _CountBadge('3 Kiriman Baru'),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Resume Biografi Tokoh KH Ahmad Dahlan & Muhammadiyah',
          style: TextStyle(
            color: _ink,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Tenggat: Kemarin, 14:00 WIB • 19/21 Terkumpul',
          style: TextStyle(
            color: Color(0xFFE11D48),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'MENUNGGU PENILAIAN:',
          style: TextStyle(
            color: _muted,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const _SubmissionStudent(
          initials: 'FP',
          name: 'Farhan Pratama',
          attendanceNumber: '01',
          detail: 'Absen 01 • Kemarin 13:45 WIB',
          fileName: 'Resume_AhmadDahlan_Farhan.pdf',
          size: '1.2 MB',
          late: false,
        ),
        const SizedBox(height: 8),
        const _SubmissionStudent(
          initials: 'AP',
          name: 'Aisyah Putri',
          attendanceNumber: '02',
          detail: 'Absen 02 • Kemarin 12:10 WIB',
          fileName: 'Tugas_KH_Ahmad_Dahlan_Aisyah.pdf',
          size: '980 KB',
          late: false,
        ),
        const SizedBox(height: 8),
        const _SubmissionStudent(
          initials: 'FA',
          name: 'Fatih Al-Farisi',
          attendanceNumber: '03',
          detail: 'Absen 03 • Hari ini 07:15 WIB',
          fileName: 'Catatan_Kemuhammadiyahan_Fatih.jpg',
          size: '2.1 MB',
          late: true,
        ),
        const SizedBox(height: 10),
        Builder(
          builder: (context) => OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const SubmissionsScreen(),
              ),
            ),
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Lihat Semua 19 Pengumpulan'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _green,
              minimumSize: const Size.fromHeight(44),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
        ),
      ],
    ),
  );
}

class _SubjectBadge extends StatelessWidget {
  const _SubjectBadge(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5EE),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: _green,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _CountBadge extends StatelessWidget {
  const _CountBadge(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFFFEA619),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF684000),
        fontSize: 10,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class _SubmissionStudent extends StatelessWidget {
  const _SubmissionStudent({
    required this.initials,
    required this.name,
    required this.attendanceNumber,
    required this.detail,
    required this.fileName,
    required this.size,
    required this.late,
  });
  final String initials, name, attendanceNumber, detail, fileName, size;
  final bool late;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F3FF),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: late ? const Color(0xFF855300) : _green,
              foregroundColor: Colors.white,
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    detail,
                    style: const TextStyle(color: _muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            Text(
              late ? 'Susulan' : 'Tepat Waktu',
              style: TextStyle(
                color: late ? const Color(0xFF855300) : _green,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                fileName.endsWith('.jpg')
                    ? Icons.image_outlined
                    : Icons.picture_as_pdf_outlined,
                color: late ? _green : const Color(0xFFE11D48),
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              Text(size, style: const TextStyle(color: _muted, fontSize: 9)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Builder(
          builder: (context) => FilledButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => GradeSubmissionScreen(
                  studentName: name,
                  initials: initials,
                  attendanceNumber: attendanceNumber,
                  fileName: fileName,
                  fileSize: size,
                  isLate: late,
                ),
              ),
            ),
            icon: const Icon(Icons.rate_review, size: 18),
            label: const Text('Beri Nilai & Koreksi'),
            style: FilledButton.styleFrom(
              backgroundColor: _green,
              minimumSize: const Size.fromHeight(42),
            ),
          ),
        ),
      ],
    ),
  );
}

class _CompletedAssignmentCard extends StatelessWidget {
  const _CompletedAssignmentCard({
    required this.subject,
    required this.title,
    required this.progress,
  });
  final String subject, title, progress;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: const TextStyle(
                color: _green,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const Text(
              'Semua Dinilai',
              style: TextStyle(
                color: _green,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        Text(progress, style: const TextStyle(color: _muted, fontSize: 11)),
      ],
    ),
  );
}
