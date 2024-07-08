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

class Crypto {
  final String id;
  final String rank;
  final String symbol;
  final String name;
  final String supply;
  final String maxSupply;
  final String marketCapUsd;
  final String volumeUsd24Hr;
  final String priceUsd;
  final String changePercent24Hr;
  final String vwap24Hr;
  final String explorer;

  Crypto({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.supply,
    required this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.changePercent24Hr,
    required this.vwap24Hr,
    required this.explorer,
  });

  Crypto copyWith({
    String? id,
    String? rank,
    String? symbol,
    String? name,
    String? supply,
    String? maxSupply,
    String? marketCapUsd,
    String? volumeUsd24Hr,
    String? priceUsd,
    String? changePercent24Hr,
    String? vwap24Hr,
    String? explorer,
  }) =>
      Crypto(
        id: id ?? this.id,
        rank: rank ?? this.rank,
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        supply: supply ?? this.supply,
        maxSupply: maxSupply ?? this.maxSupply,
        marketCapUsd: marketCapUsd ?? this.marketCapUsd,
        volumeUsd24Hr: volumeUsd24Hr ?? this.volumeUsd24Hr,
        priceUsd: priceUsd ?? this.priceUsd,
        changePercent24Hr: changePercent24Hr ?? this.changePercent24Hr,
        vwap24Hr: vwap24Hr ?? this.vwap24Hr,
        explorer: explorer ?? this.explorer,
      );

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Crypto &&
        other.id == id &&
        other.rank == rank &&
        other.symbol == symbol &&
        other.name == name &&
        other.supply == supply &&
        other.maxSupply == maxSupply &&
        other.marketCapUsd == marketCapUsd &&
        other.volumeUsd24Hr == volumeUsd24Hr &&
        other.priceUsd == priceUsd &&
        other.changePercent24Hr == changePercent24Hr &&
        other.vwap24Hr == vwap24Hr &&
        other.explorer == explorer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rank.hashCode ^
        symbol.hashCode ^
        name.hashCode ^
        supply.hashCode ^
        maxSupply.hashCode ^
        marketCapUsd.hashCode ^
        volumeUsd24Hr.hashCode ^
        priceUsd.hashCode ^
        changePercent24Hr.hashCode ^
        vwap24Hr.hashCode ^
        explorer.hashCode;
  }
}
