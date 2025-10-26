// ignore_for_file: avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          DropdownSearch<String>(
            items: (f, cs) => ["Sumbar", 'Jabar', 'Sumsel', 'Bali'],
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Pilih provinsi asal : ',
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.menu(
              disabledItemFn: (item) => item == 'Sumsel',
              fit: FlexFit.loose,
              constraints: BoxConstraints(),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                padding: EdgeInsets.all(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
