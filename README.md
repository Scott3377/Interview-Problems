Longest-Word
============

# Scott Thomas, Interview problem, February 2013
# 
# PROBLEM: Find the longest word in the wordlist (wordlist.txt) that is composed of other words in the list.
# 
# For this problem, I began by reading in the word file and assigning each word as a key in a hash.
# I thought that a hash would be best because of its very efficient selection time O(1) to check
# if a certain word was in the wordlist (assuming no collisions).  I iterated over each character of each 
# word in the word list, and appended the found words to an array which served as the value of the hash 
# whose key was the word.  At the end of each word, I would check to see if the temporary snippet string 
# was empty.  The snippet string would only be empty if it was found as a word from the list and added 
# to the array of words found for that word.  If a clean combination was not found, I would go back 
# and look for longer initial words. Every hash would have a minimum of one match from the word list
# (the word itself) or a clean combination of words (no unmatched characters left over), but only 
# clean combinations would be added to the word_combo_list.
#
# Here are some examples of how this solution is an improvement over a more naive solution that merely finds only the first word. within a word
# 
# WRONG: word_hash["catchall"] => ["cat"] + "chall"
# 
#   		vs.
# 
# CORRECT: word_hash["catchall"] => ["catch","all"]
#
# The proper solution requires a recursive function that calls itself and look for longer prior words. See below for how it works:
# 
# :: CALL check_for_word() FUNCTION ::
# 
# word_hash["catchall"] => "c" + "atchall"
# word_hash["catchall"] => "ca" + "tchall"
# word_hash["catchall"] => ["cat"] + "chall"
# word_hash["catchall"] => ["cat"] + "c" + "hall"
# word_hash["catchall"] => ["cat"] + "ch" + "all"
# word_hash["catchall"] => ["cat"] + "cha" + "ll"
# word_hash["catchall"] => ["cat"] + "chal" + "l"
# word_hash["catchall"] => ["cat"] + "chall"
#
# :: NO WORD FOUND ::
# :: CALL check_for_word() FUNCTION again(popping the last array element off of the stack & passing in the index of the last found word) ::
# 
# word_hash["catchall"] => "catc" + "hall"
# word_hash["catchall"] => ["catch"] + "all"
# word_hash["catchall"] => ["catch"] + "a" + "ll"
# word_hash["catchall"] => ["catch"] + "al" + "l"
# word_hash["catchall"] => ["catch","all"]
# 
# :: BOTH WORDS FOUND ::
#
#
# NOTE: Requires "wordlist.txt" in same directory as program code.
