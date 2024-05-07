// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naporta/model/pedido.dart';
import 'package:naporta/view/page_detail.dart';
import 'package:naporta/view/widget/naPorta_appBar.dart';
import 'package:naporta/view/widget/naPorta_card.dart';
import 'package:naporta/viewModel/naPorta_viewModel.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController numberPedidoController = TextEditingController();
  TextEditingController destinoController = TextEditingController();

  TextEditingController descricaoController = TextEditingController();
  TextEditingController nomeController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final NaPortaViewModel controller = Get.put(NaPortaViewModel());
    return Scaffold(
        appBar: NaPortaAppBar(onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Adicione o pedido'),
                  content: Form(
                    child: Column(children: [
                      TextFormField(
                        controller: numberPedidoController,
                        decoration:
                            const InputDecoration(hintText: "Numero do pedido"),
                        validator: Validatorless.required('Coloque seu codigo'),
                        maxLength: 6,
                      ),
                      TextFormField(
                          controller: destinoController,
                          decoration: const InputDecoration(
                              hintText: "Endereço destino"),
                          validator:
                              Validatorless.required('Coloque seu endereço')),
                      TextFormField(
                        controller: nomeController,
                        decoration:
                            const InputDecoration(hintText: "Digite seu Nome"),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration:
                            const InputDecoration(hintText: "seu email"),
                      ),
                      TextFormField(
                        controller: telefonController,
                        decoration:
                            const InputDecoration(hintText: "seu celular"),
                        maxLength: 11,
                      ),
                    ]),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Salvar'),
                      onPressed: () async {
                        String numberPedido = numberPedidoController.text;
                        var enderecoFinal = destinoController.text;
                        controller.destinationAddress = destinoController.text;

                        if (numberPedido.isNotEmpty) {
                          controller.destinationAddress = enderecoFinal;

                          await controller.addUser(PedidoModel(
                              id: Random().nextInt(100),
                              pedido: numberPedido,
                              status: DateTime.now().toString(),
                              destinoFinal: enderecoFinal.toLowerCase(),
                              nome: nomeController.text
                                  .toLowerCase()
                                  .capitalizeFirst,
                              email: emailController.text.toLowerCase(),
                              celular: telefonController.text));
                          Navigator.pop(context);
                          numberPedidoController.clear();
                          emailController.clear();
                          telefonController.clear();
                          nomeController.clear();
                          destinoController.clear();
                        } else {
                          Get.snackbar("Error", "Erro ao salvar");
                        }
                      },
                    )
                  ],
                );
              });
        }),
        body: Obx(() => Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Text(
                      'Pedidos',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.pedidos.length,
                        itemBuilder: (context, index) {
                          final order = controller.pedidos[index];
                          return Dismissible(
                            key: UniqueKey(),
                            background: const Card(color: Colors.red),
                            onDismissed: ((direction) =>
                                controller.deleteUser(order.id)),
                            child: InkWell(
                              child: NaPortaCard(
                                title: order.pedido.toUpperCase(),
                                subTitle: order.status.substring(0, 10),
                              ),
                              onTap: () {
                                controller.addMarkersAndRoute(
                                    order.destinoFinal ?? 'avenida brasil');
                                //controller.goToMapScreen(index, order.destinoFinal??'rua londres');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PageDetail(
                                          descricaoUlt:
                                              ' Chegando em ${order.destinoFinal}',
                                          index: index,
                                          pedidos: order,
                                          origin: controller.origin.value ??
                                              LatLng(controller.origemLat,
                                                  controller.origemLong),
                                          destination:
                                              controller.destination.value ??
                                                  LatLng(controller.origemLat,
                                                      controller.origemLong),
                                        )));
                              },
                            ),
                          );
                        })
                  ]),
            )));
  }
}
