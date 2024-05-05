import 'package:flutter/material.dart';

class NaPortaRow extends StatelessWidget {

    NaPortaRow({required this.icon, required this.texto,});


  IconData icon;
  String texto;
  


   @override
   Widget build(BuildContext context) {
       return Row(children: [
                   Container(height: 50, width: 50,decoration: const BoxDecoration(color: Colors.orange,
                     borderRadius: BorderRadius.all(Radius.circular(6))
             
                   ),child:  Icon(icon, color: Colors.white,)),
                   Text(texto )
                 ]);
  }
}