import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/header/header_widget.dart';
import '../../screens/home/components/navigation_icons.dart';
import '../../navigation/app_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late GoogleMapController mapController;
  bool _isLocationPermissionGranted = false;
  
  // Faculty of Engineering, Alexandria coordinates
  final LatLng _initialPosition = const LatLng(31.2001, 29.9187);
  
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('faculty_of_engineering'),
      position: LatLng(31.2001, 29.9187),
      infoWindow: InfoWindow(
        title: 'Faculty of Engineering',
        snippet: 'Alexandria University',
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() {
      _isLocationPermissionGranted = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ScaleTransition(
                      scale: _animation,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search location...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _initialPosition,
                            zoom: 15,
                          ),
                          markers: _markers,
                          onMapCreated: (GoogleMapController controller) {
                            mapController = controller;
                          },
                          myLocationEnabled: _isLocationPermissionGranted,
                          myLocationButtonEnabled: _isLocationPermissionGranted,
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          compassEnabled: true,
                        ),
                      ),
                    ),
                    if (!_isLocationPermissionGranted)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _checkLocationPermission,
                          child: const Text('Enable Location Services'),
                        ),
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.indoorViewRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA5D7C2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Indoor View',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFA5D7C2),
            ),
            child: const NavigationIcons(),
          ),
        ],
      ),
    );
  }
} 