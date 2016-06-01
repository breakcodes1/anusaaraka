;This file is intended for finding out the whether the given senstence is a idiom or not. Input is the ids of the words of the 
;sentence and the idioms.gdbm file. Output is the w-x notation of the equivalent hindi meaning of that idiom.  

 (defrule get_eng_word_list			;Defining name for a rule
 (declare (salience 100))			;Declaring the priority level for a rule to be fired

 (id-word ?id ?word)				;Checking root word for a word
 ?f1<-(index ?id)
 ?f<-(English-list $?Eng_list)
 =>
 (retract ?f ?f1)
 (assert (English-list $?Eng_list ?word))	;Meaning is asserted in the final output
 (bind ?id (+ ?id 1))
 (assert (index ?id))
 )


 (defrule chk_for_idiom				;Checking whether a sentence is a idiom or not
 (declare (salience 50))
 ?f<-(English-list $?Eng_list)
 (index ?id)
  =>
  (bind ?len (length $?Eng_list))
  (loop-for-count (?i 1 ?len) 
  	           (bind ?flag 1)
		   (loop-for-count (?j ?i ?len)
		                    (bind ?k (nth$ ?j $?Eng_list))
                                    (if (eq ?flag 1) then
                                    (bind ?str ?k)
 ;                                   (bind $?ids (create$ ?j))
                                    (bind ?flag 0)
                                    else
                                    (bind ?str (str-cat ?str "_" ?k)))
;                                    (bind $?ids (create$ $?ids ?j))
                                    (bind ?lkup (gdbm_lookup "idioms.gdbm" ?str))
                                    (if (neq ?lkup "FALSE") then
                                        ;(printout t ?str -------- ?lkup crlf)
                                         (assert (sen_type-id-phrase idiom ?j (explode$ ?str)))
                                     )))

 )

 (defrule chk_for_idiom1
 ?f<-(sen_type-id-phrase idiom ?j  ?str)
 ?f1<-(sen_type-id-phrase idiom ?j1 ?str1)
 (test (neq ?str ?str1))
 (test (str-index  ?str ?str1))
 =>
  (if (> (length ?str) (length ?str1)) then
  (retract ?f1)
  else 
  (retract ?f)
 )
 )

