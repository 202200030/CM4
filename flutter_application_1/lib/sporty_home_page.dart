import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedometer/pedometer.dart';
import 'sideMenu/side_menu.dart';
import 'customization_provider.dart';
import 'notification_service.dart'; // Importar NotificationService

class SportyHomePage extends StatefulWidget {
  @override
  _SportyHomePageState createState() => _SportyHomePageState();
}

class _SportyHomePageState extends State<SportyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _stepCountValue = '0000';
  late Stream<StepCount> _stepCountStream;
  int _lifeBar = 100;
  Timer? _lifeTimer;
  int _previousSteps = 0;
  late NotificationService _notificationService; // Instância de NotificationService

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService(); // Inicializar NotificationService
    _notificationService.init(); // Chamar init do NotificationService
    _initPedometer();
    _resetLife();
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    setState(() {
      int steps = event.steps;
      _stepCountValue = steps.toString().padLeft(4, '0');
      if (steps > _previousSteps) {
        _increaseLife();
      }
      _previousSteps = steps;
    });
  }

  void _onStepCountError(error) {
    print('Step Count Error: $error');
  }

  void _resetLife() {
    _lifeTimer?.cancel();
    setState(() {
      _lifeBar = 100;
    });

    _lifeTimer = Timer.periodic(Duration(days: 1), (timer) {
      setState(() {
        _decreaseLife();
      });
    });
  }

  void _increaseLife() {
    setState(() {
      _lifeBar = (_lifeBar + 10).clamp(0, 100);
    });
  }

  void _decreaseLife() {
    setState(() {
      _lifeBar = (_lifeBar - 5).clamp(0, 100);
      if (_lifeBar <= 50) {
        _notificationService.showNotification("O teu pet precisa de exercício", "A vida da tua chita está abaixo de 50%"); // Enviar notificação
      }
      if (_lifeBar <= 0) {
        _lifeTimer?.cancel();
        _showDeathMessage();
      }
    });
  }

  void _showDeathMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("A Chita Faleceu"),
          content: Text("A chita morreu por falta de atividade."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _resetLife();
              },
            ),
          ],
        );
      },
    );
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
          Positioned(
            top: 65,
            left: 50,
            child: _buildLifeBar(),
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

  Widget _buildLifeBar() {
    return Column(
      children: [
        Container(
          width: 20,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 20,
                height: (100 * _lifeBar / 100).clamp(0, 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _lifeBar > 30 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
