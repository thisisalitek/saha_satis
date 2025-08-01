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

  static String postFatura(MainAppType mainApp, Fis fis) {
    var sthFields17 = "";
    var sthValues17 = "";
    var chaFields16 = "";
    var chaValues16 = "";
    var chaFields17 = "";
    var chaValues17 = "";

    if (mainApp == MainAppType.mikro17) {
      chaFields17 =
          """, cha_MainProgramNo, cha_VersionNo, cha_MenuNo, cha_MikroSpecial1, cha_MikroSpecial2, cha_MikroSpecial3, cha_ExternalProgramType, cha_ExternalProgramId, cha_Hash
        , cha_efatura_belge_tipi
        , cha_vergi11, cha_vergi12, cha_vergi13, cha_vergi14, cha_vergi15, cha_vergi16, cha_vergi17, cha_vergi18, cha_vergi19, cha_vergi20
        , cha_ilave_edilecek_kdv11, cha_ilave_edilecek_kdv12, cha_ilave_edilecek_kdv13, cha_ilave_edilecek_kdv14, cha_ilave_edilecek_kdv15
        , cha_ilave_edilecek_kdv16, cha_ilave_edilecek_kdv17, cha_ilave_edilecek_kdv18, cha_ilave_edilecek_kdv19, cha_ilave_edilecek_kdv20
        , cha_tevkifat_sifirlandi_fl, cha_bsba_e_belge_mi, cha_eticaret_kanal_kodu, cha_hizli_satis_kasa_no, cha_ebelge_Islemturu""";
      chaValues17 =
          """, 21 /*cha_MainProgramNo*/, @MikroVersionNo /*cha_VersionNo*/, 61270 /*cha_MenuNo*/, '' /*cha_MikroSpecial1*/, '' /*cha_MikroSpecial2*/, '' /*cha_MikroSpecial3*/, 
          0 /*cha_ExternalProgramType*/, '' /*cha_ExternalProgramId*/, 0 /*cha_Hash*/ 
          , 0 /*cha_efatura_belge_tipi*/ , @Vergi11 /*cha_vergi11*/, @Vergi12 /*cha_vergi12*/, @Vergi13 /*cha_vergi13*/, @Vergi14 /*cha_vergi14*/, @Vergi15 /*cha_vergi15*/
          , @Vergi16 /*cha_vergi16*/, @Vergi17 /*cha_vergi17*/, @Vergi18 /*cha_vergi18*/, @Vergi19 /*cha_vergi19*/, @Vergi20 /*cha_vergi20*/, 0 /*cha_ilave_edilecek_kdv11*/
          , 0 /*cha_ilave_edilecek_kdv12*/, 0 /*cha_ilave_edilecek_kdv13*/, 0 /*cha_ilave_edilecek_kdv14*/, 0 /*cha_ilave_edilecek_kdv15*/
          , 0 /*cha_ilave_edilecek_kdv16*/, 0 /*cha_ilave_edilecek_kdv17*/, 0 /*cha_ilave_edilecek_kdv18*/, 0 /*cha_ilave_edilecek_kdv19*/
          , 0 /*cha_ilave_edilecek_kdv20*/, 0 /*cha_tevkifat_sifirlandi_fl*/, 0 /*cha_bsba_e_belge_mi*/, '' /*cha_eticaret_kanal_kodu*/
          , 0 /*cha_hizli_satis_kasa_no*/, 0 /*cha_ebelge_Islemturu*/""";

      sthFields17 =
          """, sth_MainProgramNo, sth_VersionNo, sth_MenuNo, sth_MikroSpecial1, sth_MikroSpecial2, sth_MikroSpecial3, 
      sth_ExternalProgramType, sth_ExternalProgramId, sth_Hash, sth_eticaret_kanal_kodu, sth_bagli_ithalat_kodu, sth_tevkifat_sifirlandi_fl
      """;
      sthValues17 =
          """, 1 /*sth_MainProgramNo*/, @ /*sth_VersionNo*/, '360231' /*sth_MenuNo*/, '' /*sth_MikroSpecial1*/, '' /*sth_MikroSpecial2*/, '' /*sth_MikroSpecial3*/, 
      0 /*sth_ExternalProgramType*/, '' /*sth_ExternalProgramId*/, 0 /*sth_Hash*/
      """;
    } else if (mainApp == MainAppType.mikro16) {
      chaFields16 = """, cha_disyazilimid  """;
      chaValues16 = """, '' /*cha_disyazilimid*/""";
    }

    int sthEvrakTip = 0;
    int sthCins = 0;
    switch (fis.evrakTip) {
      case 0: // alis faturasi
        sthEvrakTip = 3;
        break;
      case 63: // satis faturasi
        sthEvrakTip = 4;
        break;
      default:
        return "";
    }
    switch (fis.cins) {
      case 6: // toptan fatura
        sthCins = 0;
        break;
      case 7: // perakende fatura
        sthCins = 1;
        break;
      case 12: // fason faturasi
        sthCins = 8;
        break;
      case 13: // dis ticaret faturasi
        sthCins = 12;
        break;
      default:
        return "";
    }
    var q =
        """
        DECLARE @EvrakSeri VARCHAR(4)='${fis.evrakSeri}';
        DECLARE @EvrakSira INT=0;
        DECLARE @SatirNo INT=0;
        DECLARE @MikroUserNo INT=99;
        DECLARE @MikroVersionNo VARCHAR(20)="";
        DECLARE @FIRMANO INT=0;
        DECLARE @SUBENO INT=0;
        DECLARE @CHA_GUID UNIQUEIDENTIFIER;
        DECLARE @CHA_TIP INT = ${fis.tip};
        DECLARE @CHA_CINS INT = 7;
        DECLARE @CHA_IADE INT = ${fis.normalIade};
        DECLARE @CHA_EVRAKTIP INT = ${fis.evrakTip};
        DECLARE @CHA_TPOZ INT = 1;
        DECLARE @CHA_TICARET_TURU INT = ${fis.tip == 1 ? 0 : 1};
        DECLARE @CHA_CARI_CINS INT = 4;

        DECLARE @STH_CINS INT=$sthCins;
        DECLARE @STH_TIP INT=${fis.tip == 0 ? 1 : 0};
        DECLARE @STH_EVRAKTIP INT=$sthEvrakTip;
        DECLARE @STH_NORMAL_IADE INT=${fis.normalIade};

        DECLARE @CariSorMerkez VARCHAR(25)='${fis.sorMerkez}';
        DECLARE @StokSorMerkez VARCHAR(25)='${fis.sorMerkez}';
       
        SET @CHA_GUID=NEWID();
        """;
    if (mainApp == MainAppType.mikro17) {
      q += """ 
        IF EXISTS(SELECT TOP 1 * FROM DEPOLAR) BEGIN
          SELECT TOP 1 @=dep_VersionNo FROM DEPOLAR ORDER BY dep_no DESC
        END
      """;
    }

    List<double> vergiler = [];
    double satisToplam = 0;
    double vergiToplam = 0;
    double iskToplam1 = 0;
    double iskToplam2 = 0;
    double iskToplam3 = 0;
    double iskToplam4 = 0;
    double iskToplam5 = 0;
    double iskToplam6 = 0;
    // List<double> vergiMatrahlari = [];
    for (var i = 0; i <= 20; i++) {
      vergiler.add(0);
      // vergiMatrahlari.add(0);
    }
    for (var line in fis.lines) {
      if (line.vergiPntr >= 0 && line.vergiPntr <= 20) {
        vergiler[line.vergiPntr] += line.vergi;
      }
      satisToplam +=
          line.tutar -
          line.iskTut1 -
          line.iskTut2 -
          line.iskTut3 -
          line.iskTut4 -
          line.iskTut5 -
          line.iskTut6 +
          line.vergi;
      vergiToplam += line.vergi;
      iskToplam1 += line.iskTut1;
      iskToplam2 += line.iskTut2;
      iskToplam3 += line.iskTut3;
      iskToplam4 += line.iskTut4;
      iskToplam5 += line.iskTut5;
      iskToplam6 += line.iskTut6;
    }

    // --- CARI_HAREKETLER ///
    q +=
        """
        SELECT @EvrakSira=ISNULL(MAX(cha_evrakno_sira),0) + 1 FROM CARI_HESAP_HAREKETLERI WITH(NOLOCK)  WHERE cha_evrakno_seri=@EvrakSeri AND cha_evrak_tip=@CHA_EVRAKTIP;

        INSERT INTO CARI_HESAP_HAREKETLERI (cha_Guid, cha_DBCno, cha_SpecRecNo, cha_iptal, cha_fileid, cha_hidden, cha_kilitli, cha_degisti, cha_CheckSum, cha_create_user, 
            cha_create_date, cha_lastup_user, cha_lastup_date, cha_special1, cha_special2, cha_special3, cha_firmano, cha_subeno, cha_evrak_tip, cha_evrakno_seri, cha_evrakno_sira, 
            cha_satir_no, cha_tarihi, cha_tip, cha_cinsi, cha_normal_Iade, cha_tpoz, cha_ticaret_turu, cha_belge_no, cha_belge_tarih, cha_aciklama, cha_satici_kodu, cha_EXIMkodu, 
            cha_projekodu, cha_yat_tes_kodu, cha_cari_cins, cha_kod, cha_ciro_cari_kodu, cha_d_cins, cha_d_kur, cha_altd_kur, cha_grupno, cha_srmrkkodu, cha_kasa_hizmet, cha_kasa_hizkod, 
            cha_karsidcinsi, cha_karsid_kur, cha_karsidgrupno, cha_karsisrmrkkodu, cha_miktari, cha_meblag, cha_aratoplam, cha_vade, cha_Vade_Farki_Yuz, cha_ft_iskonto1, cha_ft_iskonto2, 
            cha_ft_iskonto3, cha_ft_iskonto4, cha_ft_iskonto5, cha_ft_iskonto6, cha_ft_masraf1, cha_ft_masraf2, cha_ft_masraf3, cha_ft_masraf4, cha_isk_mas1, cha_isk_mas2, cha_isk_mas3, 
            cha_isk_mas4, cha_isk_mas5, cha_isk_mas6, cha_isk_mas7, cha_isk_mas8, cha_isk_mas9, cha_isk_mas10, cha_sat_iskmas1, cha_sat_iskmas2, cha_sat_iskmas3, cha_sat_iskmas4, 
            cha_sat_iskmas5, cha_sat_iskmas6, cha_sat_iskmas7, cha_sat_iskmas8, cha_sat_iskmas9, cha_sat_iskmas10, cha_yuvarlama, cha_StFonPntr, cha_stopaj, cha_savsandesfonu, 
            cha_avansmak_damgapul, cha_vergipntr, cha_vergisiz_fl, cha_otvtutari, cha_otvvergisiz_fl, cha_oiv_pntr, cha_oivtutari, cha_oiv_vergi, cha_oivergisiz_fl, cha_fis_tarih, 
            cha_fis_sirano, cha_trefno, cha_sntck_poz, cha_reftarihi, cha_istisnakodu, cha_pos_hareketi, cha_meblag_ana_doviz_icin_gecersiz_fl, cha_meblag_alt_doviz_icin_gecersiz_fl, 
            cha_meblag_orj_doviz_icin_gecersiz_fl, cha_sip_uid, cha_kirahar_uid, cha_vardiya_tarihi, cha_vardiya_no, cha_vardiya_evrak_ti, cha_ebelge_turu, cha_tevkifat_toplam, 
            cha_e_islem_turu, cha_fatura_belge_turu, cha_diger_belge_adi, cha_uuid, cha_adres_no, cha_vergifon_toplam, cha_ilk_belge_tarihi, cha_ilk_belge_doviz_kuru, cha_HareketGrupKodu1, 
            cha_HareketGrupKodu2, cha_HareketGrupKodu3, cha_ebelgeno_seri, cha_ebelgeno_sira, cha_hubid, cha_hubglbid, cha_vergi1, cha_vergi2, cha_vergi3, cha_vergi4, cha_vergi5, cha_vergi6, 
            cha_vergi7, cha_vergi8, cha_vergi9, cha_vergi10, 
            cha_ilave_edilecek_kdv1, cha_ilave_edilecek_kdv2, cha_ilave_edilecek_kdv3, cha_ilave_edilecek_kdv4, cha_ilave_edilecek_kdv5, cha_ilave_edilecek_kdv6, cha_ilave_edilecek_kdv7, 
            cha_ilave_edilecek_kdv8, cha_ilave_edilecek_kdv9, cha_ilave_edilecek_kdv10
            $chaFields17 $chaFields16)
            VALUES(@CHA_GUID /*cha_Guid*/, 0 /*cha_DBCno*/, 0 /*cha_SpecRecNo*/, 0 /*cha_iptal*/, 51 /*cha_fileid*/, 0 /*cha_hidden*/, 0 /*cha_kilitli*/, 0 /*cha_degisti*/,
            0 /*cha_CheckSum*/, @MikroUserNo /*cha_create_user*/, GETDATE() /*cha_create_date*/, @MikroUserNo /*cha_lastup_user*/, GETDATE() /*cha_lastup_date*/, 
            '' /*cha_special1*/, '' /*cha_special2*/, '' /*cha_special3*/, 0 /*cha_firmano*/, 0 /*cha_subeno*/, @CHA_EVRAKTIP /*cha_evrak_tip*/, @EvrakSeri /*cha_evrakno_seri*/,
            @EvrakSira /*cha_evrakno_sira*/, 0 /*cha_satir_no*/, @Tarih /*cha_tarihi*/, @CHA_TIP /*cha_tip*/, @CHA_CINS /*cha_cinsi*/, @CHA_IADE /*cha_normal_Iade*/,
            @CHA_TPOZ /*cha_tpoz*/, @CHA_TICARET_TURU /*cha_ticaret_turu*/, @BelgeNo /*cha_belge_no*/, @Tarih /*cha_belge_tarih*/, '' /*cha_aciklama*/, '' /*cha_satici_kodu*/, '' /*cha_EXIMkodu*/, 
            @ProjeKodu /*cha_projekodu*/, '' /*cha_yat_tes_kodu*/,@CHA_CARI_CINS /*cha_cari_cins*/, @KasaKod /*cha_kod*/, @CariKod /*cha_ciro_cari_kodu*/, 
        0 /*cha_d_cins*/, 1 /*cha_d_kur*/, 1 /*cha_altd_kur*/, 0 /*cha_grupno*/, @SorumlulukMerkezi /*cha_srmrkkodu*/, 0 /*cha_kasa_hizmet*/, '' /*cha_kasa_hizkod*/, 
            0 /*cha_karsidcinsi*/, 1 /*cha_karsid_kur*/, 0 /*cha_karsidgrupno*/, '' /*cha_karsisrmrkkodu*/, 0 /*cha_miktari*/, $satisToplam /*cha_meblag*/,
            ${satisToplam - vergiToplam} /*cha_aratoplam*/, ${fis.odemePlanNo} /*cha_vade*/, 0 /*cha_Vade_Farki_Yuz*/, $iskToplam1 /*cha_ft_iskonto1*/,  $iskToplam2 /*cha_ft_iskonto2*/
            ,  $iskToplam3 /*cha_ft_iskonto3*/,  $iskToplam4 /*cha_ft_iskonto4*/,
            $iskToplam5 /*cha_ft_iskonto5*/, $iskToplam6 /*cha_ft_iskonto6*/, 0 /*cha_ft_masraf1*/, 0 /*cha_ft_masraf2*/, 0 /*cha_ft_masraf3*/, 0 /*cha_ft_masraf4*/, 0 /*cha_isk_mas1*/, 1 /*cha_isk_mas2*/,
            1 /*cha_isk_mas3*/, 1 /*cha_isk_mas4*/, 1 /*cha_isk_mas5*/, 1 /*cha_isk_mas6*/, 1 /*cha_isk_mas7*/, 1 /*cha_isk_mas8*/, 1 /*cha_isk_mas9*/, 1 /*cha_isk_mas10*/, 0 /*cha_sat_iskmas1*/,
            0 /*cha_sat_iskmas2*/, 0 /*cha_sat_iskmas3*/, 0 /*cha_sat_iskmas4*/, 0 /*cha_sat_iskmas5*/, 0 /*cha_sat_iskmas6*/, 0 /*cha_sat_iskmas7*/, 0 /*cha_sat_iskmas8*/, 0 /*cha_sat_iskmas9*/,
            0 /*cha_sat_iskmas10*/, 0 /*cha_yuvarlama*/, 0 /*cha_StFonPntr*/, 0 /*cha_stopaj*/, 0 /*cha_savsandesfonu*/, 0 /*cha_avansmak_damgapul*/, 0 /*cha_vergipntr*/, 0 /*cha_vergisiz_fl*/,
            0 /*cha_otvtutari*/, 0 /*cha_otvvergisiz_fl*/, 0 /*cha_oiv_pntr*/, 0 /*cha_oivtutari*/, 0 /*cha_oiv_vergi*/, 0 /*cha_oivergisiz_fl*/, '1899-12-30 00:00:00.000' /*cha_fis_tarih*/, 
            0 /*cha_fis_sirano*/, '' /*cha_trefno*/, 0 /*cha_sntck_poz*/, '1899-12-30 00:00:00.000' /*cha_reftarihi*/, 0 /*cha_istisnakodu*/, 0 /*cha_pos_hareketi*/, 
            0 /*cha_meblag_ana_doviz_icin_gecersiz_fl*/, 0 /*cha_meblag_alt_doviz_icin_gecersiz_fl*/, 0 /*cha_meblag_orj_doviz_icin_gecersiz_fl*/, '00000000-0000-0000-0000-000000000000' /*cha_sip_uid*/,
            '00000000-0000-0000-0000-000000000000' /*cha_kirahar_uid*/, '1899-12-30 00:00:00.000' /*cha_vardiya_tarihi*/, 0 /*cha_vardiya_no*/, 0 /*cha_vardiya_evrak_ti*/,
             ${fis.normalIade == 1 ? 1 : 0} /*cha_ebelge_turu*/,
            0 /*cha_tevkifat_toplam*/, 0 /*cha_e_islem_turu*/, 0 /*cha_fatura_belge_turu*/, '' /*cha_diger_belge_adi*/, NEWID() /*cha_uuid*/, 1 /*cha_adres_no*/, 0 /*cha_vergifon_toplam*/,
            '1899-12-30 00:00:00.000' /*cha_ilk_belge_tarihi*/, 0 /*cha_ilk_belge_doviz_kuru*/, '' /*cha_HareketGrupKodu1*/, '' /*cha_HareketGrupKodu2*/, '' /*cha_HareketGrupKodu3*/, 
            '' /*cha_ebelgeno_seri*/, 0 /*cha_ebelgeno_sira*/, '' /*cha_hubid*/, '' /*cha_hubglbid*/, @Vergi1 /*cha_vergi1*/, @Vergi2 /*cha_vergi2*/, 
            @Vergi3 /*cha_vergi3*/, @Vergi4 /*cha_vergi4*/, @Vergi5 /*cha_vergi5*/, @Vergi6 /*cha_vergi6*/, @Vergi7 /*cha_vergi7*/, @Vergi8 /*cha_vergi8*/, @Vergi9 /*cha_vergi9*/, 
            @Vergi10 /*cha_vergi10*/, 0 /*cha_ilave_edilecek_kdv1*/, 0 /*cha_ilave_edilecek_kdv2*/,0 /*cha_ilave_edilecek_kdv3*/, 0 /*cha_ilave_edilecek_kdv4*/, 
            0 /*cha_ilave_edilecek_kdv5*/, 0 /*cha_ilave_edilecek_kdv6*/, 0 /*cha_ilave_edilecek_kdv7*/, 0 /*cha_ilave_edilecek_kdv8*/, 0 /*cha_ilave_edilecek_kdv9*/, 0 /*cha_ilave_edilecek_kdv10*/
            $chaValues17 $chaValues16);
    """;
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
        sth_eirs_tipi, sth_teslim_tarihi, sth_matbu_fl, sth_satis_fiyat_doviz_cinsi, sth_satis_fiyat_doviz_kuru
        $sthFields17)
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
        0 /*sth_satis_fiyat_doviz_cinsi*/, 1 /*sth_satis_fiyat_doviz_kuru*/
        $sthValues17);

      SET @SatirNo=@SatirNo+1;
      """;
    }

    return q;
  }

  static String postIrsaliye(MainAppType mainApp, Fis fis) {
    var sthFields17 = "";
    var sthValues17 = "";

    if (mainApp == MainAppType.mikro17) {
      sthFields17 =
          """, sth_MainProgramNo, sth_VersionNo, sth_MenuNo, sth_MikroSpecial1, sth_MikroSpecial2, sth_MikroSpecial3, 
      sth_ExternalProgramType, sth_ExternalProgramId, sth_Hash, sth_eticaret_kanal_kodu, sth_bagli_ithalat_kodu, sth_tevkifat_sifirlandi_fl
      """;
      sthValues17 =
          """, 1 /*sth_MainProgramNo*/, @ /*sth_VersionNo*/, '360231' /*sth_MenuNo*/, '' /*sth_MikroSpecial1*/, '' /*sth_MikroSpecial2*/, '' /*sth_MikroSpecial3*/, 
      0 /*sth_ExternalProgramType*/, '' /*sth_ExternalProgramId*/, 0 /*sth_Hash*/
      """;
    }
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
        sth_eirs_tipi, sth_teslim_tarihi, sth_matbu_fl, sth_satis_fiyat_doviz_cinsi, sth_satis_fiyat_doviz_kuru
        $sthFields17)
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
        0 /*sth_satis_fiyat_doviz_cinsi*/, 1 /*sth_satis_fiyat_doviz_kuru*/
        $sthValues17);

      SET @SatirNo=@SatirNo+1;
      """;
    }

    return q;
  }

  static String postSiparis(MainAppType mainApp, Fis fis) {
    var sipFields16 = "";
    var sipValues16 = "";
    var sipFields17 = "";
    var sipValues17 = "";

    if (mainApp == MainAppType.mikro17) {
      sipFields17 =
          """, sip_MainProgramNo, sip_VersionNo, sip_MenuNo, sip_MikroSpecial1, sip_MikroSpecial2, sip_MikroSpecial3, 
          sip_ExternalProgramType, sip_ExternalProgramId, sip_Hash, sip_miktar2, sip_avans_tutari
          """;
      sipValues17 =
          """, 1 /*sip_MainProgramNo*/, @ /*sip_VersionNo*/, '22200' /*sip_MenuNo*/, '' /*sip_MikroSpecial1*/, '' /*sip_MikroSpecial2*/, '' /*sip_MikroSpecial3*/, 
      0 /*sip_ExternalProgramType*/, '' /*sip_ExternalProgramId*/, 0 /*sip_Hash*/, 0 /*sip_miktar2*/, 0 /*sip_avans_tutari*/
      """;
    }
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
