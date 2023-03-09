import 'package:ai_ecard/models/parameters/base_params.dart';

class AccountModel extends BaseParameter{
  String username;
  String password;
  AccountModel(this.username, this.password);
  @override
  Map<String, dynamic> build() {
    params['username'] = username;
    params['password'] = password;
    return super.build();
  }
}