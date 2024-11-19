import 'package:flutter/material.dart';
import 'package:perpus/pages/bookpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hero Image
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(
                    'assets/rezky aib 2.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Title with Gradient Effect
            Text(
              'Perpustakaan Digital',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.blue, Colors.teal],
                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              'Temukan dan eksplorasi koleksi buku kami',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 40),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bookpage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Jelajahi Buku',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
