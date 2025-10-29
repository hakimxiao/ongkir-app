// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import 'package:ongkir/app/modules/home/city_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class CityDropdown extends GetView<HomeController> {
  const CityDropdown({super.key, required this.provId, required this.tipe});

  final int provId;
  final String tipe;

  Future<List<City>> _getCity() async {
    Uri url = Uri.parse(
      'https://rajaongkir.komerce.id/api/v1/destination/city/$provId',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          "key": dotenv.env["RAJA_ONGKIR_SHIPPING_COST_API"].toString(),
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var statusCode = data["meta"]["code"];
      if (statusCode != 200) throw data["meta"]["message"];

      var listOfCity = data["data"] as List<dynamic>;
      var models = City.fromJsonList(listOfCity);
      return models;
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: DropdownSearch<City>(
        items: (f, cs) async => await _getCity(),
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: tipe == "asal"
                ? "Pilih Kota / Kabupaten Asal"
                : "Pilih Kota / Kabupaten Tujuan",
            contentPadding: const EdgeInsets.all(15),
          ),
        ),
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (city) => city.name ?? "-",
        onChanged: (city) {
          if (city != null) {
            print(city.name);
            if (tipe == "asal") {
              controller.originCityId.value = city.id!;
            } else {
              controller.destinationCityId.value = city.id!;
            }
          } else {
            if (tipe == "asal") {
              print("Tidak memilih kota / kabupaten asal apapun");
            } else {
              print("Tidak memilih kota / kabupaten asal apapun");
            }
          }

          if (city != null) {
            print(city.name);
          } else {
            print("Tidak memilih kota / kabupaten asal apapun");
          }
        },
        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: tipe == "asal"
                  ? "Ketikkan nama kota / Kabupaten asal anda"
                  : "Ketikkan nama kota / Kabupaten tujuan anda",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(Icons.search),
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}
