
\NeedsTeXFormat{LaTeX2e}[2016/01/01]
\RequirePackage{expl3}[2016/01/01]
\ProvidesExplClass{jinpingmei}{2016/09/01}{v0}{The Plum in the Golden Vase}

\cs_set_eq:NN \pdfmdfivesum \mdfivesum

\DeclareOption * { \PassOptionsToClass { \CurrentOption } { ctexbook } }
\PassOptionsToClass { openany , linespread = 1.3 , fontset = none } { ctexbook }
\ProcessOptions \scan_stop:
\LoadClass { ctexbook } [ 2016/01/01 ]

\raggedbottom
\int_zero:N \tex_widowpenalty:D
\int_zero:N \tex_clubpenalty:D

\RequirePackage { geometry }

\geometry
  {
    papersize = { 145mm, 210mm }, textwidth = 110mm, lines=30,
    inner = 15mm, top = 20mm, bindingoffset = 5mm,
    headheight = 10mm, headsep = 3\medskipamount , foot = 5mm
  }

\RequirePackage { titleps }
\RequirePackage { zref-base }
\RequirePackage [ mainaux, starttoc ] { rerunfilecheck }
\RequirePackage { hyperref }
\RequirePackage { bookmark }

\tl_const:Nn \c_@@_title_tl  { 金瓶梅 }
\tl_const:Nn \c_@@_author_tl { 蘭陵笑笑生 }

\hypersetup
  {
    hidelinks ,
    hypertexnames      = true ,
    naturalnames       = false ,
    pdfstartview       = XYZ ~ null ~ null ~ 1 ,
    pdfpagemode        = UseNone ,
    pdfpagelayout      = TwoPageRight ,
    pdfprintscaling    = None ,
    pdfdisplaydoctitle = true ,
    pdfinfo            =
      {
        Title   = \c_@@_title_tl ,
        Author  = \c_@@_author_tl ,
        Creator = XeLaTeX ~ + ~ xeCJK ~ + ~ CTeX ,
      } ,
  }

\bookmarksetup { numbered = true }
\ctexset { contentsname = 目錄 }
\setmainfont { Linux ~ Biolinum ~ O }
\cs_if_exist:NTF \xeCJKsetup
  {
    \xeCJKsetup
      {
        AllowBreakBetweenPuncts = true ,
        CheckSingle             = true ,
        AutoFakeBold            = false ,
        AutoFakeSlant           = false ,
      }
    \xeCJKDeclareSubCJKBlock { Ext } { "20000 -> "2CEA1 }
  }
  { \ctexset { declarecharrange = { Ext } { "20000 -> "2CEA1 } } }
\defaultCJKfontfeatures { Script = CJK }
\setCJKmainfont [ ItalicFont = DFPKaiShuW3-B5 ,
                  BoldFont = DFPNMingXBold-B5 ] { DFPMingLight-B5 }
\setCJKsansfont [ BoldFont = DFPNHeiXBold-B5 ]  { DFPHeiMedium-B5 }
\setCJKmonofont [ BoldFont = DFPFangSongW6-B5 ] { DFPFangSongW4-B5 }
\setCJKmainfont [ Ext , ItalicFont = FZKaiT-Extended(SIP) ] { PMingLiU-ExtB }
\group_begin:
  \tl_clear:N \l_tmpa_tl
  \int_step_inline:nnnn { 1 } { 1 } { 9 }
    { \tl_put_right:Nn \l_tmpa_tl { \include { tex / 00 #1 } } }
  \int_step_inline:nnnn { 10 } { 1 } { 99 }
    { \tl_put_right:Nn \l_tmpa_tl { \include { tex / 0 #1 } } }
  \int_step_inline:nnnn { 100 } { 1 } { 100 }
    { \tl_put_right:Nn \l_tmpa_tl { \include { tex / #1 } } }
  \cs_new_protected_nopar:Npx \INCLUDEMAINTEXT
    { \exp_not:o { \l_tmpa_tl } }
\group_end:
\ctex_patch_cmd:Nnn \cleardoublepage
  { \newpage }
  { \thispagestyle { empty } \newpage }
\RenewDocumentCommand \frontmatter { }
  {
    \cleardoublepage
    \@mainmatterfalse
    \ctexset { chapter/numbering = false }
    \pagestyle { front }
    \pagenumbering { Roman }
  }
\RenewDocumentCommand \mainmatter { }
  {
    \cleardoublepage
    \@mainmattertrue
    \ctexset { chapter/numbering = true }
    \pagestyle { main }
    \pagenumbering { arabic }
  }
\newpagestyle { front } [ \small ]
  {
    \sethead [ \quad \itshape \arabic { page } ] [ \ziju { 1 } \c_@@_title_tl ] [ ]
             { } { \ziju { 1 } \chaptertitle } { \itshape \arabic { page } \quad }
    \cs_set_eq:NN \makeheadrule \@@_head_rule:
  }
\newpagestyle { main } [ \small ]
  {
    \sethead [ \quad \thepage ] [ \ziju { 1 } \c_@@_title_tl ] [ \CTEXthechapter ]
             { \chaptertitle } { } { \thepage \quad }
    \cs_set_eq:NN \makeheadrule \@@_head_rule:
  }
\cs_new_protected_nopar:Npn \@@_head_rule:
  { \box_use:N \l_@@_head_rule_box }
\box_new:N \l_@@_head_rule_box
\vbox_set_top:Nn \l_@@_head_rule_box
  {
    \skip_vertical:N \medskipamount
    \tex_hrule:D width \textwidth depth .5pt height \c_zero_dim \scan_stop:
  }
\pagestyle { main }
\ctexset
  {
    chapter = {
      pagestyle   = empty ,
      fixskip     = true ,
      name        = { 第 , 回 } ,
      format      = \bfseries \Large ,
      nameformat  = \@@_name_format:n ,
      aftername   = \par \nointerlineskip \@@_head_rule:
                    \par \skip_vertical:N \bigskipamount ,
      titleformat = \@@_title_box:n ,
      beforeskip  = \bigskipamount ,
      afterskip   = \baselineskip + \bigskipamount ,
    }
  }
\cs_new_protected:Npn \@@_name_format:n #1
  { \@@_fill_outer: #1 \par }
\cs_new_protected:Npn \@@_title_box:n #1
  {
    \bool_if:NTF \CTEX@chapter@numbering
      {
        \seq_set_split:Nnn \l_tmpa_seq { ^^^^3000 } {#1}
        \@@_fill_inner:
        \seq_use:Nn \l_tmpa_seq { \\ }
      }
      { \centering \ziju { 1 } #1 }
  }
\cs_new_protected:Npn \@@_fill_inner:
  {
    \int_if_odd:nTF { \value { page } }
      { \raggedleft }
      { \raggedright }
  }
\cs_new_protected:Npn  \@@_fill_outer:
  {
    \int_if_odd:nTF { \value { page } }
      { \raggedright }
      { \raggedleft }
  }
\cs_new_eq:NN \jinpingmei@saved@contentsline \contentsline
\RenewDocumentCommand \contentsline { m }
  {
    \cs_if_exist_use:cF { toc@label@#1 }
      { \jinpingmei@saved@contentsline {#1} }
  }
\cs_new_protected:Npn \toc@label@chapter
  {
    \int_compare:nNnTF { \value { tocdepth } } > \c_minus_one
      { \@@_toc_chapter:nnn }
      { \use_none:nnn }
  }
\cs_new_protected:Npn \@@_toc_chapter:nnn #1
  { \@@_toc_chapter_aux:w #1 \q_stop }
\cs_new_protected:Npn \@@_toc_chapter_aux:w \numberline #1 #2 ^^^^3000 #3 \q_stop
  { \@@_toc_chapter:nnnnn {#1} {#2} {#3} }
\cs_new_protected:Npn \@@_toc_chapter:nnnnn #1#2#3#4#5
  {
    \nointerlineskip
    \addvspace { \skip_eval:n { \medskipamount + \smallskipamount } }
    \group_begin:
      \tex_noindent:D
      \@@_toc_label:nn {#1} {#5}
      \ensuremath
        {
          \tex_vcenter:D
            {
              \ttfamily
              \hbox:n { \@@_hyper_link:nn {#5} {#2} }
              \nointerlineskip \skip_vertical:N \medskipamount
              \hbox:n { \@@_hyper_link:nn {#5} {#3} }
            }
        }
      \@@_cdot_fill:
      \@@_hyper_link:nn {#5} {#4} \par
    \group_end:
  }
\cs_new_protected_nopar:Npn \@@_cdot_fill:
  { \tex_leaders:D \box_use:N \l_@@_cdot_box \tex_hfill:D }
\box_new:N \l_@@_cdot_box
\hbox_set_to_wd:Nnn \l_@@_cdot_box { 8pt }
  { \tex_hss:D \textcdot \tex_hss:D }
\cs_new_protected_nopar:Npn \@@_hyper_link:nn
  { \hyper@link { link } }
\cs_new_protected:Npn \@@_toc_label:nn #1#2
  {
    \dim_set:Nn \l_tmpa_dim
      { \zref@extractdefault {#2} { label@width } { \c_zero_dim } }
    \hbox_set:Nn \l_tmpa_box
      {
        \cs_set_eq:NN \CJKglue \tex_hfill:D
        \@@_hyper_link:nn {#2} { #1 \tex_unskip:D }
      }
    \dim_compare:nNnTF \l_tmpa_dim > \c_zero_dim
      { \hbox_to_wd:nn { \l_tmpa_dim } { \hbox_unpack:N \l_tmpa_box } }
      { \box_use:N \l_tmpa_box }
    \seq_gput_right:Nx \g_@@_toc_seq { \dim_eval:n { \box_wd:N \l_tmpa_box } }
    \int_gincr:N \g_@@_toc_int
    \@@_toc_mark:n { \int_use:N \g_@@_toc_int }
    \zref@labelbylist {#2} { toc@label }
    \quad
  }
\int_new:N \g_@@_toc_int
\seq_new:N \g_@@_toc_seq
\cs_new_protected:Npn \@@_toc_mark:n #1
  { \etex_marks:D \g_@@_toc_label_mark {#1} }
\RenewDocumentCommand \tableofcontents { }
  {
    \group_begin:
      \ctexset
        {
          chapter/aftertitle+ = {
            \chaptermark { \contentsname }
            \bookmark [ level = chapter , dest = \@currentHref ] { \contentsname }
          }
        }
      \chapter * { \contentsname }
      \AtBeginShipout { \@@_set_toc_label_width: }
      \@starttoc { toc }
      \AtBeginShipoutNext { \tl_gclear:N \@@_set_toc_label_width: }
    \group_end:
  }
\cs_new_protected_nopar:Npn \@@_set_toc_label_width:
  {
    \str_if_eq_x:nnF
      { \etex_topmarks:D \g_@@_toc_label_mark }
      { \etex_firstmarks:D \g_@@_toc_label_mark }
      { \@@_set_toc_label_width_aux: }
  }
\cs_new_protected_nopar:Npn \@@_set_toc_label_width_aux:
  {
    \tl_gset:Nn \g_@@_toc_label_width_tl { 0pt }
    \int_step_inline:nnnn
      { \etex_firstmarks:D \g_@@_toc_label_mark }
      { 1 }
      { \etex_botmarks:D \g_@@_toc_label_mark }
      {
        \seq_gpop_left:NNTF \g_@@_toc_seq \l_tmpa_tl
          {
            \tl_gset:Nx \g_@@_toc_label_width_tl
              { \dim_max:nn { \g_@@_toc_label_width_tl } { \l_tmpa_tl } }
          }
          { \BOOM }
      }
  }
\newmarks \g_@@_toc_label_mark
\tl_new:N \g_@@_toc_label_width_tl
\zref@newprop * { label@width } [ 0pt ] { \g_@@_toc_label_width_tl }
\zref@newlist { toc@label }
\zref@addprop { toc@label } { label@width }
\RenewDocumentEnvironment { quote } { }
  {
    \list { }
      {
        \skip_zero:N \partopsep
        \skip_zero:N \topsep
        \skip_set_eq:NN \parsep \parskip
        \dim_zero:N \rightmargin
        \dim_set_eq:NN \leftmargin \parindent
        \dim_set_eq:NN \listparindent \parindent
        \dim_set_eq:NN \itemindent \listparindent
      }
    \itshape
    \item \scan_stop:
    \obeylines
  }
  { \endlist }
\cs_if_exist:NTF \xeCJK_make_node:n
  {
    \cs_new_protected_nopar:Npn \@@_ccglue:
      { \CJKglue }
    \cs_new_protected_nopar:Npn \@@_make_node:
      { \xeCJK_make_node:n { CJK } }
  }
  {
    \cs_new_protected_nopar:Npn \@@_ccglue:
      {  \skip_horizontal:n { \ltjgetparameter { kanjiskip } } }
    \cs_new_protected_nopar:Npn \@@_make_node:
      { }
  }
\NewDocumentCommand \textcombine { m }
  {
    \prop_get:NnNTF \g_@@_combine_prop {#1} \l_tmpa_tl
      {
        \mode_if_vertical:TF
          { \tex_indent:D } { \@@_ccglue: }
        \tl_use:N \l_tmpa_tl
        \@@_make_node:
      }
      { 〔 \hbox:n {#1} 〕 }
  }
\prop_new:N \g_@@_combine_prop
\prop_gput:Nnn \g_@@_combine_prop { 釒夏 }
  { \@@_combine:nnnn { 釗 } { 夏 } { .5 } { .6 } }
\prop_gput:Nnn \g_@@_combine_prop { 飠 皆 }
  { \@@_combine:nnnn { 餇 } { 皆 } { .55 } { .6 } }
\prop_gput:Nnn \g_@@_combine_prop { 飠禾 }
  { \@@_combine:nnnn { 餇 } { 禾 } { .55 } { .6 } }
\prop_gput:Nnn \g_@@_combine_prop { 糹堂 }
  { \@@_combine:nnnn { 細 } { 堂 } { .6 } { .65 } }
\prop_gput:Nnn \g_@@_combine_prop { 扌闔 }
  { \@@_combine:nnnn { 扣 } { 闔 } { .6 } { .65 } }
\prop_gput:Nnn \g_@@_combine_prop { 禾邑 }
  { \@@_combine:nnnn { 种 } { 邑 } { .6 } { .65 } }
\prop_gput:Nnn \g_@@_combine_prop { 石店 }
  { \@@_combine:nnnn { 砷 } { 店 } { .6 } { .7 } }
\prop_gput:Nnn \g_@@_combine_prop { 石否 }
  { \@@_combine:nnnn { 砷 } { 否 } { .6 } { .7 } }
\prop_gput:Nnn \g_@@_combine_prop { 火夸 }
  { \@@_combine:nnnn { 灿 } { 夸 } { .6 } { .7 } }
\cs_new_protected_nopar:Npn \@@_combine:nnnn #1#2#3#4
  {
    \hbox_to_wd:nn { \f@size pt }
      {
        \hbox_set:Nn \l_tmpa_box {#1}
        \box_trim:Nnnnn \l_tmpa_box
          { 0pt } { 0pt } { #3 \box_wd:N \l_tmpa_box } { 0pt }
        \box_clip:N \l_tmpa_box
        \box_use:N \l_tmpa_box
        \tex_hss:D
        \hbox_set:Nn \l_tmpa_box {#2}
        \box_scale:Nnn \l_tmpa_box {#4} { 1 }
        \box_use:N \l_tmpa_box
      }
  }
