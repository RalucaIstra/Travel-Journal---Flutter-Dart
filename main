import 'package:flutter/material.dart';
import 'map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //elimin debug
      title: 'Travel Journal',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 247, 132, 61)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? selectedCountry;
  String? selectedCity;

  final Map<String, List<String>> citiesInCountry={
    'Italia': ['Milano','Pisa', 'Roma', 'Venetia'],
    'Romania': ['Brasov','Bucharest','Cluj Napoca','Iasi', 'Oradea', ' Suceava'],
    'Austria': ['Hallstat', 'Viena'],
    'Germania':['Munich', 'Colmar'],
    
  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
          ),
        ),
        ListView(
          children: <Widget>[
           const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 150,
              horizontal: 50.50,
              ),
            ),
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '\t\tCu bucurie îți prezint "Travel Journal", aplicația perfectă pentru pasionații de călătorii ca tine, cei care apreciază descoperirea locurilor noi și organizarea perfectă a fiecărei excursii. Indiferent dacă ești un aventurier în căutare de restaurante locale, atractii turistice impresionante, cafenele pitorești sau grădini încântătoare, "TravelJournal" este partenerul tău de încredere pentru a face fiecare călătorie memorabilă.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                              
                ),
              ),
              const Text(
                '\t\tCu această aplicație ușor de utilizat, poți explora orice destinație din lume cu ușurință. Tot ce trebuie să faci este să selectezi țara și orașul pe care dorești să le vizitezi, iar "Travel Journal" îți va oferi toate informațiile de care ai nevoie pentru a-ți planifica aventura perfectă.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                              
                ),
              ),
              DropdownButton<String>(
                dropdownColor: const Color.fromARGB(255, 1, 22, 37),
                value: selectedCountry,
                items: citiesInCountry.keys.map((String country){
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: const TextStyle(color: Colors.white),
                      ),
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState((){
                    selectedCountry = newValue;
                    selectedCity = null;
                  });
                },
                hint: const Text(
                  'Select a country',
                  style: TextStyle(color: Colors.white),
                  ),
              ),
              if (selectedCountry != null)
                DropdownButton<String>(
                  value: selectedCity,
                  items: citiesInCountry[selectedCountry!]!.map((String city){
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(
                        city,
                        //style: const TextStyle(color: Colors.white),
                        ),
                    );
                  }).toList(),
                  onChanged: (String? value) {  
                  if (value != null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context) => CityPage(city: value)),
                    );
                  }
                  },
                  hint: const Text(
                  'Select a city',
                  style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          ],
        ),
        ],
      ),
    );
  }
}
