// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naporta/view/widget/naPorta_row.dart';

class PageDetail extends StatefulWidget {
  PageDetail({
    required this.descricaoUlt,
    required this.descricaoInit,
  });


  String descricaoUlt;
  String descricaoInit;

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedido C8C3CE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        toolbarHeight: 150,
        backgroundColor: Colors.orange[600],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(shrinkWrap: true, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                )),
          ),
          NaPortaRow(
              icon: Icons.car_rental,
              texto: 'Saindo em ${widget.descricaoInit}'),
          SizedBox(
            height: 40,
          ),
          VerticalDivider(
            width: 3,
            color: Colors.black,
            thickness: 3,
          ),
          NaPortaRow(icon:  Icons.pin, texto: widget.descricaoUlt),
          
        
           SizedBox(
            height: 40,
          ),
          Text('Pedido'),
          Text(
            'title',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
