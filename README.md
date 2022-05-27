# Bioconductor conference template web site

This repository contains material for the Bioconductor annual conference. View example at https://bioc2022.bioconductor.org/ and the corresponding [GitHub repo](https://github.com/Bioconductor/BioC2022)

1. Make sure [Hugo is installed](https://gohugo.io/getting-started/installing/). Check hugo version

```shell
hugo version
```

2. Clone the repository and switch to it

```shell
git clone git@github.com:Bioconductor/BioC2022.git
cd BioC2022/
```

3. Run hugo

```shell
rm -rf public; hugo --verbose; hugo server --disableFastRender --verbose
```

and view the results at http://localhost:1313/

4. Host your site on [Netlify](https://www.netlify.com/), as described [here](https://bookdown.org/yihui/blogdown/netlify.html). Use build command `hugo`, publish directory `public`, and set advanced variable `HUGO_VERSION` to your `hugo version` number, e.g., 0.76.5

Created using modified [hugo-universal-theme](https://github.com/devcows/hugo-universal-theme). See the [demo web site](https://themes.gohugo.io/theme/hugo-universal-theme/), the original [github repository](https://github.com/devcows/hugo-universal-theme) and the [exampleSite files](https://github.com/devcows/hugo-universal-theme/tree/master/exampleSite). Template by [Bootstrapious](https://bootstrapious.com/p/universal-business-e-commerce-template). Ported to Hugo by [DevCows](https://github.com/devcows/hugo-universal-theme). The theme is added as selected files, not as a submodule, for easier modification.

# ToDo/Help wanted

- Make schedule as a partial, populated from `config.toml`. Example - [hugo-conference](https://themes.gohugo.io/hugo-conference/) theme.

## New template

[gdg-x/zeppelin](https://github.com/gdg-x/zeppelin) - original conference template, [GDG DevFest](http://gdg-x.github.io/zeppelin/) - demo web site. [bcc2020/bcc2020.github.io](https://github.com/bcc2020/bcc2020.github.io) - modified conference template for the [BCC2020](https://bcc2020.github.io/) conference



# Adding papers for the the schedule

+ The only place where we should be adding data for the abstracts and other
elements for the schedule table is `data/abstracts/`.

+ The `content/abstracts/` directory contains the individual pages for the
abstracts. This directory could be ignored as it will be updated with
the `create_abstracts.sh` and `create_tracks.sh` bash scripts. These scripts
convert the elements in data to content pages.

+ There are three types of abstracts

general format: day[1-3]_HHMM_type_paper/track#.yaml

1. papers. Name format: day1_1315_longWorkshop_paper25.yaml. 
2. tracks. Name format: day1_0900_shortTalksSysEpi_track.yaml.
3. All other elements that will be added to the schedule.

+ The abstracts should all contain these fields: 

```
title: ""
paper: ""
session_type: ""
authors: ""
presenting_author: ""
affiliation: ""
abstract: ""
time: ""
github: ""
time: 
twitter: ""
youtube: ""
day: ""
talks: ""
```
+ If any field isn't used, it should remain blank.

+ This is the explanation of the fields:

1. title - A string witht he full titlte.
2. paper - number of paper or track. Valid options: paper# or track#.
For example, paper2, track1, etc. track is only used for the short talks tracks.
There is not defined track number as in the case of the papers, so I'm just
adding in order of appearnce in the document shared by Erica.
3. session_type: String with the type. Valid options: "Short talk",
"Short talks track", "Package demo", "Workshop".
4. authors: string with the authors separated by comma.
5. presenting_author: author who will present. I'm using the first author.
6. affiliation: string with the affiliation.
7. abstract: string with the abstract. sometimes there are quotes in the text,
which should be escaped.
8. github. Haven't used this field. Not sure if this has been provided.
9. twitter - twitter handle without the @.
10. youtube - link to youtube video when available.
11. day - valid options: day1, day2, day3.
12. talks - this field is only for the short talk tracks. this should list
the number of the papers under this track. This should be a yaml array.
Example: ["paper10", "paper20"]
14. time - the time in 24h format. Example: 1300 for 1 PM.
15. Run the scripts to create the abstracs and tracks files:
```
## in base driectory
bash create_abstracts.sh
bash create_tracks.sh
```

# Instructions on how to use Rmarkdown code to auto-generate yaml files

* Download the Rmarkdown filee - 01-create-yaml.Rmd in the base Github folder. It also includes a built PDF and HTML for easy viewing of the code. 
* Make sure the input file is up to date. Link to the google sheet is here: https://docs.google.com/spreadsheets/d/1tGtGffcbCRxQFjE3ej42IcWlN4FJCsuQeZvETt9g0oA/edit#gid=0
* Once data is updated, export this file as TSV into your computer. Save this file in a folder called "input" 
* NOTE - For the "time" column, set format to custom "hh:mm" (IMPORTANT)
* Run the code
* Output files are generated in the "yaml_output" folder 



