abstract class ILocalProvider {
  Future<void> saveToken(String token);

  Future<String?> readToken();

  Future<void> deleteToken();
}
