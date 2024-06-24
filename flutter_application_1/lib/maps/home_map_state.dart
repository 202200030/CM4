import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'running_logic.dart'; // Import your RunningLogic class

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late GoogleMapController _mapController;
  late StreamSubscription<Position> _positionStream;
  CameraPosition? _initialCameraPosition;
  bool _isCameraInitialized = false;
  Position? _currentPosition;
  BitmapDescriptor? _customMarker;
  Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  String? _selectedWorkout;

  RunningLogic _runningLogic = RunningLogic(); // Instantiate RunningLogic

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

    try {
      Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: locationOptions.accuracy,
      );

      _updateInitialCameraPosition(position);
      _setUpPositionStream(geolocator, locationOptions);
    } catch (e) {
      print(e);
    }
  }

  void _updateInitialCameraPosition(Position position) {
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      );
      _currentPosition = position;
      _markers.add(_createMarker(position));
    });
  }

  void _setUpPositionStream(GeolocatorPlatform geolocator, LocationOptions locationOptions) {
    _positionStream = geolocator.getPositionStream(
      desiredAccuracy: locationOptions.accuracy,
      distanceFilter: locationOptions.distanceFilter,
    ).listen(
      (Position position) {
        _updateCameraAndMarker(position);
      },
      onError: (err) {
        print(err);
      },
    );
  }

  void _updateCameraAndMarker(Position position) {
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
        _markers.clear();
        _markers.add(_createMarker(position));
      });
    }
  }

  Marker _createMarker(Position position) {
    return Marker(
      markerId: MarkerId('currentLocation'),
      position: LatLng(position.latitude, position.longitude),
      icon: _customMarker ?? BitmapDescriptor.defaultMarker,
    );
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
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _showWorkoutsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent();
      },
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleRow(),
          SizedBox(height: 20),
          _buildCenteredText('Select your workout:'),
          SizedBox(height: 20),
          _buildWorkoutGrid(),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
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

  Widget _buildCenteredText(String text) {
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

  Widget _buildWorkoutGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          _buildWorkoutItem('assets/Workouts_Assests/corrida.png'),
          _buildWorkoutItem('assets/Workouts_Assests/caminhada.png'),
        ],
      ),
    );
  }

  Widget _buildWorkoutItem(String assetPath) {
    return GestureDetector(
      onTap: () {
        _selectWorkout(assetPath);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Image.asset(assetPath, width: 70),
          SizedBox(height: 5),
          Text(
            _getWorkoutLabel(assetPath),
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
    return assetPath.replaceAll('assets/Workouts_Assests/', '').replaceAll('.png', '');
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
                if (_selectedWorkout != null)
                  Positioned(
                    bottom: 120,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Handle selected workout button press
                      },
                      backgroundColor: Colors.teal,
                      child: Image.asset(_selectedWorkout!, width: 30, height: 30),
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      if (_runningLogic.isRunning) {
                                        _runningLogic.stopRun(() => setState(() {}));
                                      } else {
                                        _runningLogic.startRun(() => setState(() {}));
                                      }
                                    },
                                    backgroundColor: _runningLogic.isRunning ? Colors.red : Colors.teal,
                                    icon: _runningLogic.isRunning
                                        ? Icon(Icons.stop, color: Colors.white)
                                        : Icon(Icons.directions_run, color: Colors.white),
                                    label: Text(
                                      _runningLogic.isRunning ? 'Stop Run' : 'Start Run',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 200),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: _runningLogic.isRunning
                                        ? Container(
                                            key: ValueKey('elapsedTime'),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              _runningLogic.getFormattedElapsedTime(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ],
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
}
