class AppConstants {
  AppConstants._();

  static const String appName = 'Cryptor';

  // API URLs
  static const String binanceApiBaseUrl = 'https://api.binance.com/api/v3';
  static const String newsApiBaseUrl =
      'https://cryptopanic.com/api/v1'; // Assuming CryptoPanic

  // Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUsername = 'username';
  static const String keyUserEmail = 'user_email';

  // Format patterns
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm:ss';

  // Featured Symbols (USDT Pairs)
  static const List<String> featuredSymbols = [
    'BTCUSDT',
    'ETHUSDT',
    'BNBUSDT',
    'XRPUSDT',
    'ADAUSDT',
    'SOLUSDT',
    'DOGEUSDT',
    'TONUSDT',
    'AVAXUSDT',
    'DOTUSDT',
    'TRXUSDT',
    'NEARUSDT',
    'ATOMUSDT',
    'APTUSDT',
    'SUIUSDT',
    'HBARUSDT',
    'ICPUSDT',
    'ALGOUSDT',
    'UNIUSDT',
    'AAVEUSDT',
    'MKRUSDT',
    'CRVUSDT',
    'CAKEUSDT',
    'COMPUSDT',
    'SUSHIUSDT',
    'DYDXUSDT',
    'YFIUSDT',
    'LDOUSDT',
    'MATICUSDT',
    'OPUSDT',
    'ARBUSDT',
    'IMXUSDT',
    'LRCUSDT',
    'STRKUSDT',
    'MNTUSDT',
    'ZKUSDT',
    'METISUSDT',
    'CELRUSDT',
    'SHIBUSDT',
    'PEPEUSDT',
    'FLOKIUSDT',
    'BONKUSDT',
    'WIFUSDT',
    'BABYDOGEUSDT',
    'MEMEUSDT',
    'MOGUSDT',
    'TURBOUSDT',
    'RENDERUSDT',
    'FETUSDT',
    'NMRUSDT',
    'CTXCUSDT',
    'ARKMUSDT',
    'GLMUSDT',
    'TAOUSDT',
    'WLDUSDT',
    'AXSUSDT',
    'SANDUSDT',
    'MANAUSDT',
    'GALAUSDT',
    'ENJUSDT',
    'ILVUSDT',
    'RONINUSDT',
    'MAGICUSDT',
    'BEAMUSDT',
    'PYRUSDT',
    'LINKUSDT',
    'FILUSDT',
    'ARUSDT',
    'THETAUSDT',
    'HNTUSDT',
    'LPTUSDT',
    'STORJUSDT',
    'SCUSDT',
    'ANKRUSDT',
    'SNTUSDT',
    'LTCUSDT',
    'XMRUSDT',
    'XLMUSDT',
    'VETUSDT',
    'EOSUSDT',
    'XTZUSDT',
    'ZECUSDT',
    'DASHUSDT',
    'ONEUSDT',
    'CHZUSDT',
    'TFUELUSDT',
    'ONTUSDT',
    'QTUMUSDT',
    'NEXOUSDT',
    'KASUSDT',
  ];

  // Top Market Leaders
  static const List<String> marketLeaders = [
    'BTCUSDT',
    'ETHUSDT',
    'BNBUSDT',
    'XRPUSDT',
    'ADAUSDT',
    'SOLUSDT',
    'DOGEUSDT',
    'TONUSDT',
  ];
}
