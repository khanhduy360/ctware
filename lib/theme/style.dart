import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

extension BoxStyle on BoxDecoration {
  static BoxDecoration fromBoxDecoration(
      {double? radius,
      Color? color,
      bool isShadow = true,
      Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(radius ?? 0),
      gradient: gradient,
      boxShadow: isShadow
          ? [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
              ),
            ]
          : null,
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class Responsive {
  /*
    height: Responsive.height(50, context) => 50% height of device
    width: Responsive.width(100, context) => 100% width of device
  */
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

// Tạo extension cho String để chuyển đổi Base64 thành Image widget
extension ImageFromBase64 on String {
  static Widget toImage(String string, {fit = BoxFit.fill}) {
    // Giải mã chuỗi Base64 thành Uint8List
    Uint8List bytes = base64Decode(string);

    // Hiển thị hình ảnh từ Uint8List
    return Image.memory(bytes, fit: fit,);
  }
}