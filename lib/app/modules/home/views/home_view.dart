// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/city_model.dart';

import '../province_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ProvinceDropdown(),
          Obx(
            () => controller.hiddenCity.isTrue
                ? SizedBox()
                : CityDropdown(provId: controller.provId.value),
          ),
        ],
      ),
    );
  }
}

// UI AREA CODE  ====
class ProvinceDropdown extends GetView<HomeController> {
  const ProvinceDropdown({super.key});

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
            labelText: "Pilih Provinsi",
            contentPadding: const EdgeInsets.all(15),
          ),
        ),
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (provinsi) => provinsi.name ?? "-",
        onChanged: (prov) {
          if (prov != null) {
            print(prov.name);
            controller.hiddenCity.value = false;
            controller.provId.value = int.parse(prov.id!);
          } else {
            print("Data provinsi tidak tersedia");
            controller.hiddenCity.value = true;
            controller.provId.value = 0;
          }
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

class CityDropdown extends StatelessWidget {
  const CityDropdown({super.key, required this.provId});

  final int provId;

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
            labelText: "Pilih Kota / Kabupaten",
            contentPadding: const EdgeInsets.all(15),
          ),
        ),
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (city) => city.name ?? "-",
        onChanged: (city) => {
          if (city != null)
            {print(city.name)}
          else
            {print("Data kota / Kabupaten tidak tersedia")},
        },
        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Ketikkan nama kota / Kabupaten anda",
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
