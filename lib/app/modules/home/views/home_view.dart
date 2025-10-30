// ignore_for_file: avoid_print, deprecated_member_use

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
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
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
        ],
      ),
    );
  }
}
