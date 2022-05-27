
## This script should be used in the base directory of the hugo project
## In bash:
## bash create_abstracts.sh

## Delete previously created track files
rm -rf content/abstracts/track*.md

for i in $(ls data/abstracts/*track*.yaml | sed -e "s|data/abstracts/\(.\+track[0-9]*\)\.yaml$|\1|")
do

    echo Creating page for $i

    title=$(grep -e "title:" data/abstracts/$i.yaml | sed -e "s/title: \"\(.\+\)\"/\1/")
    session_type=$(grep -e "session_type:" data/abstracts/$i.yaml | sed -e "s/session_type: \"\(.\+\)\"/\1/")
    paper=$(grep -e "paper:" data/abstracts/$i.yaml | sed -e "s/paper: \"\(track.\+\)\"/\1/")

    echo title is $title
    echo session_type is $session_type
    echo paper is $paper
    
    echo -e "---
title: \"$title\"
tags: [\"$session_type\"]
type: \"blog\"
draft: false
---

{{< tracks track=\"$paper\">}}

" > content/abstracts/$paper.md 

done
