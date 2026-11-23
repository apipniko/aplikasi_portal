import 'package:flutter/material.dart';

const _page = Color(0xFFF9F9FF);
const _ink = Color(0xFF111C2D);
const _primary = Color(0xFF0D6E3F);
const _blue = Color(0xFF004C76);
const _gold = Color(0xFFFBBF24);
const _rose = Color(0xFFE11D48);

class PendingAssignmentsScreen extends StatefulWidget {
  const PendingAssignmentsScreen({
    super.key,
    this.title = 'Menghafal Doa Masuk & Keluar Masjid serta Surat Al-Insyirah',
    this.subject = 'Al-Islam & KMD',
    this.teacher = 'Ust. Fajar Anshori',
    this.deadline = 'Besok, 23.59 WIB',
    this.instructions = 'Rekam bacaan doa dan surat pendek dengan suara jelas, lalu unggah berkas audio (MP3/M4A) atau dokumen catatan.',
    this.isAudio = true,
  });

  final String title, subject, teacher, deadline, instructions;
  final bool isAudio;

  @override
  State<PendingAssignmentsScreen> createState() =>
      _PendingAssignmentsScreenState();
}

class _PendingAssignmentsScreenState extends State<PendingAssignmentsScreen> {
  final noteController = TextEditingController();
  bool fileSelected = false;
  bool recording = false;
  bool savedDraft = false;

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  void _openOtherTask() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const PendingAssignmentsScreen(
          title: 'Laporan Pengamatan Siklus Air Sederhana',
          subject: 'Ilmu Pengetahuan Alam',
          teacher: 'Ibu Rina Wulandari',
          deadline: 'Lusa, 23.59 WIB',
          instructions: 'Amati penggunaan air di rumah. Catat sumber air, tuliskan hasil pengamatan, lalu jelaskan tiga cara menghemat air.',
          isAudio: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _page,
      body: Column(
        children: [
          const _AssignmentHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              children: [
                const Text(
                  'Tugas Perlu Dikirim',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Kelas 4A • SD Muhammadiyah Tamantirto',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 14),
                _TaskDescriptionCard(
                  title: widget.title,
                  subject: widget.subject,
                  teacher: widget.teacher,
                  deadline: widget.deadline,
                  instructions: widget.instructions,
                  urgent: widget.isAudio,
                ),
                const SizedBox(height: 12),
                _SubmissionCard(
                  isAudio: widget.isAudio,
                  fileSelected: fileSelected,
                  recording: recording,
                  noteController: noteController,
                  onSelectFile: () {
                    setState(() => fileSelected = !fileSelected);
                    _message(
                      fileSelected
                          ? 'Berkas contoh berhasil ditambahkan.'
                          : 'Berkas dihapus dari pengumpulan.',
                    );
                  },
                  onToggleRecording: () {
                    setState(() => recording = !recording);
                    _message(
                      recording ? 'Perekaman dimulai.' : 'Perekaman dijeda.',
                    );
                  },
                  onPlay: () => _message(
                    recording
                        ? 'Selesaikan rekaman sebelum memutarnya.'
                        : 'Belum ada rekaman untuk diputar.',
                  ),
                  onDeleteRecording: () {
                    setState(() => recording = false);
                    _message('Rekaman dihapus.');
                  },
                  onSubmit: () => _message(
                    fileSelected || recording || noteController.text.isNotEmpty
                        ? 'Jawaban tugas siap dikirim.'
                        : 'Pilih berkas, rekam jawaban, atau tambahkan catatan terlebih dahulu.',
                  ),
                  onSaveDraft: () {
                    setState(() => savedDraft = true);
                    _message('Draf tugas berhasil disimpan.');
                  },
                  savedDraft: savedDraft,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Tugas Lainnya',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      widget.isAudio ? '1 Tugas Lagi' : 'Tugas Aktif',
                      style: const TextStyle(
                        color: _primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                _OtherTaskCard(onPressed: _openOtherTask),
                const SizedBox(height: 14),
                const Center(
                  child: Text(
                    'Data Simulasi / Contoh Prototipe Akademik',
                    style: TextStyle(
                      color: Colors.black45,
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

class _AssignmentHeader extends StatelessWidget {
  const _AssignmentHeader();

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
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFE7EEFF),
              foregroundColor: _ink,
            ),
            icon: const Icon(Icons.arrow_back, size: 20),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x66FBBF24),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              children: [
                Icon(Icons.bolt, size: 16, color: Color(0xFF855300)),
                SizedBox(width: 4),
                Text(
                  '2 Tugas Aktif',
                  style: TextStyle(
                    color: Color(0xFF855300),
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

BoxDecoration get _cardDecoration => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(14),
  boxShadow: const [
    BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
  ],
);

class _TaskDescriptionCard extends StatelessWidget {
  const _TaskDescriptionCard({
    required this.title,
    required this.subject,
    required this.teacher,
    required this.deadline,
    required this.instructions,
    required this.urgent,
  });

  final String title, subject, teacher, deadline, instructions;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration.copyWith(
        border: const Border(left: BorderSide(color: _primary, width: 6)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5EE),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.menu_book, size: 14, color: _primary),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            subject,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    teacher,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              title,
              style: const TextStyle(
                color: _ink,
                fontSize: 17,
                height: 1.3,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, size: 16, color: Color(0xFF855300)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      urgent
                          ? 'Segera Kumpulkan! • Tenggat: $deadline (Sisa 1 Hari)'
                          : 'Tenggat: $deadline',
                      style: const TextStyle(
                        color: Color(0xFF855300),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            const SizedBox(height: 9),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text: 'Instruksi Pengerjaan: ',
                    style: TextStyle(color: _ink, fontWeight: FontWeight.w900),
                  ),
                  TextSpan(text: instructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmissionCard extends StatelessWidget {
  const _SubmissionCard({
    required this.isAudio,
    required this.fileSelected,
    required this.recording,
    required this.noteController,
    required this.onSelectFile,
    required this.onToggleRecording,
    required this.onPlay,
    required this.onDeleteRecording,
    required this.onSubmit,
    required this.onSaveDraft,
    required this.savedDraft,
  });

  final bool isAudio, fileSelected, recording, savedDraft;
  final TextEditingController noteController;
  final VoidCallback onSelectFile;
  final VoidCallback onToggleRecording, onPlay, onDeleteRecording;
  final VoidCallback onSubmit, onSaveDraft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lembar Pengumpulan Tugas',
            style: TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: onSelectFile,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                border: Border.all(color: const Color(0xFFBEC9BE), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5EE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      fileSelected ? Icons.description : Icons.cloud_upload,
                      size: 24,
                      color: _primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fileSelected
                        ? 'Berkas jawaban siap dilampirkan'
                        : 'Ketuk untuk unggah berkas',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAudio
                        ? 'Mendukung MP3, M4A, PDF, JPG (Maks. 20MB)'
                        : 'Mendukung PDF, JPG, PNG (Maks. 20MB)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          if (isAudio) ...[
            const SizedBox(height: 14),
            const Row(
              children: [
                Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'ATAU REKAM LANGSUNG',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Color(0xFFE2E8F0))),
              ],
            ),
            const SizedBox(height: 12),
            _VoiceRecorder(
              recording: recording,
              onToggleRecording: onToggleRecording,
              onPlay: onPlay,
              onDelete: onDeleteRecording,
            ),
          ],
          const SizedBox(height: 14),
          const Text(
            'Catatan untuk Ustadz (opsional)',
            style: TextStyle(
              color: _ink,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: noteController,
            minLines: 2,
            maxLines: 4,
            style: const TextStyle(color: _ink, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Contoh: Ust, ini jawaban tugas saya...',
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 11),
              filled: true,
              fillColor: const Color(0xFFF9F9FF),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: onSubmit,
              style: FilledButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              icon: const Icon(Icons.send, size: 20),
              label: const Text(
                'Kirim Jawaban Tugas Sekarang',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton.icon(
              onPressed: onSaveDraft,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFDEE8FF),
                foregroundColor: _ink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              icon: Icon(savedDraft ? Icons.bookmark_added : Icons.bookmark),
              label: Text(savedDraft ? 'Draf Tersimpan' : 'Simpan Draf'),
            ),
          ),
        ],
      ),
    );
  }
}

class _VoiceRecorder extends StatelessWidget {
  const _VoiceRecorder({
    required this.recording,
    required this.onToggleRecording,
    required this.onPlay,
    required this.onDelete,
  });

  final bool recording;
  final VoidCallback onToggleRecording, onPlay, onDelete;

  @override
  Widget build(BuildContext context) {
    const waveHeights = [
      12.0,
      22.0,
      30.0,
      18.0,
      36.0,
      16.0,
      27.0,
      12.0,
      22.0,
      32.0,
      15.0,
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        border: Border.all(color: const Color(0x66E2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: recording ? _rose : Colors.black26,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Perekam Suara Cepat',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                recording ? 'Merekam...' : '00:00 / 03:00',
                style: const TextStyle(color: Colors.black54, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < waveHeights.length; i++)
                  Container(
                    width: 4,
                    height: waveHeights[i],
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: recording
                          ? _rose
                          : _primary.withValues(alpha: .35 + (i % 3) * .2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onToggleRecording,
                  style: FilledButton.styleFrom(
                    backgroundColor: _rose,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  icon: Icon(recording ? Icons.stop : Icons.mic, size: 18),
                  label: Text(
                    recording ? 'Berhenti' : 'Mulai Rekam',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onPlay,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF9F9FF),
                  foregroundColor: _ink,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: onDelete,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF9F9FF),
                  foregroundColor: _rose,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OtherTaskCard extends StatelessWidget {
  const _OtherTaskCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration.copyWith(
        border: const Border(left: BorderSide(color: _gold, width: 5)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TaskSubjectPill(),
                SizedBox(height: 6),
                Text(
                  'Laporan Pengamatan Siklus Air Sederhana',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Tenggat: Lusa, 23.59 WIB',
                  style: TextStyle(color: Colors.black54, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDEE8FF),
              foregroundColor: _ink,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Kerjakan',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskSubjectPill extends StatelessWidget {
  const _TaskSubjectPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'Ilmu Pengetahuan Alam',
        style: TextStyle(
          color: _blue,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
