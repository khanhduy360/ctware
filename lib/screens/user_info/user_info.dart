import 'package:cached_network_image/cached_network_image.dart';
import 'package:ctware/configs/Colors.dart';
import 'package:ctware/screens/user_info/widgets/support_row.dart';
import 'package:ctware/screens/user_info/widgets/change_password_screen.dart';
import 'package:ctware/screens/user_info/widgets/update_user_info_screen.dart';
import 'package:ctware/screens/user_info/widgets/user_info_header.dart';
import 'package:ctware/screens/user_info/widgets/update_field_screen.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/section_title.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  // Wigget _initUpdateUserInfoField(BuildContext context,
  //     {String title, String fieldName, Function()? update}) {
  //       return InkWell(
  //         onTap: ,
  //       );
  //     }

  // Widget _initScreen(BuildContext context, News item) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const UserInfoActionList()),
  //       );
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
  //       decoration: BoxStyle.fromBoxDecoration(radius: 10),
  //       padding: const EdgeInsets.all(10),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CachedNetworkImage(
  //             placeholder: (context, url) => const Center(
  //                 child: SizedBox(
  //                     height: 50,
  //                     width: 50,
  //                     child: CircularProgressIndicator())),
  //             imageUrl: item.Image ?? '',
  //             height: 90,
  //             width: 120,
  //             fit: BoxFit.fill,
  //           ),
  //           Expanded(
  //               child: Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   item.Title ?? '',
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(color: Colors.blue, fontSize: 18),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 2),
  //                   child: Text(item.Description ?? '',
  //                       maxLines: 3,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: const TextStyle(fontSize: 15)),
  //                 ),
  //               ],
  //             ),
  //           )),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                              indent: 8, // Độ dài cách từ trái
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
                              indent: 8, // Độ dài cách từ trái
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
                              indent: 8, // Độ dài cách từ trái
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
                            indent: 8, // Độ dài cách từ trái
                            endIndent: 8,
                          ),
                          SupportRow(
                              leftTitle: 'Zalo: ',
                              rightTitle: 'CANTHOWASSCO OA Page',
                              icon: 'assets/icons/zalo-icon.png'),
                          Divider(
                            thickness: .3,
                            indent: 8, // Độ dài cách từ trái
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
                              indent: 8, // Độ dài cách từ trái
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
