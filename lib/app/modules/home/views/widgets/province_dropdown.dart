// ignore_for_file: avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:ongkir/app/modules/home/province_model.dart';

class ProvinceDropdown extends GetView<HomeController> {
  const ProvinceDropdown({super.key, required this.tipe});

  final String tipe;

  Future<List<Province>> _getProvinces() async {
    Uri url = Uri.parse(
      'https://rajaongkir.komerce.id/api/v1/destination/province',
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

      var listOfProvince = data["data"] as List<dynamic>;
      var models = Province.fromJsonList(listOfProvince);

      return models;
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        items: (f, cs) async => await _getProvinces(),
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
            contentPadding: const EdgeInsets.all(15),
          ),
        ),
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (provinsi) => provinsi.name ?? "-",
        onChanged: (prov) {
          if (prov != null) {
            print(prov.name);
            if (tipe == "asal") {
              controller.hiddenOriginCity.value = false;
              controller.provOriginId.value = int.parse(prov.id!);
            } else {
              controller.hiddenDestinationCity.value = false;
              controller.provDestianationId.value = int.parse(prov.id!);
            }
          } else {
            if (tipe == "asal") {
              controller.hiddenOriginCity.value = false;
              controller.provOriginId.value = 0;
            } else {
              controller.hiddenDestinationCity.value = false;
              controller.provDestianationId.value = 0;
            }
          }
          controller.showButton();
        },
        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Ketikkan nama provinsi anda",
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
