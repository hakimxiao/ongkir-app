
````markdown
# 📘 Materi 1 – Mengambil dan Mengonversi Data JSON ke Model di Flutter

## 🧩 Tujuan Pembelajaran
Pada materi ini, kita belajar bagaimana cara:
1. Mengambil data dari API menggunakan package `http`.
2. Mengubah data JSON hasil response menjadi model Dart agar mudah digunakan.
3. Menggunakan tool **Quicktype.io** untuk membuat model otomatis dari data JSON.

---

## ⚙️ Tools yang Digunakan
- **Flutter SDK**
- **Package `http`**
- **Quicktype.io** → digunakan untuk mengonversi data JSON menjadi model Dart secara otomatis.
- **Package `flutter_dotenv`** → digunakan untuk menyimpan API key agar tidak langsung ditulis di kode.

---

## 🌐 Langkah-Langkah

### 1️⃣ Instalasi Dependency
Tambahkan dependency berikut pada file `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  flutter_dotenv: ^5.1.0
````

Lalu jalankan perintah:

```bash
flutter pub get
```

---

### 2️⃣ Buat File `.env`

Buat file baru di root proyek (sejajar dengan `pubspec.yaml`):

```
RAJA_ONGKIR_SHIPPING_COST_API=isi_api_key_kamu_disini
```

---

### 3️⃣ Pastikan File `.env` Tidak Diupload ke GitHub

Tambahkan `.env` ke `.gitignore` agar tidak ikut terupload:

```
# Environment
.env
```

---

### 4️⃣ Gunakan dotenv di Flutter

#### Contoh File: `main.dart`

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // Pastikan dotenv diload sebelum runApp
  await dotenv.load(fileName: ".env");

  Uri url = Uri.parse(
    'https://rajaongkir.komerce.id/api/v1/destination/province',
  );

  final response = await http.get(
    url,
    headers: {"key": dotenv.env["RAJA_ONGKIR_SHIPPING_COST_API"].toString()},
  );

  print(response.body);
}
```

> 💡 **Catatan:**
> `dotenv.load()` hanya perlu dipanggil **sekali saja**, biasanya di `main.dart`.
> Jika kamu ingin mengakses variabel env di file lain (misalnya `modules`, `pages`, atau `views`), cukup import:
>
> ```dart
> import 'package:flutter_dotenv/flutter_dotenv.dart';
> ```
>
> lalu gunakan:
>
> ```dart
> dotenv.env['NAMA_VARIABLE']
> ```

---

### 5️⃣ Struktur Folder Project

```
ONGKIR/
├─ android/
├─ assets/
├─ ios/
├─ lib/
│  ├─ main.dart
│  ├─ pages/
│  └─ modules/
├─ test/
│  └─ widget_test.dart
├─ .env
├─ pubspec.yaml
└─ README.md
```

---

### 6️⃣ Troubleshooting

Jika muncul error seperti ini saat testing:

```
Failed to load ".env": Instance of 'FileNotFoundError'
```

🔍 **Solusi:**

* Pastikan file `.env` ada di root project, **bukan di folder `lib/` atau `test/`**.
* Gunakan path relatif `"./.env"` bila perlu:

  ```dart
  await dotenv.load(fileName: "./.env");
  ```

---

### ✅ Hasil Akhir

Program berhasil mengambil data dari API menggunakan key di `.env` dan menampilkan hasil JSON ke console.

---

### 📚 Sumber Tambahan

* [Flutter HTTP Documentation](https://pub.dev/packages/http)
* [Flutter Dotenv Documentation](https://pub.dev/packages/flutter_dotenv)
* [Quicktype.io JSON to Dart](https://app.quicktype.io/)

