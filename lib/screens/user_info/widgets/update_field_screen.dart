import 'package:ctware/configs/colors.dart';
import 'package:flutter/material.dart';

class UpdateFieldScreen extends StatefulWidget {
  final String fieldName;
  final String appbarTitle;
  final String fieldTitle;
  final IconData icon;
  final Function() onSubmit;

  const UpdateFieldScreen({
    super.key,
    required this.appbarTitle,
    required this.fieldName,
    required this.fieldTitle,
    required this.icon,
    required this.onSubmit,
  });

  @override
  _UpdateFieldScreenState createState() => _UpdateFieldScreenState();
}

class _UpdateFieldScreenState extends State<UpdateFieldScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appbarTitle,
          style: const TextStyle(color: AppColors.txtWhite),
        ),
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.txtWhite,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/LoginScreen.png'),
            fit: BoxFit.fill, 
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.fieldTitle,
                style: const TextStyle(color: AppColors.txtPrimary, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Nhập ${widget.fieldName} của bạn",
                  prefixIcon: Icon(
                    widget.icon,
                    color: AppColors.bgPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.bgGrey,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: widget.onSubmit,
                    child: const Text(
                      "Tiếp tục",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
