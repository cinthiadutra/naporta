import 'package:flutter/material.dart';
import 'package:naporta/view/widget/naPorta_appBar.dart';
import 'package:naporta/view/widget/naPorta_card.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: NaPortaAppBar(),
           body: Padding(
             padding: const EdgeInsets.all(20.0),
             child: ListView(
              children: [
                const Text('Pedidos', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
               NaPortaCard(title: 'C8C3CE', subTitle: 'C8C3CE'),
               NaPortaCard(title: 'C8C3CE', subTitle: ''),
               NaPortaCard(title: 'C8C3CE', subTitle: ''),
               NaPortaCard(title: 'C8C3CE', subTitle: ''),
               NaPortaCard(title: 'C8C3CE', subTitle: ''),

              ],
             ),
           ),
       );
  }
}