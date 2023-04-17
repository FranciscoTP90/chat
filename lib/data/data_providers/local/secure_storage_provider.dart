import 'package:chat_app/data/data_providers/local/i_local_data_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageProvider implements ILocalProvider {
  SecureStorageProvider({required FlutterSecureStorage storage})
      : _storage = const FlutterSecureStorage();
  final FlutterSecureStorage _storage;

  @override
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'token', value: token);
    } catch (e) {
      throw Exception('msg: Error al guardar token');
    }
  }

  @override
  Future<String?> readToken() async {
    try {
      // Read value
      String? token = await _storage.read(key: 'token');
      return token;
    } catch (e) {
      throw Exception('msg: Error al obtener token');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'token');
    } catch (e) {
      throw Exception('msg: Error al borrar token');
    }
  }
}
