// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../province_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            items: (f, cs) async {
              Uri url = Uri.parse(
                'https://rajaongkir.komerce.id/api/v1/destination/province',
              );

              try {
                final response = await http.get(
                  url,
                  headers: {
                    "key": dotenv.env["RAJA_ONGKIR_SHIPPING_COST_API"]
                        .toString(),
                  },
                );

                var data = json.decode(response.body) as Map<String, dynamic>;

                var statusCode = data["meta"]["code"];
                if (statusCode != 200) {
                  throw data["meta"]["message"];
                }

                var listOfProvince = data["data"] as List<dynamic>;
                var models = Province.fromJsonList(listOfProvince);

                return models;
              } catch (err) {
                debugPrint(err.toString());
                return List.empty();
              }
            },
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Pilih Provinsi",
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            compareFn: (a, b) => a.id == b.id,
            itemAsString: (provinsi) => provinsi.name ?? "-",
            onChanged: (value) => print(value!.name),
            popupProps: PopupPropsMultiSelection.menu(
              itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
                title: Text(
                  item.name ?? "-",
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                leading: Icon(
                  Icons.flag,
                  color: isSelected ? Colors.blue : Colors.grey,
                ),
                tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
              ),
              fit: FlexFit.loose,
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
              suggestedItemProps: SuggestedItemProps(showSuggestedItems: true),
            ),
          ),
        ],
      ),
    );
  }
}
