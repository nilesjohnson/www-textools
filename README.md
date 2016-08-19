# www-textools

A collection of TeX-related things.

Author: Willie Wong  https://gitlab.msu.edu/u/wongwil2

To use: download the relevant class (`.cls`) and package (`.sty`) files. You may need to read the source to see what are the dependencies. 

I provide some pre-configured TeX templates (`.tex-template`). 

To include the git version information in your document please see the section on Publishing below. 

Project repo: https://gitlab.msu.edu/wongwil2/www-textools 

Project announcement:
https://plus.google.com/+WillieWong/posts/2SApbdjv6po



## Motivation

Reading long papers can be quite taxing, especially when trying to
keep track of the logical relationships between theorems and lemmata,
or to sometimes even just to remember what "Lemma 3.6.13" said. (No,
you can't remember it, and so you have to flip through half of a 300
page paper to find that lemma.)

Trying to make life slightly easier for future readers of my work
(especially graduate students who will be taking my class next
spring), I've been working on a couple of solutions in tandem.

## Descriptive Referencing

The functionality is quite simple: when calling \label, one adds a
second argument containing a short descriptor of the thing being
labeled. When calling \ref, the description will be printed in the
margin. (There's some intelligence involving not placing the
description more than once per page and other small things.) Currently
it is only available in the form of a special document class since it
only really works when you have ample margin space to work with, and
the standard classes are not good in that regards (with the possible
exception of amsart.)

## New proof environment

The LaTeX code also defines a new proof environment, which can track
the \ref commands used within. This is then used to output auxiliary
data files that store the cross reference logic used in the
proofs.

## Dependency graph

With (not too much) javascript, this data can be displayed as an
interactive graph showing how different parts of the paper fit
together. The link below shows the output from a dummy test
document. Features:

 - Different colors for different "theorem types". 
 - Search function for ease of locating a theorem (this is meant to be
   used together with the book/lecture notes, so we search by labels
   like "Theorem 1.3").
 - Display of the description, and the page number on which the full
   statement can be found.
 - MathJax support! So mathematics included in the short descriptions
   are properly rendered.





## Publishing with Git Version Info

While working on the project, you probably don't need to worry about
versioning information: you can keep track of it using Git. But when
posting pre-prints on your website or on the arXiv, it would be
convenient to keep some version information handy in case of
questions. 

I am assuming you are using the work-flow where each "publication" lives in its own git repo. 

To do so make sure that in your `.gitattributes` file, export subst is enabled for the file `git-version-info.tex`. E.g.  
`git-version-info.tex export-subst`  
Copy the template file `git-version-info.tex-template` to your folder as `git-version-info.tex` and edit it as you wish. 
In the preamble of your main file, make sure to `\input{git-version-info}`. 

Instead of directly posting files from the project to arXiv, use `git
archive`. 

1. First make sure that all the source files required to build the
document is under version control. 
2. `git commit` if you have changes to make. 
3. `git tag <tag>` if you want human-readable tag for the release
info. 
4. And finally  `git archive --format=tar.gz -o mypaper.tar.gz HEAD`
will output a gzipped tarball of your paper with the needed class and
style files, as well as any graphics and such. 
5. Upload `mypaper.tar.gz` to arXiv, and you are done! (Alternatively,
you can unpack it and build the PDF yourself for upload to personal
website.) 

The advantage of building a git archive is that via `.gitattributes`,
`export-subst` is enabled for `.tex` files. If you use this in
conjunction with many of the included tex template files, this will give you
versioning information in the footer of the generated PDFs.

## Copyright

A few of the files in this repo are from third parties (notably `ocg-p.sty` and `ocgx.sty`); those are distributed under the license specified in the source-code. 

Everything else is released in the public domain. 
