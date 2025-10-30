// ignore_for_file: avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.beratBarangC,
            autocorrect: false,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Berat Barang",
              hintText: "Berat barang",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => controller.handleBeratBarang(value),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 150,
          height: 50,
          child: DropdownSearch<String>(
            items: (f, cs) => [
              "Ton",
              'Kwintal',
              'Ons',
              'Lbs',
              'Pound',
              'Kg',
              'Hg',
              'Dag',
              'Gram',
              'Dg',
              'Cg',
              'Mg',
            ],
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Satuan",
              ),
            ),
            popupProps: PopupProps.bottomSheet(
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari satuan berat",
                  border: OutlineInputBorder(),
                ),
              ),
              showSelectedItems: true,
              showSearchBox: true,
            ),
            onChanged: (value) => controller.handleSatuan(value!),
          ),
        ),
      ],
    );
  }
}
