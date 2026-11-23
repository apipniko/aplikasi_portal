import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apk_sd_muh_tamantirto/main.dart';

void main() {
  testWidgets('login, student tabs, and teacher screens render', (
    tester,
  ) async {
    await tester.pumpWidget(const MadaniApp());
    expect(find.text('Nomor Induk / Identitas Pengguna'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), '0123456789');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.ensureVisible(find.text('Masuk ke Portal'));
    await tester.tap(find.text('Masuk ke Portal'));
    await tester.pumpAndSettle();
    expect(find.text('Hari ini'), findsOneWidget);
    await tester.tap(find.text('Jadwal'));
    await tester.pumpAndSettle();
    expect(find.text('Jadwal Belajar Kelas 4A'), findsOneWidget);
    expect(find.text("Upacara Bendera & Tadarus Al-Qur'an"), findsOneWidget);
    await tester.tap(find.text('Materi'));
    await tester.pumpAndSettle();
    expect(find.text('Materi & Tugas'), findsOneWidget);
    expect(
      find.text('Mengenal Tokoh Teladan K.H. Ahmad Dahlan'),
      findsOneWidget,
    );
    await tester.tap(find.text('Buka Materi').first);
    await tester.pumpAndSettle();
    expect(find.text('Detail Materi Ajar'), findsOneWidget);
    expect(find.text('Pratinjau Dokumen'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tugas Siswa (2)'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Kirim Jawaban'));
    await tester.tap(find.text('Kirim Jawaban'));
    await tester.pumpAndSettle();
    expect(find.text('Tugas Perlu Dikirim'), findsOneWidget);
    expect(
      find.text('Latihan Menghitung Pecahan Sederhana Halaman 42'),
      findsOneWidget,
    );
    expect(find.text('Lembar Pengumpulan Tugas'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Info'));
    await tester.pumpAndSettle();
    expect(
      find.text('Persiapan Penilaian Tengah Semester (PTS) Genap 2024/2025'),
      findsOneWidget,
    );
  });
}
