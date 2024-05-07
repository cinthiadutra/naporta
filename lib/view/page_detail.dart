// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naporta/model/pedido.dart';
import 'package:naporta/view/widget/naPorta_row.dart';
import 'package:naporta/viewModel/naPorta_viewModel.dart';

class PageDetail extends StatefulWidget {
  PageDetail({
    super.key,
    required this.descricaoUlt,
    required this.index,
    this.pedidos, required this.origin, required this.destination,
  });

  String descricaoUlt;
  int index;
  final PedidoModel? pedidos;
  final LatLng origin;
  final LatLng destination;

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
final _mapController = Completer<GoogleMapController>();

  //Defina a posição inicial da câmera quando o mapa carregar
  final _initialPosition = const CameraPosition(
    target: LatLng(-23.6821604, -46.8754942),
    zoom: 10,
  );

  final NaPortaViewModel controller = Get.put(NaPortaViewModel());

  @override
  Widget build(BuildContext context) {
    widget.descricaoUlt = controller.destinationAddress;
    return Scaffold(
        appBar: AppBar( foregroundColor: Colors.white,
          title: Text(
            'Pedido ${widget.pedidos?.pedido.toUpperCase() ?? 'C4E2T4'}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          toolbarHeight: 150,
          backgroundColor: Colors.orange[600],
        ),
        body: ListView(shrinkWrap: true, children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: controller.markers.obs,
                    onMapCreated: (controller) {
          _mapController.complete(controller);
        },

                    initialCameraPosition: _initialPosition
                      
                    )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NaPortaRow(
                  icon: Icons.directions_car,
                  texto:
                      ' Saindo em ${controller.startAddressController}\n ${widget.pedidos?.status ?? ''} '),
            ),
            const SizedBox(
              height: 40,
            ),
            const VerticalDivider(
              width: 5,
              thickness: 4,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NaPortaRow(
                  icon: Icons.flag_sharp,
                  texto:
                      'Chegando em ${widget.pedidos?.destinoFinal}\n ${widget.pedidos?.status ?? ''}'),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pedido',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.pedidos?.pedido.toUpperCase() ?? "C4E2T4",
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              
              child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const Text(
                    'Cliente',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.pedidos?.nome ?? "",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    widget.pedidos?.email ?? "",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "+55 ${widget.pedidos?.celular ?? ""}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ]),
        );
  }

}
