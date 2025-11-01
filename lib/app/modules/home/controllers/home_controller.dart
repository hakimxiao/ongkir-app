// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/home/kurir_model.dart';

class HomeController extends GetxController {
  var hiddenOriginCity = true.obs;
  var provOriginId = 0.obs;
  var originCityId = 0.obs;
  var hiddenDestinationCity = true.obs;
  var provDestianationId = 0.obs;
  var destinationCityId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;
  var kurirName = "".obs;

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

  void ongkosKirim() async {
    await dotenv.load(fileName: ".env");

    Uri url = Uri.parse(
      'https://rajaongkir.komerce.id/api/v1/calculate/district/domestic-cost',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          "key": dotenv.env["RAJA_ONGKIR_SHIPPING_COST_API"].toString(),
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "origin": "$originCityId",
          "destination": "$destinationCityId",
          "weight": "$beratBarang",
          "courier": "$kurir",
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var result = data["data"] as List<dynamic>;

      var listOfCostKurir = Kurir.fromJsonList(result);

      print(
        listOfCostKurir[0],
      ); // datanya banyak tapi kita print disini yang pertama aja

      Get.defaultDialog(
        title: "${kurir.toUpperCase()} - $kurirName",
        titleStyle: TextStyle(fontSize: 25, color: Colors.grey[700]),
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: listOfCostKurir.map((kurir) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kiri: service + description + cost
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kurir.service,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                kurir.description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                NumberFormat.currency(
                                  locale: "id_ID",
                                  symbol: "Rp ",
                                  decimalDigits: 0,
                                ).format(kurir.cost),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Kanan: ETD
                        Text(
                          kurir.etd.toString().replaceAll("day", "Hari"),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    } catch (err) {
      print(err);
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: "$err");
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
