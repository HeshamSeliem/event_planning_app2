import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/provider/bottomNavProvider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/add%20event/add_event_screen.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/home_tab.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/lovedTab/love_tab.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/mapTab/map_tab.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/profile_tab.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String routeName = "/";

  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = Provider.of<Bottomnavprovider>(context);
    return Scaffold(
      body: tabs[bottomNavProvider.selectedIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).colorScheme.primary
          ),
          child: BottomNavigationBar(
            
           // type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavProvider.selectedIndex,
            onTap: (index) {
              bottomNavProvider.changeIndex(index);
            },
            //showUnselectedLabels: true,
            items: [
              // home icon
              buildBottomNavItems(
                unSelectedimagePath: AssetManager.homeIcon,
                selectedimagePath: AssetManager.homeSelectedIcon,
                labelString: AppLocalizations.of(context)!.home,
                index: 0,
                context: context,
              ),
              // map icon
              buildBottomNavItems(
                unSelectedimagePath: AssetManager.unSelectedMap,
                selectedimagePath: AssetManager.selectedMap,
                labelString: AppLocalizations.of(context)!.map,
                index: 1,
                context: context,
              ),
              // love icon
              buildBottomNavItems(
                unSelectedimagePath: AssetManager.unSelectedLove,
                selectedimagePath: AssetManager.selectedLove,
                labelString: AppLocalizations.of(context)!.love,
                index: 2,
                context: context,
              ),
              // profile icon
              buildBottomNavItems(
                unSelectedimagePath: AssetManager.unSelectedProfile,
                selectedimagePath: AssetManager.selectedprofile,
                labelString: AppLocalizations.of(context)!.profile,
                index: 3,
                context: context,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          //mini: true,
          onPressed: () {
            // add event here
            //navigate to create screen
            Navigator.pushNamed(context, AddEventScreen.routeName);
          },
          child: Icon(Icons.add, color: AppColors.whiteColors, size: 25),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem buildBottomNavItems({
    required String unSelectedimagePath,
    required String selectedimagePath,
    required String labelString,
    required int index,
    required BuildContext context,
  }) {
    var bottomNavProvider = context.watch<Bottomnavprovider>();
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          bottomNavProvider.selectedIndex == index
              ? selectedimagePath
              : unSelectedimagePath,
        ),
        color: AppColors.whiteColors,
      ),
      label: labelString,
    );
  }
}
