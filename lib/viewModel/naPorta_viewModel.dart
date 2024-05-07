// ignore_for_file: file_names, unnecessary_null_comparison, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naporta/data/db_naPorta.dart';
import 'package:naporta/model/pedido.dart';
import 'package:naporta/view/page_detail.dart';

class NaPortaViewModel extends GetxController { 
 late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  String startAddressController = "Rua joao rego 265";
  String destinationAddress = "Destination Address";
  DbNaporta _service = DbNaporta();
  var pedidos = <PedidoModel>[].obs;
  double origemLat = -22.8527559;
  double origemLong = -43.2682783;
  TextEditingController destinationController =
              TextEditingController();
Rx<LatLng?> destination = Rx<LatLng?>(null);
Rx<LatLng?> origin = Rx<LatLng?>(const LatLng(-22.8527559, -43.2682783));

  @override
  void onInit() {
    super.onInit();
       loadOrders();

  }
 void clearDestination() {
    destinationController.clear();
    destination.value = null;
  }

  Future<void> goToMapScreen(int i, String destFim) async {
    List<Location> destinationResults =
        await locationFromAddress(destinationAddress);
    if (destinationResults != null) {
      Get.to(() => PageDetail(origin: origin.value!, destination: destination.value!, descricaoUlt: destFim, index: i,));
    } else {
      Get.snackbar(
        'Erro',
        'Por favor, insira um destino válido.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    
  }
  

   addMarkersAndRoute(String destino) async {
  
    List<Location> destinationResults =
  await locationFromAddress(destino);

    LatLng startLatLng = LatLng(origemLat, origemLong);
    LatLng destinationLatLng =
        LatLng(destinationResults[0].latitude, destinationResults[0].longitude);

    markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: startLatLng,
        infoWindow: const InfoWindow(title: 'Start'),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: destinationLatLng,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );

    polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [startLatLng, destinationLatLng],
        color: Colors.blue,
        width: 5,
      ),
    );

    // Atualiza a visualização do mapa
    update();
    
  }

  void drawRoute() {
    // Para manter os endereços fixos, você pode optar por não fazer nada aqui
    // ou limpar os campos de texto, dependendo dos requisitos do seu aplicativo.
    // startAddressController.clear();
    // destinationAddressController.clear();
  
  }
   Future<void> loadOrders() async {
    final results = await _service.getPedidos();
    pedidos.assignAll(
     results
    );}
  

  Future<void> addOrder(PedidoModel order) async {
    await _service.addPedido( PedidoModel(id: Random().nextInt(100), pedido: order.pedido, status: DateTime.now().toLocal().toString(),
    destinoFinal: order.destinoFinal?.toLowerCase(), nome: order.nome?.toUpperCase().capitalizeFirst, email: order.email?.toLowerCase(), celular: order.celular));
    

    pedidos.assignAll(pedidos);
  }


  Future<void> fetchUsers() async {
    pedidos.value = await _service.getPedidos();
  }

  Future<int> addUser(PedidoModel pedido) async {
    int result = await _service.addPedido(pedido);
    if (result > 0) {
      // Reload the users list after adding a new user
      await fetchUsers();
    }
    return result;
  }


  Future<int> updateUser(PedidoModel pedido) async {
    int result = await _service.updateUser(pedido);
    return result;
  }

  Future<int> deleteUser(int id) async {
    int result = await _service.deleteUser(id);
    return result;
  }
}
