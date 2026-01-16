// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retryable_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RetryableOperation _$RetryableOperationFromJson(Map<String, dynamic> json) =>
    _RetryableOperation(
      id: json['id'] as String,
      type: $enumDecode(_$OperationTypeEnumMap, json['type']),
      payload: json['payload'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      lastError: json['lastError'] as String?,
    );

Map<String, dynamic> _$RetryableOperationToJson(_RetryableOperation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$OperationTypeEnumMap[instance.type]!,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
      'retryCount': instance.retryCount,
      'maxRetries': instance.maxRetries,
      'lastError': instance.lastError,
    };

const _$OperationTypeEnumMap = {
  OperationType.toggleFavorite: 'toggleFavorite',
  OperationType.createCollection: 'createCollection',
  OperationType.addToCollection: 'addToCollection',
  OperationType.removeFromCollection: 'removeFromCollection',
  OperationType.updateProfile: 'updateProfile',
  OperationType.syncSettings: 'syncSettings',
  OperationType.deleteCollection: 'deleteCollection',
  OperationType.updateCollectionName: 'updateCollectionName',
  OperationType.fetchCollections: 'fetchCollections',
  OperationType.fetchCollectionDetails: 'fetchCollectionDetails',
  OperationType.fetchFavorites: 'fetchFavorites',
  OperationType.fetchQuotes: 'fetchQuotes',
  OperationType.fetchDailyQuote: 'fetchDailyQuote',
};
