import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightPrimaryColor,
      appBar: AppBar(
        title: Text("Netflix"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: Color(0xFF141414),
            ),
            SizedBox(
              height: 80,
            ),
            TextFormField(
              decoration: InputDecoration(
                  filled: true, fillColor: AppTheme.lightPrimaryVarientColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "This is the first text field",
              style: TextStyle(color: AppTheme.lightOnSecondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
