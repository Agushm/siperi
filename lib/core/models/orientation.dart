part of 'models.dart';

class OrientationPainful {
  OrientationPainful({
    required this.p,
    required this.q,
    required this.r,
    required this.s,
    required this.t,
    required this.management,
  });
  late final String p;
  late final String q;
  late final String r;
  late final String s;
  late final String t;
  late final String management;

  OrientationPainful.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    q = json['q'];
    r = json['r'];
    s = json['s'];
    t = json['t'];
    management = json['management'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['p'] = p;
    _data['q'] = q;
    _data['r'] = r;
    _data['s'] = s;
    _data['t'] = t;
    _data['management'] = management;
    return _data;
  }
}
