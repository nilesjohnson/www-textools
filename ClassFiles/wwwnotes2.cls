%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  wwwnotes2 class by Willie W-Y Wong     
%%%%  Usage: 
%%%%    \documentclass{wwwnotes}
%%%%    \title{<title>}
%%%%    \subtitle{<subtitle>}
%%%%    \author{<author>}
%%%%    \begin{document}
%%%%    \maketitle
%%%%    ....
%%%%    \end{document}
%%%%
%%%%  Currently the style has predefined the following theorems:
%%%%    thm, prop, lem, cor, conj, defn, conv, rmk, exa, quest, proof, ans
%%%%  Extended referencing commands:
%%%%    \ref, \eqref, \thref
%%%%  One should only use \chapter and \section, and optionally \part for 
%%%%    sectioning. Don't use \subsection! That's too many levels down, as 
%%%%    Tufte would say. 
%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wwwnotes2}
	[2016/01/20 v0.6 Willie Wai Yeung Wong Notes class]

\LoadClass[11pt,titlepage,leqno,openright,twoside]{report}

\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}

\RequirePackage{ifthen}

\RequirePackage{geometry}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{emarks}
\RequirePackage{marginnote}
\RequirePackage{titling}

\RequirePackage{enumitem}
%\RequirePackage{paralist}  %Read the manual? Seems to break standard list envs
\RequirePackage{index}
\RequirePackage{url}
\RequirePackage{cite}

%%I do not think I need this one
%% \RequirePackage{multicol}

\RequirePackage[oldstylenums,narrowiints,intlimits,sumlimits,noDcommand]{kpfonts}
\RequirePackage[protrusion,babel]{microtype}

\RequirePackage{amsmath}
\RequirePackage[amsmath,thmmarks,thref,hyperref]{ntheorem}
\RequirePackage{mathtools}
\RequirePackage[ntheorem]{empheq}

\RequirePackage[colorlinks=false]{hyperref}

%% Geometry (geometry)
\geometry{papersize={7.4in,9.5in},scale=0.65,bindingoffset=0.2in,twoside,hmarginratio={1:2},vmarginratio={3:4},headheight=14pt,headsep=0.2in,footskip=0.5in}

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
	\setfoot[\tiny \theauthor][\thepage][]{}{\thepage}{\tiny \GitPageFooter}}
\pagestyle{wwwfancy}

%Redefine refstepcounter to throw things into the marks
\let\www@old@refstepcounter\refstepcounter
\def\refstepcounter#1{%
	\www@old@refstepcounter{#1}%
	\ifthenelse{\equal{#1}{equation}}{\marksthecs{www@stuff@mark}{theequation}}{}%
	\ifthenelse{\equal{#1}{chapter}}{\marksthecs{www@stuff@mark}{theequation}}{}}


% To make the clear page completely empty, with no header or footer
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	%\vspace*{\fill}
	%\begin{center}
	%   This page intentially blank.
	%\end{center}
	%\vspace{\fill}
	\thispagestyle{empty}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother

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
	{\begin{proof}[\thref{#1}]}%
	{\end{proof}}

\newtheoremstyle{wwwnumberonly}%
  {\item[\normalfont\bfseries\hskip\labelsep ##2]}%
  {\item[\normalfont\bfseries\hskip\labelsep ##2 (##3)]}
\theoremstyle{wwwnumberonly}
\theoremsymbol{\P}
\theorempreskip\parsep
\theorempostskip\parsep

\newtheorem{paras}[equation]{Paragraphs}

%%%%% End Theorem like environments %%%%%

