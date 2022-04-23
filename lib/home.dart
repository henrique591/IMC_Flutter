import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
// Henrique Araujo
//Henriquearaujo1998@gmail.com

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//Controller
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaContoller = TextEditingController();

  GlobalKey<FormState> _formakey = GlobalKey<FormState>();

// Variaveis privadas
  String _infoText = "Informe seus dados";

  double _imc = 0.0;
  int cor = 0;
  String _statusPeso = "kg";
  String _statusAltura = "m";

  bool _notZero = false;
  //Método para limpas os campos
  void _limpaCampos() {
    pesoController.text = "";
    alturaContoller.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _imc = 0;
      _statusAltura = "m";
      _statusPeso = "kg";
    });
  }

//Método Calcular
  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      //converte centimentros em metros
      double altura = double.parse(alturaContoller.text) / 100;

      _imc = peso / (altura * altura);

      if (_imc < 15.0) {
        _infoText = "Serveramente abaixo do peso";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";

        _statusAltura = "${altura * 100}m";
      } else if (_imc >= 15.0 && _imc < 16.0) {
        _infoText = "Muito abaixo do peso";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      } else if (_imc >= 16.0 && _imc < 18.5) {
        _infoText = "Abaixo do peso";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      } else if (_imc >= 18.5 && _imc < 25.0) {
        _infoText = "Saudável";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      } else if (_imc >= 25.0 && _imc < 30.0) {
        _infoText = "Sobrepeso";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      } else if (_imc >= 30.0 && _imc < 35.0) {
        _infoText = "Obesidade moderada";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      } else if (_imc >= 35.0 && _imc < 40.0) {
        _infoText = "Obesidade alta";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      } else if (_imc > 40) {
        _infoText = "Obesidade muito alta";
        _statusPeso = "${peso}kg";
        _statusAltura = "${altura}m";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Titulo do app na barra
        title: const Text(" Cálculadora de Imc"),
        leading: IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Info(),
                  )),
          icon: const Icon(
            Icons.announcement,
            color: Colors.white,
          ),
        ),
        //centraliza o titulo da barra
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _limpaCampos, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formakey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 1,
              ),
              //todo o corpo do app
              Status(),
              Grafico(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Resultado(), TextInf()],
              ),
              FieldPeso(),
              FieldAltura(),
              ButtonCalcular(),
              Tabela()
            ],
          ),
        ),
      ),
    );
  }

  // entrada de dados peso
  FieldPeso() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //Controller
        controller: pesoController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Peso (Kg)',
            hintText: 'Digite o seu Peso Exp: 80',
            hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            isDense: true,
            contentPadding: EdgeInsets.all(18)),
      ),
    );
  }

  //Entrada de dados Altura
  FieldAltura() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //Controller
        controller: alturaContoller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Altura',
            hintText: 'Digite a sua altura Exp: 172',
            hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(18)),
      ),
    );
  }

  // Toda a estrutura do Botão Calcular
  ButtonCalcular() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 40,
        child: RaisedButton(
          color: Colors.green,
          onPressed: _calcularIMC,
          child: const Text(
            "Calcular",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  // texte do resultado
  Resultado() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25),
    );
  }

  // texto link para mais informação sobre IMC
  TextInf() {
    return TextButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
                  child: Info(),
                )),
        child: Text('infor'));
  }

  // Tela com as Informações sobre o IMC
  Info() {
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cálculo IMC",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 50, right: 50),
            child: const Text(
                "IMC é a sigla para Índice de Massa Corpórea, parâmetro adotado pela Organização Mundialde Saúde para calcular o peso ideal de cada pessoa.O índice é calculado da seguinte maneira: divide-se o peso do paciente pela sua altura elevada ao quadrado. Diz-se que o indivíduo tem peso normal quando o resultado do IMC está entre 18,5 e 24,9.Quer descobrir seu IMC? Insira seu peso e sua altura nos campos abaixo e compare com os índices da tabela. Importante: siga os exemplos e use pontos como separadores."),
          ),
        ],
      ),
    );
  }

  // Grafico maneiro que eu fiz, mostrando o valor do seu IMC
  Grafico() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            minimum: 0,
            maximum: 40,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 15.0,
                  color: Color.fromRGBO(48, 46, 32, 0.897),
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 15.0,
                  endValue: 16.0,
                  color: Color.fromARGB(255, 10, 135, 151),
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 16.0,
                  endValue: 18.5,
                  color: Color.fromARGB(255, 65, 83, 161),
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 18.5,
                  endValue: 25.0,
                  color: Colors.greenAccent.shade400,
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 25.0,
                  endValue: 30.0,
                  color: Color.fromARGB(255, 212, 174, 117),
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 30.0,
                  endValue: 35.0,
                  color: Color.fromARGB(255, 252, 118, 78),
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 35.0,
                  endValue: 40.0,
                  color: Colors.red,
                  startWidth: 50,
                  endWidth: 50),
              GaugeRange(
                  startValue: 40,
                  endValue: 41,
                  color: Colors.brown,
                  startWidth: 50,
                  endWidth: 50),
            ],
            pointers: <GaugePointer>[
              MarkerPointer(
                value: _imc,
                markerType: MarkerType.triangle,
                markerHeight: 30,
                markerWidth: 30,
                markerOffset: 40,
                color: Colors.white,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                axisValue: _imc,
                positionFactor: 0.05,
                widget: Text(
                  _imc.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              )
            ])
      ],
    );
  }

  /// Texto superior mostrando altura e peso
  Status() {
    return IntrinsicHeight(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        VerticalDivider(),
        Text(_statusAltura),
        VerticalDivider(),
        Text(_statusPeso),
        VerticalDivider(),
      ],
    ));
  }

// Lista mostrando o IMC e marca o seu IMC
  Tabela() {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.arrow_right,
                color: _imc == 0
                    ? Color(0xFFFAFAFA)
                    : _imc < 15
                        ? Colors.black
                        : Color(0xFFFAFAFA),
              ),
              Container(
                width: 20,
                height: 20,
                color: Color.fromRGBO(48, 46, 32, 0.897),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Serveramente abaixo do peso                                                        < 15',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc < 15
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right,
                  color: _imc == 0
                      ? Color(0xFFFAFAFA)
                      : _imc >= 15.0 && _imc < 16.0
                          ? Colors.black
                          : Color(0xFFFAFAFA)),
              Container(
                width: 20,
                height: 20,
                color: Color.fromARGB(255, 10, 135, 151),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Muito abaixo do peso                                                                 15.0 - 16.0',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc >= 15.0 && _imc < 16.0
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right,
                  color: _imc == 0
                      ? Color(0xFFFAFAFA)
                      : _imc >= 16.0 && _imc < 18.5
                          ? Colors.black
                          : Color(0xFFFAFAFA)),
              Container(
                width: 20,
                height: 20,
                color: Color.fromARGB(255, 65, 83, 161),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Abaixo do peso                                                                            16.0 - 18.5',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc >= 16.0 && _imc < 18.5
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right,
                  color: _imc == 0
                      ? Color(0xFFFAFAFA)
                      : _imc >= 18.5 && _imc < 25.0
                          ? Colors.black
                          : Color(0xFFFAFAFA)),
              Container(
                width: 20,
                height: 20,
                color: Colors.greenAccent.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Saudável                                                                                       18.5 - 25.0 ',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc >= 18.5 && _imc < 25.0
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right,
                  color: _imc == 0
                      ? Color(0xFFFAFAFA)
                      : _imc >= 25.0 && _imc < 30.0
                          ? Colors.black
                          : Color(0xFFFAFAFA)),
              Container(
                width: 20,
                height: 20,
                color: Color.fromARGB(255, 212, 174, 117),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Sobrepeso                                                                                    25.0 - 30.0',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc >= 25.0 && _imc < 30.0
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right,
                  color: _imc == 0
                      ? Color(0xFFFAFAFA)
                      : _imc >= 30.0 && _imc < 35.0
                          ? Colors.black
                          : Color(0xFFFAFAFA)),
              Container(
                width: 20,
                height: 20,
                color: Color.fromARGB(255, 252, 118, 78),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Obesidade moderada                                                                 30.0 - 35.0',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc >= 30.0 && _imc < 35.0
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right,
                  color: _imc == 0
                      ? Color(0xFFFAFAFA)
                      : _imc >= 35.0 && _imc > 40.0
                          ? Colors.black
                          : Color(0xFFFAFAFA)),
              Container(
                width: 20,
                height: 20,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  'Obesidade alta                                                                             35.0 - 40.0',
                  style: TextStyle(
                      color: _imc == 0
                          ? Colors.black
                          : _imc >= 35.0 && _imc > 40.0
                              ? Colors.amber
                              : Colors.black))
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
