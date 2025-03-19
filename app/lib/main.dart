import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  final List<Widget> _pages = [ProfilePage(), TrainPage(), QuestLogPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fitness RPG")),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ChatDialog(),
          );
        },
        child: Icon(Icons.chat),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Train'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Quest Log'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User XP: 1200", style: TextStyle(fontSize: 20)),
          Text("Height: 185 cm", style: TextStyle(fontSize: 18)),
          Text("Weight: 75 kg", style: TextStyle(fontSize: 18)),
          Text("Body Fat: 15%", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class TrainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Training Programs Here", style: TextStyle(fontSize: 24)),
    );
  }
}

class QuestLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Quest Log - Track Progress Here", style: TextStyle(fontSize: 24)),
    );
  }
}

class ChatDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("AI Chat"),
      content: Text("Chat with AI here..."),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
      ],
    );
  }
}
