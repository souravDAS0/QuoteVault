// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteDto {

 String get id; String get text;@JsonKey(name: 'author_id') String get authorId;@JsonKey(name: 'author_name') String get authorName;@JsonKey(name: 'author_description') String? get authorDescription;@JsonKey(name: 'category_id') String get categoryId;@JsonKey(name: 'category_name') String get categoryName;@JsonKey(name: 'likes_count') int get likesCount;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'is_bookmarked') bool get isBookmarked;@JsonKey(name: 'is_featured') bool get isFeatured;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteDtoCopyWith<QuoteDto> get copyWith => _$QuoteDtoCopyWithImpl<QuoteDto>(this as QuoteDto, _$identity);

  /// Serializes this QuoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorDescription, authorDescription) || other.authorDescription == authorDescription)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,authorId,authorName,authorDescription,categoryId,categoryName,likesCount,isFavorite,isBookmarked,isFeatured,imageUrl,createdAt);

@override
String toString() {
  return 'QuoteDto(id: $id, text: $text, authorId: $authorId, authorName: $authorName, authorDescription: $authorDescription, categoryId: $categoryId, categoryName: $categoryName, likesCount: $likesCount, isFavorite: $isFavorite, isBookmarked: $isBookmarked, isFeatured: $isFeatured, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QuoteDtoCopyWith<$Res>  {
  factory $QuoteDtoCopyWith(QuoteDto value, $Res Function(QuoteDto) _then) = _$QuoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String text,@JsonKey(name: 'author_id') String authorId,@JsonKey(name: 'author_name') String authorName,@JsonKey(name: 'author_description') String? authorDescription,@JsonKey(name: 'category_id') String categoryId,@JsonKey(name: 'category_name') String categoryName,@JsonKey(name: 'likes_count') int likesCount,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'is_bookmarked') bool isBookmarked,@JsonKey(name: 'is_featured') bool isFeatured,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$QuoteDtoCopyWithImpl<$Res>
    implements $QuoteDtoCopyWith<$Res> {
  _$QuoteDtoCopyWithImpl(this._self, this._then);

  final QuoteDto _self;
  final $Res Function(QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? authorId = null,Object? authorName = null,Object? authorDescription = freezed,Object? categoryId = null,Object? categoryName = null,Object? likesCount = null,Object? isFavorite = null,Object? isBookmarked = null,Object? isFeatured = null,Object? imageUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorDescription: freezed == authorDescription ? _self.authorDescription : authorDescription // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteDto].
extension QuoteDtoPatterns on QuoteDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteDto value)  $default,){
final _that = this;
switch (_that) {
case _QuoteDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text, @JsonKey(name: 'author_id')  String authorId, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'author_description')  String? authorDescription, @JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'category_name')  String categoryName, @JsonKey(name: 'likes_count')  int likesCount, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'is_bookmarked')  bool isBookmarked, @JsonKey(name: 'is_featured')  bool isFeatured, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.id,_that.text,_that.authorId,_that.authorName,_that.authorDescription,_that.categoryId,_that.categoryName,_that.likesCount,_that.isFavorite,_that.isBookmarked,_that.isFeatured,_that.imageUrl,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text, @JsonKey(name: 'author_id')  String authorId, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'author_description')  String? authorDescription, @JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'category_name')  String categoryName, @JsonKey(name: 'likes_count')  int likesCount, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'is_bookmarked')  bool isBookmarked, @JsonKey(name: 'is_featured')  bool isFeatured, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _QuoteDto():
return $default(_that.id,_that.text,_that.authorId,_that.authorName,_that.authorDescription,_that.categoryId,_that.categoryName,_that.likesCount,_that.isFavorite,_that.isBookmarked,_that.isFeatured,_that.imageUrl,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text, @JsonKey(name: 'author_id')  String authorId, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'author_description')  String? authorDescription, @JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'category_name')  String categoryName, @JsonKey(name: 'likes_count')  int likesCount, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'is_bookmarked')  bool isBookmarked, @JsonKey(name: 'is_featured')  bool isFeatured, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.id,_that.text,_that.authorId,_that.authorName,_that.authorDescription,_that.categoryId,_that.categoryName,_that.likesCount,_that.isFavorite,_that.isBookmarked,_that.isFeatured,_that.imageUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteDto extends QuoteDto {
  const _QuoteDto({required this.id, required this.text, @JsonKey(name: 'author_id') required this.authorId, @JsonKey(name: 'author_name') required this.authorName, @JsonKey(name: 'author_description') this.authorDescription, @JsonKey(name: 'category_id') required this.categoryId, @JsonKey(name: 'category_name') required this.categoryName, @JsonKey(name: 'likes_count') this.likesCount = 0, @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'is_bookmarked') this.isBookmarked = false, @JsonKey(name: 'is_featured') this.isFeatured = false, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _QuoteDto.fromJson(Map<String, dynamic> json) => _$QuoteDtoFromJson(json);

@override final  String id;
@override final  String text;
@override@JsonKey(name: 'author_id') final  String authorId;
@override@JsonKey(name: 'author_name') final  String authorName;
@override@JsonKey(name: 'author_description') final  String? authorDescription;
@override@JsonKey(name: 'category_id') final  String categoryId;
@override@JsonKey(name: 'category_name') final  String categoryName;
@override@JsonKey(name: 'likes_count') final  int likesCount;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'is_bookmarked') final  bool isBookmarked;
@override@JsonKey(name: 'is_featured') final  bool isFeatured;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteDtoCopyWith<_QuoteDto> get copyWith => __$QuoteDtoCopyWithImpl<_QuoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorDescription, authorDescription) || other.authorDescription == authorDescription)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,authorId,authorName,authorDescription,categoryId,categoryName,likesCount,isFavorite,isBookmarked,isFeatured,imageUrl,createdAt);

@override
String toString() {
  return 'QuoteDto(id: $id, text: $text, authorId: $authorId, authorName: $authorName, authorDescription: $authorDescription, categoryId: $categoryId, categoryName: $categoryName, likesCount: $likesCount, isFavorite: $isFavorite, isBookmarked: $isBookmarked, isFeatured: $isFeatured, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteDtoCopyWith<$Res> implements $QuoteDtoCopyWith<$Res> {
  factory _$QuoteDtoCopyWith(_QuoteDto value, $Res Function(_QuoteDto) _then) = __$QuoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String text,@JsonKey(name: 'author_id') String authorId,@JsonKey(name: 'author_name') String authorName,@JsonKey(name: 'author_description') String? authorDescription,@JsonKey(name: 'category_id') String categoryId,@JsonKey(name: 'category_name') String categoryName,@JsonKey(name: 'likes_count') int likesCount,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'is_bookmarked') bool isBookmarked,@JsonKey(name: 'is_featured') bool isFeatured,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$QuoteDtoCopyWithImpl<$Res>
    implements _$QuoteDtoCopyWith<$Res> {
  __$QuoteDtoCopyWithImpl(this._self, this._then);

  final _QuoteDto _self;
  final $Res Function(_QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? authorId = null,Object? authorName = null,Object? authorDescription = freezed,Object? categoryId = null,Object? categoryName = null,Object? likesCount = null,Object? isFavorite = null,Object? isBookmarked = null,Object? isFeatured = null,Object? imageUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_QuoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorDescription: freezed == authorDescription ? _self.authorDescription : authorDescription // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
