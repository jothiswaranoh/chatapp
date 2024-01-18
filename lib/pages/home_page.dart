import 'package:groupchat/components/carouselbody.dart';
import 'package:groupchat/components/my_drawer.dart';
import 'package:groupchat/variables/app_colors.dart';
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
        drawer:MyDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Group chat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  // Add other styles as needed
                ),
              ),
            ),
          ),
          CarouselBody(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Chats",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  // Add other styles as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
