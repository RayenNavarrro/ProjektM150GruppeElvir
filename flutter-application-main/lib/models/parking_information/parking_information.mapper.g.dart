import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';
import 'package:equatable/src/equatable.dart';

import 'availability.dart';
import 'car_park.dart';
import 'price.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  CarParkMapper._(),
  EquatableMapper._(),
  AvailabilityMapper._(),
  PriceMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class CarParkMapper extends BaseMapper<CarPark> {
  CarParkMapper._();

  @override Function get decoder => decode;
  CarPark decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  CarPark fromMap(Map<String, dynamic> map) => CarPark(id: Mapper.i.$get(map, 'id'), plsId: Mapper.i.$get(map, 'plsId'), name: Mapper.i.$get(map, 'name'), currentAvailability: Mapper.i.$get(map, 'currentAvailability'), paymentOptions: Mapper.i.$get(map, 'paymentOptions'), openingHours: Mapper.i.$get(map, 'openingHours'), prices: Mapper.i.$get(map, 'prices'));

  @override Function get encoder => (CarPark v) => encode(v);
  dynamic encode(CarPark v) => toMap(v);
  Map<String, dynamic> toMap(CarPark c) => {'id': Mapper.i.$enc(c.id, 'id'), 'plsId': Mapper.i.$enc(c.plsId, 'plsId'), 'name': Mapper.i.$enc(c.name, 'name'), 'currentAvailability': Mapper.i.$enc(c.currentAvailability, 'currentAvailability'), 'paymentOptions': Mapper.i.$enc(c.paymentOptions, 'paymentOptions'), 'openingHours': Mapper.i.$enc(c.openingHours, 'openingHours'), 'prices': Mapper.i.$enc(c.prices, 'prices')};

  @override String stringify(CarPark self) => 'CarPark(id: ${Mapper.asString(self.id)}, plsId: ${Mapper.asString(self.plsId)}, name: ${Mapper.asString(self.name)}, currentAvailability: ${Mapper.asString(self.currentAvailability)}, paymentOptions: ${Mapper.asString(self.paymentOptions)}, openingHours: ${Mapper.asString(self.openingHours)}, prices: ${Mapper.asString(self.prices)})';
  @override int hash(CarPark self) => Mapper.hash(self.id) ^ Mapper.hash(self.plsId) ^ Mapper.hash(self.name) ^ Mapper.hash(self.currentAvailability) ^ Mapper.hash(self.paymentOptions) ^ Mapper.hash(self.openingHours) ^ Mapper.hash(self.prices);
  @override bool equals(CarPark self, CarPark other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.plsId, other.plsId) && Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.currentAvailability, other.currentAvailability) && Mapper.isEqual(self.paymentOptions, other.paymentOptions) && Mapper.isEqual(self.openingHours, other.openingHours) && Mapper.isEqual(self.prices, other.prices);

  @override Function get typeFactory => (f) => f<CarPark>();
}

extension CarParkMapperExtension  on CarPark {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  CarParkCopyWith<CarPark> get copyWith => CarParkCopyWith(this, $identity);
}

abstract class CarParkCopyWith<$R> {
  factory CarParkCopyWith(CarPark value, Then<CarPark, $R> then) = _CarParkCopyWithImpl<$R>;
  AvailabilityCopyWith<$R> get currentAvailability;
  ListCopyWith<$R, Price, PriceCopyWith<$R>> get prices;
  $R call({String? id, int? plsId, String? name, Availability? currentAvailability, List<String>? paymentOptions, List<String>? openingHours, List<Price>? prices});
  $R apply(CarPark Function(CarPark) transform);
}

class _CarParkCopyWithImpl<$R> extends BaseCopyWith<CarPark, $R> implements CarParkCopyWith<$R> {
  _CarParkCopyWithImpl(CarPark value, Then<CarPark, $R> then) : super(value, then);

  @override AvailabilityCopyWith<$R> get currentAvailability => AvailabilityCopyWith($value.currentAvailability, (v) => call(currentAvailability: v));
  @override ListCopyWith<$R, Price, PriceCopyWith<$R>> get prices => ListCopyWith($value.prices, (v, t) => PriceCopyWith(v, t), (v) => call(prices: v));
  @override $R call({String? id, int? plsId, String? name, Availability? currentAvailability, List<String>? paymentOptions, List<String>? openingHours, List<Price>? prices}) => $then(CarPark(id: id ?? $value.id, plsId: plsId ?? $value.plsId, name: name ?? $value.name, currentAvailability: currentAvailability ?? $value.currentAvailability, paymentOptions: paymentOptions ?? $value.paymentOptions, openingHours: openingHours ?? $value.openingHours, prices: prices ?? $value.prices));
}

class EquatableMapper extends BaseMapper<Equatable> {
  EquatableMapper._();

  @override Function get decoder => decode;
  Equatable decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Equatable fromMap(Map<String, dynamic> map) => throw MapperException.missingConstructor('Equatable');

  @override Function get encoder => (Equatable v) => encode(v);
  dynamic encode(Equatable v) {
    if (v is CarPark) { return CarParkMapper._().encode(v); }
    else if (v is Availability) { return AvailabilityMapper._().encode(v); }
    else if (v is Price) { return PriceMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(Equatable e) => {};

  @override String stringify(Equatable self) => 'Equatable()';
  @override int hash(Equatable self) => 0;
  @override bool equals(Equatable self, Equatable other) => true;

  @override Function get typeFactory => (f) => f<Equatable>();
}

extension EquatableMapperExtension  on Equatable {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class AvailabilityMapper extends BaseMapper<Availability> {
  AvailabilityMapper._();

  @override Function get decoder => decode;
  Availability decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Availability fromMap(Map<String, dynamic> map) => Availability(id: Mapper.i.$get(map, 'id'), status: Mapper.i.$get(map, 'status'), free: Mapper.i.$get(map, 'free'), moment: Mapper.i.$get(map, 'moment'));

  @override Function get encoder => (Availability v) => encode(v);
  dynamic encode(Availability v) => toMap(v);
  Map<String, dynamic> toMap(Availability a) => {'id': Mapper.i.$enc(a.id, 'id'), 'status': Mapper.i.$enc(a.status, 'status'), 'free': Mapper.i.$enc(a.free, 'free'), 'moment': Mapper.i.$enc(a.moment, 'moment')};

  @override String stringify(Availability self) => 'Availability(id: ${Mapper.asString(self.id)}, status: ${Mapper.asString(self.status)}, free: ${Mapper.asString(self.free)}, moment: ${Mapper.asString(self.moment)})';
  @override int hash(Availability self) => Mapper.hash(self.id) ^ Mapper.hash(self.status) ^ Mapper.hash(self.free) ^ Mapper.hash(self.moment);
  @override bool equals(Availability self, Availability other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.status, other.status) && Mapper.isEqual(self.free, other.free) && Mapper.isEqual(self.moment, other.moment);

  @override Function get typeFactory => (f) => f<Availability>();
}

extension AvailabilityMapperExtension  on Availability {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  AvailabilityCopyWith<Availability> get copyWith => AvailabilityCopyWith(this, $identity);
}

abstract class AvailabilityCopyWith<$R> {
  factory AvailabilityCopyWith(Availability value, Then<Availability, $R> then) = _AvailabilityCopyWithImpl<$R>;
  $R call({String? id, String? status, int? free, DateTime? moment});
  $R apply(Availability Function(Availability) transform);
}

class _AvailabilityCopyWithImpl<$R> extends BaseCopyWith<Availability, $R> implements AvailabilityCopyWith<$R> {
  _AvailabilityCopyWithImpl(Availability value, Then<Availability, $R> then) : super(value, then);

  @override $R call({String? id, String? status, int? free, DateTime? moment}) => $then(Availability(id: id ?? $value.id, status: status ?? $value.status, free: free ?? $value.free, moment: moment ?? $value.moment));
}

class PriceMapper extends BaseMapper<Price> {
  PriceMapper._();

  @override Function get decoder => decode;
  Price decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Price fromMap(Map<String, dynamic> map) => Price(parkingDuration: Mapper.i.$get(map, 'parkingDuration'), amount: Mapper.i.$get(map, 'amount'));

  @override Function get encoder => (Price v) => encode(v);
  dynamic encode(Price v) => toMap(v);
  Map<String, dynamic> toMap(Price p) => {'parkingDuration': Mapper.i.$enc(p.parkingDuration, 'parkingDuration'), 'amount': Mapper.i.$enc(p.amount, 'amount')};

  @override String stringify(Price self) => 'Price(parkingDuration: ${Mapper.asString(self.parkingDuration)}, amount: ${Mapper.asString(self.amount)})';
  @override int hash(Price self) => Mapper.hash(self.parkingDuration) ^ Mapper.hash(self.amount);
  @override bool equals(Price self, Price other) => Mapper.isEqual(self.parkingDuration, other.parkingDuration) && Mapper.isEqual(self.amount, other.amount);

  @override Function get typeFactory => (f) => f<Price>();
}

extension PriceMapperExtension  on Price {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  PriceCopyWith<Price> get copyWith => PriceCopyWith(this, $identity);
}

abstract class PriceCopyWith<$R> {
  factory PriceCopyWith(Price value, Then<Price, $R> then) = _PriceCopyWithImpl<$R>;
  $R call({String? parkingDuration, double? amount});
  $R apply(Price Function(Price) transform);
}

class _PriceCopyWithImpl<$R> extends BaseCopyWith<Price, $R> implements PriceCopyWith<$R> {
  _PriceCopyWithImpl(Price value, Then<Price, $R> then) : super(value, then);

  @override $R call({String? parkingDuration, double? amount}) => $then(Price(parkingDuration: parkingDuration ?? $value.parkingDuration, amount: amount ?? $value.amount));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===

class Mapper {
  Mapper._();

  static MapperContainer i = MapperContainer(_mappers);

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) => i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue(dynamic value) => i.toValue(value);
  static Map<String, dynamic> toMap(dynamic object) => i.toMap(object);
  static Iterable<dynamic> toIterable(dynamic object) => i.toIterable(object);
  static String toJson(dynamic object) => i.toJson(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

mixin Mappable implements MappableMixin {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override
  String toString() {
    return _guard(() => Mapper.asString(this), super.toString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            _guard(() => Mapper.isEqual(this, other), () => super == other));
  }

  @override
  int get hashCode {
    return _guard(() => Mapper.hash(this), () => super.hashCode);
  }

  T _guard<T>(T Function() fn, T Function() fallback) {
    try {
      return fn();
    } on MapperException catch (e) {
      if (e.isUnsupportedOrUnallowed()) {
        return fallback();
      } else {
        rethrow;
      }
    }
  }
}
