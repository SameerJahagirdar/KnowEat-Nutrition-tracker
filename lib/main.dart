import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/addmeal.dart';
import '/pages/meal_list.dart';
import '/pages/home.dart';
import '/services/listofmeals.dart';
import '/services/mealpreference.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await MealPref.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create : (_)=> ListOfMeals())
    ],
    child: MaterialApp(
      home: MainPage(),
      routes:  {
        '/addmeal' : (context) => AddMeal(),
        '/meallist':(context) => MealList(),
        '/home' : (context) => Home(),
      },
    ),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final List<Widget> _pages=[
    Home(),
    MealList()
  ];

  late PageController pageController;

  void initState(){
    super.initState();
    pageController = PageController();
  }

  void dispose(){
    pageController.dispose();
    super.dispose();
  }
  int selectedindex=0;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KnowEat',
        style: TextStyle(
          fontSize: 25.0,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.red,
      ),
      body: PageView(
        children: _pages,
        controller: pageController,
        onPageChanged: (index){
          setState((){
            selectedindex=index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items:const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
          label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage),
            label: 'Meals'
        )
      ],
      currentIndex: selectedindex,
        onTap: (index) {
        setState(() {
          selectedindex = index;
        });
        pageController.jumpToPage(index);
        },
      ),
     );
     }
  }



