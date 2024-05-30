import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/homeScreen/widgets/cards_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CardsPage();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currIndex = index;
          });
        },
        currentIndex: currIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
