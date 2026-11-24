import 'package:flutter/material.dart';

const portalGreen = Color(0xFF0D6E3F),
    portalInk = Color(0xFF1E293B),
    portalBg = Color(0xFFF9F9FF);

class PortalScreen extends StatefulWidget {
  const PortalScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.cards,
    this.search = false,
    this.form = false,
    this.primaryAction,
  });
  final String title, subtitle;
  final IconData icon;
  final List<PortalCardData> cards;
  final bool search, form;
  final String? primaryAction;
  @override
  State<PortalScreen> createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> {
  final query = TextEditingController();
  @override
  void dispose() {
    query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: portalBg,
    body: Column(
      children: [
        _PageHeader(title: widget.title),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            children: [
              Text(
                widget.subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              if (widget.search)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: TextField(
                    controller: query,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Cari ${widget.title.toLowerCase()}...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                  ),
                ),
              if (widget.form) const _FormFields(),
              ...widget.cards
                  .where(
                    (c) =>
                        query.text.isEmpty ||
                        ('${c.title} ${c.detail}').toLowerCase().contains(
                          query.text.toLowerCase(),
                        ),
                  )
                  .map(
                    (c) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _PortalCard(item: c),
                    ),
                  ),
              if (widget.primaryAction != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: FilledButton.icon(
                    onPressed: () => _message(context, widget.primaryAction!),
                    icon: const Icon(Icons.check),
                    label: Text(widget.primaryAction!),
                    style: FilledButton.styleFrom(
                      backgroundColor: portalGreen,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Data simulasi · SD Muhammadiyah Tamantirto',
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final isTeacher =
        title.contains('Guru') ||
        title.contains('Nilai Kurikulum') ||
        title.contains('Agenda Guru') ||
        title.contains('Kelola') ||
        title.contains('Unggah') ||
        title.contains('Buat Penugasan') ||
        title.contains('Tugas Masuk') ||
        title.contains('Beri Nilai');

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xDDF9F9FF),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: portalInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    SizedBox(
                      width: 6,
                      height: 6,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF08492A),
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
              color: isTeacher
                  ? const Color(0xFFE8F5EE)
                  : const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              isTeacher ? 'Guru' : 'Siswa',
              style: TextStyle(
                color: isTeacher
                    ? const Color(0xFF0D6E3F)
                    : const Color(0xFF0369A1),
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
              color: portalGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields();
  @override
  Widget build(BuildContext context) => const Column(
    children: [
      TextField(
        decoration: InputDecoration(
          labelText: 'Judul / nama',
          prefixIcon: Icon(Icons.edit_outlined),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 12),
      TextField(
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Keterangan / instruksi',
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.notes),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 14),
    ],
  );
}

class PortalCardData {
  const PortalCardData(
    this.title,
    this.detail,
    this.icon, {
    this.action,
    this.color = portalGreen,
  });
  final String title, detail;
  final IconData icon;
  final String? action;
  final Color color;
}

class _PortalCard extends StatelessWidget {
  const _PortalCard({required this.item});
  final PortalCardData item;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D0D6E3F),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(item.icon, color: item.color),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: portalInk,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.detail,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              if (item.action != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => _message(context, item.action!),
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: Text(item.action!),
                      style: TextButton.styleFrom(
                        foregroundColor: portalGreen,
                        padding: EdgeInsets.zero,
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

void _message(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
