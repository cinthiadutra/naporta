// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naporta/view/page_detail.dart';

class NaPortaCard extends StatelessWidget {

  NaPortaCard({super.key, required this.title, required this.subTitle,});

  String title;
  String subTitle;
  


   @override
   Widget build(BuildContext context) {
       return Card(
        child: ListTile(
          title: Text(title) ,
          subtitle: Text(' Previsão de entrega  em $subTitle'),
          trailing: InkWell(child: const Icon(Icons.arrow_right), onTap: () => Get.to(()=>PageDetail(descricaoUlt: ' estou saindo de casa', descricaoInit: ' em rua tatatatatatatatatta',)),),
          
        ),
       );
  }
}