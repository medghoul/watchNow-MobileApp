import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../helpers/logger/logging.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String homeScreenRoute = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _current = 0;
  var _logLine = '';

  int get current => _current;
  String get logLine => _logLine;


  @override
  void initState() {
    super.initState();
    LoggingFactory.configure(
      LoggingConfiguration(
        isEnabled: true,
        shouldLogNetworkInfo: true,
        loggingLevel: Level.verbose,
        onLog: (logLine) {
          setState(() {
            _logLine = logLine;
          });
        },
      ),
    );
    logger.i('HomeScreen init');

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            logger.d('On pressed ${logLine}');
            Navigator.pushNamed(context, '/tv_shows');
          },
          child: const Text('Go to Tv Shows Screen'),
        ),
      ),
    );
  }
}


