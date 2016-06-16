# www-textools

A collection of TeX-related things. 

To use: download the relevant class (`.cls`) and package (`.sty`) files. You may need to read the source to see what are the dependencies. 

I provide some pre-configured TeX templates (`.tex-template`). 

To include the git version information in your document please see the section on Publishing below. 

## Publishing

While working on the project, you probably don't need to worry about
versioning information: you can keep track of it using Git. But when
posting pre-prints on your website or on the arXiv, it would be
convenient to keep some version information handy in case of
questions. 

I am assuming you are using the work-flow where each "publication" lives in its own git repo. 

To do so make sure the `.gitattributes` file is downloaded from here. Alternatively edit your local one to include the line `*.tex export-subst`. 

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
