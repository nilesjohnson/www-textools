%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  wwwnotes2 class by Willie W-Y Wong     
%%%%  For usage see template file
%%%%
%%%%  Currently the style has predefined the following theorems:
%%%%    thm, prop, lem, cor, defn, conv, rmk, exa, exer,
%%%%    conj, quest, proof, pfof, thot
%%%%  Extended referencing commands:
%%%%    \ref, \eqref, \thref
%%%%  Descriptive labelling commands:
%%%%    \desclabel, \descthref, \desceqref, \descref
%%%%  Note, the descriptive labelling commands also writes to the *-xrf.csv files 
%%%%    when used in conjunction with the pfof environments. This allows data
%%%$    to be recorded for generating dependency trees between theorems. 
%%%%  Margin note command:
%%%%    \marginnote
%%%%  One should only use \chapter and \section, and optionally \part for 
%%%%    sectioning. Don't use \subsection! That's too many levels down, as 
%%%%    Tufte would say. 


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wwwnotes2}
	[2016/01/20 v0.6 Willie Wai Yeung Wong Notes class]

\LoadClass[10pt,titlepage,leqno,openright,twoside]{report}

\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}

\RequirePackage{ifthen}

\RequirePackage{geometry}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{everypage}
\RequirePackage{etoolbox}
\RequirePackage{newfile}
\RequirePackage{emarks}
\RequirePackage{marginfix}
\RequirePackage{titling}

\RequirePackage{enumitem}
\RequirePackage{index}
\RequirePackage{url}
\RequirePackage[backend=biber,style=reading,entrykey=false,abstract=false,library=false,file=false,maxnames=10]{biblatex}


\RequirePackage[oldstylenums,narrowiints,intlimits,sumlimits,noDcommand]{kpfonts}
\RequirePackage[protrusion,babel]{microtype}


\RequirePackage{mathtools}
\RequirePackage[ntheorem]{empheq}
\RequirePackage[amsmath,thmmarks,thref,hyperref]{ntheorem}

\RequirePackage[colorlinks=false]{hyperref}

%% Geometry (geometry)
\geometry{papersize={7.4in,9.5in},includemp=true,marginparwidth=1.44in,width=6.1in,bindingoffset=0.2in,twoside,hmarginratio={2:1},vmarginratio={3:4},headheight=14pt,headsep=0.2in,footskip=0.5in}

%% Git backup (gracefully degrades if user doesn't use Git)
\newcommand*\gitShortHash{(git not used)}
\newcommand*\GitPageFooter{(version info not available)}

%% Title Page (titling)[hyperref]
\newcommand*\thesubtitle{}
\newcommand*\subtitle[1]{\renewcommand*\thesubtitle{#1}}
\let\oldtitle\title
\newcommand*\thetitletext{}
\renewcommand*\title[1]{\renewcommand*\thetitletext{#1}\oldtitle{#1}}
\pretitle{\begin{flushleft}\Huge \bfseries \scshape}
\posttitle{\par\end{flushleft}\begin{flushleft}\Large \thesubtitle\end{flushleft} \vfill}
\preauthor{\begin{flushright}\LARGE}
\postauthor{\par\end{flushright}%
	\hypersetup{pdfauthor={\theauthor},pdftitle={\thetitle},%
	pdfsubject={Mathematics}}%
	\vskip 1.5in}
\predate{\begin{center}\footnotesize Revision based on commit \texttt{\gitShortHash{}} as of }
\postdate{\par\end{center}}
\setlength{\droptitle}{0.5in}

%% Headers and Footers (titlesec,emarks)
\widenhead*{0.1in}{0.45in}
\newcommand*\www@show@marks{%
	\ifmarksequal{\topmarks}{\botmarks}{www@stuff@mark}{(Prev. ref. \thefirstmarks{www@stuff@mark})}{%
	\ifmarksequal{\firstmarks}{\botmarks}{www@stuff@mark}{Ref. \thefirstmarks{www@stuff@mark}}{%
	Refs. \thefirstmarks{www@stuff@mark}--\thebotmarks{www@stuff@mark}}}}
\newpagestyle{wwwfancy}{\headrule%
	\sethead[\footnotesize\slshape\www@show@marks]%
		[][\footnotesize\slshape\thetitletext]%
		{\footnotesize\slshape\thesubtitle}{}%
		{\footnotesize\slshape\www@show@marks}%
	\setfoot[\tiny \copyright~\theauthor][\thepage][]{}{\thepage}{\tiny \GitPageFooter}}
\pagestyle{wwwfancy}

%Redefine refstepcounter to throw things into the marks
\let\www@old@refstepcounter\refstepcounter
\def\refstepcounter#1{%
	\www@old@refstepcounter{#1}%
	\ifthenelse{\equal{#1}{equation}}{\marksthecs{www@stuff@mark}{theequation}}{}%
	\ifthenelse{\equal{#1}{chapter}}{\marksthecs{www@stuff@mark}{theequation}}{}}


% To make the clear page completely empty, with no header or footer
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else\hbox{}
	%\vspace*{\fill}
	%\begin{center}
	%   This page intentially blank.
	%\end{center}
	%\vspace{\fill}
	\thispagestyle{empty}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%% Section/Chapter titles (titlesec)
\setcounter{secnumdepth}{0}
\setcounter{tocdepth}{1}
\titleformat{\part}[display]{\bfseries\huge}%
	{\filcenter\partname\ \thepart}{0.4in}%
	{\filcenter\Huge}[\thispagestyle{empty}]
\titleformat{\chapter}[display]{\bfseries\Large}%
	{\filleft\chaptertitlename\ {\huge\thechapter}}%
	{1ex}{\titlerule\vspace{2ex}\filcenter\Huge}%
	[\vspace{1ex}\titlerule]
\titleformat{\section}{\bfseries\Large}{}{}{}
%%%%% End basic set-up  %%%%%

%%%%% Theorem like environments (ntheorem (modified)) %%%%%
\numberwithin{equation}{chapter}

\theoremstyle{changebreak}
\theoremheaderfont{\normalfont\scshape\bfseries}
\theorembodyfont{\upshape}
\theoremseparator{}
\theoremindent0cm
\theoremnumbering{arabic}
\theoremsymbol{\ensuremath{\blacksquare}}

\newtheorem{thm}[equation]{Theorem}
\newtheorem{prop}[equation]{Proposition}
\newtheorem{lem}[equation]{Lemma}
\newtheorem{cor}[equation]{Corollary}
\newtheorem{defn}[equation]{Definition}
\newtheorem{conv}[equation]{Convention}

\theorembodyfont{\itshape}
\theoremsymbol{\ensuremath{\diamondsuit}}

\newtheorem{quest}[equation]{Open Question}
\newtheorem{conj}[equation]{Conjecture}

\theoremheaderfont{\normalfont\itshape}
\theorembodyfont{\upshape}
\theoremsymbol{\ensuremath{\blacksquare}}

\newtheorem{rmk}[equation]{Remark}
\newtheorem{exa}[equation]{Example}
\newtheorem{exer}[equation]{Exercise}

\theoremstyle{nonumberplain}
\theoremheaderfont{\normalfont\scshape}
\theoremsymbol{\ensuremath{\square}}

\newtheorem{proof}{Proof}

\newenvironment{pfof}[1]%
	{\def\wwwnotes@pfofctr{#1}\begin{proof}[\thref{#1}]}%
	{\end{proof}}

\newtheoremstyle{wwwnumberonly}%
  {\item[\theorem@headerfont\bfseries\hskip\labelsep ##2]}%
  {\item[\theorem@headerfont\bfseries\hskip\labelsep ##2 (##3)]}
\theoremstyle{wwwnumberonly}
\theoremheaderfont{\normalfont\bfseries}
\theoremsymbol{\P}
\theorempreskip\parsep
\theorempostskip\parsep

\newtheorem{thot}[equation]{Thought}
%%%%% End Theorem like environments %%%%%

%%%%% Margin Notes and Descriptive Labelling (marginfix, everypage) %%%%%
\newcommand*\marginfont{\footnotesize\itshape}
\setlength\marginparpush{9pt}
\newcommand{\marginnote}[1]{%
	\marginpar[\raggedleft\marginfont #1]{\raggedright\marginfont #1}}

\newoutputstream{Xrefedges}
\newoutputstream{Xrefvertices}
\openoutputfile{\jobname-edges-xrf.csv}{Xrefedges}
\openoutputfile{\jobname-vertices-xrf.csv}{Xrefvertices}
\addtostream{Xrefedges}{source,target}
\addtostream{Xrefvertices}{id,label,type,description,page}


\newcommand\desclabel[2]{%
	\label{#1}%
	\global\@namedef{www@label@store@description@#1}{#2}%
	\addtostream{Xrefvertices}{#1,"\@currentlabel","\csname\InTheoType Keyword\endcsname","#2",\thepage}}
% getdesc: 
%  #1 -- label, #2 -- filter, #3 -- error, #4 -- pre, #5 -- post
\newcommand\label@getdesc[5]{%
	\ifcsname www@label@store@description@#1\endcsname
		#2{#4\@nameuse{www@label@store@description@#1}#5}%
	\else
		#3%
	\fi}

% Showdesc tests if the label has already been shown on this page. If not, it 
% show the info for the label, and marks it as shown. The list of shown labels 
% is cleared at the end of every page with an \AddEverypageHook (see below)
\gdef\@desc@refs@on@page{}
\newcommand*\showdesc[1]{%
	\ifinlist{#1}{\@desc@refs@on@page}{\ClassInfo{wwwnotes2}{Label #1 is already shown, suppressing second display}}{%	
	\label@getdesc{#1}{\marginnote}{\ClassWarning{wwwnotes2}{Label #1 has no description}}{Ref.\ \ref*{#1}: ``}{''}%
\listgadd{\@desc@refs@on@page}{#1}}}

% Patch all three of the common reference commands. 
\newcommand*\descthref[1]{\thref{#1}\showdesc{#1}\writeref{#1}}
\newcommand*\desceqref[1]{\eqref{#1}\showdesc{#1}\writeref{#1}}
\newcommand*\descref[1]{\ref{#1}\showdesc{#1}\writeref{#1}}

\newcommand*\writeref[1]{\ifdef\wwwnotes@pfofctr{\addtostream{Xrefedges}{\wwwnotes@pfofctr,#1}}{}}
\AddEverypageHook{\gdef\@desc@refs@on@page{}}
%%%%% End Margin Notes and Descriptive Labelling %%%%%

