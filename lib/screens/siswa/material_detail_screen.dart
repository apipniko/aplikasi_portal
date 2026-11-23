import 'package:flutter/material.dart';

const _page = Color(0xFFF9F9FF);
const _ink = Color(0xFF111C2D);
const _green = Color(0xFF08492A);
const _primary = Color(0xFF0D6E3F);
const _blue = Color(0xFF004C76);

class MaterialDetailScreen extends StatefulWidget {
  const MaterialDetailScreen({
    super.key,
    this.title = 'Mengenal Tokoh Teladan K.H. Ahmad Dahlan',
    this.subject = 'Al-Islam & Kemuhammadiyahan',
    this.teacher = 'Ust. Fajar Anshori, S.Pd.I',
    this.format = 'PDF Doc',
    this.size = '4.2 MB',
    this.pageCount = 12,
    this.subjectIcon = Icons.auto_stories,
  });

  final String title, subject, teacher, format, size;
  final int pageCount;
  final IconData subjectIcon;

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  final notesController = TextEditingController();
  int currentPage = 1;
  int zoomLevel = 0;
  bool savedOffline = false;

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _page,
      body: Column(
        children: [
          _DetailTopBar(subject: widget.subject),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                _MaterialInfoCard(
                  title: widget.title,
                  subject: widget.subject,
                  teacher: widget.teacher,
                  format: widget.format,
                  size: widget.size,
                  pageCount: widget.pageCount,
                  subjectIcon: widget.subjectIcon,
                ),
                const SizedBox(height: 12),
                _DocumentPreview(
                  title: widget.title,
                  currentPage: currentPage,
                  pageCount: widget.pageCount,
                  zoomLevel: zoomLevel,
                  onZoomIn: () => setState(() {
                    zoomLevel = (zoomLevel + 1).clamp(0, 3);
                  }),
                  onZoomOut: () => setState(() {
                    zoomLevel = (zoomLevel - 1).clamp(0, 3);
                  }),
                  onPrevious: currentPage > 1
                      ? () => setState(() => currentPage--)
                      : null,
                  onNext: currentPage < widget.pageCount
                      ? () => setState(() => currentPage++)
                      : null,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => _showMessage(
                      'Mengunduh berkas ${widget.format} (${widget.size})...',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: _primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    icon: const Icon(Icons.download, size: 20),
                    label: Text(
                      'Unduh Berkas ${widget.format} (${widget.size})',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () {
                      setState(() => savedOffline = !savedOffline);
                      _showMessage(
                        savedOffline
                            ? 'Materi berhasil disimpan untuk akses offline!'
                            : 'Materi dihapus dari daftar offline.',
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFEA619),
                      foregroundColor: _ink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    icon: Icon(
                      savedOffline
                          ? Icons.bookmark_added
                          : Icons.bookmark_add_outlined,
                      size: 20,
                    ),
                    label: Text(
                      savedOffline
                          ? 'Tersimpan Offline'
                          : 'Simpan ke Materi Offline Saya',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _StudyNotes(
                  controller: notesController,
                  onSave: () => _showMessage('Catatan berhasil disimpan!'),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info_outline, size: 15, color: Colors.black45),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Data Contoh Prototipe Akademik - SD Muhammadiyah Tamantirto',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black45, fontSize: 10),
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
    );
  }
}

class _DetailTopBar extends StatelessWidget {
  const _DetailTopBar({required this.subject});

  final String subject;

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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Detail Materi Ajar',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5EE),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Icon(Icons.menu_book, color: _primary, size: 20),
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

class _MaterialInfoCard extends StatelessWidget {
  const _MaterialInfoCard({
    required this.title,
    required this.subject,
    required this.teacher,
    required this.format,
    required this.size,
    required this.pageCount,
    required this.subjectIcon,
  });

  final String title, subject, teacher, format, size;
  final int pageCount;
  final IconData subjectIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _DetailPill(
                text: subject,
                color: _primary,
                background: const Color(0xFFE8F5EE),
                icon: Icons.star,
              ),
              const _DetailPill(
                text: 'Tersedia Offline',
                color: _blue,
                background: Color(0xFFE0F2FE),
                icon: Icons.verified_user,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 21,
              height: 1.25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFFE7EEFF),
                child: Text(
                  'U',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Pengampu Kelas 4A • Diunggah 12 Jan 2025',
                      style: TextStyle(color: Colors.black54, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _DocumentMetric(label: 'Format', value: format),
              ),
              Expanded(
                child: _DocumentMetric(label: 'Ukuran', value: size),
              ),
              Expanded(
                child: _DocumentMetric(
                  label: 'Halaman',
                  value: '$pageCount Hal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailPill extends StatelessWidget {
  const _DetailPill({
    required this.text,
    required this.color,
    required this.background,
    required this.icon,
  });

  final String text;
  final Color color, background;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            text,
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

class _DocumentMetric extends StatelessWidget {
  const _DocumentMetric({required this.label, required this.value});

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 9),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _ink,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentPreview extends StatelessWidget {
  const _DocumentPreview({
    required this.title,
    required this.currentPage,
    required this.pageCount,
    required this.zoomLevel,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onPrevious,
    required this.onNext,
  });

  final String title;
  final int currentPage, pageCount, zoomLevel;
  final VoidCallback onZoomIn, onZoomOut;
  final VoidCallback? onPrevious, onNext;

  @override
  Widget build(BuildContext context) {
    final titleText = title.contains('Ahmad Dahlan')
        ? 'Biografi Singkat K.H. Ahmad Dahlan'
        : title;
    final scale = 1 + zoomLevel * .08;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: _cardDecoration,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: const Color(0xFFE7EEFF),
            child: Row(
              children: [
                const Icon(Icons.visibility, size: 18, color: _primary),
                const SizedBox(width: 7),
                const Expanded(
                  child: Text(
                    'Pratinjau Dokumen',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onZoomIn,
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _ink,
                  ),
                  icon: const Icon(Icons.zoom_in, size: 17),
                ),
                IconButton(
                  onPressed: onZoomOut,
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _ink,
                  ),
                  icon: const Icon(Icons.zoom_out, size: 17),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFF9F9FF),
            child: Column(
              children: [
                const Text(
                  'MODUL PEMBELAJARAN 04',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _primary,
                    fontSize: 10,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _ink,
                    fontSize: 17 * scale,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 142,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE8F5EE), Color(0xFFB7D7C2)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 18,
                        bottom: 10,
                        child: Icon(
                          Icons.menu_book,
                          size: 106,
                          color: Colors.white.withValues(alpha: .72),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 12,
                        child: Icon(
                          Icons.auto_stories,
                          size: 46,
                          color: _primary.withValues(alpha: .55),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.school, size: 36, color: _green),
                          SizedBox(height: 4),
                          Text(
                            'Belajar • Berilmu • Berkemajuan',
                            style: TextStyle(
                              color: _green,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  currentPage == 1
                      ? 'K.H. Ahmad Dahlan lahir di Yogyakarta dengan nama Muhammad Darwis. Beliau adalah ulama pembaharu Islam di Indonesia sekaligus pendiri organisasi Muhammadiyah pada tahun 1912 M.'
                      : 'Semangat perjuangan beliau didasarkan pada kecintaan terhadap Al-Qur’an dan Sunnah, serta kepedulian terhadap pendidikan anak bangsa dan kemajuan umat Islam.',
                  style: TextStyle(
                    color: const Color(0xFF3F4941),
                    fontSize: 13 * scale,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  currentPage == 1
                      ? 'Semangat perjuangannya menjadi teladan dalam menuntut ilmu dan mengamalkan kebaikan.'
                      : 'Nilai keteladanan yang dapat kita pelajari adalah tekun, peduli, dan terus berusaha memberi manfaat.',
                  style: TextStyle(
                    color: const Color(0xFF3F4941),
                    fontSize: 13 * scale,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: onPrevious,
                  icon: const Icon(Icons.chevron_left, size: 17),
                  label: const Text('Sebelumnya'),
                  style: TextButton.styleFrom(
                    foregroundColor: _ink,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Halaman $currentPage dari $pageCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onNext,
                  style: TextButton.styleFrom(
                    foregroundColor: _primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Selanjutnya'),
                      SizedBox(width: 3),
                      Icon(Icons.chevron_right, size: 17),
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

class _StudyNotes extends StatelessWidget {
  const _StudyNotes({required this.controller, required this.onSave});

  final TextEditingController controller;
  final VoidCallback onSave;

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
              Icon(Icons.edit_note, size: 20, color: _primary),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  'Catatan Belajar Pribadi',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Opsional',
                style: TextStyle(color: Colors.black54, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            'Tulis hal penting dari materi ini agar mudah diingat saat ujian:',
            style: TextStyle(color: Colors.black54, fontSize: 11, height: 1.4),
          ),
          const SizedBox(height: 9),
          TextField(
            controller: controller,
            minLines: 3,
            maxLines: 5,
            style: const TextStyle(color: _ink, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Contoh: Muhammadiyah didirikan pada 8 Dzulhijjah 1330 H / 18 November 1912...',
              hintStyle: const TextStyle(
                color: Colors.black38,
                fontSize: 11,
                height: 1.4,
              ),
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
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: onSave,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFE7EEFF),
                foregroundColor: _ink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Simpan Catatan',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
