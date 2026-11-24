import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/portal_routes.dart';
import 'screens/siswa/student_dashboard_screen.dart';
import 'screens/siswa/student_schedule_screen.dart';
import 'screens/siswa/student_materials_screen.dart';
import 'screens/siswa/student_grades_screen.dart';
import 'screens/announcements_screen.dart';
import 'screens/guru/teacher_dashboard_screen.dart';
import 'screens/guru/teacher_schedule_screen.dart';
import 'screens/guru/teacher_materials_screen.dart';
import 'screens/guru/grade_management_screen.dart';

void main() => runApp(const MadaniApp());

class MadaniApp extends StatelessWidget {
  const MadaniApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Madani Belajar',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E3F)),
    ),
    home: LoginScreen(
      onLogin: (context, role) => Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => PortalHome(role: role)),
      ),
    ),
  );
}

class PortalHome extends StatefulWidget {
  const PortalHome({super.key, required this.role});
  final String role;
  @override
  State<PortalHome> createState() => _PortalHomeState();
}

class _PortalHomeState extends State<PortalHome> {
  int selected = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool get isTeacher => widget.role == 'Guru / Staf';

  List<Widget> get pages => isTeacher
      ? const [
          TeacherDashboardScreen(),
          TeacherMaterialsScreen(),
          GradeManagementScreen(),
          TeacherScheduleScreen(),
        ]
      : const [
          StudentDashboardScreen(),
          StudentScheduleScreen(),
          StudentMaterialsScreen(),
          StudentGradesScreen(),
          AnnouncementsScreen(),
        ];
  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    backgroundColor: const Color(0xFFF9F9FF),
    appBar: isTeacher
        ? _TeacherHeader(onMenu: () => _scaffoldKey.currentState?.openDrawer())
        : null,
    body: SafeArea(top: false, child: pages[selected]),
    drawer: Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0D6E3F)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Madani Belajar\\nSD Muhammadiyah Tamantirto',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            for (final group in [isTeacher ? 'Guru' : 'Siswa']) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 5),
                child: Text(
                  group,
                  style: const TextStyle(
                    color: Color(0xFF0D6E3F),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              for (final route in portalRoutes.where((r) => r.group == group))
                ListTile(
                  title: Text(route.title),
                  leading: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(builder: (_) => route.page),
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: selected,
      onDestinationSelected: (i) => setState(() => selected = i),
      backgroundColor: Colors.white,
      elevation: 3,
      indicatorColor: const Color(0xFFE8F5EE),
      height: 68,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: isTeacher
          ? const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Materi & Tugas',
              ),
              NavigationDestination(
                icon: Icon(Icons.assignment_turned_in_outlined),
                label: 'Input Nilai',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Jadwal',
              ),
            ]
          : const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Jadwal',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Materi',
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                label: 'Nilai',
              ),
              NavigationDestination(
                icon: Icon(Icons.campaign_outlined),
                label: 'Info',
              ),
            ],
    ),
  );
}

class _TeacherHeader extends StatelessWidget implements PreferredSizeWidget {
  const _TeacherHeader({required this.onMenu});
  final VoidCallback onMenu;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Menu',
            onPressed: onMenu,
            icon: Image.asset(
              'assets/images/school_logo.png',
              width: 42,
              height: 42,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 4),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SD MUHAMMADIYAH TAMANTIRTO',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF0D6E3F),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .7,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Ustadzah Rahma, S.Pd.',
                  style: TextStyle(
                    color: Color(0xFF111C2D),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Wali Kelas 4A • Portal Pendidik',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF0D6E3F),
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ],
      ),
    ),
  );
}
