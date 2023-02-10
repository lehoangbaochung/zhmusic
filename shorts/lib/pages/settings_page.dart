import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Ngôn ngữ'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('Chủ đề'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
