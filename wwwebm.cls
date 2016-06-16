%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  wwwebm class by Willie W-Y Wong for prepping documents for the
%%%%    Espresso Book Machine

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wwwebm}
	[2016/01/20 v0.5 Willie Wai Yeung Wong EspressoBook class]

\LoadClass[10pt,titlepage,leqno,openright]{report}

\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}

\RequirePackage{geometry}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{titling}
\RequirePackage{hyperref}

\RequirePackage[oldstylenums,narrowiints,intlimits,sumlimits,noDcommand]{kpfonts}
\RequirePackage[protrusion,babel]{microtype}

%% Geometry (geometry)
\geometry{papersize={7.4in,9.5in},scale=0.7,bindingoffset=0.2in,twoside,hmarginratio={1:1},vmarginratio={3:4},headheight=14pt,headsep=0.2in,footskip=0.5in}

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
\postdate{\par\end{center}}
\setlength{\droptitle}{0.5in}

%% Table of Contents page (titletoc)
\contentsmargin{2.55em}
\dottedcontents{section}[6em]{}{5.5em}{1pc}

%% Headers and Footers (titlesec)
\widenhead*{0.2em}{0.5em}
\newpagestyle{wwwfancy}{\headrule%
	\setmarks{chapter}{section}%
	\sethead[\footnotesize\slshape\ifthesection{\thesection.\ \sectiontitle}{}]%
		[][\footnotesize\slshape\thetitletext]%
		{\footnotesize\slshape\ifthechapter{\thechapter.\ \chaptertitle}{}%
		{\small\slshape\ifthesection{\thesection.\ \sectiontitle}{}}%
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
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}
\newcommand*\listoftags{}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}
\titleformat{\chapter}[display]{\bfseries\Large}%
	{\filleft\chaptertitlename\ {\huge\thechapter}}%
	{1ex}{\titlerule\vspace{2ex}\filcenter\Huge}%
	[\vspace{1ex}\titlerule]
\titleformat{\section}{\bfseries\Large}{\thesection}{.5em}{}
\titleformat{\subsection}[runin]{\normalfont\bfseries}%
	{\thesubsection.}{0.5em}{}[.---]
\titleformat{\subsubsection}[runin]{\normalfont\slshape}%
	{}{}{}[.---]
% TODO: titleformat for par, and subpar

%%%%% End basic set-up  %%%%%
