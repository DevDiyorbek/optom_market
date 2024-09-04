import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }

  Future<void> saveUserData({
    required String firstName,
    required String phoneNumber,
    required String username,
    required String? lastName,
    required String image,
  }) async {
    await write('first_name', firstName);
    await write('phone_number', phoneNumber);
    await write('username', username ?? '');
    await write('last_name', lastName ?? '');
    await write('image', image ?? '');
  }

  Future<Map<String, String?>> readUserData() async {
    final firstName = await read('first_name');
    final phoneNumber = await read('phone_number');
    final username = await read('username');
    final lastName = await read('last_name');
    final image = await read('image');

    return {
      'first_name': firstName,
      'phone_number': phoneNumber,
      'username': username,
      'last_name': lastName,
      'image': image,
    };
  }
}
