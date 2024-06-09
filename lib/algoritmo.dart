import 'dart:math';

List<String> paisesMatriz(List<List<dynamic>> matriz, int n) {
  List<String> lista = [];
  for (int i = 1; i < n; i++) {
    lista.add(matriz[0][i]);
  }
  return lista;
}

bool isInLista(List<String> lista, String pais) {
  bool bandera = false;
  for (String villa in lista) {
    if (!villa.contains(pais)) {
      bandera = true;
    } else {
      bandera = false;
      break;
    }
  }
  if (lista.isEmpty) {
    bandera = true;
  }
  return bandera;
}

List<String> listaParaVillas(List<String> lista, int n, List<List<dynamic>> matriz) {
  String mensaje = "";
  List<String> paises = paisesMatriz(matriz, n);
  List<String> listaFinal = [];
  bool bandera = false;
  bool bandera2 = false;

  for (int i = 0; i < lista.length; i++) {
    if (listaFinal.isNotEmpty) {
      bandera = isInLista(listaFinal, lista[i].split(" ")[0]);
    }
    if (bandera == true || listaFinal.isEmpty) {
      List<String> division = lista[i].split(" ");
      division.removeAt(0);
      for (int j = 0; j < n - 1; j++) {
        if (!division.contains(paises[j]) &&
            paises[j] != lista[i].split(" ")[0] &&
            isInLista(listaFinal, paises[j]) == true) {
          if (mensaje.isEmpty) {
            mensaje += " ${paises[j]}";
          } else {
            List<String> aux = mensaje.split(" ");
            for (int k = 0; k < aux.length; k++) {
              for (int l = 0; l < lista.length; l++) {
                if (aux[k] == lista[l].split(" ")[0]) {
                  List<String> division2 = lista[l].split(" ");
                  if (!division2.contains(paises[j])) {
                    bandera2 = true;
                  } else {
                    bandera2 = false;
                  }
                }
              }
            }
            if (bandera2 == true) {
              mensaje += " ${paises[j]}";
            }
          }
        }
      }
      if (bandera == true || listaFinal.isEmpty) {
        listaFinal.add(lista[i].split(" ")[0] + mensaje);
      }
    }
    mensaje = "";
  }
  return listaFinal;
}

List<String> listaRelacionesNoAmistosasPaises(List<List<dynamic>> matriz, int n) {
  List<String> lista = [];
  List<String> paisesParaVillas = paisesMatriz(matriz, n);

  for (int i = 1; i < n; i++) {
    for (int j = 1; j < n; j++) {
      if (matriz[i][j] == 1 && i != j) {
        lista.add("${matriz[i][0]}:${matriz[0][j]}");
      }
    }
  }

  List<String> listaFiltrada = [];
  for (int i = 0; i < lista.length; i++) {
    for (int j = 0; j < lista.length; j++) {
      if (lista[j].split(":")[1] == lista[i].split(":")[0] &&
          lista[j] != "1:1" &&
          lista[j].split(":")[0] == lista[i].split(":")[1]) {
        listaFiltrada.add(lista[i]);
        lista[j] = "1:1";
        lista[i] = "1:1";
      }
    }
  }

  List<String> listaRelacionesNoAmistosas = [];
  String mensaje = "";

  for (int i = 0; i < paisesParaVillas.length; i++) {
    for (int j = 0; j < listaFiltrada.length; j++) {
      if (listaFiltrada[j].contains(paisesParaVillas[i])) {
        if (listaFiltrada[j].split(":")[0] == paisesParaVillas[i]) {
            mensaje += " ${listaFiltrada[j].split(":")[1]}";
        }
        if (listaFiltrada[j].split(":")[1] == paisesParaVillas[i]) {
          mensaje += " ${listaFiltrada[j].split(":")[0]}";
        }
      }
    }
    listaRelacionesNoAmistosas.add(paisesParaVillas[i] + mensaje);
    mensaje = "";
  }
  return listaRelacionesNoAmistosas;
}

List<List<dynamic>> matrizVilla(List<String> lista, int n, List<String> paises) {
  List<List<dynamic>> matriz = List.generate(
      lista.length + 1, (i) => List.filled(n, 0, growable: false),
      growable: false);
  matriz[0][0] = "#";
  for (int i = 1; i < lista.length + 1; i++) {
    matriz[i][0] = "Villa #$i";
  }
  for (int j = 1; j < n; j++) {
    matriz[0][j] = paises[j - 1];
  }
  for (int i = 1; i < lista.length + 1; i++) {
    for (int j = 1; j < n; j++) {
      if (lista[i - 1].contains(paises[j - 1])) {
        matriz[i][j] = 1;
      } else {
        matriz[i][j] = 0;
      }
    }
  }
  
  return matriz;
}

List<List<dynamic>> matrizAleatoria(int tam){
  List<String> paises = [
    "Argentina", "China", "Colombia", "Australia", "Jamaica", "Japón",
    "Austria", "Irlanda", "Islandia", "Italia", "Barbados", "Bélgica",
    "Bolivia", "Brasil", "Camerún", "Canadá", "Chile", "Croacia",
    "Cuba", "Dinamarca", "Ecuador", "Egipto", "Eslovaquia", "Eslovenia",
    "España", "Estonia", "Armenia", "Filipinas", "Finlandia", "Francia",
    "Ghana", "Grecia", "Granada", "Guatemala", "Honduras", "India",
    "Indonesia", "Irán", "Irak", "Uzbekistán", "Vanuatu", "Venezuela",
    "Vietnam", "Yemen", "Yibuti", "Zambia", "Zimbabue",
    "Noruega", "Paraguay",];


  int n = tam;
  
  List<List<dynamic>> matriz = List.generate(
      n, (i) => List.filled(n, 0, growable: false),
      growable: false);
  
  matriz[0][0] = "#"; 

  
  for (int i = 1; i < n; i++) {
    for (int j = 1; j < n; j++) {
      int numeroRandom = Random().nextInt(2);
      matriz[i][j] = numeroRandom;
      matriz[j][i] = numeroRandom;
      matriz[0][j] = paises[j - 1];
      matriz[i][0] = paises[i - 1];
      if (i == j) {
        matriz[i][j] = 0;
      }
    }
  }
  
  return matriz;
}
List<List<dynamic>> algoritmoParaDeterminarVillas(int n, List<List<dynamic>> matriz) {
  
  List<String> listaRelaciones = listaRelacionesNoAmistosasPaises(matriz, n);
  List<String> listaVillas = listaParaVillas(listaRelaciones, n, matriz);
  List<List<dynamic>> matrizVillas = matrizVilla(listaVillas, n, paisesMatriz(matriz, n));
  
  return matrizVillas;
}

List<List<dynamic>> matrizPrueba1 = [
    ["#", "Argentina", "China", "Colombia", "Australia", "Jamaica", "Japon"],
    ["Argentina", 0, 0, 1, 1, 1, 1],
    ["China", 0, 0, 0, 1, 0, 1],
    ["Colombia", 1, 0, 0, 0, 0, 1],
    ["Australia", 1, 1, 0, 0, 0, 0],
    ["Jamaica", 1, 0, 0, 0, 0, 1],
    ["Japon", 1, 1, 1, 0, 1, 0]
  ];
  
  List<List<dynamic>> matrizPrueba2 = [  
    ["#","Argentina", "China","Colombia","Australia","Jamaica","Japón"],
    ["Argentina",0,0,0,0,0,1],
    ["China", 0,0,1,0,0,0],
    ["Colombia",0 ,1,0,1,0,1],
    ["Australia",0 ,0,1,0,1,0],
    ["Jamaica",0 ,0,0,1,0,0],
    ["Japón", 1 ,0 ,1,0,0,0],];

  List<List<dynamic>> matrizPrueba3 = [
      ["#", "Argentina", "China", "Colombia", "Australia", "Jamaica", "Japón", "Austria","Irlanda", "Islandia"],
      ["Argentina", 0, 0, 1, 1, 0, 0, 0, 0, 0],
      ["China", 0, 0, 1, 0, 0, 0, 1, 1, 1],
      ["Colombia", 1, 1, 0, 1, 1, 0, 1, 0, 0],
      ["Australia", 1, 0, 1, 0, 1, 1, 1, 0, 0],
      ["Jamaica", 0, 0, 1, 1, 0, 1, 1, 0, 1],
      ["Japón", 0, 0, 0, 1, 1, 0, 0, 1, 1],
      ["Austria", 0, 1, 1, 1, 1, 0, 0, 0, 1],
      ["Irlanda", 0, 1, 0, 0, 0, 1, 0, 0, 1],
      ["Islandia", 0, 1, 0, 0, 1, 1, 1, 1, 0],];

List<List<dynamic>> matrizPrueba4 = [
  ["#", "Argentina", "China", "Colombia", "Australia"],
  ["Argentina", 0, 1, 1, 0],
  ["China", 1, 0, 1, 0],
  ["Colombia", 1, 1, 0, 0],
  ["Australia", 0, 0, 0, 0],];

List<List<dynamic>> matrizPrueba5 = [
  ["#", "Argentina", "China", "Colombia", "Australia", "Jamaica", "Japón", "Austria"],
  ["Argentina", 0, 0, 1, 1, 1, 0, 0],
  ["China", 0, 0, 1, 0, 1, 0, 1],
  ["Colombia", 1, 1, 0, 0, 1, 0, 1],
  ["Australia", 1, 0, 0, 0, 1, 0, 1],
  ["Jamaica", 1, 1, 1, 1, 0, 1, 0],
  ["Japón", 0, 0, 0, 0, 1, 0, 1],
  ["Austria", 0, 1, 1, 1, 0, 1, 0],
];
