$text = "";

# Read from standard input.
while ($line = <>) { 
   $text .= $line;
}

# Extract words separated by blankspace(s).
@words = split(/ +/, $text);

# Total number of words.
$word_count = $#words;

@sentence = ("<s>", "det", "var", "en", "gång", "en", "katt", "som", "hette", "nils", "</s>");

# Create bigrams from words and calculate their frequency.
$frequency_words{$words[0]}++;
for ($i = 0; $i < $word_count; $i++) {
	$bigram = $words[$i] . " " . $words[$i + 1];
	$bigrams[$i] = $bigram;
	$frequency_bigrams{$bigram}++;
	$frequency_words{$words[$i + 1]}++;
}

# Sentence probabilities using unigrams.
$sentence_probability = 1;
for ($i = 1; $i <= $#sentence; $i++) {
	$sentence_word = $sentence[$i];
	$sentence_word_frequency = $frequency_words{$sentence_word};
	$word_probability = $sentence_word_frequency / $word_count;
	$sentence_probability *= $word_probability;
	print $sentence_word .
		"\t" . $sentence_word_frequency . 
		"\t" . $word_count .
		"\t" . $word_probability .
		"\n";
}
print "Sentence probability: " . $sentence_probability . ".\n";

# Sentence probabilities using bigrams.
$sentence_probability = 1;
for ($i = 0; $i < $#sentence; $i++) {
	$sentence_bigram = $sentence[$i] . " " . $sentence[$i + 1];
	$sentence_bigram_frequency = $frequency_bigrams{$sentence_bigram};
	$sentence_word_frequency = $frequency_words{$sentence[$i]};
	if ($sentence_bigram_frequency == 0) {
		$bigram_probability = $frequency_words{$sentence[$i + 1]} / $word_count;
	} else {
		$bigram_probability = $sentence_bigram_frequency / $sentence_word_frequency;
	}
	
	$sentence_probability *= $bigram_probability;

	print $sentence_bigram .
		"\t\t" . $sentence_bigram_frequency . 
		"\t" . $sentence_word_frequency .
		"\t" . $bigram_probability .
		"\n";
}
print "Sentence probability: " . $sentence_probability . ".\n";