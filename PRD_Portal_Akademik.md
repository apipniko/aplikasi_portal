# Product Requirements Document (PRD)

## Portal Akademik dan Pembelajaran SD Muhammadiyah Tamantirto

| Informasi | Keterangan |
|---|---|
| Status dokumen | Draf untuk validasi |
| Versi | 1.0 |
| Tanggal | 23 November 2026 |
| Sumber kebutuhan | `Metopen_UTS_Final_Stitch.md` dan prototipe Flutter di `lib/` |
| Produk | Portal Akademik dan Pembelajaran SD Muhammadiyah Tamantirto |

> **Catatan status:** PRD ini merangkum kebutuhan pada laporan metopen dan fungsi/layar yang tampak pada prototipe. Laporan yang tersedia baru memuat Bab I. Prototipe menggunakan data simulasi; fitur UI yang terlihat belum membuktikan bahwa autentikasi, penyimpanan, atau proses bisnis sudah terhubung ke layanan nyata. Butir yang belum diputuskan ditandai sebagai **perlu validasi**.

## 1. Ringkasan produk

Portal Akademik dan Pembelajaran SD Muhammadiyah Tamantirto adalah aplikasi untuk memusatkan informasi akademik dan pembelajaran sekolah. Admin dan guru mengelola informasi sesuai kewenangan, sementara siswa mengakses informasi yang relevan dengan kelasnya.

Produk ditujukan untuk penggunaan berbahasa Indonesia, dengan navigasi sederhana, tampilan yang mudah dipahami siswa sekolah dasar, dan antarmuka responsif. Laporan metopen meminta aplikasi web responsif; prototipe kode yang ditelaah adalah aplikasi Flutter. Pilihan platform produksi perlu disepakati sebelum implementasi lanjutan.

## 2. Latar belakang dan masalah

Informasi jadwal, materi, tugas, nilai, pengumuman, dan kegiatan sekolah perlu tersedia pada satu tempat dan disajikan sesuai peran pengguna. Tanpa portal terpusat, pengguna berpotensi kesulitan menemukan informasi belajar yang relevan dan guru/admin perlu mengelola informasi melalui saluran terpisah.

Konteks laporan menyebut SD Muhammadiyah Tamantirto di Geblagan, Tamantirto, Kasihan, Bantul, DI Yogyakarta, dengan data semester Genap 2024/2025: 183 siswa, 9 rombongan belajar, dan 11 ruang kelas. Angka tersebut adalah konteks laporan pada semester tersebut, bukan jumlah terkini yang telah diverifikasi.

## 3. Tujuan dan hasil yang diharapkan

1. Memusatkan akses informasi akademik dan pembelajaran.
2. Memudahkan guru mengelola materi, tugas, nilai, jadwal, pengumuman, dan kegiatan sekolah.
3. Memudahkan siswa menemukan jadwal, materi, tugas, nilai, pengumuman, dan kegiatan yang sesuai dengan kelasnya.
4. Membatasi tampilan dan tindakan berdasarkan peran pengguna.
5. Menyajikan pengalaman yang mudah digunakan pada perangkat yang disepakati, dengan keterbacaan yang sesuai bagi siswa sekolah dasar.

### Indikator keberhasilan

- Pengguna dapat masuk dan diarahkan ke beranda sesuai peran yang telah diberikan.
- Siswa dapat menemukan jadwal, materi, tugas, nilai, serta informasi sekolah.
- Guru dapat menemukan alur pengelolaan materi/tugas dan penilaian.
- Admin dapat mengelola akun dan informasi akademik setelah kewenangan serta alur kerja ditetapkan.
- Informasi yang ditampilkan untuk siswa sesuai dengan kelas dan akun siswa.

Target angka, misalnya tingkat keberhasilan tugas pengguna atau waktu penyelesaian, belum ditentukan dalam laporan dan perlu ditetapkan setelah uji coba dengan pengguna.

## 4. Pengguna dan kebutuhan

### Admin

- Mengelola data pengguna dan informasi akademik.
- Mengatur akses berdasarkan peran.
- Memastikan informasi yang dipublikasikan tepat dan tersedia bagi pengguna yang sesuai.

**Catatan:** Peran admin disebut dalam laporan, tetapi belum tersedia sebagai peran atau dashboard terpisah dalam prototipe.

### Guru

- Melihat jadwal mengajar dan kelas binaan.
- Mengelola atau membagikan materi dan tugas kepada kelas.
- Meninjau kiriman tugas siswa dan memberikan nilai/koreksi.
- Mengelola nilai serta menyampaikan pengumuman atau informasi kegiatan sesuai kewenangan.

### Siswa

- Melihat jadwal pelajaran sesuai kelas.
- Membuka materi pembelajaran dan informasi tugas.
- Mengirim jawaban tugas dan menyimpan draf bila alur tersebut disetujui.
- Melihat nilai milik sendiri.
- Membaca pengumuman dan kegiatan sekolah.

## 5. Cakupan produk

### Termasuk dalam cakupan

- Akun pengguna dan akses sesuai peran.
- Jadwal pelajaran dan jadwal mengajar.
- Materi pembelajaran.
- Tugas, pengumpulan jawaban, dan peninjauan tugas.
- Nilai.
- Pengumuman resmi dan informasi kegiatan sekolah.
- Dashboard/beranda yang menampilkan ringkasan relevan menurut peran.
- Antarmuka berbahasa Indonesia yang responsif dan mudah digunakan.

### Tidak termasuk dalam cakupan

Fitur berikut secara eksplisit tidak diminta dalam laporan yang tersedia:

- Pembayaran.
- Absensi.
- Chat atau pesan langsung.
- Rapor otomatis.
- Integrasi eksternal.

Penambahan cakupan tersebut memerlukan keputusan dan kebutuhan baru; jangan menganggapnya bagian dari MVP.

## 6. Kebutuhan fungsional

Prioritas: **P0** = dibutuhkan untuk MVP; **P1** = penting, dapat menyusul bila tidak menghambat alur utama.

| ID | Prioritas | Kebutuhan | Kriteria penerimaan ringkas |
|---|---|---|---|
| FR-01 | P0 | Sistem menyediakan autentikasi untuk pengguna yang berwenang. | Pengguna mengisi identitas dan kredensial; kredensial tidak valid menghasilkan pesan yang jelas; pengguna berhasil masuk hanya dengan akun sah. |
| FR-02 | P0 | Sistem menerapkan peran siswa, guru, dan admin. | Setelah masuk, pengguna melihat dashboard dan tindakan sesuai perannya; siswa tidak dapat melihat data siswa lain atau tindakan pengelolaan guru/admin. |
| FR-03 | P0 | Admin dapat mengelola akun pengguna dan informasi akademik. | Admin dapat membuat atau memperbarui data yang menjadi kewenangannya; rincian bidang data dan aturan perubahan ditetapkan bersama sekolah. |
| FR-04 | P0 | Siswa dapat melihat jadwal pelajaran menurut kelasnya. | Jadwal menampilkan sekurang-kurangnya hari, waktu, mata pelajaran, dan informasi kelas/ruang jika tersedia. |
| FR-05 | P0 | Guru dapat melihat jadwal mengajar dan kelas terkait. | Guru dapat membedakan sesi mengajar berdasarkan hari/waktu, kelas, dan mata pelajaran. |
| FR-06 | P0 | Guru dapat mengelola dan membagikan materi ke kelas. | Materi yang diterbitkan menampilkan judul, deskripsi/instruksi, mata pelajaran atau kelas, dan konten/berkas yang didukung oleh keputusan teknis. Siswa yang sesuai dapat membukanya. |
| FR-07 | P0 | Guru dapat membuat dan membagikan tugas. | Tugas memiliki judul, instruksi, kelas sasaran, dan tenggat bila ditentukan; siswa sasaran dapat melihat tugas tersebut. |
| FR-08 | P0 | Siswa dapat mengumpulkan jawaban tugas. | Siswa dapat melihat instruksi dan tenggat, mengirim jawaban melalui cara yang disepakati, serta menerima konfirmasi berhasil atau pesan kegagalan yang jelas. |
| FR-09 | P0 | Guru dapat meninjau kiriman dan memberikan nilai/koreksi. | Guru dapat membuka kiriman siswa, memasukkan hasil penilaian/koreksi, dan menyimpan perubahan; siswa hanya dapat melihat hasil miliknya. |
| FR-10 | P0 | Siswa dapat melihat nilai miliknya dan guru dapat mengelola nilai sesuai kewenangan. | Nilai terkait dengan siswa dan mata pelajaran/penilaian yang jelas; tidak ada akses siswa ke nilai pengguna lain. Aturan nilai/KKM perlu ditetapkan sekolah. |
| FR-11 | P0 | Pengguna dapat melihat pengumuman dan kegiatan sekolah. | Daftar informasi menampilkan judul dan detail penting; kategori yang dipakai mengikuti kebutuhan sekolah. |
| FR-12 | P1 | Beranda menampilkan ringkasan yang berguna sesuai peran. | Beranda siswa mengarahkan ke jadwal, tugas, materi, nilai, dan informasi; beranda guru menampilkan ringkasan kelas/tugas/jadwal; admin mendapat akses ke pengelolaan. |
| FR-13 | P1 | Pengguna dapat mencari atau menyaring informasi jika daftar cukup panjang. | Hasil pencarian/penyaringan sesuai dengan kata kunci atau kategori yang ditampilkan; pencarian kosong memiliki keadaan kosong yang informatif. |

### Alur utama

1. **Masuk:** pengguna memasukkan identitas dan kredensial, lalu diarahkan ke dashboard berdasarkan peran.
2. **Belajar siswa:** siswa membuka jadwal atau materi, membaca detail, melihat tugas, lalu mengirim jawaban bila diperlukan.
3. **Pengelolaan guru:** guru memilih kelas/mata pelajaran, mengunggah atau membagikan materi/tugas, meninjau kiriman, lalu menyimpan penilaian.
4. **Pengelolaan admin:** admin mengelola akun dan informasi akademik sesuai kewenangan yang ditetapkan sekolah.
5. **Informasi sekolah:** pengguna membuka pengumuman atau kegiatan yang tersedia baginya.

## 7. Kebutuhan nonfungsional

- **Bahasa:** antarmuka utama menggunakan Bahasa Indonesia.
- **Responsif:** tata letak dapat digunakan pada ukuran layar perangkat sasaran. Prioritas web responsif berasal dari laporan; dukungan platform dan browser final perlu divalidasi.
- **Kemudahan penggunaan:** navigasi dan label harus jelas; teks serta tindakan utama mudah ditemukan oleh siswa sekolah dasar maupun guru/admin.
- **Privasi dan akses:** data nilai dan data siswa hanya dapat diakses pihak yang berwenang. Persyaratan keamanan teknis, masa simpan, dan perlindungan data anak perlu ditetapkan sebelum rilis.
- **Keandalan data:** sistem membedakan data sebenarnya dengan data contoh/simulasi dan tidak menampilkan contoh sebagai informasi resmi.
- **Umpan balik:** setiap tindakan utama menyediakan konfirmasi keberhasilan atau kesalahan yang dapat dipahami pengguna.
- **Aksesibilitas:** kontras, ukuran teks, fokus, dan target sentuh perlu diuji pada perangkat sasaran.

Persyaratan kuantitatif untuk kinerja, ketersediaan, pencadangan, dan kapasitas belum dinyatakan dalam sumber; perlu ditetapkan bersama pemilik produk dan tim teknis.

## 8. Pemetaan prototipe saat ini dan kesenjangan

Prototipe Flutter saat ini memperlihatkan:

- Layar masuk dengan pemilihan peran siswa atau guru/staf.
- Dashboard dan navigasi untuk siswa dan guru.
- Contoh layar jadwal, materi, tugas, nilai, pengumuman/kegiatan.
- Contoh alur guru untuk unggah materi, pembuatan tugas, peninjauan kiriman, dan pengelolaan nilai.
- Contoh alur siswa untuk detail materi dan pengumpulan tugas.
- Penanda bahwa sejumlah konten adalah data simulasi/contoh.

Hal berikut **belum boleh dianggap sebagai kemampuan produksi** hanya berdasarkan UI yang ada:

- Autentikasi nyata: kode masuk saat ini meneruskan pengguna berdasarkan peran yang dipilih, bukan memverifikasi akun.
- Penyimpanan atau sinkronisasi data ke backend.
- Pembatasan akses yang ditegakkan oleh server.
- Proses unggah berkas, pengiriman tugas, penyimpanan nilai, dan penerbitan informasi yang persisten.
- Dashboard dan manajemen admin.
- Proses pemulihan kredensial dan pengelolaan akun.
- Kesesuaian data contoh dengan data sekolah terkini.

## 9. Rilis MVP dan urutan pengerjaan

### MVP

1. Menetapkan platform, peran, dan aturan akses bersama sekolah.
2. Mengimplementasikan autentikasi dan pemetaan akun ke kelas/peran.
3. Menyediakan informasi jadwal, materi, tugas, nilai, serta pengumuman/kegiatan.
4. Menyediakan alur guru untuk membagikan materi/tugas dan menilai kiriman.
5. Menyediakan alur admin untuk mengelola pengguna dan informasi akademik.
6. Menguji akses peran, privasi nilai, responsivitas, dan kemudahan penggunaan.

Urutan dapat berubah sesuai keputusan sekolah dan dependensi teknis. Data produksi tidak boleh dimasukkan sebelum hak akses dan perlindungan data disepakati.

## 10. Asumsi dan keputusan yang perlu divalidasi

1. Apakah produk akhir harus berupa web responsif, aplikasi Android/iOS, atau satu aplikasi Flutter yang menargetkan beberapa platform?
2. Apakah siswa menggunakan NISN dan PIN, sementara guru/staf menggunakan NIP/NBM dan kata sandi seperti yang dicontohkan di layar login? Siapa yang menerbitkan dan mengatur ulang kredensial?
3. Apa cakupan hak admin, dan siapa yang boleh menerbitkan pengumuman/kegiatan?
4. Bagaimana struktur kelas, mata pelajaran, tahun ajaran, semester, jadwal, dan kalender ditetapkan serta diperbarui?
5. Apakah pengumpulan tugas harus mendukung teks, berkas, audio, atau kombinasi? Apa batasan ukuran dan format berkas?
6. Bagaimana komponen nilai, KKM, koreksi, periode penilaian, dan publikasi nilai ditentukan? Angka KKM pada prototipe harus diverifikasi sebelum dipakai sebagai aturan.
7. Apakah pengguna mencakup orang tua/wali? Peran ini belum disebut dalam laporan yang tersedia.
8. Berapa target performa, ketersediaan, dukungan perangkat/browser, kebijakan pencadangan, dan kebutuhan retensi data?
9. Apakah data semester 2024/2025 pada laporan hanya data penelitian/prototipe atau akan dimigrasikan? Data harus diperbarui dan divalidasi sebelum penggunaan nyata.
10. Isi Bab II dan Bab III laporan metopen belum tersedia dalam sumber yang ditelaah; kebutuhan tambahan dari bab tersebut perlu dimasukkan setelah tersedia.

## 11. Referensi yang ditelaah

- `Metopen_UTS_Final_Stitch.md` — brief Google Stitch yang merangkum Bab I laporan metopen, peran, cakupan fitur, layar, arahan UI, dan batasan.
- `lib/main.dart` dan `lib/screens/` — prototipe Flutter yang menunjukkan navigasi dan contoh layar siswa/guru.
- `test/widget_test.dart` — uji widget yang memeriksa sebagian alur tampilan prototipe; bukan verifikasi layanan autentikasi atau backend produksi.
