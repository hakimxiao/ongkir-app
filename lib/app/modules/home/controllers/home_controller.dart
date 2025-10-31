// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var hiddenOriginCity = true.obs;
  var provOriginId = 0.obs;
  var originCityId = 0.obs;
  var hiddenDestinationCity = true.obs;
  var provDestianationId = 0.obs;
  var destinationCityId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  double beratBarang = 0.0;
  String satuan = 'Gram';

  late TextEditingController beratBarangC;

  void showButton() {
    if (originCityId != 0 &&
        destinationCityId != 0 &&
        beratBarang > 0 &&
        kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void handleBeratBarang(String value) {
    beratBarang = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;

    switch (cekSatuan) {
      case "Ton":
        beratBarang = beratBarang * 1000000; // 1 ton = 1.000.000 gram
        break;

      case "Kwintal":
        beratBarang = beratBarang * 100000; // 1 kwintal = 100.000 gram
        break;

      case "Ons":
        beratBarang = beratBarang * 100; // 1 ons = 100 gram
        break;

      case "Lbs":
        beratBarang = beratBarang * 453.592; // 1 lbs = 453,592 gram
        break;

      case "Pound":
        beratBarang = beratBarang * 453.592; // 1 pound = 453,592 gram
        break;

      case "Kg":
        beratBarang = beratBarang * 1000; // 1 kg = 1.000 gram
        break;

      case "Hg":
        beratBarang = beratBarang * 100; // 1 hg = 100 gram
        break;

      case "Dag":
        beratBarang = beratBarang * 10; // 1 dag = 10 gram
        break;

      case "Gram":
        beratBarang = beratBarang; // tetap gram
        break;

      case "Dg":
        beratBarang = beratBarang * 0.1; // 1 dg = 0,1 gram
        break;

      case "Cg":
        beratBarang = beratBarang * 0.01; // 1 cg = 0,01 gram
        break;

      case "Mg":
        beratBarang = beratBarang * 0.001; // 1 mg = 0,001 gram
        break;

      default:
        beratBarang = beratBarang;
        break;
    }

    print('$beratBarang Gram');
    showButton();
  }

  void handleSatuan(String value) {
    beratBarang = double.tryParse(beratBarangC.text) ?? 0.0;

    switch (value) {
      case "Ton":
        beratBarang = beratBarang * 1000000; // 1 ton = 1.000.000 gram
        break;

      case "Kwintal":
        beratBarang = beratBarang * 100000; // 1 kwintal = 100.000 gram
        break;

      case "Ons":
        beratBarang = beratBarang * 100; // 1 ons = 100 gram
        break;

      case "Lbs":
        beratBarang = beratBarang * 453.592; // 1 lbs = 453,592 gram
        break;

      case "Pound":
        beratBarang = beratBarang * 453.592; // 1 pound = 453,592 gram
        break;

      case "Kg":
        beratBarang = beratBarang * 1000; // 1 kg = 1.000 gram
        break;

      case "Hg":
        beratBarang = beratBarang * 100; // 1 hg = 100 gram
        break;

      case "Dag":
        beratBarang = beratBarang * 10; // 1 dag = 10 gram
        break;

      case "Gram":
        beratBarang = beratBarang; // tetap gram
        break;

      case "Dg":
        beratBarang = beratBarang * 0.1; // 1 dg = 0,1 gram
        break;

      case "Cg":
        beratBarang = beratBarang * 0.01; // 1 cg = 0,01 gram
        break;

      case "Mg":
        beratBarang = beratBarang * 0.001; // 1 mg = 0,001 gram
        break;

      default:
        beratBarang = beratBarang;
        break;
    }

    satuan = value;

    print('$beratBarang Gram');
    showButton();
  }

  @override
  void onInit() {
    beratBarangC = TextEditingController(text: beratBarang.toString());
    super.onInit();
  }

  @override
  void onClose() {
    beratBarangC.dispose();
    super.onClose();
  }
}
