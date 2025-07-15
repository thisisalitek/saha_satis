import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:sqflite/sqflite.dart';

enum CurrentAccountSearchType {
  accountCode,
  accountName;

  String get value {
    switch (this) {
      case CurrentAccountSearchType.accountCode:
        return 'AccountCode';
      case CurrentAccountSearchType.accountName:
        return 'AccountName';
    }
  }
}

class LocalCurrentService {
  LocalCurrentService();

  Future<List<CurrentAccountModel>> getFilteredCurrentAccounts({
    required CurrentAccountSearchType? searchType,
    required String? searchText,
    required int offset,
  }) async {
    final Database db = await DatabaseProvider.instance.database;

    List<dynamic> queryParams = [];
    String queryAdditional = '';

    if (searchType != null && searchText != null) {
      if (searchType == CurrentAccountSearchType.accountCode) {
        queryAdditional = '''
          (CA.code LIKE ? OR CA.code LIKE ? OR CA.code LIKE ?)
        ''';
        queryParams.add("%${searchText.toLowerCase()}%");
        queryParams.add("%${searchText.toUpperCase()}%");
        queryParams.add("%$searchText%");
      } else if (searchType == CurrentAccountSearchType.accountName) {
        queryAdditional = '''
          (CA.title1 LIKE ? OR CA.title1 LIKE ? OR CA.title1 LIKE ?)
        ''';
        queryParams.add("%${searchText.toLowerCase()}%");
        queryParams.add("%${searchText.toUpperCase()}%");
        queryParams.add("%$searchText%");
      }
    }

    // SQL sorgusu: customer_accounts ve customer_addresses tablolarını JOIN ediyoruz.
    // ORDER BY ile belirli bir adresin (örn. en küçük ID'li) her cari hesap için önce gelmesini sağlarız.
    String sql = '''
SELECT
    CA.id AS id,
    CA.code AS code,
    CA.title1 AS name, -- AS name
    CA.title2 AS name2, -- AS name2
    CA.taxOfficeName AS taxOfficeName,
    CA.taxOfficeNo AS taxOfficeNo,
    CA.representativeCode AS representativeCode,
    CA.email AS email,
    CA.mobilePhone AS mobilePhone,
    CA.taxOfficeCode AS taxOfficeCode,
    CA.naceCode1 AS naceCode1,
    CA.naceCode2 AS naceCode2,
    CA.companyType AS companyType,
    CA.createdBy AS createdBy,
    CA.createdAt AS createdAt,
    CA.updatedBy AS updatedBy,
    CA.updatedAt AS updatedAt,

    CAD.id AS adId, -- AS adId (CustomerAddressModel'in 'id'si için alias)
    CAD.accountCode AS accountCode,
    CAD.addressNo AS addressNo,
    CAD.street AS street,
    CAD.neighborhood AS neighborhood,
    CAD.avenue AS avenue,
    CAD.district AS district,
    CAD.apartmentNo AS apartmentNo,
    CAD.zipCode AS zipCode,
    CAD.county AS county,
    CAD.city AS city,
    CAD.addressCode AS addressCode,
    CAD.phoneCountryCode AS phoneCountryCode,
    CAD.phoneAreaCode AS phoneAreaCode,
    CAD.phoneNo1 AS phoneNo1,
    CAD.phoneNo2 AS phoneNo2,
    CAD.representativeCode AS adRepresentativeCode,
    CAD.specialNote AS specialNote,
    CAD.visitDay AS visitDay,
    CAD.gpsLatitude AS gpsLatitude,
    CAD.gpsLongitude AS gpsLongitude,
    CAD.visitWeek AS visitWeek,
    CAD.visitDay2_1 AS visitDay2_1,
    CAD.visitDay2_2 AS visitDay2_2,
    CAD.visitDay2_3 AS visitDay2_3,
    CAD.visitDay2_4 AS visitDay2_4,
    CAD.visitDay2_5 AS visitDay2_5,
    CAD.visitDay2_6 AS visitDay2_6,
    CAD.visitDay2_7 AS visitDay2_7,
    CAD.einvoiceAlias AS einvoiceAlias,
    CAD.createdBy AS adCreatedBy, -- AS adCreatedBy
    CAD.createdAt AS adCreatedAt, -- AS adCreatedAt
    CAD.updatedBy AS adUpdatedBy, -- AS adUpdatedBy
    CAD.updatedAt AS adUpdatedAt -- AS adUpdatedAt
FROM
    customer_accounts CA
LEFT JOIN
    customer_addresses CAD ON CA.code = CAD.accountCode
WHERE
    1=1
    ${queryAdditional.isNotEmpty ? 'AND ($queryAdditional)' : ''}
ORDER BY
    CA.code ASC, CAD.id ASC -- Her cari hesap için en az bir adres gelmesini garanti etmek için sıralama
LIMIT 300 OFFSET $offset;
    ''';

    List<Map<String, dynamic>> result;
    if (queryParams.isNotEmpty) {
      result = await db.rawQuery(sql, queryParams);
    } else {
      result = await db.rawQuery(sql);
    }
    List<CurrentAccountModel> currentAccountModel =
        result.map((map) => CurrentAccountModel.fromJson(map.cast<String, dynamic>())).toList();
    return currentAccountModel;
  }
}
