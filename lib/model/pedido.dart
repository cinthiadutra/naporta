import 'dart:convert';


// ignore_for_file: public_member_api_docs, sort_constructors_first






class PedidoModel {

  final int id;
  final String pedido;
  final String status;
  final String? destinoFinal;
  final String? nome;
  final String? email;
  final String? celular;
  PedidoModel({
    required this.id,
    required this.pedido,
    required this.status,
    this.destinoFinal,
    this.nome,
    this.email,
    this.celular,
  });

  
  

  @override
  String toString() {
    return 'PedidoModel(id: $id, pedido: $pedido, status: $status, destinoFinal: $destinoFinal, nome: $nome, email: $email, celular: $celular)';
  }

  PedidoModel copyWith({
    int? id,
    String? pedido,
    String? status,
    String? destinoFinal,
    String? nome,
    String? email,
    String? celular,
  }) {
    return PedidoModel(
      id: id ?? this.id,
      pedido: pedido ?? this.pedido,
      status: status ?? this.status,
      destinoFinal: destinoFinal ?? this.destinoFinal,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      celular: celular ?? this.celular,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pedido': pedido,
      'status': status,
      'destinoFinal': destinoFinal,
      'nome': nome,
      'email': email,
      'celular': celular,
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'] as int,
      pedido: map['pedido'] as String,
      status: map['status'] as String,
      destinoFinal: map['destinoFinal'] != null ? map['destinoFinal'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      celular: map['celular'] != null ? map['celular'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(String source) => PedidoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
