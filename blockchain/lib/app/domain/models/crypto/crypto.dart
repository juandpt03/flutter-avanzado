import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto.freezed.dart';
part 'crypto.g.dart';

class Cryptos {
  final List<Crypto> cryptos;

  Cryptos({
    required this.cryptos,
  });

  factory Cryptos.fromJson(Map<String, dynamic> json) => Cryptos(
        cryptos: json['data'].map<Crypto>((x) => Crypto.fromJson(x)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': cryptos.map((x) => x.toJson()).toList(),
      };
}

@Freezed()
class Crypto with _$Crypto {
  factory Crypto({
    required String id,
    required String rank,
    required String symbol,
    required String name,
    required String supply,
    required String maxSupply,
    required String marketCapUsd,
    required String volumeUsd24Hr,
    required String priceUsd,
    required String changePercent24Hr,
    required String vwap24Hr,
    required String explorer,
  }) = _Crypto;

  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        id: json['id'] ?? '',
        rank: json['rank'] ?? '',
        symbol: json['symbol'] ?? '',
        name: json['name'] ?? '',
        supply: json['supply'] ?? '',
        maxSupply: json['maxSupply'] ?? '',
        marketCapUsd: json['marketCapUsd'] ?? '',
        volumeUsd24Hr: json['volumeUsd24Hr'] ?? '',
        priceUsd: json['priceUsd'] ?? '',
        changePercent24Hr: json['changePercent24Hr'] ?? '',
        vwap24Hr: json['vwap24Hr'] ?? '',
        explorer: json['explorer'] ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'rank': rank,
        'symbol': symbol,
        'name': name,
        'supply': supply,
        'maxSupply': maxSupply,
        'marketCapUsd': marketCapUsd,
        'volumeUsd24Hr': volumeUsd24Hr,
        'priceUsd': priceUsd,
        'changePercent24Hr': changePercent24Hr,
        'vwap24Hr': vwap24Hr,
        'explorer': explorer,
      };
}
