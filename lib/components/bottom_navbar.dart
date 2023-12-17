import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/screens/build_meal.dart';
import '../screens/bar_chart_sample2.dart';
import '../screens/home.dart';
import '../screens/my_recipe.dart';
import '../screens/pie.dart';
import '../screens/recipe_add.dart';


class BottomTabBar extends StatefulWidget {
  BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0); //Page Controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index){
              //_pageController.animateToPage(index, duration: Duration(microseconds: 1000), curve: Curves.ease);
              setState(() {
                _pageController.animateToPage(index, duration: Duration(microseconds: 400000), curve: Curves.ease);
                _currentIndex = index;
              });
            },
            children : const [
              Home(),
              RecipeAdd(),
              MyRecipe(),
              BuildMeal(),
            ]
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color.fromARGB(255, 246, 197, 0),
            unselectedItemColor: Color.fromARGB(255, 173, 0, 0),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                // _pageController.animateToPage(index, duration: Duration(microseconds: 400000), curve: Curves.ease);
                _pageController.jumpToPage(index);
                // _pageController.jumpToPage(index);
                // _currentIndex = index;
              });
            },
            backgroundColor: Color.fromARGB(255, 0, 2, 49),
            items:const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, size: 20, color: Color.fromARGB(
                    255, 255, 255, 255)),
                activeIcon: Icon(Icons.home_filled, size: 20, color: Color.fromARGB(255, 246, 197, 0)),
                label: 'Home', backgroundColor: Color.fromARGB(255, 0, 11, 75)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_rounded, size: 20, color: Color.fromARGB(
                    255, 255, 255, 255)),
                activeIcon: Icon(Icons.newspaper_rounded, size: 20, color: Color.fromARGB(255, 246, 197, 0)),
                label: 'Add Recipe', backgroundColor:Color.fromARGB(255, 0, 11, 75)
              ),BottomNavigationBarItem(
                icon: Icon(Icons.photo_camera_front_rounded, size: 20, color: Color.fromARGB(
                    255, 255, 255, 255)),
                activeIcon: Icon(Icons.photo_camera_front_rounded, size: 20, color: Color.fromARGB(255, 246, 197, 0)),
                label: 'My Recipe', backgroundColor: Color.fromARGB(255, 0, 11, 75)
              ),BottomNavigationBarItem(
                icon: Icon(Icons.photo_camera_front_rounded, size: 20, color: Color.fromARGB(
                    255, 255, 255, 255)),
                activeIcon: Icon(Icons.photo_camera_front_rounded, size: 20, color: Color.fromARGB(255, 246, 197, 0)),
                label: 'Build Meal', backgroundColor: Color.fromARGB(255, 0, 11, 75)
              )
            ]
        )
    );
  }
}