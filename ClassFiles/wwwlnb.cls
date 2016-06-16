%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  wwwlnb class by Willie W-Y Wong for use as a LabNoteBook
%%%%  See wwwlnb.tex for template of use.
%%%%  Usage: 
%%%%    \documentclass{wwwlnb}
%%%%    \title{<title>}
%%%%    \subtitle{<subtitle>}
%%%%    \author{<author>}
%%%%    \firstyear{<firstyear>}
%%%%    \begin{document}
%%%%    \maketitle
%%%%    ....
%%%%    \end{document}
%%%%
%%%%  Wrap each entry in \begin{entry}{<Y>}{<M>}{<D>}{<title>}{<tag list>}
%%%%    ...  \end{entry} block. 
%%%%  Currently the style has predefined the following theorems:
%%%%    thm, prop, lem, cor, conj, defn, conv, rmk, exa, quest, proof, ans
%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wwwlnb}
	[2016/01/19 v0.5 Willie Wai Yeung Wong LabNotes class]

\LoadClass[10pt,titlepage,leqno,openright]{report}

\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}

\RequirePackage{ifthen}

\RequirePackage{geometry}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{titling}

\RequirePackage{enumitem}
\RequirePackage{index}
\RequirePackage{url}
\RequirePackage{cite}
\RequirePackage{www_tagging}

%%I do not think I need this one
%% \RequirePackage{multicol}

\RequirePackage[oldstylenums,narrowiints,intlimits,sumlimits,noDcommand]{kpfonts}
\RequirePackage[protrusion,babel]{microtype}

\RequirePackage[ntheorem,leqno]{empheq}
\RequirePackage[thmmarks,thref,amsmath,hyperref]{ntheorem}
% The following line is a workaround for a tag placement problem. See
% http://tex.stackexchange.com/questions/50845/empheq-conflict-with-ntheorem
% For more detail.
\usetagform{default}

\RequirePackage[notcite,notref]{showkeys}
\RequirePackage[colorlinks=false]{hyperref}

%% Geometry (geometry)
\geometry{papersize={7.4in,9.5in},scale=0.7,bindingoffset=0.2in,twoside,hmarginratio={1:1},vmarginratio={3:4},headheight=14pt,headsep=0.2in,footskip=0.5in}

%% Increase pnumwidth to accept longer page numbers
\makeatletter
\renewcommand{\@pnumwidth}{2em}
\makeatother

%% Git backup (gracefully degrades if user doesn't use Git)
\newcommand*\gitShorthash{(git not used)}
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
	pdfsubject={Mathematical Research}}%
	\vskip 1.5in}
\predate{\begin{center}\footnotesize Revision based on commit \texttt{\gitShorthash{}} as of }
\postdate{\par Included tags in this build: \texttt{\activatedtaglist}\par\end{center}}
\setlength{\droptitle}{0.5in}

%% Table of Contents page (titletoc)
\contentsmargin{2.55em}
\dottedcontents{section}[6em]{}{5.5em}{1pc}

%% Headers and Footers (titlesec)
\widenhead*{0.2em}{0.5em}
\newpagestyle{wwwfancy}{\headrule%
	\setmarks{chapter}{section}%
	\sethead[\small\slshape\ifthesection{\thesection.\ \sectiontitle}{}]%
		[][\small\slshape\thetitletext]%
		{\small\slshape\thetitletext}{}%
		{\small\slshape\ifthesection{\thesection.\ \sectiontitle}{}}%
	\setfoot[\tiny tagged: \texttt{\activatedtaglist}][\thepage][]{}{\thepage}{\tiny \GitPageFooter}}
\pagestyle{wwwfancy}

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
\renewcommand\thesection{\arabic{part}.\arabic{chapter}.\arabic{section}}
\newcommand*\listoftags{}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}
\titleformat{\chapter}[display]{\bfseries\Large}%
	{\filleft\chaptertitlename\ {\huge\thechapter}}%
	{1ex}{\titlerule\vspace{2ex}\filcenter\Huge}%
	[\vspace{1ex}\titlerule]
\titleformat{\section}{\bfseries\Large}{\thesection}{.5em}{}%
	[\quad {\footnotesize (tagged as: \texttt{\listoftags})}]
\titleformat{\subsection}[runin]{\normalfont\bfseries}%
	{\thesubsection.}{0.5em}{}[.---]
\titleformat{\subsubsection}[runin]{\normalfont\slshape}%
	{}{}{}[.---]
% TODO: titleformat for par, and subpar

%% Topic commands (www_tagging)
%%% Argument: #1-3 YYMMDD #4 title #5 tags
\makeatletter
\newenvironment{entry}[5]%
        {\csundef{@tagged@used}{}%
        \forcsvlist{\addtostream{taglist}}{#5}%
        \forcsvlist{\listadd\thisblocktags}{#5}%
	\listadd\thisblocktags{all}%
	\listadd\thisblocktags{year#1}% This and next to add temporal control
	\listadd\thisblocktags{month#1.#2}%
        \forlistcsloop{\andor@listparse{thisblocktags}}{tagcombolist@master}%
        \ifcsname @tagged@used\endcsname%
                \let\comment\relax%
                \let\endcomment\relax%
        \fi\comment%
	\setcounter{part}{#1}\setcounter{chapter}{#2}%
	\setcounter{section}{#3}\addtocounter{section}{-1}%
	\renewcommand\listoftags{#5}\section{#4}%
	}{\endcomment}
\let\oldusetagcombos\usetagcombos%
\newcommand\activatedtaglist{(null)}
\renewcommand*\usetagcombos[1]{\oldusetagcombos{#1}%
	\def\activatedtaglist{#1}}
\makeatother
%%%%% End basic set-up  %%%%%

%%%%% Theorem like environments (ntheorem (modified)) %%%%%
\numberwithin{equation}{section}

\theoremstyle{break}
\theoremheaderfont{\normalfont\bfseries}
\theorembodyfont{\itshape}
\theoremseparator{}
\theoremindent0cm
\theoremnumbering{arabic}
\theoremsymbol{\ensuremath{_\blacksquare}}

\newtheorem{thm}[equation]{Theorem}
\newtheorem{prop}[equation]{Proposition}
\newtheorem{lem}[equation]{Lemma}
\newtheorem{cor}[equation]{Corollary}
\newtheorem{conj}[equation]{Conjecture}


\theoremstyle{plain}
\theoremseparator{:}

\newtheorem{quest}{Question}

\theorembodyfont{\upshape}

\newtheorem{defn}[equation]{Definition}
\newtheorem{conv}[equation]{Convention}

\theoremheaderfont{\normalfont\itshape}

\newtheorem{rmk}[equation]{Remark}
\newtheorem{exa}[equation]{Example}
\newtheorem{answer}{Answer}

\theoremstyle{nonumberplain}
\theoremheaderfont{\normalfont\scshape}
\theoremsymbol{\ensuremath{_\Box}}

\newtheorem{proof}{Proof}
%%%%% End Theorem like environments %%%%%

%%%%% Miscellaneous commands %%%%%
\newcommand*\arXiv[1]{\href{http://arxiv.org/abs/#1}{arXiv:#1}}
%% Shortcut for providing arXiv reference strings
%%%%% End Misc commands %%%%%

%%%%% Load other custom packages %%%%%
\RequirePackage{www_helper_commands}
\RequirePackage[geom,slash,sets,norm,errorterm,pde,miscops,labeled,roman,conv]{www_math_commands}
%%%%% End custom packages %%%%%
