import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisiler/view/kisidetay_widget.dart';
import 'package:kisiler/view/kisikayitsayfasi_widget.dart';
import 'package:kisiler/viewmodel/kisilerdao.dart';
import 'package:kisiler/model/kisilerdb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  bool aramaYapiliyormu = false;
  String arama_kelimesi = "";
  Icon aramaIconu = Icon(Icons.search);

  Future<bool> uygulamayiKapat() async {
    return exit(0);
  }

  Future<List<Kisilerdb>> tumKisiler() async {
    late List<Kisilerdb> a;
    try {
      a = await Kisilerdao().tumKisiler();
    
    } catch (e) {
      print(e);
    }

    return a;
  }

  Future<List<Kisilerdb>> kisiAra(String text) async {
    var a = await Kisilerdao().kisiAra(text);
    return a;
  }

  Future<void> sil(int id) async {
    try {
      Kisilerdao().kisiSil(id);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> Eminmisin(int id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Text(
          "Kişi Silinsin mi?",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        content: Text("Bu kişi cihazınızdan  kalıcı olarak silinecek?"),
        actions: [
          TextButton(
            onPressed: () {
              sil(id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  duration: Duration(seconds: 1),
                  content: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Text(
                        "Silindi",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            },
            child: Text("Sil"),
          ),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.transparent,
                    duration: Duration(seconds: 1),
                    elevation: 0,
                    content: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        child: Text(
                          "İpatl edildi",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text("Iptal")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5D6D7E),
        /// kendi leadingine icon buton verererk basıldığında uygulamadan çıkış sağlanır
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => uygulamayiKapat(),
        ),
        title: aramaYapiliyormu
            ? TextFormField(
          style: TextStyle(color: Colors.white),
          autofocus: true,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    arama_kelimesi = value;
                  });
                  arama_kelimesi = value;
                },
              )
            : Text("Dersler"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  if (aramaYapiliyormu == true) {
                    setState(() {
                      aramaIconu = Icon(Icons.search);
                      aramaYapiliyormu = false;
                      // burada TextDielde deki yazıyı siliyor
                      arama_kelimesi = "";
                    });
                  } else {
                    setState(() {
                      aramaIconu = Icon(Icons.close);
                      aramaYapiliyormu = true;
                    });
                  }
                },
                icon: aramaIconu),
          )
        ],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFF7B7D7D),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Kisi_Kaydet(),
                ));
          },
          label: Text("Ekle"),
          icon: Icon(Icons.add)),
    );
  }

  WillPopScope Body() {
    return WillPopScope(
      onWillPop: () => uygulamayiKapat(),
      child: FutureBuilder(
        future: aramaYapiliyormu ? kisiAra(arama_kelimesi) : tumKisiler(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kisiler = snapshot.data;

            return ListView.builder(
              itemCount: kisiler!.length,
              itemBuilder: (context, index) {
                var sirlisekilekle = kisiler[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 55,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KisiDetay(sirlisekilekle),
                            )),
                        child: Card(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(width: 2)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "${sirlisekilekle.ders_ad}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "${sirlisekilekle.derslik}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text("${sirlisekilekle.ders_akts}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text("${sirlisekilekle.ders_hoca}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text("${sirlisekilekle.ders_tarih}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: IconButton(
                                      onPressed: () {
                                        Eminmisin(sirlisekilekle.ders_id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ),
                               
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Veri Yok"),
            );
          }
        },
      ),
    );
  }
}
