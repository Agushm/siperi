part of 'models.dart';

class OrientationPainful {
  OrientationPainful({
    required this.userId,
    required this.p,
    required this.q,
    required this.r,
    required this.s,
    required this.t,
    required this.management,
    required this.ketManagement,
    required this.createdAt,
    required this.release,
  });
  late final String userId;
  late final String p;
  late final String q;
  late final String r;
  late final double s;
  late final String t;
  late final String management;
  late final String ketManagement;
  late final DateTime createdAt;
  late final DateTime release;

  OrientationPainful.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    p = json['p'];
    q = json['q'];
    r = json['r'];
    s = json['s'];
    t = json['t'];
    management = json['management'];
    ketManagement = json['ketManagement'];
    createdAt = DateTime.parse(json['createdAt']);
    release = DateTime.parse(json['release']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['p'] = p;
    _data['q'] = q;
    _data['r'] = r;
    _data['s'] = s;
    _data['t'] = t;
    _data['management'] = management;
    _data['ketManagement'] = ketManagement;
    _data['createdAt'] = createdAt.toIso8601String();
    _data['release'] = release.toIso8601String();
    return _data;
  }
}

int getMinuteRelease(double s) {
  if (s == 123) {
    return 2;
  } else if (s >= 1 && s < 4) {
    return 8 * 60;
  } else if (s >= 4 && s < 7) {
    return 4 * 60;
  } else if (s >= 7 && s < 10) {
    return 60;
  } else {
    return 0;
  }
}
