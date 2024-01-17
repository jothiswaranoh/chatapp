import 'package:chatui/components/carouselbody.dart';
import 'package:chatui/variables/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor:
            AppColors.mainBackground, // Match the Scaffold background color
        leading: IconButton(
          icon: Icon(Icons.chat), // Replace with your app logo
          onPressed: () {
            // Add your logic here for the logo button press if needed
          },
        ),
        title: const Text(
          'Chating App',
          style: TextStyle(color: AppColors.white),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(36.0), // Adjust the height as needed
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:Column(
          children: [
            const SizedBox(height: 20),
            CarouselBody(),
          ],
      ),
    );
  }
}
