enum Environment{
  dev,
  test,
  pro
}

class AppEnvironment {
  static late Map<String, dynamic> _config;
  static String get baseUrl =>  _config['API_URL'] ?? '';

  static void setAppEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Config.debugConstants;
        break;
      case Environment.test:
        _config = _Config.testConstants;
        break;
      case Environment.pro:
        _config = _Config.prodConstants;
        break;
      default:
        _config = _Config.debugConstants;
    }
  }

  static get apiUrl {
    return _config[_Config.API_URL];
  }
  static get messageUrl {
    return _config[_Config.MESSAGE_URL];
  }
  static get clientId {
    return _config[_Config.CLIENT_ID];
  }
  static get redirectUrl {
    return _config[_Config.REDIRECT_URL];
  }
  static get networkType {
    return _config[_Config.NETWORK_TYPE];
  }

  static get gameApiUrl {
    return _config[_Config.GAME_API];
  }

}

class _Config {
  // ignore: constant_identifier_names
  static const API_URL = 'API_URL';
  static const MESSAGE_URL = 'MESSAGE_URL';
  static const CLIENT_ID = 'saas-app';
  static const REDIRECT_URL = 'http://localhost:8000/login';
  static const NETWORK_TYPE = 'NETWORK_TYPE';
  static const GAME_API = 'GAME_API';

  static Map<String, dynamic> debugConstants = {
    API_URL: 'http://34.142.171.165:9000/v1',
    MESSAGE_URL: 'http://34.142.197.247:8888/saas/api',
    CLIENT_ID: 'saas-app',
    REDIRECT_URL: 'saas://success',
    // NETWORK_TYPE: NetworkType.TESTNET,
    GAME_API: 'https://gamecenter.icu/api/v1'
  };

  static Map<String, dynamic> testConstants = {
    API_URL: 'http://34.142.197.247:8080/saas/api/v1',
    MESSAGE_URL: 'http://34.142.197.247:8888/saas/api',
    CLIENT_ID: 'saas-app',
    REDIRECT_URL: 'saas://success',
    // NETWORK_TYPE: NetworkType.TESTNET,
    GAME_API: 'https://gamecenter.icu/api/v1'
  };

  static Map<String, dynamic> prodConstants = {
    API_URL: 'http://34.142.197.247:8080/saas/api/v1',
    MESSAGE_URL: 'http://34.142.197.247:8888/saas/api',
    CLIENT_ID: 'saas-app',
    REDIRECT_URL: 'saas://success',
    // NETWORK_TYPE: NetworkType.MAINNET,
    GAME_API: 'https://gamecenter.icu/api/v1'
  };
}