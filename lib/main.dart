import 'package:flutter/material.dart';
import 'algoritmo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROYECTO-ADA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 9, 54, 138)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Asignacion de Villas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const List<String> lista = <String>[
  '3X3','4X4','5X5', '6X6', '7X7','8X8','9X9','10X10',
  '11X11','12X12','13X13','14X14','15X15','16X16','17X17',
  '18X18','19X19','20X20','21X21','22X22','23X23','24X24',
  '25X25','26X26','27X27','28X28','29X29','30X30','31X31',
  '32X32','33X33','34X34','35X35','36X36','37X37','38X38',
  '39X39','40X40','41X41','42X42','43X43','44X44','45X45',
  '46X46','47X47','48X48',
];

const List<String> pruebas = <String>['Matriz 1','Matriz 2','Matriz 3','Matriz 4','Matriz 5',];

class _MyHomePageState extends State<MyHomePage> {
  int size = 3;
  String matriz = "Matriz 1";
  List<List<dynamic>> villasPaises = List.generate(
      3, (i) => List.filled(3, "#", growable: false),
      growable: false);
  
  List<List<dynamic>> relacionesPaises = List.generate(
      3, (i) => List.filled(3, "#", growable: false),
      growable: false);

  _showMatriz(List<List<dynamic>> matriz, int numero, int numero2) {
    return Column(
      children: [
        for (int i = 0; i < matriz.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int j = 0; j < matriz[i].length; j++)
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: matriz[i][j] == numero
                        ? Colors.green
                        : matriz[i][j] == numero2 
                        ? Colors.red
                        :Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      matriz[i][j].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
  void sizeMatriz() {
    setState(() {
      relacionesPaises = matrizAleatoria(size);
      villasPaises = algoritmoParaDeterminarVillas(size, relacionesPaises);
    });
  }
  
  void sizePruebas(int n, List<List<dynamic>> matrizSeleccionada){
    setState(() {
      relacionesPaises = matrizSeleccionada;
      villasPaises = algoritmoParaDeterminarVillas(n, relacionesPaises);
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text(widget.title, style: const TextStyle(color: Colors.white))),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Seleccione el tamaño de la matriz: ',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownMenu<String>(
                    initialSelection: lista.first,
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    menuHeight: 180,
                    onSelected: (String? value) {
                      setState(() {
                        size = int.parse(value!.split('X')[0]);
                      });
                    },
                    dropdownMenuEntries:
                        lista.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () => sizeMatriz(),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blueAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    child: const Text(
                      'Ver Resultado',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Seleccione una matriz de prueba: ',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownMenu<String>(
                    initialSelection: pruebas.first,
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    menuHeight: 180,
                    onSelected: (String? value) {
                      setState(() {
                        matriz = value!;
                      });
                    },
                    dropdownMenuEntries:
                        pruebas.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () => matriz == "Matriz 1" 
                    ? sizePruebas(7,matrizPrueba1)
                    : matriz == "Matriz 2" 
                    ? sizePruebas(7, matrizPrueba2)
                    : matriz == "Matriz 3" 
                    ? sizePruebas(10, matrizPrueba3)
                    : matriz == "Matriz 4" 
                    ? sizePruebas(5, matrizPrueba4)
                    : sizePruebas(8, matrizPrueba5),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blueAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    child: const Text(
                      'Mostrar Matriz de prueba',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    const Text("Color para relacion: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20, width: 20,child: Container(decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.green ,
                    ),)), 

                    const SizedBox(width: 20,),

                    const Text("Color para no relacion: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20, width: 20,child: Container(decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.red ,
                    ),)),
                ],
              ),

              const SizedBox(height: 20,),
              
              const Text("Matriz de Relaciones", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              
              
              
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: _showMatriz(relacionesPaises,0,1),
              ),
              const SizedBox(height: 20,),
              
              const Text("Matriz de Villas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: _showMatriz(villasPaises,1,0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}