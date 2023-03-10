class Generate{
  dynamic data;
  Generate({this.data});
  Generate.fromJson(dynamic json) {
    data = json;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'data: $data';
  }
}