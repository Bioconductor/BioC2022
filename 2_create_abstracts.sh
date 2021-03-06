
## This script should be used in the base directory of the hugo project
## In bash:
## bash create_abstracts.sh


## Delete previously created abstracts
rm -rf content/abstracts/paper*.md

for i in $(ls data/abstracts/*paper*yaml | sed -e "s|data/abstracts/\(.\+paper.\+\)\.yaml$|\1|")
do

    echo Creating abstract page for $i

    title=$(grep -e "title" data/abstracts/$i.yaml | sed -e "s/title: \"\(.\+\)\"/\1/")
    session_type=$(grep -e "session_type" data/abstracts/$i.yaml | sed -e "s/session_type: \"\(.\+\)\"/\1/")
    paper=$(grep -e "paper" data/abstracts/$i.yaml | sed -e "s/paper: \"\(paper.\+\)\"/\1/")
    
    echo -e "---
title: \"$title\"
tags: [\"$session_type\"]
type: \"blog\"
draft: false
---

{{< abstracts paper=\"$paper\">}}

" > content/abstracts/$paper.md 

done
