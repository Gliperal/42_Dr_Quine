#!/bin/bash
quine='echo "#!/bin/bash"
printf "quine=\\x27"
echo "$quine" | head -7
printf "\\x27\n"
printf "code=\\x27eval \"\$quine\" > Grace_kid.sh\\x27\n"
echo foo=bar \# comment
echo eval \"\$code\"
'
code='eval "$quine" > Grace_kid.sh'
foo=bar # comment
eval "$code"
