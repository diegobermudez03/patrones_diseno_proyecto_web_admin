import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:tuple/tuple.dart';
import 'package:web_admin/core/menu_navigator/widgets/main_navigator.dart';
import 'package:web_admin/core/strings/app_strings.dart';


class MainPage extends StatefulWidget{
  final List<Tuple4<int, String, String, Icon>> pages = const [
    Tuple4(1, AppStrings.manPage, "/mainPage", Icon(Icons.event)),
    Tuple4(2, AppStrings.events, "/events", Icon(Icons.event)),
  ];

  const MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _isNavigating = false; // Add this to track navigation status
  int selected = 0; //this variable keeps track of the option selected in the menu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            builder: (data) => SideMenuData(
              header: const Text(AppStrings.menuHeader),
              items: widget.pages.map(
                (e) => SideMenuItemDataTile(
                  isSelected: selected == e.item1, 
                  onTap: ()=> _navigateTo(e.item3),
                  title: e.item2,
                  icon: e.item4,
                )
              ).toList(),
              footer: const Text(AppStrings.menuFooter)
            )
          ),
          Expanded(
            child: MainNavigator(_navigatorKey)
          )
        ],
      ),
    );
  }

    //Function to navigate
  void _navigateTo(String routeName) async {
    if (!_isNavigating && _navigatorKey.currentState != null) {
        _isNavigating = true;
         await _navigatorKey.currentState!.pushNamed(routeName);
        _isNavigating = false;
    }
  }
}

