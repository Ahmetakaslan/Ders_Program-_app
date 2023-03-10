import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kisiler/kisilerdao.dart';
import 'package:kisiler/kisilerdb.dart';
import 'package:kisiler/main.dart';

class KisiDetay extends StatefulWidget {
  Kisilerdb kisilerdb;
  KisiDetay(this.kisilerdb);


  @override
  State<KisiDetay> createState() => _KisiDetayState();
}

class _KisiDetayState extends State<KisiDetay> {
   
  Future<void> kisi_guncelle(
      int kisi_id, String kisi_ad, String kisi_tel ,String ders_hoca,String ders_tarih) async {
    Kisilerdao().kisi_Guncelle(kisi_id, kisi_ad, kisi_tel,ders_hoca,ders_tarih);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 1, microseconds: 50),
        behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: const EdgeInsets.only(left: 80,right: 80),
          child: Container(

            //EdgeInsets.only(left: size.width/12),
            // EdgeInsets.symmetric(horizontal:size.width/4, vertical: 5),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${kisi_ad} Kaydedildi",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
              
                color: Color(0xFFECF0F1 ), borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
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
  void initState() {
    // TODO: implement initState
    a.text = widget.kisilerdb.ders_ad;
    b.text = widget.kisilerdb.ders_akts;
    c.text=widget.kisilerdb.ders_hoca;
    d.text=widget.kisilerdb.ders_tarih;
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9A7D0A),
            title: Text("Derslerin ayrıntısı "),
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
                      hintText: "Hoca  adı giriniz",
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
                      hintText: "Ders  Tarihi giriniz",
                      hintStyle: TextStyle(fontSize: 25)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          kisi_guncelle(widget.kisilerdb.ders_id, a.text, b.text,c.text,d.text);
          print("Gucellendi");
        },
        tooltip: 'Increment',
        label: Text("Güncelle"),
        icon: const Icon(Icons.update),
      ),
    );
    ;
  }
}
