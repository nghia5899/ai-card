import 'dart:convert';
import 'package:ai_ecard/models/token/token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final storage = new FlutterSecureStorage();
  static TokenObj? tokenObj;

  static Future setTokenObj(TokenObj token) async {
    await storage.write(key: 'token', value: jsonEncode(token));
    tokenObj = token;
  }

  static Future<TokenObj?> getTokenObj() async {
    try {
      if (tokenObj?.accessToken == null || tokenObj?.accessToken == '') {
        String? token = await storage.read(key: 'token');
        if (token == null || token == '') {
          return null;
        }
        Map<String, dynamic> map = jsonDecode(token);
        tokenObj = TokenObj.fromJson(map);
        return tokenObj;
      } else {
        return tokenObj;
      }
    } catch (e) {
      return null;
    }
  }

  static Future removeToken() async {
    tokenObj = null;
    await storage.delete(key: 'token');
  }

  static Future saveFirebaseToken(String token) async {
    await storage.write(key: 'FirebaseToken', value: token);
  }

  static Future removeFirebaseToken() async {
    await storage.delete(key: 'FirebaseToken');
  }

  static Future<String?> getFirebaseToken() async {
    try {
      return await storage.read(key: 'FirebaseToken');
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getEmail() async {
    try {
      return (await storage.read(key: 'email'));
    } catch (e) {
      return null;
    }
  }

  static Future<void> setPassWallet(String password) async {
    try {
      await storage.write(key: 'password', value: password);
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> getPasswordWallet() async {
    String? password = await storage.read(key: 'password');
    return password;
  }

  // static Future<void> setCurrentWallet(String walletId) async {
  //   try {
  //     await storage.write(key: 'walletId', value: walletId);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String> getCurrentWallet() async {
  //   String? walletId = await storage.read(key: 'walletId');
  //   return walletId ?? '';
  // }
  //
  // static Future<void> setWallets(String wallets) async {
  //   try {
  //     await storage.write(key: 'wallets', value: wallets);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String> getWallets() async {
  //   final storage = new FlutterSecureStorage();
  //   String? wallets = await storage.read(key: 'wallets');
  //   return wallets ?? '[]';
  // }
  //
  // static Future<void> setCurrencies(String currencies) async {
  //   try {
  //     await storage.write(key: 'currencies', value: currencies);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String> getCurrencies() async {
  //   final storage = new FlutterSecureStorage();
  //   String? currencies = await storage.read(key: 'currencies');
  //   return currencies ?? '[]';
  // }
  //
  // static Future<void> setCurrentCoin(String coin) async {
  //   try {
  //     await storage.write(key: 'currentCoin', value: coin);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String?> getCurrentCoin() async {
  //   final storage = new FlutterSecureStorage();
  //   String? currentCoin = await storage.read(key: 'currentCoin');
  //   return currentCoin;
  // }
  //
  // static Future<void> setCurrentType(String coin) async {
  //   try {
  //     await storage.write(key: 'currentType', value: coin);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String?> getCurrentType() async {
  //   final storage = new FlutterSecureStorage();
  //   String? currentType = await storage.read(key: 'currentType');
  //   return currentType;
  // }
  //
  // static Future<void> setMnemonic(String mnemonic) async {
  //   try {
  //     await storage.write(key: 'mnemonic', value: mnemonic);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String> getMnemonic() async {
  //   final storage = new FlutterSecureStorage();
  //   String? mnemonic = await storage.read(key: 'mnemonic');
  //   return mnemonic ?? '';
  // }
  //
  // static Future<void> setSeed(String seed) async {
  //   try {
  //     await storage.write(key: 'seed', value: seed);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future<String> getSeed() async {
  //   final storage = new FlutterSecureStorage();
  //   String? seed = await storage.read(key: 'seed');
  //   return seed ?? '';
  // }
  //
  // static Future<String> getChainId() async {
  //   final storage = new FlutterSecureStorage();
  //   String? chainId = await storage.read(key: 'chainId');
  //   return chainId ?? '';
  // }
  //
  // static Future<void> setChainId(int chainId) async {
  //   try {
  //     await storage.write(key: 'chainId', value: chainId.toString());
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static Future deleteAllSecure() async {
  //   try {
  //     await storage.delete(key: 'mnemonic');
  //     await storage.delete(key: 'seed');
  //     await storage.delete(key: 'walletId');
  //     await storage.delete(key: 'wallets');
  //     await storage.delete(key: 'currencies');
  //     await storage.delete(key: 'chainId');
  //     await storage.delete(key: 'password');
  //     await storage.delete(key: 'token');
  //     await storage.delete(key: 'currentType');
  //     await storage.delete(key: 'currentCoin');
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
