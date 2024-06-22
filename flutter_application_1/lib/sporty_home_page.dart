import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedometer/pedometer.dart';
import 'sideMenu/side_menu.dart';
import 'customization_provider.dart';

class SportyHomePage extends StatefulWidget {
  @override
  _SportyHomePageState createState() => _SportyHomePageState();
}

class _SportyHomePageState extends State<SportyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _stepCountValue = '0000';
  late Stream<StepCount> _stepCountStream;

  @override
  void initState() {
    super.initState();
    _initPedometer();
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    setState(() {
      _stepCountValue = event.steps.toString().padLeft(4, '0');
    });
  }

  void _onStepCountError(error) {
    print('Step Count Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    final cheetahImage = Provider.of<CustomizationProvider>(context).cheetahImage;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Stack(
        children: [
          Container(
            height: 1500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Sporty',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Image.asset('assets/logo.png', width: 35),
                      ],
                    ),
                    SizedBox(width: 24),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(cheetahImage, width: 350),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.directions_walk, color: Colors.teal, size: 30),
                            SizedBox(width: 10),
                            Text(
                              'P: $_stepCountValue',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
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
        ],
      ),
    );
  }
}
