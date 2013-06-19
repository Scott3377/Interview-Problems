# CONSTANT
WORD_FILE = "wordlist.txt"

word_combo_list = []							# Holds list of concatenated words
$word_hash = Hash.new()							# Hash containing words in list as key, array of inner words as values
$key_length = 0								# Cache variable for key length

File.open(WORD_FILE, "r") do |f|					# Iterate through file and add words to hash
	f.each_line do |word|
		word.chomp!
		if !word.empty?
			$word_hash[word] = []
		end
	end
end

# Method that loops through word looking for word combinations
def check_for_word(word, snippet = "", rest_of_word = "")
	if rest_of_word.empty?						# If initial run, rest_of_word = original word
		rest_of_word = word
	end

	rest_of_word.split("").each do |char|				# Look for words within latter part of string
		snippet += char						# Append next character from rest_of_string to snippet
		if $word_hash.has_key?(snippet)				# If inner word found in list of words
			$word_hash[word] << snippet			# Append snippet to found words array
			snippet = ""					# Reset snippet
		end
	end
	
	if !snippet.empty?						# No clean combo. Try for longer root words
		rest_of_word = word.dup
		rest_of_word.slice! $word_hash[word].join		# rest of word = original word without found words
		snippet = $word_hash[word].pop()			# snippet = last found word
		check_for_word(word, snippet, rest_of_word)		# Call method again and look for longer words
	end

	return $word_hash[word].last.length != $key_length		# If word combo was pure combo of other words (& not word itself)
end

# MAIN PROGRAM
$word_hash.keys.each do |key|						# Loop through list of words in list (keys in hash)
	$key_length = key.length					# Cache key length
	no_extra_letters = check_for_word(key)				# Look for clean word combo (no extra letters left over)
	if no_extra_letters						# If clean combo and has more matches than just the original word, append to combo list
		word_combo_list << key
	end
end

# LOG
word_combo_list.sort!{|x,y| y.length <=> x.length }
puts "Number of words containing other words: " + word_combo_list.size.to_s
puts "The two longest words found were: \n1) " + word_combo_list[0] + "\n2) " + word_combo_list[1]
