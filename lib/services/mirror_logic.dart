import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class MirrorLogic {
  // تفعيل النسخ
  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  // تفعيل المشاركة
  static void shareText(String text) {
    Share.share(text);
  }
}
