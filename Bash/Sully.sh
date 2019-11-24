#!/bin/bash
i=5
code='if ((!i)) ; then exit 0 ; fi
let "j = i - 1"
file="Sully_$j.sh"
printf "#!/bin/bash\ni=$j\ncode=\\x27" > $file
echo "$code" | head -7 >> $file
printf "\\x27\neval \"\$code\"\n" >> $file
/bin/bash $file
'
eval "$code"
