
// ignore_for_file: file_names, must_be_immutable


import 'package:flutter/material.dart';

class NaPortaAppBar extends AppBar {

VoidCallback onTap;
  
  NaPortaAppBar({required this.onTap,super.key}):super(toolbarHeight: 200, backgroundColor: Colors.orange[600],
  title: Row( 
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset('assets/images/logo.png',scale: 5,),
      ElevatedButton(onPressed: onTap
      , style: const ButtonStyle(
        backgroundColor:  MaterialStatePropertyAll(Colors.white), 
      ), child: const Text('Novo Pedido', style: TextStyle(color: Colors.black),),)
    ],
  ));
  
}