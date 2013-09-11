$text = "";

# Read from standard input.
while ($line = <>) { 
	$text .= $line;
}

# Remove all white-spaces.
$text =~ s/\n+//g;

# Insert <s> and </s> to delimit sentences (naïve-method).
$text =~ s/([A-ZÅÄÖ].*?\.)/<s> $1 <\/s>/g;

# Make text lower case.
$text =~ s/(.*)/\L$1/g;

# Remove some punctuations & such.
$text =~ s/[\.,\-_.;]//g;

print $text;