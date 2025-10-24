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

---

## 🌐 Langkah-Langkah

### 1️⃣ Ambil Data dari API

Kita menggunakan API publik dari [ReqRes](https://reqres.in/) untuk mendapatkan data user.

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // URL endpoint API
  Uri url = Uri.parse("https://reqres.in/api/users/1");

  // Lakukan request GET ke server
  final response = await http.get(url);

  // Decode hasil response dari JSON ke Map
  final data = UserModel.fromJson(json.decode(response.body) as Map<String, dynamic>)["data"];

  print(data);
}
