# www-textools

A collection of TeX-related things. 

To use: download the relevant class (`.cls`) and package (`.sty`) files. You may need to read the source to see what are the dependencies. 

I provide some pre-configured TeX templates (`.tex-template`). 

To include the git version information in your document please see the section on Publishing below. 

Project announcement: https://gitlab.msu.edu/wongwil2/www-textools

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
