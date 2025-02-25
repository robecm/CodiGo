import 'package:flutter/material.dart';

class Module1Screen extends StatefulWidget {
  const Module1Screen({super.key});

  @override
  Module1ScreenState createState() => Module1ScreenState();
}

class Module1ScreenState extends State<Module1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo 1 - Bits'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                onPressed: () {},
                shape: const CircleBorder(),
                child: Text('1', style: TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                onPressed: () {},
                shape: const CircleBorder(),
                child: Text('2', style: TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                onPressed: () {},
                shape: const CircleBorder(),
                child: Text('3', style: TextStyle(fontSize: 40)),
              ),
            ),
          ],
        ),
      )
    );
  }
}