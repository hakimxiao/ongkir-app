// ignore_for_file: avoid_print, deprecated_member_use, unrelated_type_equality_checks

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ongkir/app/modules/home/views/widgets/city_dropdown.dart';
import 'package:ongkir/app/modules/home/views/widgets/province_dropdown.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat_barang.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: OutlineInputBorder(),
        title: const Text('Ongkos Kirim .ID'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ProvinceDropdown(tipe: "asal"),
          Obx(
            () => controller.hiddenOriginCity.isTrue
                ? SizedBox()
                : CityDropdown(
                    provId: controller.provOriginId.value,
                    tipe: "asal",
                  ),
          ),
          ProvinceDropdown(tipe: "tujuan"),
          Obx(
            () => controller.hiddenDestinationCity.isTrue
                ? SizedBox()
                : CityDropdown(
                    provId: controller.provDestianationId.value,
                    tipe: "tujuan",
                  ),
          ),
          BeratBarang(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: DropdownSearch<Map<String, String>>(
              items: (f, cs) => [
                {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                {"code": "sicepat", "name": "SiCepat Ekspres"},
                {"code": "ide", "name": "ID Express"},
                {"code": "sap", "name": "SAP Express"},
                {"code": "jnt", "name": "J&T Express"},
                {"code": "ninja", "name": "Ninja Xpress"},
                {"code": "tiki", "name": "Citra Van Titipan Kilat (TIKI)"},
                {"code": "lion", "name": "Lion Parcel"},
                {"code": "anteraja", "name": "Anteraja"},
                {"code": "pos", "name": "POS Indonesia"},
                {"code": "ncs", "name": "Nusantara Card Semesta (NCS)"},
                {"code": "rex", "name": "Royal Express Indonesia (REX)"},
                {"code": "rpx", "name": "RPX Holding"},
                {"code": "sentral", "name": "Sentral Cargo"},
                {"code": "star", "name": "Star Cargo"},
                {"code": "wahana", "name": "Wahana Prestasi Logistik"},
                {"code": "dse", "name": "21 Express (DSE)"},
              ],
              itemAsString: (item) => item["name"] ?? "-",
              compareFn: (item1, item2) => item1["code"] == item2["code"],
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Kurir Pengiriman",
                ),
              ),
              popupProps: PopupProps.menu(),
              onChanged: (value) {
                if (value != null) {
                  controller.kurir.value = value["code"]!;
                  controller.showButton();
                } else {
                  controller.hiddenButton.value = true;
                  controller.kurir.value = "";
                }
              },
            ),
          ),
          Obx(
            () => controller.hiddenButton.isTrue
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text("Cek Ongkos Kirim"),
                  ),
          ),
        ],
      ),
    );
  }
}
