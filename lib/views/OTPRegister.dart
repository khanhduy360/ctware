import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPRegister extends StatefulWidget {
  @override
  _OTPRegisterState createState() => _OTPRegisterState();
}

class _OTPRegisterState extends State<OTPRegister> {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();

  FocusNode otpFocusNode1 = FocusNode();
  FocusNode otpFocusNode2 = FocusNode();
  FocusNode otpFocusNode3 = FocusNode();
  FocusNode otpFocusNode4 = FocusNode();
  FocusNode otpFocusNode5 = FocusNode();
  FocusNode otpFocusNode6 = FocusNode();

  Timer? _timer;
  int _start = 60;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(otpFocusNode1);
      setState(() {
        _isInit = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _otpFocusNodeListener() {
    if (otpFocusNode1.hasFocus) {
      _focusNextInputField(context, otpFocusNode1, otpFocusNode2);
    } else if (otpFocusNode2.hasFocus) {
      _focusNextInputField(context, otpFocusNode2, otpFocusNode3);
    } else if (otpFocusNode3.hasFocus) {
      _focusNextInputField(context, otpFocusNode3, otpFocusNode4);
    } else if (otpFocusNode4.hasFocus) {
      _focusNextInputField(context, otpFocusNode4, otpFocusNode5);
    } else if (otpFocusNode5.hasFocus) {
      _focusNextInputField(context, otpFocusNode5, otpFocusNode6);
    }
  }

  void _focusNextInputField(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/LoginScreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Xác thực OTP',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ProductSans',
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Nhập OTP mà bạn đã nhận được qua email:',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'ProductSans',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'nkduy@ctu.edu.vn',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      FocusTraversalGroup(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildOTPTextField(
                                otpController1, otpFocusNode1, otpFocusNode2),
                            SizedBox(width: 10),
                            buildOTPTextField(
                                otpController2, otpFocusNode2, otpFocusNode3),
                            SizedBox(width: 10),
                            buildOTPTextField(
                                otpController3, otpFocusNode3, otpFocusNode4),
                            SizedBox(width: 10),
                            buildOTPTextField(
                                otpController4, otpFocusNode4, otpFocusNode5),
                            SizedBox(width: 10),
                            buildOTPTextField(
                                otpController5, otpFocusNode5, otpFocusNode6),
                            SizedBox(width: 10),
                            buildOTPTextField(
                                otpController6, otpFocusNode6, null),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Thời gian còn lại: $_start',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Xác thực OTP ở đây
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          minimumSize: Size(double.infinity, 50),
                          side: BorderSide(color: Colors.blue, width: 2),
                        ),
                        child: Text(
                          'Xác thực',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOTPTextField(TextEditingController controller,
      FocusNode focusNode, FocusNode? nextFocusNode) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (_isInit && value.length == 1 && nextFocusNode != null) {
            _focusNextInputField(context, focusNode, nextFocusNode);
          }
        },
        decoration: InputDecoration(
          counter: Offstage(),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
