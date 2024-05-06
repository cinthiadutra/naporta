// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naporta/model/pedido.dart';
import 'package:naporta/view/widget/naPorta_row.dart';
import 'package:naporta/viewModel/naPorta_viewModel.dart';

class PageDetail extends StatelessWidget {
  PageDetail({super.key, 
    required this.descricaoUlt,
    required this.descricaoInit,
    

required this.index, this.pedidos,  });


  String descricaoUlt;
  Rx<String> descricaoInit = ''.obs;
  int index;
  final PedidoModel? pedidos;

 final NaPortaViewModel controller = Get.put(NaPortaViewModel());
 


  @override
  Widget build(BuildContext context) {
    descricaoInit.value = controller.latitudeFinalController.text;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Pedido ${pedidos?.pedido.toUpperCase()??'C4E2T4'}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        toolbarHeight: 150,
        backgroundColor: Colors.orange[600],
      ),
      body: Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(shrinkWrap: true, children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: GoogleMap(
                    markers: controller.markers.obs,
                    polylines: controller.polylines.obs,
                                  onMapCreated: controller.onMapCreated,
                                  initialCameraPosition: const CameraPosition(
                                    target: LatLng(-22.8527559, -43.2682783),
                                    zoom: 13.0,
                                    
                                  ))),
                
                const SizedBox(height: 20,),
                NaPortaRow(
                    icon: Icons.directions_car,
                    texto: ' Saindo em ${controller.startAddressController}\n ${pedidos?.status??''} '),
                const SizedBox(
                  height: 40,
                ),
                const VerticalDivider(
                  width:5,
                  thickness: 4,
                  color: Colors.red,
                ),
                NaPortaRow(icon:  Icons.flag_sharp, texto:'Chegando em ${descricaoInit}\n ${pedidos?.status??''}'),
          
        
           const SizedBox(
            height: 40,
          ),
          const Text('Pedido',style: TextStyle(color: Colors.grey),),
           Text(
           pedidos?.pedido.toUpperCase()??"C4E2T4",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
            const Text('Cliente', style: TextStyle(color: Colors.grey),),
            const SizedBox(
            height: 10,
          ),
           Text(
           pedidos?.nome??"",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Text(
           pedidos?.email??"",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Text(
  "+55 ${pedidos?.celular??""}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ]),
      ),
    ));
  }
}