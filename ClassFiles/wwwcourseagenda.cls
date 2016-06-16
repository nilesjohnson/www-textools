%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  wwwcourseagenda class by Willie W-Y Wong     
%%%%  Usage: 
%%%%    \documentclass{wwwnotes}
%%%%    \course{<course>}
%%%%    \semester{<semester>}
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
%%%%  We use a customized Git Tag thingie, remember to add
%%%%    \setGitVersion{}
%%%%  as a standalone line, with no leading spaces, near the top of the files

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wwwnotes2}
	[2013/10/24 v0.5a Willie Wai Yeung Wong Notes class]

\DeclareOption{noocg}{\PassOptionsToPackage{\CurrentOption}{www_helper_commands}
             \typeout{OCG support turned off}}
\ProcessOptions\relax

\LoadClass[11pt,titlepage,leqno]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}

\RequirePackage{ifthen}

\RequirePackage{geometry}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage[titles]{tocloft} %have not explored this one yet
\RequirePackage{titling}

\RequirePackage{enumitem}
\RequirePackage{index}
\RequirePackage{url}
\RequirePackage{cite}


\RequirePackage[oldstylenums,narrowiints,intlimits,sumlimits,noDcommand]{kpfonts}
\RequirePackage[protrusion,babel]{microtype}

\RequirePackage{amsmath}
\RequirePackage[amsmath,thmmarks,thref,hyperref]{ntheorem}
\RequirePackage{mathtools}
\RequirePackage[ntheorem]{empheq}

\RequirePackage[notcite,notref]{showkeys}
\RequirePackage[colorlinks=false]{hyperref}

%% Geometry (geometry)
\geometry{letterpaper,scale=0.72,twoside,hmarginratio={1:2},vmarginratio={3:4},headheight=14pt,headsep=0.2in,footskip=0.5in}

%% Version control (Git)
\newcommand*\gitShortHash{(none)}
\newcommand*\gitAuthorName{(none)}
\newcommand*\gitAuthorEmail{(none)}
\newcommand*\gitAuthorDate{(none)}
\newcommand*\gitRefNames{(none)}
\newcommand*\GitPageFooter{(undefined)}

%% Title Page (titling)[hyperref]
\newcommand*\thesemester{}
\newcommand*\semester[1]{\renewcommand*\thesemester{#1}}
\newcommand*\thecoursenumber{}
\newcommand*\coursenumber[2]{\renewcommand*\thecoursenumber{#1, #2}}
\newcommand*\thetitletext{}
\newcommand*\course[1]{\renewcommand*\thetitletext{#1}\title{#1}}
\pretitle{\begin{flushleft}\Huge \bfseries \scshape}
\posttitle{\par \thesemester: course agenda\end{flushleft}\begin{flushleft}\Large \thecoursenumber\end{flushleft} \vfill}
\preauthor{\begin{flushright}\LARGE}
\postauthor{\par\end{flushright}%
	\hypersetup{pdfauthor={\theauthor},pdftitle={\thetitle, \thesemester},%
	pdfsubject={Teaching Course Agenda}}%
	\vskip 1.5in}
\predate{\begin{center}\footnotesize from commit \texttt{\gitShortHash}; compiled on }
\postdate{\par\end{center}}
\setlength{\droptitle}{0.5in}

%% Headers and Footers (titlesec)
\widenhead*{1em}{2em}
\newpagestyle{wwwfancy}{\headrule%
	\setmarks{section}{subsection}%
	\sethead{\small\slshape\ifthesection{\sectiontitle}{}}%
		{Day \thesection}{\small\slshape\thetitletext}%
	\setfoot{\tiny \thecoursenumber}{\thepage}{\tiny%
	\GitPageFooter}}
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
\setcounter{tocdepth}1{}
\titleformat{\section}{\bfseries\Large}{Day \thesection{} ---}{.5em}{}
\titleformat{\subsection}[runin]{\normalfont\bfseries}%
	{}{0.5em}{}[.---]
\titleformat{\subsubsection}[runin]{\normalfont\slshape}%
	{}{}{}[.---]
% TODO: titleformat for par, and subpar


%% Sectioning commands
\newcommand*\newday[1]{\cleardoublepage\section{#1}}
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
% Don't load math commands. Do it in the source. 
%\RequirePackage[geom,slash,sets,norm,errorterm,pde,miscops,labeled,conv,roman]{www_math_commands}
%%%%% End custom commands %%%%%
