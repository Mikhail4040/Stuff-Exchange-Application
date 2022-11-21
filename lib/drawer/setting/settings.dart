import 'package:finalproject/drawer/ContactUs.dart';
import 'package:finalproject/drawer/setting/modifyUserInfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:provider/provider.dart';
import "/backend/myProvider.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:toast/toast.dart';
class Settings extends StatefulWidget {
  var userId;
  var userInd;
  Settings({required this.userId, required this.userInd});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var isDark=false;
  var isDark1;
  // ThemeData darkTheme=ThemeData(
  //   accentColor: Colors.red,
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.amber,
  //
  // );
  //
  // ThemeData lightTheme = ThemeData(
  //     accentColor: Colors.pink,
  //     brightness: Brightness.light,
  //     primaryColor: Colors.blue
  // );
  @override
  Widget build(BuildContext context) {
    var userInfo=Provider.of<MyProvider>(context);
    userInfo.fetchData();
    var userImg=userInfo.Data[widget.userInd].userImage;
    var userFirstName=userInfo.Data[widget.userInd].firstName;
    isDark1=userInfo.Data[widget.userInd].isDarkMode;
    isDark=userInfo.Data[widget.userInd].isDarkMode=="true"?true:false;

    return  Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // User card
              BigUserCard(
                cardColor: Colors.red,
                userName: userFirstName,
                userProfilePic: AssetImage('assets/images/setting.png'),
                cardActionWidget: SettingsItem(
                  icons: Icons.edit,
                  iconStyle: IconStyle(
                    withBackground: true,
                    borderRadius: 50,
                    backgroundColor: Colors.yellow[600],
                  ),
                  title: "Modify",
                  subtitle: "Tap to change your data",
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return ModifyUserInfo(userId: widget.userId,userInd: widget.userInd,);
                        })
                    );
                  },
                ),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Dark mode',
                    subtitle: "Automatic",
                    trailing: Switch.adaptive(
                      value: isDark,
                      onChanged: (value)async {
                        setState(() {
                          isDark=value;
                          if(isDark==true)
                            isDark1="true";
                          else
                            isDark1="false";
                        });
                        await userInfo.updatedarkMode(widget.userId,isDark1 );

                      },
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return ContactUss();
                      }));
                    },
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'send a feedback',
                    subtitle: "for a better experience",
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: () async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      setState(() {
                         pref.remove('id');
                         pref.remove('ind');
                      });
                      MotionToast.warning(
                        title: const Text(
                          'Done',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        description: const Text('You are logged out'),
                        animationCurve: Curves.bounceIn,
                        borderRadius: 0,
                        animationDuration: const Duration(milliseconds: 1000),
                      ).show(context);

                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),

                ],
              ),
              Text("Version: 0.1"),
            ],
          ),
        ),
      );
  }
}
