import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double taxa = 0;
  double totalConta =0, totalPagar=0, comissao=0;
  int qtdPessoas=0;

  TextEditingController txtTotal = TextEditingController();
  TextEditingController txtQtd = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void calc(){
    setState(() {
      totalConta = double.parse(txtTotal.text);
      qtdPessoas = int.parse(txtQtd.text);

      comissao = (taxa * totalConta)/100;

      totalPagar = (totalConta+comissao)/qtdPessoas;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Total a pagar por pessoa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("TOTAL DA CONTA: R\$ $totalConta"),
                const SizedBox(height: 10,),
                Text("TOTAL POR PESSOA: R\$ $totalPagar"),
                const SizedBox(height: 10,),
                Text("TAXA DO GARÇOM: R\$ $comissao"),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text("Ok"),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffff6600),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                ),
              ),
            ],
          ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RACHA CONTA"),
        centerTitle: true,
        backgroundColor: const Color(0xffff66000),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(70),
                        child: const Image(
                          image: AssetImage("assets/budget.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: txtTotal,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: "Total da Conta",
                    ),
                    style: const TextStyle(fontSize: 18),
                    validator: (value){
                      if(value!.isEmpty) return "Campo Obrigatório";
                      else return null;

                    },
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Serviço %:", style: TextStyle(fontSize: 18),),
                      Slider(
                            value: taxa,
                            min: 0,
                            max: 15,
                            label: "$taxa%",
                            divisions: 15,
                            activeColor: const Color(0xffff6600),
                            inactiveColor: Colors.grey,
                            onChanged: (double val){
                              setState(() {
                                taxa = val!;
                              });
                            },
                        ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    controller: txtQtd,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: "Qtd Pessoas",
                    ),
                    style: const TextStyle(fontSize: 18),
                    validator: (value){
                      if(value!.isEmpty) return "Campo Obrigatório";
                      else return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffff6600),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            calc();
                          }

                        },
                        child: const Text("Calcular", style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
