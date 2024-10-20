import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

extension ShowingDialog on Dialog {
  static comfirmDialog(
    BuildContext context, {
    required String message,
    required Function()? yesEvent,
    String? cancelBtnText,
    String? confirmBtnText,
    bool showCancelBtn = true,
  }) {
    QuickAlert.show(
        onConfirmBtnTap: yesEvent,
        barrierDismissible: false,
        context: context,
        cancelBtnTextStyle: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 142, 140, 140),
            fontWeight: FontWeight.bold),
        confirmBtnTextStyle: const TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        type: QuickAlertType.warning,
        title: '',
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        width: Responsive.width(60, context),
        showCancelBtn: showCancelBtn,
        cancelBtnText: cancelBtnText ?? 'Hủy',
        confirmBtnText: confirmBtnText ?? 'Đồng ý',
        text: message);
  }

  static errorDialog(
    BuildContext context, {
    Function()? onConfirmBtnTapErr,
    String? confirmBtnText,
    required String errMes,
    required String title,
  }) {
    QuickAlert.show(
        width: Responsive.width(70, context),
        context: context,
        barrierDismissible: true,
        type: QuickAlertType.error,
        onConfirmBtnTap: onConfirmBtnTapErr,
        confirmBtnText: confirmBtnText ?? 'Đóng',
        confirmBtnColor: Colors.red,
        title: title,
        text: errMes);
  }

  static loadingDialog(context,
      {String? text, bool barrierDismissible = false}) {
    QuickAlert.show(
        width: Responsive.width(60, context),
        barrierDismissible: barrierDismissible,
        context: context,
        type: QuickAlertType.loading,
        widget: barrierDismissible
            ? const SizedBox()
            : const PopScope(
                canPop: false,
                child: SizedBox(),
              ),
        text: text ?? 'Vui lòng chờ');
  }

  static successDialog(context,
      {Function()? onConfirmBtnTap,
      String? confirmBtnText,
      String? title,
      required String message}) {
    QuickAlert.show(
        width: Responsive.width(60, context),
        onConfirmBtnTap: onConfirmBtnTap,
        context: context,
        type: QuickAlertType.success,
        barrierDismissible: false,
        title: title,
        widget: const PopScope(
          canPop: false,
          child: SizedBox(),
        ),
        confirmBtnText: confirmBtnText ?? 'Đóng',
        text: message);
  }
}
