import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quack_app/constants/constants.dart';
import 'package:quack_app/core/menu_data.dart';
import 'package:quack_app/screens/settings/subscreens/about_screen.dart';
import 'package:quack_app/screens/settings/subscreens/account_prefrences_screen.dart';
import 'package:quack_app/screens/settings/subscreens/food_prefrences_screen.dart';
import 'package:quack_app/screens/settings/subscreens/help_and_support_screen.dart';
import 'package:quack_app/screens/settings/subscreens/notifications_prefrences_screen.dart';
import 'package:quack_app/screens/settings/subscreens/your_calendar_screen.dart';

// Settings screen implements the screen for the settings page
class SettingsScreen extends StatefulWidget {
  final String title;
  const SettingsScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late MenuData menuData;
  final TextStyle _style = const TextStyle(color: Colors.black, fontSize: 24);
  final AutoSizeGroup _group = AutoSizeGroup();
  @override
  void initState() {
    // Re-cache updated values on view
    super.initState();
    menuData = MenuData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                color: Constants.kBackgroundGrey,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: <Widget>[
                    _getTile(
                        context, //
                        "Food Prefrences", //
                        Icons.food_bank_outlined, //
                        const FoodPrefrencesScreen()), //
                    _getTile(
                        context,
                        "Notification Prefrences",
                        Icons.notifications_active_outlined,
                        const NotificationsPrefrencesScreen()),
                    _getTile(
                        context,
                        "Your Calendar",
                        Icons.calendar_today_outlined,
                        const YourCalendarScreen()),
                    _getTile(
                        context,
                        "Account Prefrences",
                        Icons.account_circle_outlined,
                        const AccountPrefrencesScreen()),
                    _getTile(
                        context, //
                        "Help and Support",
                        Icons.help_outline_outlined,
                        const HelpSupportScreen()),
                    _getTile(
                        context, //
                        "About Quack App",
                        Icons.accessibility_outlined,
                        const AboutScreen())
                  ]),
                )),
          )
        ],
      ),
    );
  }

  // Get the Tile for each page
  // title - the text for the tile
  // icon - the icon to display before the title
  // screen - the Screen to route to after tap
  Widget _getTile(BuildContext context, String title, IconData icon,
      StatefulWidget screen) {
    return ListTile(
        onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => screen))
            },
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Container(
                decoration:
                    const BoxDecoration(border: Border(bottom: BorderSide())),
                child: AutoSizeText(
                  title,
                  style: _style,
                  group: _group,
                ))
          ],
        ));
  }
}
