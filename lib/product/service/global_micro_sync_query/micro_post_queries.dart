// ignore_for_file: unused_local_variable

enum MainAppType { mikro16, mikro17, unknown }

enum FisType { siparis, irsaliye, fatura }
//final Map<String, dynamic> fis = {"tarih": DateTime.now().toIso8601String().substring(0, 10), "cariKod": "120.001"};

class Fis {
  FisType fisType = FisType.siparis;
  int tip = 0;
  int cins = 0;
  int normalIade = 0;
  String evrakSeri = "M1";
  String tarih = DateTime.now().toIso8601String().substring(0, 10);
  String cariKod = "120.001";
  int cariAdresNo = 1;
  int depo1 = 0;
  int depo2 = 0;
  int odemePlanNo = 0;
  String belgeNo = "";
  String belgeTarihi = DateTime.now().toIso8601String().substring(0, 10);
  String saticiKod = "";
  String teslimTuru = "";
  String projeKodu = "";
  String sorMerkez = "";
  List<FisLine> lines = [];
}

class FisLine {
  String stokKod = "";
  String partiKodu = "";
  int lotNo = 0;
  String aciklama = "";
  double miktar = 0;
  int birimPntr = 1;
  double fiyat = 0;
  double tutar = 0;
  double iskTut1 = 0;
  double iskTut2 = 0;
  double iskTut3 = 0;
  double iskTut4 = 0;
  double iskTut5 = 0;
  double iskTut6 = 0;
  int vergiPntr = 0;
  //double vergiYuzde = 0;
  double vergi = 0;
}

class GlobalMicroPostQuery {
  // Database connection settings, defined as constants.
  static const Map<String, dynamic> _dbConfig = {
    "user": "hakan",
    "password": "1475",
    "database": "MikroDB_V16_100",
    "server": "localhost",
    "port": 1440,
    "dialect": "mssql",
    "dialectOptions": {"instanceName": ""},
    "options": {"encrypt": false, "trustServerCertificate": true},
  };

  MainAppType getMikroDbVersion(String database) {
    if (database.toLowerCase().startsWith('mikrodesktop')) {
      return MainAppType.mikro17;
    } else if (database.toLowerCase().startsWith('mikrodb_v16')) {
      return MainAppType.mikro16;
    } else {
      return MainAppType.unknown;
    }
  }

  static String postSiparis(MainAppType mainApp, Fis fis) {
    var sipFields16 = """""";
    var sipValues16 = """""";
    var sipFields17 =
        """, sip_MainProgramNo, sip_VersionNo, sip_MenuNo, sip_MikroSpecial1, sip_MikroSpecial2, sip_MikroSpecial3, 
      sip_ExternalProgramType, sip_ExternalProgramId, sip_Hash, sip_miktar2, sip_avans_tutari
      """;
    var sipValues17 =
        """, 1 /*sip_MainProgramNo*/, @MikroVersionNo /*sip_VersionNo*/, '22200' /*sip_MenuNo*/, '' /*sip_MikroSpecial1*/, '' /*sip_MikroSpecial2*/, '' /*sip_MikroSpecial3*/, 
      0 /*sip_ExternalProgramType*/, '' /*sip_ExternalProgramId*/, 0 /*sip_Hash*/, 0 /*sip_miktar2*/, 0 /*sip_avans_tutari*/
      """;
    var q =
        """
        DECLARE @EvrakSeri VARCHAR(4)='${fis.evrakSeri}';
        DECLARE @EvrakSira INT=0;
        DECLARE @SatirNo INT=0;
        DECLARE @MikroUserNo INT=99;
        DECLARE @MikroVersionNo VARCHAR(20)="";
        DECLARE @FIRMANO INT=0;
        DECLARE @SUBENO INT=0;
        DECLARE @SIP_CINS INT=${fis.cins};
        DECLARE @SIP_TIP INT=${fis.tip};

        DECLARE @CariSorMerkez VARCHAR(25)='${fis.sorMerkez}';
        DECLARE @StokSorMerkez VARCHAR(25)='${fis.sorMerkez}';
        SELECT @EvrakSira=ISNULL(MAX(sip_evrakno_sira),0)+1 FROM SIPARISLER WHERE sip_cins=@SIP_CINS and sip_tip=@SIP_TIP AND sip_evrakno_seri=@EvrakSeri;
       
        """;
    if (mainApp == MainAppType.mikro17) {
      q += """ 
        IF EXISTS(SELECT TOP 1 * FROM DEPOLAR) BEGIN
          SELECT TOP 1 @MikroVersionNo=dep_VersionNo FROM DEPOLAR ORDER BY dep_no DESC
        END
      """;
    }
    for (var line in fis.lines) {
      q +=
          """ 
      INSERT INTO SIPARISLER (sip_Guid, sip_DBCno, sip_SpecRECno, sip_iptal, sip_fileid, sip_hidden, sip_kilitli, sip_degisti, sip_checksum, sip_create_user,
        sip_create_date, sip_lastup_user, sip_lastup_date, sip_special1, sip_special2, sip_special3, sip_firmano, sip_subeno, sip_tarih, sip_teslim_tarih, 
        sip_tip, sip_cins, sip_evrakno_seri, sip_evrakno_sira, sip_satirno, sip_belgeno, sip_belge_tarih, sip_satici_kod, sip_musteri_kod, sip_stok_kod, 
        sip_b_fiyat, sip_miktar, sip_birim_pntr, sip_teslim_miktar, sip_tutar, sip_iskonto_1, sip_iskonto_2, sip_iskonto_3, sip_iskonto_4, sip_iskonto_5,
        sip_iskonto_6, sip_masraf_1, sip_masraf_2, sip_masraf_3, sip_masraf_4, sip_vergi_pntr, sip_vergi, sip_masvergi_pntr, sip_masvergi, sip_opno, 
        sip_aciklama, sip_aciklama2, sip_depono, sip_OnaylayanKulNo, sip_vergisiz_fl, sip_kapat_fl, sip_promosyon_fl, sip_cari_sormerk, sip_stok_sormerk, 
        sip_cari_grupno, sip_doviz_cinsi, sip_doviz_kuru, sip_alt_doviz_kuru, sip_adresno, sip_teslimturu, sip_cagrilabilir_fl, sip_prosip_uid, 
        sip_iskonto1, sip_iskonto2, sip_iskonto3, sip_iskonto4, sip_iskonto5, sip_iskonto6, sip_masraf1, 
        sip_masraf2, sip_masraf3, sip_masraf4, sip_isk1, sip_isk2, sip_isk3, sip_isk4, sip_isk5, sip_isk6, sip_mas1, sip_mas2, sip_mas3, sip_mas4, 
        sip_Exp_Imp_Kodu, sip_kar_orani, sip_durumu, sip_stal_uid, sip_planlananmiktar, sip_teklif_uid, sip_parti_kodu, sip_lot_no, sip_projekodu, 
        sip_fiyat_liste_no, sip_Otv_Pntr, sip_Otv_Vergi, sip_otvtutari, sip_OtvVergisiz_Fl, sip_paket_kod, sip_Rez_uid, sip_harekettipi, sip_yetkili_uid, 
        sip_kapatmanedenkod, sip_gecerlilik_tarihi, sip_onodeme_evrak_tip, sip_onodeme_evrak_seri, sip_onodeme_evrak_sira, sip_rezervasyon_miktari, 
        sip_rezerveden_teslim_edilen, sip_HareketGrupKodu1, sip_HareketGrupKodu2, sip_HareketGrupKodu3, sip_Olcu1, sip_Olcu2, sip_Olcu3, sip_Olcu4, sip_Olcu5, 
        sip_FormulMiktarNo, sip_FormulMiktar, sip_satis_fiyat_doviz_cinsi, sip_satis_fiyat_doviz_kuru, sip_eticaret_kanal_kodu, sip_Tevkifat_turu, sip_otv_tevkifat_turu, 
        sip_otv_tevkifat_tutari, sip_tevkifat_sifirlandi_fl
        $sipFields16$sipFields17)
      VALUES(NEWID() /*sip_Guid*/, 0 /*sip_DBCno*/, 0 /*sip_SpecRECno*/, 0 /*sip_iptal*/, 21 /*sip_fileid*/, 0 /*sip_hidden*/, 0 /*sip_kilitli*/, 0 /*sip_degisti*/, 
        0 /*sip_checksum*/, @MikroUserNo /*sip_create_user*/, GETDATE() /*sip_create_date*/, @MikroUserNo /*sip_lastup_user*/, GETDATE() /*sip_lastup_date*/, 
        '' /*sip_special1*/, '' /*sip_special2*/, '' /*sip_special3*/, @FIRMANO /*sip_firmano*/, @SUBENO /*sip_subeno*/, 
        '${fis.tarih}' /*sip_tarih*/, '${fis.tarih}' /*sip_teslim_tarih*/, @SIP_TIP /*sip_tip*/, @SIP_CINS /*sip_cins*/, 
        @EvrakSeri /*sip_evrakno_seri*/, @EvrakSira /*sip_evrakno_sira*/, @SatirNo /*sip_satirno*/, '${fis.belgeNo}' /*sip_belgeno*/, '${fis.belgeTarihi}' /*sip_belge_tarih*/, 
        '${fis.saticiKod}' /*sip_satici_kod*/, '${fis.cariKod}' /*sip_musteri_kod*/, '${line.stokKod}' /*sip_stok_kod*/, 
        ${line.fiyat} /*sip_b_fiyat*/, ${line.miktar} /*sip_miktar*/, ${line.birimPntr} /*sip_birim_pntr*/, 0 /*sip_teslim_miktar*/, ${line.tutar} /*sip_tutar*/, 
        ${line.iskTut1} /*sip_iskonto_1*/, ${line.iskTut2} /*sip_iskonto_2*/, ${line.iskTut3} /*sip_iskonto_3/*, ${line.iskTut4} /*sip_iskonto_4*/, 
        ${line.iskTut5} /*sip_iskonto_5*/, ${line.iskTut6} /*sip_iskonto_6*/, 0 /*sip_masraf_1*/, 0 /*sip_masraf_2*/, 0 /*sip_masraf_3*/, 0 /*sip_masraf_4*/, 
        ${line.vergiPntr} /*sip_vergi_pntr*/, ${line.vergi} /*sip_vergi*/, 0 /*sip_masvergi_pntr*/, 0 /*sip_masvergi*/, ${fis.odemePlanNo} /*sip_opno*/, 
        ${line.aciklama.replaceAll("'", "''").substring(0, 50)} /*sip_aciklama*/, {line.aciklama.replaceAll("'", "''").substring(50,50)} /*sip_aciklama2*/, 
        ${fis.depo1} /*sip_depono*/, 0 /*sip_OnaylayanKulNo*/, 0 /*sip_vergisiz_fl*/, 0 /*sip_kapat_fl*/, 0 /*sip_promosyon_fl*/, 
        @CariSorMerkez /*sip_cari_sormerk*/, @StokSorMerkez /*sip_stok_sormerk*/, 0 /*sip_cari_grupno*/, 0 /*sip_doviz_cinsi*/, 1 /*sip_doviz_kuru*/, 1 /*sip_alt_doviz_kuru*/, 
        ${fis.cariAdresNo} /*sip_adresno*/, '${fis.teslimTuru}' /*sip_teslimturu*/, 1 /*sip_cagrilabilir_fl*/, '00000000-0000-0000-0000-000000000000' /*sip_prosip_uid*/, 
        0 /*sip_iskonto1*/, 1 /*sip_iskonto2*/, 1 /*sip_iskonto3*/, 1 /*sip_iskonto4*/, 1 /*sip_iskonto5*/, 1 /*sip_iskonto6*/, 1 /*sip_masraf1*/, 
        1 /*sip_masraf2*/, 1 /*sip_masraf3*/, 1 /*sip_masraf4*/, 0 /*sip_isk1*/, 0 /*sip_isk2*/, 0 /*sip_isk3*/, 0 /*sip_isk4*/, 0 /*sip_isk5*/, 0 /*sip_isk6*/, 
        0 /*sip_mas1*/, 0 /*sip_mas2*/, 0 /*sip_mas3*/, 0 /*sip_mas4*/, '' /*sip_Exp_Imp_Kodu*/, 0 /*sip_kar_orani*/, 0 /*sip_durumu*/, 
        '00000000-0000-0000-0000-000000000000' /*sip_stal_uid*/, 0 /*sip_planlananmiktar*/, '00000000-0000-0000-0000-000000000000' /*sip_teklif_uid*/, 
        '${line.partiKodu}' /*sip_parti_kodu*/, ${line.lotNo} /*sip_lot_no*/, '${fis.projeKodu}' /*sip_projekodu*/, 
        0 /*sip_fiyat_liste_no*/, 0 /*sip_Otv_Pntr*/, 0 /*sip_Otv_Vergi*/, 0 /*sip_otvtutari*/, 0 /*sip_OtvVergisiz_Fl*/, '' /*sip_paket_kod*/, 
        '00000000-0000-0000-0000-000000000000' /*sip_Rez_uid*/, 0 /*sip_harekettipi*/, '00000000-0000-0000-0000-000000000000' /*sip_yetkili_uid*/, 
        '' /*sip_kapatmanedenkod*/, '1899-12-30 00:00:00.000' /*sip_gecerlilik_tarihi*/, 0 /*sip_onodeme_evrak_tip*/, '' /*sip_onodeme_evrak_seri*/, 0 /*sip_onodeme_evrak_sira*/, 
        0 /*sip_rezervasyon_miktari*/, 0 /*sip_rezerveden_teslim_edilen*/, '' /*sip_HareketGrupKodu1*/, '' /*sip_HareketGrupKodu2*/, '' /*sip_HareketGrupKodu3*/, 
        0 /*sip_Olcu1*/, 0 /*sip_Olcu2*/, 0 /*sip_Olcu3*/, 0 /*sip_Olcu4*/, 0 /*sip_Olcu5*/, 
        0 /*sip_FormulMiktarNo*/, 0 /*sip_FormulMiktar*/, 0 /*sip_satis_fiyat_doviz_cinsi*/, 1 /*sip_satis_fiyat_doviz_kuru*/, '' /*sip_eticaret_kanal_kodu*/, 0 /*sip_Tevkifat_turu*/, 
        0 /*sip_otv_tevkifat_turu*/, 0 /*sip_otv_tevkifat_tutari*/, 0 /*sip_tevkifat_sifirlandi_fl*/
        $sipValues16$sipValues17);

      SET @SatirNo=@SatirNo+1;
      """;
    }

    return q;
  }

  /// Generates a JSON payload containing the database configuration and the dynamic SQL query.
  ///
  /// The [queryTemplate] parameter takes the SQL query template to be used (e.g., `barcodeSyncQueryTemplate`).
  /// Placeholders within this template are replaced with the provided [lastUpDate], [offset], and [fetchNext] values.
  static Map<String, dynamic> createQueryPayload({
    required String queryTemplate, // Takes the query template
    required String lastUpDate,
    required int offset,
    required int fetchNext,
  }) {
    // Replace placeholders in the query template with actual values.
    final String filledSqlQuery = queryTemplate
        .replaceAll('{lastUpDate}', lastUpDate)
        .replaceAll('{offset}', offset.toString())
        .replaceAll('{fetchNext}', fetchNext.toString());

    return {
      "config": _dbConfig, // Uses the constant DB configuration.
      "query": filledSqlQuery, // Sends the populated SQL query.
    };
  }
}
