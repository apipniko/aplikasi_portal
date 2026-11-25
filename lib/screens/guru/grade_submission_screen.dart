import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _green = Color(0xFF0D6E3F);
const _ink = Color(0xFF111C2D);
const _muted = Color(0xFF64748B);
const _surface = Color(0xFFF9F9FF);

class GradeSubmissionScreen extends StatefulWidget {
  const GradeSubmissionScreen({
    super.key,
    this.studentName = 'Farhan Pratama',
    this.initials = 'FP',
    this.attendanceNumber = '01',
    this.fileName = 'Resume_AhmadDahlan_Farhan.pdf',
    this.fileSize = '1.2 MB',
    this.isLate = false,
  });

  final String studentName;
  final String initials;
  final String attendanceNumber;
  final String fileName;
  final String fileSize;
  final bool isLate;

  @override
  State<GradeSubmissionScreen> createState() => _GradeSubmissionScreenState();
}

class _GradeSubmissionScreenState extends State<GradeSubmissionScreen> {
  late final TextEditingController _scoreController;
  late final TextEditingController _feedbackController;

  @override
  void initState() {
    super.initState();
    _scoreController = TextEditingController(text: '95');
    _feedbackController = TextEditingController(
      text:
          'MasyaAllah ${widget.studentName.split(' ').first}, resume sangat rapi, '
          'pemaparan latar belakang pendirian Muhammadiyah dan pengamalan '
          "teologi Al-Ma'un sangat lengkap dan berbobot. Pertahankan ketekunannya!",
    );
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  int get _score =>
      (int.tryParse(_scoreController.text) ?? 0).clamp(0, 100).toInt();

  String get _predicate {
    if (_score >= 90) return 'Mumtaz (A)';
    if (_score >= 80) return 'Jayyid Jiddan (B)';
    if (_score >= 75) return 'Jayyid (C)';
    return 'Perlu Bimbingan';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _surface,
    appBar: AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        tooltip: 'Kembali ke Tugas Masuk',
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Koreksi & Nilai Tugas',
            style: TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            '${widget.studentName} (Absen ${widget.attendanceNumber}) • Kelas 4A',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _muted, fontSize: 10),
          ),
        ],
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        _SubmissionStatusBanner(isLate: widget.isLate),
        const SizedBox(height: 12),
        _StudentCard(
          name: widget.studentName,
          initials: widget.initials,
          attendanceNumber: widget.attendanceNumber,
        ),
        const SizedBox(height: 12),
        _DocumentCard(fileName: widget.fileName, fileSize: widget.fileSize),
        const SizedBox(height: 12),
        _gradingCard(),
        const SizedBox(height: 12),
        _actionButtons(context),
      ],
    ),
  );

  Widget _gradingCard() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [BoxShadow(color: Color(0x09000000), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.fact_check, color: _green, size: 23),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Penilaian & Rubrik Guru',
                style: TextStyle(
                  color: _ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE7EEFF),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'KKM: 75',
                style: TextStyle(
                  color: _muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5EE),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NILAI ANGKA AKHIR',
                      style: TextStyle(
                        color: _green,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 82,
                          child: TextField(
                            controller: _scoreController,
                            onChanged: (_) => setState(() {}),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: _green,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '/ 100',
                          style: TextStyle(
                            color: _green,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Predikat Capaian',
                    style: TextStyle(color: _muted, fontSize: 10),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _green,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _predicate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _score >= 75 ? 'Di atas KKM' : 'Belum mencapai KKM',
                    style: TextStyle(
                      color: _score >= 75
                          ? const Color(0xFF059669)
                          : const Color(0xFFE11D48),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Row(
          children: [
            Icon(Icons.tune, color: Color(0xFF855300), size: 19),
            SizedBox(width: 6),
            Text(
              'Aspek Penilaian Formatif',
              style: TextStyle(
                color: _ink,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const _RubricItem(
          title: '1. Fakta & Sejarah Kemuhammadiyahan',
          score: 95,
          note: "Pemahaman berdirinya 18 November 1912 dan teologi Al-Ma'un tepat.",
        ),
        const SizedBox(height: 7),
        const _RubricItem(
          title: '2. Kerapian Bahasa & Sistematika Resume',
          score: 92,
          note: 'Runtun, penggunaan ejaan baku memadai untuk siswa kelas 4.',
        ),
        const SizedBox(height: 7),
        const _RubricItem(
          title: '3. Nilai Karakter & Akhlak ISMUBA',
          score: 98,
          note: 'Menonjolkan nilai kepedulian yatim dhuafa dan disiplin kepanduan HW.',
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Catatan Evaluasi Guru untuk Siswa',
                style: TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _feedbackController.clear(),
              child: const Text('Hapus'),
            ),
          ],
        ),
        const Text(
          'Catatan ini akan disampaikan kepada siswa dan wali murid.',
          style: TextStyle(color: _muted, fontSize: 10),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FeedbackChip(
                label: 'Sangat Baik ✨',
                color: const Color(0xFFE8F5EE),
                textColor: _green,
                onTap: () => _addFeedback('Sangat baik, pertahankan!'),
              ),
              const SizedBox(width: 6),
              _FeedbackChip(
                label: 'Lengkap & Tepat 🎯',
                color: const Color(0xFFE7EEFF),
                textColor: _ink,
                onTap: () => _addFeedback('Jawaban lengkap dan tepat.'),
              ),
              const SizedBox(width: 6),
              _FeedbackChip(
                label: 'Perlu Dirapikan 📝',
                color: const Color(0xFFFEF3C7),
                textColor: const Color(0xFF855300),
                onTap: () => _addFeedback('Silakan rapikan kembali tugasnya.'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _feedbackController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Tulis catatan evaluasi untuk siswa...',
            filled: true,
            fillColor: _surface,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _actionButtons(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilledButton.icon(
        onPressed: _scoreController.text.isEmpty
            ? null
            : () {
                _showSavedMessage(context, 'Nilai berhasil dikirim ke siswa');
                Navigator.pop(context);
              },
        icon: const Icon(Icons.check_circle),
        label: const Text('Simpan & Kirim Nilai ke Siswa'),
        style: FilledButton.styleFrom(
          backgroundColor: _green,
          minimumSize: const Size.fromHeight(50),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      const SizedBox(height: 8),
      FilledButton(
        onPressed: () {
          _showSavedMessage(context, 'Nilai Farhan tersimpan');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const GradeSubmissionScreen(
                studentName: 'Aisyah Putri',
                initials: 'AP',
                attendanceNumber: '02',
                fileName: 'Tugas_KH_Ahmad_Dahlan_Aisyah.pdf',
                fileSize: '980 KB',
              ),
            ),
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFFEA619),
          foregroundColor: const Color(0xFF2A1700),
          minimumSize: const Size.fromHeight(50),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
        child: const Text(
          'Simpan & Lanjut ke Siswa Berikutnya  •  Aisyah Putri (02)',
        ),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () => _requestRevision(context),
        icon: const Icon(Icons.replay),
        label: const Text('Minta Siswa Memperbaiki / Revisi Berkas'),
        style: OutlinedButton.styleFrom(
          foregroundColor: _muted,
          backgroundColor: Colors.white,
          minimumSize: const Size.fromHeight(46),
          side: BorderSide.none,
        ),
      ),
    ],
  );

  void _addFeedback(String text) {
    final current = _feedbackController.text.trim();
    _feedbackController.text = current.isEmpty ? text : '$current $text';
    _feedbackController.selection = TextSelection.collapsed(
      offset: _feedbackController.text.length,
    );
    setState(() {});
  }

  void _showSavedMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> _requestRevision(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Minta Revisi Berkas?'),
        content: Text(
          'Siswa ${widget.studentName} akan diminta mengirim ulang tugasnya.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Kirim Permintaan'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      _showSavedMessage(context, 'Permintaan revisi dikirim kepada siswa');
    }
  }
}

class _SubmissionStatusBanner extends StatelessWidget {
  const _SubmissionStatusBanner({required this.isLate});
  final bool isLate;
  @override
  Widget build(BuildContext context) {
    final color = isLate ? const Color(0xFF855300) : _green;
    final background = isLate
        ? const Color(0xFFFEF3C7)
        : const Color(0xFFE8F5EE);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.assignment_turned_in, color: color, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dikumpulkan: Kemarin, 13:45 WIB',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Kemuhammadiyahan • Semester Genap 2024/2025',
                  style: TextStyle(color: _muted, fontSize: 9),
                ),
              ],
            ),
          ),
          Text(
            isLate ? 'SUSULAN' : 'TEPAT WAKTU',
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({
    required this.name,
    required this.initials,
    required this.attendanceNumber,
  });
  final String name, initials, attendanceNumber;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: _green,
          child: Text(
            initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
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
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'NISN: 00142981 • Siswa Aktif',
                style: const TextStyle(color: _muted, fontSize: 10),
              ),
            ],
          ),
        ),
        Text(
          'Tugas Ke-4\nAbsen $attendanceNumber',
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: _muted,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _DocumentCard extends StatelessWidget {
  const _DocumentCard({required this.fileName, required this.fileSize});
  final String fileName, fileSize;
  @override
  Widget build(BuildContext context) {
    final isPdf = fileName.toLowerCase().endsWith('.pdf');
    final fileType = isPdf ? 'PDF' : 'Gambar';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isPdf ? Icons.picture_as_pdf : Icons.image_outlined,
                color: isPdf ? const Color(0xFFE11D48) : _green,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Berkas Tugas Siswa',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '$fileSize • $fileType',
                style: const TextStyle(color: _muted, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3FF),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Icon(
                  isPdf ? Icons.description : Icons.image_outlined,
                  color: isPdf ? const Color(0xFFBA1A1A) : _green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF059669),
                  size: 18,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRATINJAU LEMBAR KERJA SISWA',
                      style: TextStyle(
                        color: _green,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Halaman 1 dari 2',
                      style: TextStyle(color: _muted, fontSize: 9),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                _DocumentPreviewText(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 17),
                  label: const Text('Unduh PDF'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _ink,
                    backgroundColor: const Color(0xFFE7EEFF),
                    side: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_full, size: 17),
                  label: const Text('Buka Dokumen'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _green,
                    backgroundColor: const Color(0xFFE8F5EE),
                    side: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocumentPreviewText extends StatelessWidget {
  const _DocumentPreviewText();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(9),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Perjuangan KH Ahmad Dahlan Mendirikan Persyarikatan Muhammadiyah Tahun 1912 di Kauman Yogyakarta',
          style: TextStyle(
            color: _ink,
            fontSize: 13,
            height: 1.35,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Kyai Haji Ahmad Dahlan (Muhammad Darwis) lahir di Kampung Kauman Yogyakarta. Beliau prihatin melihat kondisi umat Islam yang mengalami kebodohan dan keterbelakangan. Terinspirasi oleh ajaran mulia dalam Surat Al-Ma’un, Kyai Dahlan mengajarkan bahwa keimanan sejati wajib dibuktikan dengan kepedulian nyata terhadap fakir miskin, pertolongan bagi anak yatim, dan pembaharuan bidang pendidikan modern.',
          style: TextStyle(color: _muted, fontSize: 10, height: 1.5),
        ),
        SizedBox(height: 7),
        Text(
          'Pada tanggal 18 November 1912, Persyarikatan Muhammadiyah resmi didirikan di Kauman, Yogyakarta. Muhammadiyah mendirikan madrasah modern dan kepanduan Hizbul Wathan untuk membentuk generasi mandiri dan berakhlak mulia.',
          style: TextStyle(color: _muted, fontSize: 10, height: 1.5),
        ),
      ],
    ),
  );
}

class _RubricItem extends StatelessWidget {
  const _RubricItem({
    required this.title,
    required this.score,
    required this.note,
  });
  final String title, note;
  final int score;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '$score / 100',
              style: const TextStyle(
                color: _green,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: score / 100,
            minHeight: 6,
            backgroundColor: const Color(0xFFE7EEFF),
            color: _green,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          note,
          style: const TextStyle(color: _muted, fontSize: 10, height: 1.35),
        ),
      ],
    ),
  );
}

class _FeedbackChip extends StatelessWidget {
  const _FeedbackChip({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });
  final String label;
  final Color color, textColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ActionChip(
    label: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
    backgroundColor: color,
    side: BorderSide.none,
    onPressed: onTap,
  );
}
