import 'package:fixmyclass/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../HexColorCode/HexColor.dart';
import '../../strings.dart';
import '../RegisterStudentPage/RegisterStudentPage.dart';


class LoginStudentPage extends StatefulWidget {
  const LoginStudentPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginStudentPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final Dio _dio = Dio(); // Initialize Dio
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  List loginStudent = []; // Declare a list to hold API data


  // Future<void> _login() async {
  //   if (!_formKey.currentState!.validate()) return;
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final response = await _dio.post(
  //       ApiRoutes.login,
  //       data: {
  //         'email': _emailController.text,
  //         'password': _passwordController.text,
  //       },
  //       options: Options(
  //         headers: {'Content-Type': 'application/json'},
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = response.data; // FIX: No need to decode
  //
  //       if (jsonResponse['success'] == true) {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('studentList', jsonEncode(jsonResponse['students']));
  //         setState(() {
  //           loginStudent = jsonResponse['students']; // Update state with fetched data
  //           _isLoading = false;
  //           print('Login Student: $loginStudent');
  //         });
  //
  //         // Navigate to the bottom navigation screen
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => LoginStudentPage(),
  //           ),
  //         );
  //       } else {
  //         print('${AppStrings.loginFailedDebug}${jsonResponse['message']}');
  //         _showErrorDialog(jsonResponse['message']);
  //       }
  //     } else {
  //       print('${AppStrings.loginFailedMessage} ${response.statusCode}');
  //       _showErrorDialog(AppStrings.loginFailedMessage);
  //     }
  //   } on DioException catch (e) {
  //     String errorMessage = AppStrings.unexpectedError;
  //     if (e.response != null && e.response?.data is Map<String, dynamic>) {
  //       errorMessage = e.response?.data['message'] ?? errorMessage;
  //     } else if (e.response?.data is String) {
  //       errorMessage = e.response?.data;
  //     }
  //
  //     _showErrorDialog(errorMessage);
  //   } catch (e) {
  //     print('${AppStrings.generalErrorDebug}$e');
  //     _showErrorDialog(AppStrings.unexpectedError);
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  //
  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text(AppStrings.loginFailedTitle),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.20,
                  width: double.infinity,
                  child: Image.asset('assets/login_top.png',fit: BoxFit.fill,color: HexColor('#1a434e'),)),

              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.15,
                  child: Image.asset('assets/login_bottom.png',fit: BoxFit.fill,color: HexColor('#1a434e'),)),

            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding:  EdgeInsets.all(12.sp),
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(10),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black26,
                    //       blurRadius: 10,
                    //       offset: const Offset(0, 4),
                    //     ),
                    //   ],
                    // ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [


                          Column(
                            children: [
                              SizedBox(
                                height: 140.sp,
                                width: 140.sp,
                                child: Image.asset(
                                  'assets/student2.png',
                                ),
                              ),
                              // const SizedBox(height: 5),
                              Text(
                                'Fix My Class'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18.sp,



                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.sp),


                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                CupertinoIcons.mail_solid,
                                color: Colors.black, // आइकन का रंग बेहतर किया गया
                              ),
                              hintText: AppStrings.email,
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12), // बॉर्डर को अधिक स्मूथ किया
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue, width: 2), // अधिक स्पष्ट फोकस बॉर्डर
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade400),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12), // बेहतर padding
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.invalidEmail;
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return AppStrings.invalidEmail;
                              }
                              return null;
                            },

                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 15),

                          // Password Input
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                CupertinoIcons.padlock_solid,
                                color: Colors.black, // आइकन का रंग बेहतर किया गया
                              ),
                              hintText: AppStrings.password,
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye_solid,
                                  color: Colors.black, // आँख का आइकन भी स्टाइलिश बनाया गया
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12), // बॉर्डर को अधिक स्मूथ किया
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue, width: 2), // अधिक स्पष्ट फोकस बॉर्डर
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade400),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12), // बेहतर padding
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.passwordRequired;
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the forgot password screen or perform an action
                                  print("Forgot Password clicked");
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.redAccent, decoration: TextDecoration.none),
                                ),
                              )
                            ],
                          ),

                          Row(
                            children: [

                              CupertinoSwitch (
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                                activeColor: AppColors.primary,
                              ),
                              const Text(AppStrings.rememberMe),
                            ],
                          ),
                          SizedBox(height: 20.sp),
                          if (_isLoading) const CircularProgressIndicator() else  Padding(
                            padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                            child: CustomLoginButton(onPressed: () {

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BottomNavigationPage(),
                              //   ),
                              // );

                              // _login();
                            }, title: 'Login'.toUpperCase(),),
                          ),
                          SizedBox(height: 20.sp,),

                          Text.rich(TextSpan(
                            text: "Don't have an account? ",
                            style:  TextStyle(
                                color: Colors.black, fontSize: 11.sp),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Register here",
                                  style:  TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterStudentPage(),
                                        ),
                                      );

                                    }),
                            ],
                          )),



                        ],
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }
}




class CustomLoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  const CustomLoginButton({super.key, required this.onPressed, required this.title});

  @override
  _CustomLoginButtonState createState() => _CustomLoginButtonState();
}

class _CustomLoginButtonState extends State<CustomLoginButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() => isPressed = false);
        });
        widget.onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 40.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: isPressed
                ? [ AppColors.primary, AppColors.primary,]
                : [ AppColors.primary, AppColors.primary,],
          ),
          boxShadow: isPressed
              ? []
              : [
            BoxShadow(
              color: HexColor('#3a1e0d').withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${widget.title}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fade(duration: 500.ms),
        ),
      ),
    );
  }
}

// Usage Example:
// CustomLoginButton(onPressed: () {
//   print("Login Clicked!");
// });
