#!/bin/bash

code='	#!/bin/bash
	
	code=
	
	function print_code_block
	{
		# x27 is the hex value for single quotes
		printf "\x27"
		echo -n "$code"
		printf "\x27"
	}
	
	# main
	code_no_indent=$(echo "$code" | cut -c 2-)
	echo "$code_no_indent" | head -c 18
	print_code_block
	echo "$code_no_indent" | tail -c 262'

function print_code_block
{
	# x27 is the hex value for single quotes
	printf "\x27"
	echo -n "$code"
	printf "\x27"
}

# main
code_no_indent=$(echo "$code" | cut -c 2-)
echo "$code_no_indent" | head -c 18
print_code_block
echo "$code_no_indent" | tail -c 262
