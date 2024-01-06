import 'package:flutter/material.dart';
import 'package:media_app/utilities/Music.dart';
import 'package:media_app/utilities/video.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [pick_video(), Music_page()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.cyan,
            icon: Icon(Icons.video_collection),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(Icons.music_note),
            label: 'Music',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        // do something here
      ),
    );
  }
}
