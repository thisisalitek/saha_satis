// ignore_for_file: unused_local_variable

enum MainAppType { mikro16, mikro17, unknown }

enum FisType { siparis, irsaliye, fatura }
//final Map<String, dynamic> fis = {"tarih": DateTime.now().toIso8601String().substring(0, 10), "cariKod": "120.001"};

class Fis {
  FisType fisType = FisType.siparis;
  int tip = 0;
  int cins = 0;
  int evrakTip = 0;
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
  double miktar2 = 0;
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
  int fiyatListeNo = 1;

  double vergi = 0;
  String sipGuid = "00000000-0000-0000-0000-000000000000";
}

class GlobalMicroPostQuery {
  // Database connection settings, defined as constants.

  MainAppType getMikroDbVersion(String database) {
    if (database.toLowerCase().startsWith('mikrodesktop')) {
      return MainAppType.mikro17;
    } else if (database.toLowerCase().startsWith('mikrodb_v16')) {
      return MainAppType.mikro16;
    } else {
      return MainAppType.unknown;
    }
  }

  static String postIrsaliye(MainAppType mainApp, Fis fis) {
    var sthFields16 = """""";
    var sthValues16 = """""";
    var sthFields17 =
        """, sth_MainProgramNo, sth_VersionNo, sth_MenuNo, sth_MikroSpecial1, sth_MikroSpecial2, sth_MikroSpecial3, 
      sth_ExternalProgramType, sth_ExternalProgramId, sth_Hash
      """;
    var sthValues17 =
        """, 1 /*sth_MainProgramNo*/, @ /*sth_VersionNo*/, '360231' /*sth_MenuNo*/, '' /*sth_MikroSpecial1*/, '' /*sth_MikroSpecial2*/, '' /*sth_MikroSpecial3*/, 
      0 /*sth_ExternalProgramType*/, '' /*sth_ExternalProgramId*/, 0 /*sth_Hash*/
      """;
    var q =
        """
        DECLARE @EvrakSeri VARCHAR(4)='${fis.evrakSeri}';
        DECLARE @EvrakSira INT=0;
        DECLARE @SatirNo INT=0;
        DECLARE @MikroUserNo INT=99;
        DECLARE @ VARCHAR(20)="";
        DECLARE @FIRMANO INT=0;
        DECLARE @SUBENO INT=0;
        DECLARE @STH_CINS INT=${fis.cins};
        DECLARE @STH_TIP INT=${fis.tip};
        DECLARE @STH_EVRAKTIP INT=${fis.evrakTip};
        DECLARE @STH_NORMAL_IADE INT=${fis.normalIade};

        DECLARE @CariSorMerkez VARCHAR(25)='${fis.sorMerkez}';
        DECLARE @StokSorMerkez VARCHAR(25)='${fis.sorMerkez}';
        SELECT @EvrakSira=ISNULL(MAX(sth_evrakno_sira),0)+1 FROM STOK_HAREKETLERI WHERE sth_evraktip=@STH_EVRAKTIP AND sth_evrakno_seri=@EvrakSeri;
       
        """;
    if (mainApp == MainAppType.mikro17) {
      q += """ 
        IF EXISTS(SELECT TOP 1 * FROM DEPOLAR) BEGIN
          SELECT TOP 1 @=dep_VersionNo FROM DEPOLAR ORDER BY dep_no DESC
        END
      """;
    }
    for (var line in fis.lines) {
      q +=
          """ 
      INSERT INTO STOK_HAREKETLERI (sth_Guid, sth_DBCno, sth_SpecRECno, sth_iptal, sth_fileid, sth_hidden, sth_kilitli, sth_degisti, sth_checksum, sth_create_user,
        sth_create_date, sth_lastup_user, sth_lastup_date, sth_special1, sth_special2, sth_special3, sth_firmano, sth_subeno, sth_tarih, sth_tip, sth_cins,
        sth_normal_iade, sth_evraktip, sth_evrakno_seri, sth_evrakno_sira, sth_satirno, sth_belge_no, sth_belge_tarih, sth_stok_kod, 
        sth_isk_mas1, sth_isk_mas2, sth_isk_mas3, sth_isk_mas4, sth_isk_mas5, sth_isk_mas6, sth_isk_mas7, sth_isk_mas8, sth_isk_mas9, 
        sth_isk_mas10, sth_sat_iskmas1, sth_sat_iskmas2, sth_sat_iskmas3, sth_sat_iskmas4, sth_sat_iskmas5, sth_sat_iskmas6, sth_sat_iskmas7, 
        sth_sat_iskmas8, sth_sat_iskmas9, sth_sat_iskmas10, sth_pos_satis, sth_promosyon_fl, sth_cari_cinsi, sth_cari_kodu, sth_cari_grup_no, 
        sth_isemri_gider_kodu, sth_plasiyer_kodu, sth_har_doviz_cinsi, sth_har_doviz_kuru, sth_alt_doviz_kuru, sth_stok_doviz_cinsi, 
        sth_stok_doviz_kuru, sth_miktar, sth_miktar2, sth_birim_pntr, sth_tutar, sth_iskonto1, sth_iskonto2, sth_iskonto3, sth_iskonto4, 
        sth_iskonto5, sth_iskonto6, sth_masraf1, sth_masraf2, sth_masraf3, sth_masraf4, sth_vergi_pntr, sth_vergi, sth_masraf_vergi_pntr, 
        sth_masraf_vergi, sth_netagirlik, sth_odeme_op, sth_aciklama, sth_sip_uid, sth_fat_uid, sth_giris_depo_no, sth_cikis_depo_no, 
        sth_malkbl_sevk_tarihi, sth_cari_srm_merkezi, sth_stok_srm_merkezi, sth_fis_tarihi, sth_fis_sirano, sth_vergisiz_fl, 
        sth_maliyet_ana, sth_maliyet_alternatif, sth_maliyet_orjinal, sth_adres_no, sth_parti_kodu, sth_lot_no, sth_kons_uid, sth_proje_kodu, 
        sth_exim_kodu, sth_otv_pntr, sth_otv_vergi, sth_brutagirlik, sth_disticaret_turu, sth_otvtutari, sth_otvvergisiz_fl, sth_oiv_pntr, 
        sth_oiv_vergi, sth_oivvergisiz_fl, sth_fiyat_liste_no, sth_oivtutari, sth_Tevkifat_turu, sth_nakliyedeposu, sth_nakliyedurumu, 
        sth_yetkili_uid, sth_taxfree_fl, sth_ilave_edilecek_kdv, sth_ismerkezi_kodu, sth_HareketGrupKodu1, sth_HareketGrupKodu2, 
        sth_HareketGrupKodu3, sth_Olcu1, sth_Olcu2, sth_Olcu3, sth_Olcu4, sth_Olcu5, sth_FormulMiktarNo, sth_FormulMiktar, sth_eirs_senaryo, 
        sth_eirs_tipi, sth_teslim_tarihi, sth_matbu_fl, sth_satis_fiyat_doviz_cinsi, sth_satis_fiyat_doviz_kuru, sth_eticaret_kanal_kodu, 
        sth_bagli_ithalat_kodu, sth_tevkifat_sifirlandi_fl
        $sthFields16 $sthFields17)
      VALUES(NEWID() /*sth_Guid*/, 0 /*sth_DBCno*/, 0 /*sth_SpecRECno*/, 0 /*sth_iptal*/, 16 /*sth_fileid*/, 0 /*sth_hidden*/, 0 /*sth_kilitli*/, 
        0 /*sth_degisti*/, 0 /*sth_checksum*/, @MikroUserNo /*sth_create_user*/, GETDATE() /*sth_create_date*/, @MikroUserNo /*sth_lastup_user*/, 
        GETDATE() /*sth_lastup_date*/, '' /*sth_special1*/, '' /*sth_special2*/, '' /*sth_special3*/, @FIRMANO /*sth_firmano*/,  @SUBENO /*sth_subeno*/, 
        '${fis.tarih}' /*sth_tarih*/, @STH_TIP /*sth_tip*/, @STH_CINS /*sth_cins*/,  @STH_NORMAL_IADE /*sth_normal_iade*/, @STH_EVRAKTIP /*sth_evraktip*/, 
        @EvrakSeri /*sth_evrakno_seri*/, @evrakSira /*sth_evrakno_sira*/, @SatirNo /*sth_satirno*/, '${fis.belgeNo}' /*sth_belge_no*/, 
        '${fis.belgeTarihi}' /*sth_belge_tarih*/, '${line.stokKod}' /*sth_stok_kod*/, 
        0 /*sth_isk_mas1*/, 1 /*sth_isk_mas2*/, 1 /*sth_isk_mas3*/, 1 /*sth_isk_mas4*/, 1 /*sth_isk_mas5*/, 1 /*sth_isk_mas6*/, 1 /*sth_isk_mas7*/, 
        1 /*sth_isk_mas8*/, 1 /*sth_isk_mas9*/, 1 /*sth_isk_mas10*/, 0 /*sth_sat_iskmas1*/, 0 /*sth_sat_iskmas2*/, 0 /*sth_sat_iskmas3*/, 
        0 /*sth_sat_iskmas4*/, 0 /*sth_sat_iskmas5*/, 0 /*sth_sat_iskmas6*/, 0 /*sth_sat_iskmas7*/, 0 /*sth_sat_iskmas8*/, 0 /*sth_sat_iskmas9*/, 
        0 /*sth_sat_iskmas10*/, 0 /*sth_pos_satis*/, 0 /*sth_promosyon_fl*/, 0 /*sth_cari_cinsi*/, '${fis.cariKod}' /*sth_cari_kodu*/, 
        0 /*sth_cari_grup_no*/, '' /*sth_isemri_gider_kodu*/, '${fis.saticiKod}' /*sth_plasiyer_kodu*/, 0 /*sth_har_doviz_cinsi*/, 1 /*sth_har_doviz_kuru*/, 
        1 /*sth_alt_doviz_kuru*/, 0 /*sth_stok_doviz_cinsi*/, 1 /*sth_stok_doviz_kuru*/, ${line.miktar} /*sth_miktar*/, ${line.miktar2} /*sth_miktar2*/, 
        ${line.birimPntr} /*sth_birim_pntr*/, ${line.tutar} /*sth_tutar*/, ${line.iskTut1} /*sth_iskonto1*/, ${line.iskTut2} /*sth_iskonto2*/, 
        ${line.iskTut3} /*sth_iskonto3*/, ${line.iskTut4} /*sth_iskonto4*/,  ${line.iskTut5} /*sth_iskonto5*/,  ${line.iskTut6} /*sth_iskonto6*/, 
        0 /*sth_masraf1*/, 0 /*sth_masraf2*/, 0 /*sth_masraf3*/, 0 /*sth_masraf4*/, ${line.vergiPntr} /*sth_vergi_pntr*/, ${line.vergi} /*sth_vergi*/, 
        0 /*sth_masraf_vergi_pntr*/, 0 /*sth_masraf_vergi*/, 0 /*sth_netagirlik*/, ${fis.odemePlanNo} /*sth_odeme_op*/, 
        '${line.aciklama.replaceAll("'", "''").substring(0, 50)}' /*sth_aciklama*/, '${line.sipGuid}' /*sth_sip_uid*/, 
        '00000000-0000-0000-0000-000000000000' /*sth_fat_uid*/, ${fis.depo1} /*sth_giris_depo_no*/, ${fis.depo1} /*sth_cikis_depo_no*/, 
        '${fis.tarih}' /*sth_malkbl_sevk_tarihi*/, @CariSorMerkez /*sth_cari_srm_merkezi*/, @StokSorMerkez /*sth_stok_srm_merkezi*/, 
        '1899-12-30 00:00:00.000' /*sth_fis_tarihi*/, 0 /*sth_fis_sirano*/, 0 /*sth_vergisiz_fl*/, 0 /*sth_maliyet_ana*/, 0 /*sth_maliyet_alternatif*/, 
        0 /*sth_maliyet_orjinal*/, ${fis.cariAdresNo} /*sth_adres_no*/, '${line.partiKodu}' /*sth_parti_kodu*/, ${line.lotNo} /*sth_lot_no*/, 
        '00000000-0000-0000-0000-000000000000' /*sth_kons_uid*/, '${fis.projeKodu}' /*sth_proje_kodu*/, '' /*sth_exim_kodu*/, 0 /*sth_otv_pntr*/, 
        0 /*sth_otv_vergi*/, 0 /*sth_brutagirlik*/, '' /*sth_disticaret_turu*/, 0 /*sth_otvtutari*/, 0 /*sth_otvvergisiz_fl*/, 0 /*sth_oiv_pntr*/, 
        0 /*sth_oiv_vergi*/, 0 /*sth_oivvergisiz_fl*/, ${line.fiyatListeNo} /*sth_fiyat_liste_no*/, 0 /*sth_oivtutari*/, 0 /*sth_Tevkifat_turu*/, 
        0 /*sth_nakliyedeposu*/, 0 /*sth_nakliyedurumu*/, '00000000-0000-0000-0000-000000000000' /*sth_yetkili_uid*/, 0 /*sth_taxfree_fl*/, 
        0 /*sth_ilave_edilecek_kdv*/, '' /*sth_ismerkezi_kodu*/, '' /*sth_HareketGrupKodu1*/, '' /*sth_HareketGrupKodu2*/, 
        '' /*sth_HareketGrupKodu3*/, 0 /*sth_Olcu1*/, 0 /*sth_Olcu2*/, 0 /*sth_Olcu3*/, 0 /*sth_Olcu4*/, 0 /*sth_Olcu5*/, 0 /*sth_FormulMiktarNo*/, 
        0 /*sth_FormulMiktar*/, 0 /*sth_eirs_senaryo*/, 0 /*sth_eirs_tipi*/, '1899-12-30 00:00:00.000' /*sth_teslim_tarihi*/, 0 /*sth_matbu_fl*/, 
        0 /*sth_satis_fiyat_doviz_cinsi*/, 1 /*sth_satis_fiyat_doviz_kuru*/, '' /*sth_eticaret_kanal_kodu*/, 
        '' /*sth_bagli_ithalat_kodu*/, 0 /*sth_tevkifat_sifirlandi_fl*/
        $sthValues16 $sthValues17);

      SET @SatirNo=@SatirNo+1;
      """;
    }

    return q;
  }

  static String postSiparis(MainAppType mainApp, Fis fis) {
    var sipFields16 = """""";
    var sipValues16 = """""";
    var sipFields17 =
        """, sip_MainProgramNo, sip_VersionNo, sip_MenuNo, sip_MikroSpecial1, sip_MikroSpecial2, sip_MikroSpecial3, 
      sip_ExternalProgramType, sip_ExternalProgramId, sip_Hash, sip_miktar2, sip_avans_tutari
      """;
    var sipValues17 =
        """, 1 /*sip_MainProgramNo*/, @ /*sip_VersionNo*/, '22200' /*sip_MenuNo*/, '' /*sip_MikroSpecial1*/, '' /*sip_MikroSpecial2*/, '' /*sip_MikroSpecial3*/, 
      0 /*sip_ExternalProgramType*/, '' /*sip_ExternalProgramId*/, 0 /*sip_Hash*/, 0 /*sip_miktar2*/, 0 /*sip_avans_tutari*/
      """;
    var q =
        """
        DECLARE @EvrakSeri VARCHAR(4)='${fis.evrakSeri}';
        DECLARE @EvrakSira INT=0;
        DECLARE @SatirNo INT=0;
        DECLARE @MikroUserNo INT=99;
        DECLARE @ VARCHAR(20)="";
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
          SELECT TOP 1 @=dep_VersionNo FROM DEPOLAR ORDER BY dep_no DESC
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
        '${line.aciklama.replaceAll("'", "''").substring(0, 50)}' /*sip_aciklama*/, '{line.aciklama.replaceAll("'", "''").substring(50,50)}' /*sip_aciklama2*/, 
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
}
