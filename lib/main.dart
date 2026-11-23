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
  bool get isTeacher => widget.role == 'Guru / Staf';

  List<Widget> get pages => isTeacher
      ? const [
          TeacherDashboardScreen(),
          TeacherScheduleScreen(),
          TeacherMaterialsScreen(),
          AnnouncementsScreen(),
          GradeManagementScreen(),
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
    backgroundColor: const Color(0xFFF9F9FF),
    body: SafeArea(child: pages[selected]),
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
    appBar: null,
    bottomNavigationBar: NavigationBar(
      selectedIndex: selected,
      onDestinationSelected: (i) => setState(() => selected = i),
      backgroundColor: Colors.white,
      elevation: 3,
      indicatorColor: const Color(0xFFE8F5EE),
      height: 68,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
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
