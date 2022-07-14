import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/modules/search/seaech_Screen.dart';
import 'package:newsapp/shard/Cubit/cubit.dart';
import 'package:newsapp/shard/Cubit/states.dart';
import 'package:newsapp/shard/components/component.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
    listener: (context, NewsStates state){},
    builder:(context, NewsStates state) {
      NewsCubit cubit = NewsCubit.get(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(
              "News App"
          ),
          // leading:  Builder(
          //   builder: (context) => IconButton(
          //     icon: Icon(Icons.menu_rounded),
          //     onPressed: () => Scaffold.of(context).openDrawer(),
          //   ),
          // ),
          actions: [
            IconButton(
                onPressed: (){
                  NavigateTo(context,Search_Screen());
                },
                icon:Icon(
                  Icons.search,
                ),
            ),
            IconButton(
              icon:Icon(
                Icons.brightness_4_outlined,
              ),
              onPressed: (){
                cubit.changeAppMode();
                if(NewsCubit.get(context).isDark) {
                  SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                          systemNavigationBarColor: HexColor('333739'),
                          systemNavigationBarIconBrightness: Brightness.light)
                  );
                }
                else{
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                          systemNavigationBarColor: Colors.white,
                          systemNavigationBarIconBrightness: Brightness.dark)
                  );
                }
              },
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          items: cubit.NavItem,
          onTap: (index){
            cubit.changeCurrentIndex(index);
          },

        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //   UserAccountsDrawerHeader(
        //   accountName: Text('Nasrallah hany'),
        //   accountEmail: Text('nn20202412@gmail.com'),
        //   currentAccountPicture: CircleAvatar(
        //     child: ClipOval(
        //       child: Image.network(
        //         'https://e7.pngegg.com/pngimages/416/62/png-clipart-anonymous-person-login-google-account-computer-icons-user-activity-miscellaneous-computer-thumbnail.png',
        //         fit: BoxFit.cover,
        //         width: 90,
        //         height: 90,
        //       ),
        //     ),
        //   ),
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //     image: DecorationImage(
        //         fit: BoxFit.fill,
        //         image: NetworkImage(
        //             'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
        //     ),
        //   ),
        // ),
        //       ListTile(
        //         leading: Icon(Icons.favorite),
        //         title: Text('Favorites'),
        //         onTap: () => null,
        //       ),
        //       SwitchListTile(
        //           value: false,
        //           onChanged: (value){}
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.person),
        //         title: Text('Friends'),
        //         onTap: () => null,
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.share),
        //         title: Text('Share'),
        //         onTap: () => null,
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.notifications),
        //         title: Text('Request'),
        //       ),
        //       Divider(),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context)=>Settings_Screen())
        //           );
        //
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.description),
        //         title: Text('Policies'),
        //         onTap: () => null,
        //       ),
        //       Divider(),
        //       ListTile(
        //         title: Text('Exit'),
        //         leading: Icon(Icons.exit_to_app),
        //         onTap: () => null,
        //       ),
        //     ],
        //   ),
        // ),
      );
    }
    );
  }
}
