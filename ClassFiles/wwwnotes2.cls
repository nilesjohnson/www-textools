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
%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wwwnotes2}
	[2016/01/20 v0.6 Willie Wai Yeung Wong Notes class]

\DeclareOption{noocg}{\PassOptionsToPackage{\CurrentOption}{www_helper_commands}
             \typeout{OCG support turned off}}
\ProcessOptions\relax

\LoadClass[11pt,titlepage,leqno,openright]{report}

\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}

\RequirePackage{ifthen}

\RequirePackage{geometry}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage[titles]{tocloft} %have not explored this one yet
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

\RequirePackage[notcite,notref]{showkeys}
\RequirePackage[colorlinks=false]{hyperref}

%% Geometry (geometry)
\geometry{papersize={7.4in,9.5in},scale=0.7,bindingoffset=0.2in,twoside,hmarginratio={1:1},vmarginratio={3:4},headheight=14pt,headsep=0.2in,footskip=0.5in}

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
	pdfsubject={Mathematical Research}}%
	\vskip 1.5in}
\predate{\begin{center}\footnotesize Revision based on commit \texttt{\gitShortHash{}} as of }
\postdate{\par\end{center}}
\setlength{\droptitle}{0.5in}

%% Headers and Footers (titlesec)
\widenhead*{0.2em}{0.5em}
\newpagestyle{wwwfancy}{\headrule%
	\setmarks{chapter}{section}%
	\sethead[\footnotesize\slshape\ifthesection{\thesection.\ \sectiontitle}{}]%
		[][\footnotesize\slshape\thetitletext]%
		{\footnotesize\slshape\ifthechapter{\chaptertitlename\ %
		\thechapter.\ \chaptertitle}{}}{}%
		{\footnotesize\slshape\ifthesection{\thesection.\ \sectiontitle}{}}%
	\setfoot[][\thepage][]{}{\thepage}{\tiny \GitPageFooter}}
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
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{1}
\titleformat{\part}[display]{\bfseries\huge}%
	{\filcenter\partname\ \thepart}{0.4in}%
	{\filcenter\Huge}[\thispagestyle{empty}]
\titleformat{\chapter}[display]{\bfseries\Large}%
	{\filleft\chaptertitlename\ {\huge\thechapter}}%
	{1ex}{\titlerule\vspace{2ex}\filcenter\Huge}%
	[\vspace{1ex}\titlerule]
\titleformat{\section}{\bfseries\Large}{\S\thesection}{.5em}{}
\titleformat{\subsection}[runin]{\normalfont\bfseries}%
	{\thesubsection.}{0.5em}{}[.---]
\titleformat{\subsubsection}[runin]{\normalfont\slshape}%
	{}{}{}[.---]
% TODO: titleformat for par, and subpar
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

\newtheorem{quest}[equation]{Question}

\theorembodyfont{\upshape}

\newtheorem{defn}[equation]{Definition}
\newtheorem{conv}[equation]{Convention}

\theoremheaderfont{\normalfont\itshape}

\newtheorem{rmk}[equation]{Remark}
\newtheorem{exa}[equation]{Example}
\newtheorem{answer}[equation]{Answer}

\theoremstyle{nonumberplain}
\theoremheaderfont{\normalfont\scshape}
\theoremsymbol{\ensuremath{_\Box}}

\newtheorem{proof}{Proof}
%%%%% End Theorem like environments %%%%%

%%%%% Load custom commands %%%%%
\RequirePackage{www_helper_commands}
%%%%% End custom commands %%%%%
