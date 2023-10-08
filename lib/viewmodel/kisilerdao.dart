import 'package:kisiler/viewmodel/VeriTabanYardimcisi.dart';
import 'package:kisiler/model/kisilerdb.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Kisilerdao {
  Future<List<Kisilerdb>> tumKisiler() async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
 
    List<Map<String, dynamic>> listem =
        await db.rawQuery("Select * from dersler");
    print(listem.length);
    return List.generate(listem.length, (index) {
      var sirali = listem[index];
      var kisi_id = sirali["ders_id"];
      var kisi_ad = sirali["ders_ad"];
      var kisi_tel = sirali["ders_akts"];
      var ders_hoca = sirali["ders_hoca"];
      var ders_tarih = sirali["ders_tarih"];
      var derslik=sirali["derslik"];

      return Kisilerdb(kisi_id, kisi_ad, kisi_tel, ders_hoca, ders_tarih,derslik);
    });
    
  }

  Future<void> kisiSil(int id) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    try {
      db.delete("dersler", where: "ders_id=?", whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> kisi_kayit_et(String ders_ad, String ders_akts, String ders_hoca,
      String ders_tarih,String derslik) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();

    try {
      var mapim = Map<String, dynamic>();
      mapim["ders_ad"] = ders_ad;
      mapim["ders_akts"] = ders_akts;
      mapim["ders_hoca"] = ders_hoca;
      mapim["ders_tarih"] = ders_tarih;
      mapim["derslik"]=derslik;
      db.insert("dersler", mapim);
    } catch (e) {
      print("Kisi kayıt et Kısmı " + e.toString());
    }
  }

  Future<void> kisi_Guncelle(int kisi_id, String kisi_ad, String kisi_tel,
      String ders_hoca, String ders_tarih,String derslik) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    try {
      var mapim = await Map<String, dynamic>();
      mapim["ders_id"] = kisi_id;
      mapim["ders_ad"] = kisi_ad;
      mapim["ders_akts"] = kisi_tel;
      mapim["ders_hoca"] = ders_hoca;
      mapim["ders_tarih"] = ders_tarih;
      mapim["derslik"]=derslik;
      db.update("dersler", mapim, where: "ders_id=?", whereArgs: [kisi_id]);
    } catch (e) {
      print("kisi_guncelle kısmında " + e.toString());
    }
  }

  Future<List<Kisilerdb>> kisiAra(String kisi_ad) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    late List<Map<String, dynamic>> listem;
    try {
      listem = await db.rawQuery(
          "Select * from dersler where ders_ad like '%${kisi_ad}%' or  ders_akts like '%${kisi_ad}%' or ders_tarih like '%${kisi_ad}%' or ders_hoca like '%${kisi_ad}%'");
    } catch (e) {
//SELECT * FROM kisiler WHERE kisi_ad LIKE '%$kisi_ad%'
      print("kisi ara kısmında" + e.toString());
    }
    print(listem.length);
    return List.generate(listem.length, (index) {
      var sirali = listem[index];
      var kisi_id = sirali["ders_id"];
      var kisi_ad = sirali["ders_ad"];
      var kisi_tel = sirali["ders_akts"];
      var ders_hoca = sirali["ders_hoca"];
      var ders_tarih = sirali["ders_tarih"];
      var derslik =sirali["derslik"];

      return Kisilerdb(kisi_id, kisi_ad, kisi_tel, ders_hoca, ders_tarih,derslik);
    });
  }
}
