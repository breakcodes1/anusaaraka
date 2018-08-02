(load "path_for_html.clp")
(bind ?path1 ?*path*)
(bind ?*path* (str-cat ?*path* "/Anu_clp_files/create_eng_ord_html.clp"))
(load ?*path*)
(bind ?mypath1 ?*mypath*)
(bind ?path2 (str-cat ?*mypath* "/tmp/" ?*filename* "_tmp/dir_names.txt"))
(open ?path2  op_fp "r")
(bind ?s_no (readline op_fp))
(bind ?*mypath* (str-cat ?*mypath* "/tmp/" ?*filename* "_tmp/"?s_no"/facts_for_eng_html"))
(close op_fp)
(load-facts ?*mypath*)
(bind ?mypath1 (str-cat ?*filename* "_tmp.html"))
(open ?mypath1 fp "w")
;(watch all)
(run)
(close fp)
(clear)
;-------------------------------------------------------------------------------------
(load "path_for_html.clp")
(bind ?path1 ?*path*)
(bind ?*path* (str-cat ?*path* "/Anu_clp_files/create_hin_ord_html.clp"))
(load ?*path*)
(bind ?mypath1 ?*mypath*)
(bind ?path2 (str-cat ?*mypath* "/tmp/" ?*filename* "_tmp/dir_names.txt"))
(open ?path2  op_fp "r")
(bind ?s_no (readline op_fp))
(bind ?*mypath* (str-cat ?*mypath* "/tmp/" ?*filename* "_tmp/"?s_no"/facts_for_tran_html"))
(close op_fp)
(load-facts ?*mypath*)
(bind ?mypath1 (str-cat ?*filename* "_tran_tmp.html"))
(open ?mypath1 fp "w")
(run)
(close fp)
(exit)
