import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kisiler/kisilerdao.dart';
import 'package:kisiler/main.dart';

class Kisi_Kaydet extends StatefulWidget {
  const Kisi_Kaydet({super.key});

  @override
  State<Kisi_Kaydet> createState() => _Kisi_KaydetState();
}

class _Kisi_KaydetState extends State<Kisi_Kaydet> {
  Future<void> kisi_kayit_et(String ders_ad, String akts , String hoca_ad,String ders_tarih) async {
    Kisilerdao().kisi_kayit_et(ders_ad, akts,hoca_ad,ders_tarih);
   
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnaEkran(),
        ));
  }

  var a = TextEditingController();
  var b = TextEditingController();
  var c= TextEditingController();
    var d= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişiler Kaydet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  style: TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                      hintText: "Isim Giriniz",
                      hintStyle: TextStyle(fontSize: 25)),
                  controller: a,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 25),
                  controller: b,
                  decoration: InputDecoration(
                      hintText: "Akts Giriniz",
                      hintStyle: TextStyle(fontSize: 25)),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(

                  style: TextStyle(fontSize: 25),
                  controller: c,
                  decoration: InputDecoration(
                      hintText: "Hoca ismi  Giriniz",
                      hintStyle: TextStyle(fontSize: 25)),
                ),
              ),
            ),
                  Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(

                  style: TextStyle(fontSize: 25),
                  controller: d,
                  decoration: InputDecoration(
                      hintText: "Ders Tarihi  Giriniz",
                      hintStyle: TextStyle(fontSize: 25)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        if(a.text=="" || b.text =="" ||c.text==""){
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
                        "Lütfen Alanları Doldurun",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )),
                  behavior: SnackBarBehavior.floating,
                ));
        }else{
            kisi_kayit_et(a.text, b.text,c.text,d.text);
        }
        },
        tooltip: 'Increment',
        label: Text("Kaydet"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
