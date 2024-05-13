import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:geocoding/geocoding.dart';

// Future<LatLng> getCityCoordinates(String city) async {
//   List<Location> locations = await locationFromAddress(city);
//   if (locations.isNotEmpty) {
//     return LatLng(locations.first.latitude, locations.first.longitude);
//   } else {
//     throw Exception('Could not find coordinates for $city');
//   }
// }

void requestLocationPermission() async {
  PermissionStatus permission = await Permission.location.status;
  if (permission != PermissionStatus.granted) {
    await Permission.location.request();
  }
}


class CityPage extends StatefulWidget{
  final String city;
  
  const CityPage({super.key, required this.city});

  @override
  CityPageState createState() => CityPageState();
    
}

 class CityPageState extends State<CityPage>{
  Set <Marker> markers = {};
  late LatLng cityCoordinates = const LatLng(44.4268, 26.1025);
  //LatLng? cityCoordinates;
  final Completer<GoogleMapController> _controller = Completer();

  final Map<String, List<Map<String, dynamic>>> categories = {
    'Restaurante' : [
    {'name':'Raionul de Peste', 'coordinates': '44.460548066280715, 26.10067248336193'},
    {'name':'Bread and Butter', 'coordinates': '44.43440970764315, 26.097979272934804'},
    {'name':'Smash Baby Burger', 'coordinates': '44.46003375239819, 26.099690870181977'},
    {'name':'MoMo Bucharest', 'coordinates': '44.45998795255832, 26.097168415154346'},
    {'name':'5ENSI by BeanZ Cafe', 'coordinates': '44.45408986021897, 26.08699143350885'},
    {'name':'Vivo - Fusion Food Bar', 'coordinates': '44.43122944564715, 26.05335709872766'},
  ],
    'Cafenele':[
      {'name': 'Meron', 'coordinates': '44.43495346554095, 26.094572484655316'},
    ],
    'Muzee':[
      {'name': 'Palatul Parlamentului', 'coordinates': '44.42755348843842, 26.087318435333778' },
    ],
  };

  String? selectedCategory;
  String? selectedLocation;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    // //getCityCoordinates(widget.city).then((LatLng coordinates){
    //   setState((){
    //     cityCoordinates = coordinates;
    //   });
    // });
  }
    void _onMapCreated(GoogleMapController controller){
      _controller.complete(controller);
      //getCityCoordinates(widget.city).then((LatLng coordinates){
      setState ((){
       for (var category in categories.entries){
        for(var location in category.value){
        List<String> coordinates = location['coordinates'].split(',').map<String>(( String coordinates) => coordinates.trim()).toList();
        markers.add(
          Marker(
          markerId:MarkerId(' ${location['name']}'),
          position:LatLng(double.parse(coordinates[0]), double.parse(coordinates[1])),
          onTap:(){
           showModalBottomSheet(
            context: context,
            builder: (BuildContext contect){
              return Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(location['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Restaurant'),
                    const Text('Deschis: luni - joi orele 10:00 - 22:00'),
                    const Text ('vineri - duminica orele 12:00 - 00:00')
                  ],
                ),
              );
            },
           );
          },
          ),
        
      );
       }
       }
      }); 
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City: ${widget.city}'),
      
      actions: <Widget>[
        PopupMenuButton<String>(
          // onPressed: (){
            icon: const Icon(Icons.category),
            onSelected: (String category) {
            setState((){
              selectedCategory = category;
              selectedLocation = null;
            }) ;
            },
            itemBuilder: (BuildContext context){
              return categories.keys.map((String category){
                return PopupMenuItem<String>(
                  value: category,
                  child: Text(category),
                );

              }).toList();

            },
        ),
        if (selectedCategory != null)
        PopupMenuButton<String>(
            icon: const Icon(Icons.place),
            onSelected: (String location){
              setState((){
                selectedLocation = location;
              });
              Map<String, dynamic> selectedPlace = categories[selectedCategory]!.firstWhere((place) => place['name'] == selectedLocation);
              List<String> coordinates = selectedPlace['coordinates'].split(',').map<String>((String coordinate) => coordinate.trim()).toList();
              LatLng selectedLatLng = LatLng(double.parse(coordinates[0]), double.parse(coordinates[1]));
              _controller.future.then(
                (GoogleMapController controller){
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: selectedLatLng,
                        zoom: 16,
                      ),
                    ),
                  );
                },
              );
            },
            itemBuilder: (BuildContext context){
              return categories[selectedCategory]!.map((Map<String, dynamic> location){
                return PopupMenuItem<String>(
                  value: location['name'],
                  child: Text(location['name']),                  
                );
              }).toList();
            },
        ),
      ]
      ),

      
      body: Stack(
        children:[
         GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:  CameraPosition(
            target: cityCoordinates,
            zoom: 14,
          ),
          markers: markers,
        ),
      
        ],
      ),
    );                  
  }             
  }
