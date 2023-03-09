class TokenObj {
  String? accessToken;

  String? refreshToken;

  TokenObj({required this.accessToken, required this.refreshToken});

  factory TokenObj.fromJson(Map<String, dynamic> json) {
    return TokenObj(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => _$TokenObjToJson(this);

  Map<String, dynamic> _$TokenObjToJson(TokenObj instance) {
    return {
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
  }

  @override
  String toString() {
    return 'TokenObj{accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}
