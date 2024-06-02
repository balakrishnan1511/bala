import 'package:flutter/material.dart';


class servicedashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepOrange, Colors.red, Colors.deepPurple],
            stops: [0.15, 0.39, 0.95],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Text(
              'IT Support Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildGridButton(Icons.add, 'New Ticket'),
                  _buildGridButton(Icons.article, 'My Ticket'),
                  _buildGridButton(Icons.settings, 'Setting'),
                  _buildGridButton(Icons.help, 'FAQ'),
                  _buildGridButton(Icons.history, 'History'),
                  _buildGridButton(Icons.info, 'Info'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kpost Company\nIT Support Services (C) 2024',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGridButton(IconData icon, String label) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 48,
              color: Colors.orange,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}



