import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/color.dart';
import '../../../Utils/string.dart';
import '../../Login/Login/login.dart';



class AdminBottomNavigationBarScreen extends StatefulWidget {
  const AdminBottomNavigationBarScreen({super.key});

  @override
  State<AdminBottomNavigationBarScreen> createState() => _HomePageState();
}

class _HomePageState extends State<AdminBottomNavigationBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selected = 0;
  final controller = PageController();







  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40.sp,
              child: Image.asset('assets/calling_text.gif'),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.sp),
            bottomRight: Radius.circular(20.sp),
          ),
        ),
        leading: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ),
        actions: [

        ],
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        height: 70.sp,
        child: CustomBottomNavBar(
          currentIndex: selected,
          onTap: (index) {
            controller.jumpToPage(index);
            setState(() => selected = index);
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(), // 👈 Swipe disable
          children: [
          //   const IVRCallScreen(),
          //   const IVRCallScreen(),
          //   const HelplineScreen(),
          //   const SOSScreen(),
           ],
        ),
      ),
    );
  }
}
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'StudentHome'},
      {'icon': Icons.phone, 'label': 'IVR Call'},
      {'icon': Icons.qr_code_scanner, 'label': 'Scan QR'},
      {'icon': Icons.contact_phone, 'label': 'Helplines'},
      {'icon': Icons.sos, 'label': 'SOS'},
    ];

    return Container(
      color: Colors.grey.shade200,
      child: BottomAppBar(
        color: AppColors.navyBlue,
        // replace with AppColors.navyBlue if you have it
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.sp,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;

            return GestureDetector(
              onTap: () => onTap(index),
              child: SizedBox(
                height: 70.sp, // ✅ height bhi responsive
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 2) ...[
                      SizedBox(height: 28.sp), // sirf FAB ke liye empty gap
                    ] else ...[
                      Icon(
                        items[index]['icon'] as IconData,
                        color: isSelected ? Colors.white : Colors.grey,
                        size: isSelected ? 25.sp : 21.sp,
                      ),
                      SizedBox(height: 2.sp), // responsive gap
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}










class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Use a subtle, light background
      backgroundColor: AppColors.lightGray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(0.0)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 20.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black,size: 25.sp,),
                    onPressed: () {
                      Navigator.pop(context); // Drawer band karega
                    },
                  ),
                ],
              ),
            ),

            // Header
            _buildHeader(),
            Divider(
              thickness: 2.sp,
              color: Colors.grey.shade300,
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                children: [
                  _buildListTile(
                    context: context,
                    icon: Icons.person,
                    title: 'Profile',
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context)=> ProfileScreen()));
                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.qr_code,
                    title: 'Activate New QR Sticker',
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => QRActive()));

                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.shop,
                    title: 'My Orders/Products',
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => OrderHistoryScreen()));

                    },
                  ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.share,
                  //   title: 'Share Tap',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.account_balance_wallet,
                  //   title: 'Wallet',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.touch_app,
                  //   title: 'Active/Deactive QR',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.block,
                  //   title: 'Block A Number',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.bookmark,
                  //   title: 'My Story',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.call,
                  //   title: 'Call Log',
                  //   onTap: () {},
                  // ),
                  _buildListTile(
                    context: context,
                    icon: Icons.notifications,
                    title: 'Notification',
                    onTap: () {},
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.policy,
                    title: 'Terms & Policy',
                    onTap: () {},
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.description,
                    title: 'Grievances',
                    onTap: () {},
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.bloodtype,
                    title: 'Blood Donation',
                    onTap: () {},
                  ),
              _buildListTile(
                context: context,
                icon: Icons.logout,
                title: 'Logout',
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear(); // ✅ Clear all stored data

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );

                },
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.sp,
            backgroundImage: const AssetImage('assets/playstore.png'),
            backgroundColor: AppColors.lightGray,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryBlue, width: 3.sp),
              ),
            ),
          ),
           SizedBox(height: 8.sp),
          Text(
            'Ravikant Saini',
            style: TextStyle(
              color: AppColors.navyBlue,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.sp),

        ],
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = AppColors.primaryBlue,
    Color iconColor = AppColors.primaryBlue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          // Add a splash color for a nice touch
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 12.sp,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color:  AppColors.navyBlue,
                  size: 24.sp,
                ),
                 SizedBox(width: 12.sp),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color:  AppColors.navyBlue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}