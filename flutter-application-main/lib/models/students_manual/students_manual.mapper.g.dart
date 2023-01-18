import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';
import 'package:equatable/src/equatable.dart';

import 'article.dart';
import 'attachment.dart';
import 'external_link.dart';
import 'pdf_document.dart';
import 'tag.dart';
import 'video.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  ArticleMapper._(),
  EquatableMapper._(),
  AttachmentMapper._(),
  ExternalLinkMapper._(),
  PdfDocumentMapper._(),
  TagMapper._(),
  VideoMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class ArticleMapper extends BaseMapper<Article> {
  ArticleMapper._();

  @override Function get decoder => decode;
  Article decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Article fromMap(Map<String, dynamic> map) => Article(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'), content: Mapper.i.$get(map, 'content'), viewCounter: Mapper.i.$getOpt(map, 'viewCounter') ?? 0, tags: Mapper.i.$getOpt(map, 'tags') ?? const [], attachments: Mapper.i.$getOpt(map, 'attachments') ?? const []);

  @override Function get encoder => (Article v) => encode(v);
  dynamic encode(Article v) => toMap(v);
  Map<String, dynamic> toMap(Article a) => {'id': Mapper.i.$enc(a.id, 'id'), 'title': Mapper.i.$enc(a.title, 'title'), 'content': Mapper.i.$enc(a.content, 'content'), 'viewCounter': Mapper.i.$enc(a.viewCounter, 'viewCounter'), 'tags': Mapper.i.$enc(a.tags, 'tags'), 'attachments': Mapper.i.$enc(a.attachments, 'attachments')};

  @override String stringify(Article self) => 'Article(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, content: ${Mapper.asString(self.content)}, viewCounter: ${Mapper.asString(self.viewCounter)}, attachments: ${Mapper.asString(self.attachments)}, tags: ${Mapper.asString(self.tags)})';
  @override int hash(Article self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.content) ^ Mapper.hash(self.viewCounter) ^ Mapper.hash(self.attachments) ^ Mapper.hash(self.tags);
  @override bool equals(Article self, Article other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.content, other.content) && Mapper.isEqual(self.viewCounter, other.viewCounter) && Mapper.isEqual(self.attachments, other.attachments) && Mapper.isEqual(self.tags, other.tags);

  @override Function get typeFactory => (f) => f<Article>();
}

extension ArticleMapperExtension  on Article {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ArticleCopyWith<Article> get copyWith => ArticleCopyWith(this, $identity);
}

abstract class ArticleCopyWith<$R> {
  factory ArticleCopyWith(Article value, Then<Article, $R> then) = _ArticleCopyWithImpl<$R>;
  ListCopyWith<$R, Tag, TagCopyWith<$R>> get tags;
  $R call({String? id, String? title, String? content, int? viewCounter, List<Tag>? tags, List<Attachment>? attachments});
  $R apply(Article Function(Article) transform);
}

class _ArticleCopyWithImpl<$R> extends BaseCopyWith<Article, $R> implements ArticleCopyWith<$R> {
  _ArticleCopyWithImpl(Article value, Then<Article, $R> then) : super(value, then);

  @override ListCopyWith<$R, Tag, TagCopyWith<$R>> get tags => ListCopyWith($value.tags, (v, t) => TagCopyWith(v, t), (v) => call(tags: v));
  @override $R call({String? id, String? title, String? content, int? viewCounter, List<Tag>? tags, List<Attachment>? attachments}) => $then(Article(id: id ?? $value.id, title: title ?? $value.title, content: content ?? $value.content, viewCounter: viewCounter ?? $value.viewCounter, tags: tags ?? $value.tags, attachments: attachments ?? $value.attachments));
}

class EquatableMapper extends BaseMapper<Equatable> {
  EquatableMapper._();

  @override Function get decoder => decode;
  Equatable decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Equatable fromMap(Map<String, dynamic> map) => throw MapperException.missingConstructor('Equatable');

  @override Function get encoder => (Equatable v) => encode(v);
  dynamic encode(Equatable v) {
    if (v is Article) { return ArticleMapper._().encode(v); }
    else if (v is Attachment) { return AttachmentMapper._().encode(v); }
    else if (v is Tag) { return TagMapper._().encode(v); }
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

class AttachmentMapper extends BaseMapper<Attachment> {
  AttachmentMapper._();

  @override Function get decoder => decode;
  Attachment decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case "link": return ExternalLinkMapper._().decode(map);
      case "pdf": return PdfDocumentMapper._().decode(map);
      case "video": return VideoMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  Attachment fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('Attachment', 'type', '${map['type']}');

  @override Function get encoder => (Attachment v) => encode(v);
  dynamic encode(Attachment v) {
    if (v is ExternalLink) { return ExternalLinkMapper._().encode(v); }
    else if (v is PdfDocument) { return PdfDocumentMapper._().encode(v); }
    else if (v is Video) { return VideoMapper._().encode(v); }
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

class ExternalLinkMapper extends BaseMapper<ExternalLink> {
  ExternalLinkMapper._();

  @override Function get decoder => decode;
  ExternalLink decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ExternalLink fromMap(Map<String, dynamic> map) => ExternalLink(id: Mapper.i.$getOpt(map, 'id'), title: Mapper.i.$getOpt(map, 'title'), url: Mapper.i.$getOpt(map, 'url'));

  @override Function get encoder => (ExternalLink v) => encode(v);
  dynamic encode(ExternalLink v) => toMap(v);
  Map<String, dynamic> toMap(ExternalLink e) => {'id': Mapper.i.$enc(e.id, 'id'), 'title': Mapper.i.$enc(e.title, 'title'), 'url': Mapper.i.$enc(e.url, 'url'), 'type': "link"};

  @override String stringify(ExternalLink self) => 'ExternalLink(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, url: ${Mapper.asString(self.url)})';
  @override int hash(ExternalLink self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.url);
  @override bool equals(ExternalLink self, ExternalLink other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.url, other.url);

  @override Function get typeFactory => (f) => f<ExternalLink>();
}

extension ExternalLinkMapperExtension  on ExternalLink {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ExternalLinkCopyWith<ExternalLink> get copyWith => ExternalLinkCopyWith(this, $identity);
}

abstract class ExternalLinkCopyWith<$R> {
  factory ExternalLinkCopyWith(ExternalLink value, Then<ExternalLink, $R> then) = _ExternalLinkCopyWithImpl<$R>;
  $R call({dynamic id, dynamic title, dynamic url});
  $R apply(ExternalLink Function(ExternalLink) transform);
}

class _ExternalLinkCopyWithImpl<$R> extends BaseCopyWith<ExternalLink, $R> implements ExternalLinkCopyWith<$R> {
  _ExternalLinkCopyWithImpl(ExternalLink value, Then<ExternalLink, $R> then) : super(value, then);

  @override $R call({Object? id = $none, Object? title = $none, Object? url = $none}) => $then(ExternalLink(id: or(id, $value.id), title: or(title, $value.title), url: or(url, $value.url)));
}

class PdfDocumentMapper extends BaseMapper<PdfDocument> {
  PdfDocumentMapper._();

  @override Function get decoder => decode;
  PdfDocument decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  PdfDocument fromMap(Map<String, dynamic> map) => PdfDocument(id: Mapper.i.$getOpt(map, 'id'), title: Mapper.i.$getOpt(map, 'title'), url: Mapper.i.$getOpt(map, 'url'));

  @override Function get encoder => (PdfDocument v) => encode(v);
  dynamic encode(PdfDocument v) => toMap(v);
  Map<String, dynamic> toMap(PdfDocument p) => {'id': Mapper.i.$enc(p.id, 'id'), 'title': Mapper.i.$enc(p.title, 'title'), 'url': Mapper.i.$enc(p.url, 'url'), 'type': "pdf"};

  @override String stringify(PdfDocument self) => 'PdfDocument(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, url: ${Mapper.asString(self.url)})';
  @override int hash(PdfDocument self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.url);
  @override bool equals(PdfDocument self, PdfDocument other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.url, other.url);

  @override Function get typeFactory => (f) => f<PdfDocument>();
}

extension PdfDocumentMapperExtension  on PdfDocument {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  PdfDocumentCopyWith<PdfDocument> get copyWith => PdfDocumentCopyWith(this, $identity);
}

abstract class PdfDocumentCopyWith<$R> {
  factory PdfDocumentCopyWith(PdfDocument value, Then<PdfDocument, $R> then) = _PdfDocumentCopyWithImpl<$R>;
  $R call({dynamic id, dynamic title, dynamic url});
  $R apply(PdfDocument Function(PdfDocument) transform);
}

class _PdfDocumentCopyWithImpl<$R> extends BaseCopyWith<PdfDocument, $R> implements PdfDocumentCopyWith<$R> {
  _PdfDocumentCopyWithImpl(PdfDocument value, Then<PdfDocument, $R> then) : super(value, then);

  @override $R call({Object? id = $none, Object? title = $none, Object? url = $none}) => $then(PdfDocument(id: or(id, $value.id), title: or(title, $value.title), url: or(url, $value.url)));
}

class TagMapper extends BaseMapper<Tag> {
  TagMapper._();

  @override Function get decoder => decode;
  Tag decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Tag fromMap(Map<String, dynamic> map) => Tag(id: Mapper.i.$get(map, 'id'), title: Mapper.i.$get(map, 'title'));

  @override Function get encoder => (Tag v) => encode(v);
  dynamic encode(Tag v) => toMap(v);
  Map<String, dynamic> toMap(Tag t) => {'id': Mapper.i.$enc(t.id, 'id'), 'title': Mapper.i.$enc(t.title, 'title')};

  @override String stringify(Tag self) => 'Tag(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)})';
  @override int hash(Tag self) => Mapper.hash(self.id) ^ Mapper.hash(self.title);
  @override bool equals(Tag self, Tag other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title);

  @override Function get typeFactory => (f) => f<Tag>();
}

extension TagMapperExtension  on Tag {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  TagCopyWith<Tag> get copyWith => TagCopyWith(this, $identity);
}

abstract class TagCopyWith<$R> {
  factory TagCopyWith(Tag value, Then<Tag, $R> then) = _TagCopyWithImpl<$R>;
  $R call({String? id, String? title});
  $R apply(Tag Function(Tag) transform);
}

class _TagCopyWithImpl<$R> extends BaseCopyWith<Tag, $R> implements TagCopyWith<$R> {
  _TagCopyWithImpl(Tag value, Then<Tag, $R> then) : super(value, then);

  @override $R call({String? id, String? title}) => $then(Tag(id: id ?? $value.id, title: title ?? $value.title));
}

class VideoMapper extends BaseMapper<Video> {
  VideoMapper._();

  @override Function get decoder => decode;
  Video decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Video fromMap(Map<String, dynamic> map) => Video(id: Mapper.i.$getOpt(map, 'id'), title: Mapper.i.$getOpt(map, 'title'), url: Mapper.i.$getOpt(map, 'url'));

  @override Function get encoder => (Video v) => encode(v);
  dynamic encode(Video v) => toMap(v);
  Map<String, dynamic> toMap(Video v) => {'id': Mapper.i.$enc(v.id, 'id'), 'title': Mapper.i.$enc(v.title, 'title'), 'url': Mapper.i.$enc(v.url, 'url'), 'type': "video"};

  @override String stringify(Video self) => 'Video(id: ${Mapper.asString(self.id)}, title: ${Mapper.asString(self.title)}, url: ${Mapper.asString(self.url)})';
  @override int hash(Video self) => Mapper.hash(self.id) ^ Mapper.hash(self.title) ^ Mapper.hash(self.url);
  @override bool equals(Video self, Video other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.title, other.title) && Mapper.isEqual(self.url, other.url);

  @override Function get typeFactory => (f) => f<Video>();
}

extension VideoMapperExtension  on Video {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  VideoCopyWith<Video> get copyWith => VideoCopyWith(this, $identity);
}

abstract class VideoCopyWith<$R> {
  factory VideoCopyWith(Video value, Then<Video, $R> then) = _VideoCopyWithImpl<$R>;
  $R call({dynamic id, dynamic title, dynamic url});
  $R apply(Video Function(Video) transform);
}

class _VideoCopyWithImpl<$R> extends BaseCopyWith<Video, $R> implements VideoCopyWith<$R> {
  _VideoCopyWithImpl(Video value, Then<Video, $R> then) : super(value, then);

  @override $R call({Object? id = $none, Object? title = $none, Object? url = $none}) => $then(Video(id: or(id, $value.id), title: or(title, $value.title), url: or(url, $value.url)));
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
