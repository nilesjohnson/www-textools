## TeX templates

### Description

Here we collect template starter directory for writing TeX projects.
Included here are

- custom TeX class files (`.cls`) 
- custom TeX packages (`.sty`)
- pre-configured TeX templates (`.tex-template`)

The reason that the class and package files are included is because
they are not publicly available on CTAN (and I don't intend them to
be), so when changing computers or collaborating it is a hassle to
remember to copy the relevant class and style files from "out of the
tree". 

Furthermore, by including the files in the templates here I don't have
to worry about backward compatibility since modifying the class files
will not affect finished projects. 

I included pre-configured TeX templates to include export-subst
compatible strings to use with the class files. The class files can
still be used without such configuration, of course; this however
provides a way to mark archival copies with their git commit
information. (The reason that the templates are named `.tex-template`
is to prevent export-subst from acting on the archive downloads from
_this_ repository.)

### Use

#### Instantiation

On local machine (downloads the current version of the template
without cloning the history):   
```console
mkdir <project name>
cd <project name>
git archive --format=tar --remote=https://gitlab.com/wwywong/TeX-template.git HEAD | tar xf -
git init
```
Then you can delete all the unused template files (and class/style
files if you know what you are doing) and just rename the
one you want to use  
```console
mv Templates/template-article.tex-template myarticle.tex
rm -rf Templates
git add *
git commit -m "Setup the project directory"
```
and you are good to go. 

#### Publishing

While working on the project, you probably don't need to worry about
versioning information: you can keep track of it using Git. But when
posting pre-prints on your website or on the arXiv, it would be
convenient to keep some version information handy in case of
questions. 

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
