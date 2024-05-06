// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naporta/model/pedido.dart';
import 'package:naporta/view/page_detail.dart';
import 'package:naporta/view/widget/naPorta_appBar.dart';
import 'package:naporta/view/widget/naPorta_card.dart';
import 'package:naporta/viewModel/naPorta_viewModel.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NaPortaViewModel controller = Get.put(NaPortaViewModel());
    return Scaffold(
      
      appBar: NaPortaAppBar(onTap: ()async {  TextEditingController numberPedidoController =
              TextEditingController();
          TextEditingController latitudeFinalController =
              TextEditingController();
          
          TextEditingController descricaoController = TextEditingController();
          TextEditingController nomeController = TextEditingController();

          TextEditingController emailController = TextEditingController();
          TextEditingController telefonController = TextEditingController();

    

    


        await  showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Adicione o pedido'),
                  content: Form(
                    child: Column(children: [
                      TextFormField(
                        controller: numberPedidoController,
                        decoration: InputDecoration(hintText: "Numero do pedido"),
                        validator: Validatorless.required('Coloque seu codigo'),
                        maxLength: 6,
                      ),
                      TextFormField(
                        controller: latitudeFinalController,
                        decoration: InputDecoration(hintText: "Endereço destino"),
                        validator: Validatorless.required('Coloque seu endereço')
                    
                      ),
               
                      TextFormField(
                        controller: nomeController,
                        decoration: InputDecoration(hintText: "Digite seu Nome"),
                      ),
                      
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: "seu email"),
                      ),
                      TextFormField(
                        controller: telefonController,
                        decoration: InputDecoration(hintText: "seu celular"),
                        maxLength: 11,
                      ),
                    ]),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text('Salvar'),
                      onPressed: () async {
                        
                        String numberPedido = numberPedidoController.text;
                        var enderecoFinal = latitudeFinalController.text;
                        controller.destinationAddress = enderecoFinal;

                        controller.addMarkersAndRoute(
                            controller.startAddressController, enderecoFinal);

                        if (numberPedido.isNotEmpty) {
                          controller.latitudeFinalController.text = enderecoFinal;
                          await controller.addUser(PedidoModel(
                              id: Random().nextInt(100),
                              pedido: numberPedido,
                              status: DateTime.now().toString(),
                            
                              destinoFinal: enderecoFinal, nome: nomeController.text, email: emailController.text, celular: telefonController.text));
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar("Error", "Please enter valid data!");
                        }
                      },
                    )
                  ],
                );
              }
      );
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
                          return InkWell(
                            child: NaPortaCard(
                              title: order.pedido.toUpperCase(),
                              subTitle: order.status.substring(0, 10),
                            ),
                            onTap: () {
                              controller.addMarkersAndRoute(controller.startAddressController, controller.destinationAddress);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PageDetail(
                                        descricaoUlt:
                                            ' Saindo em ${controller.startAddressController}\n ',
                                        descricaoInit:
                                            ' Chegando em ${controller.destinationAddress}'.obs,
                                        index: index,
                                        pedidos: order,
                                      )));
                            },
                          );
                        })
                  ]),
            )));
  }
}
