import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart';

class SecureSecrets {
  static const _storage = FlutterSecureStorage();
  static final _key = Key.fromSecureRandom(32);
  static final _encrypter = Encrypter(AES(_key));

  static Future<String> getEncryptedApiKey(String service) async {
    String? encryptedKey = await _storage.read(key: service);
    if (encryptedKey == null) return "";
    return _encrypter.decrypt64(encryptedKey);
  }
}
