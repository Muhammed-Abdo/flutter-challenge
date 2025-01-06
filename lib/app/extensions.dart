import 'package:flutter_challenge/app/constants.dart';

extension NonNullString on String? {
  String notNull() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double notNull() {
    if (this == null) {
      return Constants.zeroDouble;
    } else {
      return this!;
    }
  }
}

extension NonNullBool on bool? {
  bool notNull() {
    if (this == null) {
      return Constants.falseBool;
    } else {
      return this!;
    }
  }
}

extension NonNullList<T> on List<T>? {
  List<T> notNull() {
    if (this == null) {
      return [];
    } else {
      return this!;
    }
  }
}

extension NonNullDateTime on String? {
  DateTime orNow() {
    if (this == null) {
      return DateTime.now();
    } else {
      try {
        return DateTime.parse(this!);
      } catch (_) {
        return DateTime.now();
      }
    }
  }
}
