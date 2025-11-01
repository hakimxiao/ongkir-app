// =====================================================================================
// PART 1 :
// =====================================================================================

// // ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

// import 'dart:convert';

// import 'package:http/http.dart' as http;

// void main() async {
//   //  < *

//   // === Uri : data url untuk flutter | dia wajib di parse.
//   Uri url = Uri.parse("https://reqres.in/api/users/1");

//   final response = await http.get(
//     url,
//     headers: {"x-api-key": "reqres-free-v1"},
//   );

//   // === jika tidak menggunakan decode maka hasilnya string, jika hasilnya string maka kita tida bisa menggunakan key value ["key"]
//   final data = (json.decode(response.body) as Map<String, dynamic>)["data"];

//   print("Ini Data [key] : " + data);
//   print("Ini Data [key][value] : " + data["email"]);
//   print(
//     "Ini Data [key][value] : " + data["first_name"] + " " + data["last_name"],
//   );

//   // * > : Menggunakan cara ini untuk mengelolah data sungguh repot maka disinilah peran model, dimana kita menyimpan respon body nya kedalam model
// }

// =====================================================================================
// PART 2 :
// =====================================================================================

// // ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:ongkir/app/data/models/user_model.dart';

// void main() async {
//   Uri url = Uri.parse("https://reqres.in/api/users/1");

//   final response = await http.get(
//     url,
//     headers: {"x-api-key": "reqres-free-v1"},
//   );

//   // knp fromJSON ? :
//   //  digunakan karena kita ingin mengubah data JSON dari response menjadi objek UserModel,
//   //  agar lebih mudah digunakan di dalam kode.
//   final user = UserModel.fromJson(
//     json.decode(response.body) as Map<String, dynamic>,
//   );
//   /**
//         Kalau kita tidak pakai fromJson, maka datanya masih berupa map (peta data) dan kita harus menulis seperti ini
//         setiap kali ingin mengambil nilai:

//           data["first_name"]
//           data["last_name"]

//         Itu bisa merepotkan kalau datanya banyak.
//         Dengan fromJson, JSON tersebut diubah menjadi objek UserModel, sehingga kita bisa memanggil datanya dengan cara yang lebih rapi:

//           user.firstName
//           user.lastName
//     */

//   print("fromJSON : ");
//   print(user.data);
//   print(user.data);
//   print(user.data.email);
//   print(user.data.firstName + " " + user.data.lastName);
//   print(user.data.avatar);

//   // toJSON : Kebalikan : fromJSON * Biasa digunakan untuk simpan ke DB
//   final myJson = userModelToJson(user);

//   print("toJSON : ");
//   print(myJson);
// }

// =====================================================================================
// PART 3 : http
// =====================================================================================

// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

// import 'package:http/http.dart' as http;

// void main() async {
//   Uri url = Uri.parse("https://reqres.in/api/users/1");

//   final response = await http.post(
//     url,
//     body: {"name": "Hakim", "job": "Flutter Developer"},
//     headers: {"x-api-key": "reqres-free-v1"},
//   );

//   print(response.body);
// }

// =====================================================================================
// PART 8 : API RAJA ONGKIR
// =====================================================================================

import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;

void main() async {
  await dotenv.load(fileName: ".env");

  Uri url = Uri.parse(
    'https://rajaongkir.komerce.id/api/v1/calculate/district/domestic-cost',
  );

  final response = await http.post(
    url,
    headers: {
      "key": dotenv.env["RAJA_ONGKIR_SHIPPING_COST_API"].toString(),
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      "origin": "501",
      "destination": "114",
      "weight": "1700",
      "courier": "jne",
    },
  );

  print(response.body);
}
