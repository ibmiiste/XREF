     h Debug Option( *SrcStmt: *NoDebugIO )
     h CopyRight('©Sh!rl0ck 2003-2009 X-Ref <Version v1.9.2>')
     h DatFmt(*EUR) TimFmt(*HMS) DatEdit(*YMD) ActGrp(*New) DftActGrp(*No)

     ?**----------------------------------------------------------------------**
     ?**---ZZ01 : outils d'analyse iSeries------------------------------------**
     ?**----------------------------------------------------------------------**

     ?**---Définition du fichier écran----------------------------------------**
     fzz01d     cf   e             WorkStn Sfile(FzzSfl:FzzRrn)                 Sfl Principal
     f                                     Sfile(F02Sfl:F02Rrn)                 Liste Composant
     f                                     Sfile(F03Sfl:F03Rrn)                 Liste des Modificati
     f                                     Sfile(F04Sfl:F04Rrn)                 Liste des Modificati
     f                                     Sfile(F05Sfl:F05Rrn)                 Liste Plugin
     f                                     Sfile(F06Sfl:F06Rrn)                 Liste Bibliothèque
     f                                     Sfile(F12Sfl:F12Rrn)                 Liste Zones
     f                                     IndDs(Indicators)                    Indicateurs Ecran
     f                                     UsrOpn                               Contrôle ouverture

     ?**---Fichier à description interne--------------------------------------**
     ffile      if a f32766        Disk    UsrOpn InfDs(PsDs)

     ?**---Définition du fichier Dump du Query--------------------------------**
     fDmpFil    if   f  528        Disk    UsrOpn Block(*No)

     ?**---Définition du fichier imprimante en interne------------------------**
     fqsysprt   o    f  132        Printer OflInd(*InOa) FormOfl(66)
     f                                     FormLen(66) UsrOpn

     ?**---Définition du fichier écran en interne-----------------------------**
     f££zz01d   o    f   80        Workstn UsrOpn

     ?**---Définition des Constantes------------------------------------------**
     d mdf             c                   Const(300)                           Longueur Texte
     d Version         c                   Const('v1.9.2 ')                     N° Version
     d lo              c                   Const('abcdefghijklmnopqrstuvwxyz')  Minuscules
     d up              c                   Const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')  Majuscules
     d Clibl           c                   Const('*LIBL')                       Liste Utilisateur
     d Cfile           c                   Const('*FILE')                       Type fichier
     d Czz01pf         c                   Const('ZZ01PF    ')                  Fichier paramètre
     d Czz01ot         c                   Const('ZZ01OUT   ')                  Fichier paramètre
     d CPgmRef         c                   Const('PGMREF    ')                  Fichier PgmRef
     d CPgmRef1        c                   Const('PGMREF1   ')                  Vue 1 sur Pgmref
     d CPgmRef2        c                   Const('PGMREF2   ')                  Vue 2 sur Pgmref
     d CPgmRef3        c                   Const('PGMREF3   ')                  Vue 3 sur Pgmref
     d Cobjd0200       c                   Const('OBJD0200')                    Description Objet
     d Cobjd0400       c                   Const('OBJD0400')                    Description Objet
     d EndOfFile       c                   Const(100)                           Fin de fichier SQL
     d InitAlloc       c                   Const(100)                           Taille Initiale Allo
     d SubsAlloc       c                   Const(100)                           Taille Allouée suppl
     d MaxTab          c                   Const(32767)                         Taille Max tableau
     d Auth_None       c                   x'0000'                              Autorisation objet
     ?**---Tableau chargé à la compilation------------------------------------**
     d Tb_Plugin       s             55a   dim(20) ctdata
     d Nouv_Tab        s            100a   dim(20) ctdata
     d Modifencours    s            100a   dim(Mdf) ctdata
     d F04desTab       s             80a   dim(24) ctdata
     d Desc_Entete     s             60a   dim(48) ctdata

     ?**---Autorisation par type d'objet--------------------------------------**
?    ?**   31 - 02|F02 - X-Ref                    |                           **
?    ?**   32 - 14|F14 - Where Used               ||                          **
?    ?**   33 - 07|F07 - Description Fichier      |||                         **
?    ?**   34 - 08|F08 - Logiques Fichier         ||||                        **
?    ?**   35 - 09|F22 - Recherche de caractères  |||||                       **
?    ?**   36 - 15|F15 - Carto. Programme         ||||||                      **
?    ?**   37 - 16|F16 - Carto. Source            |||||||                     **
?    ?**   38 - 20|F20 - Carto. Ile               ||||||||                    **
?    ?**   39 -                                   |||||||||                   **
?    ?**   40 - 06|F06 - Lancement d'une requête  ||||||||||                  **
     d OptFile         c                   Const('0111100001')                  Autorisation fichier
     d OptPgm          c                   Const('1100111100')                  Autorisation prog.
     d OptSrvPgm       c                   Const('1110111100')                  Autorisation srvpgm
     d OptModule       c                   Const('1000101100')                  Autorisation module
     d OptDtaara       c                   Const('0100100000')                  Autorisation Dtaara
     d OptVide         c                   Const('0000111000')                  Autorisation Analyse
     d OptQuery        c                   Const('1100100001')                  Autorisation Query

?    ?**---Variables Types----------------------------------------------------**
     d £SysPtr         s               *   ProcPtr  Based(Dummy)
     d £Dyna           s            128a                                        Type de tableau
     d £Heap           s             10i 0                                      Heap Id
     d £Index          s             10i 0                                      Index de tableau
     d £MasterTaille   s             20i 0                                      Taille du tableau Ma
     d £StIndex        s              5i 0                                      Index de sous-tablea
     d £Tab            s             10a                                        Nom de tableau
     d £StTab          s             20a                                        Nom de sous-tableau
     d £FeedBack       s             12a                                        Message d'erreur
     ?**---Attributs d'un User Space------------------------------------------**
     d £QUsAttr        Ds
     d                               10i 0 Inz(1)                               QUsNumRec
     d                               10i 0 Inz(3)                               QUsKey
     d                               10i 0 Inz(1)                               QUsRecLen
     d                                1a   Inz('1')                             QUsRecData

     ?**---Définition des variables globales----------------------------------**
      **---Pointeur-----------------------------------------------------------**
     d PtrPlug         s               *   ProcPtr
      **---Booléen------------------------------------------------------------**
     d Bib_Ok          s               n                                        Liste Ok
     d Bib_Ok_Sav      s               n                                        Liste Ok
     d Bib_Ok_Init     s               n   Inz(*On)                             Liste Ok
     d Ctl_Fonct       s               n
     d Car_Carte_C     s               n
     d Car_Carte_D     s               n
     d Car_Carte_F     s               n
     d Car_Carte_P     s               n
     d Car_Free        s               n
     d Car_Proto       s               n
     d F06_Obj         s               n
     d F06_Src         s               n
     d F06_Ref         s               n
     d F06_Lig_Obj     s               n
     d F06_Lig_Src     s               n
     d F06_Lig_Ref     s               n
     d F06ClrRef       s               n
     d First           s               n
     d First_Chk       s               n   inz('1')
      **---Date/Heure/Timestamp-----------------------------------------------**
     d Datedujour      s               d
     d Heure           s               t
     d Zztmst          s               z
      **---Alphanumérique-----------------------------------------------------**
     d OverRide        s              1a
     d Stat            s              1a
     d SpaceValue      s              1a   inz(X'00')                           Valeur du User Space
     d Spkg            s              1a                                        Sql : WhSpkg
     d TrslScan        s              1a
     d TrimScan        s              1a
     d WildScan        s              1a
     d SfRule          s              1a
     d SfCompare       s              2a
     d Lib_Temp        s              6a
     d FormatName      s              8a
     d FileFmt         s              8a   inz('FILD0100')
     d LstOutFmt       s              8a   inz('DBRL0100')
     d CJobI0700       s              8a   inz('JOBI0700')
     d Outputsv        s              8a
     d Qry             s             10a
     d LZone           s             10a
     d fmt             s             10a
     d ObjEntry_Sav    s             10a
     d ZzComp          s             10a
     d ZzBib           s             10a
     d ZzType          s             10a
     d ZzFonc          s             10a                                        Fonction utilisée
     d JobEntry        s             10a
     d SpaceAuth       s             10a   inz('*USE')                          Autorisation User Sp
     d SpaceReplc      s             10a   inz('*YES')                          Remplacement du User
     d ObjectType      s             10a   inz('*ALL')                          Type d'objet
     d SpaceAttr       s             10a   inz                                  Attribut du User Spa
     d CLPgmRef        s             10a                                        Bibliothèque PgmRef
     d Nom_Comp        s             10a
     d Bib             s             10a                                        Bilbiothèque
     d Fnam            s             10a                                        Objet Référencé
     d Pnam            s             10a                                        Programme appelant
     d Lnam            s             10a                                        Biblitohèque du réfé
     d Otyp            s             10a                                        Type du référencé
     d Rfnm            s             10a                                        Sql : WhRfnm
     d System          s             10a   inz('*LCL')                          Système
     d ObjChk          s             10a
     d Format          s             10a
     d XFile           s             10a
     d XLib            s             10a
     d Type            s             10a
     d TypChk          s             10a
     d LibChk          s             10a
     d FmtType         s             10a   inz('*EXT')
     d Ignore          s             10a   inz
     d RecordFmt       s             10a   inz('*FIRST')
     d LibRef          s             10a
     d ListeBib        s             10a
     d SrclibW         s             11a
     d Trt             s             12a
     d Rfsn            s             13a                                        Sql : WhRfsn
     d Usage           s             14a                                        Usage du fichier
     d Max_Date        s             13a
     d Desc            s             15a                                        Sql : WhText
     d Blan            s             16a   inz
     d Object          s             20a
     d Procedure       s             20a
     d SFileLib        s             20a
     d Proto_Name      s             20a                                        nom du prototype
     d Proc_Encours    s             20a                                        nom du prototype
     d RFileLib        s             20a
     d Output          s             30a
     d SfValue         s             50a
     d Etoile          s             26a   inz('*')
     d InputDs         s             28a
     d SavComp         s             30a
     d SpaceText       s             50a   inz('User Space Temporaire')         Libellé User Space
     d Text            s             50a
     d Lst_Bnd         s             50a
     d hd02            s             80a
     d hd03            s             80a
     d Ent01           s            132a                                        Ligne de l'Entête
     d Ent02           s            132a                                        Ligne de l'Entête
     d Ent03           s            132a                                        Ligne de l'Entête
     d Ent04           s            132a                                        Ligne de l'Entête
     d Ent05           s            132a                                        Ligne de l'Entête
     d Lig01           s            132a                                        Ligne de l'Entête
     d Det01           s            132a                                        Ligne de l'Entête
     d OvrCmd          s            200a                                        Commande AS400
     d Fld             s            256a
     d Req_Crt         s           1000a
     d Req_Sql         s           1000a
     d Requete0        s           1000a                                        Requête SQL
     d Requete1        s           1000a                                        Requête SQL
     d Requete2        s           1000a                                        Requête SQL
     d Requete4        s           1000a                                        Requête SQL
     d Requete5        s           1000a                                        Requête SQL
     d Requete6        s           1000a                                        Requête SQL
     d InPut           s           1280a
     d SqlDefn         s          10000a
     d All_File        s          32767a
      **---Packé--------------------------------------------------------------**
     d StrScan         s              3p 0
     d LenSrcDta       s              3p 0
     d LenF01Obj       s              3p 0
     d SrcRet          s              3p 0
     d NbrL            s              5p 0
     d Rec             s              5p 0
      **---Etendu-------------------------------------------------------------**
     d Fusg            s              2  0                                      Usage du fichier
     d I1              s              4  0
     d I2              s              4  0
     d NbrLogics       s              4  0
     d FzzRrn          s              5  0 inz(0)                               Rang d'enreg. FZZ
     d F02Rrn          s              5  0 inz(0)                               Rang d'enreg. F02
     d F03Rrn          s              5  0 inz(0)                               Rang d'enreg. F02
     d F04Rrn          s              5  0 inz(0)                               Rang d'enreg. F02
     d F05Rrn          s              5  0 inz(0)                               Rang d'enreg. F05
     d F06Rrn          s              5  0 inz(0)                               Rang d'enreg. F06
     d F12rrn          s              5  0 inz(0)                               Rang d'enreg. F12
     d i               s              5  0 inz(1)                               Compteur
     d CptF22          s              5  0 inz(1)                               Compteur
     d Index_X         s              5  0
     d SqlCpt          s              5  0 inz(1)                               Compteur
     d IOff            s              5  0 inz(1)                               Compteur
     d j               s              5  0 inz                                  Compteur
     d k               s              5  0 inz                                  Compteur
     d Nbr             s              5  0
     d NbrMbr          s              5  0
     d NbrFmt          s              5  0
     d Pos_Comp        s              5  0
     d Ind_Rappel      s              5  0
     d IndRapWrk       s              5  0
     d Cpt1            s              5  0                                      Compteur 1
     d Cpt2            s              5  0                                      Compteur 2
     d Cpt3            s              5  0                                      Compteur 3
     d Cpt4            s              5  0                                      Compteur 4
     d Cpt6            s              5  0                                      Compteur 6
     d Cpt7            s              5  0                                      Compteur 7
     d Cpt8            s              5  0                                      Compteur 8
     d Cpt_I           s              5  0                                      Compteur 8
     d Id_Ile          s              5  0
     d I_Ile           s              5  0
     d Id_Ile_Premier  s              5  0
     d Cpt_Ile         s              5  0
     d prctage         s              5  2
     d Cpt_Ligne       s              8  0
     d S               s             10  0
     d OvrCmdLen       s             15  5                                      Longueur de la comma
      **---Entier signé-------------------------------------------------------**
     d lenmat          s              5i 0
     d lenmatp         s              5i 0
     d x               s              5i 0
     d y               s              5i 0
     d f               s             10i 0
     d g               s             10i 0
     d IndRef          s             10i 0
     d Nbr_Poste       s             10i 0
      **---Binaire------------------------------------------------------------**
     d Date_Null       s              4b 0
     d jobilen         s              4b 0 inz(9999)
     d SpaceLen        s              9b 0 inz(MaxTab)                          Longueur du User Spa
     d StartPosit      s              9b 0                                      Position dans le Use
     d StartLen        s              9b 0                                      Longueur dans le Use
     d ReceiveLen      s              9b 0
     d SaveLen         s              9b 0
     d SaveStart       s              9b 0
      **---Spécial Gestion Tableau--------------------------------------------**
     d NameTab         s                   Dim(MaxTab) Like(£Tab)
     d DynArrDsà       s               *   Dim(MaxTab)
     d Mat_Matrice     s                   Dim(10) Like(MatriceDs) inz
     d HeapTab         s                   Dim(MaxTab) Like(HeapDef)
     d DynArr          s                   Dim(MaxTab) based(DynArrà)
     d                                     Like(£Dyna)
     d Name_Tab        s                   Dim(MaxTab) Like(£StTab)
     d Master_Tab      s                   Dim(MaxTab) Like(£Tab)
     d Master_Size     s                   Dim(MaxTab) Like(£Index)
     d HeapMax         s                   Like(£Heap)
     d Identifiant     s                   Like(£StIndex) Inz
     d Heap_Tab        s                   Dim(MaxTab) Like(HeapDef)
      **---Entier non signé---------------------------------------------------**
     d Car_Copy        s              3u 0
     d Car_Slash       s              3u 0
     d Car_PtVirg      s              3u 0
     d Car_FreeBegin   s              3u 0
     d Car_FreeEnd     s              3u 0
     d Car_Comment     s              3u 0
     d Car_FiRoutine   s              3u 0
     d Car_SsRoutine   s              3u 0
     d Car_ExRoutine   s              3u 0
     d Car_Libl        s              3u 0
     d Car_Cas         s              3u 0
     d Niveau          s              3u 0
     d NbrProto        s              5u 0 Inz
     d Cpt             s              5u 0

     ?**---Définition fichiers en entrée--------------------------------------**
     d  Lib_In         Ds                  Qualified
     d   File                        10a
     d   Lib                         10a
     d                               10a                                        Mbr
     d   Fmt                         10a
     ?**---Définition fichier en sortie---------------------------------------**
     d  Lib_Out        Ds                  Qualified
     d   File                        10a
     d   Lib                         10a
     d                               10a                                        Mbr
     ?**---DS du sous-fichier F06 : Gestion liste de bibliothèque-------------**
     d F06Fld          s            132
     d F06_Ds          Ds
     d   F06Opt
     d   F06Lib                      10a
     d   F06Des
     d   F06Maj
     d   F06Date
     ?**---DS du sous-fichier F04 : Gestion des analyses----------------------**
     d F04_Ds          Ds
     d  Obj04                        10a
     d  Lib04                        10a
     d  Type04                        7a
     d  Fonc04                       10a
     d  Tmst04                       26a
     d  Mode04                       12a
     d  Opt04                         1a
     ?**---Affichage XREF : Ligne---------------------------------------------**
     d LigXref         Ds
     d   XrefNom               1     10
     d   XrefTxtDsc           11     60
     d   XrefUsage            63     77
     d                        78     78    inz(X'20')
     d   XrefRfnm             79     88
     d   XrefOtyp             89     99
     d   XrefLnam            101    111
     d   XrefRfsn            112    125
     ?**---Affichage [F04] : Ligne--------------------------------------------**
     d LigF04          Ds
     d   F04Nom                1     10
     d   F04Texte             11     60
     d   F04Lib               61     70
     ?**---Affichage de la description d'un fichier : Ligne-------------------**
     d LigDescFile     ds
     d   DescNom               1     10
     d   DescDes              11     60
     d   DescTyp              63     63
     d   DescLon              64     70
     d   DescDec              74     75
     d   DescDeb              77     80
     d   DescFin              81     87
     d   DescInt              90     99
     d   DescAlt             101    130
     ?**---Affichage de la recherche de caractère : Ligne---------------------**
     d LigScan         Ds
     d  ScanPnam               1     10
     d  ScanDes               11     60
     d  ScanBib               63     72
     d  ScanFil               75     84
     ?**---DS Paramètres en entrée--------------------------------------------**
     d ParmEntry1      Ds
     d  Entry_Obj                    10a
     d  Entry_Lib                    10a
     d  Entry_typ                     7a
     d  Entry_Fct                    10a
     d  Entry_Output                  8a
     d  Entry_Trt                    12a
     d                                4b 0
     d  Entry_FicSrc                 10a
     d  Entry_BibSrc                 10a
     d  Entry_MbrSrc                 10a
     d  Entry_Text                   50a   overlay(Parmentry1:90)
     ?**---DS Paramètre Plugin------------------------------------------------**
     d DataPlugin      Ds          1024
     d  x_Date                       10a                                        Date du jour
     d  x_heure                       8a                                        Heure
     d  x_User                       10a                                        Utilisateur
     d  x_Job                        10a                                        Travail
     d  x_NJob                        6a                                        N° de Job
     d  x_Os400                       6a                                        OS/400
     d  x_Version                     7a                                        Version X-Ref
     d  x_Plugin                     35a                                        Nom du Plugin
     d  x_SrvPgm                     10a                                        Programme de service
     d  x_SrvLib                     10a                                        Bibliothèque du Prg
     d  x_Mode                        1a                                        Mode de lancement
     d  x_Output                      1a                                        Format de sortie
     d  x_Objet                      10a                                        Nom du composant
     d  x_Bib                        10a                                        Nom de la bibliothèq
     d  x_Type                       10a                                        Type de l'objet
     d  x_Texte                      50a                                        Texte de l'objet
     d  x_FicSrc                     10a                                        Fichier Source
     d  x_BibSrc                     10a                                        Bibliothèque source
     d  x_MbrSrc                     10a                                        Membre source
     d  x_NivSrc                      1a                                        Niveau d'analyse du
     d  x_LastFunct                  10a                                        Dernière fonction ut
     d  x_BibRef                     10a                                        bibliothèque du fich
     ?**---List Data Program--------------------------------------------------**
     d Lst_dta_Pgm     Ds
     d  Lst_Size                      8b 0
     d                               10a                                        Lst_Pgm
     d                               10a                                        Lst_PgmLib
     d  Lst_Mod                      10a
     d                               10a                                        Lst_ModLib
     ?**---List Data Program--------------------------------------------------**
     d Lst_dta_Srv     Ds
     d  Lst_Srv_Size                  8b 0
     d                               10a                                        Lst_Srv_Pgm
     d                               10a                                        Lst_Srv_PgmLi
     d  Lst_Srv_Mod                  10a
     d                               10a                                        Lst_Srv_ModLi
     ?**---List Data Service Program------------------------------------------**
     d Lst_dta_SrvPgm  Ds
     d  Program_name                 10a
     d                               10a
     d  Lst_Srv                      10a
     d                               10a                                        Lst_SrvLib
     d                               16a                                        Lst_SrvSign
     ?**---List Data Module---------------------------------------------------**
     d ListData        Ds
     d  List_Size                     6b 0
     d                               10a                                        List_Module
     d                               10a                                        List_ModLib
     d                                1a                                        List_ProcType
     d                                4b 0                                      List_OffProc
     d                                4b 0                                      List_SizProc
     d                               10a                                        List_ArgProc
     d  List_ProcName         47     80a
     ?**---List Data Program--------------------------------------------------**
     d Lst_dta_Bnd     Ds
     d  Lst_BndSize                   8b 0
     d                               10a                                        Lst_ModBnd
     d                               10a                                        Lst_ModBndLib
     d  Lst_BndTyp                   10a
     d                               10a                                        Lst_BndLib
     d  Lst_BndOffSet                 8b 0
     d  Lst_BndLength                 8b 0
     ?**---Rang d'enregistrement dans le fichier------------------------------**
     d PsDs            Ds
     d  NbrEnregs                    10i 0  overlay(PsDs:156)
     d  Rrn                  397    400b 0
     ?**---Définition d'un source---------------------------------------------**
     d DSSource        Ds
     d  SrcLib                       10a
     d  SrcFil                       10a
     d  SrcMbr                       10a
     d  SrcRrn                        5  0
     d  SrcMax                        5  0
     ?**---Ds statut du programme---------------------------------------------**
     d WsPsDs         sDs
     d  WsPsDs1                     256a
     d  WsPsds2                     256a
     d  Routine                       7a    overlay(WsPsDs:29)
     d  Travail                      10a    overlay(WsPsDs:244)
     d  Utilisateur                  10a    overlay(WsPsDs:254)
     d  User                         10a    overlay(WsPsDs:254)
     d  Numero                        6s 0  overlay(WsPsDs:264)
     d                        40     46                                         Excp_MsgId
     d                        91    170                                         Excp_Data
     ?**---Ds pour la définition de la clé d'un fichier-----------------------**
     d KeyData         Ds
     d  DependKey              1     10
     d  AscendDes             14     14
     ?**---Ds pour la définition des sélection/ommissions d'un LF-------------**
     d FindSelect      Ds         32767    inz
     d  Physical              50     69
     d  FindFormat            70     79
     d  NbrKeys              117    118b 0
     d  NbrSelOmit           130    131b 0
     d  OffSelOmit           132    135b 0
     d  OffSet               136    139b 0
     ?**---Ds pour la définition des sélection/ommissions d'un LF-------------**
     d KeySelect       Ds           150    inz
     d  Rule                   3      3
     d  Compare                4      5
     d  CompName               6     15
     d  NbrSO                 16     17b 0
     d  OffsetSO              29     32b 0
     ?**---Définition d'un Heap-----------------------------------------------**
     d HeapDef         Ds
     d  HeapId                       10i 0
     d  HeapSize                     10i 0
     d  HeapElems                    10i 0
     ?**---Définition d'une matrice-------------------------------------------**
     d MatriceDs       Ds
     d   Mat_Y                        5i 0 Dim(MaxTab) inz(0)
     ?**---Ds pour la définition des Clés d'un LF-----------------------------**
     d KeySOS          Ds           150    inz
     d  POffset                1      4b 0
     d  NL                     5      6b 0
     d  SelectVar             21     48
     ?**---Ds pour la liste des LF d'un PF------------------------------------**
     d ListDs          Ds
     d  DependFil             21     30
     d  DependLib             31     40
     ?**---Ds du récepteur pour le nombre de format par fichier---------------**
     d Receiver        Ds          4096    inz
     d  NbrFormats            62     63b 0
     d  DBFileOffS           317    320b 0
     d                       337    338                                         AccessType
     ?**---Description d'un fichier source------------------------------------**
     d RcdSrc          Ds         32766
     d  SrcSeq                        6  2
     d                                6  0                                      SrcDat
     d  SrcDta                      150
     ?**---Description d'un fichier Dump--------------------------------------**
     d DmpFilDs        ds
     d  SavfDta                1    512
     d  NoOMH                257    512
     d                       513    528                                         ChkSum
     ?**---Description d'un scan----------------------------------------------**
     d ScanDsRes       ds
     d  SourcePgm              1     10
     d                        11     20                                         SourceTyp
     d  SourceTxt             47     95
     ?**---Description des logiques-------------------------------------------**
     d AccPthDs        ds
     d  SfLibrary                    10a
     d  SfFilename                   10a
     d  SfKeyField                   10a
     d  SfFormat                     10a
     d  SfAsendDec                    1
     d  SfText                       50
     ?**---Description d'un fichier-------------------------------------------**
     d                 ds                           based(pEntry)
     d FieldName               1     10
     d DataType               11     11
     d                        12     12                                         Use
     d OutBufPos              13     16i 0
     d                        17     20i 0                                      InBufPos
     d ByteLeng               21     24i 0
     d Digits                 25     28i 0
     d DecPos                 29     32i 0
     d FieldText              33     82
     d                        83     84                                         EditCode
     d                        85     88i 0                                      EditWordLen
     d                        89    152                                         EditWord
     d                       153    172                                         ColHead1
     d                       173    192                                         ColHead2
     d                       193    212                                         ColHead3
     d IntName               213    222
     d AltName               223    252
     d                       253    256i 0                                      LenAltFld
     d                       257    260i 0                                      NumDBCS
     d                       261    261n                                        AlwNull
     d                       262    262n                                        HostVarInd
     d                       263    266                                         DatTimFmt
     d                       267    267                                         DatTimSep
     d VaryingInd            268    268n
     ?**---Description d'un objet---------------------------------------------**
     d                 Ds
     d  WLiblOk                      10a
     d  TxtDscOk                     50a
     d  SrcMbrOk                     10a
     d  SrcFOk                       10a
     d  SrcLibOk                     10a
     ?**---Liste des Objets---------------------------------------------------**
     d DsList          Ds                                                       Liste d'objet
     d  DsListFile                   10                                         Objet
     d  DsListLib                    10                                         Bibliothèque
     d  DsListTyp                    10                                         Type d'objet
     ?**---OBJD0400-----------------------------------------------------------**
     d Objd0400        Ds
     d                               10i 0                                      Bytes Returned
     d                               10i 0                                      Bytes Available OdBy
     d  OdObjNam                     10a                                        Object Name
     d  OdObjLib                     10a                                        Object Library Name
     d  OdObjTypRt                   10a                                        Object Type
     d                               10a                                        Return Library
     d  OdObjASP                     10i 0                                      Object ASP Number
     d  OdObjOwn                     10a                                        Object Owner
     d  OdObjDmn                      2a                                        Object Domain
     d  OdObjCrtDts                  13a                                        Creat. Date and Time
     d  OdObjChgDts                  13a                                        Chge Date and Time
     d  OdObjExtAtt                  10a                                        External Attribute
     d  OdObjTxtDes                  50a                                        Text Description
     d  OdObjSrcFil                  10a                                        Source File
     d  OdObjSrcLib                  10a                                        Source Library
     d  OdObjSrcMbr                  10a                                        Source Member
     d  OdObjLast            461    467                                         Date Last Used
     ?**---Indicateurs du fichier écran---------------------------------------**
     d Indicators      Ds
     d  OptAide               01     01n                                        Aide
     d  OptXref               02     02n                                        XRef
     d  AffSrc                02     02n                                        Touche de Fonction [
     d  Exit                  03     03n                                        Exit
     d  OptRecDesc            04     04n                                        Recherche Descriptio
     d  OptPlugin             05     05n                                        Appel plugin
     d  OptRunQry             06     06n                                        RunQry
     d  OptDesc               07     07n                                        Description
     d  OptAccpth             08     08n                                        Affichage des logiqu
     d  OptRappel             09     09n                                        Rappel Analyse
     d  OptRappelP            10     10n                                        Rappel Analyse En Av
     d  OptRecProc            11     11n                                        Recherche Module
     d  Retour                12     12n                                        Retour
     d  OptImpr               13     13n                                        Impression du sous-f
     d  OptWhereUsed          14     14n                                        Where Used
     d  OptCarto              15     15n                                        Cartographie
     d  OptCartoSrc           16     16n                                        Cartographie Source
     d  OptRecZone            17     17n                                        Recherche d'une zone
     d  OptSplf               18     18n                                        Wrksplf
     d  OptAffObj             19     19n                                        Affichage de la desc
     d  OptCartoIle           20     20n                                        CartoGraphie ILE
     d  OptLigCmd             21     21n                                        Ligne de Commande
     d  OptSrch               22     22n                                        Recherche de caractè
     d  OptAnalyse            23     23n                                        Gestion Analyse
     d  OptBib                24     24n                                        Gestion de la liste
     d  DspPr                 41     41n                                        Zone protégée
     d  DspNd                 42     42n                                        Zone non affichée
     d  DspPc                 43     43n                                        Zone Positionnement
     d  Dsp_Bib               44     44n                                        Couleur sur Biblioth
     d  Dsp_Repro             45     45n                                        Appel Chk_Composant
     d  SflDsp                48     48n                                        Affichage sous fichi
     d  SflDspCtl             49     49n                                        Affichage sous fichi
     d  SflClr                50     50n                                        Clear du sous fichie
     d  SflInd                50     50n                                        Clear du sous fichie
     d  AutRecDesc            60     60n                                        Autorisation recherc
     d  OptDspMaj             72     72n                                        MàJ référence Biblio
     d  OptDspPr              73     73n                                        blocage des zones
     d  ClrRed                74     74n                                        Couleur Rouge
     d  ClrBlu                75     75n                                        Couleur Bleu
     d  ClrPnk                76     76n                                        Couleur Vert
     d  AutObj                       10a   overlay(Indicators:31)               Liste Autorisation
     d  Fonc_Ind                     24a   overlay(Indicators:1)                Touche de fonction u
     ?**---Description d'un composant-----------------------------------------**
     d Composant       Ds                                                       Composant
     d  Obj                          10a                                        Objet
     d  Lib                          10a                                        Bibliothèque
     ?**---Description du job-------------------------------------------------**
     d Jobi            Ds
     d  NCurLib               75     76b 0
     ?**---User Space Générique-----------------------------------------------**
     d UserSpace       Ds
     d  SpaceName                    10a
     d  SpaceLib                     10a
     ?**---Entête d'un User Space---------------------------------------------**
     d GenHeadDs       Ds                  based(pUserSpace)
     d  InputSize            113    116b 0                                      Taille de l'entête
     d                       117    120i 0                                      Offset de l'entête H
     d                       121    124i 0                                      Taille de l'entête H
     d  ListOffset           125    128b 0                                      Offset des données
     d                       129    132i 0                                      Taille de la liste L
     d  NumberList           133    136b 0                                      Nombre de données
     d  EntrySize            137    140b 0                                      Taille des données
     ?**---Code Erreur standard API : ERRC0100--------------------------------**
     d ApiError        Ds
     d                               10i 0 Inz(%Size(ApiError))                                  AeB
     d  AeBytAvl                     10i 0 Inz                                  Bytes Available
     d                                7a                                        Exception Id     AeM
     d                                1a                                        Reserved
     d                              128a                                        Exception Data   AeM
     ?**----------------------------------------------------------------------**
     d RslvTemplt      Ds
     d   Gen_Mat_Id                  32a
     d     TypeSubtyp                 2a   Overlay(Gen_Mat_Id:1)
     d     ObjectPtr                 30a   Overlay(Gen_Mat_Id:3)
     d                                2a   Inz(Auth_None)                       Req_Auth
     ?**----------------------------------------------------------------------**
     d ABP_Info        Ds
     d                               10i 0 Inz(%size(ABP_Info))                 ABP_Ret
     d                               10i 0                                      ABP_Avail
     d                                8a   Inz(*ALLX'00')
     d                               10i 0                                      ABP_ActGrp
     d                               10i 0                                      ABP_ActMark
     d                                7a   Inz(*ALLX'00')
     d                                1a                                        ABP_Flags
     d                                1a   Inz(*ALLX'00')
     ?**---Code Erreur--------------------------------------------------------**
     d ErrCode         Ds
     d                               10i 0 Inz(0)                               ErrProv
     ?**---Récupération de la version d'OS/400--------------------------------**
     d Os400          uDs                  Dtaara(QSS1MRI)                      DTAARA OS/400
     d  Version_Os             1      6a                                        Version OS/400
     d                         1    750a                                        Dummy

     ?**---Appel de ZZ01------------------------------------------------------**
     d Zz01            Pr
     d  parm                        150a                                        Paramètres Commandes

      **----------------------------------------------------------------------**
      **---Gestion des tableaux et des matrices-------------------------------**
      **----------------------------------------------------------------------**
     ?**---Get Heap Storage---------------------------------------------------**
     d CeeGtSt         Pr
     d  parm                               Like(£Heap)                          Heap Id
     d  parm                               Like(£Index)                         Taille du Heap
     d  parm                           *                                        Adresse Mémoire du H
     d  parm                               Options(*Omit) Like(£FeedBack)       Retour
     ?**---Create Heap--------------------------------------------------------**
     d CeeCrHp         Pr
     d  parm                               Like(£Heap)                          Heap Id
     d  parm                               Like(£Index)                         Taille Initiale
     d  parm                               Const Like(£Index)                   Incrément
     d  parm                               Const Like(£Index)                   Stratégie de mémoire
     d  parm                               Options(*Omit) Like(£FeedBack)       Retour
     ?**---Discard Heap-------------------------------------------------------**
     d CeeDsHp         Pr
     d  parm                               Const Like(£Heap)                    Heap Id
     d  parm                               Options(*Omit) Like(£FeedBack)       Retour
     ?**---Initialisation du tableau------------------------------------------**
     d Tab_Init        Pr
     d  parm                         10a   Const                                Tab_Name
     ?**---Alimentation du tableau--------------------------------------------**
     d Tab_Set         Pr
     d  parm                         10a   Const                                Tab_Name
     d  parm                         10i 0 Value                                Index
     d  parm                               Value Like(£Dyna)                    Element
     ?**---Récupération du tableau--------------------------------------------**
     d Tab_Get         Pr                  Like(£Dyna)
     d  parm                         10a   Const                                Tab_Name
     d  parm                         10i 0 Value                                Index
     ?**---Information sur le tableau-----------------------------------------**
     d Tab_Inf         Pr            10i 0
     d  parm                         10a   Const                                Tab_Name
     ?**---Longueur Maxi d'un élément-----------------------------------------**
     d Tab_Len         Pr            10i 0
     d  parm                         10a   Const                                Tab_Name
     ?**---Suppression du tableau---------------------------------------------**
     d Tab_Term        Pr
     d  parm                         10a   Const options(*omit)                 Nom du tableau
     ?**---Recherche dans le tableau------------------------------------------**
     d Tab_Srch        Pr            10i 0
     d  parm                         10a   Const                                Tab_Name
     d  parm                               Value like(£Dyna)                    Element
     d  parm                         10i 0 Value                                Index
     ?**---Transfert d'un tableau dans un autre tableau-----------------------**
     d Tab_Trf         Pr
     d  parm                         10a   Const                                Tab_Name
     d  parm                         10a   Const                                Tab_Sav
     ?**---Incrément d'un élément---------------------------------------------**
     d Tab_Incr        Pr
     d  Parm                         10a   Const                                Tab_Name
     d  parm                         10i 0 Const                                Index
     ?**---Allocation du Heap-------------------------------------------------**
     d Tab_Init2       Pr                  Like(£Heap)                          Heap Id
     ?**---Fabrication du tableau---------------------------------------------**
     d Tab_Make2       Pr                  Like(£Heap)                          Heap Id
     d  parm                               Const Like(£Tab)                     Nom du tableau
     d  parm                               Const Like(£Index)                   Index
     d  parm                               Const Like(£StTab)                   Nom du Sous-Tableau
     ?**---Formatage du nom de tableau----------------------------------------**
     d Tab_Format2     Pr                  Like(£StTab)                         Nom du Sous-Tableau
     d  parm                               Const Like(£Tab)                     Nom du tableau
     d  parm                               Value Like(£Index)                   Index
     d  parm                               Like(£Index)                         Index réduit
     d  parm                               Like(£StIndex)                       Numéro de sous-table
     ?**---Information sur le sous-tableau------------------------------------**
     d Tab_StInf2      Pr                  Like(£Index)                         Taille du Sous-Table
     d  parm                               Const Like (£StTab)                  Nom du Sous-Tableau
     ?**---Calcul Index réduit et numéro de sous-tableau----------------------**
     d Tab_IdxRed2     Pr
     d  parm                               Const Like(£Index)                   Index
     d  parm                               Like(£Index)                         Index réduit
     d  parm                               Like(£StIndex)                       Numéro de sous-table
     ?**---Longueur Maxi d'un élément-----------------------------------------**
     d Tab_Len2        Pr                  Like(£Index)                         Longueur max. d'un p
     d  parm                               Const Like(£Tab)                     nom du Tableau
     ?**---Information sur le tableau-----------------------------------------**
     d Tab_Inf2        Pr                  Like(£Index)                         Taille du Tableau
     d  parm                               Const Like(£Tab)                     Nom du Tableau
     ?**---Nom du Sous-Tableau------------------------------------------------**
     d Tab_StName2     Pr                  Like(£StTab)                         Nom de Sous-Tableau
     d  parm                               Const Like(£Tab)                     Nom du tableau
     d  parm                               Const Like(£StIndex)                 Numéro de Sous-Table
     ?**---Alimentation du tableau--------------------------------------------**
     d Tab_Set2        Pr
     d  parm                               Const Like(£Tab)                     Nom du tableau
     d  parm                               Value Like(£Index)                   Index
     d  parm                               Value Like(£Dyna)                    Elément
     ?**---Récupération du tableau--------------------------------------------**
     d Tab_Get2        Pr                  Like(£Dyna)                          Element
     d  parm                               Const Like(£Tab)                     Nom du tableau
     d  parm                               Value Like(£Index)                   Index
     ?**---Suppression du tableau---------------------------------------------**
     d Tab_Term2       Pr
     d  parm                               Like(£Tab) Value                     Nom du Tableau
     ?**---Recherche dans le tableau------------------------------------------**
     d Tab_Srch2       Pr                  Like(£Index)                         Index
     d  parm                               Const Like(£Tab)                     Nom du Tableau
     d  parm                               Value Like(£Dyna)                    Elément
     d  parm                               Value Like(£Index)                   Index de départ
     ?**---Transfert d'un tableau dans un autre tableau-----------------------**
     d Tab_Trf2        Pr
     d  parm                               Const Like(£Tab)                     Tableau d'origine
     d  parm                               Const Like(£Tab)                     Tableau d'arrivée
     ?**---Incrément d'un élément---------------------------------------------**
     d Tab_Incr2       Pr
     d  parm                               Const Like(£Tab)                     Nom du tableau
     d  parm                               Const Like(£Index)                   Index
     ?**---Alimentation de la matrice-----------------------------------------**
     d Mat_Set         Pr
     d  Parm                         10i 0 Const                                Matrice
     d  Parm                         10i 0 Value                                X
     d  Parm                         10i 0 Value                                Y
     d  Parm                               Value Like(£Dyna)                    Element
     ?**---Récupération de la matrice-----------------------------------------**
     d Mat_Get         Pr                  Like(£Dyna)
     d  parm                         10i 0 Const                                Matrice
     d  parm                         10i 0 Value                                X
     d  parm                         10i 0 Value                                Y
     ?**---Taille de la matrice en X------------------------------------------**
     d Mat_Infx        Pr            10i 0
     d  parm                         10i 0 Const                                Matrice
     ?**---Taille de la matrice en Y------------------------------------------**
     d Mat_Infy        Pr            10i 0
     d  parm                         10i 0 Const                                Matrice
     ?**---Longueur Maxi d'un élément d'une matrice---------------------------**
     d Mat_Len         Pr            10i 0
     d  parm                         10i 0 Const                                Matrice
     ?**---Longueur Maxi d'un élément d'une matrice sur une colonne-----------**
     d Mat_LenCol      Pr            10i 0
     d  parm                         10i 0 Const                                Matrice
     d  parm                         10i 0 Value                                Y
     ?**---Suppression de la matrice------------------------------------------**
     d Mat_Term        Pr
     d  parm                         10i 0 Const                                Matrice
     ?**---Tri Tableau--------------------------------------------------------**
     d Tab_Tri2        Pr
     d  Parm1                        10a   Value                                Tableau
     d  Parm2                         5  0 Value                                Positon Début
     d  Parm3                         5  0 Value                                Position Fin

      **----------------------------------------------------------------------**
      **---Analyse du source--------------------------------------------------**
      **----------------------------------------------------------------------**
     ?**---Procédure : Src_Analyse--------------------------------------------**
     d Src_Analyse     Pr              n                                        Procédure Analyse
     d  parm                         10a                                        Bibliothèque Source
     d  parm                         10a                                        Fichier Source
     d  parm                         10a                                        Membre Source
     d  parm                          1a   Value                                Mode
     ?**---Procédure : Get_Caractere------------------------------------------**
     d Get_Caractere   Pr                                                       Recherche des Blocs
     d  parm                         80a                                        Ligne de Code
     ?**---Procédure : Get_Bloc-----------------------------------------------**
     d Get_Bloc        Pr                                                       Recherche des Blocs
     d  parm                         80a                                        Ligne de Code
     ?**---Procédure : Clr_Car------------------------------------------------**
     d Clr_Car         Pr                                                       Init des indicateurs
     ?**---Procédure : Ovr_SrcFile--------------------------------------------**
     d Ovr_SrcFile     Pr              n                                        Override des sources
     d  parm                               LikeDs(DSSource)                     Source en cours
     ?**---Procédure : Get_OvrFile--------------------------------------------**
     d Get_OvrFile     Pr                                                       Override des sources
     d  parm                         80a                                        Ligne de Code
     ?**---Procédure : Get_SrcLib---------------------------------------------**
     d Get_SrcLib      Pr            10a                                        Recherche bibliothèq
     d  parm                         10a                                        Fichier Source
     d  parm                         10a                                        Membre Source

      **----------------------------------------------------------------------**
      **---API OS/400---------------------------------------------------------**
      **----------------------------------------------------------------------**
     ?**---RTVQRYINF----------------------------------------------------------**
     d RtvQryf         Pr
     d  parm                         10a
     d  parm                         10a
     d  parm                       1280a
     d  parm                         30a
     d  parm                          1a
     ?**---List ILE Module  Information pour un programme de service----------**
     d QbnlSpgm        Pr                  Extpgm('QBNLSPGM')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                               Like(ApiError)
     ?**---List ILE Module  Information pour un programme---------------------**
     d QbnlPgmi        Pr                  Extpgm('QBNLPGMI')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                               Like(ApiError)
     ?**---List Procédures dans un module-------------------------------------**
     d QbnlModi        Pr                  Extpgm('QBNLMODI')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                               Like(ApiError)
     ?**---Liste des membres--------------------------------------------------**
     d QUsLMbr         Pr                  ExtPgm('QUSLMBR')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                         10a
     d  parm                          1a
     ?**---Liste des formats--------------------------------------------------**
     d QUsLRcd         Pr                  ExtPgm('QUSLRCD')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                          1a
     ?**---Recherche des dépendances d'un fichier-----------------------------**
     d Qdbldbr         Pr                  ExtPgm('QDBLDBR')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                         10a
     d  parm                         10a
     d  parm                               like(ApiError)
     ?**---Recherche de l'adresse d'un User Space-----------------------------**
     d Qusptrus        Pr                  ExtPgm('QUSPTRUS')
     d  parm                         20a
     d  parm                           *
     ?**---Lancement de Commande----------------------------------------------**
     d QUsCmdLn        Pr                  ExtPgm('QUSCMDLN')
     ?**---Liste des objets---------------------------------------------------**
     d QUsLObj         Pr                  ExtPgm('QUSLOBJ')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                         10a
     ?**---Description d'un objet---------------------------------------------**
     d QusrObjd        Pr                  ExtPgm('QUSROBJD')
     d  parm                      32767a   Options(*VarSize)                    Receiver Variable
     d  parm                         10i 0 Const                                Length of Receiver
     d  parm                          8a   Const                                Format Name
     d  parm                         20a   Const                                Object and Library
     d  parm                         10a   Const                                Object Type
     d  parm                      32767a   Options(*VarSize)                    Api Error
     ?**---Lancement de Commande----------------------------------------------**
     d QCmdExc         Pr                  ExtPgm('QCMDEXC')
     d  parm                        100a                                        Commande
     d  parm                         15  5                                      Longueur de la Cde
     ?**---Recherche de chaine  de caractères---------------------------------**
     d QClScan         Pr                  ExtPgm('QCLSCAN')
     d  parm                        150a
     d  parm                          3p 0
     d  parm                          3p 0
     d  parm                         10a
     d  parm                          3p 0
     d  parm                          1a
     d  parm                          1a
     d  parm                          1a
     d  parm                          3p 0
     ?**---Réception d'un User Space------------------------------------------**
     d Qusrtvus        Pr                  ExtPgm('QUSRTVUS')
     d  parm                         20a
     d  parm                          9b 0
     d  parm                          9b 0
     d  parm                       2000a   Options(*Varsize)
     ?**---Affichage des zones d'un fichier-----------------------------------**
     d Quslfld         Pr                  ExtPgm('QUSLFLD')
     d  parm                         20a
     d  parm                         10a
     d  parm                         20a
     d  parm                         10a
     d  parm                          1a
     ?**---Création d'un User Space-------------------------------------------**
     d QusCrtUs        Pr                  ExtPgm('QUSCRTUS')
     d  parm                         20a
     d  parm                         10a
     d  parm                          9b 0
     d  parm                          1a
     d  parm                         10a
     d  parm                         50a
     d  parm                         10a
     d  parm                               like(ApiError)
     ?**---Changment des attributs d'un User Space----------------------------**
     d QusCusAt        Pr                  ExtPgm('QUSCUSAT')
     d  Parm                         10a
     d  Parm                         20a
     d  Parm                               Like(£QusAttr)
     d  Parm                           *
     ?**---Suppression d'un User Space----------------------------------------**
     d QusdltUs        Pr                  ExtPgm('QUSDLTUS')
     d  parm                         20a
     d  parm                               like(ApiError)
     ?**---Description d'un fichier-------------------------------------------**
     d Qdbrtvfd        Pr                  ExtPgm('QDBRTVFD')
     d  parm                         20a
     d  parm                          9b 0
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                         10a
     d  parm                          1a
     d  parm                         10a
     d  parm                         10a
     d  parm                               like(ApiError)
     ?**---Prototype  de procédure information de job-------------------------**
     d QUsrJobI        Pr                  ExtPgm('QUSRJOBI')
     d  parm                      32767a   Options(*VarSize)
     d  parm                          4b 0
     d  parm                          8a
     d  parm                         26a
     d  parm                         16a
     ?**---Prototypes and templates for calling ResolveSystemPtr (RSLVSP.H)---**
     d RslvSp2         Pr                  ExtProc('_RSLVSP2')
     d  parm                               Like(£SysPtr)                        Ptr
     d  parm                               Like(RslvTemplt) Const               Template
     d RslvSp4         Pr                  ExtProc('_RSLVSP4')
     d  parm                               Like(£SysPtr)                        Ptr
     d  parm                               Like(RslvTemplt) Const               Template
     d  parm                               LIKE(£SysPtr) Const                  LibPtr
     d ActBndPgm       Pr                  ExtProc('QleActBndPgm')
     d  parm                               Like(£SysPtr) Const                  SrvpgmPtr
     d  parm                         10i 0                                      ActMark
     d  parm                               Like(ABP_Info)                       ABPInfo
     d  parm                         10i 0 Const                                ABPInfoLen
     d  parm                               LIKE(ErrCode)                        ErrorCode
     d GetExport       Pr                  ExtProc('QleGetExp')
     d  parm                         10i 0                                      SrvpgmMark
     d  parm                         10i 0 Const                                ExportId
     d  parm                         10i 0 Const                                NameLen
     d  parm                        100a   Const                                ExportName
     d  parm                           *   ProcPtr Const                        ExportPtr
     d  parm                         10i 0                                      ExportType
     d  parm                               Like(ErrCode)                        ErrorCode
?     **---Dump d'un objet Query----------------------------------------------**
     d DmpQry          Pr
     d  QueryName                    10a   Const
     d  QueryLib                     10a   Const
     d  QualUSName                   20a   Const
     d  QryAut                        1N
     ?**---Définition de l'entête de sous-fichier-----------------------------**
     d Rtv_Entete      Pr                  Like(FzzDesc)
     d  parm                               Like(ZzFonc) Value                   Fonction
     ?**---Filtre des zones textes--------------------------------------------**
     d Filtre          Pr         10000a
     d  parm                      10000a   Value                                Texte
     d  parm                      10000a   Options(*Omit)                       Valeur exclue
     d  parm                      10000a   Options(*Omit)                       Valeur de remplaceme
     ?**---Gestion des analyses-----------------------------------------------**
     d Gst_Analyse     Pr
     ?**---DSPPGMREF----------------------------------------------------------**
     d DspPgmRef       Pr              n
     d  parm                         10a   Value
     ?**---Decription d'un fichier--------------------------------------------**
     d GetTxt          Pr
     d  parm                         10a   Value                                RefObj
     d  parm                         10a   Value                                RefLib
     d  parm                         10a   Value Options(*Nopass)               RefFmt
     ?**---Outils XRef--------------------------------------------------------**
     d RtvFd           Pr              n
     d  parm                         20a                                        Composant
     ?**---Extraction des références------------------------------------------**
     d Ext_Ref         Pr              n
     d  parm                         10a   Value
     ?**---Algorithme de recherche--------------------------------------------**
     d Algo            Pr
     ?**---Alimentation des tableaux de recherche-----------------------------**
     d AlgoAlim        Pr
     ?**---Dessin de l'algorithme---------------------------------------------**
     d AlgoDessin      Pr
     ?**---Prototype de recherche de procédures-------------------------------**
     d Rec_Mod         Pr
     d  Parm                         10a   Value
     d  Parm                         50a   Value
     ?**---Mise à jour des références techniques------------------------------**
     d Maj_Ref         Pr
     d  parm                         10a   Value                                Libname
     ?**---Contrôle de la résolution del'écran--------------------------------**
     d Ctl_Dsp         Pr              n
     ?**---Récupération pointeur de procédure---------------------------------**
     d GetProcPtr      Pr              *   ProcPtr
     d  parm                        100a   Varying Const                        Procedure
     d  parm                         10a   Const                                SrvPgm
     d  parm                         10a   Const                                Library
     ?**---Outils XRef--------------------------------------------------------**
     d Taille_Bib      Pr
     d  parm                       1024a
     d Net_PgmRef      Pr
     d  parm                       1024a
     d Zone_Prog       Pr
     d  parm                       1024a
     d Arc_Trigg       Pr
     d  parm                       1024a
     d Rec_Avc         Pr
     d  parm                       1024a

     ?**----------------------------------------------------------------------**
     ?**---M A I N------------------------------------------------------------**
     ?**----------------------------------------------------------------------**
     d zz01            Pi
     d  ParmEntry                   150a

      /Free

       Monitor;
?      //---Initialisation----------------------------------------------------//
       ExSr Initialisation;

?      //---Si tout s'est bien passé au démarrage-----------------------------//
       If Not Exit;
?      //---Boucle tant que pas de sortie demandée----------------------------//
         Dou Exit;
            Exsr Driver;
         EndDo;
       EndIf;

?      //---Fin du programme--------------------------------------------------//
       ExSr Fin;
       On-error;
         Exsr *Pssr;
       EndMon;

       *Inlr = *On;

?      //---------------------------------------------------------------------//
?      //---Initialisation----------------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Initialisation;

?      //---Récupération de la version de l'OS400-----------------------------//
       In Os400;
       Unlock os400;

?      //---Récupération des paramètres en entrée-----------------------------//
       ParmEntry1 = ParmEntry;

?      //---Formatage du composant en entrée----------------------------------//
       Entry_Obj = %Xlate(lo:up:Entry_Obj);

?      //---Contrôle mode de traitement---------------------------------------//
       Trt = Entry_Trt;
       If Trt = '*INTERACTIVE';
         F01Mode = 1;
       Else;
         F01Mode = 2;
       EndIf;

?      //---Contrôle mode de sortie-------------------------------------------//
       Select;
       When Entry_OutPut = '*DISPLAY';
         F01OutPut = 1;
       When Entry_OutPut = '*OUTFILE';
         F01OutPut = 2;
       When Entry_OutPut = '*PRINTER';
         F01OutPut = 3;
       EndSl;

?      //---Mode de traitement------------------------------------------------//
       If Trt <> '*INTERACTIVE';
         Entry_OutPut = '*OUTFILE';
       EndIf;

?      //---Alimentation tableau des fonctions--------------------------------//
       For i = 1 to 24;
         Tab_Set('Fonction':i :%subst(F04desTab(i):1 :59));
         Tab_Set('Fonc'    :i :%subst(F04desTab(i):60:10));
       EndFor;

?      //---Alimentation de l'aide en ligne-----------------------------------//
       If Entry_OutPut ='*DISPLAY';
         ExSr Alim_Fonct;
       EndIf;

?      //---Source------------------------------------------------------------//
       Exsr Info_source;

?      //---Contrôle de la résolution de l'écran------------------------------//
       If Trt = '*INTERACTIVE';
         Exit = Ctl_Dsp();
       EndIf;

       If Trt = '*INTERACTIVE';
?      //---Création du fichier de sortie-------------------------------------//
         ExSr Crt_Output;
?      //---Création du fichier paramètre-------------------------------------//
         ExSr Crt_Parameter;
?      //---Alimentation des zones par défaut---------------------------------//
         F01Version = Version;
       EndIf;

?      //---Affichage du titre X-Ref------------------------------------------//
       F01Titre = '[ X-Ref : Analyse iSeries ]';

?      //---Mise à jour des tableaux des bibliothèques------------------------//
       ExSr Maj_Tab_Bib;

?      //---Alimentation obligatoire de la liste de bibliothèque--------------//
       If Not(F06_Obj and F06_Src and F06_Ref);
         Bib_Ok_Init = *Off;
         ExSr Liste_Bib;
         Bib_Ok_Init = *On;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Mise à jour tableau des bibliothèques-----------------------------//
?      //---------------------------------------------------------------------//

       Begsr Maj_Tab_Bib;

?      //---Chargement de la liste de bibliothèque Objet----------------------//
       ExSr Get_Bib_Obj;

?      //---Chargement de la liste de bibliothèque Source---------------------//
       ExSr Get_Bib_Src;

?      //---Recherche emplacement de PGMREF-----------------------------------//
       ExSr Choix_PgmRef;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Alimentation des info source--------------------------------------//
?      //---------------------------------------------------------------------//

       Begsr Info_source;

       If %Subst(Entry_Fct:1:9) = '*CARTOSRC';

?      //---Membre source-----------------------------------------------------//
         If Entry_MbrSrc = '*OBJ';
           If Entry_Obj = '*NONE';
             Entry_MbrSrc = *Blanks;
           Else;
             Entry_MbrSrc = Entry_Obj;
           EndIf;
         EndIf;

?      //---Bibliothèque source-----------------------------------------------//
         If Entry_BibSrc = '*LIBOBJ';
           If Entry_Lib = '*LIBL';
             Entry_BibSrc = *Blanks;
           Else;
             Entry_BibSrc = Entry_Lib;
           EndIf;
         EndIf;

?      //---Alimentation zone écran-------------------------------------------//
         F12Mbr = %Xlate(lo:up:Entry_MbrSrc);
         F12Src = Entry_FicSrc;
         F12Lib = Entry_BibSrc;
       Else;

?      //---Mise à blanc des infos--------------------------------------------//
         Entry_MbrSrc = *Blanks;
         Entry_FicSrc = *Blanks;
         Entry_BibSrc = *Blanks;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Création du fichier de sortie-------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Crt_Output;

?      //---Contrôle Existence du fichier paramètre---------------------------//
       QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                Czz01ot+Clibl:Cfile:ApiError);

?      //---Recherche Curlib--------------------------------------------------//
       QusrJobI(JobI:jobilen:CJobi0700:Etoile:Blan);

?      //---Si inexistant, création du fichier--------------------------------//
       If AeBytAvl > *Zero;
         If NCurLib = 0;
?      //---Si pas de curlib alors création du fichier dans QTEMP-------------//
           Lib_Temp = 'Qtemp/';
         Else;
?      //---Sinon dans la curlib----------------------------------------------//
           Lib_Temp = *blanks;
         EndIf;

?      //---Définition de la requête------------------------------------------//
         Requete6='Create Table '+Lib_Temp+'Zz01out (ZzTmst Timestamp Not Null -
         with Default, ZzComp Char ( 10) Not Null With Default, ZzType Char (  -
         10) Not Null With Default, ZzBib Char ( 10) Not Null With             -
         Default, ZzFonc Char ( 10) Not Null With Default, ZzMode Char (       -
         12) Not Null With Default, ZzFld Char ( 256) Not Null With Default)';
      /End-Free
     c/Exec Sql
     c+ Execute immediate :Requete6
     c/End-Exec
     c/Exec Sql
     c+ Label on Table Zz01Out is 'X-Ref - Fichier de Sortie'
     c/End-Exec
      /Free

       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //-- Création du fichier paramètre-------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Crt_Parameter;

?      //---Contrôle Existence du fichier paramètre---------------------------//
       QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                Czz01pf+Clibl:Cfile:ApiError);

?      //---Recherche Curlib--------------------------------------------------//
       QusrJobI(JobI:jobilen:CJobi0700:Etoile:Blan);

?      //---Si inexistant, création du fichier--------------------------------//
       If AeBytAvl > *Zero;
         If NCurLib = 0;
?      //---Si pas de curlib alors création du fichier dans QTEMP-------------//
           Lib_Temp = 'QTemp/';
         Else;
?      //---Sinon dans la curlib----------------------------------------------//
           Lib_Temp = *Blanks;
         EndIf;

?      //---Définition de la requête------------------------------------------//
        Requete6='Create table '+Lib_Temp+'Zz01pf (Type_Enregistrement For Colu-
       mn zzType Char(5) Not Null With Default, Valeur_Enregistrement For Colum-
       n ZzValeur Char(30) Not Null With Default, Primary Key                -
        (Type_Enregistrement, Valeur_Enregistrement))';
      /End-Free
     c/Exec Sql
     c+ Execute immediate :Requete6
     c/End-Exec
     c/Exec Sql
     c+ Label on Table Zz01pf is 'X-Ref - Fichier paramètre'
     c/End-Exec
      /Free

       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F24] : Gestion de la liste de bibliothèque Objet-----------------//
?      //---------------------------------------------------------------------//
       BegSr Liste_Bib;

       Bib_Ok = *Off;
       Dou Bib_ok = *on;

?      //---Alimentation de la liste de bibliothèque--------------------------//
         ExSr Alim_Liste_Tab;

?      //---Contrôle de la liste de bibliothèque------------------------------//
         ExSr Alim_Liste_Sfl;
         Bib_Ok_Sav = Bib_Ok;
         Bib_Ok = *Off;

         If Entry_OutPut <> '*OUTFILE';

?      //---Affichage de la liste de bibliothèque-----------------------------//
         Dow Not Bib_Ok And Not Exit and Not Retour;
?      //---Sauvegarde de la liste de bibliothèque----------------------------//
           Tab_Trf('ListeBib':'SV');

           If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
             OptDspMaj = *On;
?      //---Si au moins une bib Objet n'est pas définie-----------------------//
             If Not F06_Obj and Not F06_Lig_Obj;
               F06Rrn += 1 ;
               F06Opt = 'O';
               F06Lib = '<Bib_Obj>';
               Write F06Sfl;
             EndIf;
?      //---Il faut une bibliothèque de référence-----------------------------//
             If Not F06_Ref and Not F06_Lig_Ref;
               F06Rrn += 1 ;
               F06Opt = 'S';
               F06Lib = '<Bib_Ref>';
               Write F06Sfl;
             EndIf;
?      //---Si au moins une bib Source n'est pas définie----------------------//
             If Not F06_Src and Not F06_Lig_Src;
               F06Rrn += 1 ;
               F06Opt = 'S';
               F06Lib = '<Bib_Src>';
               Write F06Sfl;
             EndIf;
?      //---Lignes à blanc----------------------------------------------------//
             F06_Ds = *Blanks;
             For i = 1 to 5;
               OptDspMaj = *On;
               F06Rrn +=1;
               Write F06Sfl;
             EndFor;

             OptDspMaj = *Off;

?      //---Affichage du sous-fichier-----------------------------------------//
             If F06Rrn > 0;
               ExFmt F06Ctl;
?      //---Gestion du changement de la liste---------------------------------//
               If Exit <> *On and Retour <> *On;
                 F06_Src = *Off;
                 F06_Ref = *Off;
                 F06_Obj = *Off;
?      //---Comparaison entre sauvegarde et liste en cours--------------------//
                 For i = 1 to Tab_Inf('SV') + 5;
                   Chain i F06Sfl;
                   If Tab_Get('SV':i) <> F06Opt+F06Lib+F06Maj+F06Date
                   or F06Opt = 'C';
                     Bib_Ok = *Off;
                     If F06Opt = 'O';
                       F06Maj = 'X';
                     Else;
                       F06Maj = *Blanks;
                     EndIf;
                   EndIf;
?      //---Mise à jour de la liste en cours----------------------------------//
                   Tab_Set('ListeBib':i:F06Opt+F06Lib+F06Maj+F06Date);
                   F06_Ds = *Blanks;
                 EndFor;

               EndIf;
?      //---Suprression de la liste de sauvegarde-----------------------------//
               Tab_Term('SV');

             EndIf;
           EndIf;

?      //---Chargement du sous-fichier----------------------------------------//
           ExSr Alim_Liste_Sfl;

         EndDo;

?      //---Affichage du sous-fichier-----------------------------------------//
         If Exit <> *On and Retour <> *On and Bib_Ok;
           OptDspPr = *On;
           ExSr Alim_Liste_Sfl;
           OptDspPr = *Off;

           If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
             ExFmt F06Ctl;

             If Not(Exit or Retour);
?      //---Suppression des enregistrements dans ZZ01PF-----------------------//
      /End-Free
     c/Exec Sql
     c+ Delete from Zz01pf
     c/End-Exec
      /Free

?      //---Sauvegarde des enregistrements dans ZZ01PF------------------------//
               For i = 1 to Tab_Inf('ListeBib');
?      //---Récupération de la bibliothèque-----------------------------------//
                 Bib = %subst(Tab_Get('ListeBib':i):2:10);
?      //---Sauvegarde si bibliothèque différent de blanc---------------------//
                 If %subst(Tab_Get('ListeBib':i):1:1) <> ' ' and Bib <> *Blanks;
                   Select;
                   When %subst(Tab_Get('ListeBib':i):1:1) = 'O';
                     ListeBib = 'OBLIB';
                   When %subst(Tab_Get('ListeBib':i):1:1) = 'S';
                     ListeBib = 'SCLIB';
                   When %subst(Tab_Get('ListeBib':i):1:1) = 'R';
                     ListeBib = 'LIBRF';
?      //---Suppression de l'alias de QTEMP-----------------------------------//
       Req_Sql = 'DROP ALIAS QTEMP/PGMREF ';
      /End-Free
     c/exec sql
     c+ Execute Immediate :Req_Sql
     c/End-Exec
      /Free
?      //---Création Alias PGMREF dans QTEMP----------------------------------//
       Req_Sql = 'CREATE ALIAS QTEMP/PGMREF FOR ' + %Trim(Bib) + '/PGMREF';
      /End-Free
     c/exec sql
     c+ Execute Immediate :Req_Sql
     c/End-Exec
      /Free
                   EndSl;
      /End-Free
     c/Exec Sql
     c+ Insert Into Zz01pf Values(:ListeBib, :Bib)
     c/End-Exec
      /Free
                 EndIf;
?      //---Mise à jour des références Technique------------------------------//
                 If %subst(Tab_Get('ListeBib':i):12:1) = 'X';
                   F06Lib = %subst(Tab_Get('ListeBib':i):2:10);
                   Maj_Ref(F06Lib);
                 EndIf;
               EndFor;

           EndIf;
?      //---Suppression des tableaux------------------------------------------//
             Tab_Term('ListeBib');
             Tab_Term('OBLIB');
             Tab_Term('SCLIB');

?      //---Chargement de la liste de bibliothèque Objet----------------------//
             ExSr Maj_Tab_Bib;

           EndIf;
         EndIf;

?      //---Si liste incorrecte au départ et sortie alors sortie complète-----//
         If Bib_Ok_Init = *Off and (Exit or Retour);
           Exit = *On;
           Retour = *On;
         EndIf;

?      //---Si liste incorrecte et demande de sortie alors restaure liste-----//
         If Bib_Ok = *Off and (Exit or Retour);
           Tab_Term('ListeBib');
           Tab_Term('OBLIB');
           Tab_Term('SCLIB');
           ExSr Maj_Tab_Bib;
           Bib_Ok = *On;
         Else;

?      //---Si Sortie ou retour alors retour----------------------------------//
         If Retour = *On or Exit = *On;
           Retour = *Off;
           Exit = *Off;
         EndIf;
       EndIf;
         Else;
           Bib_Ok = *On;
         EndIf;
       EndDo;

?      //---Mise à jour du composant sauvegardé-------------------------------//
       If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
         If Not Exit and Not Retour;
           Entry_Obj = SavComp;
           SavComp = *Blanks;
         EndIf;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Alimentation de la liste principale de bibliothèque---------------//
?      //---------------------------------------------------------------------//

       BegSr Alim_Liste_Tab;

?      //---Alimentation de la liste de bibliothèque principal----------------//
       i = *Zeros;

?      //---Alimentation Liste de bibliothèque Référence----------------------//
       If %Trim(LibRef) <> *Blanks;
         i += 1;
         Tab_set('ListeBib': i : 'R' + %trim(LibRef));
         ClPgmRef = %Trim(LibRef);
       EndIf;

?      //---Alimentation Liste de bibliothèque Objet--------------------------//
       For j = 1 To Tab_Inf('OBLIB');
         i += 1;
         F06Lib = Tab_Get('OBLIB':j);
?      //---Recherche de la dernière date de MàJ des références---------------//
      /End-Free
     c/Exec Sql
     c+ SELECT max(Whdttm) INTO :Max_Date:date_null FROM Qtemp/pgmref WHERE
     c+ whlib = :F06Lib
     c/End-Exec
      /Free
?      //---Si date non trouvée alors proposition de mise à jour--------------//
         If Max_Date = *Blanks;
           F06Maj = 'X';
           F06Date = *Blanks;
         Else;
?      //---Sinon formatage de la date----------------------------------------//
           F06Date = %subst(Max_Date:6:2) + '/' + %Subst(Max_Date:4:2) + '/' +
           '20' + %Subst(Max_Date:2:2) + ' ' + %Subst(Max_Date:8:2) + 'h' +
           %Subst(Max_Date:10:2) + 'mn' + %subst(Max_Date:12:2) + 's';
           Max_Date = *Blanks;
           F06Maj = ' ';
         EndIf;
?      //---Alimentation de la liste de bibliothèque objet--------------------//
         Tab_set('ListeBib': i : 'O' + F06Lib + F06Maj + F06Date );
       EndFor;

?      //---Alimentation Liste de bibliothèque Source-------------------------//
       For j = 1 To Tab_Inf('SCLIB');
         i += 1;
         Tab_set('ListeBib': i : 'S'+ %Trim(Tab_Get('SCLIB':j)));
       EndFor;

?      //---Ajout des enregistrements s'il manque un type de bibliothèque-----//
       F06_Ds = *Blanks;
       If Not F06_Ref;
         i += 1;
         Tab_set('ListeBib': i : 'R<Bib_Ref>');
       EndIf;
       If Not F06_Obj;
         i += 1;
         Tab_set('ListeBib': i : 'O<Bib_Obj>');
       EndIf;
       If Not F06_Src;
         i += 1;
         Tab_set('ListeBib': i : 'S<Bib_Src>');
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Création/Clear du fichier des références techniques---------------//
?      //---------------------------------------------------------------------//

       BegSr Crt_Pgmref;

       QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:CPgmRef+ClPgmRef:Cfile
                :ApiError);

?      //---Si inexistant, Création du physique et du logique-----------------//
       If AeBytAvl > *Zero;
?      //---Création du fichier physique--------------------------------------//
         OvrCmd= 'DSPPGMREF PGM('+%Trim(F06Lib)+'/*ALL) OUTPUT(*OUTFILE)';
         OvrCmd= %Trim(OvrCmd) + ' OBJTYPE(*ALL) OUTFILE(';
         OvrCmd= %Trim(OvrCmd) + %Trim(F06Lib) + '/PGMREF)';
         OvrCmd= %Trim(OvrCmd) + ' OUTMBR(*FIRST *REPLACE)';
         OvrCmdLen = 200;
         QcmdExc(OvrCmd:OvrCmdLen);
?      //---Ajout du libellé sur le fichier-----------------------------------//
         OvrCmd = 'CHGPF FILE(' + %Trim(F06Lib) + '/PGMREF)';
         Ovrcmd = %Trim(OvrCmd)+' TEXT(''X-Ref - Fichier Référence'')';
         OvrCmd = %Trim(OvrCmd) + ' SIZE(*NOMAX) REUSEDLT(*YES)';
         OvrCmdLen = 200;
         QcmdExc(OvrCmd:OvrCmdLen);
?      //---Sinon clear du fichier--------------------------------------------//
       Else;
         OvrCmd = 'CLRPFM FILE(' +%Trim(ClPgmRef) +'/PGMREF)';
         OvrCmdLen = 200;
         QcmdExc(OvrCmd:OvrCmdLen);
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Création/Clear des LF pour les références techniques--------------//
?      //---------------------------------------------------------------------//

       Begsr Crt_Pgmref_Lf;

       QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                CPgmRef+ClPgmRef:Cfile:ApiError);

?      //---Si inexistant, Affichage message et impossibilité de sortir-------//
       If AeBytAvl > *Zero;
         Bib_Ok = *Off;
         F06Des = x'22' + '     *** Fichier Réf. Tech. Absent ***';
       Else;
?      //---Sinon contrôle et création des LF associés------------------------//
         CLPgmRef = F06Lib;
?      //---LF N° 1 : WHFNAM/WHOTYP-------------------------------------------//
         QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
         CPgmRef1 + ClPgmRef:Cfile:ApiError);
         If AeBytAvl > *Zero;
           Req_Crt = 'CREATE INDEX '+CPgmref1+ ' ON '+%Trim(ClPgmRef) +'/' +
                     CPgmRef + '(WHFNAM ASC, WHOTYP ASC)';
      /End-Free
     c/Exec Sql
     c+ Execute Immediate :Req_Crt
     c/End-Exec
      /Free
           OvrCmd = 'CHGLF FILE(' + %Trim(ClPgmRef) + '/'+ CPgmref1 + ')       -
            TEXT(''X-Ref - Index PGMREF : WHFNAM/WHOTYP'')';
           OvrCmdLen = 200;
           QcmdExc(OvrCmd:OvrCmdLen);
         EndIf;

?      //---LF N° 2 : WHSPKG/WHPNAM/WHLIB-------------------------------------//
         QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
         CPgmRef2 + ClPgmRef:Cfile:ApiError);
         If AeBytAvl > *Zero;
           Req_Crt='CREATE INDEX '+Cpgmref2+' ON '+%Trim(ClPgmRef)+'/'+CPgmRef +
                    '(WHSPKG ASC, WHPNAM ASC, WHLIB ASC)';
      /End-Free
     c/Exec Sql
     c+ Execute Immediate :Req_Crt
     c/End-Exec
      /Free
           OvrCmd = 'CHGLF FILE(' + %Trim(ClPgmRef) + '/'+ CPgmRef2 +')        -
            TEXT(''X-Ref - Index PGMREF : WHSPKG/WHPNAM/WHLIB'')';
           OvrCmdLen = 200;
           QcmdExc(OvrCmd:OvrCmdLen);
         EndIf;

?      //---LF N° 3 : WHOBJT/WHPNAM-------------------------------------------//
         QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
         CPgmRef3 + ClPgmRef:Cfile:ApiError);
         If AeBytAvl > *Zero;
           Req_Crt = 'CREATE INDEX '+CPgmRef3+ ' ON '+%Trim(ClPgmRef) +'/' +
           CPgmRef + ' (WHOBJT ASC, WHPNAM ASC)';
      /End-Free
     c/Exec Sql
     c+ Execute Immediate :Req_Crt
     c/end-Exec
      /free
           OvrCmd = 'CHGLF FILE(' + %Trim(ClPgmRef) + '/'+CPgmRef3 +')         -
            TEXT(''X-Ref - Index PGMREF : WHOBJT/WHPNAM'')';
           OvrCmdLen = 200;
           QcmdExc(OvrCmd:OvrCmdLen);
         EndIf;

?      //---Recherche du nombre d'enregistrement pour information-------------//
         OvrCmd = 'OVRDBF FILE(FILE) TOFILE('+%trim(F06Lib)+'/PGMREF)';
         OvrCmdLen = 200;
         QcmdExc(OvrCmd:OvrCmdLen);
         Open(e) File;
         If Not %Error;
           F06Des = 'PGMREF Présent avec ' + %char(NbrEnregs)
                     + ' enregistrement(s) ';
         EndIf;
         Close file;
         OvrCmd = 'DLTOVR FILE(FILE)';
         OvrCmdLen = 200;
         QcmdExc(OvrCmd:OvrCmdLen);
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Alimentation de la liste de bibliothèque dans Sous-fichier--------//
?      //---------------------------------------------------------------------//

       BegSr Alim_Liste_Sfl;

       Bib_Ok = *On;
       F06Rrn = 0;
       F06ClrRef = *Off;
      /End-Free
     c/Exec sql
     c+ set :ZzTmst = Current_timestamp
     c/End-Exec
      /Free

?      //---Clear du sous-fichier---------------------------------------------//
       If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
         SflInd = *On;
         Write F06Ctl;
         SflInd = *Off;
       EndIf;

       For i = 1 to Tab_Inf('ListeBib');

?      //---Initialisation des codes couleurs---------------------------------//
         ClrRed = *Off;
         ClrBlu = *Off;
         ClrPnk = *Off;

?      //---Récupération des infos Bibliothèques------------------------------//
         F06Opt  = %subst(Tab_Get('ListeBib':i):01:01);
         F06Lib  = %subst(Tab_Get('ListeBib':i):02:10);
         F06Maj  = %subst(Tab_Get('ListeBib':i):12:01);
         F06Date = %subst(Tab_Get('ListeBib':i):13:21);

         If F06Opt = 'O';
           OptDspMaj = *Off;
         Else;
           OptDspMaj = *On;
         EndIf;

         If F06Opt = 'O' and F06ClrRef;
           F06Maj = 'X';
         EndIf;
?      //---Contrôle Existence de la bibliothèque et description--------------//
         QusrObjd(Objd0400:%Size(Objd0400):COBJD0200:
                 F06Lib + 'QSYS':'*LIB':ApiError);
         If Not(AeBytAvl > *Zero);
           F06Des = OdObjTxtDes;
         Else;
           If F06Lib <> *Blanks;
             F06Des = *All'?';
             Bib_Ok = *Off;
           Else;
             F06Des = *Blanks;
           EndIf;
         EndIf;

?      //---Création du fichier de référence avec le code C-------------------//
         If F06Opt = 'C';
           CLPgmRef = F06Lib;
           ExSr Crt_Pgmref;
           F06Opt = 'R';
           Tab_Set('ListeBib':i:F06Opt+F06Lib+F06Maj+F06Date);
           F06ClrRef = *On;
         EndIf;

?      //---Contrôle Existence du fichier PgmRef------------------------------//
         If F06Opt = 'R';
           CLPgmRef = F06Lib;
           Exsr Crt_Pgmref_Lf;
?      //---Si clear du fichier de référence, MàJ liste de bib.---------------//
           If F06ClrRef;
             Tab_Set('SV':i:F06Opt+F06Lib+F06Maj+F06Date);
             Tab_Set('ListeBib':i:F06Opt+F06Lib+F06Maj+F06Date);
           EndIf;
         EndIf;

?      //---Couleur en fonction du type de bilbiothèque-----------------------//
         Select;
           When F06Opt = 'R' or F06Opt ='C';
             ClrRed = *On;
           When F06Opt = 'O';
             ClrBlu = *On;
           When F06Opt = 'S';
             ClrPnk = *On;
         EndSl;

?      //---Alimentation du Sous-fichier pour une sortie écran----------------//
         If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
           F06Rrn +=1;
           Write F06Sfl;
         Else;
?      //---Sortie fichier----------------------------------------------------//
           F06Fld = F06Opt+' '+F06Lib+' '+F06Des+' '+F06Maj+' '+F06Date;
      /End-Free
     c/Exec Sql
     c+ Insert Into Zz01out Values(:zztmst, :zzcomp, :zztype,
     c+ :zzbib, :zzfonc, :Trt, :F06Fld)
     c/End-exec
      /Free
         EndIf;

?      //---Contrôle Existence Bibliothèque Source----------------------------//
         If F06Opt = 'S' and F06Lib <>'<Bib_Src>';
           F06_Src = *On;
         EndIf;

?      //---Contrôle Existence Bibliothèque Objet-----------------------------//
         If F06Opt = 'O' and F06Lib <>'<Bib_Obj>';
           F06_Obj = *On;
         EndIf;

?      //---Contrôle Existence Bibliothèque Référence-------------------------//
         If (F06Opt = 'R' or F06Opt = 'C') and F06Lib <>'<Bib_Ref>';
           F06_Ref = *On;
         EndIf;

?      //---Contrôle Enreg. incorrect-----------------------------------------//
         If F06Lib ='<Bib_Src>';
           F06_Lig_Src = *On;
         EndIf;

?      //---Contrôle Enreg. incorrect-----------------------------------------//
         If F06Lib = '<Bib_Obj>';
           F06_Lig_Obj = *On;
         EndIf;

?      //---Contrôle Enreg. incorrect-----------------------------------------//
         If F06Lib = '<Bib_Ref>';
           F06_Lig_Ref = *On;
         EndIf;

       EndFor;

?      //---Si Bib. objet et bib. Source non définie alors on ne passe pas----//
       If not (F06_Obj and F06_Src and F06_Ref);
         Bib_Ok = *Off;
       EndIf;

?      //---Initialisation des couleurs---------------------------------------//
       ClrRed = *Off;
       ClrBlu = *Off;
       ClrPnk = *Off;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Chargement de la liste des bibliothèques Sources------------------//
?      //---------------------------------------------------------------------//
       BegSr Get_Bib_Src;

?      //---Requete sur fichier paramètre pour bibliothèque objet-------------//
       Requete0 = 'select zzvaleur from zz01pf where zztype =''SCLIB''         -
                  Order by zzValeur';

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/exec sql
     c+ Prepare S2 From :Requete0
     c/end-exec
     c/exec sql
     c+ Declare C2 Cursor For S2
     c/end-exec
     c/exec sql
     c+ Open C2
     c/end-exec

     c/exec sql
     c+ Fetch Next From C2 Into :lib
     c/end-exec
      /Free

       i = 1;
       F06_Src = *Off;
?      //---Alimentation du tableau SCLIB pour la bibliothèque source---------//
       Dow Sqlcod <> EndOfFile;
         F06_Src = *On;
         Tab_Set('SCLIB':i:lib);
         i += 1;
      /End-Free
     c/exec sql
     c+ Fetch Next From C2 INTO :lib
     c/end-exec
      /Free
       EndDo;

      /End-Free
     c/Exec Sql
     c+ Close C2
     c/End-Exec
      /free

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Chargement de la liste des bibliothèques Objets-------------------//
?      //---------------------------------------------------------------------//
       BegSr Get_Bib_Obj;

?      //---Requete sur fichier paramètre pour bibliothèque objet-------------//
       Requete0 = 'select zzValeur from zz01pf where zztype =''OBLIB''         -
                  Order by zzValeur';

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     c+ Prepare S1 From :Requete0
     c/End-Exec
     c/Exec Sql
     c+ Declare C1 Cursor For S1
     c/End-Exec
     c/Exec Sql
     c+ OPEN C1
     c/End-Exec
     c/Exec Sql
     c+ Fetch Next From C1 INTO :lib
     c/End-Exec
      /Free

       i = 1;
       F06_Obj = *Off;
?      //---Alimentation du tableau OBLIB pour la bibliothèque objet----------//
       Dow Sqlcod <> EndOfFile;
         F06_Obj = *On;
         Tab_Set('OBLIB':i:lib);
         i += 1;
      /End-Free
     c/Exec Sql
     c+ Fetch Next From C1 INTO :lib
     c/End-Exec
      /Free
       EndDo;

      /End-Free
     c/Exec Sql
     c+ CLOSE C1
     c/End-Exec
      /Free

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Alimentation de l'aide en ligne-----------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Alim_Fonct;

?      //---Ligne 1 de touches de fonctions-----------------------------------//
       Fonct01 = 'F01= Aide    F03= Sortir    F05= Outils    F09/F10= +/-    F1-
       2= Retour    F13= Impr.    F18= Gestion Spooles    F21= Ligne de Cmde';

?      //---Ligne 2 de touches de fonctions-----------------------------------//
       Fonct02 = 'F02= X-Ref  F06= Query  F07= Desc. Fichier  F08= Desc. LF/VUE-
         F14= Where Used  F15= Carto. Pgm  F16= Carto. Src  F19= Desc. Objet';

?      //---Ligne 3 de touches de fonctions-----------------------------------//
       Fonct03 = 'F04= Rec./Description F11= Rec.Proc./Modul F17= Rec.zone/Fich-
       ier F20= Carto.Ile F22= Rec. Carac. F23= Lst Analyses F24= Paramètres';

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Choix du PgmRef---------------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Choix_PgmRef;

       LibRef = *Blanks;

      /End-Free
     c/exec sql
     c+ set :LibRef = (select substr(zzvaleur, 1 , 10) from zz01pf
     c+ where zztype = 'LIBRF')
     c/End-Exec
      /Free
       If LibRef <> *Blanks;
         F06_Ref = *On;
         ClPgmRef = LibRef;
       Else;
         F06_Ref = *Off;
       EndIf;
?      //---Création Alias PGMREF dans QTEMP----------------------------------//
       Req_Sql = 'CREATE ALIAS QTEMP/PGMREF FOR ' + %Trim(LibRef) + '/PGMREF';
      /End-Free
     c/exec sql
     c+ Execute Immediate :Req_Sql
     c/End-Exec
      /Free

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Driver modal------------------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Driver;

       Select;
?      //---Mode interactif---------------------------------------------------//
         When Trt ='*INTERACTIVE';
           ExSr Dsply_Selection;
         When Trt = '*BATCH';
?      //---Mode batch--------------------------------------------------------//
           ExSr ModeBatch;
         When Trt = '*NOPROMPT';
?      //---En mode NoPrompt--------------------------------------------------//
           F01Obj = %Xlate(lo:up:Entry_Obj);
           F01Bib = Entry_Lib;
           F01Typ = Entry_typ;
           ExSr Chk_Composant;
           ExSr Call_Option;
       EndSl;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Mode batch--------------------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr ModeBatch;
?      //---Sortie Ecran------------------------------------------------------//
       If %Open(ZZ01D);
         DspPr = *On;
         ExFmt F01;
         Entry_Obj = F01Obj;
?      //---Alimentation par défaut de la bibliothèque------------------------//
         If F01Bib <> *Blanks;
           Entry_Lib = F01Bib;
         Else;
           Entry_Lib = '*LIBL';
         EndIf;
?      //---Alimentation par défaut du type du composant----------------------//
         If F01Typ <> *Blanks;
           Entry_Typ = F01Typ;
         Else;
           Entry_Typ = '*ALL';
         EndIf;
?      //---Sélection fonction------------------------------------------------//
         DspPr = *Off;
         i = %Scan('1':Fonc_Ind);
         If i = *Zero;
           Entry_Fct = '*NONE';
         Else;
           Entry_Fct = Tab_Get('Fonc':i);
         EndIf;

?      //---Sortie fichier----------------------------------------------------//
       Else;
         ParmEntry = ParmEntry1;
       EndIf;

?      //---Soumission du job-------------------------------------------------//
       If Entry_Fct <> '*NONE';
         Entry_Trt = '*NOPROMPT';
         OvrCmdLen = 200;
         If Entry_Obj = '*NONE';
           JobEntry = 'NONE';
         Else;
           JobEntry = Entry_Obj;
         EndIf;

?      //---Commande du job---------------------------------------------------//
         OvrCmd = 'SBMJOB CMD(XREF COMPOSANT(' + %Trim(Entry_Lib) + '/' +
         %Trim(Entry_Obj) + ')' + ' TYPE('+ %Trim(Entry_Typ) + ') FONCTION('
         + %Trim(Entry_Fct) + ') OUTPUT(*OUTFILE) ' + 'MODE(*NOPROMPT)';
         If Entry_Fct = '*CARTOSRC' or Entry_Fct = '*CARTOSRC2';
           OvrCmd = %trim(OvrCmd) + ' SOURCE(' + %Trim(Entry_FicSrc) + ' ' +
           %Trim(Entry_BibSrc) + ' ' + %Trim(Entry_MbrSrc) + ')';
         EndIf;
         If Entry_Fct = '*RECDESC' or Entry_Fct = '*RECPROC';
           OvrCmd = %trim(OvrCmd) + ' TEXTE(' + Entry_Text + ')';
         EndIf;
         OvrCmd = %trim(OvrCmd) + ') JOB(' + %Trim(JobEntry)  + ')';
         ovrcmd = %Trim(ovrcmd) + ' JOBQ(QS36EVOKE)' ;
         QcmdExc(OvrCmd:OvrCmdLen);

       EndIf;

?      //---Après lancement en mode batch-------------------------------------//
       If Not %Open(ZZ01D);

?      //---En mode sortie fichier--------------------------------------------//
         Exit = *On;

       Else;

?      //---En mode sortie écran----------------------------------------------//
         Trt ='*INTERACTIVE';
         Entry_Fct = '*NONE';
         F01Mode = 1;
         DspPr= *Off;
         Clear Fonc_Ind;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Affichage de l'écran de sélection---------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Dsply_Selection;

?      //---Affichage Info du jour--------------------------------------------//
       DateduJour = %Date;
       Heure = %Time;
       F01Info = 'Date:' + x'20' + %char(DateduJour);
       F01Info = %Trim(F01Info) + x'22' + ' ' + 'Heure:'+ x'20' + %char(Heure);
       F01Info = %Trim(F01Info) + x'22' +'Travail:' + x'20';
       F01Info = %Trim(F01Info) + '(' +%Trim(Travail) + '/'  ;
       F01Info = %Trim(F01Info) + %Trim(Utilisateur) + '/';
       F01Info = %Trim(F01Info) +  %char(Numero) + ') ';
       F01Info = %Trim(F01Info) + x'22' + 'O/S:' + x'20' + Version_Os;

?      //---Affichage Version-------------------------------------------------//
       If %Subst(Version:7:1)<>*Blanks;
         F01Info = %Trim(F01Info) + ' ' + x'29' + 'Version en cours de test';
         F01Info = %Trim(F01Info) +  x'20';
       Else;
         F01Info = %Trim(F01Info) + '  ' + x'23' +
?        'http://shirlock.free.fr' + x'20';
       EndIf;

?      //---Choix des options disponibles-------------------------------------//
       ExSr Chk_Options;

?      //---Alimentation du type de l'objet-----------------------------------//
       If Entry_Typ <> *Blanks and Entry_Typ <> '*ALL';
         F01Typ   = Entry_Typ;
         Entry_Typ = *Blanks;
       EndIf;

?      //---Alimentation de la bilbiothèque-----------------------------------//
       If Entry_Lib <> *Blanks and Entry_Lib <> '*LIBL';
         F01Bib   = Entry_Lib;
         Entry_Lib= *Blanks;
       EndIf;

?      //---Affichage du pied de l'écran--------------------------------------//
       Write Foot;

?      //---Affichage de l'écran----------------------------------------------//
       i = %Scan('1':Fonc_Ind);
?      //---Si pas d'appel de Fonction préalable------------------------------//
       If (%Addr(Entry_Obj) = *Null or Entry_Obj = *Blanks or Entry_Obj=*Loval)
         and (%Addr(Entry_Text)=*Null or Entry_Text=*Blanks or
         Entry_Text=*Loval) and i = 0;
         ExFmt F01;
       Else;
?      //---Si appel de fonction préalable------------------------------------//
         Write F01;
?      //---Initialisation des zones------------------------------------------//
         If Entry_Obj ='*NONE' or Entry_Obj = *Blanks;
           Entry_Obj = *Blanks;
         Else;
           F01Obj = Entry_Obj;
         EndIf;
?      //---Remise à blanc de l'objet de départ-------------------------------//
         Entry_Obj = *Blanks;
       EndIf;

?      //---Choix du mode de traitement---------------------------------------//
       If F01Mode = 1;
         Trt ='*INTERACTIVE';
       Else;
         Trt ='*BATCH';
       EndIf;

?      //---Choix du format de sortie-----------------------------------------//
       Select;
       when F01OutPut = 1;
         Entry_OutPut ='*DISPLAY';
       when F01OutPut = 2;
         Entry_OutPut = '*OUTFILE';
       when F01OutPut = 3;
         Entry_OutPut = '*PRINTER';
       EndSl;

       If Exit = *Off;
?      //---Check du composant------------------------------------------------//
         If F01Obj <> %subst(SavComp:1:10) Or Dsp_Repro;

?      //---Contrôle du composant---------------------------------------------//
           If Dsp_bib or Dsp_Repro or Not First_Chk;
             F01Bib = *Blanks;
             F01Typ = *Blanks;
           EndIf;
           First_Chk = *Off;
           ExSr Chk_Composant;

?      //---Sauvegarde du composant-------------------------------------------//
           SavComp = *Blanks;
           SavComp = F01Obj + F01Bib + F01Typ;

?      //---Choix des options disponibles-------------------------------------//
           ExSr Chk_Options;

?      //---Appel de l'option-------------------------------------------------//
           If Entry_Fct <> '*NONE' and Trt ='*INTERACTIVE';
             ExSr Call_Option;
           EndIf;

         Else;
?      //---Appel de l'option-------------------------------------------------//
           ExSr Call_Option;
         EndIf;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Finalisation------------------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Fin;

?      //---Suppression de l'alias de QTEMP-----------------------------------//
       Req_Sql = 'DROP ALIAS QTEMP/PGMREF ';
      /End-Free
     c/exec sql
     c+ Execute Immediate :Req_Sql
     c/End-Exec
      /Free

?      //---Fermeture du fichier écran----------------------------------------//
       If %Open(zz01d);
         Close zz01d;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Affichage des modifications en cours------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Dsp_Chg;

?      //---Clear du sous-fichier---------------------------------------------//
       F03Rrn = 0;
       SflInd = *On;
       Write F03Ctl;
       SflInd = *Off;

?      //---Définitions des touches de fonction-------------------------------//
       F03Des = x'26' + 'Nouveautés avec la version '+ Version + x'22';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       For i = 1 To 20;
         F03des = Nouv_Tab(i);
         F03Rrn = F03Rrn + 1;
         Write F03Sfl;
       EndFor;

?      //---Définitions des touches de fonction-------------------------------//
       F03Des = x'26' + 'Touches de fonctions' + x'22';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       F03Des = '';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       For i = 1 To 24;
         If %subst(F04DesTab(i):7:15) <> *Blanks;
           F03des = F04DesTab(i);
           %Subst(F03Des:9:1) = x'22';
           F03Rrn = F03Rrn + 1;
           Write F03Sfl;
         EndIf;
       EndFor;
?      //---Définitions des Dernières Modifications---------------------------//
       F03Des = '';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       %subst(F03Des:35:20) = x'22' + '.:._____________.:.';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       F03Des = '';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       F03Des = x'26' + 'Dernières Modifications' + x'22';
       F03Date = x'26' + 'Dt Modif.';
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       F03Date = *Blanks;
       F03Des = *Blanks;
       F03Rrn = F03Rrn + 1;
       Write F03Sfl;

       For i = 1 to Mdf;
         If Modifencours(i) <> *Blanks;
           F03Date = %subst(ModifEnCours(i):83:10);
           F03Des = %subst(ModifEnCours(i):1:80);
           F03Rrn += 1;
           Write F03Sfl;
           F03Date = *Blanks;
         Endif;
       EndFor;

?      //---Affichage du sous-fichier-----------------------------------------//
       If F03Rrn > 0;
         ExFmt F03Ctl;
         Exit = *Off;
         Retour = *Off;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Contrôle du composant---------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Chk_Composant;

       F01Des = *Blanks;
?      //---Contrôle Existence de la bibliothèque et description--------------//
       QusrObjd(Objd0400:%Size(Objd0400):COBJD0200:
               F01Bib+'QSYS':'*LIB':ApiError);
B01    If Not(AeBytAvl <=*Zero);
         F01Bib = '*ALL';
E01    EndIf;

?      //---Clear du sous-fichier---------------------------------------------//
B01    If Trt = '*INTERACTIVE';
         F02Rrn = 0;
         SflInd = *On;
         Write F02Ctl;
         SflInd = *Off;
E01    EndIf;

?      //---Traduction du Composant-------------------------------------------//
B01    If Dsp_Repro;
         F01Obj = ObjComp;
E01    EndIf;

       ObjEntry_Sav = F01Obj;
       ObjComp = ObjEntry_Sav;
       F01Obj = %XLate(lo:up:F01Obj);

?      //---Create User Space List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

B01    If (F01Bib <> '*LIBL' and F01Bib <>'' and F01Bib <>'*ALL');
?      //---Liste des objets avec le nom ObjNam-------------------------------//
         Obj = F01Obj;
         Lib = F01Bib;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         FormatName = 'OBJL0100';
         QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
         StartPosit = 1;
         StartLen = 1024;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;
         NbrMbr = NumberList;

?      //---Lecture de tous les composants------------------------------------//
B02      For Nbr = 1 To NbrMbr;
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
           StartPosit = StartPosit + StartLen;
?      //---Alimentation du Sous-fichier de sélection-------------------------//
B03        If F01Typ = *Blanks or F01Typ = DsListTyp;
             F02Obj = DsListFile;
             F02Lib = DsListLib;
             F02Typ = DsListTyp;
             QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                     F02Obj + F02Lib:F02Typ:ApiError);
             F02Des = OdObjTxtDes;
B04          If Trt <> '*INTERACTIVE';
               Nbr = NbrMbr;
               i = Tab_Inf('OBLIB');
               F02Rrn = 1;
X04          Else;
               F02Rrn += 1;
               Write F02Sfl;
E04          EndIf;
E03        EndIf;
E02      EndFor;
X01    Else;
?      //---Liste des objets avec le nom ObjNam-------------------------------//
         Obj = F01Obj;
         Lib = '*ALL';
         ObjectType = '*ALL';
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         FormatName = 'OBJL0100';
         QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
         StartPosit = 1;
         StartLen = 1024;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;
         NbrMbr = NumberList;

?      //---Lecture de tous les composants------------------------------------//
B02      For Nbr = 1 To NbrMbr;
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
           StartPosit = StartPosit + StartLen;
?      //---Alimentation du Sous-fichier de sélection-------------------------//
           If Tab_Srch('OBLIB':DsListLib:1) > 0;
B03        If F01Typ = *Blanks or F01Typ = DsListTyp;
             F02Obj = DsListFile;
             F02Lib = DsListLib;
             F02Typ = DsListTyp;
             QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                   F02Obj + F02Lib:F02Typ:ApiError);
             F02Des = OdObjTxtDes;
?      //---Bibliothèque existe dans la liste ?-------------------------------//
B04          If Tab_Srch('OBLIB':F02Lib:1) = 0;
               Dsp_Bib = *On;
X04          Else;
B05            If Not DspPc;
                 DspPc = *On;
E05            EndIf;
               Dsp_Bib = *Off;
E04          EndIf;
?      //---Remplissage du sous-fichier---------------------------------------//
B04          If Trt <> '*INTERACTIVE';
               Nbr = NbrMbr;
               i = Tab_Inf('OBLIB');
               F02Rrn = 1;
X04          Else;
               F02Rrn += 1;
               Write F02Sfl;
E04          EndIf;
E03        EndIf;
           EndIf;
E02      EndFor;
?      //---Liste des objets avec le nom ObjNam-------------------------------//
         Obj = F01Obj;
         Lib = '*ALL';
         ObjectType = '*ALL';
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         FormatName = 'OBJL0100';
         QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
         StartPosit = 1;
         StartLen = 1024;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;
         NbrMbr = NumberList;

B02      For Nbr = 1 To NbrMbr;
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
           StartPosit = StartPosit + StartLen;
           If Tab_Srch('OBLIB':DsListLib:1) = 0;
?      //---Alimentation du Sous-fichier de sélection-------------------------//
B03        If F01Typ = *Blanks or F01Typ = DsListTyp;
             F02Obj = DsListFile;
             F02Lib = DsListLib;
             F02Typ = DsListTyp;
             QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                   F02Obj + F02Lib:F02Typ:ApiError);
             F02Des = OdObjTxtDes;
?      //---Bibliothèque existe dans la liste ?-------------------------------//
B04          If Tab_Srch('OBLIB':F02Lib:1) = 0;
               Dsp_Bib = *On;
X04          Else;
B05            If Not DspPc;
                 DspPc = *On;
E05            EndIf;
               Dsp_Bib = *Off;
E04          EndIf;
?      //---Remplissage du sous-fichier---------------------------------------//
B04          If Trt <> '*INTERACTIVE';
               Nbr = NbrMbr;
               i = Tab_Inf('OBLIB');
               F02Rrn = 1;
X04          Else;
               F02Rrn += 1;
               Write F02Sfl;
E04          EndIf;
E03        EndIf;
           EndIf;
E02      EndFor;
E01    EndIf;

?      //---Si un seul enregistrement, retour à l'écran principal sinon ...---//
B01    If F02Rrn = 1;
         F01Obj = F02Obj;
         QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                 F02Obj + F02Lib:F02Typ:ApiError);
         F01Des = OdObjTxtDes;
         F01Bib = F02Lib;
         F01typ = F02Typ;
X01    Else;
?      //---...Affichage du sous-fichier--------------------------------------//
B02      If F02Rrn > 0;
           ExFmt F02Ctl;
E02      EndIf;

?      //---Récupération de l'objet sélectionné-------------------------------//
B02      If F02Cur > 0 and not exit and not retour;
           Chain F02Cur F02Sfl;
B03        If %Found;
             F01Obj = F02Obj;
?      //---Récupération de la description de l'objet-------------------------//
             QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                     F02Obj + F02Lib:F02Typ:ApiError);
             F01Des = OdObjTxtDes;
             F01Bib = F02Lib;
             F01typ = F02Typ;
E03        EndIf;
X02      Else;
B03        If Tab_Get('Rappel1':IndRapWrk) <> *Blanks;
             F01Obj = Tab_Get('Rappel1':IndRapWrk);
             F01Des = Tab_Get('Rappel2':IndRapWrk);
             F01Bib = Tab_Get('Rappel3':IndRapWrk);
             F01Typ = Tab_Get('Rappel4':IndRapWrk);
E03        EndIf;
           Retour = *Off;
           Exit = *Off;
E02      EndIf;
E01    EndIf;

?      //---Couleur de la bibliothèque sur écran principale-------------------//
B01    If Tab_Srch('OBLIB':F01Bib:1) = 0 and F01Bib <> *Blanks;
         Dsp_Bib = *On;
X01    Else;
         Dsp_Bib = *Off;
E01    EndIf;
       DspPc = *Off;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

?      //---Ajout de la bibliothèque dans PGMREF si inexistante---------------//
       If Tab_Srch('OBLIB':F01Bib:1) = 0 and F01Bib <> '*ALL' And
       F01Bib <> '*LIBL' and F01Bib <> '';
         F15Bib = F01Bib;
         ExFmt F15;
         If Not Retour;
      /End-Free
     c/Exec Sql
     C+ Insert Into ZZ01PF Values('OBLIB', :F01Bib)
     c/End-Exec
      /Free
           Maj_Ref(F01Bib);
           Tab_Term('OBLIB');
           ExSr Get_Bib_Obj;
           Dsp_Bib = *Off;
         EndIf;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Contrôle des options disponibles----------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Chk_Options;

       Select ;
         When F01Typ = *Blanks;
           AutObj = OptVide;
         When F01Typ = '*FILE';
           AutObj = OptFile;
         When F01Typ = '*PGM';
           AutObj = OptPgm;
         When F01Typ = '*MODULE';
           AutObj = OptModule;
         When F01Typ = '*DTAARA';
           AutObj = OptDtaara;
         When F01Typ = '*SRVPGM';
           AutObj = OptSrvPgm;
         When F01Typ = '*QRYDFN';
           AutObj = OptQuery;
       EndSl;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Appel de l'option-------------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Call_Option;

?      //---Initialisation des zones de travail-------------------------------//
       Reset LigXref;
       Ctl_Fonct = *Off;

?      //---ORIENTATION SUIVANT FONCTIONNALITE--------------------------------//
       Select;

?      //---[F01]------------------------------------------------------------*//
         When OptAide or Entry_Fct = '*HELP';
           ZzFonc = '*HELP';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Dsp_Chg;
?      //---[F02]------------------------------------------------------------*//
         When OptXref or Entry_Fct = '*XREF';
           Tab_Term2('££WRK');
           ZzFonc = '*XREF';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr XRef;
           Ctl_Fonct = *On;
?      //---[F04]------------------------------------------------------------*//
         When OptRecDesc or Entry_Fct = '*RECDESC';
           Tab_Term2('££WRK');
           ZzFonc = '*RECDESC';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Rec_Desc;
           Ctl_Fonct = *On;
?      //---[F05]------------------------------------------------------------*//
         When OptPlugin;
           ExSr Plugin;
           Ctl_Fonct = *On;
?      //---[F06]-------------------------------------------------------------//
         When OptRunQry Or Entry_Fct = '*RUNQRY';
           ZzFonc = '*RUNQRY';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Run_Qry;
           Ctl_Fonct = *Off;
?      //---[F07]-------------------------------------------------------------//
         When OptDesc or Entry_Fct ='*DESCFILE';
           Tab_Term2('££WRK');
           ZzFonc = '*DESCFILE';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           Exsr Dsp_File;
           Ctl_Fonct = *On;
?      //---[F08]-------------------------------------------------------------//
         When OptAccPth or Entry_Fct = '*LSTLF';
           Tab_Term2('££WRK');
           ZzFonc = '*LSTLF';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Dsp_Accpth;
           Ctl_Fonct = *On;
?      //---[F09]-------------------------------------------------------------//
         When OptRappel;
           If IndRapWrk = Ind_Rappel;
             IndRapWrk = Ind_Rappel;
           EndIf;
           IndRapWrk -= 1;
           If IndRapWrk < 1;
             IndRapWrk = 1;
           EndIf;
           If IndRapWrk > 0;
             F01Obj = Tab_Get('Rappel1':IndRapWrk);
             F01Des = Tab_Get('Rappel2':IndRapWrk);
             F01Bib = Tab_Get('Rappel3':IndRapWrk);
             F01Typ = Tab_Get('Rappel4':IndRapWrk);
             ZzFonc = Tab_Get('Rappel5':IndRapWrk);
             SavComp = *Blanks;
             SavComp = F01Obj + F01Bib + F01Typ;
             FzzDesc = Rtv_entete(ZzFonc);
             Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
             Tab_Trf2(%Char(IndRapWrk):'££WRK');
             Ctl_Fonct = *On;
           EndIf;
?      //---[F10]-------------------------------------------------------------//
         When OptRappelP;
           IndRapWrk += 1;
           If IndRapWrk > Ind_Rappel;
             IndRapWrk = Ind_rappel;
           EndIf;
           If IndRapWrk > 0;
             F01Obj = Tab_Get('Rappel1':IndRapWrk);
             F01Des = Tab_Get('Rappel2':IndRapWrk);
             F01Bib = Tab_Get('Rappel3':IndRapWrk);
             F01Typ = Tab_Get('Rappel4':IndRapWrk);
             ZzFonc = Tab_Get('Rappel5':IndRapWrk);
             SavComp = *Blanks;
             SavComp = F01Obj + F01Bib + F01Typ;
             FzzDesc = Rtv_entete(ZzFonc);
             Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
             Tab_Trf2(%Char(IndRapWrk):'££WRK');
             Ctl_Fonct = *On;
           EndIf;
?      //---[F11]-------------------------------------------------------------//
         When OptRecProc or Entry_Fct = '*RECPROC';
           Tab_Term2('££WRK');
           ZzFonc = '*RECPROC';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Rec_Procedure;
           Ctl_Fonct = *On;
?      //---[F13]-------------------------------------------------------------//
         When OptImpr;
           ExSr Prt_Sfl;
?      //---[F14]-------------------------------------------------------------//
         When OptWhereUsed or Entry_Fct = '*WHEREUSED';
           Tab_Term2('££WRK');
           ZzFonc = '*WHEREUSED';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Where_Used;
           Ctl_Fonct = *On;
?      //---[F15]-------------------------------------------------------------//
         When OptCarto or Entry_Fct = '*CARTOPGM'
           and F01Obj <> *Blanks;
           Tab_Term2('££WRK');
           ZzFonc ='*CARTOPGM';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           Exsr AlgoPgm;
           Ctl_Fonct = *On;
?      //---[F16]-------------------------------------------------------------//
         When OptCartoSrc or Entry_Fct = '*CARTOSRC'
           or Entry_Fct ='*CARTOSRC2';
           Tab_Term2('££WRK');
           ZzFonc ='*CARTOSRC';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Analyse;
           Ctl_Fonct = *On;
?      //---[F17]-------------------------------------------------------------//
         When OptRecZone or Entry_Fct = '*RECZONE' and F01Obj <> *Blanks;
           ZzFonc = '*RECZONE';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Rec_Zone;
           Ctl_Fonct = *On;
?      //---[F18]-------------------------------------------------------------//
         When OptSplf or Entry_Fct = '*WRKSPLF';
           ExSr Wrk_Splf;
           Ctl_fonct = *On;
?      //---[F19]-------------------------------------------------------------//
         When OptAffObj or Entry_Fct = '*DESCOBJ';
           Tab_Term2('££WRK');
           ZzFonc = '*DESCOBJ';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Aff_Obj;
           Ctl_Fonct = *On;
?      //---[F20]-------------------------------------------------------------//
         When OptCartoIle or Entry_Fct = '*CARTOILE';
           Tab_Term2('££WRK');
           ZzFonc = '*CARTOILE';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           ExSr Carto_Ile;
           Ctl_Fonct = *On;
?      //---[F21]-------------------------------------------------------------//
         When OptLigCmd or Entry_Fct = '*CMD';
           ZzFonc = '*CMD';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           QUsCmdLn();
?      //---[F22]-------------------------------------------------------------//
         When OptSrch or Entry_Fct = '*RECCAR' and F01Obj <> *Blanks;
           Tab_Term2('££WRK');
           ZzFonc = '*RECCAR';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           Exsr Scan;
           Ctl_Fonct = *On;
?      //---[F23]-------------------------------------------------------------//
         When OptAnalyse or Entry_Fct = '*ANALYSE';
           Tab_Term2('££WRK');
           ZzFonc = '*ANALYSE';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           Gst_Analyse();
           Ctl_Fonct = *On;
?      //---[F24]-------------------------------------------------------------//
         When OptBib or Entry_Fct = '*LIBRARY';
           ZzFonc = '*LIBRARY';
           FzzDesc = Rtv_entete(ZzFonc);
           Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
           Exsr Liste_Bib;
?      //---[Fxx]-------------------------------------------------------------//
         When Entry_Fct = '*PGMREF';
           If Tab_Srch('OBLIB':F01Obj:1) = 0;
      /End-Free
     c/Exec Sql
     C+ InSERT INTO ZZ01PF VALUES('OBLIB', :F01Obj)
     c/End-Exec
      /Free
           EndIf;
           Maj_Ref(F01Obj);
           Ctl_Fonct = *Off;

       EndSl;

?      //---Mise en mémoire des dernières recherches--------------------------//
       If %Trim(F01Obj) + %Trim(F01Bib) + %Trim(F01Typ) +%Trim(ZzFonc) <>
          %Trim(Tab_Get('Rappel1':Ind_Rappel)) +
          %Trim(Tab_Get('Rappel3':Ind_Rappel)) +
          %Trim(Tab_Get('Rappel4':Ind_Rappel)) +
          %Trim(Tab_Get('Rappel5':Ind_Rappel))
           And Not OptRappel And Not OptRappelP
           And ZzFonc <> '*LIBRARY' And ZzFonc <> '*ANALYSE'
           And ZzFonc <> *Blanks And Ctl_Fonct;
         Ind_Rappel += 1;
         IndRapWrk = Ind_Rappel;
         Tab_Set('Rappel1':Ind_Rappel:F01Obj);
         Tab_Set('Rappel2':Ind_Rappel:F01Des);
         Tab_Set('Rappel3':Ind_Rappel:F01Bib);
         Tab_Set('Rappel4':Ind_Rappel:F01Typ);
         Tab_Set('Rappel5':Ind_Rappel:ZzFonc);
         Tab_Trf2('££WRK':%Char(Ind_Rappel));
       EndIf;

?      //---Sortie Impression-------------------------------------------------//
       If F01Output = 3;
         Exsr Prt_Sfl;
       EndIf;

?      //---Sortie Fichier----------------------------------------------------//
       If F01Output = 2;
         Exsr Ins_Fichier;
       EndIf;

?      //---Reset des indicateurs de touches----------------------------------//
       If Exit = *On;
         Fonc_Ind = *All'0';
         Exit = *On;
       Else;
         Fonc_Ind = *All'0';
       EndIf;

?      //---Affichage des résultats-------------------------------------------//
       If Entry_OutPut = '*DISPLAY';

         If Ctl_Fonct;
?      //---Affichage de l'entête---------------------------------------------//
           Write F01;
?      //---Affichage du pied de page-----------------------------------------//
           Write Foot;
?      //---Affichage du sous-fichier-----------------------------------------//
           ExSr Aff_Sfl;
         EndIf;

?      //---Gestion de la touche entrée---------------------------------------//
         If FzzCur > 0 and Exit <> *On and Retour <> *On and OptRappel <> *On
            and OptRappelP <> *On;
           Chain FzzCur FzzSfl;
           If %Found;
             LigXref = FzzZone;
             F01Obj = XrefNom;
             F01Des = XrefTxtDsc;
             F01Bib = XrefLnam;
             F01Typ = XrefOtyp;
             SavComp = *Blanks;
             SavComp = F01Obj + F01Bib + F01Typ;
             Exsr Chk_Composant;
           EndIf;
           FzzCur = *Zero;
         Else;
           If F01Obj <> %Subst(SavComp:1:10);
             F01Typ = *Blanks;
             F01Bib = *Blanks;
             Exsr Chk_Composant;
             SavComp = *Blanks;
             SavComp = F01Obj + F01Bib + F01Typ;
           EndIf;
         EndIf;
         F01OutPut = 1;
         Entry_Fct = '*NONE';
       Else;
?      //---Sortie fichier----------------------------------------------------//
         Entry_Fct= *Blanks;
       EndIf;

?      //---Si Mode *NOPROMPT, sortie immédiate-------------------------------//
       If Trt= '*NOPROMPT';
         Exit = *On;
       EndIf;

       DspPr = *Off;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Gestion des plugins-----------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Plugin;

?      //---Clear du sous-fichier---------------------------------------------//
       If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
         F05Rrn = 0;
         SflInd = *On;
         Write F05Ctl;
         SflInd = *Off;

         For i=1 to 20;
?      //---Alimentation du sous-fichier--------------------------------------//
           If Tb_Plugin(i) <> '';
             Plug05 =  Tb_Plugin(i);
             F05Rrn += 1;
             write f05sfl;
           EndIf;
         EndFor;

?      //---Si pas de plugin--------------------------------------------------//
         If F05Rrn = 0;
           Plug05 = 'Aucun Plugin détecté';
           F05Rrn += 1;
           write f05sfl;
         EndIf;

?      //---Affichage du sous-fichier-----------------------------------------//
         ExFmt F05ctl;
?      //---Appel du plugin---------------------------------------------------//
         If F05Cur > 0 and not Retour and not Exit;
?      //---Récupération de l'objet sélectionné-------------------------------//
           Chain F05Cur F05Sfl;
           If %Found;
?      //---Alimentation des paramètres en entrée-----------------------------//
             Exsr Alim_DataPlugin;
?      //---Appel du Plugin---------------------------------------------------//
             Select;
               When  F05Cur = 1;
                 Rec_Avc(DataPlugin);
               When  F05Cur = 2;
                 Taille_Bib(DataPlugin);
               When  F05Cur = 3;
                 Net_PgmRef(DataPlugin);
               When  F05Cur = 4;
                 Zone_Prog(DataPlugin);
               When  F05Cur = 5;
                 Arc_Trigg(DataPlugin);
             EndSl;
?      //---Récupération des paramètres en sortie-----------------------------//
             Exsr Extr_DataPlugin;
           EndIf;
         EndIf;
       EndIf;
       EndSr;

?      //---------------------------------------------------------------------//
?      //---Alimentation des paramètres pour les plugin-----------------------//
?      //---------------------------------------------------------------------//

       BegSr Alim_DataPlugin;
       x_Date      = %Char(%Date);
       x_heure     = %char(%Time);
       x_User      = %Trim(Utilisateur);
       x_Job       = %Trim(Travail);
       x_NJob      = %Char(Numero);
       x_Os400     = Version_Os;
       x_Version   = Version;
       x_Plugin    = Plug05;
       x_SrvPgm    = ''      ;
       x_SrvLib    = ''      ;
       x_Mode      = %Char(F01Mode);
       x_Output    = %Char(F01Output);
       x_Objet     = F01Obj;
       x_Bib       = F01Bib;
       x_Type      = F01Typ;
       x_Texte     = F01Des;
       x_FicSrc    = OdObjSrcFil;
       x_BibSrc    = OdObjSrcLib;
       x_MbrSrc    = OdObjSrcMbr;
       x_NivSrc    = F12Mod;
       x_LastFunct = ZzFonc;
       x_BibRef    = LibRef;
       EndSr;

?      //---------------------------------------------------------------------//
?      //---Extraction des paramètres pour les plugin--  ---------------------//
?      //---------------------------------------------------------------------//

       BegSr Extr_DataPlugin;
       F01Obj = x_Objet;
       F01Bib = x_Bib;
       F01Typ = x_Type;
       F01Des = x_Texte;
       F12Src = x_FicSrc;
       F12Lib = x_BibSrc;
       F12Mbr = x_MbrSrc;
       F12Mod = x_NivSrc;
       ZzFonc = x_LastFunct;
       LibRef = x_BibRef;
       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F02] : XREF------------------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr XRef;

?      //---Traduction du type d'objet----------------------------------------//
       Select;
       when F01Typ = '*PGM';
         Spkg = 'P';
       when F01Typ = '*MODULE';
         Spkg = 'M';
       when F01Typ = '*SRVPGM';
         Spkg = 'V';
       when F01Typ = '*QRYDFN';
         Spkg = 'Q';
       EndSl;

?      //---Requete sur PGMREF------------------------------------------------//
       Requete1 = 'select whfnam, whlnam, whfusg, whOtyp, whrfsn, whrfnm from '+
       LibRef + '/pgmref where whpnam = ''' + %Trim(F01Obj) +
       ''' and whlib = ''' + %Trim(F01Bib) + ''' and whSpkg = ''' + Spkg + '''';

?      //---Préparation, Déclaration, Ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     c+ Prepare S1_PgmRef From :Requete1
     c/End-Exec
     c/Exec Sql
     c+ Declare C1_PgmRef Cursor For S1_PgmRef
     c/End-Exec
     c/Exec Sql
     c+ OPEN C1_PGMREF
     c/End-Exec

     c/Exec Sql
     c+ Fetch Next From C1_PGMREF INTO :Fnam, :Lnam, :Fusg, :Otyp, :Rfsn,
     c+ :Rfnm
     c/End-Exec
      /Free

       Cpt_I = 0;
       Dow SqlCod <> EndOfFile;
         ObjChk = Fnam;
         TypChk = Otyp;
         LibChk = Lnam;
         Exsr Chk_Obj;
         Exsr Chk_Usage;
?      //---Alimentation des zones--------------------------------------------//
         XrefNom    = Fnam;
         XrefTxtDsc = TxtDscOk;
         XrefUsage  = Usage;
         XrefRfnm   = Rfnm;
         XrefOTyp   = OTyp;
         XrefLnam   = Lnam;
         XrefRfsn   = Rfsn;
         FzzZone    = *Blanks;
         FzzZone    = LigXref;

?      //---Alimentation du tableau principal---------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);

      /End-Free
     c/Exec Sql
     c+ Fetch Next From C1_PGMREF INTO :Fnam, :Lnam, :Fusg, :Otyp, :Rfsn,
     c+ :Rfnm
     c/End-Exec
      /Free
       Enddo;

      /End-Free
     c/Exec Sql
     C+ Close C1_PgmRef
     c/End-Exec
      /Free

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Contrôle de l'objet-----------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Chk_Obj;

       WLiblOk  = *Blanks;
       TxtDscOk = *Blanks;
       SrcMbrOk = *Blanks;
       SrcFOk   = *Blanks;
       SrcLibOk = *Blanks;

?      //---Traduction du composant-------------------------------------------//
       ObjChk = %XLate(lo:up:ObjChk);

?      //---Recherche de la description de l'objet----------------------------//
       QusrObjd(ObjD0400:%Size(ObjD0400):CObjD0400
              :ObjChk+LibChk:TypChk:ApiError);
?      //---Objet non trouvé--------------------------------------------------//
       If AeBytAvl > *Zero;
         WLiblOk = *All'?';
         TxtDscOk = *All'?';
         SrcMbrOk = *Blanks;
         SrcFOk = *Blanks;
         SrcLibOk = *Blanks;
       Else;
?      //---Objet trouvé------------------------------------------------------//
         WLiblOk = OdObjLib;
         TxtDscOk = OdObjTxtDes;
         SrcMbrOk = OdObjSrcMbr;
         SrcFOk = OdObjSrcFil;
         SrcLibOk = OdObjSrcLib;
         i = Tab_Inf('OBLIB');
       EndIf;

       If AeBytAvl > *Zero;
         For i=1 to Tab_Inf('OBLIB');
  ?      //---Recherche de la description de l'objet--------------------------//
           QusrObjd(ObjD0400:%Size(ObjD0400):CObjD0400
                   : ObjChk + %subst(Tab_Get('OBLIB':i):1:10)
                   : TypChk:ApiError);
  ?      //---Objet non trouvé------------------------------------------------//
           If AeBytAvl > *Zero;
             WLiblOk = *All'?';
             TxtDscOk = *All'?';
             SrcMbrOk = *Blanks;
             SrcFOk = *Blanks;
             SrcLibOk = *Blanks;
           Else;
  ?      //---Objet trouvé----------------------------------------------------//
             WLiblOk = OdObjLib;
             TxtDscOk = OdObjTxtDes;
             SrcMbrOk = OdObjSrcMbr;
             SrcFOk = OdObjSrcFil;
             SrcLibOk = OdObjSrcLib;
             i = Tab_Inf('OBLIB');
           EndIf;
         EndFor;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Contrôle de l'usage d'un fichier----------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Chk_Usage;

       Select;
         When Fusg  = 0;
           Usage =' N/A';
         When Fusg  = 1;
           Usage =' Lecture';
         When Fusg  = 2;
           Usage =X'22' + 'Ecriture';
         When Fusg  = 3;
           Usage= X'22' + 'Lect./Ecrit.';
         When Fusg  = 4;
           Usage= X'22' + 'Mise à jour';
         When Fusg  = 5;
           Usage= X'22' + 'Lecture/MàJ';
         When Fusg  = 6;
           Usage= X'22' + 'Ecriture/MàJ';
         When Fusg  = 7;
           Usage= X'22' + 'Le./Ec./MàJ';
         When Fusg  = 8;
           Usage= ' Non indiqué';
         When Fusg  = 9;
           Usage= ' Lecture/NI';
         When Fusg  = 10;
           Usage= X'22' + 'Ecriture/NI';
         When Fusg  = 11;
           Usage= X'22' + 'Le./Ec./NI';
         When Fusg  = 12;
           Usage= X'22' + 'MàJ/NI';
       EndSl;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F19] : Affichage de la description d'un objet--------------------//
?      //---------------------------------------------------------------------//

       BegSr Aff_Obj;

?      //---Recherche information de l'objet----------------------------------//
       QusrObjd(Objd0400:%size(Objd0400):Cobjd0400:
                   F01Obj + F01Bib:F01Typ:ApiError);
?      //---Nom de l'objet---------------------------------------------Lig. 1-//
       FzzZone = 'Nom de l''Objet..:' + x'22'+ OdObjNam;

?      //---Alimentation du tableau principal---------------------------------//
       Cpt_I = 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Bibliothèque de l'objet------------------------------------Lig. 2-//
       FzzZone = 'Bibliothèque....:'+ x'22' + OdObjLib;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Type de l'objet--------------------------------------------Lig. 3-//
       FzzZone = 'Type de l''Objet.:' + x'22'+ OdObjTypRt;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Description de l'objet-------------------------------------Lig. 4-//
       FzzZone = 'Description.....:' + x'22'+ OdObjTxtDes;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---ASP de l'Objet---------------------------------------------Lig. 5-//
       FzzZone = 'ASP.............:' + x'22'+ %Char(OdObjASP);
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Propriétaire de l'objet------------------------------------Lig. 6-//
       FzzZone = 'Propriétaire....:' + x'22'+ OdObjOwn;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Domaine de l'objet-----------------------------------------Lig. 7-//
       FzzZone = 'Domaine.........:' + x'22'+ OdObjDmn;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Info Création/Modification/Source--------------------------Lig. 8-//
       FzzZone = 'Création';
       %Subst(fzzZone:36:12)= 'Modification';
       %Subst(fzzZone:71:6)= 'Source';
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Date création----------------------------------------------Lig. 9-//
       FzzZone = '    Date........:' + x'22'+
       %subst(OdObjCrtDts:6:2) + '/' + %Subst(OdObjCrtDts:4:2) + '/' +
       %char(%Dec(%Subst(OdObjCrtDts:1:1):1:0) + 19) + %Subst(OdObjCrtDts:2:2);
       %subst(FzzZone:36:28) =  x'20' + '   Date........:' + x'22'+
       %subst(OdObjChgDts:6:2) + '/' + %Subst(OdObjChgDts:4:2) + '/' +
       %char(%Dec(%Subst(OdObjChgDts:1:1):1:0) + 19) + %Subst(OdObjChgDts:2:2);
       %subst(FzzZone:71:35) = x'20' + '   Fichier.........:' + x'22'
                               + OdObjSrcFil;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Heure création---------------------------------------------Lig. 10//
       FzzZone = '    Heure.......:' + x'22'+ %Subst(OdObjCrtDts:8:2) +
       'h' + %Subst(OdObjCrtDts:10:2) + 'mn'+%subst(OdObjCrtDts:12:2) + 's';
       %subst(FzzZone:36:28) = x'20' + '   Heure.......:' +
        x'22'+ %Subst(OdObjChgDts:8:2) +
       'h' + %Subst(OdObjChgDts:10:2) + 'mn'+%subst(OdObjChgDts:12:2) + 's';
       %subst(FzzZone:71:35) = x'20' + '   Bibliothèque....:' + x'22'
                               + OdObjSrcLib;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Membre Source----------------------------------------------Lig. 11//
       FzzZone = *Blanks;
       %subst(FzzZone:71:35) = '    Membre..........:' + x'22'+ OdObjSrcMbr;
       Cpt_I += 1;
       Tab_Set2('££WRK':Cpt_I:FzzZone);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F14] : Recherche Where Used--------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Where_Used;

       ExSr Srch_logics;

?      //---Requete sur PGMREF------------------------------------------------//
       Requete0 = 'Select whlib, whpnam, whfusg, whspkg, whtext                +
                , whfnam, whrfsn from ' + %Trim(LibRef) + '/pgmref where       +
                whfnam in ' + %Trim(all_File)                                  +
                 ' and whotyp = ''' + %Trim(F01Typ)                            +
                  ''' and whlib in (select zzvaleur from '                     +
                  'zz01pf where zztype=''OBLIB'' ) order by Whlib';

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     c+ Prepare S2_PgmRef From :Requete0
     c/end-exec
     c/Exec Sql
     c+ Declare C2_PgmRef Cursor For S2_PgmRef
     c/end-exec
     c/Exec Sql
     c+ OPEN C2_PGMREF
     c/end-exec

     c/Exec Sql
     c+ Fetch Next From C2_PGMREF INTO :Lib, :Pnam, :Fusg, :Spkg, :Desc,
     c+ :Rfnm, :Rfsn
     c/End-Exec
      /Free

       Cpt_I = 0;
       Dow SqlCod <> EndOfFile;
?      //---Alimentation du Sous Fichier--------------------------------------//
         Select;
           When Spkg = 'P';
             Otyp = '*PGM';
           When Spkg = 'F';
             Otyp = '*FILE';
           when Spkg = 'M';
             Otyp = '*MODULE';
           when Spkg = 'V';
             Otyp = '*SRVPGM';
           when Spkg = 'Q';
             Otyp = '*QRYDFN';
         Other;
             Otyp = *all'?';
         EndSl;

         ObjChk = Pnam;
         TypChk = Otyp;
         LibChk = Lib;
         ExSr Chk_Obj;
         Exsr Chk_Usage;
?      //---Alimentation des zones--------------------------------------------//
         FzzZone    = *Blanks;
         XrefNom    = Pnam;
         XrefTxtDsc = TxtDscOk;
         XrefUsage  = Usage;
         XrefRfnm   = Rfnm;
         XrefOTyp   = OTyp;
         XrefLnam   = Lib;
         XrefRfsn   = Rfsn;
         FzzZone    = LigXref;

?      //---Alimentation du tableau principal---------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);

      /End-Free
     C/Exec Sql
     C+ Fetch Next From C2_PGMREF INTO :Lib, :Pnam, :Fusg, :Spkg, :Desc,
     C+ :Rfnm, :Rfsn
     c/End-Exec
      /Free
       Enddo;

      /End-Free
     C/Exec Sql
     C+ CLOSE C2_PGMREF
     c/End-Exec
      /Free


       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F07] : Affichage description du fichier--------------------------//
?      //---------------------------------------------------------------------//

       BegSr Dsp_File;

       Obj = F01Obj;
       Lib = F01Bib;
       Cpt_I = 0;
?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       SpaceLen = MaxTab;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);
?      //---Liste des formats d'un fichier------------------------------------//
       FormatName = 'RCDL0100';
       OverRide = '1';
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUslRcd(UserSpace:FormatName:Composant:OverRide);

?      //---Retrieve user space General information---------------------------//
       StartPosit = 1;
       StartLen = 1024;
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       Qusptrus(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
       StartPosit = ListOffset + 1;
       StartLen = EntrySize;
       NbrFmt = NumberList;
       K = 1;

?      //---Lecture de tous les Membres d'un fichier source-------------------//
       For j = 1 To NbrFmt;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:fmt);
         StartPosit = StartPosit + StartLen;
         Tab_Set('FMT':k:Fmt);
         k += 1;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

       For j = 1 to Tab_Inf('FMT');
         FzzZone = 'Format : ' + x'22' + Tab_Get('FMT':j);
?      //---Alimentation du tableau principal---------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Create User Space-------------------------------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                  SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Get the list of all the fields------------------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         OverRide = '1';
         Type = Tab_Get('FMT':j);
         Format  = 'FLDL0100';
         Quslfld(UserSpace:Format:Composant:Type:OverRide);

?      //---Get a pointer to the user space containing the list---------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);

         For i = 1 to  NumberList;
           LigDescFile = *Blanks;
           pEntry = pUserSpace + listOffset + ((i-1)*entrySize);
           DescNom = FieldName;
           DescDes = FieldText;
           DescInt = IntName;
           DescAlt = AltName;
           Evalr DescTyp = DataType;
           Evalr DescDeb = %char(OutBufPos);
           Evalr DescFin = %char(OutBufPos + ByteLeng - 1);

           If Digits = 0;
             Evalr DescLon = %char(ByteLeng);
           Else;
             Evalr DescLon = %char(Digits);
           EndIf;

           If DescTyp = 'A';
             DescDec = *Blanks;
             If VaryingInd <> '0';
               DescDec = '~';
             EndIf;
           Else;
             DescDec = %char(DecPos);
           EndIf;

           FzzZone = LigDescFile;
           If %Subst(%trim(FzzZone):1:3) <> '*IN';
?      //---Alimentation du tableau principal---------------------------------//
             Cpt_I += 1;
             Tab_Set2('££WRK':Cpt_I:FzzZone);
           EndIf;

         EndFor;
?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

       EndFor;

       Tab_Term('FMT');

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F16] : Analyse du programme--------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr Analyse;

       Cpt_I = 0;

       If Trt = '*INTERACTIVE';
?      //---Recherche du fichier source si possible---------------------------//
         If F01Obj <> *Blanks;
           ObjChk = F01Obj;
           TypChk = F01Typ;
           Exsr Chk_Obj;
           F12Mod = '0';
           If OdObjSrcFil = *Blanks;
             OdObjSrcMbr = F01Obj;
             OdObjSrcLib = F01Bib;
           EndIf;
         Else;
           OdObjSrcMbr = *Blanks;
           OdObjSrcLib = *Blanks;
           OdObjSrcFil = *Blanks;
         EndIf;
       Else;
         If Entry_Fct= '*CARTOSRC2';
           F12Mod ='1';
         Else;
           F12Mod ='0';
         EndIf;
       EndIf;

       If Trt = '*INTERACTIVE' and Entry_FicSrc = *Blanks;
         F12Mbr = F01Obj;
         F12Mbr = OdObjSrcMbr;
         F12Lib = OdObjSrcLib;
         F12Src = OdObjSrcFil;
         Dou (F12Mbr <> *Blanks and F12Lib <> *Blanks and F12Src <> *Blanks)
         or Exit or Retour;
           ExFmt F12;
         EndDo;
       Else;
         Entry_MbrSrc = *Blanks;
         Entry_FicSrc = *Blanks;
         Entry_BibSrc = *Blanks;
       EndIf;

       If F12Mod = '0';
         ZzFonc = '*CARTOSRC';
       Else;
         ZzFonc = '*CARTOSRC2';
       EndIf;

       If Not Exit and Not Retour;

?      //---Appel de l'algorithme de cartographie-----------------------------//
         If Src_Analyse(F12Lib:F12Src:F12Mbr:F12Mod);

?      //---Appel de l'algorithme de cartographie-----------------------------//
           Algo();

?      //---Affichage du sous-fichier-----------------------------------------//
           For g = 1 To Mat_Infy(1);
             FzzZone = *Blanks;
             For f = 1 To Mat_Infx(1);
               LenMat = Mat_lenCol(1:f);
               If f > 1;
                 LenMatP = LenMatP + Mat_LenCol(1:f-1);
               Else;
                 LenMatP = 1;
               EndIf;
               %subst(FzzZone:LenMatP:LenMat) = %subst(Mat_Get(1:f:g):1:LenMat);
             EndFor;

?      //---Affichage Statut--------------------------------------------------//
             If Trt ='*INTERACTIVE';
               Stat001 = 'Affichage du Sous-Fichier';
               Stat002 = 'Rang = ' + %char(FzzRrn);
               Stat003 = *blanks;
               write F13;
             EndIf;

?      //---Alimentation du tableau de travail--------------------------------//
             Cpt_I += 1;
             Tab_Set2('££WRK':Cpt_I:FzzZone);

           EndFor;

?      //---Suppression des tableaux------------------------------------------//
           Tab_Term('1');
           Tab_Term('2');
           Tab_Term('3');
           Tab_Term('4');
           Tab_Term('5');
           Tab_Term('6');
           Tab_Term('7');
           Mat_Term(1);
           Close QSysPrt;
         Else;
           Exit = *Off;
           Retour = *Off;
         EndIf;
       EndIf;

?      //---Mise à jour des touches F03 et F12--------------------------------//
       Exit = *Off;
       Retour = *Off;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F20] : Cartogrpahie ILE------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Carto_Ile;

?      //---Initialisation avec le composant renseigné------------------------//
       OutputSv = Entry_OutPut;
       Id_Ile = 1;
       Cpt_Ile = 0;
       Cpt_I = 0;
       Tab_Set('Objet' : Id_Ile : F01Obj);
       Tab_Set('Type'  : Id_Ile : F01Typ);
?      //---Recensement des objets--------------------------------------------//
       For I_Ile = 1 to Id_Ile;
         Select;
           when Tab_get('Type':I_Ile) = '*PGM';
             ExSr Carto_Pgm;
           when Tab_get('Type':I_Ile) = '*MODULE';
             ExSr Carto_Module;
           when Tab_get('Type':I_Ile) = '*SRVPGM';
             ExSr Carto_SrvPgm;
           when Tab_get('Type':I_Ile) = '*BNDDIR';
             ExSr Carto_BndDir;
          EndSl;
       EndFor;
?      //---Appel de l'algorithme de cartographie-----------------------------//
       For i = 1 to Tab_Inf('A');
         Tab_set('1':i:%Trim(Tab_Get('Objet':%Dec(Tab_Get('A':i):5:0))) + ' - '+
                       %Trim(Tab_Get('Type':%Dec(Tab_Get('A':i):5:0))));
         Tab_set('2':i:%Trim(Tab_Get('Objet':%Dec(Tab_Get('B':i):5:0))) + ' - '+
                       %Trim(Tab_Get('Type':%Dec(Tab_Get('B':i):5:0))));
       EndFor;
?      //---Formattage Procédure Exportées------------------------------------//
       For i = 1 To Tab_Inf('1');
         If %Scan('*PROC ':Tab_Get('2':i)) > 0;
           Index_X = Tab_Srch('2':%Trim(Tab_Get('2':i)) +'-X':1);
           If Index_X > 0;
             Tab_Set('1':Index_X:*Blanks);
             Tab_Set('2':Index_X:*Blanks);
             Tab_Set('2':i:x'28' + %Trim(Tab_Get('2':i)) + x'20');
           EndIf;
         EndIf;
       EndFor;
?      //---Formattage Procédure Importées------------------------------------//
       For i = 1 To Tab_Inf('1');
         If %Scan('*PROC-I':Tab_Get('2':i)) > 0;
           Tab_Set('2':i:x'30' + %Trim(Tab_Get('2':i)) + x'20');
         EndIf;
       EndFor;
       Entry_Output = OutPutSv;
       Algo();
?      //---Affichage du sous-fichier-----------------------------------------//
       For g = 1 To Mat_Infy(1);
         FzzZone = *Blanks;
         For f = 1 To Mat_Infx(1);
          LenMat = Mat_lenCol(1:f);
          If f > 1;
            LenMatP = LenMatP + Mat_LenCol(1:f-1);
          Else;
            LenMatP = 1;
          EndIf;
          %subst(FzzZone:LenMatP:LenMat) = %subst(Mat_Get(1:f:g):1:LenMat);
         EndFor;
         FzzZone = %xlate(x'00':x'40':FzzZone);

?      //---Alimentation du tableau principal---------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);

       EndFor;
?      //---Suppression des tableaux------------------------------------------//
       Tab_Term('A');
       Tab_Term('B');
       Tab_Term('1');
       Tab_Term('2');
       Tab_Term('3');
       Tab_Term('4');
       Tab_Term('5');
       Tab_Term('6');
       Tab_Term('7');
       Mat_Term(1);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Cartographie ILE d'un programme-----------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Carto_Pgm;
       Id_Ile_Premier = I_Ile;
?      //---Liste des Modules-------------------------------------------------//
?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       FormatName = 'PGML0110';
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       QBnlPgmi(UserSpace:FormatName:Object:ApiError);
?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:Lst_Dta_Pgm);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : Lst_Mod);
         Tab_Set('Type'  : Id_Ile : '*MODULE');
         ListOffset = ListOffset + Lst_Size;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);
?      //---Liste des Programmes de services----------------------------------//
?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       FormatName = 'PGML0200';
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       QBnlPgmi(UserSpace:FormatName:Object:ApiError);
?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:Lst_Dta_SrvPgm);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : Lst_Srv);
         Tab_Set('Type'  : Id_Ile : '*SRVPGM');
         ListOffset = ListOffset + 56;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);
       EndSr;

?      //---------------------------------------------------------------------//
?      //---Cartographie ILE d'un module--------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Carto_Module;
       Id_Ile_Premier = I_Ile;
?      //---Liste des Procédures Définies-------------------------------------//
?      //---Create the User Space---------------------------------------------//
       SpaceName  = 'USERSPACE' ;
       SpaceLib   = 'QTEMP'     ;
       SpaceAttr  = *Blanks     ;
       SpaceLen   = 4096        ;
       SpaceValue = x'00'       ;
       SpaceAuth  = '*CHANGE'   ;
       SpaceText  = *Blanks     ;
       SpaceReplc = '*YES'      ;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Call the API------------------------------------------------------//
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       SpaceName = 'USERSPACE';
       SpaceLib  = 'QTEMP';
       Format    = 'MODL0300';
       QBnlModi(UserSpace:Format:Object:ApiError);

?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);

?      //---Retrieve List Information-2---------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = List_Size;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);
         Procedure = %Subst(List_ProcName:1:List_Size - 46);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : Procedure);
         Tab_Set('Type'  : Id_Ile : '*PROC');
         ListOffset = ListOffset + List_Size;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

?      //---Liste des Procédures Exportées------------------------------------//
?      //---Create the User Space---------------------------------------------//
       SpaceName  = 'USERSPACE' ;
       SpaceLib   = 'QTEMP'     ;
       SpaceAttr  = *Blanks     ;
       SpaceLen   = 1024        ;
       SpaceValue = x'00'       ;
       SpaceAuth  = '*CHANGE'   ;
       SpaceText  = *Blanks     ;
       SpaceReplc = '*YES'      ;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Call the API------------------------------------------------------//
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       SpaceName = 'USERSPACE';
       SpaceLib  = 'QTEMP';
       Format    = 'MODL0100';
       QBnlModi(UserSpace:Format:Object:ApiError);

?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);

?      //---Retrieve List Information-2---------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = List_Size;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);
         Procedure = %Subst(List_ProcName:1:List_Size - 46);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : Procedure);
         Tab_Set('Type'  : Id_Ile : '*PROC-X');
         ListOffset = ListOffset + List_Size;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

?      //---Liste des Procédures Importées------------------------------------//
?      //---Create the User Space---------------------------------------------//
       SpaceName  = 'USERSPACE' ;
       SpaceLib   = 'QTEMP'     ;
       SpaceAttr  = *Blanks     ;
       SpaceLen   = 4096        ;
       SpaceValue = x'00'       ;
       SpaceAuth  = '*CHANGE'   ;
       SpaceText  = *Blanks     ;
       SpaceReplc = '*YES'      ;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Call the API------------------------------------------------------//
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       SpaceName = 'USERSPACE';
       SpaceLib  = 'QTEMP';
       Format    = 'MODL0200';
       QBnlModi(UserSpace:Format:Object:ApiError);

?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);

?      //---Retrieve List Information-2---------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = List_Size;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);
         Procedure = %Subst(List_ProcName:1:List_Size - 46);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : Procedure);
         Tab_Set('Type'  : Id_Ile : '*PROC-I');
         ListOffset = ListOffset + List_Size;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

?      //---Liste des Répertoires de liage------------------------------------//
?      //---Create the User Space---------------------------------------------//
       SpaceName  = 'USERSPACE' ;
       SpaceLib   = 'QTEMP'     ;
       SpaceAttr  = *Blanks     ;
       SpaceLen   = 4096        ;
       SpaceValue = x'00'       ;
       SpaceAuth  = '*CHANGE'   ;
       SpaceText  = *Blanks     ;
       SpaceReplc = '*YES'      ;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Call the API------------------------------------------------------//
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       SpaceName = 'USERSPACE';
       SpaceLib  = 'QTEMP';
       Format    = 'MODL0400';
       QBnlModi(UserSpace:Format:Object:ApiError);

?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);

?      //---Retrieve List Information-2---------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = List_Size;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:Lst_Dta_Bnd);
         StartPosit = Lst_BndOffset + 1;
         StartLen   = Lst_BndLength;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:Lst_Bnd);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : %Subst(Lst_Bnd:1:Lst_BndLength));
         Tab_Set('Type'  : Id_Ile : Lst_BndTyp);
         ListOffset = ListOffset + Lst_BndSize;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);
       EndSr;

?      //---------------------------------------------------------------------//
?      //---Cartographie ILE d'un programme de service------------------------//
?      //---------------------------------------------------------------------//

       BegSr Carto_SrvPgm;
       Id_Ile_Premier = I_Ile;
?      //---Liste des Modules-------------------------------------------------//
?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       FormatName = 'SPGL0110';
       Object = %Subst(Tab_Get('Objet':Id_Ile_Premier):1:10) + F01Bib;
       QBnlSPgm(UserSpace:FormatName:Object:ApiError);
?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 1024;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:Lst_Dta_Srv);
         Id_Ile += 1;
         Cpt_Ile += 1;
         Tab_Set('A':Cpt_Ile:%Char(Id_Ile_Premier));
         Tab_Set('B':Cpt_Ile:%Char(Id_Ile));
         Tab_Set('Objet' : Id_Ile : Lst_Srv_Mod);
         Tab_Set('Type'  : Id_Ile : '*MODULE');
         ListOffset = ListOffset + Lst_Srv_Size;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);
?      //---Liste des Programme de services-----------------------------------//
?      //---Liste des Procédures Exportées------------------------------------//
       EndSr;

?      //---------------------------------------------------------------------//
?      //---Cartographie ILE d'un répertoire de liage-------------------------//
?      //---------------------------------------------------------------------//

       BegSr Carto_BndDir;
?      //---Liste des Modules-------------------------------------------------//
?      //---Liste des Programmes de service-----------------------------------//
       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F22] : Recherche-d'une chaine de caractères----------------------//
?      //---------------------------------------------------------------------//

       BegSr Scan;

       Cpt_Ligne = 0;
       Cpt_I = 0;

?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       SpaceLen = MaxTab;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

       j = 0;
?      //---------------------------------------------------------------------//
       For CptF22 = 1 To Tab_Inf('SCLIB');

         FormatName = 'OBJL0100';
         Obj = '*ALL';
         Lib = Tab_Get('SCLIB':CptF22);
         ObjectType = '*FILE';
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
         StartPosit = 1;
         StartLen = 1024;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;
         NbrMbr = NumberList;

         For k = 1 to NbrMbr;
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           Qusptrus(UserSpace:pUserSpace);
           QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
           StartPosit = StartPosit + StartLen;
?      //---Alimentation du tableau-------------------------------------------//
           j += 1;
           Tab_Set2('MBRFIL':j:DsListFile);
           Tab_Set2('MBRLIB':j:DsListLib);
         EndFor;

       EndFor;

       k = 1;
       For CptF22 = 1 to Tab_Inf2('MBRFIL');

?      //---Ne faire la recherche que sur des PF------------------------------//
         Obj = Tab_Get2('MBRFIL':CptF22);
         Lib = Tab_Get2('MBRLIB':CptF22);
        QusrObjd(ObjD0400:%Size(ObjD0400):CObjD0400:Composant:'*FILE':ApiError);
         If OdObjExtAtt = 'PF';
?      //---Ne prendre que les fichiers source--------------------------------//
           If RtvFd(composant);
?      //---Liste des membres d'un fichier source-----------------------------//
             FormatName = 'MBRL0200';
             ObjectType = '*ALL';
             OverRide = '1';
             SpaceName = 'USERSPACE';
             SpaceLib = 'QTEMP';
             QUslMbr(UserSpace:FormatName:Composant:ObjectType:OverRide);

?      //---Retrieve user space General information---------------------------//
             StartPosit = 1;
             StartLen = 1024;
             SpaceName = 'USERSPACE';
             SpaceLib = 'QTEMP';
             Qusptrus(UserSpace:pUserSpace);
             QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
             StartPosit = ListOffset + 1;
             StartLen = EntrySize;
             NbrMbr = NumberList;

?      //---Lecture de tous les Membres d'un fichier source-------------------//
             For j = 1 To NbrMbr;
               SpaceName = 'USERSPACE';
               SpaceLib = 'QTEMP';
               Qusptrus(UserSpace:pUserSpace);
               QUsRtvUs(UserSpace:StartPosit:StartLen:ScanDsRes);
               StartPosit = StartPosit + StartLen;
               Tab_Set2('MBRMBR':k:SourcePgm);
               Tab_Set2('MBRLIE':k:%char(CptF22));
               Tab_Set2('MBRDES':k:SourceTxt);
               k += 1;

?      //---Affichage Statut--------------------------------------------------//
               If Trt = '*INTERACTIVE';
                 Stat001 = 'Recherche Membre ...';
                 Stat002 = 'Fichier Source = ' + Obj;
                 Stat003 = 'Bibliothèque = ' + Lib;
                 Stat004 = 'Membre = ' + SourcePgm;
                 write F13;
               EndIf;

             EndFor;

           EndIf;

         EndIf;

       EndFor;

?      //---Recherche de la zone dans le fichier source-----------------------//
       For CptF22 = 1 to Tab_Inf2('MBRMBR');
?      //---Affichage Statut--------------------------------------------------//
         If Trt = '*INTERACTIVE';
           Stat001 = 'Recherche Membre ...';
           Stat002 = 'Membre = ' + Tab_Get2('MBRMBR':CptF22);
           Prctage = 100 * (CptF22 / Tab_Inf2('MBRMBR'));
           Stat003 = 'Avancement = ' + %trim(%char(prctage)) + ' %';
           Stat004 = 'Tot. lig. = ' + %char(Cpt_Ligne);
           write F13;
         EndIf;

         OvrCmd = 'OVRDBF FILE(FILE) TOFILE(' +
                 %Trim(Tab_Get2('MBRLIB':%Dec(Tab_Get2('MBRLIE':CptF22):15:0)))+
                 '/' +
                 %Trim(Tab_Get2('MBRFIL':%Dec(Tab_Get2('MBRLIE':CptF22):15:0)))+
                 ') MBR(' +
                 %Trim(Tab_Get2('MBRMBR':CptF22)) +
                 ') OVRSCOPE(*job) RCDFMTLCK((' +
                 %Trim(Tab_Get2('MBRFIL':%Dec(Tab_Get2('MBRLIE':CptF22):15:0)))+
                 ' *SHRRD))';

         OvrCmdLen = %len(OvrCmd);
         QcmdExc(OvrCmd:OvrCmdLen);
         Open(e) File;
         If Not %Error;
         SrcRet = 0;
         Read File RcdSrc;
         Dow  not %eof And SrcRet = 0;

           Cpt_Ligne += 1;
           StrScan  = 1;
           TrslScan = '1';
           TrimScan = '1';
           WildScan = '';
           LenSrcDta = %Len(SrcDta);
           LenF01Obj = %Len(%Trim(F01Obj));
           QClScan(SrcDta:LenSrcDta:StrScan:F01Obj:LenF01Obj:TrslScan:
                   TrimScan:WildScan:SrcRet);

           If SrcRet > 0;

             k = %Dec(Tab_Get2('MBRLIE':CptF22):15:0);
             ScanPNam = Tab_Get2('MBRMBR':CptF22);
             Scandes = Tab_Get2('MBRDES':CptF22);
             ScanFil = Tab_Get2('MBRFIL':k);
             ScanBib = Tab_Get2('MBRLIB':k);
             FzzZone = LigScan;

?      //---Alimentation du tableau principal---------------------------------//
             Cpt_I += 1;
             Tab_Set2('££WRK':Cpt_I:FzzZone);

           EndIf;

           read file RcdSrc;
         Enddo;
         Close File;
         EndIf;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F15] : Recherche XRef--------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr AlgoPgm;

       IndRef = 0;
       Cpt_I = 0;

?      //---Extraction des tableaux-------------------------------------------//
       If Ext_Ref(F01Obj);
?      //---Appel de l'algorithme de cartographie-----------------------------//
       Algo();

?      //---Affichage du sous-fichier-----------------------------------------//
       For g = 1 To Mat_Infy(1);
         FzzZone = *Blanks;
         For f = 1 To Mat_Infx(1);
          LenMat = Mat_lenCol(1:f);
          If f > 1;
            LenMatP = LenMatP + Mat_LenCol(1:f-1);
          Else;
            LenMatP = 1;
          EndIf;
          %subst(FzzZone:LenMatP:LenMat) = %subst(Mat_Get(1:f:g):1:LenMat);
         EndFor;
?      //---Affichage nom du programme----------------------------------------//
         Pos_Comp = %Scan('.'+x'22':FzzZone) + 2;
         If Pos_Comp > 2;
           Nom_Comp = %subst(FzzZone:Pos_comp:20);
           ObjChk = Nom_Comp;
           TypChk = '*PGM';
           Exsr Chk_Obj;
           If TxtDscOk = *all'?';
             TxtDscOk = *Blanks;
           EndIf;
           FzzZone = %Trim(FzzZone) + ' ' + x'20' +  %Trim(TxtDscOk);
         EndIf;

?      //---Affichage Statut--------------------------------------------------//
         If Trt = '*INTERACTIVE';
           Stat001 = 'Affichage du Sous-Fichier';
           Stat002 = 'Rang = ' + %char(FzzRrn);
           Stat003 = *blanks;
           write F13;
         EndIf;

?      //---Alimentation du tableau de travail--------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);

       EndFor;

?      //---Suppression des tableaux------------------------------------------//
       Tab_Term('1');
       Tab_Term('2');
       Tab_Term('3');
       Tab_Term('4');
       Tab_Term('5');
       Tab_Term('6');
       Tab_Term('7');
       Mat_Term(1);
       EndIf;
       Close QsysPrt;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F08] : Affichage des Logiques/Clés d'un physique-----------------//
?      //---------------------------------------------------------------------//
       BegSr Dsp_Accpth;

       SFileLib = %Subst(F01Obj:1:10) + F01Bib;
       First = *On;
       Cpt_I = 0;

?      //---Write Access Path-------------------------------------------------//
       ExSr GetFil;
       Tab_Term('AR');
       Tab_Term('A2');
       Clear AccPthDs;
       Clear SfValue;

       First = *Off;
       SpaceName = 'USRSPC';
       SpaceLib = 'QTEMP';

?      //---Create User Space-------------------------------------------------//
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                 SpaceAuth:SpaceText:SpaceReplc:ApiError);

       SpaceName = 'USRSPC';
       SpaceLib = 'QTEMP';
?      //---List database relations to user space-----------------------------//
       RecordFmt = '*FIRST';
       Ignore = *Blanks;
       QDblDbr(UserSpace:LstOutFmt:SFileLib:RecordFmt:
               Ignore:ApiError);

?      //---Retrieve user space general information---------------------------//
       StartPosit = 1;
       StartLen = 140;
       SpaceName = 'USRSPC';
       SpaceLib = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
       StartPosit = 1;
       StartLen = InputSize;
       SpaceName = 'USRSPC';
       SpaceLib = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:InputDs);

?      //---Retrieve the list by walking trough the user space----------------//
       StartPosit = (ListOffset + 1);
       StartLen = EntrySize;
       SaveLen = EntrySize;
       NbrLogics = NumberList;

       For NbrL = 1 to Nbrlogics;
         SpaceName = 'USRSPC';
         SpaceLib = 'QTEMP';
         SaveStart = StartPosit;
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListDs);

         SpaceName = 'USRSPC';
         SpaceLib = 'QTEMP';
         SFileLib = DependFil;
         %SubSt(SFileLib:11:10) = DependLib;
         ExSr GetFil;
         FzzZone = *Blanks;
?      //---Alimentation du tableau principal---------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Suppression des tableaux------------------------------------------//
         Tab_Term('AR');
         Tab_Term('A2');
         Clear AccPthDs;
         Clear SfValue;
         StartPosit = (SaveStart + SaveLen);
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USRSPC';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Description des champs--------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr GetFil;

       ReceiveLen = 4096;
       OverRide = '0';
       QdbRtvFd(Receiver:ReceiveLen:RfileLib:FileFmt:
               SFileLib:RecordFmt:OverRide:System:
               FmtType:ApiError);

       For Rec = 1 To %Len(Receiver);
         Tab_Set('AR':Rec:%Subst(Receiver:Rec:1));
       EndFor;

       IOff = DbFileOffs;
       For Cpt1 = 1 to NbrFormats;
         For Cpt2 = 1 To 150;
           %subst(FindSelect:Cpt2:1) = Tab_Get('AR':Cpt2 + IOff - 1);
         EndFor;
         For i = 1 to 20;
           If %Subst(Physical:i:1) < x'40';
             %Subst(Physical:i:1) = x'40';
           EndIf;
         EndFor;
         s = OffSet + 1;
         If First = *Off;
?      //---Récupération de la description de l'objet-------------------------//
           QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:SfileLib:cFile:ApiError);
           FzzZone = *Blanks;
           FzzZone = %subst(SfileLib:1:10) + ' ' + %subst(SfileLib:11:10) +
                     '   Fmt : ' + FindFormat + x'22' + OdObjTxtDes +
                      x'20' + Physical;
?      //---Alimentation du tableau principal---------------------------------//
           Cpt_I += 1;
           Tab_Set2('££WRK':Cpt_I:FzzZone);
         EndIf;
         If OffSet > *Zeros and NbrKeys > *Zeros;
           GetTxt(%Subst(RFileLib:1:10):%subst(RFileLib:11:10):FindFormat);
           For Cpt3 = 1 To NbrKeys;
             For Cpt4 = 1 To 14;
               %subst(KeyData:Cpt4:1) = Tab_Get('AR':Cpt4 + s - 1);
             EndFor;
             If AscendDes = x'C1';
               SfAsendDec = 'D';
             Else;
               SfAsendDec = 'A';
             EndIf;
             If (%subst(dependkey:1:1)) < x'40';
               Dependkey = *Blanks;
             EndIf;

             SfKeyField = DependKey;
             For Cpt4 = 1 to Tab_inf('ARYF');
               If Tab_Get('ARYF':Cpt4) = DependKey;
                SfValue = %Trim(SfValue) + ' ' + Tab_Get('ARYT':Cpt4);
               EndIf;
             EndFor;
             SfText = SfValue;
             FzzZone = AccPthDs;
?      //---Alimentation du tableau principal---------------------------------//
             Cpt_I += 1;
             Tab_Set2('££WRK':Cpt_I:FzzZone);
?      //---Create User Space-------------------------------------------------//
             SfLibrary = *Blanks;
             SfFileName = *Blanks;
             SfFormat = *Blanks;
             SfValue = *Blanks;
             S += 32;
           EndFor;
         Else;
           XFile = %Subst(RfileLib:1:10);
           XLib  = %Subst(RfileLib:11:10);
      /End-Free
     c/exec sql
     c+ Select View_Definition into :sqldefn from sysviews where
     c+ system_View_Name = :xfile and System_View_Schema = :xlib
     c/End-exec
      /Free
           If SqlCod = *Zeros;
             SqlDefn = Filtre(SqlDefn:*Omit:*Omit);
             SqlDefn = %Xlate(x'25':x'40':SqlDefn);
             SqlCpt = 1;
             Dou %Subst(SqlDefn:SqlCpt:124) = *Blanks;
               FzzZone = x'22'+ %XLate(up:lo:%Subst(sqlDefn:SqlCpt:124));
?      //---Alimentation du tableau principal---------------------------------//
               Cpt_I += 1;
               Tab_Set2('££WRK':Cpt_I:FzzZone);
               SqlCpt +=124;
             EndDo;
           EndIf;
         EndIf;
         If OffSet > *Zeros and NbrSelOmit <> *Zeros;
           ExSr SelOmt;
         EndIf;
         SfCompare = *Blanks;
         SfRule = *Blanks;
         IOff += 160;
       EndFor;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Sélections/Ommissions---------------------------------------------//
?      //---------------------------------------------------------------------//

        BegSr SelOmt;

        I1 = (OffSelOmit + 1);
        For Cpt6 = 1 To NbrSelOmit;
          For Cpt7 = 1 to 150;
           %subst(KeySelect:Cpt7:1) = Tab_Get('AR':Cpt7 + I1 - 1);
          EndFor;
          If Compare = 'AL';
            Iter;
          EndIf;
          SfCompare = Compare;
          SfRule = Rule;
          I2 = OffSetSo + 1;
          For Cpt7 = 1 To NbrSo;
            For Cpt8 = 1 To 150;
             %subst(KeySos:Cpt8:1) = Tab_Get('AR':Cpt8 + I2 - 1);
            EndFor;
            For Cpt8 = 1 To 27;
              Tab_Set('A2':Cpt8:%Subst(SelectVar:Cpt8:1));
            EndFor;
            Nl -= 19;
            If Nl > *Zeros;
              For Cpt8 = Nl To 28;
                Tab_Set('A2':Cpt8:*Blanks);
              EndFor;
            EndIf;
            For Cpt8 = 1 To 28;
              %subst(SfValue:Cpt8:1) = Tab_Get('A2':Cpt8);
            EndFor;
            SfKeyField = CompName;
            SfAsendDec = *Blanks;
            SfText = (SfRule + ' ' + SfCompare + ' ' + SfValue);
            FzzZone = AccPthDs;
?      //---Alimentation du tableau principal---------------------------------//
            Cpt_I += 1;
            Tab_Set2('££WRK':Cpt_I:FzzZone);
            I2 = POffset + 1;
          EndFor;
          I1 = (I1 + 32);
        EndFor;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Affichage et gestion du sous-fichier(Impression)------------------//
?      //---------------------------------------------------------------------//

       BegSr Aff_Sfl;

?      //---Clear du sous-fichier---------------------------------------------//
       ExSr Clr_Sfl;

?      //---Alimentation du sous-fichier si tableau est rempli----------------//
       If Tab_Inf2('££WRK') > 0;
?      //---Clear du sous-fichier---------------------------------------------//
         FzzRrn = 0;
         For i = 1 to Tab_Inf2('££WRK');
           If Tab_Get2('££WRK':i) <> ' ';
             FzzZone = Tab_Get2('££WRK':i);
             If FzzRrn < 9999;
               FzzRrn += 1;
               Write FzzSfl;
             Else;
               i = Tab_Inf2('££WRK');
             EndIf;
           EndIf;
         EndFor;
       Else;
         FzzRrn = 0;
       EndIf;

       F01Nbr = fzzRrn;
       write f01;
?      //---Affichage du Sous Fichier-----------------------------------------//
       If FzzRrn > 0;
         FzzRcd = 1;
         Exfmt FzzCtl;
         read(e) f01;
       Else;
         FzzZone = *Blanks;
         FzzRrn = 1;
         write FzzSfl;
         %subst(FzzZone:50:23) = '*** Aucun résultat ***';
         FzzRrn += 1;
         write FzzSfl;
         FzzRcd = 1;
         write FzzCtl;
         Fonc_Ind = *all'0';
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Alimentation Fichier de sortie------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Ins_Fichier;

       ZzComp = F01Obj;
       ZzType = F01Typ;
       ZzBib = F01Bib;
      /End-Free
     c/Exec sql
     c+ set :ZzTmst = Current_timestamp
     c/End-Exec
      /Free

       If Tab_Inf2('££WRK') > 0;
         For i = 1 To Tab_Inf2('££WRK');
            Fld = Tab_Get2('££WRK':i);
      /End-Free
     c/Exec Sql
     c+ INSERT INTO ZZ01OUT VALUES(:zztmst, :zzcomp, :zztype,
     c+ :zzbib, :zzfonc, :Trt, :Fld)
     c/End-Exec
      /Free
         EndFor;
       EndIf;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F13] : Impression du sous-fichier--------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Prt_Sfl;
?      //---Ouverture du fichier----------------------------------------------//
       Open Qsysprt;
       OptImpr = *Off;

?      //---Impression de l'entête--------------------------------------------//
       Ent01 = %subst(F01Info:1:33);
       %subst(Ent01:85:48) = %subst(F01Info:35:48);
       Ent02 = 'Nom du composant : ' + x'22' + F01Obj;
       Ent02 = %trim(Ent02) + '  ' + F01Des + 'Bibliothèque : ' + F01Bib;
       %subst(Ent03:41:50) = Titre;
       Ent04 = FzzDesc;
       Ent05 = *all'=';
       *In75 = *On;
       Except;
       *In75 = *Off;

  ?    //---Gestion de la sortie tableau--------------------------------------//
       For i = 1 To Tab_Inf2('££WRK');
         Det01 = Tab_Get2('££WRK':i);
  ?    //---Gestion du saut de page-------------------------------------------//
         If *InOa;
           *InOa = *Off;
  ?    //---Impression de l'entête--------------------------------------------//
           *In75 = *On;
           Except;
           *In75 = *Off;
         EndIf;
  ?    //---Impression de la ligne de détails---------------------------------//
         Lig01 = Tab_Get2('££WRK':i);
         *In76 = *on;
         Except;
         *In76 = *off;
       EndFor;

  ?    //---Fermeture du fichier imprimante-----------------------------------//
       Close Qsysprt;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Clear du sous-fichier---------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Clr_Sfl;

       FzzRrn = 0;
       SflInd = *On;
       write FzzCtl;
       SflInd = *Off;
       FzzZone = *Blanks;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F18] : WrkSplf---------------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Wrk_Splf;

       OvrCmd = 'WRKJOB OPTION(*SPLF)';
       OvrCmdLen = %len(OvrCmd);
       QcmdExc(OvrCmd:OvrCmdLen);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F04] : Recherche par Description---------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Rec_Desc;

       AutRecDesc = *On;
       DspNd = *On;
       DspPc = *On;

       Write Foot;
       If Entry_text = *Blanks;
         ExFmt F01;
       Else;
         F01Des = Entry_Text;
         Entry_Text = *Blanks;
       EndIf;

       Cpt_I = 0;

       If F01Des <> *Blanks and Not Exit and Not Retour;

?      //---Alimentation de l'entête------------------------------------------//
       F01Des = %Trim(%Xlate(' ':'%':%Trim(F01Des)));

?      //---Requete sur PGMREF------------------------------------------------//
       requete2 = 'Select whpnam, whlib, whText from '                         +
                  LibRef + '/pgmref where upper(whtext) like ''%'              +
                  %trim(%Xlate(Lo:Up:F01Des)) + '%'''                          +
                  ' Group by whpnam, whlib, whtext'                            +
                  ' Order by whlib, whpnam, whtext' ;

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     C+ Prepare S3_PgmRef From :Requete2
     c/End-Exec
     c/Exec Sql
     C+ Declare C3_PgmRef Cursor For S3_PgmRef
     c/End-Exec
     c/Exec Sql
     C+ OPEN C3_PGMREF
     c/End-Exec

     c/Exec Sql
     C+ Fetch Next From C3_PGMREF INTO :Fnam, :Lib, :Text
     c/End-Exec
      /Free

       Dow SqlCod <> EndOfFile;
         ObjChk = Fnam;
         TypChk = Otyp;
         Exsr Chk_Obj;
         Exsr Chk_Usage;
?      //---Alimentation des zones--------------------------------------------//
         FzzZone = *Blanks;
         F04Nom = Fnam;
         F04Texte = Text;
         F04Lib = Lib;
         FzzZone = LigF04;
?      //---Ecriture du Sous Fichier------------------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);

      /End-Free
     c/Exec Sql
     C+ Fetch Next From C3_PGMREF INTO :Fnam, :Lib, :Text
     c/End-exec
      /Free

       EndDo;

      /End-Free
     c/Exec Sql
     C+ CLOSE C3_PGMREF
     c/End-Exec
      /Free

       EndIf;

       AutRecDesc = *Off;
       DspNd = *Off;
       DspPc = *Off;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F06] : Lancement d'une requête-----------------------------------//
?      //---------------------------------------------------------------------//

       BegSr Run_Qry;

       OvrCmd = '?RUNQRY *N QRYFILE((' + %Trim(F01Bib) + '/' +
                 %trim(F01Obj) + '))';
       OvrCmdLen = %len(OvrCmd);
       Callp(e) QcmdExc(OvrCmd:OvrCmdLen);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F17] : Recherche de la zone d'un fichier-------------------------//
?      //---------------------------------------------------------------------//

       BegSr Rec_Zone;

       Cpt_I = 0;
?      //---Alimentation de l'entête------------------------------------------//
       FzzDesc = *Blanks;
       FzzZone = *Blanks;
       %subst(FzzDesc:1:5)    = 'Objet';
       %subst(FzzDesc:12:11)  = 'Description';
       %subst(FzzDesc:65:4)   = 'Zone';
       %subst(FzzDesc:101:10) = 'Biblio.';

?      //---Requete sur PGMREF------------------------------------------------//
       Requete1 = 'Select System_table_Name, System_Table_Schema, '            +
                  'System_Column_Name from '                                   +
                  'SysColumns Where System_Column_Name like ''%'               +
                  %Trim(F01Obj)   +
                  '%''';

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec sql
     C+ Prepare S1_RecZon From :Requete1
     c/End-Exec
     c/Exec sql
     C+ Declare C1_RecZon Cursor For S1_RecZon
     c/End-Exec
     c/Exec sql
     C+ OPEN C1_RECZON
     c/End-Exec

     c/Exec sql
     C+ Fetch Next From C1_RECZON INTO :Fnam, :Lnam, :LZone
     c/End-Exec
      /Free

       Dow SqlCod <> EndOfFile;
         ObjChk = Fnam;
         TypChk = '*FILE';
         Exsr Chk_Obj;
?      //---Alimentation des zones--------------------------------------------//
         %subst(FzzZone:1:10)   = Fnam;
         %subst(FzzZone:12:50)  = TxtDscOk;
         If Tab_Srch('OBLIB':Lnam:1) = 0;
           %Subst(FzzZone:100:1) = x'27';
           %Subst(FzzZone:111:1) = x'20';
         EndIf;
         %subst(FzzZone:101:10) = Lnam;
         %Subst(FzzZone:65:10) = LZone;

?      //---Alimentation du tableau de travail--------------------------------//
         Cpt_I += 1;
         Tab_Set2('££WRK':Cpt_I:FzzZone);

      /End-Free
     c/Exec Sql
     C+ Fetch Next From C1_RECZON INTO :Fnam, :Lnam, :LZone
     c/end-Exec
      /Free
       Enddo;
      /End-Free
     c/Exec Sql
     C+ CLOSE C1_RECZON
     c/End-Exec
      /Free

       EndSr;

?      //---------------------------------------------------------------------//
?      //---[F11] : Recherche d'une procédure dans un module------------------//
?      //---------------------------------------------------------------------//

       Begsr Rec_Procedure;

       AutRecDesc = *On;
       Cpt_I = 0;

       Write Foot;
       If Entry_text = *Blanks;
         ExFmt F01;
       Else;
         F01Des = Entry_Text;
         Entry_Text = *Blanks;
       EndIf;

       If F01Des <> *Blanks and Not Exit and Not Retour;

         For i = 1 to Tab_Inf('OBLIB');
           Rec_Mod(Tab_Get('OBLIB':i):%XLate(lo:up:F01Des));
         EndFor;

         If Tab_Inf2('Module') > 0;
           For i = 1 to Tab_Inf2('Module');

             FzzZone = Tab_Get2('Module':i) + Tab_Get2('Procedure':i);
             FzzZone = %xlate(x'00':x'40':FzzZone);
             If FzzZone <> *Blanks;

?      //---Alimentation du tableau principal---------------------------------//
               Cpt_I += 1;
               Tab_Set2('££WRK':Cpt_I:FzzZone);

             Endif;

           EndFor;

         EndIf;

         Tab_Term2('Module');
         Tab_Term2('Procedure');
       EndIf;

       AutRecDesc = *Off;
       DspNd = *Off;
       DspPc = *Off;

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Recherche des logiques d'un fichier physique----------------------//
?      //---------------------------------------------------------------------//

       Begsr Srch_Logics;
       All_File = '(''' + %trim(F01Obj) + '''';
       If F01Typ = '*FILE';
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';

?      //---Create User Space-------------------------------------------------//
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                 SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---List database relations to user space-----------------------------//
       RecordFmt = '*FIRST';
       Ignore = *Blanks;
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       SFileLib = %Subst(F01Obj:1:10) + F01Bib;

       QDblDbr(UserSpace:LstOutFmt:SFileLib:RecordFmt:
               Ignore:ApiError);

?      //---Retrieve user space general information---------------------------//
       StartPosit = 1;
       StartLen = 140;
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       Qusptrus(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
       StartPosit = 1;
       StartLen = InputSize;
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUsRtvUs(UserSpace:StartPosit:StartLen:InputDs);

?      //---Retrieve the list by walking trough the user space----------------//
       StartPosit = (ListOffset + 1);
       StartLen = EntrySize;
       SaveLen = EntrySize;
       NbrLogics = NumberList;

       For NbrL = 1 to Nbrlogics;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         SaveStart = StartPosit;
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListDs);
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         SFileLib = DependFil;
         If DependFil <> '*NONE';
           All_file = %Trim(All_File) + ',''' + %Trim(DependFil) + '''';
         EndIf;
         %SubSt(SFileLib:11:10) = DependLib;
         StartPosit = (SaveStart + SaveLen);
       EndFor;
       EndIf;

       All_File = %Trim(All_File) + ')';

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

       EndSr;

?      //---------------------------------------------------------------------//
?      //---Recherche des logiques d'un fichier physique----------------------//
?      //---------------------------------------------------------------------//

       Begsr *Pssr;
       Trt = '*ERROR';
       Routine = '*CANCL';
      /End-Free
     c/Exec sql
     c+ set :ZzTmst = Current_timestamp
     c/End-Exec

     c/Exec Sql
     c+ INSERT INTO ZZ01OUT VALUES(:zztmst, :zzcomp, :zztype,
     c+ :zzbib, :zzfonc, :Trt, :WsPsDs1)
     c/End-exec

     c/Exec Sql
     c+ INSERT INTO ZZ01OUT VALUES(:zztmst, :zzcomp, :zztype,
     c+ :zzbib, :zzfonc, :Trt, :WsPsDs2)
     c/End-exec
      /Free
       If Not Ctl_Dsp() and F01Mode = 1;
         ExFmt F07;
       EndIf;

       endsr;

      /End-Free

     ?**---Fichier Imprimante-------------------------------------------------**
     oQSysPrt   e    75                     1
     o         or    oa
     o                       Ent01              132                             Info Travail
     o          e    75                     1
     o                       Ent02              132                             Info Composant
     o          e    75                     1
     o                       Ent03              132                             Info Fonction
     o          e    75                     1
     o                       Ent04              132                             Info Colonne
     o          e    75                     1
     o                       Ent05              132                             Ligne de séparation
     o          ef   76                     1
     o                       Lig01              132
     ?**---Fichier Ecran pour résolution 80x24 (**Erreur**)-------------------**
     o££zz01d   e            Head2
     o                       hd02                80
     o          e            head3
     o                       hd03                80

     ?**----------------------------------------------------------------------**
     ?**---Détermination fichier source---------------------------------------**
     ?**----------------------------------------------------------------------**
     p RtvFd           b

     d RtvFd           Pi              n
     d   Composant                   20a
     ?**---Définition des variables-------------------------------------------**
     d FdFormat        s             10a
     d FdMember        s             10a
     d FdOverride      s              1a
     d FdSystem        s             10a
     d FdType          s             10a
     d Rtc             s               n
     d SpaceLen        s              9b 0 inz(4096)
     ?**---Description d'un fichier-------------------------------------------**
     d RtvFdDs         ds
     d FdSrc                   9      9a
     d                        10     20a                                        dummy
      /Free
       FdFormat = 'FILD0100';
       FdMember = '*FIRST';
       FdOverride = '0';
       FdSystem = '*LCL';
       FdType = '*EXT';
       QDbrtvfd(RtvFdDs:Spacelen:Composant:FdFormat:Composant:
                FdMember:Fdoverride:FdSystem:FdType:ApiError);

       If FdSrc = x'08';
         Rtc = *on;
       Else;
         Rtc = *off;
       EndIf ;

       return Rtc;

      /End-Free
     p RtvFd           e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Extraction des références--------------------------------**
     ?**----------------------------------------------------------------------**
     p Ext_Ref         b
     ?**---Prototype d'interface----------------------------------------------**
     d Ext_Ref         Pi              n
     d   RefObj                      10a   Value
     ?**---Définition des variables locales-----------------------------------**
     d Indice          s              5p 0
     d CodeRetour      s               n
      /Free
       If DspPgmRef(RefObj);

       Indice = 1;
         Dow Indice <= Tab_Inf('2');
           If Tab_Srch('1':Tab_Get('2':Indice):1) <= 0;
             CodeRetour = DspPgmRef(Tab_Get('2':Indice));
           EndIf;
?      //---Affichage Statut--------------------------------------------------//
           If Trt = '*INTERACTIVE';
             Stat001 = 'DspPgmRef en cours...';
             Stat002 = '';
             Stat003 = '';
             Stat004 = %char(Indice) + '/' + %char(Tab_Inf('1'));
             write F13;
           EndIf;
           Indice += 1;
         EndDo;
         Return *On;
       Else;
         Return *Off;
       EndIf;
      /End-Free

     p Ext_Ref         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure DSPPGMREF------------------------------------------------**
     ?**----------------------------------------------------------------------**
     p DspPgmRef       b

     d DspPgmRef       Pi              n
     d   RefObj                      10a   Value
     ?**---Déclaration des variables locales----------------------------------**
     d Requete         s             80a
     d WrkObj          s             10a
     d LibRef          s             10a
     d Nbr_Poste       s             10i 0
     d z               s             10i 0
     d zz              s             10i 0
     ?**---Déclaration des constantes-----------------------------------------**
     d EndOfFile       c                   Const(100)                           Fin de fichier SQL
      /Free
       LibRef = *Blanks;

      /End-free
     c/Exec Sql
     c+ set :LibRef = (select substr(zzvaleur, 1 , 10) from zz01pf where
     c+ zztype = 'LIBRF')
     c/End-exec
      /Free

?      //---Requete sur fichier paramètre pour bibliothèque objet-------------//
       Requete = 'select whfnam from ' + LibRef + '/pgmref where whpnam =''' +
                RefObj + ''' and whobjt = ''P''';

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     C+ Prepare S5 From :Requete
     c/End-Exec
     c/Exec Sql
     C+ Declare C5 Cursor For S5
     c/End-Exec
     c/Exec Sql
     C+ OPEN C5
     c/End-Exec

     c/Exec Sql
     C+ Fetch Next From C5 INTO :WrkObj
     c/End-Exec
      /Free

       Dow Sqlcod <> EndOfFile;
         IndRef += 1;
         Tab_Set('1'  : IndRef : RefObj );
         Tab_Set('2'  : IndRef : WrkObj );
?      //---Affichage Statut--------------------------------------------------//
         If Trt = '*INTERACTIVE';
           Stat001 = 'DspPgmRef en cours...';
           Stat002 = 'Pgm A = ' + Tab_Get('1':IndRef);
           Stat003 = 'Pgm B = ' + Tab_Get('2':IndRef);
           Stat004 = %char(IndRef) + '/' + %char(Tab_Inf('1'));
           Write F13;
         EndIf;
      /End-Free
     c/Exec Sql
     C+ Fetch Next From C5 INTO :WrkObj
     c/End-Exec
      /Free
       EndDo;
      /End-Free
     c/Exec Sql
     C+ CLOSE C5
     c/End-Exec
      /Free

       If IndRef > 0;
         Return *on;
       Else;
         Return *off;
       EndIf;

       Nbr_Poste = Tab_Inf('1');
?      //---Nettoyage des tableaux-Recursif-----------------------------------//
       For z = 1 To Nbr_Poste;
         If Tab_Get('1':z) = Tab_Get('2':z);
           Tab_Set('1':z:*blanks);
           Tab_Set('2':z:*blanks);
         EndIf;
       EndFor;

?      //---Nettoyage des tableaux-Doublons-----------------------------------//
       For z = 1 To Nbr_Poste;
         If Tab_Get('1':z)<> *Blanks;
           zz = Tab_Srch('2':Tab_Get('2':z):z+1);
           If zz > 0 and Tab_Get('1':zz) = Tab_Get('1':z);
             Tab_Set('1':zz:*blanks);
             Tab_Set('2':zz:*blanks);
             z = 0;
           EndIf;
         EndIf;
       EndFor;

?      //---Compactage des tableaux-------------------------------------------//
       For z = 1 To Nbr_Poste;
         If Tab_Get('1':z) = *Blanks;
           For zz = z To Nbr_Poste;
             Tab_Set('1':zz:Tab_Get('1':zz+1));
             Tab_Set('2':zz:Tab_Get('2':zz+1));
           EndFor;
           Nbr_Poste -= 1;
           z -= 1;
         EndIf;
       EndFor;

      /End-Free
     p DspPgmRef       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure description des champs-----------------------------------**
     ?**----------------------------------------------------------------------**
     p GetTxt          b

     d GetTxt          Pi
     d   RefObj                      10a   Value
     d   RefLib                      10a   Value
     d   RefFmt                      10a   Value Options(*Nopass)
      /Free
?      //---Create User Space-------------------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Get the list of all the fields------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       OverRide = '1';
       RefFmt = %Xlate(x'00':x'40':RefFmt);
       If RefFmt <> *Blanks;
         Type = RefFmt;
       Else;
         Type = '*FIRST';
       EndIf;
       Format  = 'FLDL0100';
       Obj = RefObj;
       Lib = RefLib;
       Quslfld(UserSpace:Format:Composant:Type:OverRide);

?      //---Get a pointer to the user space containing the list---------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       Qusptrus(UserSpace:pUserSpace);

       For i = 1 to  NumberList;
         pEntry = pUserSpace + listOffset + ((i-1)*entrySize);
         Tab_Set('ARYF':i:FieldName);
         Tab_Set('ARYT':i:FieldText);
       EndFor;
?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

      /End-Free
     p GetTxt          e

     ?**----------------------------------------------------------------------**
     ?**---Procédures Rec_Mod : Recherche de modules--------------------------**
     ?**----------------------------------------------------------------------**
     p Rec_Mod         b
     d Rec_Mod         Pi
     d  Rec_Lib                      10a   Value
     d  Rec_Proc                     50a   Value
     ?**---User Space Générique-----------------------------------------------**
     d UserSpace       ds
     d   SpaceName                   10a   inz('USERSPACE')
     d   SpaceLib                    10a   inz('QTEMP')
     ?**---List Data----------------------------------------------------------**
     d ListData        ds
     d  List_Size                     6b 0
     d  List_Module                  10a
     d                               10a                                        List_ModLib
     d                                1a                                        List_ProcType
     d                                4b 0                                      List_OffProc
     d                                4b 0                                      List_SizProc
     d                               10a                                        List_ArgProc
     d  List_ProcName         47    100a
     ?**---Déclaration des variables------------------------------------------**
     d SpaceAttr       s             10a
     d SpaceAuth       s             10a
     d SpaceReplc      s             10a
     d SpaceLen        s              9b 0 inz(4096)
     d SpaceText       s             50a
     d Format          s             10a
     d Prg             s             20a
     d Procedure       s             20a
     d StartPosit      s              9b 0
     d StartLen        s              9b 0
     d i               s                   Like(NumberList)
     d Cpt_Proc        s                   Like(NumberList)
     ?**---Entête d'un User Space---------------------------------------------**
     d GenHeadDs       ds
     d                       113    116B 0                                      Taille de l'entête
     d                       117    120i 0
     d                       121    124i 0
     d   ListOffset          125    128B 0                                      Offset des données
     d                       129    132i 0
     d                       133    136B 0                                      Nombre de données
     d                       137    140B 0                                      Taille des données
      /Free

?      //---Create the User Space---------------------------------------------//
       SpaceName  = 'USERSPACE' ;
       SpaceLib   = 'QTEMP'     ;
       SpaceAttr  = *Blanks     ;
       SpaceLen   = 1024        ;
       SpaceValue = x'00';
       SpaceAuth  = '*CHANGE'   ;
       SpaceText  = *Blanks     ;
       SpaceReplc = '*YES'      ;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Call the API------------------------------------------------------//
       Prg       = '*ALL      '+ Rec_Lib;
       SpaceName = 'USERSPACE';
       SpaceLib  = 'QTEMP';
       Format    = 'MODL0300';
       QBnlModi(UserSpace:Format:Prg:ApiError);

?      //---Retrieve Header Information---------------------------------------//
       StartPosit = 1;
       StartLen   = 1024;
       SpaceName  = 'USERSPACE';
       SpaceLib   = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

       For i=1 to NumberList;
?      //---Retrieve List Information-----------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = 80;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);

?      //---Retrieve List Information-2---------------------------------------//
         StartPosit = ListOffset + 1;
         StartLen   = List_Size;
         SpaceName  = 'USERSPACE';
         SpaceLib   = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:ListData);
         Procedure = %trim(List_ProcName);
         Procedure = %Subst(List_ProcName:1:List_Size - 46);
         If %Trim(Procedure) = %Trim(Rec_Proc);
           cpt_proc += 1;
           Tab_Set2('Module':cpt_proc:List_Module) ;
           Tab_Set2('Procedure':Cpt_proc:Procedure);
         EndIf;
         ListOffset = ListOffset + List_Size;
       EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

      /End-Free
     p Rec_Mod         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Maj_Ref : Mise à jour des références technique-----------**
     ?**----------------------------------------------------------------------**
     p Maj_Ref         b

     d Maj_Ref         Pi
     d  Libname                      10a   Value
     ?**---Définition des variables locales-----------------------------------**
     d OvrCmd          s            200a
     d OvrLen          s             15  5
     d Dat_Sys         s             13a
      /Free

?      //---Suppression des anciennes références------------------------------//
       Req_Sql = 'Delete From ' + %trim(ClPgmRef) +
                 '/Pgmref Where whlib = ''' + %Trim(LibName) + '''';
      /End-Free
     c/exec sql
     C+ Execute Immediate :Req_Sql
     c/End-Exec
      /Free
?      //---Contrôle Existence de la bibliothèque et description--------------//
       QusrObjd(Objd0400:%Size(Objd0400):COBJD0200:
               LibName + 'QSYS':'*LIB':ApiError);
       If Not(AeBytAvl > *Zero);
?      //---Mise à jour des références à jour---------------------------------//
       OvrCmd = 'DSPPGMREF PGM(' + %Trim(LibName) + '/*ALL) OUTPUT(*OUTFILE) ' +
       'OBJTYPE(*ALL) OUTFILE('+%Trim(ClPgmRef)+'/PGMREF) OUTMBR(*FIRST *ADD)';
       OvrLen = %Len(OvrCmd);
       Dat_Sys = '1' + %subst(%char(Datedujour):9:2) +
                       %subst(%char(Datedujour):4:2) +
                       %subst(%char(Datedujour):1:2) +
                       %subst(%char(Heure):1:2) +
                       %subst(%char(Heure):4:2) +
                       %subst(%char(Heure):7:2);
       Callp(e) QCmdExc(OvrCmd:OvrLen);
       If %Error;
      /End-Free
     c/exec sql
     C+ Insert Into QTEMP/PgmRef (WhLib, WhDttm) Values(:LibName, :Dat_Sys)
     c/End-Exec
      /Free
       EndIf;

?      //---Ajout des Querys--------------------------------------------------//

?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPAC';
       SpaceLib = 'QTEMP';
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

?      //---Liste des objets avec le nom ObjNam-------------------------------//
       Composant = '*ALL      ' + LibName;
       ObjectType = '*QRYDFN';
       SpaceName = 'USERSPAC';
       SpaceLib = 'QTEMP';
       FormatName = 'OBJL0100';
       QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
       StartPosit = 1;
       StartLen = 1024;
       SpaceName = 'USERSPAC';
       SpaceLib = 'QTEMP';
       QUsPtrUs(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
       StartPosit = ListOffset + 1;
       StartLen = EntrySize;
       NbrMbr = NumberList;

?      //---Lecture de tous les composants------------------------------------//
       For Nbr = 1 To NbrMbr;
         SpaceName = 'USERSPAC';
         SpaceLib = 'QTEMP';
         QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
         StartPosit = StartPosit + StartLen;
?      //---Alimentation du Sous-fichier de sélection-------------------------//
          Qry = DsListFile;
          RtvQryF(Qry:Lib:Input:OutPut:Stat);
?      //---Recherche description du Query------------------------------------//
          QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:Qry + LibName:'*FILE':
          ApiError);
          Desc = OdObjTxtDes;
          If Stat = '0';
?      //---Initialisation-fichier en sortie----------------------------------//
            Lib_Out = Output;

?      //---Si Fichier en sortie----------------------------------------------//
            If Lib_Out.File <> *Blanks;
      /End-Free
     C/Exec Sql
     C+ INSERT INTO QTEMP/PGMREF VALUES(:LibName, :Qry, :Desc, 0,
     C+ :Dat_Sys, :Lib_Out.File, :Lib_Out.Lib, ' ', 0, 2, ' ', ' ', 0,
     C+ 'F', '*FILE', ' ', 'Q', 0)
     C/End-Exec
      /Free
            EndIf;

?      //---Traitement fichiers en entrée-------------------------------------//
            For J = 0 to 31;
              Lib_In = %subst(Input:j*40+1:40);
              If Lib_In.File <> *Blanks;
      /End-Free
     C/Exec Sql
     C+ INSERT INTO QTEMP/PGMREF VALUES(:LibName, :Qry, :Desc, 0,
     C+ :Dat_Sys, :Lib_In.File, :Lib_In.Lib, ' ', 0, 1, :Lib_In.Fmt,
     C+ ' ', 0, 'F', '*FILE', ' ', 'Q', 0)
     C/End-Exec
      /Free
              EndIf;
            EndFor;
          EndIf;
        EndFor;
        EndIf;
?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPAC';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

      /End-Free
     p Maj_Ref         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure principale-----------------------------------------------**
     ?**----------------------------------------------------------------------**
     p Algo            b

     d Algo            Pi
     ?**---Définition des variables locales-----------------------------------**
     d i               s             10i 0
     d j               s             10i 0
     d IndRec          s             10i 0
     d Ind_Suivant     s             10i 0
     d Ind_Precedent   s             10i 0
     d Tab3_Libre      s               n
      /Free
       First = *On;
       Nbr_Poste = Tab_Inf('1');
       Tab_Set('3':1:*Blanks);
       Tab_Set('4':1:*Blanks);
       Tab_Set('5':1:*Blanks);
       Tab_Set('6':1:*Blanks);
?      //---Calcul des tableaux-----------------------------------------------//
       AlgoAlim();
?      //---Traitement Principal----------------------------------------------//
       i = 1;
       x = 1;
       y = 1;

?      //---Recherche du point d'entrée---------------------------------------//
       Tab_Set('7':i:Tab_Get('4':Tab_Srch('6':'0':1)));

?      //---Traçage de la carte-----------------------------------------------//
       Mat_Set(1:x:y:Tab_Get('7':i));

?      //---Affichage Statut--------------------------------------------------//
       If Trt ='*INTERACTIVE';
         Stat001 = 'Algorithme en cours...';
         Stat002 = 'Itération = ' + %char(i);
         Stat003 = 'x = ' + %char(x) + ' y = ' + %char(y);
         Stat004 = Mat_Get(1:x:y);
         Write F13;
       EndIf;

?      //---Recherche du chemin suivant---------------------------------------//
       Dow i > 0 ;
         IndRec = 0;
         Tab3_Libre = *Off;
         Dou Tab3_Libre = *On or IndRec > Nbr_Poste;
           IndRec += 1;
           Ind_Suivant = Tab_Srch('1':Tab_Get('7':i):IndRec);
           If Ind_Suivant = 0;
             Tab3_Libre = *On;
           Else;
             If Tab_Get('3':Ind_Suivant) = *Blanks;
               Tab3_Libre = *On;
             EndIf;
           EndIf;

?      //---Affichage Statut--------------------------------------------------//
           If Trt ='*INTERACTIVE';
             Stat001 = 'Algorithme en cours...';
             Stat002 = 'Itération = ' + %char(i);
             Stat003 = 'x = ' + %char(x) + ' y = ' + %char(y) ;
             Write F13;
           EndIf;

         EndDo;

?      //---Chemin trouvé-----------------------------------------------------//
         If Ind_Suivant > 0 and Tab_Get('1':Ind_Suivant) <> *Blanks;
           Tab_Set('3':Ind_Suivant:'**');
           i += 1;
           x = i;
           y += 1;
           Tab_Set('7':i:Tab_Get('2':Ind_Suivant));
?      //---Traçage de la carte-----------------------------------------------//
           Mat_Set(1:x:y:Tab_Get('7':i));

?      //---Affichage Statut--------------------------------------------------//
           If Trt ='*INTERACTIVE';
             Stat001 = 'Algorithme en cours...';
             Stat002 = 'Itération = ' + %char(i);
             Stat003 = 'x = ' + %char(x) + ' y = ' + %char(y);
             Stat004 = Mat_Get(1:x:y);
             Write F13;
           EndIf;

?      //---Recalcul----------------------------------------------------------//
           AlgoAlim();

?      //---Recherche du chemin suivant---------------------------------------//
           If Tab_Srch('4':Tab_Get('2':Ind_Suivant):1) < 1;
             i -= 1;
             x -= 1;
           Else;
             If Tab_Get('5':Tab_Srch('4':Tab_Get('2':Ind_Suivant):1)) = '0';
               i -= 1;
               x -= 1;
             EndIf;
           EndIf;
         Else;
?      //---Chemin non trouvé-------------------------------------------------//
           j = i ;
?      //---Recherche du chemin précédent-------------------------------------//
           Dou Tab_Get('7':j) = *Blanks;
             Dou Ind_Precedent = 0;
               Ind_Precedent = Tab_Srch('1':Tab_Get('7':j):Ind_Precedent + 1);
               If Ind_Precedent > 0;
                 Tab_Set('3':Ind_Precedent:*Blanks);
               EndIf;

?      //---Affichage Statut--------------------------------------------------//
               If Trt = '*INTERACTIVE';
                 Stat001 = 'Algorithme en cours...';
                 Stat002 = 'Itération = ' + %char(i);
                 Stat003 = 'x = ' + %char(x) + ' y = ' + %char(y);
                 Write F13;
               EndIf;

             EndDo;
             Tab_Set('7':j:*Blanks);
             j += 1;
           EndDo;
           i -= 1;
           AlgoAlim();
         EndIf;

       EndDo;
       AlgoDessin();

      /End-Free
     p Algo            e
     ?**----------------------------------------------------------------------**
     ?**---Alimentation des tableaux------------------------------------------**
     ?**----------------------------------------------------------------------**
     p AlgoAlim        b

     d AlgoAlim        Pi

     ?**---Définition des variables-------------------------------------------**
     d z               s             10i 0
     d zz              s             10i 0
     d Poste           s             10i 0
      /Free

       Poste = 0;
       If First = *On;
?      //---Affichage Statut--------------------------------------------------//
         If Trt ='*INTERACTIVE';
           Stat001 = 'Algorithme en cours...';
           Stat002 = 'Nettoyage des Tab. Récursif';
           Stat003 = 'z = ' + %char(z) + ' sur ' + %Char(Nbr_Poste);
           Stat004 = *Blanks;
           Write F13;
         EndIf;
?      //---Nettoyage des tableaux-Recursif-----------------------------------//
         For z = 1 To Nbr_Poste;
           If Tab_Get('1':z) = Tab_Get('2':z);
             Tab_Set('1':z:*blanks);
             Tab_Set('2':z:*blanks);
           EndIf;
         EndFor;

?      //---Affichage Statut--------------------------------------------------//
         If Trt ='*INTERACTIVE';
           Stat001 = 'Algorithme en cours...';
           Stat002 = 'Nettoyage des Tab. doublons';
           Stat003 = *Blanks;
           Stat004 = *Blanks;
           Write F13;
         EndIf;
?      //---Nettoyage des tableaux-Doublons-----------------------------------//
         For z = 1 To Nbr_Poste;
           If Tab_Get('1':z)<> *Blanks;
             zz = Tab_Srch('2':Tab_Get('2':z):z+1);
             If zz > 0 and Tab_Get('1':zz) = Tab_Get('1':z);
               Tab_Set('1':zz:*blanks);
               Tab_Set('2':zz:*blanks);
               z = 0;
             EndIf;
           EndIf;
         EndFor;

?      //---Affichage Statut--------------------------------------------------//
         If Trt ='*INTERACTIVE';
           Stat001 = 'Algorithme en cours...';
           Stat002 = 'Compactage des Tableaux';
           Stat003 = 'z = ' + %char(z) + ' sur ' + %Char(Nbr_Poste);
           Stat004 = *Blanks;
           Write F13;
         EndIf;
?      //---Compactage des tableaux-------------------------------------------//
         For z = 1 To Nbr_Poste;
           If Tab_Get('1':z) = *Blanks;
             For zz = z To Nbr_Poste;
               Tab_Set('1':zz:Tab_Get('1':zz+1));
               Tab_Set('2':zz:Tab_Get('2':zz+1));
             EndFor;
             Nbr_Poste -= 1;
             z -= 1;
           EndIf;
         EndFor;
         First = *Off;
       EndIf;

?      //---Affichage Statut--------------------------------------------------//
       If Trt ='*INTERACTIVE';
         Stat001 = 'Algorithme en cours...';
         Stat002 = 'Calcul des Tableaux';
         Stat003 = 'Nbre de Poste : ' + %Char(Nbr_Poste);
         Stat004 = *Blanks;
         Write F13;
       EndIf;

?      //---Calcul des compteurs-Tableau (1)----------------------------------//
       For z = 1 To Nbr_Poste;
         If Tab_Get('3':z)= *Blanks;

           If Tab_Srch('4':Tab_Get('1':z):1) > 0;
             Tab_Incr('5':Tab_Srch('4':Tab_Get('1':z):1));
           Else;
             Poste += 1;
             Tab_Set('4':Poste:Tab_Get('1':z));
             Tab_Set('5':Poste:'1');
             Tab_Set('6':Poste:'0');
           EndIf;
?      //---Calcul des compteurs-Tableau (2)----------------------------------//
           If Tab_Srch('4':Tab_Get('2':z):1) > 0;
             Tab_Incr('6':Tab_Srch('4':Tab_Get('2':z):1));
           Else;
             Poste += 1;
             Tab_Set('4':Poste:Tab_Get('2':z));
             Tab_Set('5':Poste:'0');
             Tab_Set('6':Poste:'1');
           EndIf;

         EndIf;
       EndFor;

      /End-Free
     p AlgoAlim        e

     ?**----------------------------------------------------------------------**
     ?**---Dessin de la carte ------------------------------------------------**
     ?**----------------------------------------------------------------------**
     p AlgoDessin      b

     d AlgoDessin      Pi

     ?**---Définition des variables locales-----------------------------------**
     d i               s             10i 0
     d j               s             10i 0
     d Infx            s             10i 0
     d Infy            s             10i 0
     ?**---Définition des constantes locales----------------------------------**
     d w0Coin          c                   Const('|...........................')
     d w0Trait         c                   Const('|')
      /Free

       Infy = Mat_Infy(1);
       Infx = Mat_Infx(1);

B01    For j = 1 To Infy;
B02      For i = 1 To Infx;
B03        If Mat_Get(1:i+1:j) <> *Blanks;

?      //---Affichage Statut--------------------------------------------------//
B04         If Trt = '*INTERACTIVE';
              Stat001 = 'Tracé des embranchements';
              Stat002 = 'xmax = ' + %char(Infx) + ' ymax = ' + %char(Infy);
              Stat003 = 'x =    ' + %char(i) +    '  y =   ' + %char(j);
              Write F13;
E04         EndIf;

             Mat_Set(1:i:j:%subst(w0Coin:1:Mat_LenCol(1:i)-1)+x'22');
E03        EndIf;
E02      EndFor;
E01    EndFor;

B01    For j = Infy-1 downto 1;
B02      For i = 1 To Infx;
B03        If Mat_Get(1:i:j) = *Blanks;
B04          If %subst(Mat_Get(1:i:j+1):1:1) =  w0Trait;

?      //---Affichage Statut--------------------------------------------------//
B05            If Trt = '*INTERACTIVE';
                 Stat001 = 'Tracé des liens';
                 Stat002 = 'xmax = ' + %char(Infx) + ' ymax = ' + %char(Infy);
                 Stat003 = 'x =    ' + %char(i) +    '  y =   ' + %char(j);
                 Write F13;
E05            EndIf;

               Mat_Set(1:i:j:w0Trait);
E04          EndIf;
E03        EndIf;
E02      EndFor;
E01    EndFor;

      /End-Free
     p AlgoDessin      e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Src_Analyse : Analyse du source--------------------------**
     ?**----------------------------------------------------------------------**
     p Src_Analyse     b                                                        Procédure Analyse
     ?**---Prototype d'interface----------------------------------------------**
     d Src_Analyse     Pi              n                                        Procédure Analyse
     d   LibA                        10a                                        Bibliothèque Source
     d   Src                         10a                                        Fichier Source
     d   Mbr                         10a                                        Membre Source
     d   ModeDet                      1a   Value
     ?**---Définition des variables locales-----------------------------------**
     d CodeRetour      s               n
      /Free
?      //---Source en cours---------------------------------------------------//
       Niveau = 1;
       SrcLib = LibA;
       SrcFil = Src;
       SrcMbr = Mbr;
       SrcRrn = 1;
       Cpt = 1;
       NbrProto = 0;
       Clr_Car();
       Proc_Encours = 'Main';
?      //---Sélection du source-----------------------------------------------//
B01    If Ovr_SrcFile(DSSource);
         Tab_Set('ProtoTab':1:*Blanks);
         SrcMax = NbrEnregs;
         Tab_Set('SrcCpy':Niveau:DSSource);
?      //---Lecture du source-------------------------------------------------//
         read file RcdSrc;

B02      Dow not %Eof;

           RcdSrc.SrcDta = %Xlate(lo:up:RcdSRc.Srcdta);
?      //---Recherche des caractères spéciaux---------------------------------//
           Get_Caractere(RcdSrc.Srcdta);
?      //---Recherche des blocs-----------------------------------------------//
B03        If Car_Comment = 0 and %trim(RcdSrc.SrcDta) <> *Blanks;
             Get_Bloc(RcdSrc.Srcdta);
E03        EndIf;
?      //---Choix du source à lire--------------------------------------------//
B03        If Car_Copy > 0 and Car_Comment = 0  and ModeDet = '1';
             Get_OvrFile(RcdSrc.SrcDta);
E03        EndIf;
?      //---Affichage Statut--------------------------------------------------//
B03        If Trt = '*INTERACTIVE';
             Stat001 = 'Lecture du source';
             Stat002 = %trim(RcdSrc.SrcDta);
             Stat003 = DsSource;
             Stat004 = 'Niveau = ' + %Char(Niveau) + '  Séquence = ' +
                      %Char(RcdSrc.SrcSeq);
             write F13;
E03        EndIf;
?      //---Reset des indicateurs---------------------------------------------//
           Clr_Car();

           read file RcdSrc;
?      //---Fin de source ou fin de /copy ?-----------------------------------//
B03        Dow Niveau > 1 and %Eof;
?      //---Affichage Statut--------------------------------------------------//
B04          If Trt ='*INTERACTIVE';
               Stat001 = 'Lecture du source';
               Stat002 = RcdSrc.SrcDta;
               Stat003 = DsSource;
               Stat004 = 'Niveau = ' + %Char(Niveau) + '  Séquence = ' +
                        %Char(RcdSrc.SrcSeq);
               write F13;
E04          EndIf;

B04          If %Open(File);
               Close File;
E04          EndIf;

             Niveau -= 1;
             DsSource = Tab_Get ('SrcCpy':Niveau);
             SrcRrn += 1;
B04          If SrcRrn <= SrcMax;
?      //---Sélection du source-----------------------------------------------//
               CodeRetour = Ovr_SrcFile(DSSource);
               Read File RcdSRc ;
E04          EndIf;
E03        EndDo;
E02      EndDo;

         Close File;
         Tab_Term('ProtoTab');
         Return *On;
X01    Else;
         Return *Off;
E01    EndIf;

      /End-Free
     p Src_Analyse     e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Get_Caractere : Recherche des Caractères spéciaux--------**
     ?**----------------------------------------------------------------------**
     p Get_Caractere   b                                                        Recherche caractère
     ?**---Prototype d'interface----------------------------------------------**
     d Get_Caractere   Pi                                                       Recherche caractère
     d   SrcDta                      80a                                        Ligne de Code
     ?**---Définitions des constantes-----------------------------------------**
     d Cst_Copy        c                   Const('/COPY')
     d Cst_Slash       c                   Const('/')
     d Cst_PtVirg      c                   Const(';')
     d Cst_FreeBegin   c                   Const('/FREE')
     d Cst_FreeEnd     c                   Const('/END-FREE')
     d Cst_comment     c                   Const('//')
     d Cst_Carte_C     c                   Const('C')
     d Cst_Carte_D     c                   Const('D')
     d Cst_Carte_P     c                   Const('P')
     d Cst_Carte_F     c                   Const('F')
     d Cst_SsRoutine   c                   Const('BEGSR')
     d Cst_FiRoutine   c                   Const('ENDSR')
     d Cst_ExRoutine   c                   Const('EXSR')
     d Cst_Star        c                   Const('*')
     d Cst_Proto       c                   Const('PR')
     d Cst_Libl        c                   Const('*LIBL/')
     d Cst_Cas         c                   Const('CASEQ')
      /Free
?      //---Recherche des mots spécifiques------------------------------------//
       Car_PtVirg    = %Scan( Cst_PtVirg     : SrcDta );
       Car_FreeBegin = %Scan( Cst_FreeBegin  : SrcDta );
       Car_FreeEnd   = %Scan( Cst_FreeEnd    : SrcDta );
       Car_Comment   = %Scan( Cst_Comment    : SrcDta );
       Car_Ssroutine = %Scan( Cst_SsRoutine  : SrcDta );
       Car_Firoutine = %Scan( Cst_FiRoutine  : SrcDta );
       Car_ExRoutine = %Scan( Cst_ExRoutine  : SrcDta );
       Car_Libl      = %Scan( Cst_Libl       : SrcDta );
       Car_Cas       = %Scan( Cst_Cas        : SrcDta );
?      //---Source en Free----------------------------------------------------//
B01    If Car_FreeBegin > 0;
         Car_FreeEnd = *Zeros;
         Car_Free = *On;
E01    EndIf;

B01    If Car_FreeEnd > 0;
         Car_FreeBegin = *Zeros;
         Car_Free = *Off;
E01    EndIf;
?      //---Ligne de commentaire----------------------------------------------//
B01    If %subst(SrcDta:7:1) = Cst_Star and Not(Car_Free);
         Car_Comment = 1;
E01    EndIf;
?      //---Ligne de définition de prototype----------------------------------//
B01    If %subst(SrcDta:24:2) = Cst_Proto and Car_Comment = 0;
         Car_Proto = *On;
E01    EndIf;
?      //---Ligne de /Copy----------------------------------------------------//
B01    If %subst(SrcDta:7:5) = Cst_Copy;
         Car_Copy = 7;
         Car_Slash = %scan(Cst_Slash:SrcDta:Car_Copy + 1);
E01    EndIf;
?      //---Type de ligne de code---------------------------------------------//
B01    select;
X01      When %subst(SrcDta:6:1) = Cst_Carte_C;
           Car_Carte_C = *on;
X01      When %subst(SrcDta:6:1) = Cst_Carte_D;
           Car_Carte_D = *on;
X01      When %subst(SrcDta:6:1) = Cst_Carte_P;
           Car_Carte_P = *on;
X01      When %subst(SrcDta:6:1) = Cst_Carte_F;
           Car_Carte_F = *on;
X01      Other;
           Car_Carte_C = *off;
           Car_Carte_D = *off;
           Car_Carte_P = *off;
E01    EndSl;
      /End-Free
     p Get_Caractere   e                                                        Recherche caractère

     ?**----------------------------------------------------------------------**
     ?**---Procédure Get_Bloc : Recherche des blocs de programme--------------**
     ?**----------------------------------------------------------------------**
     p Get_Bloc        b                                                        Recherche des blocs
     ?**---Prototype d'interface----------------------------------------------**
     d Get_Bloc        Pi                                                       Recherche des Blocs
     d   SrcDta                      80a                                        Ligne de Code
     ?**---Déclaration des variables locales----------------------------------**
     d i               s              5  0
     d PosRoutine      s              5  0
     d LongRoutine     s              5  0
     d Routine         s             20a
      /Free
?      //---Liste des Prototypes----------------------------------------------//
B01    If Car_Carte_D and Car_Proto;
         Proto_Name = %Trim(%Subst(SrcDta:7:15));
B02      If Tab_Srch('ProtoTab':Proto_Name: 1) = 0 and Proto_Name <> *Blanks;
           NbrProto += 1;
           Tab_Set('ProtoTab':NbrProto:Proto_Name);
E02      EndIf;
E01    EndIf;

?      //---Appel de procédure------------------------------------------------//
B01    If NbrProto > *Zero;
B02      If Not(Car_Carte_D) and Not(Car_Carte_P) and Not(Car_Carte_F);
B03        For i = 1 to NbrProto;
B04          If %Scan(%Trim(Tab_Get('ProtoTab':i)):SrcDta) > 0;
               Tab_Set('1':Cpt:Proc_Encours);
               Tab_Set('2':Cpt:%Trim(Tab_Get('ProtoTab':i)));
               Cpt += 1;
E04          EndIf;
E03        EndFor;
E02      EndIf;
E01    EndIf;

?      //---Appel de sous-routine---------------------------------------------//
B01    If Car_ExRoutine > 0;
B02      If Car_Free;
           PosRoutine = Car_ExRoutine + 4;
           LongRoutine = Car_PtVirg - PosRoutine;
B03        If LongRoutine > 0;
             Routine = %trim(%Subst(SrcDta:PosRoutine:LongRoutine));
             Tab_Set('1':Cpt:Proc_Encours);
             Tab_Set('2':Cpt:Routine);
             Cpt += 1;
E03        EndIf;
X02      Else;
           Routine = %Trim(%Subst(SrcDta:Car_Exroutine + 4:20));
           Tab_Set('1':Cpt:Proc_Encours);
           Tab_Set('2':Cpt:Routine);
           Cpt += 1;
E02      EndIf;
E01    EndIf;

?      //---Appel de Caseq et Cabeq-------------------------------------------//
B01    If Not Car_Free;
B02      If Car_Cas > 0 and Not(Car_Carte_D);
           PosRoutine = 50;
           LongRoutine = 14;
           Routine = %trim(%Subst(SrcDta:PosRoutine:LongRoutine));
           Tab_Set('1':Cpt:Proc_Encours);
           Tab_Set('2':Cpt:Routine);
           Cpt += 1;
E02      EndIf;
E01    EndIf;
?      //---Changement de sous-routine----------------------------------------//
B01    If Car_SsRoutine > 0 ;
B02      If Car_Free;
           PosRoutine = Car_SsRoutine + 5;
           LongRoutine = Car_PtVirg - PosRoutine;
B03        If LongRoutine > 0;
             Routine = %trim(%Subst(SrcDta:PosRoutine:LongRoutine));
             Proc_Encours = Routine;
E03        EndIf;
X02      Else;
           Routine = %Trim(%subst(SrcDta:12:Car_SsRoutine - 12));
           Proc_Encours = Routine;
E02      EndIf;
E01    EndIf;
?      //---Fin de sous-routine-----------------------------------------------//
B01    If Car_FiRoutine > 0
          or (Car_Carte_P and %Subst(SrcDta:8:1) = 'E');
         Proc_Encours = 'Main';
E01    EndIf;

?      //---Changement de procédure-------------------------------------------//
B01    If Car_Carte_P and %Subst(SrcDta:8:1) = 'B';
         Proc_Encours = %Trim(%Subst(SrcDta:7:15));
E01    EndIf;

      /End-Free
     p Get_Bloc        e                                                        Recherche des Blocs

     ?**----------------------------------------------------------------------**
     ?**---Procédure Clr_Car : Reset des indicateurs--------------------------**
     ?**----------------------------------------------------------------------**
     p Clr_Car         b                                                        Reset des indicateur
     ?**---Prototype d'interface----------------------------------------------**
     d Clr_Car         Pi                                                       Reset des indicateur
      /Free

       Car_Copy        = 0   ;
       Car_PtVirg      = 0   ;
       Car_FreeBegin   = 0   ;
       Car_FreeEnd     = 0   ;
       Car_Comment     = 0   ;
       Car_FiRoutine   = 0   ;
       Car_SsRoutine   = 0   ;
       Car_Proto       = *off;
       Car_Carte_C     = *off;
       Car_Carte_D     = *off;
       Car_Carte_P     = *off;
       Car_Carte_F     = *off;

      /End-Free
     p Clr_Car         e                                                        Reset des indicateur

     ?**----------------------------------------------------------------------**
     ?**---Procédure Get_OvrFile : Override des copy source-------------------**
     ?**----------------------------------------------------------------------**
     p Get_OvrFile     b                                                        Override des copy so
     ?**---Prototype d'interface----------------------------------------------**
     d Get_OvrFile     Pi                                                       Override des copy so
     d   SrcDta                      80a
     ?**---Définition des variables locales-----------------------------------**
     d Car_Comma       s              3u 0
     d CodeRetour      s               n
     ?**---Définition des constantes locales----------------------------------**
     d Cst_Comma       c                   Const(',')
      /Free

       SrcRrn = Rrn;
       SrcMax = NbrEnregs;
       Tab_Set('SrcCpy':Niveau:DSSource);
?      //---Détermination du fichier source et du membre----------------------//
B01    If Car_Libl = 0;
B02      If Car_Slash > 0;
           Car_comma = %Scan(Cst_Comma:Srcdta:Car_Slash);
           SrcFil=%Trim(%Subst(SrcDta:Car_Slash+ 1: Car_Comma - Car_Slash- 1));
           SrcMbr  = %Trim(%Subst(SrcDta:Car_Comma + 1:10));
           SrcLib=%Trim(%Subst(SrcDta:Car_Copy + 5: Car_Slash - Car_Copy - 5));
X02      Else;
           Car_Comma = %Scan(Cst_Comma:Srcdta:Car_Copy + 1);
           SrcFil=%Trim(%Subst(SrcDta:Car_Copy + 5: Car_Comma - Car_Copy - 5));
           SrcMbr = %Trim(%Subst(SrcDta:Car_Comma + 1:10));
E02      EndIf;
X01    Else;
         Car_Comma = %Scan(Cst_Comma:Srcdta:Car_Libl + 1);
         SrcFil = %Trim(%Subst(SrcDta:Car_Libl + 6: Car_Comma - Car_Libl - 6));
         SrcMbr  = %Trim(%Subst(SrcDta:Car_Comma + 1:10));
E01    EndIf;
?      //---Affichage Statut--------------------------------------------------//
B01    If Trt = '*INTERACTIVE';
         Stat001 = 'Recherche /copy';
         Stat002 = 'Fichier Source : ' + SrcFil;
         Stat003 = 'Membre Source : '  + SrcMbr;
         Stat004 = *Blanks;
         write F13;
E01    EndIf;

?      //---Détermination de la bibliothèque----------------------------------//
B01    If Car_Slash = *Zero;
         SrcLib = Get_SrcLib(SrcFil:SrcMbr);
E01    EndIf;

B01    If SrcLib <> *Blanks;
?      //---Sauvegarde de la position dans le source--------------------------//
         SrcRrn = 1;
         CodeRetour = Ovr_SrcFile(DSSource);
B02      If CodeRetour;
           Niveau += 1;
           SrcRrn = 1;
           SrcMax = NbrEnregs;
           Tab_Set('SrcCpy':Niveau:DSSource);
X02      Else;
           DSSource = Tab_Get('SrcCpy':Niveau);
           CodeRetour = Ovr_SrcFile(DSSource);
           Read file RcdSrc;
E02      EndIf;
X01    Else;
         DSSource = Tab_Get('SrcCpy':Niveau);
E01    EndIf;

      /End-Free
     p Get_OvrFile     e                                                        Override des copy so

     ?**----------------------------------------------------------------------**
     ?**---Procédure Ovr_SrcFile : Override des sources-----------------------**
     ?**----------------------------------------------------------------------**
     p Ovr_SrcFile     b                                                        Override des sources
     ?**---Prototype d'interface----------------------------------------------**
     d Ovr_SrcFile     Pi              n                                        Override des sources
     d   Source                            LikeDs(DSSource)
      /Free
B01    If %open(file);
         Close File;
E01    EndIf;
B01    If %Trim(SrcLib) <> *Blanks;
         SrclibW = %Trim(SrcLib) + '/';
X01    Else;
         SrclibW = *Blanks;
E01    EndIf;
?      //---Sélection du source-----------------------------------------------//
       OvrCmd = 'OVRDBF FILE(FILE) TOFILE('+%trim(SrclibW) +%Trim(SrcFil) +
                ') MBR(' + %trim(SrcMbr) + ') POSITION(*RRN ' + %Char(SrcRrn) +
                ')';
       OvrCmdLen = %len(OvrCmd);
       QcmdExc(OvrCmd:OvrCmdLen);
?      //---Lecture du source-------------------------------------------------//
       Open(e) File;
B01    If %Error;
         Return *Off;
X01    Else;
         Return *On;
E01    EndIf;

      /End-Free
     p Ovr_SrcFile     e                                                        Override des sources

     ?**----------------------------------------------------------------------**
     ?**---Procédure Get_SrcLib : Recherche de la bibliothèque----------------**
     ?**----------------------------------------------------------------------**
     p Get_SrcLib      b                                                        Recherche Bibliothèq
     ?**---Prototype d'interface----------------------------------------------**
     d Get_SrcLib      Pi            10a                                        Biblitohèque Source
     d   SrcFil                      10a                                        Fichier Source
     d   SrcMbr                      10a                                        Membre Source
     d StartPosit      s              9b 0                                      Position dans le Use
     d StartLen        s              9b 0                                      Longueur dans le Use
     d i               s              5  0 inz(1)                               Compteur
     d j               s              5  0 inz                                  Compteur
     d k               s              5  0 inz                                  Compteur
     d NbrMbr          s              5  0
     d FormatName      s              8a   inz('OBJL0100')                      Format Liste d'objet
     d SpaceAttr       s             10a   inz                                  Attribut du User Spa
     d ObjectType      s             10a   inz('*ALL')                          Type d'objet
     d SpaceAuth       s             10a   inz('*USE')                          Autorisation User Sp
     d OverRide        s              1a
     d SpaceReplc      s             10a   inz('*YES')                          Remplacement du User
     d SpaceText       s             50a   inz('User Space Temporaire')         Libellé User Space
     d SpaceLen        s              9b 0 inz(MaxTab)                          Longueur du User Spa
     ?**---User Space Générique-----------------------------------------------**
     d UserSpace       ds
     d   SpaceName                   10a   inz('USERSPACE')
     d   SpaceLib                    10a   inz('QTEMP')
     ?**---Liste des Objets---------------------------------------------------**
     d DsList          ds                                                       Liste d'objet
     d  DsListFile                   10                                         Objet
     d  DsListLib                    10                                         Bibliothèque
     d                               10                                         Type d'objet  DsList
     ?**---Description d'un scan----------------------------------------------**
     d ScanDsRes       ds
     d  SourcePgm              1     10
     d                        11     20                                         SourceTyp
     d                        47     95                                         SourceTxt
      /Free

       SrcLib = *Blanks;

?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       SpaceLen = MaxTab;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

       j = 0;
?      //---------------------------------------------------------------------//
B01    For i = 1 To Tab_Inf('SCLIB');

         FormatName = 'OBJL0100';
         Obj = '*ALL';
         Lib = Tab_Get('SCLIB':i);
         ObjectType = '*FILE';
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
         StartPosit = 1;
         StartLen = 1024;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;
         NbrMbr = NumberList;

B02      For k = 1 to NbrMbr;
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           QUsPtrUs(UserSpace:pUserSpace);
           QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
           StartPosit = StartPosit + StartLen;
?      //---Alimentation du tableau-------------------------------------------//
           j += 1;
           Tab_Set('MBRFIL':j:DsListFile);
           Tab_Set('MBRLIB':j:DsListLib);
E02      EndFor;

E01    EndFor;

       k = 1;
B01    For i = 1 to Tab_Inf('MBRFIL');

?      //---Ne faire la recherche que sur des PF------------------------------//
         Obj = Tab_Get('MBRFIL':i);
         Lib = Tab_Get('MBRLIB':i);
        QusrObjd(ObjD0400:%Size(ObjD0400):CObjD0400:Composant:'*FILE':ApiError);
?      //---Ne prendre que les fichiers source--------------------------------//
B02      If OdObjExtAtt = 'PF' and RtvFd(Composant);
?      //---Liste des membres d'un fichier source-----------------------------//
           FormatName = 'MBRL0200';
           ObjectType = '*ALL';
           OverRide = '1';
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           QUslMbr(UserSpace:FormatName:Composant:ObjectType:OverRide);

?      //---Retrieve user space General information---------------------------//
           StartPosit = 1;
           StartLen = 1024;
           SpaceName = 'USERSPACE';
           SpaceLib = 'QTEMP';
           Qusptrus(UserSpace:pUserSpace);
           QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
           StartPosit = ListOffset + 1;
           StartLen = EntrySize;
           NbrMbr = NumberList;

?      //---Lecture de tous les Membres d'un fichier source-------------------//
B03        For j = 1 To NbrMbr;
             SpaceName = 'USERSPACE';
             SpaceLib = 'QTEMP';
             Qusptrus(UserSpace:pUserSpace);
             QUsRtvUs(UserSpace:StartPosit:StartLen:ScanDsRes);
             StartPosit = StartPosit + StartLen;
?      //---Source dans la bonne bibliothèque ?-------------------------------//
B04          If SrcFil = Obj and SrcMbr = SourcePgm;
               SrcLib = Lib;
               Return SrcLib ;
E04          EndIf;

E03        EndFor;

E02      EndIf;

E01    EndFor;

?      //---Suppression du User Space-----------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QusDltUs(UserSpace:ApiError);

       Return SrcLib;

      /End-Free
     p Get_SrcLib      e                                                        Recherche Bibliothèq

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Création et initialisation du tableau------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Init        b
     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Init        Pi
     d Tab_Name                      10a   Const
     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s             10i 0
      /Free
?      //---Initialisation du Heap Id (Valeur donnée par l'API)---------------//
       HeapId = 0;
?      //---Nombre d'éléments par défaut--------------------------------------//
       HeapElems = InitAlloc;
?      //---Détermination de la taille initiale-------------------------------//
       HeapSize = HeapElems * %Size(DynArr);
?      //---Création du Heap--------------------------------------------------//
       CeeCrHp(HeapId:HeapSize:0:0:*Omit);
?      //---Allocation du Heap------------------------------------------------//
       CeeGtSt(HeapId:HeapSize:DynArrà:*Omit);
?      //---Initialisation du tableau-----------------------------------------//
B01    For Cpt1 = 1 to HeapElems;
         Clear DynArr(Cpt1);
E01    EndFor;
?      //---Sauvegarde Adresse du tableau-------------------------------------//
       DynArrDsà(HeapId) = DynArrà;
?      //---Sauvegarde Informations sur le tableau----------------------------//
       HeapTab(HeapId) = HeapDef;
?      //---Sauvegarde Heap Id le plus élevé----------------------------------//
       HeapMax = HeapId;
?      //---Sauvegarde du nom du tableau suivant le Heap Id-------------------//
       NameTab(HeapId)= Tab_Name;
      /End-Free
     p Tab_Init        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Suppression du tableau---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Term        b
     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Term        Pi
     d   Tab_Name                    10a   Const options(*omit)
     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s             10i 0
      /Free
?      //---Suppression d'un tableau------------------------------------------//
B01    If Tab_Name <> *Blanks;
?      //---Recherche du Heap Id du tableau-----------------------------------//
         Cpt1 = %LookUp(Tab_Name:NameTab);
?      //---S'il existe-------------------------------------------------------//
B02      If Cpt1 > 0;
?      //---Suppression en mémoire--------------------------------------------//
           CeeDsHp(Cpt1:*Omit);
?      //---Clear des tableaux des informations de tableau--------------------//
           Clear DynArrDsà(Cpt1);
           Clear HeapTab(Cpt1);
           Clear NameTab(Cpt1);
?      //---Le Heap Id maximum est modifié s'il s'agit de sa suppression------//
B03        If Cpt1 = HeapMax;
             HeapMax -= 1;
E03        EndIf;
E02      EndIf;
X01    Else;
?      //---Suppression de tous les tableaux----------------------------------//
B02      For Cpt1 = 1 To HeapMax;
?      //---Suppression en mémoire--------------------------------------------//
           CeeDsHp(Cpt1:*Omit);
?      //---Clear des tableaux des informations de tableau--------------------//
           Clear DynArrDsà(Cpt1);
           Clear HeapTab(Cpt1);
           Clear NameTab(Cpt1);
E02      EndFor;
E01    EndIf;
      /End-Free
     p Tab_Term        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Alimentation du tableau--------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Set         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Set         Pi
     d   Tab_Name                    10a   Const
     d   Index                       10i 0 Value
     d   Element                           Value Like(£Dyna)
     ?**---Définition des variables locales-----------------------------------**
     d OldElems        s             10i 0
     d Cpt1            s             20i 0
      /Free
       HeapId = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau-------------------------------------//
B01    If HeapId > *Zero;
?      //---Récupération des informations du tableau--------------------------//
         HeapDef = HeapTab(HeapId);
?      //---Récupération de l'adresse mémoire du tableau----------------------//
         DynArrà = DynArrDsà(HeapId);
E01    EndIf;
?      //---Sinon création en mémoire du tableau------------------------------//
B01    If DynArrà = *Null or HeapID = *Zero;
         Tab_Init(Tab_Name);
         HeapDef = HeapTab(HeapId);
         DynArrà = DynArrDsà(HeapId);
E01    EndIf;
?      //---Faut-il agrandir le tableau ?-------------------------------------//
B01    If Index > HeapElems;
         OldElems = HeapElems;
?      //---Calcul de la nouvelle taille du tableau---------------------------//
B02      If Index > HeapElems + SubsAlloc;
           HeapElems = Index;
X02      Else;
           HeapElems += SubsAlloc;
E02      EndIf;
?      //---Reallocation de la taille-----------------------------------------//
         HeapSize = HeapElems * %Size(DynArr);
         DynArrà = %realloc(DynArrà:HeapSize);
?      //---Initialisation des nouveaux éléments------------------------------//
B02      For Cpt1 = OldElems + 1 to HeapElems;
           Clear DynArr(Cpt1);
E02      EndFor;
?      //---Sauvegarde des informations du tableau----------------------------//
         DynArrDsà(HeapId) = DynArrà;
         HeapTab(HeapId)   = HeapDef;
E01    EndIf;
?      //---Alimentation du tableau-------------------------------------------//
       DynArr(Index) = Element;
      /End-Free
     p Tab_Set         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Incrément d'un tableau---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Incr        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Incr        Pi
     d   Tab_Name                    10a   Const
     d   Index                       10i 0 Const
      /Free
       HeapId = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau-------------------------------------//
B01    If HeapId <> 0 and Index <> 0;
?      //---Récupération des informations du tableau--------------------------//
         HeapDef = HeapTab(HeapId);
?      //---Récupération de l'adresse mémoire du tableau----------------------//
         DynArrà = DynArrDsà(HeapId);
?      //---Alimentation du tableau-------------------------------------------//
         DynArr(Index) = %Char(%Dec(DynArr(Index):30:0) + 1);
?      //---Sauvegarde des informations du tableau----------------------------//
         DynArrDsà(HeapId) = DynArrà;
         HeapTab(HeapId)   = HeapDef;
E01    EndIf;

      /End-Free
     p Tab_Incr        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Récupération d'un élément------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Get         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Get         Pi                  like(£Dyna)
     d   Tab_Name                    10a   Const
     d   Index                       10i 0 Value
     ?**---Définition des variables locales-----------------------------------**
     d Element         s                   like(£Dyna) inz
      /Free
       HeapId = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau-------------------------------------//
B01    If HeapId <> 0;
?      //---Récupération des informations du tableau--------------------------//
         HeapDef = HeapTab(HeapId);
?      //---Récupération de l'adresse mémoire du tableau----------------------//
         DynArrà = DynArrDsà(HeapId);
?      //---Récupération de l'élément s'il existe-----------------------------//
B02      If Index <= HeapElems And Index > *Zeros;
           Element = DynArr(Index);
X02      Else;
?      //---Retourne blanc s'il n'existe pas----------------------------------//
           Element = *Blanks;
E02      EndIf;
?      //---Sauvegarde des informations du tableau----------------------------//
         DynArrDsà(HeapId) = DynArrà;
         HeapTab(HeapId)   = HeapDef;
E01    EndIf;

       Return Element;
      /End-Free
     p Tab_Get         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Recherche d'un élément---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Srch        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Srch        Pi                  like(Index)
     d   Tab_Name                    10a   Const
     d   Element                           Value Like(£Dyna)
     d   Index                       10i 0 Value
     ?**---Définition des varaibles locales-----------------------------------**
     d Ind             s             10i 0
     d IndRtn          s             10i 0
     d InfTab          s             10i 0
      /Free

       HeapId   = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau et de la valeur de l'index----------//
B01    If HeapId <> 0  and Index <> 0;
?      //---Récupération des informations du tableau--------------------------//
         HeapDef = HeapTab(HeapId);
?      //---Récupération de l'adresse du tableau en mémoire-------------------//
         DynArrà  = DynArrDsà(HeapId);
?      //---Récupération de l'élément s'il existe-----------------------------//
B02      If Element <> *Blanks;
?      //---Taille du tableau-------------------------------------------------//
           InfTab = Tab_Inf(Tab_Name);
?      //---Recherche dans le tableau-----------------------------------------//
B03        For Ind = Index To InfTab;
?      //---Si trouvé---------------------------------------------------------//
B04          If Element = Tab_Get(Tab_Name:Ind);
               IndRtn = Ind;
               Ind    = Tab_Inf(Tab_Name);
X04          Else;
?      //---Si pas trouvé-----------------------------------------------------//
               IndRtn = 0;
E04          EndIf;
E03        EndFor;
E02      EndIf;
?      //---Sauvegarde des données--------------------------------------------//
         DynArrDsà(HeapId) = DynArrà ;
         HeapTab(HeapId)   = HeapDef;
E01    EndIf;

       Return IndRtn;
      /End-Free
     p Tab_Srch        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Information sur le tableau-----------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Inf         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Inf         Pi            10i 0
     d   Tab_Name                    10a   Const
     ?**---Définition des variables locales-----------------------------------**
     d Taille          s             10i 0
     d Cpt1            s             10i 0
      /Free
       HeapId   = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau-------------------------------------//
B01    If HeapId <> 0;
?      //---Récupération des informations du tableau--------------------------//
         HeapDef = HeapTab(HeapId);
?      //---Récupération de l'adresse en mémoire------------------------------//
         DynArrà  = DynArrDsà(HeapId);
?      //---Recherche du dernier poste alimenté-------------------------------//
B02      For Cpt1 = 1 to  HeapElems;
B03        If DynArr(Cpt1) <> *Blanks;
             Taille = Cpt1;
E03        EndIf;
E02      EndFor;
E01    EndIf;

       Return Taille;
      /End-Free
     p Tab_Inf         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Longueur Maxi d'un élément-----------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Len         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Len         Pi            10i 0
     d   Tab_Name                    10a   Const
     ?**---Définition des variables locales-----------------------------------**
     d Taille          s             10i 0 inz(0)
     d Cpt1            s             10i 0
     d InfTab          s             10i 0
      /Free
       HeapId   = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau-------------------------------------//
B01    If HeapId <> 0;
         HeapDef = HeapTab(HeapId);
         DynArrà  = DynArrDsà(HeapId);
         InfTab   = Tab_Inf(NameTab(HeapId));
?      //---Pour chaque poste-------------------------------------------------//
B02      For Cpt1 = 1 to  InfTab;
?      //---Recherche de la taille--------------------------------------------//
B03        If %Len(%Trim(DynArr(Cpt1))) > Taille;
             Taille = %Len(%trim(DynArr(Cpt1)));
E03        EndIf;
E02      EndFor;
E01    EndIf;

       Return Taille;
      /End-Free
     p Tab_Len         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Transfert d'un tableau---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Trf         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Trf         Pi
     d   Tab_Name                    10a   Const
     d   Tab_Save                    10a   Const
     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s             10i 0 inz(0)
     d InfyTab         s             10i 0 inz(0)
      /Free
?      //---Recherche du Heap du tableau--------------------------------------//
       HeapId   = %LookUp(Tab_Name:NameTab) ;
?      //---Contrôle Existence du tableau-------------------------------------//
B01    If HeapId <> 0;
         HeapDef = HeapTab(HeapId);
         DynArrà  = DynArrDsà(HeapId);
?      //---Suppression du tableau de sauvegarde s'il existe------------------//
B02      If %LookUp(Tab_Save:NameTab) > 0;
           Tab_Term(Tab_Save);
E02      EndIf;
?      //---Transfert des postes 1 à 1----------------------------------------//
         InfyTab = Tab_Inf(Tab_Name);
B02      For Cpt1 = 1 to InfyTab;
           Tab_Set(Tab_Save:Cpt1:Tab_Get(Tab_Name:Cpt1));
E02      EndFor;
E01    EndIf;
      /End-Free
     p Tab_Trf         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Alimentation de la matrice-----------------------------**
     ?**----------------------------------------------------------------------**
     p Mat_Set         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_Set         Pi
     d   Matrice                     10i 0 Const
     d   X                           10i 0 Value
     d   Y                           10i 0 Value
     d   Element                           Value Like(£Dyna)
     ?**---Définition des variables locales-----------------------------------**
     d Tab_Name        s             10a
      /Free
?      //---Contrôle indice de la matrice-------------------------------------//
B01    If Matrice <> 0;
?      //---Récupération des informations de la matrice-----------------------//
         MatriceDs = Mat_Matrice(Matrice);
?      //---Si Informations existent, récupération du Heap du sous tableau----//
B02      If Mat_Y(Y) <> x'4040';
           HeapID = Mat_Y(Y);
?      //---Sinon le sous tableau est créé------------------------------------//
X02      Else;
           Tab_Name = 'MAT' + %Char(y);
           Tab_Init(Tab_Name);
           Mat_Y(Y) = HeapID;
           Mat_Matrice(Matrice) = MatriceDs;
E02      EndIf;
?      //---Alimentation du sous tableau--------------------------------------//
         Tab_Set(NameTab(HeapId):X:Element);
E01    EndIf;
      /End-Free
     p Mat_Set         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Récupération de la matrice-----------------------------**
     ?**----------------------------------------------------------------------**
     p Mat_Get         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_Get         Pi                  Like(£Dyna)
     d   Matrice                     10i 0 Const
     d   X                           10i 0 Value
     d   Y                           10i 0 Value
     ?**---Définition des variables locales-----------------------------------**
     d Element         s                   like(£Dyna)
      /Free
?      //---Contrôle indice de la matrice-------------------------------------//
B01    If Matrice <> 0;
?      //---Recherche information de la matrice-------------------------------//
         MatriceDs = Mat_Matrice(Matrice);
?      //---Récupération du Heap Id du sous tableau---------------------------//
         HeapID = Mat_Y(Y);
?      //---Récupération de lélément du sous tableau--------------------------//
         Element = Tab_Get(NameTab(HeapId):X);
E01    EndIf;

       Return Element;
      /End-Free
     p Mat_Get         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Taille maximale en Y-----------------------------------**
     ?**----------------------------------------------------------------------**
     p Mat_Infy        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_Infy        Pi            10i 0
     d   Matrice                     10i 0 Const
     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s             10i 0 inz(0)
      /Free
?      //---Contrôle indice de la matrice-------------------------------------//
B01    If Matrice <> 0;
         MatriceDs = Mat_Matrice(Matrice);
?      //---Recherche de l'indice de sous tableau le plus élevé---------------//
B02      Dou Mat_Y(Cpt1) = x'4040';
           Cpt1 += 1;
E02      EndDo;
E01    EndIf;

       Return Cpt1 - 1;
      /End-Free
     p Mat_Infy        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Taille maximale en X-----------------------------------**
     ?**----------------------------------------------------------------------**
     p Mat_Infx        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_Infx        Pi            10i 0
     d   Matrice                     10i 0 Const
     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s             10i 0 inz(0)
     d Max             s             10i 0 inz(0)
     d InfyMat         s             10i 0 inz(0)
      /Free

?      //---Contrôle indice de la matrice-------------------------------------//
B01    If Matrice <> 0;
         MatriceDs = Mat_Matrice(Matrice);
         InfyMat   = Mat_Infy(Matrice);
?      //---Pour chaque sous tableau------------------------------------------//
B02      For Cpt1 = 1 To InfyMat;
           HeapID = Mat_Y(Cpt1);
?      //---Recherche de la longueur du poste---------------------------------//
B03        If Tab_Inf(NameTab (HeapId)) > Max;
             Max = Tab_Inf(NameTab(HeapId));
E03        EndIf;
E02      EndFor;
E01    EndIf;

       Return Max;
      /End-Free
     p Mat_Infx        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Longueur d'un élément d'une matrice--------------------**
     ?**----------------------------------------------------------------------**
     p Mat_Len         b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_Len         Pi            10i 0
     d   Matrice                     10i 0 Const
     ?**---Définition des variables locales-----------------------------------**
     d Taille          s             10i 0 inz(0)
     d Cpt1            s             10i 0 inz(0)
     d InfyMat         s             10i 0 inz(0)
      /Free
?      //---Contrôle indice de la matrice-------------------------------------//
B01    If Matrice <> 0;
?      //---Récupération des informations-------------------------------------//
         MatriceDs = Mat_Matrice(Matrice);
         InfyMat = Mat_Infy(Matrice);
?      //---Pour chaque sous tableau------------------------------------------//
B02      For Cpt1 = 1 To InfyMat;
           HeapID = Mat_Y(Cpt1);
?      //---Recherche de la taille--------------------------------------------//
B03        If Tab_Len(NameTab(HeapId)) > Taille;
             Taille = Tab_Len(NameTab(HeapId));
E03        EndIf;
E02      EndFor;
E01    EndIf;

       Return Taille;
      /End-Free
     p Mat_Len         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Longueur d'un élément d'une matrice--------------------**
     ?**----------------------------------------------------------------------**
     p Mat_LenCol      b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_LenCol      Pi            10i 0
     d   Matrice                     10i 0 Const
     d   X                           10i 0 Value
     ?**---Définition des variables locales-----------------------------------**
     d Taille          s             10i 0 inz(0)
     d InfTab          s             10i 0
     d InfyMat         s             10i 0 inz(0)
     d Tab_Name        s             10a
      /Free
?      //---Contrôle indice de la matrice-------------------------------------//
B01    If Matrice <> 0;
         MatriceDs = Mat_Matrice(Matrice);
         InfyMat   = Mat_Infy(Matrice);
?      //---Pour chaque sous tableau------------------------------------------//
B02      For Cpt1 = 1 To InfyMat;
           HeapID = Mat_Y(Cpt1);
?      //---Recherche de la longueur du poste---------------------------------//
           Tab_Name = NameTab(HeapId);
           HeapId   = %LookUp(Tab_Name:NameTab);
?      //---Contrôle existence du tableau-------------------------------------//
B03        If HeapId <> 0;
             HeapDef = HeapTab(HeapId);
             DynArrà  = DynArrDsà(HeapId);
             InfTab   = Tab_Inf(NameTab(HeapId));
?      //---Recherche de la taille--------------------------------------------//
B04          If %Len(%Trim(DynArr(x))) > Taille;
               Taille = %Len(%trim(DynArr(x)));
E04          EndIf;
E03        EndIf;
E02      EndFor;
E01    EndIf;

       Return Taille;
      /End-Free
     p Mat_LenCol      e
     ?**----------------------------------------------------------------------**
     ?**---Procédure : Supression de la Matrice-------------------------------**
     ?**----------------------------------------------------------------------**
     p Mat_Term        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Mat_Term        Pi
     d   Matrice                     10i 0 Const
     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s             10i 0 Inz(1)
     d Tab_Name        s             10a
      /Free
?      //---Contrôle indice matrice-------------------------------------------//
B01    If Matrice <> *Zeros;
         MatriceDs = Mat_Matrice(Matrice);
?      //---Suprresion de tous les sous-tableaux------------------------------//
B02      Dou Mat_Y(Cpt1) = x'4040';
           Tab_Name = 'MAT' + %Char(Cpt1);
           Tab_Term(Tab_Name);
           Cpt1 += 1;
E02      EndDo;
?      //---Suppression des informations sur la matrice-----------------------//
         Clear Mat_Matrice(Matrice);
E01    EndIf;
      /End-Free
     p Mat_Term        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Supression de la Matrice-------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Tri2        b

     d Tab_Tri2        pi
     d  Nom_Tab                      10a   Value
     d  Pos1                          5  0 Value
     d  Pos2                          5  0 Value
?     **---Définition des variables locales-----------------------------------**
     d NbrTab          s              5  0
     d swap            s                   Like(£Dyna)
     d i               s             10i 0
     d j               s             10i 0
     d k               s             10i 0 inz
     d ok              s               n

      /Free

       j = 1;
       k = 0;
       NbrTab = Tab_Inf2(Nom_Tab);

       Dow Not Ok;

         k += 1;
         Ok = *On;
         For i = k to NbrTab - j;
           If %Xlate(up:lo:%Subst(Tab_Get2(Nom_Tab:i):Pos1:Pos2)) >
              %Xlate(up:lo:%Subst(Tab_Get2(Nom_Tab:i+1):Pos1:Pos2));
             Swap = Tab_Get2(Nom_Tab:i);
             Tab_Set2(Nom_Tab:i:Tab_Get2(Nom_Tab:i+1));
             Tab_Set2(Nom_Tab:i+1:Swap);
             Ok = *Off;
           EndIf;
         EndFor;

         j += 1;
         Ok = *On;
         For i = NbrTab - j  DownTo k;
           If %Xlate(up:lo:%Subst(Tab_Get2(Nom_Tab:i):Pos1:Pos2)) >
              %Xlate(up:lo:%Subst(Tab_Get2(Nom_Tab:i+1):Pos1:Pos2));
             Swap = Tab_Get2(Nom_Tab:i);
             Tab_Set2(Nom_Tab:i:Tab_Get2(Nom_Tab:i+1));
             Tab_Set2(Nom_Tab:i+1:Swap);
             Ok = *Off;
           EndIf;
         EndFor;

       EndDo;

      /End-Free
     p Tab_Tri2        e
     ?**----------------------------------------------------------------------**
     ?**---Filtre des zones textes--------------------------------------------**
     ?**----------------------------------------------------------------------**
     p Filtre          b

     d Filtre          pi         10000a
     d  Texte_In                  10000a   Value
     d  Exclus                    10000a   Options(*Omit)
     d  Rempla                    10000a   Options(*Omit)
?     **---Définition des variables locales-----------------------------------**
     d i               s              5  0
     d j               s              5  0
     d Pos             s              5  0
     d Len             s              5  0
     d Texte           s          10000a
      /Free
B01    If %Addr(Exclus) = *Null or Exclus = *Blanks;
         Texte = Texte_In;
         Texte = %Xlate(x'00':x'40':Texte);
         Texte = %Trim(Texte);

B02      For j = 1 To 10000;
           i = %Scan('  ':Texte:j);
B03        If i > 0 ;
             Texte = %Subst(Texte:1:i) + %Subst(Texte:i+2:10000-(i+2));
             j= i-1;
E03        EndIf;
B03        If %Subst(Texte:j+1:10000-j-1) = *Blanks;
             j = 10000;
E03        EndIf;
E02      EndFor;

         Texte_In = *Blanks;
X01    Else;
B02      If %Addr(Rempla) = *Null or Rempla = *Blanks;
           Texte = Texte_In;
           Pos = %Scan(%Trim(Exclus):Texte);
B03        If Pos >0 ;
             Len = %Len(%Trim(Exclus));
B04          For  j = 1 to Len;
               %Subst(Texte:Pos + j-1 : 1) = ' ';
E04          EndFor;
E03        EndIf;
X02      Else;
           Texte = Texte_In;
           Pos = %Scan(%Trim(Exclus):Texte);
B03        If Pos >0 ;
             Len = %Len(%Trim(Exclus));
B04          For  j = 1 to Len;
B05            If j > %Len(%Trim(Rempla));
                 %Subst(Texte:Pos + j-1 : 1) = ' ';
X05            Else;
                 %Subst(Texte:Pos + j-1 : 1) = %Subst(Rempla : j : 1 );
E05            EndIf;
E04          EndFor;
E03        EndIf;
E02      EndIf;
         Texte = Filtre(Texte:*Omit:*Omit);
E01    EndIf;

       Texte_In = *Blanks;
B01    If %Addr(Exclus) <> *Null;
         Exclus   = *Blanks;
E01    EndIf;
B01    If %Addr(Rempla) <> *Null;
         Rempla   = *Blanks;
E01    EndIf;
       return texte;

      /End-Free
     p Filtre          e

     ?**----------------------------------------------------------------------**
     ?**---Contrôle de la résolution de l'écran-------------------------------**
     ?**----------------------------------------------------------------------**

     p Ctl_Dsp         b
     ?**---Définition du prototype d'interface--------------------------------**
     d Ctl_Dsp         Pi              n

     ?**---Définition des variables locales-----------------------------------**
     d Rtcd            s               n
      /Free

       Rtcd = *Off;

?      //---Ouverture du fichier écran----------------------------------------//
B01    If Not %Open(ZZ01D);
         Open(e) zz01d;
B02      If %Error;
?      //---Si impossible d'ouvrir l'écran------------------------------------//
           OvrCmdLen = 100;
           OvrCmd = 'CRTDSPF FILE(££zz01d)';
           QCmdExc(OvrCmd:OvrCmdLen);
           Open ££zz01d;
           hd02 = x'22'+'X-Ref'+x'20'+'fonctionne en 27 * 132 uniquement';
           Except head2;
?      //---Affichage du message pour la résolution---------------------------//
           hd03 = 'Modifier votre résolution écran sinon allez sur ' +
                  'http://shirlock.free.fr';
           Except head3;
?      //---Fermeture des fichiers et sortie du programme---------------------//
           Close ££zz01d;
           OvrCmd = 'DLTF FILE(££zz01d)';
           QCmdExc(OvrCmd:OvrCmdLen);
           Rtcd = *On;
E02     EndIf;
E01    EndIf;

       Return Rtcd;

      /End-Free
     p Ctl_Dsp         e

     ?**----------------------------------------------------------------------**
     ?**---[F23] : Gestion des analyses---------------------------------------**
     ?**----------------------------------------------------------------------**

     p Gst_Analyse     b
     ?**---Définition du prototype d'interface--------------------------------**
     d Gst_Analyse     Pi

     ?**---Définition des variables locales-----------------------------------**
     d Zzflds          s            250a
     d ZzComp          s             10a
     d ZzBib           s             10a
     d ZzType          s             10a
      /Free

B01    Dow Retour = *Off;
?      //---Requete sur fichier ZZ01OUT---------------------------------------//
         Requete4 = 'select Distinct ZzTmst, ZzComp, ZzType, ZzBib, ZzFonc, ' +
                    'ZzMode from zz01out order by ZzTmst Desc';

?      //---Clear du sous-fichier---------------------------------------------//
         F04Rrn = 0;
         SflInd = *On;
         Write F04Ctl;
         SflInd = *Off;

?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec sql
     C+ Prepare S4 From :Requete4
     c/end-exec
     c/Exec sql
     C+ Declare C4 Cursor For S4
     c/end-exec
     c/Exec sql
     C+ OPEN C4
     c/end-exec

     c/Exec sql
     c+ Fetch Next From C4 INTO :Tmst04, :Obj04, :Type04, :Lib04,
     c+ :Fonc04, :Mode04
     c/end-exec
      /Free

         Cpt1 = 0;
?      //---Alimentation du sous-fichier résumé-------------------------------//
B02      Dow Sqlcod <> EndOfFile;
           Cpt1 += 1;
B03        If Entry_OutPut = '*DISPLAY' or Entry_OutPut = '*PRINTER';
             F04Rrn +=1;
             Write F04Sfl;
X03        Else;
             Fld = F04_Ds;
      /End-Free
     c/Exec Sql
     c+ INSERT INTO ZZ01OUT (ZZTMST, ZZCOMP, ZZTYPE, ZZBIB, ZZFONC, ZZMODE,
     c+ ZZFLD) VALUES(:zztmst, :zzcomp, :zztype, :zzbib, :zzfonc, :Trt, :Fld)
     c/End-Exec
      /Free
E03        EndIf;
      /End-Free
     c/Exec Sql
     c+ Fetch Next From C4 INTO :Tmst04, :Obj04, :Type04, :Lib04,
     c+ :Fonc04, :Mode04
     c/End-Exec
      /Free
E02      EndDo;
      /End-Free
     c/Exec Sql
     c+ CLOSE C4
     c/End-Exec
      /Free

B02      If Entry_OutPut = '*DISPLAY';
?      //---Affichage du sous-fichier-----------------------------------------//
B03        If F04Rrn > 0;

             ExFmt F04Ctl;

?      //---Lecture de chaque Enregistrement du sous-fichier------------------//
B04          If Retour <> *On;

B05            For i = 1 to Cpt1;

                 Chain i F04Sfl;
?      //---Si Affichage------------------------------------------------------//
B06              If Opt04 = '5';
                   Retour = *On;
                   i = Cpt1 + 1;
?      //---Requete sur fichier ZZ01OUT---------------------------------------//
                   Requete5 = 'select ZzFld, ZzFonc, ZzComp, ZzType, ZzBib ' +
                   'from zz01out where zztmst = '''+Tmst04 + '''';
?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     C+ Prepare S6 From :Requete5
     c/End-Exec
     c/Exec Sql
     C+ Declare C6 Cursor For S6
     c/End-Exec
     c/Exec Sql
     C+ OPEN C6
     c/End-Exec

     c/Exec Sql
     C+ Fetch Next From C6 INTO :ZzFlds, :ZzFonc, :ZzComp, :ZzType, :ZzBib
     c/End-Exec
      /Free
?      //---Alimentation des informations composants--------------------------//
                   Titre = Tab_Get('Fonction':Tab_Srch('Fonc':ZzFonc:1));
                   FzzDesc = Rtv_entete(ZzFonc);
                   F01Obj = ZzComp;
                   F01Bib = ZzBib;
                   F01Typ = ZzType;
                   If ZzType <> '*ALL' and ZzType <> *Blanks;
                     QusrObjd(Objd0400:%size(Objd0400):Cobjd0200:
                       F01Obj + F01Bib:F01Typ:ApiError);
                     F01Des = OdObjTxtDes;
                   Else;
                     F01Des = *Blanks;
                   EndIf;
                   SavComp = *Blanks;
                   SavComp = F01Obj + F01Bib + F01Typ;
                   Cpt_I = 0;
?      //---Alimentation du sous-fichier principal----------------------------//
B07                Dow Sqlcod <> EndOfFile;
                     FzzZone = ZzFldS;

?      //---Alimentation du tableau principal---------------------------------//
                     Cpt_I += 1;
                     Tab_Set2('££WRK':Cpt_I:FzzZone);

      /End-Free
     c/Exec Sql
     C+ Fetch Next From C6 INTO :ZzFlds, :ZzFonc, :ZzComp, :ZzType, :ZzBib
     c/End-Exec
      /Free
E07                EndDo;

      /End-Free
     C/Exec Sql
     C+ Close C6
     c/End-Exec
      /Free

E06              EndIf;

B06              If Opt04 = '4';
      /End-Free
     c/Exec Sql
     C+ Delete From Zz01out where zztmst = :tmst04
     c/End-Exec
      /Free
E06              EndIf;
E05            EndFor;
E04          EndIf;
             Opt04 = *Blanks;
X03        Else;
             Retour = *On;
E03        EndIf;
X02      Else;
           Retour = *On;
E02      EndIf;
E01    EndDo;

       Exit = *Off;
       Retour = *Off;

      /End-Free
     p Gst_Analyse     e

     ?**----------------------------------------------------------------------**
     ?**---Gestion de l'entête de sous-fichier--------------------------------**
     ?**----------------------------------------------------------------------**

     p Rtv_Entete      b
     ?**---Définition du prototype d'interface--------------------------------**
     d Rtv_Entete      Pi                  Like(FzzDesc)
     d Fonction                            Like(ZzFonc) Value

     ?**---Définition des variables locales-----------------------------------**
     d Entete          s                   Like(FzzDesc)
     d i               s              5  0
      /Free
       i = Tab_Srch('Fonc':fonction:1);
       If i > 0;
         Entete = Desc_Entete(i) + Desc_Entete(i+24);
       Else;
         Entete = *Blanks;
       EndIf;
       return Entete;
      /End-Free
     p Rtv_Entete      e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Création et initialisation du tableau------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Init2       b
     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Init2       pi                  Like(£Heap)

     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s                   Like(£Index)
      /Free

       HeapId = *Zero;
?      //---Nombre d'éléments par défaut--------------------------------------//
       HeapElems = InitAlloc;
?      //---Détermination de la taille initiale-------------------------------//
       HeapSize = HeapElems * %Size(DynArr);
?      //---Création du Heap--------------------------------------------------//
       CeeCrHp(HeapId:HeapSize:0:0:*Omit);
?      //---Allocation du Heap------------------------------------------------//
       CeeGtSt(HeapId:HeapSize:DynArrà:*Omit);
?      //---Initialisation du tableau-----------------------------------------//
       For Cpt1 = 1 to HeapElems;
         Clear DynArr(Cpt1);
       EndFor;
?      //---Tableau de pointeur-----------------------------------------------//
       DynArrDsà(HeapId) = DynArrà;
?      //---Tableau des Heap--------------------------------------------------//
       Heap_Tab(HeapId) = HeapDef;

       Return HeapId;
      /End-Free
     p Tab_Init2       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Création et initialisation du tableau------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Make2       b
     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Make2       pi                  Like(£Heap)
     d   Tab_Name                          Const Like(£Tab)
     d   Index                             Const Like(£Index)
     d   StTab_Name                        Const Like(£StTab)
     d CptMake2        s              5  0
      /Free

?      //---Tableau des sous-tableau------------------------------------------//
       If %LookUp(StTab_Name:Name_Tab) = 0;
?      //---Recherche du Numéro de Heap---------------------------------------//
         HeapId = Tab_Init2();
?      //---Sauvegarde du numéro des Heap Max---------------------------------//
         If HeapId > HeapMax;
           HeapMax = HeapID;
         EndIf;
?      //---Tableau des Heap--------------------------------------------------//
         Name_Tab(HeapId) = StTab_Name;
       EndIf;
?      //---Tableau des tableaux----------------------------------------------//
       If %LookUp(Tab_Name:Master_Tab) = *Zero;
         For CptMake2 = 1 to %elem(Master_Tab);
           If Master_Tab(CptMake2) <> ' ';
             Identifiant = CptMake2 + 1;
           EndIf;
         EndFor;
         If Identifiant >= %Elem(Master_Tab);
           Identifiant = %Elem(Master_Tab);
         EndIf;
         If Identifiant = 0;
           Identifiant = 1;
         EndIf;

         Master_Tab(Identifiant)  = Tab_Name;
         Master_Size(Identifiant) = Index;
       EndIf;

       Return HeapId;

      /End-Free
     p Tab_Make2       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Alimentation du tableau--------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Set2        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Set2        Pi
     d   Tab_Name                          Const Like(£Tab)
     d   Index                             Value Like(£Index)
     d   Element                           Value Like(£Dyna)

     ?**---Définition des variables locales-----------------------------------**
     d IndexReduit     s                   Like(£Index)
     d OldElems        s                   Like(£Index)
     d NumSousTabl     s                   Like(£StIndex)
     d StTab_Name      s                   Like(£StTab)

      /Free

?      //---Tableau des sous-tableau------------------------------------------//
       StTab_Name = Tab_Format2(Tab_Name:Index:IndexReduit:NumSousTabl);
       HeapId     = %LookUp(StTab_Name:Name_Tab);
?      //---Sous-tableau non défini-------------------------------------------//
       If HeapId = 0;
         HeapId = Tab_Make2(Tab_Name:Index:StTab_Name);
       EndIf;
?      //---Récupération des informations sur le heap-------------------------//
       HeapDef = Heap_Tab(HeapId);
       DynArrà = DynArrDsà(HeapId);

?      //---Faut-il agrandir le tableau ?-------------------------------------//
       If IndexReduit > HeapElems;

         OldElems = HeapElems;
?      //---Calcul de la nouvelle taille du tableau---------------------------//
         If IndexReduit > HeapElems + SubsAlloc;
           HeapElems = IndexReduit;
         Else;
           HeapElems += SubsAlloc;
         EndIf;

?      //---Reallocation de la taille-----------------------------------------//
         HeapSize = HeapElems * %Size(DynArr);
         DynArrà  = %realloc(DynArrà:HeapSize);

         DynArrDsà(HeapId) = DynArrà;
         Heap_Tab(HeapId)  = HeapDef;

       EndIf;

?      //---Alimentation du tableau-------------------------------------------//
       DynArr(IndexReduit) = Element;
?      //---Mise à jour du Master Tableau-------------------------------------//
       Identifiant = %LookUp(Tab_Name:Master_Tab);
       If Index > Master_Size(Identifiant);
         Master_Size(Identifiant) = Index;
         Master_Tab(Identifiant) = Tab_Name;
       EndIf;

      /End-Free
     p Tab_Set2        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Récupération d'un élément------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Get2        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Get2        Pi                  Like(£Dyna)
     d   Tab_Name                          Const Like(£Tab)
     d   Index                             Value Like(£Index)
     ?**---Définition des variables locales-----------------------------------**
     d NumSousTabl     s                   Like(£StIndex)
     d StTab_Name      s                   Like(£StTab)
     d Element         s                   like(£Dyna) inz
     d IndexReduit     s                   Like(£Index)

      /Free
?      //---Contrôle existence du Master Tableau------------------------------//
       StTab_Name = Tab_Format2(Tab_Name:Index:IndexReduit:NumSousTabl);
       HeapId   = %LookUp(StTab_Name:Name_Tab);
       If HeapId > 0;
         HeapDef = Heap_Tab(HeapId);
         DynArrà = DynArrDsà(HeapId);
?      //---Récupération de l'élément s'il existe-----------------------------//
         If IndexReduit <= HeapElems;
           Element = DynArr(IndexReduit);
         EndIf;
         DynArrDsà(HeapId) = DynArrà;
         Heap_Tab(HeapId)  = HeapDef;
       Else;
         Element = *Blanks;
       EndIf;

       Return Element;
      /End-Free
     p Tab_Get2        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Définition des propriétés du tableau-------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Format2     b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Format2     Pi                  Like(£StTab)
     d   Tab_Name                          Const Like(£Tab)
     d   Index                             Value Like(£Index)
     d   IndexReduit                       Like(£Index)                          Index réduit
     d   NumSousTabl                       Like(£StIndex)                        Numéro de sous-tabl
     ?**---Définition des variables locales-----------------------------------**
     d StTab_Name      s                   Like(£StTab)

      /Free

       Tab_IdxRed2(Index:IndexReduit:NumSousTabl);
       StTab_Name = Tab_StName2(Tab_Name:NumSousTabl);

       Return StTab_Name;
      /End-Free
     p Tab_Format2     e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Calcul de l'index réduit et numéro de sous tableau-----**
     ?**----------------------------------------------------------------------**
     p Tab_IdxRed2     b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_IdxRed2     Pi
     d   Index                             Const Like(£Index)                    Index
     d   IndexReduit                       Like(£Index)                          Index réduit
     d   NumSousTabl                       Like(£StIndex)                        Numéro de sous-tabl

      /Free

?      //---Numéro de Sous-tableau est un multiple de MaxTab------------------//
       If %Rem(Index:MaxTab) <> 0;
         NumSousTabl = %Div(Index:MaxTab) + 1;
       Else;
         NumSousTabl = %Div(Index:MaxTab);
       EndIf;

?      //---Calcul de l'index Réduit------------------------------------------//
       IndexReduit = Index - ((NumSousTabl - 1) * MaxTab);

      /End-Free
     p Tab_IdxRed2     e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Incrément d'un tableau---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Incr2       b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Incr2       Pi
     d   Tab_Name                          Const Like(£Tab)
     d   Index                             Const Like(£Index)

     ?**---Définition des variables locales-----------------------------------**
     d IndexReduit     s                   Like(£Index)
     d NumSousTabl     s                   Like(£StIndex)
     d StTab_Name      s                   Like(£StTab)

      /Free
?      //---Tableau des sous-tableau------------------------------------------//
       StTab_Name = Tab_Format2(Tab_Name:Index:IndexReduit:NumSousTabl);
       HeapId     = %LookUp(StTab_Name:Name_Tab);
       HeapDef    = Heap_Tab(HeapId);
       DynArrà    = DynArrDsà(HeapId);

?      //---Alimentation du tableau-------------------------------------------//
       DynArr(Index)      = %Char(%Dec(DynArr(Index):30:0) + 1);

       DynArrDsà(HeapId)  = DynArrà;
       Heap_Tab(HeapId)   = HeapDef;

      /End-Free
     p Tab_Incr2       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Information sur le tableau-----------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Inf2        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Inf2        Pi                  Like (£Index)
     d   Tab_Name                          Const Like(£Tab)
     ?**---Définition des variables locales-----------------------------------**
     d Index_Master    s                   Like(£Index)
     d Taille          s                   Like(£MasterTaille)

      /Free
       Index_Master = %LookUp(Tab_Name:Master_Tab);
       If Index_Master > *Zero;
         Taille = Master_Size(Index_Master);
       Else;
         Taille = *Zero;
       EndIf;

       Return Taille;

      /End-Free
     p Tab_Inf2        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Nom du Sous-Tableau------------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_StName2     b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_StName2     Pi                  Like (£StTab)
     d   Tab_Name                          Const Like(£Tab)
     d   NumSousTabl                       Const Like(£StIndex)

     ?**---Définition des variables locales-----------------------------------**
     d   StTab_Name    s                   Like(£StTab)
      /Free

?      //---Tableau des sous-tableau------------------------------------------//
       %Subst(StTab_Name:1:10) = *All'à';
       %Subst(StTab_Name:1:%Len(%Trim(Tab_Name))) = %Trim(Tab_Name);
       %Subst(StTab_Name:11:10) = %Trim(%Char(NumSousTabl));

       Return StTab_Name;

      /End-Free
     p Tab_StName2     e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Longueur de poste d'un tableau-------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Len2        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Len2        Pi                  Like (£Index)
     d   Tab_Name                          Const Like(£Tab)

     ?**---Définition des variables locales-----------------------------------**
     d StTab_Name      s                   Like(£StTab)
     d Long_Name       s                   Like(£Index)
     d Num_StMax       s                   Like(£StIndex)
     d InfTab          s                   Like(£Index)
     d Index_Reduit    s                   Like(£Index)
     d Taille          s                   Like(£Index)
     d I               s                   Like(£Index)
     d J               s                   Like(£Index)
      /Free

?      //---Si le tableau existe----------------------------------------------//
       If %LookUp(Tab_Name:Master_Tab) > *Zero;
?      //---Nombre de poste dans le tableau-----------------------------------//
         Taille = Tab_Inf2(Tab_Name);
?      //---S'il y a  au moins un poste---------------------------------------//
         If Taille > *Zero;
?      //---récupération du n° de sous tableau Max----------------------------//
           Tab_IdxRed2(Taille:Index_Reduit:Num_StMax);
?      //---recherche de la longueur max d'une zone---------------------------//
           For I = 1 To Num_StMax;
?      //---Détermination du sous-tableau-------------------------------------//
             StTab_Name = Tab_StName2(Tab_Name:I);
?      //---S'il existe-------------------------------------------------------//
             HeapId   = %LookUp(StTab_Name:Name_Tab) ;
             If HeapId > *Zero;
?      //---Récupération du tableau-------------------------------------------//
               HeapDef  = Heap_Tab(HeapId);
               DynArrà  = DynArrDsà(HeapId);
?      //---Taille du sous-tableau--------------------------------------------//
               InfTab = Tab_StInf2(Name_Tab(HeapId));
?      //---Contrôle de chaque champ------------------------------------------//
               For J = 1 to  InfTab;
                 If %Len(%Trim(DynArr(J))) > Long_Name;
                   Long_Name = %Len(%trim(DynArr(J)));
                 EndIf;
               EndFor;
             EndIf;
           EndFor;
         EndIf;
       EndIf;

       Return Long_Name;

      /End-Free
     p Tab_Len2        e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Information sur le sous-tableau------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_StInf2      b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_StInf2      Pi                  Like(£Index)
     d   StTab_Name                        Const Like(£StTab)

     ?**---Définition des variables locales-----------------------------------**
     d Taille          s                   Like(£Index)
     d I               s                   Like(£Index)

      /Free
       HeapId   = %LookUp(StTab_Name:Name_Tab);
       HeapDef  = Heap_Tab(HeapId);
       DynArrà  = DynArrDsà(HeapId);

?      //---Taille du sous-tableau--------------------------------------------//
       For I = 1 to  HeapElems;
         If DynArr(I) <> *Blanks;
           Taille = I;
         EndIf;
       EndFor;

       Return Taille;

      /End-Free
     p Tab_StInf2      e
     ?**----------------------------------------------------------------------**
     ?**---Procédure : Recherche d'un élément---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Srch2       b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Srch2       Pi                  Like(£Index)
     d   Tab_Name                          Const like(£Tab)
     d   Element                           Value Like(£Dyna)
     d   Index                             Value Like(£Index)

     ?**---Définition des variables locales-----------------------------------**
     d StTab_Name      s                   Like(£StTab)
     d Num_StMax       s                   Like(£StIndex)
     d Num_StDeb       s                   Like(£StIndex)
     d InfTab          s                   Like(£Index)
     d Index_Reduit    s                   Like(£Index)
     d Taille          s                   Like(£Index)
     d I               s                   Like(£Index)
     d J               s                   Like(£Index)
     d IndRtn          s                   Like(£Index)

      /Free

?      //---Si variable à rechercher est différente de *blanks----------------//
       If Element <> *Blanks;
?      //---Si le tableau existe----------------------------------------------//
         If %LookUp(Tab_Name:Master_Tab) > *Zero;
?      //---Nombre de poste dans le tableau-----------------------------------//
           Taille = Tab_Inf2(Tab_Name);
?      //---S'il y a  au moins un poste---------------------------------------//
           If Taille > *Zero;
?      //---récupération du n° de sous tableau Max----------------------------//
             Tab_IdxRed2(Taille:Index_Reduit:Num_StMax);
?      //---récupération du n° de sous tableau de début-----------------------//
             Tab_IdxRed2(Index:Index_Reduit:Num_StDeb);
?      //---recherche de la longueur max d'une zone---------------------------//
             For I = Num_StDeb To Num_StMax;
?      //---Détermination du sous-tableau-------------------------------------//
               StTab_Name = Tab_StName2(Tab_Name:I);
?      //---S'il existe-------------------------------------------------------//
               HeapId   = %LookUp(StTab_Name:Name_Tab) ;
               If HeapId > *Zero;
?      //---Récupération du tableau-------------------------------------------//
                 HeapDef  = Heap_Tab(HeapId);
                 DynArrà  = DynArrDsà(HeapId);
?      //---Taille du sous-tableau--------------------------------------------//
                 InfTab = Tab_StInf2(Name_Tab(HeapId));

?      //---Contrôle de chaque champ------------------------------------------//
                 For J = Index_Reduit to  InfTab;
                   If Element = Tab_Get2(Name_Tab(HeapId):J);
                     IndRtn = J;
                     J = InfTab;
                     I = Num_StMax;
                   EndIf;
                 EndFor;
               EndIf;
             EndFor;
           EndIf;
         EndIf;
       EndIf;

       Return IndRtn;

      /End-Free
     p Tab_Srch2       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Suppression du tableau---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Term2       b
     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Term2       Pi
     d   Tab_Name                          Like(£Tab) Value

     ?**---Définition des variables locales-----------------------------------**
     d HeapId          s                   Like(£Heap)
     d StTab_Name      s                   Like(£StTab)
     d Num_StMax       s                   Like(£StIndex)
     d Index_Reduit    s                   Like(£Index)
     d Taille          s                   Like(£Index)
     d I               s                   Like(£Index)
     d Pt              s               *

      /Free

?      //---Adresse du nom de tableau-----------------------------------------//
       Pt = %Addr(Tab_Name);
?      //---Si le nom de tableau est renseigné--------------------------------//
B01    If Pt <> *Null;
?      //---Suppression du tableau--------------------------------------------//
B02      If %LookUp(Tab_Name:Master_Tab) > *Zero;
?      //---Nombre de poste dans le tableau-----------------------------------//
           Taille = Tab_Inf2(Tab_Name);
?      //---S'il y a au moins un poste----------------------------------------//
B03        If Taille > *Zero;
?      //---Récupération du n° de sous tableau Max----------------------------//
             Tab_IdxRed2(Taille:Index_Reduit:Num_StMax);
?      //---Recherche de la longueur max d'une zone---------------------------//
B04          For I = 1 To Num_StMax;
?      //---Détermination du sous-tableau-------------------------------------//
               StTab_Name = Tab_StName2(Tab_Name:I);
?      //---S'il existe-------------------------------------------------------//
               HeapId = %LookUp(StTab_Name:Name_Tab);
B05            If HeapId > *Zero;
                 Name_Tab(HeapId) = *Blanks;
?      //---Suppression du Heap-----------------------------------------------//
                 CeeDsHp(HeapId:*Omit);
                 Clear DynArrDsà(HeapId);
                 Clear Heap_Tab(HeapId);
                 Clear Name_Tab(HeapId);
?      //---Mise à jour du Heap Id Max.---------------------------------------//
B06              If HeapId = HeapMax;
                   HeapMax -= 1;
E06              EndIf;
E05            EndIf;
E04          EndFor;
E03        EndIf;
           Master_Tab(%LookUp(Tab_Name:Master_Tab)) = *Blanks;
E02      EndIf;
X01    Else;
?      //---Suppression de tous les tableaux----------------------------------//
B02      For HeapId = 1 To HeapMax;
           CeeDsHp(HeapId:*Omit);
           Clear DynArrDsà(HeapId);
           Clear Heap_Tab(HeapId);
           Clear Name_Tab(HeapId);
E02      EndFor;

E01    EndIf;
      /End-Free
     p Tab_Term2       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Transfert d'un tableau---------------------------------**
     ?**----------------------------------------------------------------------**
     p Tab_Trf2        b

     ?**---Définition d'interface de procédure--------------------------------**
     d Tab_Trf2        Pi
     d   Tab_Name                          Const Like (£Tab)
     d   Tab_Save                          Const Like (£Tab)

     ?**---Définition des variables locales-----------------------------------**
     d Cpt1            s                   Like(£Index) inz(0)
     d InfyTab         s                   Like(£Index) inz(0)

      /Free
?      //---Suppression du tableau de sauvegarde s'il existe------------------//
       If %LookUp(Tab_Save:Master_Tab) > 0;
         Tab_Term2(Tab_Save);
       EndIf;
?      //---Transfert des postes du tableau-----------------------------------//
       InfyTab = Tab_Inf2(Tab_Name);
       For Cpt1 = 1 to InfyTab;
         Tab_Set2(Tab_Save:Cpt1:Tab_Get2(Tab_Name:Cpt1));
       EndFor;
      /End-Free
     p Tab_Trf2        e

     ?**----------------------------------------------------------------------**
     ?**---Récupération du pointeur de procédure------------------------------**
     ?**----------------------------------------------------------------------**
     p GetProcPtr      b
     ?**---Définition du prototype d'interface--------------------------------**
     D GetProcPtr      Pi              *   ProcPtr
     D   Procedure                  100a   Varying Const
     D   Srvpgm                      10a   Const
     D   Library                     10a   Const
     ?**---Définition des variables locales-----------------------------------**
     d LibPtr          s                   Like(£SysPtr)
     d SrvpgmPtr       s                   Like(£SysPtr)
     d ActMark         s             10i 0
     d ProcPtr         s               *   ProcPtr
     d ExportType      s             10i 0
     ?**---Définition des constantes locales----------------------------------**
     d EX_NOT_FOUND    c                   0
     d EX_PROC         c                   1
     d EX_DATA         c                   2
     d EX_NO_ACCESS    c                   3

      /Free
?      //---First, get the pointer to the service program---------------------//
       If Library = '*LIBL';
?      //---They specified *LIBL----------------------------------------------//
         TypeSubtyp = x'0203';
         ObjectPtr = Srvpgm;
         RslvSp2(SrvpgmPtr : RslvTemplt);
       Else;
?      //---They specified the library ...------------------------------------//
?      //---Get the pointer to the library------------------------------------//
         TypeSubtyp = x'0401';
         ObjectPtr = Library;
         RslvSp2(LibPtr : RslvTemplt);
?      //---Get the pointer to the service program----------------------------//
         TypeSubtyp = x'0203';
         ObjectPtr = Srvpgm;
         RslvSp4(SrvpgmPtr : RslvTemplt : LibPtr);
       EndIf;
?      //---Now, activate the service program---------------------------------//
       ActBndPgm(SrvpgmPtr : ActMark :ABP_Info : %size(ABP_Info) : ErrCode);
?      //---------------------------------------------------------------------//
?      //---Finally, get the procedure pointer--------------------------------//
?      //---We're using nameLen+name rather than export-number----------------//
?      //---so we pass 0 as the export number.--------------------------------//
?      //---------------------------------------------------------------------//
       GetExport(ActMark:0:%len(Procedure):Procedure:ProcPtr:
                 ExportType:ErrCode);
?      //---Return the procedure pointer--------------------------------------//
       If ExportType = EX_PROC;
         Return ProcPtr;
       Else;
         Return *Null;
       EndIf;
      /End-Free
     P GetProcPtr      e

     ?**----------------------------------------------------------------------**
     ?**---Récupération des infos Querys--------------------------------------**
     ?**----------------------------------------------------------------------**
     p RtvQryf         b
     d RtvQryf         Pi
     d  QryName                      10a
     d  QryLib                       10a
     d  QryIn                      1280a
     d  QryOut                       30a
     d  ErrCode                       1a

     ?**---Définition des constantes locales----------------------------------**
     d QryOutTypeOff   c                   Const(261)
     d QryOutOffOff    c                   Const(381)
     d QryInCountOff   c                   Const(559)
     d QryInOff        c                   Const(563)

     ?**---Définition des variables locales-----------------------------------**
     d  QryOut1        ds
     d  QryOutFile                   10a
     d  QryOutFileLib                10a
     d  QryOutFileMbr                10a
     d Idx             s             10i 0
     d QUsQName        s             20a   Inz('QRYDMP    QTEMP     ')
     d QUsExtAtr       s             10a   Inz('QryDump')
     d QUsInzSiz       s              9b 0 Inz(x'1000')
     d QUsInzVal       s              1a   Inz(x'00')
     d QUsAut          s             10a   Inz('*ALL')
     d QUsTxt          s             50a   Inz('User Space for RtvQryF')
     d QUsLib          s             10a
     d QUsErrCode      s               *   Inz(*Null)
     d QMhErrCode      s               *   Inz(*Null)
     d QryOutType      s              1a
     d QryOutTmp       s             34a
     d QryInTmp        s             80a
     d QryAut          s               n   Inz( *Off )
     d QryOutOffDS     Ds
     d  QryOutOff                    10U 0
     d QryInCountDS    Ds
     d  QryInCount                    5U 0
     d QUsAttr         Ds
     d                               10i 0 Inz(1)                               QUsNumRec
     d                               10i 0 Inz(3)                               QUsKey
     d                               10i 0 Inz(1)                               QUsRecLen
     d                                1a   Inz('1')                             QUsRecData
     d QUsRtvUs        Pr                  ExtPgm('QUSRTVUS')
     d  QualifiedName                20a   Const
     d  StartingPos                  10i 0 Const
     d  DataRcvLength                10i 0 Const
     d  DataRcv                    9999a   Options(*Varsize)
     d QMhRmvPm        Pr                  ExtPgm('QMHRMVPM')
     d  CSE                          16a   Const
     d  CSECtr                       10i 0 Const
     d  MessageKey                    4a   Const
     d  MsgToRmv                     10a   Const
     d  ErrCode                        *
      /Free
       ErrCode = '0';
?      //---Création du User Space--------------------------------------------//
       QusCrtUs(QUsQName:QUsExtAtr:QUsInzSiz:QUsInzVal:QUsAut:QUsTxt
       :SpaceReplc:ApiError);
?      //---Augmentation de la taille en automatique--------------------------//
       QusCusAt(QUsLib:QUsQName:QUsAttr:QUsErrCode);
?      //---Dump du Query dans le User Spaceomatique--------------------------//
       DmpQry(QryName:QryLib:QUsQName:QryAut);

?      //---Si Autorisé à l'objet---------------------------------------------//
       If QryAut;

?      //---Récupération des données------------------------------------------//
         QUsRtvUs(QUsQName:QryOutTypeOff:%Size(QryOutType):QryOutType);
?      //---Contrôle Existence d'un fichier en sortie-------------------------//
         If QryOutType <> '3';
           QryOutFile = '*NONE';
         Else;
           QUsRtvUs(QUsQName:QryOutOffOff:%Size(QryOutOffDS):QryOutOffDS);
?      //---Contrôle Existence d'un fichier en sortie par défaut--------------//
           If QryOutOff = 0;
             QryOutFile = '*DFT';
           Else;
?      //---Récupération des infos du fichier en sortie-----------------------//
             QUsRtvUs(QUsQName:QryOutOff + 5:%Size(QryOutTmp):QryOutTmp);
             QryOutFile    = %Subst(QryOutTmp :  1 : 10);
             QryOutFileLib = %Subst(QryOutTmp : 13 : 10);
             QryOutFileMbr = %Subst(QryOutTmp : 25 : 10);
           EndIf;
         EndIf;

?      //---Récupération dui nombre de fichier en entrée----------------------//
         QUsRtvUs(QUsQName:QryInCountOff:%Size(QryInCountDS):QryInCountDS);
?      //---Lecture pour chaque fichier en entrée-----------------------------//
         For Idx = 0 To QryInCount - 1;
           QUsRtvUs(QUsQName:QryInOff+(Idx*80):%Size(QryInTmp):QryInTmp);
           %Subst(QryIn:1+(Idx*40):40)=%Subst(QryInTmp:1:10) +
           %Subst(QryInTmp:13:10)+%Subst(QryInTmp:25:10)+%Subst(QryInTmp:37:10);
         EndFor;

?      //---Suppression des messages------------------------------------------//
         QMhRmvPm('*ALLINACT':0:'    ':'*ALL':QMhErrCode);

       EndIf;
       If Not QryAut;
         If ErrCode = '0';
           ErrCode = '2';
         EndIf;
       EndIf;
       QryOut = QryOut1;
       ExSr Cleanup;
       *InLr = *On;
       Return;

?      //---------------------------------------------------------------------//
?      //---CleanUp : Nettoyage-----------------------------------------------//
?      //---------------------------------------------------------------------//

       BegSr CleanUp;
       QusDltUs(QusQName:ApiError);
       EndSr;

      /End-Free
     p RtvQryf         e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : DmpQry Dump d'un Query---------------------------------**
     ?**----------------------------------------------------------------------**
     p DmpQry          b
     d DmpQry          Pi
     d  QueryName                    10a   Const
     d  QueryLib                     10a   Const
     d  QUSName                      20a   Const
     d  QryAut                         n

     ?**---Définition des variables locales-----------------------------------**
     d Cmd             S            100a
     d VerRelMod       S             10i 0
     d RcdNbr          S             10i 0
     d QUsStrPos       s             10i 0 Inz(1)
     d QUsDataForce    s              1a   Inz('1')
     ?**---Définition des constantes locales----------------------------------**
     d QMHRSNEM        c                   'QMHRSNEM'

     d QUsChgUs        PR                  ExtPgm('QUSCHGUS')
     d  QualifiedName                20a   Const
     d  StartingPos                  10i 0 Const
     d  DataLength                   10i 0 Const
     d  Data                       9999    Options(*VarSize)
     d  ForceChanges                  1a

     d SysCmd          Pr                  ExtPgm('QCMDEXC')
     d  CmdString                   300a   Options(*VarSize) Const
     d  CmdStringSize                15P 5 Const
     d  CmdOptions                    3a   Options(*NoPass) Const

      /Free

?      //---Sauvegarde du Query dans un savf----------------------------------//
       Cmd = 'CRTSAVF FILE(QTEMP/DMPFIL)';
       SysCmd(Cmd:%Size(Cmd));
       Cmd = 'SAVOBJ OBJ('+%Trim(QueryName)+') LIB( '+%Trim(QueryLib)+') '  +
             'DEV(*SAVF) OBJTYPE(*QRYDFN) SAVF(QTEMP/DMPFIL)';
       CallP(e)  SysCmd(Cmd:%Size(Cmd));
       If Not %Error;
         QryAut = *On;
?      //---Version de l'OS---------------------------------------------------//
         VerRelMod = %Dec(%subst(Version_os:2:1)+%subst(Version_os:4:1)+
         %subst(Version_os:6:1):3:0);
?      //---Calcul du nombre d'enregistrements à éviter-----------------------//
         If VerRelMod < 530;
           RcdNbr = 33;
         Else;
           RcdNbr = 48;
         Endif;

?      //---Override du savf--------------------------------------------------//
         Cmd = 'OVRSAVF FILE(DMPFIL) EXTEND(*NO) POSITION(*RRN ' +
            %char(RcdNbr)+') WAITFILE(*IMMED) SHARE(*NO) OPNSCOPE(*ACTGRPDFN)';
         SysCmd(Cmd:%Size(Cmd));

         Open DmpFil;
         Read DmpFil DmpFilDs;
?      //---Si l'OS est < 5.3, on saute les premiers 256 bytes----------------//
         If VerRelMod < 530;
           QUsChgUs(QUsName:QUsStrPos:%Size(NoOMH):NoOMH:QUsDataForce);
           QUsStrPos = QUsStrPos + %Size(NoOMH);
         Endif;
?      //---Lecture du restant du fichier et écriture dans le User Space------//
         Dou %Eof(DmpFil);
           Read DmpFil DmpFilDs;
           QUsChgUs(QUsName:QUsStrPos:%Size(SavfDta):SavfDta:QUsDataForce);
           QUsStrPos = QUsStrPos + %Size(SavfDta);
         EndDo;
       Else;
?      //---En Cas d'erreur---------------------------------------------------//
         QryAut = *Off;
       EndIf;
?      //---Nettoyage et Sortir-----------------------------------------------//
       ExSr Cleanup;
       Return;

?      //---------------------------------------------------------------------//
?      //---Cleanup working file----------------------------------------------//
?      //---------------------------------------------------------------------//
       BegSr CleanUp;

       Close DmpFil;
       Cmd = 'DLTF FILE(QTEMP/DMPFIL)';
       CallP(e)  SysCmd(Cmd:%Size(Cmd));

       EndSr;

      /End-Free
     P DmpQry          e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Lib_Size : Taille d'une bibliothèque---------------------**
     ?**----------------------------------------------------------------------**
     p Taille_Bib      b

     d Taille_Bib      Pi
     d   ParamPlug                 1024a
     ?**---Liste des objets---------------------------------------------------**
     d QUsLObj         Pr                  ExtPgm('QUSLOBJ')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                         10a
     ?**---Création d'un User Space-------------------------------------------**
     d QusCrtUs        Pr                  ExtPgm('QUSCRTUS')
     d  parm                         20a
     d  parm                         10a
     d  parm                          9b 0
     d  parm                          1a
     d  parm                         10a
     d  parm                         50a
     d  parm                         10a
     d  parm                               like(ApiError)
     ?**---Description d'une bibliothèque-------------------------------------**
     d QLirLibd        Pr                  Extpgm('QLIRLIBD')
     d  parm                      32767a         Options(*Varsize)              RcvVar
     d  parm                         10i 0 Const                                RcvVarLen
     d  parm                         10a   Const                                Library
     d  parm                      32767a   Const                                AtrToRtv
     d  parm                               Likeds(ApiError)                     Parm
     ?**---Recherche de l'adresse d'un User Space-----------------------------**
     d Qusptrus        Pr                  ExtPgm('QUSPTRUS')
     d  parm                         20a
     d  parm                           *
     ?**---Réception d'un User Space------------------------------------------**
     d Qusrtvus        Pr                  ExtPgm('QUSRTVUS')
     d  parm                         20a
     d  parm                          9b 0
     d  parm                          9b 0
     d  parm                       2000a   Options(*Varsize)
     ?**---Définition des Constantes------------------------------------------**
     d MaxTab          c                   Const(32767)                         Taille Max tableau
     ?**---Entête d'un User Space---------------------------------------------**
     d GenHeadDs       ds                  based(pUserSpace)
     d                       113    116b 0                                      Taille de l'entête
     d                       117    120i 0                                      Offset de l'entête
     d                       121    124i 0                                      Taille de l'entête
     d  ListOffset           125    128b 0                                      Offset des données
     d                       129    132i 0                                      Taille de la liste
     d  NumberList           133    136b 0                                      Nombre de données
     d  EntrySize            137    140b 0                                      Taille des données
     ?**---User Space Générique-----------------------------------------------**
     d UserSpace       ds
     d  SpaceName                    10a
     d  SpaceLib                     10a
     ?**---Code Erreur standard API : ERRC0100--------------------------------**
     d ApiError        ds
     d                               10i 0 Inz(%Size(ApiError))
     d                               10i 0 Inz                                  Bytes Available
     d                                7a                                        Exception Id
     d                                1a                                        Reserved
     d                              128a                                        Exception Data
     ?**---Liste des Objets---------------------------------------------------**
     d DsList          ds                                                       Liste d'objet
     d  DsListFile                   10                                         Objet
     d                               10                                         Bibliothèque
     d                               10                                         Type d'objet
     ?**---Description d'un composant-----------------------------------------**
     d Composant       ds                                                       Composant
     d  Obj                          10a                                        Objet
     d  Lib                          10a                                        Bibliothèque

     d AtrToRtvDS      ds
     d                               10i 0 Inz(1)
     d   Elm                         10i 0 Dim(1)
      *
     d QLirr           ds         32767
     d                               10i 0
     d                               10i 0
     d                               10i 0
     d                               10i 0
      *
     d LibSizeDS       ds
     d   LibSize                     10i 0
     d   LibSizeMult                 10i 0
     d                                 n
     d                                3A
     d VarLenDS        ds                  Based(VarLenà)
     d   VLRtnDtaLen                 10i 0
     d   VLKeyID                     10i 0
     d   VLFldSize                   10i 0
     d   VLFldValue                1000a
     ?**---Définition des variables-------------------------------------------**
     d k               s              5  0 inz                                  Compteur
     d NbrMbr          s              5  0
     d Taille          s             15  0
     d FormatName      s              8a
     d SpaceValue      s              1a   inz(X'00')                           Valeur du User Space
     d ObjectType      s             10a   inz('*ALL')                          Type d'objet
     d SpaceAuth       s             10a   inz('*USE')                          Autorisation User Sp
     d SpaceReplc      s             10a   inz('*YES')                          Remplacement du User
     d SpaceAttr       s             10a   inz                                  Attribut du User Spa
     d SpaceText       s             50a   inz('User Space Temporaire')         Libellé User Space
     d SpaceLen        s              9b 0 inz(MaxTab)                          Longueur du User Spa
     d StartPosit      s              9b 0                                      Position dans le Use
     d StartLen        s              9b 0                                      Longueur dans le Use
     d LibName         s             10a   inz                                  Bibliothèque
     d LibTotsize      s             20i 0
     d VarLenà         s               *

      /Free

?      //---Récupération paramètres-------------------------------------------//
       DataPlugin = ParamPlug;
       LibName = X_Objet;

?      //---Create User Space-List Fichier------------------------------------//
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       SpaceLen = MaxTab;
       QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                SpaceAuth:SpaceText:SpaceReplc:ApiError);

       FormatName = 'OBJL0100';
       Obj = LibName;
       Lib = 'QSYS';
       ObjectType = '*LIB';
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       QUslObj(UserSpace:FormatName:Composant:ObjectType);

?      //---Retrieve user space General information---------------------------//
       StartPosit = 1;
       StartLen = 1024;
       SpaceName = 'USERSPACE';
       SpaceLib = 'QTEMP';
       Qusptrus(UserSpace:pUserSpace);
       QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);

?      //---Retrieve user space Detail information----------------------------//
       StartPosit = ListOffset + 1;
       StartLen = EntrySize;
       NbrMbr = NumberList;

       For k = 1 to NbrMbr;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUsPtrUs(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:DsList);
         StartPosit = StartPosit + StartLen;
         libname = DSLISTFILE;
         elm(1) = 6;
         Clear QLirr;
         Clear ApiError;
         qlirlibd( QLirr:%size(QLirr):LibName:AtrToRtvDS: Apierror);
         VarLenà = %addr( QLirr ) + 16;
         LibSizeDS = VLFldValue;
         If LibSizeMult > 1;
           LibTotSize = LibSize * LibSizeMult ;
         Else;
            LibtotSize = LibSize;
         Endif;

       EndFor;

?      //---Formatage des paramètres en sortie--------------------------------//
       Taille = LibTotsize /1000;
       x_Texte = x'20' + 'Taille = '+ x'22' + %Char(Taille)
        + x'20' +' Ko';
       Taille = LibTotsize /1000000;
       x_Texte = %Trim(x_Texte) + ' / ' + x'22' + %Char(Taille) + x'20' + 'Mo';

?      //---Retour paramètres-------------------------------------------------//
       ParamPlug = DataPlugin;

      /End-Free
     p Taille_Bib      e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Suppression des enregistrement de PGMREF-----------------**
     ?**----------------------------------------------------------------------**
     p Net_Pgmref      b

     ?**---Lancement de Commande----------------------------------------------**
     d QCmdExc         Pr                  ExtPgm('QCMDEXC')
     d  parm                        100a                                        Commande
     d  parm                         15  5                                      Longueur de la Cde
     ?**---Définition des variables locales-----------------------------------**
     d OvrCmd          s            100a                                        Commande AS400
     d OvrCmdLen       s             15  5                                      Longueur de la comma
     d Nbr_Enr         s              9  0

     d Net_Pgmref      Pi
     d   ParamPlug                 1024a
     c/Exec Sql
     c+ delete from zz01pf where zzvaleur in
     c+ (select whlib from pgmref group by whlib having count(*) = 0)
     c/End-exec
     c/Exec Sql
     c+ delete from pgmref where whlib not in
     c+ (select zzvaleur from zz01pf where zztype ='OBLIB')
     c/End-exec
     c/Exec Sql
     c+ Select count(*) into :Nbr_Enr from pgmref
     c/end-Exec
      /Free
       If Nbr_Enr > 0;
         OvrCmd = 'RGZPFM PGMREF';
         OvrCmdLen = 15;
         QCmdExc(OvrCmd:OvrcmdLen);
       EndIf;
      /End-Free
     p Net_PgmRef      e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Liste des zones dans un programme----------------------**
     ?**----------------------------------------------------------------------**
     p Zone_Prog       b
     d Zone_Prog       Pi
     d   ParamPlug                 1024a
     ?**---Définition des variables-------------------------------------------**
     d Requete         s           1000a
     d*SrcSeq12        s              8a
     d*SrcDta12        s             83a
     d OvrCmd          s            200a                                        Commande AS400
     d OvrCmdLen       s             15  5                                      Longueur de la comma
     ?**---Lancement de Commande----------------------------------------------**
     d QCmdExc         Pr                  ExtPgm('QCMDEXC')
     d  parm                        100a                                        Commande
     d  parm                         15  5                                      Longueur de la Cde
      /Free

?      //---Récupération paramètres-------------------------------------------//
       DataPlugin = ParamPlug;
?      //---Si Programme------------------------------------------------------//
       If x_Type = '*PGM';
         If F01Msrc <> *Blanks;
           F01LSrc = x_Bibsrc;
           F01FSrc = x_FicSrc;
           F01MSrc = x_MbrSrc;
         Else;
           F01LSrc = x_Bib;
           F01FSrc = *Blanks;
           F01MSrc = x_Objet;
         EndIf;
       EndIf;
?      //---Si Fichier--------------------------------------------------------//
       If x_Type = '*FILE';
         F01File = x_Objet;
         F01Libl = x_Bib;
         F01LSrc = *Blanks;
         F01FSrc = *Blanks;
         F01MSrc = *Blanks;
       EndIf;
?      //---Boucle principale-------------------------------------------------//
       Exit = *Off;
       Dow Not Retour AND Not Exit;
?      //---Affichage de l'écran de sélection---------------------------------//
         Write Foot;
         Exfmt F1201;
?      //---Miseà blanc des zones---------------------------------------------//
         SrcSeq12 = *Blanks;
         SrcDta12 = *Blanks;
         Column = *Blanks;
         Tablen = *Blanks;
         Pst = *Blanks;
         If AffSrc;
           OvrCmd = 'STRSEU SRCFILE(' + %Trim(F01LSRC) + '/' + %Trim(F01FSRC) +
                    ') SRCMBR(' + %Trim(F01MSRC) + ') OPTION(5)';
           OvrCmdLen = 200;
           QcmdExc(OvrCmd:OvrCmdLen);
         EndIf;
         If Not Exit
            and F01LSrc <> *Blanks and F01FSrc <> *Blanks and F01MSrc <> *Blanks
            and F01File <> *Blanks and F01Libl <> *Blanks;
?      //---Suppression de l'alias--------------------------------------------//
      /End-Free
     c/Exec Sql
     c+ drop alias qtemp/recherche
     c/End-Exec
      /Free
?      //---Creation de l'alias-----------------------------------------------//
           Requete = 'Create Alias Qtemp/Recherche For ' + F01LSrc + '/'
                     + F01FSrc + '(' + F01MSrc + ')';
      /End-Free
     c/Exec Sql
     c+ Execute Immediate :Requete
     c/End-Exec
      /Free
?      //---Définition de la requête principale-------------------------------//
           Requete = 'Select SRCSEQ, SRCDTA, COLUMN_NAME, TABLE_NAME,          -
           POSITION(TRIM(COLUMN_NAME) IN UPPER(SRCDTA)) AS PST FROM            -
           QTEMP/RECHERCHE, QSYS2/SYSCOLUMNS WHERE TABLE_SCHEMA =' +
           '''' + F01LIBL + '''' + ' AND TABLE_NAME = ' + '''' + F01FILE + ''''+
           'AND (POSITION(COLUMN_NAME IN UPPER(SRCDTA)) <> 0                   -
            OR POSITION(TRIM(COLUMN_NAME) IN UPPER(SRCDTA)) <> 0)';
?      //---Préparation, déclaration, ouverture, ....-------------------------//
      /End-Free
     c/Exec Sql
     c+ Prepare S From :Requete
     c/End-Exec
     c/Exec Sql
     c+ Declare C Cursor For S
     c/End-Exec
     c/Exec Sql
     c+  Open C
     c/End-Exec
      /Free
?      //---Clear du sous-fichier---------------------------------------------//
            SflClr = *On;
            Write F12Ctl;
            SflClr = *Off;
            f12rrn = 0;
?      //---Lecture du premier enregistrement---------------------------------//
      /End-Free
     c/Exec Sql
     c+ FETCH NEXT FROM C INTO :SrcSeq12, :SrcDta12, :Column, :Tablen, :Pst
     c/End-Exec
      /Free
?      //---Boucle sur la requête---------------------------------------------//
            Dow sqlcod <> 100;
              f12rrn += 1;
              Write F12Sfl;
      /End-Free
     c/Exec Sql
     c+ FETCH NEXT FROM C INTO :SrcSeq12, :SrcDta12, :Column, :Tablen, :Pst
     c/End-Exec
      /Free
            EndDo;
?      //---Fermeture du curseur----------------------------------------------//
      /End-Free
     c/Exec Sql
     c+ Close C
     c/End-Exec
      /Free
?      //---Si rien trouvé----------------------------------------------------//
            If f12rrn = 0;
              f12rrn +=1;
              SrcDta12 = 'Aucun Enregistrement trouvé';
              Write F12Sfl;
            EndIf;

?      //---Affichage du sous fichier-----------------------------------------//
            F12Rcd = 1;
            SflDsp=*on;
            SflDspCtl=*on;
            Write F12ctl;
            SflDsp=*off;
            SflDspCtl=*off;
          EndIf;
       EndDo;

      /End-Free
     p Zone_Prog       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure : Archivage d'un fichier par trigger---------------------**
     ?**----------------------------------------------------------------------**
     p Arc_Trigg       b
     d Arc_Trigg       Pi
     d   ParamPlug                 1024a
     ?**---Définition des variables-------------------------------------------**
     d Action          s              1a
     d Bib             s             10a
     d Fic             s             10a
     d Fic_Log         s             10a
     d Requete2        s          32766a
     d Lst_Zone        s          32766a
     d OvrCmd          s           2800a                                        Commande AS400
     d OvrCmdLen       s             15  5                                      Longueur de la comma
     ?**---User Space Générique-----------------------------------------------**
     d UserSpace       ds
     d  SpaceName                    10a
     d  SpaceLib                     10a
     ?**---Création d'un User Space-------------------------------------------**
     d QusCrtUs        Pr                  ExtPgm('QUSCRTUS')
     d  parm                         20a
     d  parm                         10a
     d  parm                          9b 0
     d  parm                          1a
     d  parm                         10a
     d  parm                         50a
     d  parm                         10a
     d  parm                               like(ApiError)
     ?**---Suppression d'un User Space----------------------------------------**
     d QusdltUs        Pr                  ExtPgm('QUSDLTUS')
     d  parm                         20a
     d  parm                               like(ApiError)
     ?**---Liste des formats--------------------------------------------------**
     d QUsLRcd         Pr                  ExtPgm('QUSLRCD')
     d  parm                         20a
     d  parm                          8a
     d  parm                         20a
     d  parm                          1a
     ?**---Affichage des zones d'un fichier-----------------------------------**
     d Quslfld         Pr                  ExtPgm('QUSLFLD')
     d  parm                         20a
     d  parm                         10a
     d  parm                         20a
     d  parm                         10a
     d  parm                          1a
     ?**---Code Erreur standard API : ERRC0100--------------------------------**
     d ApiError        ds
     d  AeBytPro                     10i 0 Inz(%Size(ApiError))
     d  AeBytAvl                     10i 0 Inz                                  Bytes Available
     d  AeMsgId                       7a                                        Exception Id
     d                                1a                                        Reserved
     d  AeMsgDta                    128a                                        Exception Data
     ?**---Description d'un composant-----------------------------------------**
     d Composant       ds                                                       Composant
     d  Obj                          10a                                        Objet
     d  Lib                          10a                                        Bibliothèque
     ?**---Entête d'un User Space---------------------------------------------**
     d GenHeadDs       ds                  based(pUserSpace)
     d  InputSize            113    116b 0                                      Taille de l'entête
     d  HeaderOffset         117    120i 0                                      Offset de l'entête
     d  HeaderSize           121    124i 0                                      Taille de l'entête
     d  ListOffset           125    128b 0                                      Offset des données
     d  ListSize             129    132i 0                                      Taille de la liste
     d  NumberList           133    136b 0                                      Nombre de données
     d  EntrySize            137    140b 0                                      Taille des données
     ?**---Description d'un fichier-------------------------------------------**
     d                 ds                           based(pEntry)
     d FieldName               1     10
     d DataType               11     11
     d Use                    12     12
     d OutBufPos              13     16i 0
     d InBufPos               17     20i 0
     d ByteLeng               21     24i 0
     d Digits                 25     28i 0
     d DecPos                 29     32i 0
     d FieldText              33     82
     d EditCode               83     84
     d EditWordLen            85     88i 0
     d EditWord               89    152
     d ColHead1              153    172
     d ColHead2              173    192
     d ColHead3              193    212
     d IntName               213    222
     d AltName               223    252
     d LenAltFld             253    256i 0
     d NumDBCS               257    260i 0
     d AlwNull               261    261n
     d HostVarInd            262    262n
     d DatTimFmt             263    266
     d DatTimSep             267    267
     d VaryingInd            268    268n
     d fmt             s             10a
     d Format          s             10a
     d FormatName      s              8a
     d i               s              5  0 inz(1)                               Compteur
     d MaxTab          c                   Const(32767)                         Taille Max tableau
     d OverRide        s              1a
     d SpaceAttr       s             10a   inz                                  Attribut du User Spa
     d SpaceAuth       s             10a   inz('*USE')                          Autorisation User Sp
     d SpaceReplc      s             10a   inz('*YES')                          Remplacement du User
     d SpaceLen        s              9b 0 inz(MaxTab)                          Longueur du User Spa
     d SpaceValue      s              1a   inz(X'00')                           Valeur du User Space
     d SpaceText       s             50a   inz('User Space Temporaire')         Libellé User Space
     d StartLen        s              9b 0                                      Longueur dans le Use
     d StartPosit      s              9b 0                                      Position dans le Use
     ?**---Recherche de l'adresse d'un User Space-----------------------------**
     d Qusptrus        Pr                  ExtPgm('QUSPTRUS')
     d  parm                         20a
     d  parm                           *
     ?**---Réception d'un User Space------------------------------------------**
     d Qusrtvus        Pr                  ExtPgm('QUSRTVUS')
     d  parm                         20a
     d  parm                          9b 0
     d  parm                          9b 0
     d  parm                       2000a   Options(*Varsize)
     ?**---Lancement de Commande----------------------------------------------**
     d QCmdExc         Pr                  ExtPgm('QCMDEXC')
     d  parm                        100a                                        Commande
     d  parm                         15  5                                      Longueur de la Cde
      /Free

?      //---Création du fichier ZZ03PF----------------------------------------//
       Requete2 = 'Create table zz03pf (FIC03 CHAR(10), BIB03 CHAR(10), ' +
        'USR03 CHAR(10), TMSP03 TIMESTAMP, FICH03 CHAR(10))';
       Exec Sql execute immediate :requete2;
       Requete2 = 'LABEL ON TABLE zz03pf IS ' +
       '''X-Ref - Liste des Fichiers Historiques''';
       Exec Sql execute immediate :Requete2;

?      //---Récupération paramètres-------------------------------------------//
       DataPlugin = ParamPlug;
       If x_Type = '*FILE';
         Fic = x_Objet;
         Bib = x_Bib;
         Action = *Blanks;
       EndIf;

?      //---Suppression des Tiggers sur le Fichier----------------------------//
       OvrCmd = 'RMVPFTRG FILE(' +  %trim(Bib) + '/' + %Trim(Fic) + ')';
       OvrCmdLen = 100;
       Callp(e) QcmdExc(OvrCmd:OvrCmdLen);
?      //---Suppression Enregistrement dans ZZ03PF----------------------------//
       Requete2= 'Delete from zz03pf where fic03 =''' + Fic + ''' and bib03' +
       ' =''' + bib + '''';
       Exec Sql execute immediate :requete2;

       If Action = *Blanks;
?      //---Nom du fichier historique-----------------------------------------//
         Fic_Log = %trim(Fic) + 'H';

?      //---Creation du fichier Historique------------------------------------//
         Requete2= 'Create table ' + %Trim(Bib)+ '/' + Fic_Log + ' like ' + Fic;
         Exec Sql execute immediate :requete2;
?      //---Ajout des zones Historique----------------------------------------//
         Requete2= 'Alter Table ' + Fic_Log + ' add column TMSP TIMESTAMP not  -
                    null with default';
         Exec Sql execute immediate :requete2;
         Requete2= 'Alter table ' + Fic_Log +' add column usr char(10) not null-
                    with default';
         Exec Sql execute immediate :requete2;
         Requete2= 'Alter table ' + Fic_Log + ' add column Typ char(1) not null-
                    with default';
         Exec Sql execute immediate :requete2;

?      //---Recherche des zones présentes dans le fichier---------------------//
         Obj = Fic;
         Lib = Bib;
?      //---Create User Space-List Fichier------------------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         SpaceLen = MaxTab;
         QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                  SpaceAuth:SpaceText:SpaceReplc:ApiError);
?      //---Liste des formats d'un fichier------------------------------------//
         FormatName = 'RCDL0100';
         OverRide = '1';
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUslRcd(UserSpace:FormatName:Composant:OverRide);
?      //---Retrieve user space General information---------------------------//
         StartPosit = 1;
         StartLen = 1024;
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:GenHeadDs);
?      //---Retrieve user space Detail information----------------------------//
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;
?      //---Lecture de tous les Membres d'un fichier--------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);
         QUsRtvUs(UserSpace:StartPosit:StartLen:fmt);
         StartPosit = StartPosit + StartLen;
?      //---Create User Space-------------------------------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QUsCrtUs(UserSpace:SpaceAttr:SpaceLen:SpaceValue:
                  SpaceAuth:SpaceText:SpaceReplc:ApiError);
?      //---Get the list of all the fields------------------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         OverRide = '1';
         Format  = 'FLDL0100';
         Quslfld(UserSpace:Format:Composant:Fmt:OverRide);
?      //---Get a pointer to the user space containing the list---------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         Qusptrus(UserSpace:pUserSpace);
?      //---Récupération de la liste des zones--------------------------------//
         i = 1;
         pEntry = pUserSpace + listOffset + ((i-1)*entrySize);
         If AltName = *Blanks;
           Lst_Zone = 'o.' + FieldName;
         Else;
           Lst_Zone = 'o.' + AltName;
         EndIf;
         For i = 2 to  NumberList;
           pEntry = pUserSpace + listOffset + ((i-1)*entrySize);
           If AltName = *Blanks;
             Lst_Zone = %Trim(Lst_Zone)+ ',' + 'o.' + FieldName;
           Else;
             Lst_Zone = %Trim(Lst_Zone)+ ',' + 'o.' + AltName;
           EndIf;
         EndFor;
?      //---Suppression du User Space-----------------------------------------//
         SpaceName = 'USERSPACE';
         SpaceLib = 'QTEMP';
         QusDltUs(UserSpace:ApiError);

?      //---Trigger de mise à jour--------------------------------------------//
         Requete2= 'Create Trigger Upd_'+ %Trim(Fic) + '_' + %Trim(Fic_Log) +
         ' after update on ' + %Trim(Bib) + '/' + %Trim(Fic) +
         ' REFERENCING NEW AS o FOR EACH ROW MODE DB2ROW' +
         ' insert into ' + Fic_Log + 'values(' + %trim(Lst_Zone) +
         ', current_timestamp, user, ''U'')';
         Exec Sql Execute immediate :requete2;

?      //---Trigger d'insertion-----------------------------------------------//
         Requete2= 'Create Trigger Ins_'+ %Trim(Fic) + '_' + %Trim(Fic_Log) +
         ' after insert on ' + %Trim(Bib) + '/' + %Trim(Fic) +
         ' REFERENCING NEW AS o FOR EACH ROW MODE DB2ROW' +
         ' insert into ' + Fic_Log + 'values(' + %trim(Lst_Zone) +
         ', current_timestamp, user, ''A'')';
         Exec Sql Execute immediate :requete2;

?      //---Trigger de suppression--------------------------------------------//
         Requete2= 'Create Trigger Dlt_'+ %Trim(Fic) + '_' + %Trim(Fic_Log) +
         ' after Delete on ' + %Trim(Bib) + '/' + %Trim(Fic) +
         ' REFERENCING Old AS o FOR EACH ROW MODE DB2ROW' +
         ' insert into ' + Fic_Log + 'values(' + %trim(Lst_Zone) +
         ', current_timestamp, user, ''D'')';
         Exec Sql Execute immediate :requete2;

?      //---Initialisation du fichier Log-------------------------------------//
         Requete2='INSERT INTO ' + Fic_Log + ' SELECT a.*, current_timestamp,' +
          'user   ,''X'' FROM ' + Fic + ' a';
         Exec Sql Execute immediate :requete2;

?      //---Inscription dans le fichier zz03pf--------------------------------//
         Requete2= 'INSERT INTO ZZ03PF (FIC03, BIB03, USR03, TMSP03, FICH03) ' +
         'VALUES(''' + Fic + ''',''' + bib + ''',''' + user +
         ''', Current_Timestamp ,'''
         + fic_Log + ''')';
         Exec Sql Execute immediate :requete2;
       EndIf;

      /End-Free
     p Arc_Trigg       e

     ?**----------------------------------------------------------------------**
     ?**---Procédure Rec_Avc : Ajout de critère de recherche------------------**
     ?**----------------------------------------------------------------------**
     p Rec_Avc         b

     d Rec_Avc         Pi
     d   ParamPlug                 1024a
     d zz              s                   Like(£Dyna)
      /Free

       ExFmt F14;

       If F14_Des <> ' ';
         For i = 1 to Tab_Inf2('££WRK');
           zz=Tab_Get2('££WRK':i);
           If %scan(%Trim(F14_Des):zz) = 0;
             Tab_Set2('££WRK':i:' ');
           EndIf;
         EndFor;
       EndIf;

       If F14_Out <> 0;
         For i = 1 to Tab_Inf2('££WRK');
           zz=Tab_Get2('££WRK':i);
           If %subst(zz:63:1) <> x'22';
             Tab_Set2('££WRK':i:' ');
           EndIf;
         EndFor;
       EndIf;

       If F14_Lib1 <> ' ';
         For i = 1 to Tab_Inf2('££WRK');
           zz=Tab_Get2('££WRK':i);
           If F14_Dif = 2;
             If %subst(zz:101:10) = F14_Lib1;
               Tab_Set2('££WRK':i:' ');
             EndIf;
             If %subst(zz:101:10) = F14_Lib2;
               Tab_Set2('££WRK':i:' ');
             EndIf;
             If %subst(zz:101:10) = F14_Lib3;
               Tab_Set2('££WRK':i:' ');
             EndIf;
           Else;
             If %subst(zz:101:10) <> F14_Lib1 and F14_Lib1 <> ' ';
               Tab_Set2('££WRK':i:' ');
             EndIf;
             If %subst(zz:101:10) <> F14_Lib2 and F14_Lib2 <> ' ';
               Tab_Set2('££WRK':i:' ');
             EndIf;
             If %subst(zz:101:10) <> F14_Lib3 and F14_Lib3 <> ' ';
               Tab_Set2('££WRK':i:' ');
             EndIf;
           EndIf;
         EndFor;
       EndIf;
       Tab_Tri2('££WRK':12:62);

         Ind_Rappel += 1;
         IndRapWrk = Ind_Rappel;
         Tab_Set('Rappel1':Ind_Rappel:F01Obj);
         Tab_Set('Rappel2':Ind_Rappel:F01Des);
         Tab_Set('Rappel3':Ind_Rappel:F01Bib);
         Tab_Set('Rappel4':Ind_Rappel:F01Typ);
         Tab_Set('Rappel5':Ind_Rappel:ZzFonc);
         Tab_Trf2('££WRK':%Char(Ind_Rappel));

      /End-Free
     p Rec_Avc         e

** ctdata
Recherche avancée
Taille d'une bibliotheque
Nettoyage de PGMREF
Liste des zones d'un fichier dans un programme
Archivage d'un fichier par trigger              ?[Test]
** ctdata
Avec la version v1.9.0, X-Ref devient plus convivial(?!?) se rapproche de la v2 |
encore un peu plus :                                                            |
 - Le système Menu a disparu, très gadget et peu pratique en fin de compte.     |
 - Au niveau ergonomique, le gros changement vient des touches F09 et F10.      |
   A partir de maintenant, chaque analyse est sauvegardée et il est possible de |
   la rappeler à tout moment par la touche F09. La touche F10 permet de faire   |
   défiler les analyses dans l'autre sens. Un compteur a été ajouté afin de     |
   savoir quelle analyse est en cours d'affichage.                              |
 - La touche Home (la flèche qui pointe en haut, à gauche à côté du pavé        |
   numérique) permet de réafficher la fenêtre de sélection du composant si elle |
   avait été affichée au préalable.                                             |
 - Certaines touches de fonction ont été modifiées, voir la liste ci-dessous.   |
 - Lors du choix du composant, l'objet sera recherché dans tout le système.     |
   Si la bibliothèque de l'objet n'existe pas dans la liste, elle sera affichée |
   en violet. Le curseur se positionnera par défaut sur l'objet dont la         |
   bibliothèque existe dans la liste.                                           |
 - XREF peut être appeler sous la forme XREF SHIRLOCK/ZZ01 ou XREF *ALL/ZZ01.   |
                                                                                |
            ?Cf. Ci-dessous pour le détail des modifications.                   |
** ctdata                                                                       |
                               ?Aout     2009                                   |
v1.9.2  : - [F05]  : Ajout Tri par colonne                                      | 07/08/2009
          - [F22]  : La fonction marche à nouveau suite à plusieurs bug         | 13/08/2009
          - [Opt]  : BUG dans la gestion avancée des tableaux                   | 13/08/2009
          - [F04]  : Formattage entête de colonnes                              | 13/08/2009
          - [F08]  : Formattage entête de colonnes                              | 13/08/2009
================================================================================|
                               ?Janvier  2009                                   |
v1.9.1  : - [Opt]  : Correction sortie fichier de la liste de bibliothèques     | 25/11/2008
          - [F08]  : Correction sur le sens du tri                              | 10/12/2008
          - [F24]  : Sortie OUTPUT                                              | 18/12/2008
          - [CMD]  : Appel de X-Ref de la forme XREF *LIBL/ZZ01* *PGM           | 14/01/2009
          - [F05]  : Programme de service supprimé : gestion trop lourde        | 22/06/2009
          - [F05]  : Plugin incorporé dans X-Ref (Utilisation inchangée)        | 22/06/2009
          - [Opt]  : Suppression du lancement de plugin auto au démarrage       | 23/06/2009
          - [F09]  : Bug corrigé lorsque le curseur se trouvait dans le SFL     | 09/07/2009
          - [F14]  : Nom du LF mis à la place du nom du format                  | 15/07/2009
          - [F05]  : Sél. Sup. Fichier en mise à jour et bib. particulière      | 20/07/2009
          - [F05]  : Bug dans la gestion des tableaux dynamiques                | 21/07/2009
          - [F05]  : Ajout Sél. Sup. zone libre                                 | 21/07/2009
          - Optim  : Affichage composant dans bib. connue en premier            | 21/07/2009
          - Bug    : Dsppgmref en automatique ne marchait pas                   | 22/07/2009
          - Optim  : Groupe d'activation nommé à la compil supprimé             | 22/07/2009
          - Optim  : Si composant dans nvelle bib., réf. tech. possible         | 23/07/2009
================================================================================|
                               ?Décembre 2008                                   |
v1.9.0  : - [F16]  : Recherche de sous-routine incorrecte en colonné            | 27/06/2008
          - [F16]  : Sources renseignés par défaut à blanc si pas de composant  | 27/06/2008
          - [F16]  : Suppression de l'affichage persistant après analyse        | 27/06/2008
          - Optim  : Recherche de composant ne se base plus sur Liste de Bib.   | 30/06/2008
          - Optim  : Si Bib. n'existe pas, inverse video et Violet              | 30/06/2008
          - Optim  : Touche Home pour ré-afficher la liste des composants       | 30/06/2008
          - Instl  : Création de ZZ01 sous de programme directement             | 03/07/2008
          - [F02]  : Affichage, Impression et sortie fichier via un tableau     | 04/07/2008
          - [F14]  : Affichage, Impression et sortie fichier via un tableau     | 04/07/2008
          - Bug.   : Tab_Term2 - Nom des tableaux utilisés remis à blanc        | 07/07/2008
          - Optim  : Rech. Composant - Position curseur sur Bib. existante      | 07/07/2008
          - [F07]  : Affichage, Impression et sortie fichier via un tableau     | 07/07/2008
          - [F08]  : Affichage, Impression et sortie fichier via un tableau     | 07/07/2008
          - [F04]  : Affichage, Impression et sortie fichier via un tableau     | 07/07/2008
          - Bug.   : Sortie Fichier de la liste de bibliothèque                 | 07/07/2008
          - Bug.   : Recherche des références sur bibliothèques qui existent    | 07/07/2008
          - [F24]  : Amélioration des données en sortie fichier                 | 07/07/2008
          - [F15]  : Affichage, Impression et sortie fichier via un tableau     | 07/07/2008
          - [F16]  : Affichage, Impression et sortie fichier via un tableau     | 07/07/2008
          - [F24]  : Touche F03 et F12 mieux gérées en cas de problème sur liste| 08/07/2008
          - Optim  : Recherche Description d'un objet améliorée                 | 17/07/2008
          - [F18]  : Affichage, Impression et sortie fichier via un tableau     | 25/07/2008
          - [F19]  : Affichage, Impression et sortie fichier via un tableau     | 25/07/2008
          - [F20]  : Affichage, Impression et sortie fichier via un tableau     | 25/07/2008
          - [F22]  : Affichage, Impression et sortie fichier via un tableau     | 25/07/2008
          - [F23]  : Affichage, Impression et sortie fichier via un tableau     | 25/07/2008
          - [F09]  : Résultat de l'analyse ajouté                               | 28/07/2008
          - [F09]  : Numérotation des analyses en cours                         | 28/07/2008
          - [F10]  : Rappel en avant Mis en place                               | 28/07/2008
          - [F13]  : Suppression de la touche F13                               | 28/07/2008
          - Optim  : Modifications des touches F13, F18, F10 et F11(Cf. Aide)   | 28/07/2008
          - Optim  : Mise à jour Info touches de fonction (Lig. Sup ajoutée)    | 28/07/2008
          - [CMD]  : Appel de XREF par XREF Library/Object à présent            | 28/07/2008
          - Bug    : Affichage du sous-fichier après un F15                     | 28/07/2008
          - Optim  : Suppression des menus-Agrandissement de l'affichage        | 30/07/2008
          - Bug    : *RECDESC et *RECPROC corrigé via la commande               | 31/07/2008
          - Bug    : Recherche Composant si Bib. inconnue                       | 31/07/2008
          - [F07]  : Ajout d'un ~ si zone  de type varchar                      | 01/08/2008
================================================================================|
                               ?Mai 2008                                        |
v1.8.0  : - Batch  : Plantage lors du mode batch dans la routine des erreurs    | 26/11/2007
          - [F22]  : OVRDBF impossible sur certains fichier source              | 28/11/2007
          - [F17]  : Ajout du nom de la zone dans le sous fichier               | 07/12/2007
          - Optim  : Ré-écriture partielle du source                            | 17/01/2007
          - [F24]  : Ajout couleur par type de bibliothèque                     | 05/04/2008
          - Plugin : Ajout du plugin archivage par Trigger                      | 17/04/2008
          - [F02]  : Prise en compte des objets Query                           | 23/04/2008
          - [F14]  : Prise en compte des objets Query                           | 23/04/2008
          - Optim  : Référence croisé des Query                                 | 24/04/2008
          - Optim  : Correction dans recherche composant                        | 17/06/2008
================================================================================|
                             ?Octobre 2007                                      |
v1.7.1  : - Plugin : Nettoyage de PGMREF                                        | 02/08/2007
          - [F08]  : Ajout du nom du fichier physique dont dépend le LF         | 09/08/2007
          - Plugin : Lancement en auto de plugin                                | 09/08/2007
          - Plugin : Nettoyage de PGMREF en auto                                | 10/08/2007
          - [F05]  : Pas de lancement si F12 ou F03                             | 21/09/2007
          - Plugin : En auto ne sont lancer qu'une fois par jour                | 21/09/2007
          - [F22]  : Correction plantage si aucune chaine trouvée               | 26/09/2007
          - Batch  : Travail envoyé dans la jobq QS36EVOKE                      | 27/09/2007
          - Plugin : Analyse zones d'un fichier dans un source                  | 27/09/2007
          - Plugin : Alimentation des informations sources                      | 28/09/2007
          - [F24]  : Affichage des bibliothèques par ordre alphabétique         | 28/09/2007
          - [F17]  : Touche Entrée ne fonctionnait pas                          | 28/09/2007
          - [F20]  : Augmentation de la taille mémoire pour éviter les plantages| 01/10/2007
          - [F08]  : Correction Bug sur Vue SQL                                 | 12/11/2007
================================================================================|
                             ?Juin  2007                                        |
v1.7.0  : - Modification de l'emplacement pour la récupération de QSS1MRI       | 04/05/2007
          - Ajout du nom Interne et du nom Alternatif des zones d'un fichier    | 09/05/2007
          - Correction bug sur F23 lorsque type de composant ='*ALL'            | 25/05/2007
          - Ajout de la touche entrée sur le sous-fichier                       | 28/05/2007
          - Ajout de la fonction F09 rappel d'analyse. Modification de la touche| 28/05/2007
            F09 en F22 pour la recherche de caractère.                          |
          - X-Ref devient mono-module                                           | 29/05/2007
          - Présentation de la description objet modifiée                       | 30/05/2007
          - Amélioration de l'ergonomie de X-Ref avec les touches F09 et Entrée | 31/05/2007
          - Ajout de *PRINTER dans la commande et dans l'écran princpal         | 31/05/2007
          - Sup. de la touche F05 devenue inutile avec la nouvelle ergonomie    | 01/06/2007
          - Mode batch : ajout des paramètres de la v1.6.0 (source et texte)    | 06/06/2007
          - Ajout blocage si bib. de référence non créée                        | 07/06/2007
          - Modification de la gestion de la liste de bibliothèque              | 08/06/2007
          - Lancement des jobs en mode batch de façon HOLD(*YES). Ajout de para-| 12/06/2007
            métrage ultérieur au niveau application. (voir plugin)              |
          - Modification du format de l'impression                              | 13/06/2007
          - Correction pbm affichage sur la fonction where-used                 | 14/06/2007
          - Ajout du système de plugin. Appel dynamique mis en place            | 18/06/2007
================================================================================|
                             ?Avril 2007                                        |
v1.6.0  : - Agrandissement de la largeur du sous-fichier                        | 04/01/2007
          - Ajout de la description du programme dans l'algo programme          | 04/01/2007
          - Bug Cartographie source                                             | 24/01/2007
          - Bug Impression sous fichier                                         | 24/01/2007
          - Ajout OS AS400 dans l'entête                                        | 09/03/2007
          - Amélioration affichage des vues sur un fichier par l'option F08     | 15/03/2007
          - Améliorations routage des modes de traitement                       | 15/03/2007
          - Ajout de la notion fichier source dans la commande                  | 16/03/2007
          - Correction Recherche procédures dans module                         | 21/03/2007
          - Ajout du texte dans la commande pour la recherche F04 et F18        | 21/03/2007
          - Correction bug blocage X-Ref si fonction de la commande est rensei- | 21/03/2007
            gnée                                                                |
          - Correction Bug sur la fonction AlgoPgm si pas d'appel de pgm pour le| 26/03/2007
            composant à analyser                                                |
          - Ajout Libellé sur les fichier ZZ01PF et ZZ01OUT                     | 30/03/2007
          - Ajout de la bibliothèque d'installation dans l'appel de ZZ01T       | 02/04/2007
          - Bibliothèque *CURLIB plus obligatoire pour l'installation           | 03/04/2007
          - Fichier de sortie créé dans le programme à présent via SQL : simpli-| 03/04/2007
            fication de la procédure d'installation                             |
          - Ajout de l'aide en ligne sur la commande XREF                       | 05/04/2007
          - Timestamp du fichier de sortie est correcte à présent.              | 10/04/2007
          - Ajout du gestion d'erreur : affichage d'un message et création d'un | 11/04/2007
            enregistrement dans ZZ01OUT pour analyse par W-Ref.                 |
          - Correction affichage entête de sous-fichier pour la fonction F19    | 11/04/2007
          - Ajout du titre dans l'édition du spoole                             | 20/04/2007
================================================================================|
                             ?Novembre 2006                                     |
v1.5.0  : - Version v1.3.5 annulée                                              |
          - Ajout de la possibilité de créer le fichier PGMREF s'il n'existe pas|
            dans la bibliothèque de Type "R". Création des Index PGMREFx aussi. |
          - Contrôle existence des logiques pour création si nécessaire         |
          - Correction d'un bug sur la cartographie de source                   |
          - Affichage optimisé de la cartographie pour prendre le moins de place|
            possible (Largeur d'une colonne en fonction des données de cette    |
            colonne et non plus en fonction des données de l'ensemble des       |
            données.                                                            |
          - Ajout de la Cartographie ILE d'un objet (module, programme ou pro-  |
            gramme de service.                                                  |
          - Ajout du groupe d'activation XREF dans la compilation de ZZ01 pour  |
            éviter les problèmes d'overflow lors de l'utilisation intensive de  |
            X-Ref. Un RCLACTGRP XREF est alors possible pour "nettoyer" la      |
            mémoire.                                                            |
          - Touche F07 impossible pour les DTAARA. (Merci Véronique).           |
          - Obligation de créer une bibliothèque de chaque type dans la gestion |
            de la liste de bibliothèque lors de l'installation.                 |
          - Contrôle de l'existence d'une bibliothèque de chaque type en modifi-|
            cation de la liste de bibliothèque.                                 |
          - Ajout de la touche F24 pour accèder à la gestion des bibliothèques. |
          - Mise en place de la nouvelle commande Xref :                        |
             - Ajout d'une sortie fichier de l'analyse.                         |
             - Ajout de l'appel de Xref par fonction au niveau de la commande   |
             - Ajout Option "Mode" et "Sortie" : implémentation progressive des |
               différentes fonctionnalités.                                     |
             - Ajout de la fenêtre de gestion des analyses en mode fichier      |
             - Appel de la fenêtre d'analyse par la touche F23                  |
             - Type et bibliothèque de l'objet issus de la commande pris en     |
               compte                                                           |
          - Correction pbm affichage sur description de fichier                 |
          - Ajout de la description de fichier multi-format (PRTF, DSPF, etc...)|
            Merci à Delphine.                                                   |
          - Correction d'un bug sur la recherche de procédure                   |
================================================================================|
                             ?Septembre 2006                                    |
v1.3.4  : - Création index supplémentaire create index <curlib>/pgmref3 on      |
            <curlib>/pgmref (whobjt asc, whpnam asc)                            |
          - Ajout de la touche F05 pour resélectionner un composant à partir de |
            la dernière entrée au clavier.                                      |
          - Ajout du contrôle de la résolution d'écran pour eviter le plantage  |
            habituel.                                                           |
          - Modification de la gestion des bibliothèques et leur mise à jour.   |
            Correction pour la mise à jour des références techniques            |
          - Correction dans l'affichage des clés d'accès d'un LF multiple et a- |
            jout des informations SQL sur les lf sans DDS. Ajout Description.   |
          - Ajout de la touche F19 pour afficher les informations sur le compo- |
            sant. Fonctionnalitée à améliorer.                                  |
          - Fenêtres Aide, A propos et dernières modifications réunies en une   |
            seule fenêtre.                                                      |
          - Stabilisation générale de la gestion des tableaux. Les contrôles    |
            sont plus nombreux et il devrait y avoir moins de plantage.         |
          - Gestion des User Space plus propre (QRPLOBJ moins pollué)           |
          - Effacement du sous-fichier si pas de résultat.                      |
================================================================================|
                             ?Juin 2006                                         |
v1.3.3  : - Modifications de la structure ILE de X-Ref. Les anciens modules sont|
            inclus dans zz01. ZZ01X est le seul module ajouté : il contient la  |
            gestion avancée des modules.                                        |
          - ZZ01X : gestion de tableaux à 9.000.000.000 de postes.Utilisé lors  |
            de la recherche de caractère dans tous les sources (le nombre de    |
            source dépasse facilement les 38.000 sur certains systèmes :D ).    |
          - Optimisation de X-Ref si pgmref est volumineux :                    |
            CREATE INDEX  <curlib>/pgmref1 ON <curlib>/pgmref                   |
            (WHFNAM asc , WHOTYP asc )                                          |
            CREATE INDEX <curlib>/pgmref2 ON <curlib>/pgmref                    |
            (WHSPKG asc ,WHPNAM asc ,WHLIB asc )                                |
          - Ajout de la touche F12=Retour                                       |
                  ?Modifications antérieures supprimées...                      |
** ctdata
[F01]    Aide                                              *HELP
[F02]    XRef : DspPgmRef d'un programme                   *XREF
[F03]    Sortir
[F04]    Recherche par description                         *RECDESC
[F05]    Appel Plugin
[F06]    Lancement d'une requête                           *RUNQRY
[F07]    Description d'un fichier                          *DESCFILE
[F08]    Liste des logiques                                *LSTLF
[F09]    Rappel d'analyse
[F10]    Rappel d'analyse en avant
[F11]    Recherche module utilisant une procedure          *RECPROC
[F12]    Retour
[F13]    Impression du sous-fichier
[F14]    Where Used                                        *WHEREUSED
[F15]    Cartographie d'un programme                       *CARTOPGM
[F16]    Cartographie d'un source                          *CARTOSRC
[F17]    Rechercher une zone dans un fichier               *RECZONE
[F18]    Gestion des Spooles                               *WRKSPLF
[F19]    Description de l'objet                            *DESCOBJ
[F20]    Cartographie I.L.E.                               *CARTOILE
[F21]    Ligne de commande                                 *CMD
[F22]    Recherche de caractères                           *RECCAR
[F23]    Gestion des Analyses                              *ANALYSE
[F24]    Gestion des Bibliothèques                         *LIBRARY
** ctdata
123456789|123456789|123456789|123456789|123456789|123456789|
Objet     Description

Objet     Description


Zone      Description
Fichier    Biblio.  Zone      Format    Description





Objet     Description







Objet     Description


123456789|123456789|123456789|123456789|123456789|123456789|
   Accès          Format    Type        Biblio.    Niveau

Bibliothèque


 Type  Long. D   Deb    Fin  Nom Int.    Nom Alt.
                                Pf-Dta    Biblio.





   Accès          Format    Type        Biblio.    Niveau







  Biblio.     Pf-Src


