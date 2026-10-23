// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervento_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetInterventoIsarCollection on Isar {
  IsarCollection<InterventoIsar> get interventoIsars => this.collection();
}

const InterventoIsarSchema = CollectionSchema(
  name: r'InterventoIsar',
  id: 2679557326501096508,
  properties: {
    r'cliente': PropertySchema(
      id: 0,
      name: r'cliente',
      type: IsarType.string,
    ),
    r'dataCreazione': PropertySchema(
      id: 1,
      name: r'dataCreazione',
      type: IsarType.dateTime,
    ),
    r'dataScadenza': PropertySchema(
      id: 2,
      name: r'dataScadenza',
      type: IsarType.dateTime,
    ),
    r'dataUltimaModifica': PropertySchema(
      id: 3,
      name: r'dataUltimaModifica',
      type: IsarType.dateTime,
    ),
    r'descrizione': PropertySchema(
      id: 4,
      name: r'descrizione',
      type: IsarType.string,
    ),
    r'eliminato': PropertySchema(
      id: 5,
      name: r'eliminato',
      type: IsarType.bool,
    ),
    r'priorita': PropertySchema(
      id: 6,
      name: r'priorita',
      type: IsarType.string,
    ),
    r'sincronizzato': PropertySchema(
      id: 7,
      name: r'sincronizzato',
      type: IsarType.bool,
    ),
    r'stato': PropertySchema(
      id: 8,
      name: r'stato',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 9,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'tecnicoAssegnato': PropertySchema(
      id: 10,
      name: r'tecnicoAssegnato',
      type: IsarType.string,
    ),
    r'titolo': PropertySchema(
      id: 11,
      name: r'titolo',
      type: IsarType.string,
    ),
    r'ultimaModificaDa': PropertySchema(
      id: 12,
      name: r'ultimaModificaDa',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 13,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _interventoIsarEstimateSize,
  serialize: _interventoIsarSerialize,
  deserialize: _interventoIsarDeserialize,
  deserializeProp: _interventoIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _interventoIsarGetId,
  getLinks: _interventoIsarGetLinks,
  attach: _interventoIsarAttach,
  version: '3.0.5',
);

int _interventoIsarEstimateSize(
  InterventoIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cliente.length * 3;
  bytesCount += 3 + object.descrizione.length * 3;
  bytesCount += 3 + object.priorita.length * 3;
  bytesCount += 3 + object.stato.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.tecnicoAssegnato;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.titolo.length * 3;
  {
    final value = object.ultimaModificaDa;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _interventoIsarSerialize(
  InterventoIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cliente);
  writer.writeDateTime(offsets[1], object.dataCreazione);
  writer.writeDateTime(offsets[2], object.dataScadenza);
  writer.writeDateTime(offsets[3], object.dataUltimaModifica);
  writer.writeString(offsets[4], object.descrizione);
  writer.writeBool(offsets[5], object.eliminato);
  writer.writeString(offsets[6], object.priorita);
  writer.writeBool(offsets[7], object.sincronizzato);
  writer.writeString(offsets[8], object.stato);
  writer.writeStringList(offsets[9], object.tags);
  writer.writeString(offsets[10], object.tecnicoAssegnato);
  writer.writeString(offsets[11], object.titolo);
  writer.writeString(offsets[12], object.ultimaModificaDa);
  writer.writeString(offsets[13], object.uuid);
}

InterventoIsar _interventoIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InterventoIsar();
  object.cliente = reader.readString(offsets[0]);
  object.dataCreazione = reader.readDateTime(offsets[1]);
  object.dataScadenza = reader.readDateTimeOrNull(offsets[2]);
  object.dataUltimaModifica = reader.readDateTimeOrNull(offsets[3]);
  object.descrizione = reader.readString(offsets[4]);
  object.eliminato = reader.readBool(offsets[5]);
  object.id = id;
  object.priorita = reader.readString(offsets[6]);
  object.sincronizzato = reader.readBool(offsets[7]);
  object.stato = reader.readString(offsets[8]);
  object.tags = reader.readStringList(offsets[9]) ?? [];
  object.tecnicoAssegnato = reader.readStringOrNull(offsets[10]);
  object.titolo = reader.readString(offsets[11]);
  object.ultimaModificaDa = reader.readStringOrNull(offsets[12]);
  object.uuid = reader.readStringOrNull(offsets[13]);
  return object;
}

P _interventoIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _interventoIsarGetId(InterventoIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _interventoIsarGetLinks(InterventoIsar object) {
  return [];
}

void _interventoIsarAttach(
    IsarCollection<dynamic> col, Id id, InterventoIsar object) {
  object.id = id;
}

extension InterventoIsarQueryWhereSort
    on QueryBuilder<InterventoIsar, InterventoIsar, QWhere> {
  QueryBuilder<InterventoIsar, InterventoIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InterventoIsarQueryWhere
    on QueryBuilder<InterventoIsar, InterventoIsar, QWhereClause> {
  QueryBuilder<InterventoIsar, InterventoIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InterventoIsarQueryFilter
    on QueryBuilder<InterventoIsar, InterventoIsar, QFilterCondition> {
  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cliente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cliente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      clienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataCreazioneEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataCreazione',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataCreazioneGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataCreazione',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataCreazioneLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataCreazione',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataCreazioneBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataCreazione',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataScadenzaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataScadenza',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataScadenzaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataScadenza',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataScadenzaEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataScadenza',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataScadenzaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataScadenza',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataScadenzaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataScadenza',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataScadenzaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataScadenza',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataUltimaModificaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataUltimaModifica',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataUltimaModificaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataUltimaModifica',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataUltimaModificaEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataUltimaModifica',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataUltimaModificaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataUltimaModifica',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataUltimaModificaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataUltimaModifica',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      dataUltimaModificaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataUltimaModifica',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descrizione',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descrizione',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      descrizioneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      eliminatoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eliminato',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priorita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priorita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priorita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priorita',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'priorita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'priorita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'priorita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'priorita',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priorita',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      prioritaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priorita',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      sincronizzatoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sincronizzato',
        value: value,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stato',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stato',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stato',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      statoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stato',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tecnicoAssegnato',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tecnicoAssegnato',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tecnicoAssegnato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tecnicoAssegnato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tecnicoAssegnato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tecnicoAssegnato',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tecnicoAssegnato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tecnicoAssegnato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tecnicoAssegnato',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tecnicoAssegnato',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tecnicoAssegnato',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      tecnicoAssegnatoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tecnicoAssegnato',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titolo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titolo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titolo',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      titoloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titolo',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ultimaModificaDa',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ultimaModificaDa',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ultimaModificaDa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ultimaModificaDa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ultimaModificaDa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ultimaModificaDa',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ultimaModificaDa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ultimaModificaDa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ultimaModificaDa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ultimaModificaDa',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ultimaModificaDa',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      ultimaModificaDaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ultimaModificaDa',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension InterventoIsarQueryObject
    on QueryBuilder<InterventoIsar, InterventoIsar, QFilterCondition> {}

extension InterventoIsarQueryLinks
    on QueryBuilder<InterventoIsar, InterventoIsar, QFilterCondition> {}

extension InterventoIsarQuerySortBy
    on QueryBuilder<InterventoIsar, InterventoIsar, QSortBy> {
  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDataCreazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCreazione', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDataCreazioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCreazione', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDataScadenza() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataScadenza', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDataScadenzaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataScadenza', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDataUltimaModifica() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDataUltimaModificaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByEliminato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByEliminatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByPriorita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priorita', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByPrioritaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priorita', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortBySincronizzato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizzato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortBySincronizzatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizzato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByStato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByStatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByTecnicoAssegnato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnicoAssegnato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByTecnicoAssegnatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnicoAssegnato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByTitolo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByTitoloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByUltimaModificaDa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaModificaDa', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      sortByUltimaModificaDaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaModificaDa', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension InterventoIsarQuerySortThenBy
    on QueryBuilder<InterventoIsar, InterventoIsar, QSortThenBy> {
  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDataCreazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCreazione', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDataCreazioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCreazione', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDataScadenza() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataScadenza', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDataScadenzaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataScadenza', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDataUltimaModifica() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDataUltimaModificaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByEliminato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByEliminatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eliminato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByPriorita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priorita', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByPrioritaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priorita', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenBySincronizzato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizzato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenBySincronizzatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizzato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByStato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByStatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByTecnicoAssegnato() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnicoAssegnato', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByTecnicoAssegnatoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tecnicoAssegnato', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByTitolo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByTitoloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByUltimaModificaDa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaModificaDa', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy>
      thenByUltimaModificaDaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaModificaDa', Sort.desc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension InterventoIsarQueryWhereDistinct
    on QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> {
  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByCliente(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cliente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctByDataCreazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCreazione');
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctByDataScadenza() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataScadenza');
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctByDataUltimaModifica() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataUltimaModifica');
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByDescrizione(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descrizione', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctByEliminato() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eliminato');
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByPriorita(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priorita', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctBySincronizzato() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sincronizzato');
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByStato(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stato', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctByTecnicoAssegnato({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tecnicoAssegnato',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByTitolo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titolo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct>
      distinctByUltimaModificaDa({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ultimaModificaDa',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InterventoIsar, InterventoIsar, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension InterventoIsarQueryProperty
    on QueryBuilder<InterventoIsar, InterventoIsar, QQueryProperty> {
  QueryBuilder<InterventoIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InterventoIsar, String, QQueryOperations> clienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cliente');
    });
  }

  QueryBuilder<InterventoIsar, DateTime, QQueryOperations>
      dataCreazioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCreazione');
    });
  }

  QueryBuilder<InterventoIsar, DateTime?, QQueryOperations>
      dataScadenzaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataScadenza');
    });
  }

  QueryBuilder<InterventoIsar, DateTime?, QQueryOperations>
      dataUltimaModificaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataUltimaModifica');
    });
  }

  QueryBuilder<InterventoIsar, String, QQueryOperations> descrizioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descrizione');
    });
  }

  QueryBuilder<InterventoIsar, bool, QQueryOperations> eliminatoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eliminato');
    });
  }

  QueryBuilder<InterventoIsar, String, QQueryOperations> prioritaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priorita');
    });
  }

  QueryBuilder<InterventoIsar, bool, QQueryOperations> sincronizzatoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sincronizzato');
    });
  }

  QueryBuilder<InterventoIsar, String, QQueryOperations> statoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stato');
    });
  }

  QueryBuilder<InterventoIsar, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<InterventoIsar, String?, QQueryOperations>
      tecnicoAssegnatoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tecnicoAssegnato');
    });
  }

  QueryBuilder<InterventoIsar, String, QQueryOperations> titoloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titolo');
    });
  }

  QueryBuilder<InterventoIsar, String?, QQueryOperations>
      ultimaModificaDaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ultimaModificaDa');
    });
  }

  QueryBuilder<InterventoIsar, String?, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
