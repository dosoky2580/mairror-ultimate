import 'package:dio/dio.dart';

class TranslationService {
  static Future<String> translate(String text) async {
    try {
      // هنا ممكن نستخدم API مجاني أو تجريبي لتمشية الحال في الـ Debug
      return "ترجمة (Adham-AI): $text"; 
    } catch (e) {
      return "عذراً تامر، حدث خطأ في الاتصال";
    }
  }
}
