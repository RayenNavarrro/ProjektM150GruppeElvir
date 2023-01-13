import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';

import 'assignment.dart';
import 'attachment.dart';
import 'audience.dart';
import 'dto/participating_party_update_request_dto.dart';
import 'dto/stage_activity_result_creation_request.dart';
import 'location.dart';
import 'location_marker.dart';
import 'participating_party.dart';
import 'participating_party_appearance.dart';
import 'rally.dart';
import 'rally_stage.dart';
import 'stage.dart';
import 'stage_activity.dart';
import 'stage_activity_answer.dart';
import 'stage_activity_result.dart';
import 'stage_information.dart';
import 'successful_rally_join_response.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  AssignmentMapper._(),
  AttachmentMapper._(),
  VideoAttachmentMapper._(),
  ExternalLinkAttachmentMapper._(),
  AudienceMapper._(),
  LocationMarkerMapper._(),
  IBeaconLocationMarkerMapper._(),
  QRCodeLocationMarkerMapper._(),
  LocationMapper._(),
  ParticipatingPartyMapper._(),
  ParticipatingPartyAppearanceMapper._(),
  RallyStageMapper._(),
  RallyMapper._(),
  StageInformationMapper._(),
  StageMapper._(),
  StageActivityAnswerMapper._(),
  StageActivityResultMapper._(),
  ParticipatingPartyAnswerMapper._(),
  ClosedQuestionAnswerMapper._(),
  OpenQuestionAnswerMapper._(),
  StageActivityMapper._(),
  SingleChoiceActivityMapper._(),
  ClosedQuestionActivityMapper._(),
  MultipleChoiceActivityMapper._(),
  TextInputActivityMapper._(),
  SuccessfulRallyJoinResponseMapper._(),
  ParticipatingPartyUpdateRequestDtoMapper._(),
  StageActivityResultCreationRequestDtoMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class AssignmentMapper extends BaseMapper<Assignment> {
  AssignmentMapper._();

  @override Function get decoder => decode;
  Assignment decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Assignment fromMap(Map<String, dynamic> map) => Assignment(id: Mapper.i.$get(map, 'id'), joiningCode: Mapper.i.$get(map, 'joiningCode'), audience: Mapper.i.$get(map, 'audience'));

  @override Function get encoder => (Assignment v) => encode(v);
  dynamic encode(Assignment v) => toMap(v);
  Map<String, dynamic> toMap(Assignment a) => {'id': Mapper.i.$enc(a.id, 'id'), 'joiningCode': Mapper.i.$enc(a.joiningCode, 'joiningCode'), 'audience': Mapper.i.$enc(a.audience, 'audience')};

  @override String stringify(Assignment self) => 'Assignment(id: ${Mapper.asString(self.id)}, joiningCode: ${Mapper.asString(self.joiningCode)}, audience: ${Mapper.asString(self.audience)})';
  @override int hash(Assignment self) => Mapper.hash(self.id) ^ Mapper.hash(self.joiningCode) ^ Mapper.hash(self.audience);
  @override bool equals(Assignment self, Assignment other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.joiningCode, other.joiningCode) && Mapper.isEqual(self.audience, other.audience);

  @override Function get typeFactory => (f) => f<Assignment>();
}

extension AssignmentMapperExtension  on Assignment {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  AssignmentCopyWith<Assignment> get copyWith => AssignmentCopyWith(this, $identity);
}

abstract class AssignmentCopyWith<$R> {
  factory AssignmentCopyWith(Assignment value, Then<Assignment, $R> then) = _AssignmentCopyWithImpl<$R>;
  AudienceCopyWith<$R> get audience;
  $R call({String? id, int? joiningCode, Audience? audience});
  $R apply(Assignment Function(Assignment) transform);
}

class _AssignmentCopyWithImpl<$R> extends BaseCopyWith<Assignment, $R> implements AssignmentCopyWith<$R> {
  _AssignmentCopyWithImpl(Assignment value, Then<Assignment, $R> then) : super(value, then);

  @override AudienceCopyWith<$R> get audience => AudienceCopyWith($value.audience, (v) => call(audience: v));
  @override $R call({String? id, int? joiningCode, Audience? audience}) => $then(Assignment(id: id ?? $value.id, joiningCode: joiningCode ?? $value.joiningCode, audience: audience ?? $value.audience));
}

class AttachmentMapper extends BaseMapper<Attachment> {
  AttachmentMapper._();

  @override Function get decoder => decode;
  Attachment decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case "link": return ExternalLinkAttachmentMapper._().decode(map);
      case "video": return VideoAttachmentMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  Attachment fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('Attachment', 'type', '${map['type']}');

  @override Function get encoder => (Attachment v) => encode(v);
  dynamic encode(Attachment v) {
    if (v is VideoAttachment) { return VideoAttachmentMapper._().encode(v); }
    else if (v is ExternalLinkAttachment) { return ExternalLinkAttachmentMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(Attachment a) => {'id': Mapper.i.$enc(a.id, 'id'), 'title': Mapper.i.$enc(a.title, 'title'), 'url': Mapper.i.$enc(a.url, 'url')};

  @override String stringify(Attachment self) => 'Attachment(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, url: ${Mapper.asString(self.url)})';
  @override int hash(Attachment self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.url);
  @override bool equals(Attachment self, Attachment other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.url, other.url);

  @override Function get typeFactory => (f) => f<Attachment>();
}

extension AttachmentMapperExtension  on Attachment {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class VideoAttachmentMapper extends BaseMapper<VideoAttachment> {
  VideoAttachmentMapper._();

  @override Function get decoder => decode;
  VideoAttachment decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  VideoAttachment fromMap(Map<String, dynamic> map) => VideoAttachment(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), url: Mapper.i.$get(map, 'url'));

  @override Function get encoder => (VideoAttachment v) => encode(v);
  dynamic encode(VideoAttachment v) => toMap(v);
  Map<String, dynamic> toMap(VideoAttachment v) => {'id': Mapper.i.$enc(v.id, 'id'), 'title': Mapper.i.$enc(v.title, 'title'), 'url': Mapper.i.$enc(v.url, 'url'), 'type': "video"};

  @override String stringify(VideoAttachment self) => 'VideoAttachment(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, url: ${Mapper.asString(self.url)})';
  @override int hash(VideoAttachment self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.url);
  @override bool equals(VideoAttachment self, VideoAttachment other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.url, other.url);

  @override Function get typeFactory => (f) => f<VideoAttachment>();
}

extension VideoAttachmentMapperExtension  on VideoAttachment {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  VideoAttachmentCopyWith<VideoAttachment> get copyWith => VideoAttachmentCopyWith(this, $identity);
}

abstract class VideoAttachmentCopyWith<$R> {
  factory VideoAttachmentCopyWith(VideoAttachment value, Then<VideoAttachment, $R> then) = _VideoAttachmentCopyWithImpl<$R>;
  $R call({String? id, String? title, String? url});
  $R apply(VideoAttachment Function(VideoAttachment) transform);
}

class _VideoAttachmentCopyWithImpl<$R> extends BaseCopyWith<VideoAttachment, $R> implements VideoAttachmentCopyWith<$R> {
  _VideoAttachmentCopyWithImpl(VideoAttachment value, Then<VideoAttachment, $R> then) : super(value, then);

  @override $R call({String? id, String? title, String? url}) => $then(VideoAttachment(id: id ?? $value.id, title: title ?? $value.title, url: url ?? $value.url));
}

class ExternalLinkAttachmentMapper extends BaseMapper<ExternalLinkAttachment> {
  ExternalLinkAttachmentMapper._();

  @override Function get decoder => decode;
  ExternalLinkAttachment decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ExternalLinkAttachment fromMap(Map<String, dynamic> map) => ExternalLinkAttachment(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), url: Mapper.i.$get(map, 'url'));

  @override Function get encoder => (ExternalLinkAttachment v) => encode(v);
  dynamic encode(ExternalLinkAttachment v) => toMap(v);
  Map<String, dynamic> toMap(ExternalLinkAttachment e) => {'id': Mapper.i.$enc(e.id, 'id'), 'title': Mapper.i.$enc(e.title, 'title'), 'url': Mapper.i.$enc(e.url, 'url'), 'type': "link"};

  @override String stringify(ExternalLinkAttachment self) => 'ExternalLinkAttachment(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, url: ${Mapper.asString(self.url)})';
  @override int hash(ExternalLinkAttachment self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.url);
  @override bool equals(ExternalLinkAttachment self, ExternalLinkAttachment other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.url, other.url);

  @override Function get typeFactory => (f) => f<ExternalLinkAttachment>();
}

extension ExternalLinkAttachmentMapperExtension  on ExternalLinkAttachment {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ExternalLinkAttachmentCopyWith<ExternalLinkAttachment> get copyWith => ExternalLinkAttachmentCopyWith(this, $identity);
}

abstract class ExternalLinkAttachmentCopyWith<$R> {
  factory ExternalLinkAttachmentCopyWith(ExternalLinkAttachment value, Then<ExternalLinkAttachment, $R> then) = _ExternalLinkAttachmentCopyWithImpl<$R>;
  $R call({String? id, String? title, String? url});
  $R apply(ExternalLinkAttachment Function(ExternalLinkAttachment) transform);
}

class _ExternalLinkAttachmentCopyWithImpl<$R> extends BaseCopyWith<ExternalLinkAttachment, $R> implements ExternalLinkAttachmentCopyWith<$R> {
  _ExternalLinkAttachmentCopyWithImpl(ExternalLinkAttachment value, Then<ExternalLinkAttachment, $R> then) : super(value, then);

  @override $R call({String? id, String? title, String? url}) => $then(ExternalLinkAttachment(id: id ?? $value.id, title: title ?? $value.title, url: url ?? $value.url));
}

class AudienceMapper extends BaseMapper<Audience> {
  AudienceMapper._();

  @override Function get decoder => decode;
  Audience decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Audience fromMap(Map<String, dynamic> map) => Audience(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), participatingParties: Mapper.i.$get(map, 'participatingParties'));

  @override Function get encoder => (Audience v) => encode(v);
  dynamic encode(Audience v) => toMap(v);
  Map<String, dynamic> toMap(Audience a) => {'id': Mapper.i.$enc(a.id, 'id'), 'title': Mapper.i.$enc(a.title, 'title'), 'participatingParties': Mapper.i.$enc(a.participatingParties, 'participatingParties')};

  @override String stringify(Audience self) => 'Audience(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, participatingParties: ${Mapper.asString(self.participatingParties)})';
  @override int hash(Audience self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.participatingParties);
  @override bool equals(Audience self, Audience other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.participatingParties, other.participatingParties);

  @override Function get typeFactory => (f) => f<Audience>();
}

extension AudienceMapperExtension  on Audience {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  AudienceCopyWith<Audience> get copyWith => AudienceCopyWith(this, $identity);
}

abstract class AudienceCopyWith<$R> {
  factory AudienceCopyWith(Audience value, Then<Audience, $R> then) = _AudienceCopyWithImpl<$R>;
  ListCopyWith<$R, ParticipatingParty, ParticipatingPartyCopyWith<$R>> get participatingParties;
  $R call({String? id, String? title, List<ParticipatingParty>? participatingParties});
  $R apply(Audience Function(Audience) transform);
}

class _AudienceCopyWithImpl<$R> extends BaseCopyWith<Audience, $R> implements AudienceCopyWith<$R> {
  _AudienceCopyWithImpl(Audience value, Then<Audience, $R> then) : super(value, then);

  @override ListCopyWith<$R, ParticipatingParty, ParticipatingPartyCopyWith<$R>> get participatingParties => ListCopyWith($value.participatingParties, (v, t) => ParticipatingPartyCopyWith(v, t), (v) => call(participatingParties: v));
  @override $R call({String? id, String? title, List<ParticipatingParty>? participatingParties}) => $then(Audience(id: id ?? $value.id, title: title ?? $value.title, participatingParties: participatingParties ?? $value.participatingParties));
}

class LocationMarkerMapper extends BaseMapper<LocationMarker> {
  LocationMarkerMapper._();

  @override Function get decoder => decode;
  LocationMarker decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case "IBeaconLocationMarker": return IBeaconLocationMarkerMapper._().decode(map);
      case "QRCodeLocationMarker": return QRCodeLocationMarkerMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  LocationMarker fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('LocationMarker', 'type', '${map['type']}');

  @override Function get encoder => (LocationMarker v) => encode(v);
  dynamic encode(LocationMarker v) {
    if (v is IBeaconLocationMarker) { return IBeaconLocationMarkerMapper._().encode(v); }
    else if (v is QRCodeLocationMarker) { return QRCodeLocationMarkerMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(LocationMarker l) => {'id': Mapper.i.$enc(l.id, 'id')};

  @override String stringify(LocationMarker self) => 'LocationMarker(id: ${Mapper.asString(self.id)})';
  @override int hash(LocationMarker self) => Mapper.hash(self.id);
  @override bool equals(LocationMarker self, LocationMarker other) => Mapper.isEqual(self.id, other.id);

  @override Function get typeFactory => (f) => f<LocationMarker>();
}

extension LocationMarkerMapperExtension  on LocationMarker {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class IBeaconLocationMarkerMapper extends BaseMapper<IBeaconLocationMarker> {
  IBeaconLocationMarkerMapper._();

  @override Function get decoder => decode;
  IBeaconLocationMarker decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  IBeaconLocationMarker fromMap(Map<String, dynamic> map) => IBeaconLocationMarker(Mapper.i.$get(map, 'id'), uuid: Mapper.i.$get(map, 'uuid'), major: Mapper.i.$getOpt(map, 'major'), minor: Mapper.i.$getOpt(map, 'minor'));

  @override Function get encoder => (IBeaconLocationMarker v) => encode(v);
  dynamic encode(IBeaconLocationMarker v) => toMap(v);
  Map<String, dynamic> toMap(IBeaconLocationMarker i) => {'id': Mapper.i.$enc(i.id, 'id'), 'uuid': Mapper.i.$enc(i.uuid, 'uuid'), 'major': Mapper.i.$enc(i.major, 'major'), 'minor': Mapper.i.$enc(i.minor, 'minor'), 'type': "IBeaconLocationMarker"};

  @override String stringify(IBeaconLocationMarker self) => 'IBeaconLocationMarker(id: ${Mapper.asString(self.id)}, uuid: ${Mapper.asString(self.uuid)}, major: ${Mapper.asString(self.major)}, minor: ${Mapper.asString(self.minor)})';
  @override int hash(IBeaconLocationMarker self) => Mapper.hash(self.id) ^ Mapper.hash(self.uuid) ^ Mapper.hash(self.major) ^ Mapper.hash(self.minor);
  @override bool equals(IBeaconLocationMarker self, IBeaconLocationMarker other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.uuid, other.uuid) && Mapper.isEqual(self.major, other.major) && Mapper.isEqual(self.minor, other.minor);

  @override Function get typeFactory => (f) => f<IBeaconLocationMarker>();
}

extension IBeaconLocationMarkerMapperExtension  on IBeaconLocationMarker {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  IBeaconLocationMarkerCopyWith<IBeaconLocationMarker> get copyWith => IBeaconLocationMarkerCopyWith(this, $identity);
}

abstract class IBeaconLocationMarkerCopyWith<$R> {
  factory IBeaconLocationMarkerCopyWith(IBeaconLocationMarker value, Then<IBeaconLocationMarker, $R> then) = _IBeaconLocationMarkerCopyWithImpl<$R>;
  $R call({String? id, String? uuid, int? major, int? minor});
  $R apply(IBeaconLocationMarker Function(IBeaconLocationMarker) transform);
}

class _IBeaconLocationMarkerCopyWithImpl<$R> extends BaseCopyWith<IBeaconLocationMarker, $R> implements IBeaconLocationMarkerCopyWith<$R> {
  _IBeaconLocationMarkerCopyWithImpl(IBeaconLocationMarker value, Then<IBeaconLocationMarker, $R> then) : super(value, then);

  @override $R call({String? id, String? uuid, Object? major = $none, Object? minor = $none}) => $then(IBeaconLocationMarker(id ?? $value.id, uuid: uuid ?? $value.uuid, major: or(major, $value.major), minor: or(minor, $value.minor)));
}

class QRCodeLocationMarkerMapper extends BaseMapper<QRCodeLocationMarker> {
  QRCodeLocationMarkerMapper._();

  @override Function get decoder => decode;
  QRCodeLocationMarker decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  QRCodeLocationMarker fromMap(Map<String, dynamic> map) => QRCodeLocationMarker(Mapper.i.$get(map, 'id'), content: Mapper.i.$get(map, 'content'));

  @override Function get encoder => (QRCodeLocationMarker v) => encode(v);
  dynamic encode(QRCodeLocationMarker v) => toMap(v);
  Map<String, dynamic> toMap(QRCodeLocationMarker q) => {'id': Mapper.i.$enc(q.id, 'id'), 'content': Mapper.i.$enc(q.content, 'content'), 'type': "QRCodeLocationMarker"};

  @override String stringify(QRCodeLocationMarker self) => 'QRCodeLocationMarker(id: ${Mapper.asString(self.id)}, content: ${Mapper.asString(self.content)})';
  @override int hash(QRCodeLocationMarker self) => Mapper.hash(self.id) ^ Mapper.hash(self.content);
  @override bool equals(QRCodeLocationMarker self, QRCodeLocationMarker other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.content, other.content);

  @override Function get typeFactory => (f) => f<QRCodeLocationMarker>();
}

extension QRCodeLocationMarkerMapperExtension  on QRCodeLocationMarker {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  QRCodeLocationMarkerCopyWith<QRCodeLocationMarker> get copyWith => QRCodeLocationMarkerCopyWith(this, $identity);
}

abstract class QRCodeLocationMarkerCopyWith<$R> {
  factory QRCodeLocationMarkerCopyWith(QRCodeLocationMarker value, Then<QRCodeLocationMarker, $R> then) = _QRCodeLocationMarkerCopyWithImpl<$R>;
  $R call({String? id, String? content});
  $R apply(QRCodeLocationMarker Function(QRCodeLocationMarker) transform);
}

class _QRCodeLocationMarkerCopyWithImpl<$R> extends BaseCopyWith<QRCodeLocationMarker, $R> implements QRCodeLocationMarkerCopyWith<$R> {
  _QRCodeLocationMarkerCopyWithImpl(QRCodeLocationMarker value, Then<QRCodeLocationMarker, $R> then) : super(value, then);

  @override $R call({String? id, String? content}) => $then(QRCodeLocationMarker(id ?? $value.id, content: content ?? $value.content));
}

class LocationMapper extends BaseMapper<Location> {
  LocationMapper._();

  @override Function get decoder => decode;
  Location decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Location fromMap(Map<String, dynamic> map) => Location(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), locationMarkers: Mapper.i.$get(map, 'locationMarkers'));

  @override Function get encoder => (Location v) => encode(v);
  dynamic encode(Location v) => toMap(v);
  Map<String, dynamic> toMap(Location l) => {'id': Mapper.i.$enc(l.id, 'id'), 'title': Mapper.i.$enc(l.title, 'title'), 'locationMarkers': Mapper.i.$enc(l.locationMarkers, 'locationMarkers')};

  @override String stringify(Location self) => 'Location(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, locationMarkers: ${Mapper.asString(self.locationMarkers)})';
  @override int hash(Location self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.locationMarkers);
  @override bool equals(Location self, Location other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.locationMarkers, other.locationMarkers);

  @override Function get typeFactory => (f) => f<Location>();
}

extension LocationMapperExtension  on Location {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  LocationCopyWith<Location> get copyWith => LocationCopyWith(this, $identity);
}

abstract class LocationCopyWith<$R> {
  factory LocationCopyWith(Location value, Then<Location, $R> then) = _LocationCopyWithImpl<$R>;
  $R call({String? id, String? title, List<LocationMarker>? locationMarkers});
  $R apply(Location Function(Location) transform);
}

class _LocationCopyWithImpl<$R> extends BaseCopyWith<Location, $R> implements LocationCopyWith<$R> {
  _LocationCopyWithImpl(Location value, Then<Location, $R> then) : super(value, then);

  @override $R call({String? id, String? title, List<LocationMarker>? locationMarkers}) => $then(Location(id: id ?? $value.id, title: title ?? $value.title, locationMarkers: locationMarkers ?? $value.locationMarkers));
}

class ParticipatingPartyMapper extends BaseMapper<ParticipatingParty> {
  ParticipatingPartyMapper._();

  @override Function get decoder => decode;
  ParticipatingParty decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ParticipatingParty fromMap(Map<String, dynamic> map) => ParticipatingParty(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$getOpt(map, 'title'));

  @override Function get encoder => (ParticipatingParty v) => encode(v);
  dynamic encode(ParticipatingParty v) => toMap(v);
  Map<String, dynamic> toMap(ParticipatingParty p) => {'id': Mapper.i.$enc(p.id, 'id'), 'title': Mapper.i.$enc(p.title, 'title')};

  @override String stringify(ParticipatingParty self) => 'ParticipatingParty(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)})';
  @override int hash(ParticipatingParty self) => Mapper.hash(self.id) ^ Mapper.hash(self.title);
  @override bool equals(ParticipatingParty self, ParticipatingParty other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title);

  @override Function get typeFactory => (f) => f<ParticipatingParty>();
}

extension ParticipatingPartyMapperExtension  on ParticipatingParty {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ParticipatingPartyCopyWith<ParticipatingParty> get copyWith => ParticipatingPartyCopyWith(this, $identity);
}

abstract class ParticipatingPartyCopyWith<$R> {
  factory ParticipatingPartyCopyWith(ParticipatingParty value, Then<ParticipatingParty, $R> then) = _ParticipatingPartyCopyWithImpl<$R>;
  $R call({String? id, String? title});
  $R apply(ParticipatingParty Function(ParticipatingParty) transform);
}

class _ParticipatingPartyCopyWithImpl<$R> extends BaseCopyWith<ParticipatingParty, $R> implements ParticipatingPartyCopyWith<$R> {
  _ParticipatingPartyCopyWithImpl(ParticipatingParty value, Then<ParticipatingParty, $R> then) : super(value, then);

  @override $R call({String? id, Object? title = $none}) => $then(ParticipatingParty(id: id ?? $value.id, title: or(title, $value.title)));
}

class ParticipatingPartyAppearanceMapper extends BaseMapper<ParticipatingPartyAppearance> {
  ParticipatingPartyAppearanceMapper._();

  @override Function get decoder => decode;
  ParticipatingPartyAppearance decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ParticipatingPartyAppearance fromMap(Map<String, dynamic> map) => ParticipatingPartyAppearance(id: Mapper.i.$get(map, 'id'), participatingParty: Mapper.i.$get(map, 'participatingParty'), locationMarker: Mapper.i.$get(map, 'locationMarker'));

  @override Function get encoder => (ParticipatingPartyAppearance v) => encode(v);
  dynamic encode(ParticipatingPartyAppearance v) => toMap(v);
  Map<String, dynamic> toMap(ParticipatingPartyAppearance p) => {'id': Mapper.i.$enc(p.id, 'id'), 'participatingParty': Mapper.i.$enc(p.participatingParty, 'participatingParty'), 'locationMarker': Mapper.i.$enc(p.locationMarker, 'locationMarker')};

  @override String stringify(ParticipatingPartyAppearance self) => 'ParticipatingPartyAppearance(id: ${Mapper.asString(self.id)}, participatingParty: ${Mapper.asString(self.participatingParty)}, locationMarker: ${Mapper.asString(self.locationMarker)})';
  @override int hash(ParticipatingPartyAppearance self) => Mapper.hash(self.id) ^ Mapper.hash(self.participatingParty) ^ Mapper.hash(self.locationMarker);
  @override bool equals(ParticipatingPartyAppearance self, ParticipatingPartyAppearance other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.participatingParty, other.participatingParty) && Mapper.isEqual(self.locationMarker, other.locationMarker);

  @override Function get typeFactory => (f) => f<ParticipatingPartyAppearance>();
}

extension ParticipatingPartyAppearanceMapperExtension  on ParticipatingPartyAppearance {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ParticipatingPartyAppearanceCopyWith<ParticipatingPartyAppearance> get copyWith => ParticipatingPartyAppearanceCopyWith(this, $identity);
}

abstract class ParticipatingPartyAppearanceCopyWith<$R> {
  factory ParticipatingPartyAppearanceCopyWith(ParticipatingPartyAppearance value, Then<ParticipatingPartyAppearance, $R> then) = _ParticipatingPartyAppearanceCopyWithImpl<$R>;
  ParticipatingPartyCopyWith<$R> get participatingParty;
  $R call({String? id, ParticipatingParty? participatingParty, LocationMarker? locationMarker});
  $R apply(ParticipatingPartyAppearance Function(ParticipatingPartyAppearance) transform);
}

class _ParticipatingPartyAppearanceCopyWithImpl<$R> extends BaseCopyWith<ParticipatingPartyAppearance, $R> implements ParticipatingPartyAppearanceCopyWith<$R> {
  _ParticipatingPartyAppearanceCopyWithImpl(ParticipatingPartyAppearance value, Then<ParticipatingPartyAppearance, $R> then) : super(value, then);

  @override ParticipatingPartyCopyWith<$R> get participatingParty => ParticipatingPartyCopyWith($value.participatingParty, (v) => call(participatingParty: v));
  @override $R call({String? id, ParticipatingParty? participatingParty, LocationMarker? locationMarker}) => $then(ParticipatingPartyAppearance(id: id ?? $value.id, participatingParty: participatingParty ?? $value.participatingParty, locationMarker: locationMarker ?? $value.locationMarker));
}

class RallyStageMapper extends BaseMapper<RallyStage> {
  RallyStageMapper._();

  @override Function get decoder => decode;
  RallyStage decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  RallyStage fromMap(Map<String, dynamic> map) => RallyStage(id: Mapper.i.$get(map, 'id'), rallyId: Mapper.i.$get(map, 'rallyId'), stageId: Mapper.i.$get(map, 'stageId'));

  @override Function get encoder => (RallyStage v) => encode(v);
  dynamic encode(RallyStage v) => toMap(v);
  Map<String, dynamic> toMap(RallyStage r) => {'id': Mapper.i.$enc(r.id, 'id'), 'rallyId': Mapper.i.$enc(r.rallyId, 'rallyId'), 'stageId': Mapper.i.$enc(r.stageId, 'stageId')};

  @override String stringify(RallyStage self) => 'RallyStage(id: ${Mapper.asString(self.id)}, rallyId: ${Mapper.asString(self.rallyId)}, stageId: ${Mapper.asString(self.stageId)})';
  @override int hash(RallyStage self) => Mapper.hash(self.id) ^ Mapper.hash(self.rallyId) ^ Mapper.hash(self.stageId);
  @override bool equals(RallyStage self, RallyStage other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.rallyId, other.rallyId) && Mapper.isEqual(self.stageId, other.stageId);

  @override Function get typeFactory => (f) => f<RallyStage>();
}

extension RallyStageMapperExtension  on RallyStage {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  RallyStageCopyWith<RallyStage> get copyWith => RallyStageCopyWith(this, $identity);
}

abstract class RallyStageCopyWith<$R> {
  factory RallyStageCopyWith(RallyStage value, Then<RallyStage, $R> then) = _RallyStageCopyWithImpl<$R>;
  $R call({String? id, String? rallyId, String? stageId});
  $R apply(RallyStage Function(RallyStage) transform);
}

class _RallyStageCopyWithImpl<$R> extends BaseCopyWith<RallyStage, $R> implements RallyStageCopyWith<$R> {
  _RallyStageCopyWithImpl(RallyStage value, Then<RallyStage, $R> then) : super(value, then);

  @override $R call({String? id, String? rallyId, String? stageId}) => $then(RallyStage(id: id ?? $value.id, rallyId: rallyId ?? $value.rallyId, stageId: stageId ?? $value.stageId));
}

class RallyMapper extends BaseMapper<Rally> {
  RallyMapper._();

  @override Function get decoder => decode;
  Rally decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Rally fromMap(Map<String, dynamic> map) => Rally(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), rallyStages: Mapper.i.$get(map, 'rallyStages'), assignments: Mapper.i.$get(map, 'assignments'));

  @override Function get encoder => (Rally v) => encode(v);
  dynamic encode(Rally v) => toMap(v);
  Map<String, dynamic> toMap(Rally r) => {'id': Mapper.i.$enc(r.id, 'id'), 'title': Mapper.i.$enc(r.title, 'title'), 'rallyStages': Mapper.i.$enc(r.rallyStages, 'rallyStages'), 'assignments': Mapper.i.$enc(r.assignments, 'assignments')};

  @override String stringify(Rally self) => 'Rally(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, rallyStages: ${Mapper.asString(self.rallyStages)}, assignments: ${Mapper.asString(self.assignments)})';
  @override int hash(Rally self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.rallyStages) ^ Mapper.hash(self.assignments);
  @override bool equals(Rally self, Rally other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.rallyStages, other.rallyStages) && Mapper.isEqual(self.assignments, other.assignments);

  @override Function get typeFactory => (f) => f<Rally>();
}

extension RallyMapperExtension  on Rally {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  RallyCopyWith<Rally> get copyWith => RallyCopyWith(this, $identity);
}

abstract class RallyCopyWith<$R> {
  factory RallyCopyWith(Rally value, Then<Rally, $R> then) = _RallyCopyWithImpl<$R>;
  ListCopyWith<$R, RallyStage, RallyStageCopyWith<$R>> get rallyStages;
  ListCopyWith<$R, Assignment, AssignmentCopyWith<$R>> get assignments;
  $R call({String? id, String? title, List<RallyStage>? rallyStages, List<Assignment>? assignments});
  $R apply(Rally Function(Rally) transform);
}

class _RallyCopyWithImpl<$R> extends BaseCopyWith<Rally, $R> implements RallyCopyWith<$R> {
  _RallyCopyWithImpl(Rally value, Then<Rally, $R> then) : super(value, then);

  @override ListCopyWith<$R, RallyStage, RallyStageCopyWith<$R>> get rallyStages => ListCopyWith($value.rallyStages, (v, t) => RallyStageCopyWith(v, t), (v) => call(rallyStages: v));
  @override ListCopyWith<$R, Assignment, AssignmentCopyWith<$R>> get assignments => ListCopyWith($value.assignments, (v, t) => AssignmentCopyWith(v, t), (v) => call(assignments: v));
  @override $R call({String? id, String? title, List<RallyStage>? rallyStages, List<Assignment>? assignments}) => $then(Rally(id: id ?? $value.id, title: title ?? $value.title, rallyStages: rallyStages ?? $value.rallyStages, assignments: assignments ?? $value.assignments));
}

class StageInformationMapper extends BaseMapper<StageInformation> {
  StageInformationMapper._();

  @override Function get decoder => decode;
  StageInformation decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  StageInformation fromMap(Map<String, dynamic> map) => StageInformation(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), content: Mapper.i.$get(map, 'content'), attachments: Mapper.i.$get(map, 'attachments'));

  @override Function get encoder => (StageInformation v) => encode(v);
  dynamic encode(StageInformation v) => toMap(v);
  Map<String, dynamic> toMap(StageInformation s) => {'id': Mapper.i.$enc(s.id, 'id'), 'title': Mapper.i.$enc(s.title, 'title'), 'content': Mapper.i.$enc(s.content, 'content'), 'attachments': Mapper.i.$enc(s.attachments, 'attachments')};

  @override String stringify(StageInformation self) => 'StageInformation(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, content: ${Mapper.asString(self.content)}, attachments: ${Mapper.asString(self.attachments)})';
  @override int hash(StageInformation self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.content) ^ Mapper.hash(self.attachments);
  @override bool equals(StageInformation self, StageInformation other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.content, other.content) && Mapper.isEqual(self.attachments, other.attachments);

  @override Function get typeFactory => (f) => f<StageInformation>();
}

extension StageInformationMapperExtension  on StageInformation {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  StageInformationCopyWith<StageInformation> get copyWith => StageInformationCopyWith(this, $identity);
}

abstract class StageInformationCopyWith<$R> {
  factory StageInformationCopyWith(StageInformation value, Then<StageInformation, $R> then) = _StageInformationCopyWithImpl<$R>;
  $R call({String? id, String? title, String? content, List<Attachment>? attachments});
  $R apply(StageInformation Function(StageInformation) transform);
}

class _StageInformationCopyWithImpl<$R> extends BaseCopyWith<StageInformation, $R> implements StageInformationCopyWith<$R> {
  _StageInformationCopyWithImpl(StageInformation value, Then<StageInformation, $R> then) : super(value, then);

  @override $R call({String? id, String? title, String? content, List<Attachment>? attachments}) => $then(StageInformation(id: id ?? $value.id, title: title ?? $value.title, content: content ?? $value.content, attachments: attachments ?? $value.attachments));
}

class StageMapper extends BaseMapper<Stage> {
  StageMapper._();

  @override Function get decoder => decode;
  Stage decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Stage fromMap(Map<String, dynamic> map) => Stage(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), preArrivalInformation: Mapper.i.$get(map, 'preArrivalInformation'), information: Mapper.i.$get(map, 'information'), locations: Mapper.i.$get(map, 'locations'), stageActivity: Mapper.i.$get(map, 'stageActivity'));

  @override Function get encoder => (Stage v) => encode(v);
  dynamic encode(Stage v) => toMap(v);
  Map<String, dynamic> toMap(Stage s) => {'id': Mapper.i.$enc(s.id, 'id'), 'title': Mapper.i.$enc(s.title, 'title'), 'preArrivalInformation': Mapper.i.$enc(s.preArrivalInformation, 'preArrivalInformation'), 'information': Mapper.i.$enc(s.information, 'information'), 'locations': Mapper.i.$enc(s.locations, 'locations'), 'stageActivity': Mapper.i.$enc(s.stageActivity, 'stageActivity')};

  @override String stringify(Stage self) => 'Stage(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, preArrivalInformation: ${Mapper.asString(self.preArrivalInformation)}, information: ${Mapper.asString(self.information)}, locations: ${Mapper.asString(self.locations)}, stageActivity: ${Mapper.asString(self.stageActivity)})';
  @override int hash(Stage self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.preArrivalInformation) ^ Mapper.hash(self.information) ^ Mapper.hash(self.locations) ^ Mapper.hash(self.stageActivity);
  @override bool equals(Stage self, Stage other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.preArrivalInformation, other.preArrivalInformation) && Mapper.isEqual(self.information, other.information) && Mapper.isEqual(self.locations, other.locations) && Mapper.isEqual(self.stageActivity, other.stageActivity);

  @override Function get typeFactory => (f) => f<Stage>();
}

extension StageMapperExtension  on Stage {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  StageCopyWith<Stage> get copyWith => StageCopyWith(this, $identity);
}

abstract class StageCopyWith<$R> {
  factory StageCopyWith(Stage value, Then<Stage, $R> then) = _StageCopyWithImpl<$R>;
  StageInformationCopyWith<$R> get preArrivalInformation;
  StageInformationCopyWith<$R> get information;
  ListCopyWith<$R, Location, LocationCopyWith<$R>> get locations;
  $R call({String? id, String? title, StageInformation? preArrivalInformation, StageInformation? information, List<Location>? locations, StageActivity? stageActivity});
  $R apply(Stage Function(Stage) transform);
}

class _StageCopyWithImpl<$R> extends BaseCopyWith<Stage, $R> implements StageCopyWith<$R> {
  _StageCopyWithImpl(Stage value, Then<Stage, $R> then) : super(value, then);

  @override StageInformationCopyWith<$R> get preArrivalInformation => StageInformationCopyWith($value.preArrivalInformation, (v) => call(preArrivalInformation: v));
  @override StageInformationCopyWith<$R> get information => StageInformationCopyWith($value.information, (v) => call(information: v));
  @override ListCopyWith<$R, Location, LocationCopyWith<$R>> get locations => ListCopyWith($value.locations, (v, t) => LocationCopyWith(v, t), (v) => call(locations: v));
  @override $R call({String? id, String? title, StageInformation? preArrivalInformation, StageInformation? information, List<Location>? locations, StageActivity? stageActivity}) => $then(Stage(id: id ?? $value.id, title: title ?? $value.title, preArrivalInformation: preArrivalInformation ?? $value.preArrivalInformation, information: information ?? $value.information, locations: locations ?? $value.locations, stageActivity: stageActivity ?? $value.stageActivity));
}

class StageActivityAnswerMapper extends BaseMapper<StageActivityAnswer> {
  StageActivityAnswerMapper._();

  @override Function get decoder => decode;
  StageActivityAnswer decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  StageActivityAnswer fromMap(Map<String, dynamic> map) => StageActivityAnswer(id: Mapper.i.$get(map, 'id'), answerText: Mapper.i.$get(map, 'answerText'));

  @override Function get encoder => (StageActivityAnswer v) => encode(v);
  dynamic encode(StageActivityAnswer v) => toMap(v);
  Map<String, dynamic> toMap(StageActivityAnswer s) => {'id': Mapper.i.$enc(s.id, 'id'), 'answerText': Mapper.i.$enc(s.answerText, 'answerText')};

  @override String stringify(StageActivityAnswer self) => 'StageActivityAnswer(id: ${Mapper.asString(self.id)}, answerText: ${Mapper.asString(self.answerText)})';
  @override int hash(StageActivityAnswer self) => Mapper.hash(self.id) ^ Mapper.hash(self.answerText);
  @override bool equals(StageActivityAnswer self, StageActivityAnswer other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.answerText, other.answerText);

  @override Function get typeFactory => (f) => f<StageActivityAnswer>();
}

extension StageActivityAnswerMapperExtension  on StageActivityAnswer {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  StageActivityAnswerCopyWith<StageActivityAnswer> get copyWith => StageActivityAnswerCopyWith(this, $identity);
}

abstract class StageActivityAnswerCopyWith<$R> {
  factory StageActivityAnswerCopyWith(StageActivityAnswer value, Then<StageActivityAnswer, $R> then) = _StageActivityAnswerCopyWithImpl<$R>;
  $R call({String? id, String? answerText});
  $R apply(StageActivityAnswer Function(StageActivityAnswer) transform);
}

class _StageActivityAnswerCopyWithImpl<$R> extends BaseCopyWith<StageActivityAnswer, $R> implements StageActivityAnswerCopyWith<$R> {
  _StageActivityAnswerCopyWithImpl(StageActivityAnswer value, Then<StageActivityAnswer, $R> then) : super(value, then);

  @override $R call({String? id, String? answerText}) => $then(StageActivityAnswer(id: id ?? $value.id, answerText: answerText ?? $value.answerText));
}

class StageActivityResultMapper extends BaseMapper<StageActivityResult> {
  StageActivityResultMapper._();

  @override Function get decoder => decode;
  StageActivityResult decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  StageActivityResult fromMap(Map<String, dynamic> map) => StageActivityResult(id: Mapper.i.$get(map, 'id'), answers: Mapper.i.$get(map, 'answers'), awardedPoints: Mapper.i.$get(map, 'awardedPoints'), totalPoints: Mapper.i.$get(map, 'totalPoints'), momentOfCompletion: Mapper.i.$get(map, 'momentOfCompletion'));

  @override Function get encoder => (StageActivityResult v) => encode(v);
  dynamic encode(StageActivityResult v) => toMap(v);
  Map<String, dynamic> toMap(StageActivityResult s) => {'id': Mapper.i.$enc(s.id, 'id'), 'answers': Mapper.i.$enc(s.answers, 'answers'), 'awardedPoints': Mapper.i.$enc(s.awardedPoints, 'awardedPoints'), 'totalPoints': Mapper.i.$enc(s.totalPoints, 'totalPoints'), 'momentOfCompletion': Mapper.i.$enc(s.momentOfCompletion, 'momentOfCompletion')};

  @override String stringify(StageActivityResult self) => 'StageActivityResult(id: ${Mapper.asString(self.id)}, answers: ${Mapper.asString(self.answers)}, awardedPoints: ${Mapper.asString(self.awardedPoints)}, totalPoints: ${Mapper.asString(self.totalPoints)}, momentOfCompletion: ${Mapper.asString(self.momentOfCompletion)})';
  @override int hash(StageActivityResult self) => Mapper.hash(self.id) ^ Mapper.hash(self.answers) ^ Mapper.hash(self.awardedPoints) ^ Mapper.hash(self.totalPoints) ^ Mapper.hash(self.momentOfCompletion);
  @override bool equals(StageActivityResult self, StageActivityResult other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.answers, other.answers) && Mapper.isEqual(self.awardedPoints, other.awardedPoints) && Mapper.isEqual(self.totalPoints, other.totalPoints) && Mapper.isEqual(self.momentOfCompletion, other.momentOfCompletion);

  @override Function get typeFactory => (f) => f<StageActivityResult>();
}

extension StageActivityResultMapperExtension  on StageActivityResult {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  StageActivityResultCopyWith<StageActivityResult> get copyWith => StageActivityResultCopyWith(this, $identity);
}

abstract class StageActivityResultCopyWith<$R> {
  factory StageActivityResultCopyWith(StageActivityResult value, Then<StageActivityResult, $R> then) = _StageActivityResultCopyWithImpl<$R>;
  $R call({String? id, List<ParticipatingPartyAnswer>? answers, int? awardedPoints, int? totalPoints, DateTime? momentOfCompletion});
  $R apply(StageActivityResult Function(StageActivityResult) transform);
}

class _StageActivityResultCopyWithImpl<$R> extends BaseCopyWith<StageActivityResult, $R> implements StageActivityResultCopyWith<$R> {
  _StageActivityResultCopyWithImpl(StageActivityResult value, Then<StageActivityResult, $R> then) : super(value, then);

  @override $R call({String? id, List<ParticipatingPartyAnswer>? answers, int? awardedPoints, int? totalPoints, DateTime? momentOfCompletion}) => $then(StageActivityResult(id: id ?? $value.id, answers: answers ?? $value.answers, awardedPoints: awardedPoints ?? $value.awardedPoints, totalPoints: totalPoints ?? $value.totalPoints, momentOfCompletion: momentOfCompletion ?? $value.momentOfCompletion));
}

class ParticipatingPartyAnswerMapper extends BaseMapper<ParticipatingPartyAnswer> {
  ParticipatingPartyAnswerMapper._();

  @override Function get decoder => decode;
  ParticipatingPartyAnswer decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case "closedQuestionAnswer": return ClosedQuestionAnswerMapper._().decode(map);
      case "openQuestionAnswer": return OpenQuestionAnswerMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  ParticipatingPartyAnswer fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('ParticipatingPartyAnswer', 'type', '${map['type']}');

  @override Function get encoder => (ParticipatingPartyAnswer v) => encode(v);
  dynamic encode(ParticipatingPartyAnswer v) {
    if (v is ClosedQuestionAnswer) { return ClosedQuestionAnswerMapper._().encode(v); }
    else if (v is OpenQuestionAnswer) { return OpenQuestionAnswerMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(ParticipatingPartyAnswer p) => {'id': Mapper.i.$enc(p.id, 'id'), 'isCorrect': Mapper.i.$enc(p.isCorrect, 'isCorrect')};

  @override String stringify(ParticipatingPartyAnswer self) => 'ParticipatingPartyAnswer(id: ${Mapper.asString(self.id)}, isCorrect: ${Mapper.asString(self.isCorrect)})';
  @override int hash(ParticipatingPartyAnswer self) => Mapper.hash(self.id) ^ Mapper.hash(self.isCorrect);
  @override bool equals(ParticipatingPartyAnswer self, ParticipatingPartyAnswer other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.isCorrect, other.isCorrect);

  @override Function get typeFactory => (f) => f<ParticipatingPartyAnswer>();
}

extension ParticipatingPartyAnswerMapperExtension  on ParticipatingPartyAnswer {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class ClosedQuestionAnswerMapper extends BaseMapper<ClosedQuestionAnswer> {
  ClosedQuestionAnswerMapper._();

  @override Function get decoder => decode;
  ClosedQuestionAnswer decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ClosedQuestionAnswer fromMap(Map<String, dynamic> map) => ClosedQuestionAnswer(id: Mapper.i.$get(map, 'id'), isCorrect: Mapper.i.$get(map, 'isCorrect'), answer: Mapper.i.$get(map, 'answer'));

  @override Function get encoder => (ClosedQuestionAnswer v) => encode(v);
  dynamic encode(ClosedQuestionAnswer v) => toMap(v);
  Map<String, dynamic> toMap(ClosedQuestionAnswer c) => {'id': Mapper.i.$enc(c.id, 'id'), 'isCorrect': Mapper.i.$enc(c.isCorrect, 'isCorrect'), 'answer': Mapper.i.$enc(c.answer, 'answer'), 'type': "closedQuestionAnswer"};

  @override String stringify(ClosedQuestionAnswer self) => 'ClosedQuestionAnswer(id: ${Mapper.asString(self.id)}, isCorrect: ${Mapper.asString(self.isCorrect)}, answer: ${Mapper.asString(self.answer)})';
  @override int hash(ClosedQuestionAnswer self) => Mapper.hash(self.id) ^ Mapper.hash(self.isCorrect) ^ Mapper.hash(self.answer);
  @override bool equals(ClosedQuestionAnswer self, ClosedQuestionAnswer other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.isCorrect, other.isCorrect) && Mapper.isEqual(self.answer, other.answer);

  @override Function get typeFactory => (f) => f<ClosedQuestionAnswer>();
}

extension ClosedQuestionAnswerMapperExtension  on ClosedQuestionAnswer {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ClosedQuestionAnswerCopyWith<ClosedQuestionAnswer> get copyWith => ClosedQuestionAnswerCopyWith(this, $identity);
}

abstract class ClosedQuestionAnswerCopyWith<$R> {
  factory ClosedQuestionAnswerCopyWith(ClosedQuestionAnswer value, Then<ClosedQuestionAnswer, $R> then) = _ClosedQuestionAnswerCopyWithImpl<$R>;
  StageActivityAnswerCopyWith<$R> get answer;
  $R call({String? id, bool? isCorrect, StageActivityAnswer? answer});
  $R apply(ClosedQuestionAnswer Function(ClosedQuestionAnswer) transform);
}

class _ClosedQuestionAnswerCopyWithImpl<$R> extends BaseCopyWith<ClosedQuestionAnswer, $R> implements ClosedQuestionAnswerCopyWith<$R> {
  _ClosedQuestionAnswerCopyWithImpl(ClosedQuestionAnswer value, Then<ClosedQuestionAnswer, $R> then) : super(value, then);

  @override StageActivityAnswerCopyWith<$R> get answer => StageActivityAnswerCopyWith($value.answer, (v) => call(answer: v));
  @override $R call({String? id, bool? isCorrect, StageActivityAnswer? answer}) => $then(ClosedQuestionAnswer(id: id ?? $value.id, isCorrect: isCorrect ?? $value.isCorrect, answer: answer ?? $value.answer));
}

class OpenQuestionAnswerMapper extends BaseMapper<OpenQuestionAnswer> {
  OpenQuestionAnswerMapper._();

  @override Function get decoder => decode;
  OpenQuestionAnswer decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  OpenQuestionAnswer fromMap(Map<String, dynamic> map) => OpenQuestionAnswer(id: Mapper.i.$get(map, 'id'), isCorrect: Mapper.i.$get(map, 'isCorrect'), answerText: Mapper.i.$get(map, 'answerText'));

  @override Function get encoder => (OpenQuestionAnswer v) => encode(v);
  dynamic encode(OpenQuestionAnswer v) => toMap(v);
  Map<String, dynamic> toMap(OpenQuestionAnswer o) => {'id': Mapper.i.$enc(o.id, 'id'), 'isCorrect': Mapper.i.$enc(o.isCorrect, 'isCorrect'), 'answerText': Mapper.i.$enc(o.answerText, 'answerText'), 'type': "openQuestionAnswer"};

  @override String stringify(OpenQuestionAnswer self) => 'OpenQuestionAnswer(id: ${Mapper.asString(self.id)}, isCorrect: ${Mapper.asString(self.isCorrect)}, answerText: ${Mapper.asString(self.answerText)})';
  @override int hash(OpenQuestionAnswer self) => Mapper.hash(self.id) ^ Mapper.hash(self.isCorrect) ^ Mapper.hash(self.answerText);
  @override bool equals(OpenQuestionAnswer self, OpenQuestionAnswer other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.isCorrect, other.isCorrect) && Mapper.isEqual(self.answerText, other.answerText);

  @override Function get typeFactory => (f) => f<OpenQuestionAnswer>();
}

extension OpenQuestionAnswerMapperExtension  on OpenQuestionAnswer {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  OpenQuestionAnswerCopyWith<OpenQuestionAnswer> get copyWith => OpenQuestionAnswerCopyWith(this, $identity);
}

abstract class OpenQuestionAnswerCopyWith<$R> {
  factory OpenQuestionAnswerCopyWith(OpenQuestionAnswer value, Then<OpenQuestionAnswer, $R> then) = _OpenQuestionAnswerCopyWithImpl<$R>;
  $R call({String? id, bool? isCorrect, String? answerText});
  $R apply(OpenQuestionAnswer Function(OpenQuestionAnswer) transform);
}

class _OpenQuestionAnswerCopyWithImpl<$R> extends BaseCopyWith<OpenQuestionAnswer, $R> implements OpenQuestionAnswerCopyWith<$R> {
  _OpenQuestionAnswerCopyWithImpl(OpenQuestionAnswer value, Then<OpenQuestionAnswer, $R> then) : super(value, then);

  @override $R call({String? id, bool? isCorrect, String? answerText}) => $then(OpenQuestionAnswer(id: id ?? $value.id, isCorrect: isCorrect ?? $value.isCorrect, answerText: answerText ?? $value.answerText));
}

class StageActivityMapper extends BaseMapper<StageActivity> {
  StageActivityMapper._();

  @override Function get decoder => decode;
  StageActivity decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case "multipleChoice":
      case "singleChoice": return ClosedQuestionActivityMapper._().decode(map);
      case "textInput": return TextInputActivityMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  StageActivity fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('StageActivity', 'type', '${map['type']}');

  @override Function get encoder => (StageActivity v) => encode(v);
  dynamic encode(StageActivity v) {
    if (v is ClosedQuestionActivity) { return ClosedQuestionActivityMapper._().encode(v); }
    else if (v is TextInputActivity) { return TextInputActivityMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(StageActivity s) => {'id': Mapper.i.$enc(s.id, 'id'), 'title': Mapper.i.$enc(s.title, 'title'), 'task': Mapper.i.$enc(s.task, 'task'), 'maxPoints': Mapper.i.$enc(s.maxPoints, 'maxPoints')};

  @override String stringify(StageActivity self) => 'StageActivity(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, task: ${Mapper.asString(self.task)}, maxPoints: ${Mapper.asString(self.maxPoints)})';
  @override int hash(StageActivity self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.task) ^ Mapper.hash(self.maxPoints);
  @override bool equals(StageActivity self, StageActivity other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.task, other.task) && Mapper.isEqual(self.maxPoints, other.maxPoints);

  @override Function get typeFactory => (f) => f<StageActivity>();
}

extension StageActivityMapperExtension  on StageActivity {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class SingleChoiceActivityMapper extends BaseMapper<SingleChoiceActivity> {
  SingleChoiceActivityMapper._();

  @override Function get decoder => decode;
  SingleChoiceActivity decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  SingleChoiceActivity fromMap(Map<String, dynamic> map) => SingleChoiceActivity(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), task: Mapper.i.$get(map, 'task'), maxPoints: Mapper.i.$get(map, 'maxPoints'), answers: Mapper.i.$get(map, 'answers'));

  @override Function get encoder => (SingleChoiceActivity v) => encode(v);
  dynamic encode(SingleChoiceActivity v) => toMap(v);
  Map<String, dynamic> toMap(SingleChoiceActivity s) => {'id': Mapper.i.$enc(s.id, 'id'), 'title': Mapper.i.$enc(s.title, 'title'), 'task': Mapper.i.$enc(s.task, 'task'), 'maxPoints': Mapper.i.$enc(s.maxPoints, 'maxPoints'), 'answers': Mapper.i.$enc(s.answers, 'answers'), 'type': "singleChoice"};

  @override String stringify(SingleChoiceActivity self) => 'SingleChoiceActivity(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, task: ${Mapper.asString(self.task)}, maxPoints: ${Mapper.asString(self.maxPoints)}, answers: ${Mapper.asString(self.answers)})';
  @override int hash(SingleChoiceActivity self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.task) ^ Mapper.hash(self.maxPoints) ^ Mapper.hash(self.answers);
  @override bool equals(SingleChoiceActivity self, SingleChoiceActivity other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.task, other.task) && Mapper.isEqual(self.maxPoints, other.maxPoints) && Mapper.isEqual(self.answers, other.answers);

  @override Function get typeFactory => (f) => f<SingleChoiceActivity>();
}

extension SingleChoiceActivityMapperExtension  on SingleChoiceActivity {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  SingleChoiceActivityCopyWith<SingleChoiceActivity> get copyWith => SingleChoiceActivityCopyWith(this, $identity);
}

abstract class SingleChoiceActivityCopyWith<$R> {
  factory SingleChoiceActivityCopyWith(SingleChoiceActivity value, Then<SingleChoiceActivity, $R> then) = _SingleChoiceActivityCopyWithImpl<$R>;
  ListCopyWith<$R, StageActivityAnswer, StageActivityAnswerCopyWith<$R>> get answers;
  $R call({String? id, String? title, String? task, int? maxPoints, List<StageActivityAnswer>? answers});
  $R apply(SingleChoiceActivity Function(SingleChoiceActivity) transform);
}

class _SingleChoiceActivityCopyWithImpl<$R> extends BaseCopyWith<SingleChoiceActivity, $R> implements SingleChoiceActivityCopyWith<$R> {
  _SingleChoiceActivityCopyWithImpl(SingleChoiceActivity value, Then<SingleChoiceActivity, $R> then) : super(value, then);

  @override ListCopyWith<$R, StageActivityAnswer, StageActivityAnswerCopyWith<$R>> get answers => ListCopyWith($value.answers, (v, t) => StageActivityAnswerCopyWith(v, t), (v) => call(answers: v));
  @override $R call({String? id, String? title, String? task, int? maxPoints, List<StageActivityAnswer>? answers}) => $then(SingleChoiceActivity(id: id ?? $value.id, title: title ?? $value.title, task: task ?? $value.task, maxPoints: maxPoints ?? $value.maxPoints, answers: answers ?? $value.answers));
}

class ClosedQuestionActivityMapper extends BaseMapper<ClosedQuestionActivity> {
  ClosedQuestionActivityMapper._();

  @override Function get decoder => decode;
  ClosedQuestionActivity decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case "multipleChoice": return MultipleChoiceActivityMapper._().decode(map);
      case "singleChoice": return SingleChoiceActivityMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  ClosedQuestionActivity fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('ClosedQuestionActivity', 'type', '${map['type']}');

  @override Function get encoder => (ClosedQuestionActivity v) => encode(v);
  dynamic encode(ClosedQuestionActivity v) {
    if (v is SingleChoiceActivity) { return SingleChoiceActivityMapper._().encode(v); }
    else if (v is MultipleChoiceActivity) { return MultipleChoiceActivityMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(ClosedQuestionActivity c) => {'id': Mapper.i.$enc(c.id, 'id'), 'title': Mapper.i.$enc(c.title, 'title'), 'task': Mapper.i.$enc(c.task, 'task'), 'maxPoints': Mapper.i.$enc(c.maxPoints, 'maxPoints'), 'answers': Mapper.i.$enc(c.answers, 'answers')};

  @override String stringify(ClosedQuestionActivity self) => 'ClosedQuestionActivity(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, task: ${Mapper.asString(self.task)}, maxPoints: ${Mapper.asString(self.maxPoints)}, answers: ${Mapper.asString(self.answers)})';
  @override int hash(ClosedQuestionActivity self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.task) ^ Mapper.hash(self.maxPoints) ^ Mapper.hash(self.answers);
  @override bool equals(ClosedQuestionActivity self, ClosedQuestionActivity other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.task, other.task) && Mapper.isEqual(self.maxPoints, other.maxPoints) && Mapper.isEqual(self.answers, other.answers);

  @override Function get typeFactory => (f) => f<ClosedQuestionActivity>();
}

extension ClosedQuestionActivityMapperExtension  on ClosedQuestionActivity {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class MultipleChoiceActivityMapper extends BaseMapper<MultipleChoiceActivity> {
  MultipleChoiceActivityMapper._();

  @override Function get decoder => decode;
  MultipleChoiceActivity decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  MultipleChoiceActivity fromMap(Map<String, dynamic> map) => MultipleChoiceActivity(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), task: Mapper.i.$get(map, 'task'), maxPoints: Mapper.i.$get(map, 'maxPoints'), answers: Mapper.i.$get(map, 'answers'));

  @override Function get encoder => (MultipleChoiceActivity v) => encode(v);
  dynamic encode(MultipleChoiceActivity v) => toMap(v);
  Map<String, dynamic> toMap(MultipleChoiceActivity m) => {'id': Mapper.i.$enc(m.id, 'id'), 'title': Mapper.i.$enc(m.title, 'title'), 'task': Mapper.i.$enc(m.task, 'task'), 'maxPoints': Mapper.i.$enc(m.maxPoints, 'maxPoints'), 'answers': Mapper.i.$enc(m.answers, 'answers'), 'type': "multipleChoice"};

  @override String stringify(MultipleChoiceActivity self) => 'MultipleChoiceActivity(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, task: ${Mapper.asString(self.task)}, maxPoints: ${Mapper.asString(self.maxPoints)}, answers: ${Mapper.asString(self.answers)})';
  @override int hash(MultipleChoiceActivity self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.task) ^ Mapper.hash(self.maxPoints) ^ Mapper.hash(self.answers);
  @override bool equals(MultipleChoiceActivity self, MultipleChoiceActivity other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.task, other.task) && Mapper.isEqual(self.maxPoints, other.maxPoints) && Mapper.isEqual(self.answers, other.answers);

  @override Function get typeFactory => (f) => f<MultipleChoiceActivity>();
}

extension MultipleChoiceActivityMapperExtension  on MultipleChoiceActivity {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  MultipleChoiceActivityCopyWith<MultipleChoiceActivity> get copyWith => MultipleChoiceActivityCopyWith(this, $identity);
}

abstract class MultipleChoiceActivityCopyWith<$R> {
  factory MultipleChoiceActivityCopyWith(MultipleChoiceActivity value, Then<MultipleChoiceActivity, $R> then) = _MultipleChoiceActivityCopyWithImpl<$R>;
  ListCopyWith<$R, StageActivityAnswer, StageActivityAnswerCopyWith<$R>> get answers;
  $R call({String? id, String? title, String? task, int? maxPoints, List<StageActivityAnswer>? answers});
  $R apply(MultipleChoiceActivity Function(MultipleChoiceActivity) transform);
}

class _MultipleChoiceActivityCopyWithImpl<$R> extends BaseCopyWith<MultipleChoiceActivity, $R> implements MultipleChoiceActivityCopyWith<$R> {
  _MultipleChoiceActivityCopyWithImpl(MultipleChoiceActivity value, Then<MultipleChoiceActivity, $R> then) : super(value, then);

  @override ListCopyWith<$R, StageActivityAnswer, StageActivityAnswerCopyWith<$R>> get answers => ListCopyWith($value.answers, (v, t) => StageActivityAnswerCopyWith(v, t), (v) => call(answers: v));
  @override $R call({String? id, String? title, String? task, int? maxPoints, List<StageActivityAnswer>? answers}) => $then(MultipleChoiceActivity(id: id ?? $value.id, title: title ?? $value.title, task: task ?? $value.task, maxPoints: maxPoints ?? $value.maxPoints, answers: answers ?? $value.answers));
}

class TextInputActivityMapper extends BaseMapper<TextInputActivity> {
  TextInputActivityMapper._();

  @override Function get decoder => decode;
  TextInputActivity decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  TextInputActivity fromMap(Map<String, dynamic> map) => TextInputActivity(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), task: Mapper.i.$get(map, 'task'), maxPoints: Mapper.i.$get(map, 'maxPoints'));

  @override Function get encoder => (TextInputActivity v) => encode(v);
  dynamic encode(TextInputActivity v) => toMap(v);
  Map<String, dynamic> toMap(TextInputActivity t) => {'id': Mapper.i.$enc(t.id, 'id'), 'title': Mapper.i.$enc(t.title, 'title'), 'task': Mapper.i.$enc(t.task, 'task'), 'maxPoints': Mapper.i.$enc(t.maxPoints, 'maxPoints'), 'type': "textInput"};

  @override String stringify(TextInputActivity self) => 'TextInputActivity(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, task: ${Mapper.asString(self.task)}, maxPoints: ${Mapper.asString(self.maxPoints)})';
  @override int hash(TextInputActivity self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.task) ^ Mapper.hash(self.maxPoints);
  @override bool equals(TextInputActivity self, TextInputActivity other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.task, other.task) && Mapper.isEqual(self.maxPoints, other.maxPoints);

  @override Function get typeFactory => (f) => f<TextInputActivity>();
}

extension TextInputActivityMapperExtension  on TextInputActivity {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  TextInputActivityCopyWith<TextInputActivity> get copyWith => TextInputActivityCopyWith(this, $identity);
}

abstract class TextInputActivityCopyWith<$R> {
  factory TextInputActivityCopyWith(TextInputActivity value, Then<TextInputActivity, $R> then) = _TextInputActivityCopyWithImpl<$R>;
  $R call({String? id, String? title, String? task, int? maxPoints});
  $R apply(TextInputActivity Function(TextInputActivity) transform);
}

class _TextInputActivityCopyWithImpl<$R> extends BaseCopyWith<TextInputActivity, $R> implements TextInputActivityCopyWith<$R> {
  _TextInputActivityCopyWithImpl(TextInputActivity value, Then<TextInputActivity, $R> then) : super(value, then);

  @override $R call({String? id, String? title, String? task, int? maxPoints}) => $then(TextInputActivity(id: id ?? $value.id, title: title ?? $value.title, task: task ?? $value.task, maxPoints: maxPoints ?? $value.maxPoints));
}

class SuccessfulRallyJoinResponseMapper extends BaseMapper<SuccessfulRallyJoinResponse> {
  SuccessfulRallyJoinResponseMapper._();

  @override Function get decoder => decode;
  SuccessfulRallyJoinResponse decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  SuccessfulRallyJoinResponse fromMap(Map<String, dynamic> map) => SuccessfulRallyJoinResponse(participatingParty: Mapper.i.$get(map, 'participatingParty'), rally: Mapper.i.$get(map, 'rally'));

  @override Function get encoder => (SuccessfulRallyJoinResponse v) => encode(v);
  dynamic encode(SuccessfulRallyJoinResponse v) => toMap(v);
  Map<String, dynamic> toMap(SuccessfulRallyJoinResponse s) => {'participatingParty': Mapper.i.$enc(s.participatingParty, 'participatingParty'), 'rally': Mapper.i.$enc(s.rally, 'rally')};

  @override String stringify(SuccessfulRallyJoinResponse self) => 'SuccessfulRallyJoinResponse(participatingParty: ${Mapper.asString(self.participatingParty)}, rally: ${Mapper.asString(self.rally)})';
  @override int hash(SuccessfulRallyJoinResponse self) => Mapper.hash(self.participatingParty) ^ Mapper.hash(self.rally);
  @override bool equals(SuccessfulRallyJoinResponse self, SuccessfulRallyJoinResponse other) => Mapper.isEqual(self.participatingParty, other.participatingParty) && Mapper.isEqual(self.rally, other.rally);

  @override Function get typeFactory => (f) => f<SuccessfulRallyJoinResponse>();
}

extension SuccessfulRallyJoinResponseMapperExtension  on SuccessfulRallyJoinResponse {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  SuccessfulRallyJoinResponseCopyWith<SuccessfulRallyJoinResponse> get copyWith => SuccessfulRallyJoinResponseCopyWith(this, $identity);
}

abstract class SuccessfulRallyJoinResponseCopyWith<$R> {
  factory SuccessfulRallyJoinResponseCopyWith(SuccessfulRallyJoinResponse value, Then<SuccessfulRallyJoinResponse, $R> then) = _SuccessfulRallyJoinResponseCopyWithImpl<$R>;
  ParticipatingPartyCopyWith<$R> get participatingParty;
  RallyCopyWith<$R> get rally;
  $R call({ParticipatingParty? participatingParty, Rally? rally});
  $R apply(SuccessfulRallyJoinResponse Function(SuccessfulRallyJoinResponse) transform);
}

class _SuccessfulRallyJoinResponseCopyWithImpl<$R> extends BaseCopyWith<SuccessfulRallyJoinResponse, $R> implements SuccessfulRallyJoinResponseCopyWith<$R> {
  _SuccessfulRallyJoinResponseCopyWithImpl(SuccessfulRallyJoinResponse value, Then<SuccessfulRallyJoinResponse, $R> then) : super(value, then);

  @override ParticipatingPartyCopyWith<$R> get participatingParty => ParticipatingPartyCopyWith($value.participatingParty, (v) => call(participatingParty: v));
  @override RallyCopyWith<$R> get rally => RallyCopyWith($value.rally, (v) => call(rally: v));
  @override $R call({ParticipatingParty? participatingParty, Rally? rally}) => $then(SuccessfulRallyJoinResponse(participatingParty: participatingParty ?? $value.participatingParty, rally: rally ?? $value.rally));
}

class ParticipatingPartyUpdateRequestDtoMapper extends BaseMapper<ParticipatingPartyUpdateRequestDto> {
  ParticipatingPartyUpdateRequestDtoMapper._();

  @override Function get decoder => decode;
  ParticipatingPartyUpdateRequestDto decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ParticipatingPartyUpdateRequestDto fromMap(Map<String, dynamic> map) => ParticipatingPartyUpdateRequestDto(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), names: Mapper.i.$get(map, 'names'));

  @override Function get encoder => (ParticipatingPartyUpdateRequestDto v) => encode(v);
  dynamic encode(ParticipatingPartyUpdateRequestDto v) => toMap(v);
  Map<String, dynamic> toMap(ParticipatingPartyUpdateRequestDto p) => {'id': Mapper.i.$enc(p.id, 'id'), 'title': Mapper.i.$enc(p.title, 'title'), 'names': Mapper.i.$enc(p.names, 'names')};

  @override String stringify(ParticipatingPartyUpdateRequestDto self) => 'ParticipatingPartyUpdateRequestDto(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, names: ${Mapper.asString(self.names)})';
  @override int hash(ParticipatingPartyUpdateRequestDto self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.names);
  @override bool equals(ParticipatingPartyUpdateRequestDto self, ParticipatingPartyUpdateRequestDto other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.names, other.names);

  @override Function get typeFactory => (f) => f<ParticipatingPartyUpdateRequestDto>();
}

extension ParticipatingPartyUpdateRequestDtoMapperExtension  on ParticipatingPartyUpdateRequestDto {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ParticipatingPartyUpdateRequestDtoCopyWith<ParticipatingPartyUpdateRequestDto> get copyWith => ParticipatingPartyUpdateRequestDtoCopyWith(this, $identity);
}

abstract class ParticipatingPartyUpdateRequestDtoCopyWith<$R> {
  factory ParticipatingPartyUpdateRequestDtoCopyWith(ParticipatingPartyUpdateRequestDto value, Then<ParticipatingPartyUpdateRequestDto, $R> then) = _ParticipatingPartyUpdateRequestDtoCopyWithImpl<$R>;
  $R call({String? id, String? title, List<String>? names});
  $R apply(ParticipatingPartyUpdateRequestDto Function(ParticipatingPartyUpdateRequestDto) transform);
}

class _ParticipatingPartyUpdateRequestDtoCopyWithImpl<$R> extends BaseCopyWith<ParticipatingPartyUpdateRequestDto, $R> implements ParticipatingPartyUpdateRequestDtoCopyWith<$R> {
  _ParticipatingPartyUpdateRequestDtoCopyWithImpl(ParticipatingPartyUpdateRequestDto value, Then<ParticipatingPartyUpdateRequestDto, $R> then) : super(value, then);

  @override $R call({String? id, String? title, List<String>? names}) => $then(ParticipatingPartyUpdateRequestDto(id: id ?? $value.id, title: title ?? $value.title, names: names ?? $value.names));
}

class StageActivityResultCreationRequestDtoMapper extends BaseMapper<StageActivityResultCreationRequestDto> {
  StageActivityResultCreationRequestDtoMapper._();

  @override Function get decoder => decode;
  StageActivityResultCreationRequestDto decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  StageActivityResultCreationRequestDto fromMap(Map<String, dynamic> map) => StageActivityResultCreationRequestDto(answers: Mapper.i.$get(map, 'answers'), participatingPartyId: Mapper.i.$get(map, 'participatingPartyId'), stageActivityId: Mapper.i.$get(map, 'stageActivityId'));

  @override Function get encoder => (StageActivityResultCreationRequestDto v) => encode(v);
  dynamic encode(StageActivityResultCreationRequestDto v) => toMap(v);
  Map<String, dynamic> toMap(StageActivityResultCreationRequestDto s) => {'answers': Mapper.i.$enc(s.answers, 'answers'), 'participatingPartyId': Mapper.i.$enc(s.participatingPartyId, 'participatingPartyId'), 'stageActivityId': Mapper.i.$enc(s.stageActivityId, 'stageActivityId')};

  @override String stringify(StageActivityResultCreationRequestDto self) => 'StageActivityResultCreationRequestDto(answers: ${Mapper.asString(self.answers)}, participatingPartyId: ${Mapper.asString(self.participatingPartyId)}, stageActivityId: ${Mapper.asString(self.stageActivityId)})';
  @override int hash(StageActivityResultCreationRequestDto self) => Mapper.hash(self.answers) ^ Mapper.hash(self.participatingPartyId) ^ Mapper.hash(self.stageActivityId);
  @override bool equals(StageActivityResultCreationRequestDto self, StageActivityResultCreationRequestDto other) => Mapper.isEqual(self.answers, other.answers) && Mapper.isEqual(self.participatingPartyId, other.participatingPartyId) && Mapper.isEqual(self.stageActivityId, other.stageActivityId);

  @override Function get typeFactory => (f) => f<StageActivityResultCreationRequestDto>();
}

extension StageActivityResultCreationRequestDtoMapperExtension  on StageActivityResultCreationRequestDto {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  StageActivityResultCreationRequestDtoCopyWith<StageActivityResultCreationRequestDto> get copyWith => StageActivityResultCreationRequestDtoCopyWith(this, $identity);
}

abstract class StageActivityResultCreationRequestDtoCopyWith<$R> {
  factory StageActivityResultCreationRequestDtoCopyWith(StageActivityResultCreationRequestDto value, Then<StageActivityResultCreationRequestDto, $R> then) = _StageActivityResultCreationRequestDtoCopyWithImpl<$R>;
  $R call({List<String>? answers, String? participatingPartyId, String? stageActivityId});
  $R apply(StageActivityResultCreationRequestDto Function(StageActivityResultCreationRequestDto) transform);
}

class _StageActivityResultCreationRequestDtoCopyWithImpl<$R> extends BaseCopyWith<StageActivityResultCreationRequestDto, $R> implements StageActivityResultCreationRequestDtoCopyWith<$R> {
  _StageActivityResultCreationRequestDtoCopyWithImpl(StageActivityResultCreationRequestDto value, Then<StageActivityResultCreationRequestDto, $R> then) : super(value, then);

  @override $R call({List<String>? answers, String? participatingPartyId, String? stageActivityId}) => $then(StageActivityResultCreationRequestDto(answers: answers ?? $value.answers, participatingPartyId: participatingPartyId ?? $value.participatingPartyId, stageActivityId: stageActivityId ?? $value.stageActivityId));
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
