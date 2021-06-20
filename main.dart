import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(loading_root_page());
}

class loading_root_page extends StatelessWidget{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Bağlantını Kontrol Et"),);
          }else if(snapshot.hasData){
            return loading_root_pageSt();
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      debugShowCheckedModeBanner: true,
    );

  }
}

class loading_root_pageSt extends StatefulWidget{
  @override
  _loading_root_pageStState createState() => _loading_root_pageStState();
}

class _loading_root_pageStState extends State<loading_root_pageSt>{



  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  urunEkle(){
    FirebaseFirestore.instance
        .collection("urunler")
        .doc(t3.text)
        .set({
      'urunbaslik' : t3.text,'urunaciklama': t4.text
    }).whenComplete(() => print("Ürün Eklendi"));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Başlık",
                ),
                controller: t3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Açıklama",
                ),
                controller: t4,
              ),
              TextButton(
                child: Text("Kayıt Yap"),
                onPressed: (){
                  urunEkle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}