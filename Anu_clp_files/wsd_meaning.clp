 ;This file is mainly intended for finding out the wsd(Word Sense Disambiguation) meaning of the word whose meaning are not 
 ;defined in the proper noun and compound word dictionaries.Inputs to this file is the id of the word we need to retract meaning
 ;of. Output is the w-x notation of the meaning of the word in hindi. 
 
 (defglobal ?*debug_flag* = TRUE)
 
 (defrule dont_load_chunkids					  ;Defining name for a rule
 (declare (salience 7001))					  ;Declaring the priority level for a rule to be fired
 (root-verbchunk-tam-chunkids ? ? ? $? ?id $? ?root_id)		 
 (not (meaning_has_been_decided ?id))                             ;Declaring that this id's meaning is to be decided 
 ?mng<-(meaning_to_be_decided ?id)
 =>
       (assert (meaning_has_been_decided ?id))			  ;Meaning is asserted in the final output 
       (retract ?mng)
 )
 ;--------------------------------------------------------------------------------------------------------- 
 ;loads user original word file  
 (defrule load_user_org_word_file
 (declare (salience 7000))
 (id-original_word ?id ?word)
 (not (meaning_has_been_decided ?id))
 (not (file_loaded ?id))
 (not (not_SandBox)) ;Added for server purpose. (Suggested by Chaitanya Sir, Added by Roja(05-03-11))
 =>
        (bind ?file (str-cat ?*provisional_wsd_path* "/" ?word ".clp"))
        (if (neq (load* ?file) FALSE) then
            (assert (file_loaded ?id))
       )
 )
 ;---------------------------------------------------------------------------------------------------------
 ; Load user word file
 (defrule load_user_word_file
 (declare (salience 6000))
 (id-word ?id ?word)
 (not (meaning_has_been_decided ?id))
 (not (file_loaded ?id))
 (not (not_SandBox)) ;Added for server purpose. (Suggested by Chaitanya Sir, Added by Roja(05-03-11))
 =>
        (bind ?file (str-cat ?*provisional_wsd_path* "/" ?word ".clp"))
        (if (neq (load* ?file) FALSE) then
            (assert (file_loaded ?id))
       )
 )
 ;---------------------------------------------------------------------------------------------------------
 ;loads user root file
 (defrule load_user_root_file
 (declare (salience 5000))
 (id-root ?id ?root)
 (not (meaning_has_been_decided ?id))
 (not (file_loaded ?id))
 (not (not_SandBox)) ;Added for server purpose. (Suggested by Chaitanya Sir, Added by Roja(05-03-11))
 =>
        (bind ?file (str-cat ?*provisional_wsd_path* "/" ?root ".clp"))
        (if (neq (load* ?file) FALSE) then
            (assert (file_loaded ?id))
       )
 )
 ;---------------------------------------------------------------------------------------------------------
 ;loads original word file 
 (defrule load_org_word_file
 (declare (salience 4000))
 (id-original_word ?id ?word)
 (not (meaning_has_been_decided ?id))
 (not (file_loaded ?id))
 =>
        (bind ?file (str-cat ?*path* "/WSD/wsd_rules/canonical_form_wsd_rules/" ?word ".clp"))
        (if (neq (load* ?file) FALSE) then
            (assert (file_loaded ?id))
       )
 )
 ;---------------------------------------------------------------------------------------------------------
 ; Load word file
 (defrule load_word_file
 (declare (salience 3000))
 (id-word ?id ?word)
 (not (meaning_has_been_decided ?id))
 (not (file_loaded ?id))
 =>
	(bind ?file (str-cat ?*path* "/WSD/wsd_rules/canonical_form_wsd_rules/" ?word ".clp"))        
	(if (neq (load* ?file) FALSE) then
        	(assert (file_loaded ?id))
	)
 )
 ;---------------------------------------------------------------------------------------------------------
 ;loads root file
 (defrule load_root_file
 (declare (salience 2000))
 (id-root ?id ?root)
 (not (meaning_has_been_decided ?id))
 (not (file_loaded ?id))
 =>
        (bind ?file (str-cat ?*path* "/WSD/wsd_rules/canonical_form_wsd_rules/" ?root ".clp"))
        (if (neq (load* ?file) FALSE) then
            (assert (file_loaded ?id))
       )
 )
 ;---------------------------------------------------------------------------------------------------------
;The whole idea of ADVERTISING is to make people buy things .
;(if for a word, word or root file is not present in wsd and has suffix as -ing in other  morph analysis then load the respective root file)
 (defrule suff_ing
 (declare (salience 1000))
 (id-cat_coarse ?id adjective|noun)
 (not (meaning_has_been_decided ?id))
 (id-original_word ?id ?word)
 (or (word-morph (original_word  ?word)(root ?root)(suffix	ing))(word-morph (original_word  ?word)(root ?root)(suffix      en))(word-morph (original_word  ?word)(root ?root)(suffix      ed)))
 (not (file_loaded ?id))
  =>
	(bind ?file (str-cat ?*path* "/WSD/wsd_rules/canonical_form_wsd_rules/" ?root ".clp")	)
        (if (neq (load* ?file) FALSE) then
            (assert (file_loaded ?id))
       	)
 ) 
 ;---------------------------------------------------------------------------------------------------------
 ;Defining a rule lowest salience so that it would be fired in the worst case.
 (defrule end
 (declare (salience -10000))
  =>
        (close wsd_fp)
 )
 ;---------------------------------------------------------------------------------------------------------
