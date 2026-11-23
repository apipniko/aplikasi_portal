import 'package:flutter/material.dart';

import 'siswa/student_dashboard_screen.dart';
import 'siswa/student_schedule_screen.dart';
import 'siswa/student_materials_screen.dart';
import 'siswa/student_grades_screen.dart';
import 'announcements_screen.dart';
import 'siswa/pending_assignments_screen.dart';
import 'siswa/material_detail_screen.dart';
import 'guru/teacher_dashboard_screen.dart';
import 'guru/teacher_schedule_screen.dart';
import 'guru/teacher_materials_screen.dart';
import 'guru/upload_material_screen.dart';
import 'guru/create_assignment_screen.dart';
import 'guru/submissions_screen.dart';
import 'guru/grade_submission_screen.dart';
import 'guru/grade_management_screen.dart';

class PortalRoute {
  const PortalRoute(this.group, this.title, this.page);
  final String group, title;
  final Widget page;
}

final portalRoutes = <PortalRoute>[
  PortalRoute('Siswa', 'Beranda Siswa', const StudentDashboardScreen()),
  PortalRoute('Siswa', 'Jadwal Pelajaran', const StudentScheduleScreen()),
  PortalRoute('Siswa', 'Materi dan Tugas', const StudentMaterialsScreen()),
  PortalRoute('Siswa', 'Nilai Siswa', const StudentGradesScreen()),
  PortalRoute('Siswa', 'Pengumuman dan Kegiatan', const AnnouncementsScreen()),
  PortalRoute('Siswa', 'Tugas Perlu Dikirim', const PendingAssignmentsScreen()),
  PortalRoute(
    'Siswa',
    'Detail Materi Pembelajaran',
    const MaterialDetailScreen(),
  ),
  PortalRoute('Guru', 'Beranda Guru', const TeacherDashboardScreen()),
  PortalRoute('Guru', 'Jadwal Mengajar', const TeacherScheduleScreen()),
  PortalRoute(
    'Guru',
    'Kelola Materi dan Tugas',
    const TeacherMaterialsScreen(),
  ),
  PortalRoute(
    'Guru',
    'Unggah Materi Pembelajaran',
    const UploadMaterialScreen(),
  ),
  PortalRoute('Guru', 'Buat Penugasan Baru', const CreateAssignmentScreen()),
  PortalRoute('Guru', 'Tugas Masuk untuk Dikoreksi', const SubmissionsScreen()),
  PortalRoute('Guru', 'Beri Nilai dan Koreksi', const GradeSubmissionScreen()),
  PortalRoute('Guru', 'Kelola Input Nilai', const GradeManagementScreen()),
];
