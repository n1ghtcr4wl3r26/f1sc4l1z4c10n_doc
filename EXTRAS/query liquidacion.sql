SELECT                                                       --1
                    t  .itm,
                       t.nandina_ant,
                       t.nandina_u,
                       t.reg_year,
                       t.key_cuo,
                       t.reg_nber,
                       t.fecha_reg,
                       t.fecha_venc,
                       t.fecha_calculo,
                       --10
                       t.dec_fob,
                       t.dec_flete,
                       t.dec_seguro,
                       t.dec_otros,
                       t.dec_cifusd,
                       t.dec_tc,
                       t.dec_cifbs,
                       t.dec_ga,
                       t.dec_iva,
                       t.dec_ice,
                       --20
                       t.dec_iehd,
                       t.dec_icd,
                       --22
                       t.enc_fob,
                       t.enc_flete,
                       t.enc_seguro,
                       t.enc_otros,
                       t.enc_cifusd,
                       t.enc_tc,
                       t.enc_cifbs,
                       t.enc_ga,
                       --30
                       t.enc_iva,
                       t.enc_ice,
                       t.enc_iehd,
                       t.enc_icd,
                       --34
                       t.tc_ufvfecvenc,
                       t.to_ga,
                       t.to_iva,
                       t.to_ice,
                       t.to_iehd,
                       t.to_icd,
                       --40
                       t.to_ga + t.to_iva + t.to_ice + t.to_iehd + t.to_icd
                           to_total,
                       --41
                       ROUND (t.to_ga / t.tc_ufvfecvenc, 2) toufv_ga,
                       ROUND (t.to_iva / t.tc_ufvfecvenc, 2) toufv_iva,
                       ROUND (t.to_ice / t.tc_ufvfecvenc, 2) toufv_ice,
                       ROUND (t.to_iehd / t.tc_ufvfecvenc, 2) toufv_iehd,
                       ROUND (t.to_icd / t.tc_ufvfecvenc, 2) toufv_icd,
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd)
                           / t.tc_ufvfecvenc,
                           2)
                           toufv_total,
                       t.dias,
                       ROUND (POWER (1 + (t.tc_tprfecvenc / 360), t.dias), 4)
                           formula,
                       ROUND (t.ga_dt / t.tc_ufvfecvenc, 2)
                       - ROUND (t.to_ga / t.tc_ufvfecvenc, 2)
                           itufv_ga,
                       --50
                       ROUND (t.to_iva / t.tc_ufvfecvenc, 2)
                       - ROUND (t.iva_dt / t.tc_ufvfecvenc, 2)
                           itufv_iva,
                       ROUND (t.to_ice / t.tc_ufvfecvenc, 2)
                       - ROUND (t.ice_dt / t.tc_ufvfecvenc, 2)
                           itufv_ice,
                       ROUND (t.to_iehd / t.tc_ufvfecvenc, 2)
                       - ROUND (t.iehd_dt / t.tc_ufvfecvenc, 2)
                           itufv_iehd,
                       ROUND (t.to_icd / t.tc_ufvfecvenc, 2)
                       - ROUND (t.icd_dt / t.tc_ufvfecvenc, 2)
                           itufv_icd,
                       (ROUND (
                            (  t.to_ga
                             + t.to_iva
                             + t.to_ice
                             + t.to_iehd
                             + t.to_icd)
                            / t.tc_ufvfecvenc,
                            2)
                        - ROUND (
                              (  t.ga_dt
                               + t.iva_dt
                               + t.ice_dt
                               + t.iehd_dt
                               + t.icd_dt)
                              / t.tc_ufvfecvenc,
                              2))
                           itufv_total,
                       --55
                       ROUND ( (t.to_ga + t.ga_dt) / t.tc_ufvhoy, 2) dt_ga,
                       ROUND ( (t.to_iva + t.iva_dt) / t.tc_ufvhoy, 2) dt_iva,
                       ROUND ( (t.to_ice + t.ice_dt) / t.tc_ufvhoy, 2) dt_ice,
                       ROUND ( (t.to_iehd + t.iehd_dt) / t.tc_ufvhoy, 2)
                           dt_iehd,
                       ROUND ( (t.to_icd + t.icd_dt) / t.tc_ufvhoy, 2) dt_icd,
                       --60
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd
                            + t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           / t.tc_ufvfecvenc,
                           2)
                           dt_total,
                       --61
                       ROUND (
                           ( (  t.to_ga
                              + t.to_iva
                              + t.to_ice
                              + t.to_iehd
                              + t.to_icd)
                            / t.tc_ufvhoy)
                           * t.tc_ufvfecvenc,
                           2)
                           sancion,
                       --62
                       ROUND (
                             t.to_ga
                           + t.to_iva
                           + t.to_ice
                           + t.to_iehd
                           + t.to_icd
                           + t.ga_dt
                           + t.iva_dt
                           + t.ice_dt
                           + t.iehd_dt
                           + t.icd_dt,
                           2)
                           adeudo_totalbs,
                       --63
                       ROUND (
                           (  t.to_ga
                            + t.to_iva
                            + t.to_ice
                            + t.to_iehd
                            + t.to_icd
                            + t.ga_dt
                            + t.iva_dt
                            + t.ice_dt
                            + t.iehd_dt
                            + t.icd_dt)
                           / t.tc_ufvhoy,
                           2)
                           adeudo_totalufv,
                       --64
                       t.tc_ufvhoy
                FROM   (
                
                
                
                
                SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (fecha_reporte, 'dd/mm/yyyy')
                                     fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (fecha_reporte),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (fecha_reporte)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt
                          FROM   ops$asy.sad_gen a,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NOT NULL
                                 AND u.key_dec = a.key_dec
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND u.key_dec = iu.key_dec
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND a.key_dec = ia.key_dec
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_dec = ia.key_dec
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND iu.key_dec = gau.key_dec
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND ia.key_dec = gaa.key_dec
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND iu.key_dec = ivau.key_dec
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ia.key_dec = ivaa.key_dec
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iu.key_dec = iceu.key_dec(+)
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND ia.key_dec = icea.key_dec(+)
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iu.key_dec = iehdu.key_dec(+)
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND ia.key_dec = iehda.key_dec(+)
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND iu.key_dec = icdu.key_dec(+)
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND ia.key_dec = icda.key_dec(+)
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND iu.key_dec = vu.key_dec
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND ia.key_dec = va.key_dec
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
                                 
                          UNION
                        SELECT   iu.itm_nber itm,
                                 ia.saditm_hs_cod || ia.saditm_hsprec_cod
                                     nandina_ant,
                                 iu.saditm_hs_cod || iu.saditm_hsprec_cod
                                     nandina_u,
                                 u.sad_reg_year reg_year,
                                 u.key_cuo key_cuo,
                                 u.sad_reg_nber reg_nber,
                                 TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')
                                     fecha_reg,
                                 TO_CHAR (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'dd/mm/yyyy')
                                     fecha_venc,
                                 TO_CHAR (fecha_reporte, 'dd/mm/yyyy')
                                     fecha_calculo,
                                 va.sad_iitminv_valc dec_fob,
                                 va.sad_iitmefr_valc dec_flete,
                                 va.sad_iitmins_valc dec_seguro,
                                 va.sad_iitmotc_valc dec_otros,
                                 ROUND (
                                     va.sad_iitmcif_valn / va.sad_iitminv_rat,
                                     2)
                                     dec_cifusd,
                                 va.sad_iitminv_rat dec_tc,
                                 va.sad_iitmcif_valn dec_cifbs,
                                 gaa.saditm_tax_amount dec_ga,
                                 ivaa.saditm_tax_amount dec_iva,
                                 NVL (icea.saditm_tax_amount, 0) dec_ice,
                                 NVL (iehda.saditm_tax_amount, 0) dec_iehd,
                                 NVL (icda.saditm_tax_amount, 0) dec_icd,
                                 vu.sad_iitminv_valc enc_fob,
                                 vu.sad_iitmefr_valc enc_flete,
                                 vu.sad_iitmins_valc enc_seguro,
                                 vu.sad_iitmotc_valc enc_otros,
                                 ROUND (
                                     vu.sad_iitmcif_valn / vu.sad_iitminv_rat,
                                     2)
                                     enc_cifusd,
                                 vu.sad_iitminv_rat enc_tc,
                                 vu.sad_iitmcif_valn enc_cifbs,
                                 gau.saditm_tax_amount enc_ga,
                                 ivau.saditm_tax_amount enc_iva,
                                 NVL (iceu.saditm_tax_amount, 0) enc_ice,
                                 NVL (iehdu.saditm_tax_amount, 0) enc_iehd,
                                 NVL (icdu.saditm_tax_amount, 0) enc_icd,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'UFV')
                                     tc_ufvfecvenc,
                                 pkg_reporte.tipocambio (TRUNC (fecha_reporte),
                                                         'UFV')
                                     tc_ufvhoy,
                                 gau.saditm_tax_amount - gaa.saditm_tax_amount
                                     to_ga,
                                 ivau.saditm_tax_amount
                                 - ivaa.saditm_tax_amount
                                     to_iva,
                                 NVL (iceu.saditm_tax_amount, 0)
                                 - NVL (icea.saditm_tax_amount, 0)
                                     to_ice,
                                 NVL (iehdu.saditm_tax_amount, 0)
                                 - NVL (iehda.saditm_tax_amount, 0)
                                     to_iehd,
                                 NVL (icdu.saditm_tax_amount, 0)
                                 - NVL (icda.saditm_tax_amount, 0)
                                     to_icd,
                                 TRUNC (fecha_reporte)
                                 - pkg_reporte.fecha_vencimiento (
                                       u.key_cuo,
                                       TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy'))
                                     dias,
                                 pkg_reporte.tipocambio (
                                     pkg_reporte.fecha_vencimiento (
                                         u.key_cuo,
                                         TO_CHAR (a.sad_reg_date, 'dd/mm/yyyy')),
                                     'TPR')
                                     tc_tprfecvenc,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     gau.saditm_tax_amount
                                     - gaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     ga_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     ivau.saditm_tax_amount
                                     - ivaa.saditm_tax_amount,
                                     u.sad_top_cod)
                                     iva_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iceu.saditm_tax_amount, 0)
                                     - NVL (icea.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     ice_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (iehdu.saditm_tax_amount, 0)
                                     - NVL (iehda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     iehd_dt,
                                 ops$asy.fcalculadeudatributaria (
                                     u.sad_reg_date,
                                     TRUNC (fecha_reporte),
                                     u.key_year,
                                     u.key_cuo,
                                     u.key_dec,
                                     u.key_nber,
                                     NVL (icdu.saditm_tax_amount, 0)
                                     - NVL (icda.saditm_tax_amount, 0),
                                     u.sad_top_cod)
                                     icd_dt
                          FROM   ops$asy.sad_gen a,
                                 ops$asy.sad_itm ia,
                                 ops$asy.sad_tax gaa,
                                 ops$asy.sad_tax ivaa,
                                 ops$asy.sad_tax icea,
                                 ops$asy.sad_tax iehda,
                                 ops$asy.sad_tax icda,
                                 ops$asy.sad_itm_vim va,
                                 fis_alcance f,
                                 fis_notificacion n
                         WHERE       u.key_year = a.key_year
                                 AND u.key_cuo = a.key_cuo
                                 AND u.key_dec IS NULL
                                 AND a.key_dec IS NULL
                                 AND u.key_nber = a.key_nber
                                 AND a.sad_num =
                                        NVL (
                                            (SELECT   MIN (x.sad_pst_num)
                                               FROM   ops$asy.sad_gen x
                                              WHERE   x.key_cuo = u.key_cuo
                                                      AND x.sad_reg_year =
                                                             u.sad_reg_year
                                                      AND x.sad_reg_serial =
                                                             u.sad_reg_serial
                                                      AND x.sad_reg_nber =
                                                             u.sad_reg_nber
                                                      AND x.sad_pst_dat >=
                                                             n.not_fecha_notificacion),
                                            0)
                                 AND u.sad_flw = 1
                                 AND u.sad_num = 0
                                 AND u.lst_ope = 'U'
                                 AND u.key_year = iu.key_year
                                 AND u.key_cuo = iu.key_cuo
                                 AND iu.key_dec IS NULL
                                 AND u.key_nber = iu.key_nber
                                 AND u.sad_num = iu.sad_num
                                 AND a.key_year = ia.key_year
                                 AND a.key_cuo = ia.key_cuo
                                 AND ia.key_dec IS NULL
                                 AND a.key_nber = ia.key_nber
                                 AND a.sad_num = ia.sad_num
                                 AND iu.key_year = ia.key_year
                                 AND iu.key_cuo = ia.key_cuo
                                 AND iu.key_nber = ia.key_nber
                                 AND iu.itm_nber = ia.itm_nber
                                 --tributo GA
                                 AND iu.key_year = gau.key_year
                                 AND iu.key_cuo = gau.key_cuo
                                 AND gau.key_dec IS NULL
                                 AND iu.key_nber = gau.key_nber
                                 AND iu.itm_nber = gau.itm_nber
                                 AND iu.sad_num = gau.sad_num
                                 AND gau.saditm_tax_code = 'GA'
                                 AND ia.key_year = gaa.key_year
                                 AND ia.key_cuo = gaa.key_cuo
                                 AND gaa.key_dec IS NULL
                                 AND ia.key_nber = gaa.key_nber
                                 AND ia.itm_nber = gaa.itm_nber
                                 AND ia.sad_num = gaa.sad_num
                                 AND gaa.saditm_tax_code = 'GA'
                                 --tributo IVA
                                 AND iu.key_year = ivau.key_year
                                 AND iu.key_cuo = ivau.key_cuo
                                 AND ivau.key_dec IS NULL
                                 AND iu.key_nber = ivau.key_nber
                                 AND iu.itm_nber = ivau.itm_nber
                                 AND iu.sad_num = ivau.sad_num
                                 AND ivau.saditm_tax_code = 'IVA'
                                 AND ia.key_year = ivaa.key_year
                                 AND ia.key_cuo = ivaa.key_cuo
                                 AND ivaa.key_dec IS NULL
                                 AND ia.key_nber = ivaa.key_nber
                                 AND ia.itm_nber = ivaa.itm_nber
                                 AND ia.sad_num = ivaa.sad_num
                                 AND ivaa.saditm_tax_code = 'IVA'
                                 --tributo ICE
                                 AND iu.key_year = iceu.key_year(+)
                                 AND iu.key_cuo = iceu.key_cuo(+)
                                 AND iceu.key_dec(+) IS NULL
                                 AND iu.key_nber = iceu.key_nber(+)
                                 AND iu.itm_nber = iceu.itm_nber(+)
                                 AND iu.sad_num = iceu.sad_num(+)
                                 AND iceu.saditm_tax_code(+) = 'ICE'
                                 AND ia.key_year = icea.key_year(+)
                                 AND ia.key_cuo = icea.key_cuo(+)
                                 AND icea.key_dec(+) IS NULL
                                 AND ia.key_nber = icea.key_nber(+)
                                 AND ia.itm_nber = icea.itm_nber(+)
                                 AND ia.sad_num = icea.sad_num(+)
                                 AND icea.saditm_tax_code(+) = 'ICE'
                                 --tributo IEHD
                                 AND iu.key_year = iehdu.key_year(+)
                                 AND iu.key_cuo = iehdu.key_cuo(+)
                                 AND iehdu.key_dec(+) IS NULL
                                 AND iu.key_nber = iehdu.key_nber(+)
                                 AND iu.itm_nber = iehdu.itm_nber(+)
                                 AND iu.sad_num = iehdu.sad_num(+)
                                 AND iehdu.saditm_tax_code(+) = 'IEHD'
                                 AND ia.key_year = iehda.key_year(+)
                                 AND ia.key_cuo = iehda.key_cuo(+)
                                 AND iehda.key_dec(+) IS NULL
                                 AND ia.key_nber = iehda.key_nber(+)
                                 AND ia.itm_nber = iehda.itm_nber(+)
                                 AND ia.sad_num = iehda.sad_num(+)
                                 AND iehda.saditm_tax_code(+) = 'IEHD'
                                 --tributo ICD
                                 AND iu.key_year = icdu.key_year(+)
                                 AND iu.key_cuo = icdu.key_cuo(+)
                                 AND icdu.key_dec(+) IS NULL
                                 AND iu.key_nber = icdu.key_nber(+)
                                 AND iu.itm_nber = icdu.itm_nber(+)
                                 AND iu.sad_num = icdu.sad_num(+)
                                 AND icdu.saditm_tax_code(+) = 'ICD'
                                 AND ia.key_year = icda.key_year(+)
                                 AND ia.key_cuo = icda.key_cuo(+)
                                 AND icda.key_dec(+) IS NULL
                                 AND ia.key_nber = icda.key_nber(+)
                                 AND ia.itm_nber = icda.itm_nber(+)
                                 AND ia.sad_num = icda.sad_num(+)
                                 AND icda.saditm_tax_code(+) = 'ICD'
                                 --para los valores FOB FLETE SEGURO OTROS CIF
                                 AND iu.key_year = vu.key_year
                                 AND iu.key_cuo = vu.key_cuo
                                 AND vu.key_dec IS NULL
                                 AND iu.key_nber = vu.key_nber
                                 AND iu.itm_nber = vu.itm_nber
                                 AND iu.sad_num = vu.sad_num
                                 AND ia.key_year = va.key_year
                                 AND ia.key_cuo = va.key_cuo
                                 AND va.key_dec IS NULL
                                 AND ia.key_nber = va.key_nber
                                 AND ia.itm_nber = va.itm_nber
                                 AND ia.sad_num = va.sad_num
                                 --para recuperar informacion del control
                                 AND f.alc_tipo_tramite = 'DUI'
                                 AND f.alc_gestion = u.sad_reg_year
                                 AND f.alc_aduana = u.key_cuo
                                 AND u.sad_reg_serial = 'C'
                                 AND f.alc_numero = u.sad_reg_nber
                                 AND f.ctl_control_id = prm_codigo
                                 AND f.alc_num = 0
                                 AND f.alc_lstope = 'U'
                                 AND f.ctl_control_id = n.ctl_control_id
                                 AND n.not_num = 0
                                 AND n.not_lstope = 'U'
