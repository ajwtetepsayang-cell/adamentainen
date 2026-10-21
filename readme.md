# ADA PADEL Maintenance Hub — cara menjalankan dan mempublikasikan

Aplikasi web responsif berdasarkan file Excel **MENTAINEN PERIODE JULI-DESEMBER 2026**. Tampilan berisi Dashboard, Pekerjaan Aktual, Checklist Aset, Pengajuan Prioritas, Laporan Biaya, dan Pengaturan/Sinkronisasi.

## Isi paket
- `index.html` — aplikasi utama.
- `manifest.webmanifest`, `service-worker.js`, `icon.svg` — dukungan pemasangan seperti aplikasi (PWA) saat diakses lewat HTTPS.
- `supabase_schema.sql` — struktur database dan aturan akses.

## 1. Coba langsung
Buka `index.html` di browser. Mode lokal dapat mencatat pekerjaan, checklist, pengajuan, menandai pekerjaan selesai, ekspor CSV, dan backup JSON. Data lokal hanya ada di browser/perangkat yang dipakai.

## 2. Publikasikan agar punya alamat online
1. Ekstrak ZIP ke sebuah folder di komputer.
2. Buka [Netlify Drop](https://app.netlify.com/drop) atau layanan hosting statis lain. Unggah ZIP ini langsung, atau ekstrak lalu unggah folder berisi `index.html`, `manifest.webmanifest`, `service-worker.js`, dan `icon.svg`. Netlify menyebutkan bahwa deploy tanpa akun menghasilkan URL sementara; untuk mengelola dan memperbarui situs secara berkelanjutan, buat/claim situs dengan akun. [Panduan resmi](https://docs.netlify.com/start/quickstarts/netlify-drop-quickstart/).
3. Hosting akan memberikan URL HTTPS. Simpan URL tersebut untuk dibuka lewat HP atau komputer.
4. Publikasi statis membuat tampilan aplikasi online, tetapi data tidak otomatis menyatu antar perangkat sampai langkah database berikut dilakukan.

## 3. Aktifkan database bersama dan login
1. Buat proyek di Supabase.
2. Buka **SQL Editor** dan jalankan seluruh isi `supabase_schema.sql`.
3. Pada pengaturan Authentication, aktifkan Email/Password. Untuk uji coba tim kecil, tentukan apakah konfirmasi email diaktifkan. Buat akun untuk setiap petugas; sebaiknya pengaturan pendaftaran dibatasi sesuai kebijakan perusahaan setelah akun tim terbuat.
4. Di pengaturan API proyek, salin **Project URL** dan **anon/public key** (atau publishable key yang didukung proyek). Jangan menggunakan `service_role` key di browser.
5. Buka URL aplikasi yang sudah dipublikasikan → menu **Pengaturan & sinkron** → masukkan Project URL dan anon/public key → **Simpan konfigurasi** → login atau buat akun.
6. Pada login pertama ketika tabel kosong, data dasar dari Excel pada perangkat itu akan disalin ke database. Setelah sinkron, perangkat lain yang memakai proyek dan akun tim yang sama membaca tabel cloud yang sama. Perubahan disebarkan melalui Realtime.

### Catatan akses & penggunaan perusahaan
- Semua pengguna yang berhasil login pada proyek ini dapat membaca, mengubah, dan menghapus semua data maintenance di tabel tersebut. Buat akun hanya untuk staf yang berwenang dan matikan pendaftaran publik setelah akun tim tersedia.
- Untuk peluncuran operasional perusahaan, pertimbangkan membatasi akses berdasarkan peran, menyiapkan backup database, dan menunjuk administrator aplikasi.
- Bila ada data cloud sebelumnya, aplikasi memuat isi tabel cloud; data lokal perangkat tidak otomatis menimpa data yang telah ada. Ekspor backup sebelum migrasi.
- Jangan memasukkan rahasia perusahaan yang tidak diperlukan. Data awal mengikuti isi workbook yang diberikan.

## 4. Backup dan laporan
Menu **Pengaturan & sinkron** menyediakan ekspor JSON untuk backup, ekspor CSV daftar pekerjaan, impor backup JSON, dan cetak/simpan PDF lewat browser.

## Data awal dari workbook
- 24 pekerjaan aktual: 23 selesai, 1 dalam proses.
- 6 pengajuan prioritas (estimasi Rp 51.348.200).
- 54 aset dan 321 catatan historis checklist OK/NOK.
- Biaya aktual pekerjaan Rp 46.826.200.

Aplikasi ini menampilkan data seperti pada workbook; verifikasi kembali catatan dan status sebelum dipakai sebagai laporan operasional resmi.
