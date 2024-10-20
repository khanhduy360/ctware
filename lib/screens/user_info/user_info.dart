import 'package:ctware/configs/Colors.dart';
import 'package:ctware/screens/user_info/widgets/support_row.dart';
import 'package:ctware/screens/user_info/widgets/change_password_screen.dart';
import 'package:ctware/screens/user_info/widgets/user_info_header.dart';
import 'package:ctware/screens/user_info/widgets/update_field_screen.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';

import 'widgets/section_title.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Thông tin người dùng',
        backAction: false,
        body: SingleChildScrollView(
            child: Container(
                color: AppColors.bgLight,
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserInfoHeader(),
                      const SectionTitle(title: "Quản lý tài khoản"),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: AppColors.bgWhite,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Quản lý Hóa đơn'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {},
                            ),
                            const Divider(
                              thickness: .3,
                              indent: 8,
                              endIndent: 8,
                            ),
                            ListTile(
                              title: const Text('Đổi mật khẩu'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdatePasswordScreen(),
                                    ));
                              },
                            ),
                            const Divider(
                              thickness: .3,
                              indent: 8,
                              endIndent: 8,
                            ),
                            ListTile(
                              title: const Text('Cập nhật Email'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateFieldScreen(
                                        appbarTitle: 'Cập nhật Email',
                                        fieldName: 'Email',
                                        fieldTitle: 'Nhập Email',
                                        icon: Icons.email,
                                        onSubmit: () {},
                                      ),
                                    ));
                              },
                            ),
                            const Divider(
                              thickness: .3,
                              indent: 8,
                              endIndent: 8,
                            ),
                            ListTile(
                              title: const Text('Nhập số điện thoại'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateFieldScreen(
                                          appbarTitle: 'Số điện thoại',
                                          fieldName: 'Số điện thoại',
                                          fieldTitle: 'Nhập số điện thoại',
                                          icon: Icons.phone,
                                          onSubmit: () => {}),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                      const SectionTitle(title: 'Hỗ trợ'),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: AppColors.bgWhite,
                        child: const Column(children: [
                          SupportRow(
                            leftTitle: 'Email: ',
                            rightTitle: 'ctncantho@gmail.com',
                            icon: 'assets/icons/gmail-icon.png',
                          ),
                          Divider(
                            thickness: .3,
                            indent: 8,
                            endIndent: 8,
                          ),
                          SupportRow(
                              leftTitle: 'Zalo: ',
                              rightTitle: 'CANTHOWASSCO OA Page',
                              icon: 'assets/icons/zalo-icon.png'),
                          Divider(
                            thickness: .3,
                            indent: 8,
                            endIndent: 8,
                          ),
                          SupportRow(
                              leftTitle: 'Facebook: ',
                              rightTitle: 'CANTHOWASSCO Fanpage',
                              icon: 'assets/icons/fb-icon.png'),
                        ]),
                      ),
                      const SectionTitle(title: 'Giới thiệu'),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: AppColors.bgWhite,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Về CTWCare'),
                              onTap: () {},
                            ),
                            const Divider(
                              thickness: .3,
                              indent: 8,
                              endIndent: 8,
                            ),
                            ListTile(
                              title: const Text('Điều khoản sử dụng'),
                              onTap: () {},
                            ),
                          ],
                        ),
                      )
                    ]))));
  }
}
