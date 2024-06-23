import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import '../workouts_screen.dart'; // Import your WorkoutsScreen widget here

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

// mapas
  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late GoogleMapController _mapController;
  late StreamSubscription<Position> _positionStream;
  CameraPosition? _initialCameraPosition;
  bool _isCameraInitialized = false;
  Position? _currentPosition;
  BitmapDescriptor? _customMarker;
  Set<Marker> _markers = {}; // Set to store markers
  MapType _currentMapType = MapType.normal; // Variable to store current map type
  List<MapType> _mapTypes = [MapType.normal, MapType.satellite]; // List of map types
  String? _selectedWorkout; // Store selected workout image path

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _requestPermission();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  Future<void> _loadCustomMarker() async {
    _customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)),
      'assets/logo.png',
    );
  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _initGeolocation();
    } else {
      // Handle permission denial
      print("Location permission denied");
    }
  }

  void _initGeolocation() async {
    var geolocator = GeolocatorPlatform.instance;

    var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    // Fetch the initial position and set it as the initial camera position
    try {
      Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: locationOptions.accuracy,
      );

      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
        _currentPosition = position;
        _markers.add(_createMarker(position)); // Add initial marker
      });

      _positionStream = geolocator.getPositionStream(
        desiredAccuracy: locationOptions.accuracy,
        distanceFilter: locationOptions.distanceFilter,
      ).listen(
        (Position position) {
          _updateCameraPosition(position);
          _updateMarkerPosition(position);
        },
        onError: (err) {
          print(err);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Marker _createMarker(Position position) {
    return Marker(
      markerId: MarkerId('currentLocation'),
      position: LatLng(position.latitude, position.longitude),
      icon: _customMarker ?? BitmapDescriptor.defaultMarker,
    );
  }

  void _updateCameraPosition(Position position) {
    if (_isCameraInitialized) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ),
      );
      setState(() {
        _currentPosition = position;
      });
    }
  }

  void _updateMarkerPosition(Position position) {
    setState(() {
      _markers.clear(); // Clear existing markers
      _markers.add(_createMarker(position)); // Add updated marker
    });
  }

  void _focusOnUserPosition() {
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  void _toggleMapType() {
    setState(() {
      // Toggle between normal and satellite map types
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _showWorkoutsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitleRow(),
              SizedBox(height: 20),
              buildCenteredText('Select your workout:'),
              SizedBox(height: 20),
              buildWorkoutGrid(context), // Pass context to buildWorkoutGrid
            ],
          ),
        );
      },
    );
  }

  void _selectWorkout(String workoutImagePath) {
    setState(() {
      _selectedWorkout = workoutImagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialCameraPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _isCameraInitialized = true;
                  },
                  initialCameraPosition: _initialCameraPosition!,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: _markers,
                  mapType: _currentMapType,
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: _toggleMapType,
                        backgroundColor: Colors.teal,
                        child: Icon(Icons.layers, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: _zoomIn,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.zoom_in, color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.white,
                            ),
                            InkWell(
                              onTap: _zoomOut,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.zoom_out, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: _focusOnUserPosition,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.my_location, color: Colors.white),
                  ),
                ),
                if (_selectedWorkout != null) // Show selected workout button if selectedWorkout is not null
                  Positioned(
                    bottom: 120, // Adjust position as needed
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Handle button press
                      },
                      backgroundColor: Colors.teal,
                      child: Image.asset(_selectedWorkout!, width: 30, height: 30), // Display selected workout image
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  right: 0,
                  left: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FloatingActionButton.extended(
                            onPressed: _showWorkoutsBottomSheet,
                            backgroundColor: Colors.teal,
                            icon: Icon(Icons.flag, color: Colors.white),
                            label: Text('Select Workout', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Center buildTitleRow() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/flag.png', width: 50),
          SizedBox(width: 10),
          Text(
            'Workouts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Center buildCenteredText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Expanded buildWorkoutGrid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2, // Changed to 2 columns for running and walking
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          WorkoutItem('assets/Workouts_Assests/corrida.png', () {
            _selectWorkout('assets/Workouts_Assests/corrida.png');
            Navigator.pop(context); // Close bottom sheet
          }),
          WorkoutItem('assets/Workouts_Assests/caminhada.png', () {
            _selectWorkout('assets/Workouts_Assests/caminhada.png');
            Navigator.pop(context); // Close bottom sheet
          }),
        ],
      ),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  WorkoutItem(this.assetPath, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(assetPath, width: 70),
          SizedBox(height: 5),
          Text(
            _getWorkoutLabel(assetPath), // Assuming a function to get label based on assetPath
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  String _getWorkoutLabel(String assetPath) {
    // Implement logic to derive label from assetPath
    return assetPath.replaceAll('assets/Workouts_Assests/', '').replaceAll('.png', '');
  }
}
