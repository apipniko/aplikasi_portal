import 'package:flutter/material.dart';

import 'portal_screen.dart';

const _onSurface = Color(0xFF111C2D);
const _surfaceVariant = Color(0xFF3F4941);
const _surfaceLow = Color(0xFFF0F3FF);
const _borderSubtle = Color(0xFFE2E8F0);
const _skyTint = Color(0xFFE0F2FE);
const _successTeal = Color(0xFF059669);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLogin});
  final void Function(BuildContext context, String role) onLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final id = TextEditingController();
  final pin = TextEditingController();
  bool hidePin = true;
  String role = 'Siswa';

  @override
  void dispose() {
    id.dispose();
    pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: portalBg,
    body: SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          24 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(),
                  const SizedBox(height: 16),
                  _loginCard(),
                  const SizedBox(height: 16),
                  _classroomBanner(),
                  const SizedBox(height: 16),
                  _helpCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _header() => Column(
    children: [
      Container(
        width: 92,
        height: 92,
        margin: const EdgeInsets.only(bottom: 12),
        child: Image.asset(
          'assets/images/school_logo.png',
          fit: BoxFit.contain,
        ),
      ),
      const Text(
        'SD Muhammadiyah Tamantirto',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _onSurface,
          fontSize: 24,
          height: 1.3,
          fontWeight: FontWeight.w800,
          letterSpacing: -.4,
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        'Portal Akademik & Pembelajaran • Geblagan, Tamantirto, Kasihan, Bantul',
        textAlign: TextAlign.center,
        style: TextStyle(color: _surfaceVariant, fontSize: 13, height: 1.45),
      ),
      const SizedBox(height: 10),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 6,
        runSpacing: 6,
        children: [
          _badge(
            Icons.event_available,
            'Semester Genap 2024/2025',
            const Color(0xFFE8F5EE),
            portalGreen,
          ),
          _badge(
            Icons.info_outline,
            'Data Simulasi / Contoh',
            const Color(0xFFDEE8FF),
            _surfaceVariant,
          ),
        ],
      ),
    ],
  );

  Widget _loginCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _borderSubtle),
      boxShadow: const [
        BoxShadow(
          color: Color(0x12000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: _FieldLabel(
                icon: Icons.badge_outlined,
                label: 'Nomor Induk / Identitas Pengguna',
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Pilih peran',
              onSelected: (value) => setState(() => role = value),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'Siswa', child: Text('Siswa')),
                PopupMenuItem(value: 'Guru / Staf', child: Text('Guru / Staf')),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: _surfaceLow,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      role,
                      style: const TextStyle(
                        color: portalGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.expand_more, color: portalGreen, size: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: id,
          maxLength: 30,
          keyboardType: TextInputType.text,
          decoration: _inputDecoration(
            hintText: 'NISN (Siswa) atau NIP / NBM Muhammadiyah',
            prefixIcon: Icons.account_circle_outlined,
          ),
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Nomor identitas wajib diisi'
              : null,
        ),
        const SizedBox(height: 2),
        Text(
          role == 'Siswa'
              ? 'Masukkan 10 digit NISN siswa.'
              : 'Masukkan NIP / NBM Muhammadiyah pendidik atau staf.',
          style: const TextStyle(
            color: _surfaceVariant,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(
              child: _FieldLabel(
                icon: Icons.password_outlined,
                label: 'PIN / Kata Sandi Masuk',
              ),
            ),
            TextButton(
              onPressed: () => _showHelp(context),
              style: TextButton.styleFrom(
                foregroundColor: portalGreen,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Lupa Sandi / PIN?',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: pin,
          maxLength: 20,
          obscureText: hidePin,
          decoration: _inputDecoration(
            hintText: '••••••',
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              tooltip: hidePin ? 'Tampilkan PIN' : 'Sembunyikan PIN',
              onPressed: () => setState(() => hidePin = !hidePin),
              icon: Icon(
                hidePin
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (value) => value == null || value.isEmpty
              ? 'PIN atau kata sandi wajib diisi'
              : null,
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Expanded(
              child: Text(
                role == 'Siswa'
                    ? 'PIN 6 digit siswa'
                    : 'Kata sandi akun pendidik/staf',
                style: const TextStyle(
                  color: _surfaceVariant,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
            const Icon(Icons.shield_outlined, color: _successTeal, size: 15),
            const SizedBox(width: 4),
            const Text(
              'Terproteksi',
              style: TextStyle(
                color: _successTeal,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 48,
          child: FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.onLogin(context, role);
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: portalGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              elevation: 2,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Masuk ke Portal',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _classroomBanner() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _surfaceLow,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/login_classroom.png',
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ruang Belajar Digital',
                style: TextStyle(
                  color: portalGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Selamat datang di kelas pintar 2024/2025',
                style: TextStyle(
                  color: _surfaceVariant,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'SD Muhammadiyah Tamantirto Mandiri & Berakhlak',
                style: TextStyle(color: _surfaceVariant, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _helpCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _borderSubtle),
      boxShadow: const [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _skyTint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.contact_support_outlined,
                color: Color(0xFF004C76),
                size: 21,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Butuh Bantuan Akses Masuk?',
                    style: TextStyle(
                      color: _onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Layanan Tata Usaha (TU) & Operator Dapodik Sekolah',
                    style: TextStyle(
                      color: _surfaceVariant,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _contactRow(
          Icons.call_outlined,
          'Kantor TU: (0274) 412345',
          '07.00 - 14.30 WIB',
        ),
        const SizedBox(height: 8),
        _contactRow(
          Icons.mail_outline,
          'tu@sdmutamantirto.sch.id',
          'Email Resmi',
        ),
        const SizedBox(height: 12),
        const Text(
          'Majelis Pendidikan Dasar & Menengah PCM Kasihan • Yogyakarta',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black45, fontSize: 11, height: 1.4),
        ),
      ],
    ),
  );

  Widget _contactRow(IconData icon, String label, String detail) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: _surfaceLow,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Row(
      children: [
        Icon(icon, color: portalGreen, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          detail,
          style: const TextStyle(color: _surfaceVariant, fontSize: 10),
        ),
      ],
    ),
  );

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
      borderSide: const BorderSide(color: _borderSubtle),
    );
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black45, fontSize: 13),
      prefixIcon: Icon(prefixIcon, color: Colors.black45, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFFAFBFF),
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: portalGreen, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1.5),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: portalGreen, size: 18),
      const SizedBox(width: 6),
      Flexible(
        child: Text(
          label,
          style: const TextStyle(
            color: _onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

Widget _badge(
  IconData icon,
  String label,
  Color background,
  Color foreground,
) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(999),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: foreground, size: 14),
      const SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  ),
);

void _showHelp(BuildContext context) => showDialog<void>(
  context: context,
  builder: (_) => const AlertDialog(
    title: Text('Bantuan akses'),
    content: Text(
      'Hubungi Tata Usaha SD Muhammadiyah Tamantirto di (0274) 412345, pukul 07.00-14.30 WIB, atau tu@sdmutamantirto.sch.id.',
    ),
    actions: [CloseButton()],
  ),
);
