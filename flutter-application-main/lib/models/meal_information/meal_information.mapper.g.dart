import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';
import 'package:equatable/src/equatable.dart';

import 'day.dart';
import 'meal.dart';
import 'meal_icon.dart';
import 'nutritional_value.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  DayMapper._(),
  EquatableMapper._(),
  MealMapper._(),
  MealIconMapper._(),
  NutritionalValueMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class DayMapper extends BaseMapper<Day> {
  DayMapper._();

  @override Function get decoder => decode;
  Day decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Day fromMap(Map<String, dynamic> map) => Day(id: Mapper.i.$get(map, 'id'), date: Mapper.i.$get(map, 'date'), menus: Mapper.i.$get(map, 'menus'));

  @override Function get encoder => (Day v) => encode(v);
  dynamic encode(Day v) => toMap(v);
  Map<String, dynamic> toMap(Day d) => {'id': Mapper.i.$enc(d.id, 'id'), 'date': Mapper.i.$enc(d.date, 'date'), 'menus': Mapper.i.$enc(d.menus, 'menus')};

  @override String stringify(Day self) => 'Day(id: ${Mapper.asString(self.id)}, date: ${Mapper.asString(self.date)}, menus: ${Mapper.asString(self.menus)})';
  @override int hash(Day self) => Mapper.hash(self.id) ^ Mapper.hash(self.date) ^ Mapper.hash(self.menus);
  @override bool equals(Day self, Day other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.date, other.date) && Mapper.isEqual(self.menus, other.menus);

  @override Function get typeFactory => (f) => f<Day>();
}

extension DayMapperExtension  on Day {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  DayCopyWith<Day> get copyWith => DayCopyWith(this, $identity);
}

abstract class DayCopyWith<$R> {
  factory DayCopyWith(Day value, Then<Day, $R> then) = _DayCopyWithImpl<$R>;
  ListCopyWith<$R, Meal, MealCopyWith<$R>> get menus;
  $R call({String? id, DateTime? date, List<Meal>? menus});
  $R apply(Day Function(Day) transform);
}

class _DayCopyWithImpl<$R> extends BaseCopyWith<Day, $R> implements DayCopyWith<$R> {
  _DayCopyWithImpl(Day value, Then<Day, $R> then) : super(value, then);

  @override ListCopyWith<$R, Meal, MealCopyWith<$R>> get menus => ListCopyWith($value.menus, (v, t) => MealCopyWith(v, t), (v) => call(menus: v));
  @override $R call({String? id, DateTime? date, List<Meal>? menus}) => $then(Day(id: id ?? $value.id, date: date ?? $value.date, menus: menus ?? $value.menus));
}

class EquatableMapper extends BaseMapper<Equatable> {
  EquatableMapper._();

  @override Function get decoder => decode;
  Equatable decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Equatable fromMap(Map<String, dynamic> map) => throw MapperException.missingConstructor('Equatable');

  @override Function get encoder => (Equatable v) => encode(v);
  dynamic encode(Equatable v) {
    if (v is Day) { return DayMapper._().encode(v); }
    else if (v is Meal) { return MealMapper._().encode(v); }
    else if (v is MealIcon) { return MealIconMapper._().encode(v); }
    else if (v is NutritionalValue) { return NutritionalValueMapper._().encode(v); }
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

class MealMapper extends BaseMapper<Meal> {
  MealMapper._();

  @override Function get decoder => decode;
  Meal decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Meal fromMap(Map<String, dynamic> map) => Meal(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), priceInternal: Mapper.i.$getOpt(map, 'priceInternal') ?? 0.0, priceExternal: Mapper.i.$getOpt(map, 'priceExternal') ?? 0.0, menuComponents: Mapper.i.$get(map, 'menuComponents'), allergenes: Mapper.i.$get(map, 'allergenes'), balance: Mapper.i.$getOpt(map, 'balance'), environmentalImpact: Mapper.i.$getOpt(map, 'environmentalImpact'), additionalInformation: Mapper.i.$getOpt(map, 'additionalInformation') ?? const <String>[], nutritionalValues: Mapper.i.$get(map, 'nutritionalValues'), icons: Mapper.i.$getOpt(map, 'icons') ?? const <MealIcon>[]);

  @override Function get encoder => (Meal v) => encode(v);
  dynamic encode(Meal v) => toMap(v);
  Map<String, dynamic> toMap(Meal m) => {'id': Mapper.i.$enc(m.id, 'id'), 'title': Mapper.i.$enc(m.title, 'title'), 'priceInternal': Mapper.i.$enc(m.priceInternal, 'priceInternal'), 'priceExternal': Mapper.i.$enc(m.priceExternal, 'priceExternal'), 'menuComponents': Mapper.i.$enc(m.menuComponents, 'menuComponents'), 'allergenes': Mapper.i.$enc(m.allergenes, 'allergenes'), 'balance': Mapper.i.$enc(m.balance, 'balance'), 'environmentalImpact': Mapper.i.$enc(m.environmentalImpact, 'environmentalImpact'), 'additionalInformation': Mapper.i.$enc(m.additionalInformation, 'additionalInformation'), 'nutritionalValues': Mapper.i.$enc(m.nutritionalValues, 'nutritionalValues'), 'icons': Mapper.i.$enc(m.icons, 'icons')};

  @override String stringify(Meal self) => 'Meal(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, priceInternal: ${Mapper.asString(self.priceInternal)}, priceExternal: ${Mapper.asString(self.priceExternal)}, menuComponents: ${Mapper.asString(self.menuComponents)}, allergenes: ${Mapper.asString(self.allergenes)}, balance: ${Mapper.asString(self.balance)}, environmentalImpact: ${Mapper.asString(self.environmentalImpact)}, additionalInformation: ${Mapper.asString(self.additionalInformation)}, nutritionalValues: ${Mapper.asString(self.nutritionalValues)}, icons: ${Mapper.asString(self.icons)})';
  @override int hash(Meal self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.priceInternal) ^ Mapper.hash(self.priceExternal) ^ Mapper.hash(self.menuComponents) ^ Mapper.hash(self.allergenes) ^ Mapper.hash(self.balance) ^ Mapper.hash(self.environmentalImpact) ^ Mapper.hash(self.additionalInformation) ^ Mapper.hash(self.nutritionalValues) ^ Mapper.hash(self.icons);
  @override bool equals(Meal self, Meal other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.priceInternal, other.priceInternal) && Mapper.isEqual(self.priceExternal, other.priceExternal) && Mapper.isEqual(self.menuComponents, other.menuComponents) && Mapper.isEqual(self.allergenes, other.allergenes) && Mapper.isEqual(self.balance, other.balance) && Mapper.isEqual(self.environmentalImpact, other.environmentalImpact) && Mapper.isEqual(self.additionalInformation, other.additionalInformation) && Mapper.isEqual(self.nutritionalValues, other.nutritionalValues) && Mapper.isEqual(self.icons, other.icons);

  @override Function get typeFactory => (f) => f<Meal>();
}

extension MealMapperExtension  on Meal {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  MealCopyWith<Meal> get copyWith => MealCopyWith(this, $identity);
}

abstract class MealCopyWith<$R> {
  factory MealCopyWith(Meal value, Then<Meal, $R> then) = _MealCopyWithImpl<$R>;
  ListCopyWith<$R, NutritionalValue, NutritionalValueCopyWith<$R>> get nutritionalValues;
  ListCopyWith<$R, MealIcon, MealIconCopyWith<$R>> get icons;
  $R call({String? id, String? title, double? priceInternal, double? priceExternal, List<String>? menuComponents, List<String>? allergenes, String? balance, String? environmentalImpact, List<String>? additionalInformation, List<NutritionalValue>? nutritionalValues, List<MealIcon>? icons});
  $R apply(Meal Function(Meal) transform);
}

class _MealCopyWithImpl<$R> extends BaseCopyWith<Meal, $R> implements MealCopyWith<$R> {
  _MealCopyWithImpl(Meal value, Then<Meal, $R> then) : super(value, then);

  @override ListCopyWith<$R, NutritionalValue, NutritionalValueCopyWith<$R>> get nutritionalValues => ListCopyWith($value.nutritionalValues, (v, t) => NutritionalValueCopyWith(v, t), (v) => call(nutritionalValues: v));
  @override ListCopyWith<$R, MealIcon, MealIconCopyWith<$R>> get icons => ListCopyWith($value.icons, (v, t) => MealIconCopyWith(v, t), (v) => call(icons: v));
  @override $R call({String? id, String? title, double? priceInternal, double? priceExternal, List<String>? menuComponents, List<String>? allergenes, Object? balance = $none, Object? environmentalImpact = $none, List<String>? additionalInformation, List<NutritionalValue>? nutritionalValues, List<MealIcon>? icons}) => $then(Meal(id: id ?? $value.id, title: title ?? $value.title, priceInternal: priceInternal ?? $value.priceInternal, priceExternal: priceExternal ?? $value.priceExternal, menuComponents: menuComponents ?? $value.menuComponents, allergenes: allergenes ?? $value.allergenes, balance: or(balance, $value.balance), environmentalImpact: or(environmentalImpact, $value.environmentalImpact), additionalInformation: additionalInformation ?? $value.additionalInformation, nutritionalValues: nutritionalValues ?? $value.nutritionalValues, icons: icons ?? $value.icons));
}

class MealIconMapper extends BaseMapper<MealIcon> {
  MealIconMapper._();

  @override Function get decoder => decode;
  MealIcon decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  MealIcon fromMap(Map<String, dynamic> map) => MealIcon(id: Mapper.i.$get(map, 'id'), sourceUri: Mapper.i.$get(map, 'sourceUri'), altText: Mapper.i.$get(map, 'altText'));

  @override Function get encoder => (MealIcon v) => encode(v);
  dynamic encode(MealIcon v) => toMap(v);
  Map<String, dynamic> toMap(MealIcon m) => {'id': Mapper.i.$enc(m.id, 'id'), 'sourceUri': Mapper.i.$enc(m.sourceUri, 'sourceUri'), 'altText': Mapper.i.$enc(m.altText, 'altText')};

  @override String stringify(MealIcon self) => 'MealIcon(id: ${Mapper.asString(self.id)}, sourceUri: ${Mapper.asString(self.sourceUri)}, altText: ${Mapper.asString(self.altText)})';
  @override int hash(MealIcon self) => Mapper.hash(self.id) ^ Mapper.hash(self.sourceUri) ^ Mapper.hash(self.altText);
  @override bool equals(MealIcon self, MealIcon other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.sourceUri, other.sourceUri) && Mapper.isEqual(self.altText, other.altText);

  @override Function get typeFactory => (f) => f<MealIcon>();
}

extension MealIconMapperExtension  on MealIcon {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  MealIconCopyWith<MealIcon> get copyWith => MealIconCopyWith(this, $identity);
}

abstract class MealIconCopyWith<$R> {
  factory MealIconCopyWith(MealIcon value, Then<MealIcon, $R> then) = _MealIconCopyWithImpl<$R>;
  $R call({String? id, String? sourceUri, String? altText});
  $R apply(MealIcon Function(MealIcon) transform);
}

class _MealIconCopyWithImpl<$R> extends BaseCopyWith<MealIcon, $R> implements MealIconCopyWith<$R> {
  _MealIconCopyWithImpl(MealIcon value, Then<MealIcon, $R> then) : super(value, then);

  @override $R call({String? id, String? sourceUri, String? altText}) => $then(MealIcon(id: id ?? $value.id, sourceUri: sourceUri ?? $value.sourceUri, altText: altText ?? $value.altText));
}

class NutritionalValueMapper extends BaseMapper<NutritionalValue> {
  NutritionalValueMapper._();

  @override Function get decoder => decode;
  NutritionalValue decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  NutritionalValue fromMap(Map<String, dynamic> map) => NutritionalValue(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), value: Mapper.i.$get(map, 'value'), rowIndex: Mapper.i.$get(map, 'rowIndex'));

  @override Function get encoder => (NutritionalValue v) => encode(v);
  dynamic encode(NutritionalValue v) => toMap(v);
  Map<String, dynamic> toMap(NutritionalValue n) => {'id': Mapper.i.$enc(n.id, 'id'), 'title': Mapper.i.$enc(n.title, 'title'), 'value': Mapper.i.$enc(n.value, 'value'), 'rowIndex': Mapper.i.$enc(n.rowIndex, 'rowIndex')};

  @override String stringify(NutritionalValue self) => 'NutritionalValue(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, value: ${Mapper.asString(self.value)}, rowIndex: ${Mapper.asString(self.rowIndex)})';
  @override int hash(NutritionalValue self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.value) ^ Mapper.hash(self.rowIndex);
  @override bool equals(NutritionalValue self, NutritionalValue other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.value, other.value) && Mapper.isEqual(self.rowIndex, other.rowIndex);

  @override Function get typeFactory => (f) => f<NutritionalValue>();
}

extension NutritionalValueMapperExtension  on NutritionalValue {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  NutritionalValueCopyWith<NutritionalValue> get copyWith => NutritionalValueCopyWith(this, $identity);
}

abstract class NutritionalValueCopyWith<$R> {
  factory NutritionalValueCopyWith(NutritionalValue value, Then<NutritionalValue, $R> then) = _NutritionalValueCopyWithImpl<$R>;
  $R call({String? id, String? title, String? value, int? rowIndex});
  $R apply(NutritionalValue Function(NutritionalValue) transform);
}

class _NutritionalValueCopyWithImpl<$R> extends BaseCopyWith<NutritionalValue, $R> implements NutritionalValueCopyWith<$R> {
  _NutritionalValueCopyWithImpl(NutritionalValue value, Then<NutritionalValue, $R> then) : super(value, then);

  @override $R call({String? id, String? title, String? value, int? rowIndex}) => $then(NutritionalValue(id: id ?? $value.id, title: title ?? $value.title, value: value ?? $value.value, rowIndex: rowIndex ?? $value.rowIndex));
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
