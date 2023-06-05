\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{solutionclass}[2023/03/03 My Custom LaTeX Class for exercise solutions]

\LoadClass[a4paper, twoside, 11pt]{book}

% LANGUAGE AND ENCODING
\RequirePackage[portuguese, english]{babel} % Allows to use multiple languages in the document
\RequirePackage[utf8]{inputenc} % Defines the input encoding
\RequirePackage[T1]{fontenc} % Defines the font encoding

% TEXT FORMATTING AND MANIPULATION
\RequirePackage{indentfirst} % Indent the first paragraph of a section
\RequirePackage{datetime} % Provides various features of date and time formatting
\RequirePackage{csquotes} % Context sensitive quotation facilities
\RequirePackage{mathrsfs} % Provides additional math scripts fonts
\RequirePackage{titlesec} % Allows customization of section titles
\RequirePackage{upgreek} % Provides upright greek letters
\RequirePackage{dsfont} % Provides various math symbols such as the indicator function
\RequirePackage{pifont} % Provides various symbols such as check marks and crosses
\RequirePackage{lipsum} % Generates Lorem Ipsum text for testing purposes

% MATHEMATICS AND PHYSICS
\RequirePackage{amsmath} % for mathematical symbols
\RequirePackage{amssymb} % for mathematical symbols
\RequirePackage{mathtools} % for mathematical typesetting
\RequirePackage{physics} % for mathematical physics
\RequirePackage{stmaryrd} % for mathematical symbols
\RequirePackage{tensor} % for tensors
\RequirePackage{calc} % for mathematical calculations

% FIGURES, TIKZ AND BOXES
\RequirePackage{graphicx} % for including images
\RequirePackage{float} % provides H option for figures and tables
\RequirePackage{xcolor} % for color support
\RequirePackage{tikz} % for creating graphics and diagrams
\RequirePackage{tikz-3dplot} % for 3D graphics in TikZ
\RequirePackage{pgfplots} % for creating plots and diagrams
\RequirePackage[most]{tcolorbox} % for creating colored boxes and frames

% PAGE AND TEXT STYLES
\RequirePackage[colorlinks = true,
                urlcolor = LinkColor,
                anchorcolor = LinkColor,
                citecolor = LinkColor,
                filecolor = LinkColor,
                linkcolor = LinkColor,
                menucolor = LinkColor,
                linktocpage = true,
                bookmarks = true,
                pdfusetitle]{hyperref} % Hyperlinks
\RequirePackage[top = 2.5cm,
                bottom = 3.8cm,
                left = 2cm,
                right = 2cm,
                ]{geometry} % Page margins
\RequirePackage[shortlabels]{enumitem} % Customized lists
\RequirePackage{microtype} % Improves typography
\RequirePackage{fancyhdr} % Custom headers and footers
\RequirePackage{titletoc} % Custom table of contents
\RequirePackage{lastpage} % Reference to the last page
\RequirePackage{etoolbox} % Toolbox of programming tools
\RequirePackage{multicol} % Multiple columns
\RequirePackage{caption} % Customizing captions
\RequirePackage{lmodern} % Latin Modern fonts
\RequirePackage{nameref} % Cross-referencing by name
\RequirePackage{changepage} % Change page dimensions
\RequirePackage{minted} % Code formatting tool
\RequirePackage{comment}


% BIBLIOGRAFY
\RequirePackage[backend    = biber, 
                style      = ext-authoryear-comp,
                sorting    = nyvt, 
                backref    = false,
                articlein  = false,
                uniquename = true,
                doi        = true, 
                dashed     = false]{biblatex} % Custom bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BIBLIOGRAFYU SETTINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The below settings add the .bib archive and define the format which will be compilated
\addbibresource{bib.bib} %Load references
\DeclareFieldFormat[article,periodical]{volume}{\mkbibbold{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The below commands was created to make a onte kind of reference citing
\newcommand{\therefs}{%
    {%\bfseries%
    \newline%
    \textcolor{myLColor}{References:}%
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The below setting was written to print the references
\AtEndDocument{%
    \clearpage
    \pagestyle{fancy} % clears the middle part of the headers from here on (no year to specify)
    \markboth{\textsc{References}}{\textsc{References}} % ensures headers are working as intended during reference chapter
    \printbibliography[heading=bibintoc, title=References]
} % prints references
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% TIKZ SETTINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usetikzlibrary{%
    decorations.pathreplacing, % Create decorative path elements that replace parts of the original path.
    decorations.pathmorphing, % Create decorative path elements that morph the original path.
    decorations.markings, % Place decorations along a path.
    shapes.multipart, % Create nodes with multiple parts.
    shapes.geometric, % Provide additional geometric shapes.
    arrows.meta, % Define arrowheads for paths.
    tikzmark, % Place markers on a path or in a TikZ picture.
    fadings, % Create gradient and transparency effects.
    arrows, % Provide additional arrowheads.
    angles, % Measure and display angles between lines.
    quotes, % Place quotes on a path.
    calc, % Provide additional mathematical functions.
    3d, % Create three-dimensional TikZ diagrams.
}
\pgfplotsset{compat=1.18} % Sets the compatibility level for the pgfplots package to version 1.18, ensuring consistent compilation of plots and diagrams in the document.

\tikzset{>=stealth} % Arrow style for all tikZ environment.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% COLOR SETTINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To change the darker color of the document, like the cover page background, change the hexadecimal code #101010 to the color which you want. To know what hexadecimal code you need, access https://htmlcolorcodes.com
\definecolor{myDColor}{HTML}{101010} % Darker Color
% To change the lighter color of the document, like the box solution backaground, change the hexadecimal code #e93820 to the color which you want
\definecolor{myLColor}{HTML}{7736d9} % Lighter Color
% To change the link color of the document, like the mentions, change the hexadecimal code #eb5a00 to the color which you want
\definecolor{LinkColor}{HTML}{9669d9} % Link Color

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CHAPTER AND SECTION SETTINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command is designed to customize the styling of the \chaper{} command to create a box with the chapter number along with a mini summary containing the page where each exercise and its solution are located.
\newcommand{\chapterNumberAndMinitoc}{%
\begin{tikzpicture}
    \node[%
        minimum height  = 3.2cm,
        text width      = 2.5cm,
        outer sep       = 0pt,
        inner sep       = 0pt,
        align           = center, 
        fill            = myDColor,
        font            = \color{white}\fontsize{70}{90}\selectfont,
    ] (num) {\homeworkNumber}; 
    
    \node[%
         minimum height     = 20pt,
        outer sep           = 0pt,
        inner sep           = 0pt,
        rotate              = 90,
        anchor              = south,
        font                = \color{black}\small\normalfont
    ] (listN) at (num.west) {\textls[180]{\textsc{Homework N°}}};
    
    \node[%
        minimum height  = 3.2cm,% Height of the box    
        minimum width   = 6.2cm,
        inner sep       = 2.5mm, % The border thickness
        outer sep       = 0pt,
        align           = left, % Text aligning
        fill            = myDColor, % Color background
        anchor          = east,
    ] at (listN.north) {%
        \footnotesize
        \color{white}
        \begin{minipage}{\fpeval{\textwidth-2.5cm-20pt-5mm}pt} % Control the width of the box
            \begin{multicols}{2}
                \printcontents[sections]{}{1}{}{}
            \end{multicols}
        \end{minipage}%
    };
\end{tikzpicture}%
}

\titleformat{\chapter}[display]
{\normalfont\bfseries\color{myDColor}}
{\filleft%
    \chapterNumberAndMinitoc}{1em}
{\titlerule[2.5pt]\vspace{3pt}\titlerule\vspace{4pt}\LARGE\textsc}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command removes the blank page that is automatically created when you compile the text cover and then a chapter.
\makeatletter
\patchcmd{\chapter}{%
\if@openright
    \cleardoublepage
    \else
    \clearpage
\fi
}{%
}{}{}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command create a polygon on the left side of the section title
\newcommand{\polygonSection}{%
\begin{tikzpicture}[remember picture, overlay,baseline=1.5ex]
\node[%
    regular polygon sides   = 6, 
    rounded corners,
    regular polygon,
    minimum size            = 1.58cm,
    ultra thick,
    inner sep               = 0pt,
    fill                    = myLColor!85,
    anchor                  = south
] at (current page.north west |- 0,0) (red polygon) {};
\foreach \i in {2.5,...,4.5}{%
    \node[%
        myDColor,
        regular polygon sides   = 6, 
        regular polygon,
        rounded corners,
        minimum size            = \i cm,
        ultra thick,
        draw,
    ] at (red polygon) {};
}
\end{tikzpicture}}

\RequirePackage{titlesec}
\titleformat{\section}[display]
    {\vspace{2em}\normalfont\bfseries\color{myDColor}\huge}{}{}
    {\polygonSection\hspace{0.666em}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command is a reformulation of the \section{} command, so that from now on, every time this command is called it will not compile the section number, only the title, but will still add this title in the table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\oldsection\section                             
\renewcommand{\section}[1]{%                        
    \oldsection*{#1}                                
    \phantomsection                                
    \addcontentsline{toc}{section}{#1}              
}                                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\titlecontents{section}
[0em]
{}
{}
{}
{\titlerule*[0.4pc]{.}\contentspage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command change the color of the label number in \label{} commands
\makeatletter
\def\tagform@#1{\maketag@@@{\normalfont(\color{myLColor}\ignorespaces#1\unskip\@@italiccorr\color{black})}}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DOCUMENT COVER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here the commands for building the document cover were made.
\newcommand{\pretitle}[3]{%
\begin{titlepage}
\pagestyle{empty}
\begin{tikzpicture}[remember picture,overlay]
    % BACKGROUND
    \fill[myDColor] (current page.south west) rectangle (current page.north east);
    \foreach \i in {2.5,...,22}{%
        \node[%
            myDColor!60,
            regular polygon sides   = 6, 
            regular polygon,
            rounded corners,
            minimum size            = \i cm,
            ultra thick,
            draw,
        ] at ($(current page.west)+(2.5,-5)$) {};
    }
    % BACKGROUND POLYGONS
    \foreach \i in {0.5,...,22}{%
        \node[%
            myLColor!85,        
            regular polygon sides   = 6, 
            regular polygon,
            rounded corners,
            minimum size            = \i cm,
            ultra thick,
            draw,
        ] at ($(current page.north west)+(2.5,0)$) {};
    }
    \foreach \i in {0.5,...,22}{%
        \node[%
            myDColor!90,        
            regular polygon sides   = 6, 
            regular polygon,
            rounded corners,
            minimum size            = \i cm,
            ultra thick,
            draw,
        ] at ($(current page.north east)+(0,-10)$) {};
    }
    \foreach \i in {21,...,6}{%
        \node[
            myLColor!85,        
            regular polygon sides   = 6, 
            regular polygon,
            rounded corners,
            minimum size            = \i cm,
            ultra thick,
            draw,
        ] at ($(current page.south east)+(-0.2,0.1)$) {};
    }
    % TITLE
    \node[%
        myLColor!5,
        rounded corners,        
        minimum height  = 3cm,         
        minimum width   = 0.625*\paperwidth,
        left,
    ] (title) at ($(current page.north east)+(0,-10)$){%
        {\fontsize{22}{30} \selectfont \bfseries #1} % TITLE = #1
    };

    % SUBTITLE
    \node[%
        myLColor!10,
        rounded corners,
        minimum height  = 2cm, 
        minimum width   = 0.625*\paperwidth,        
        left,
    ] at ($(current page.north east)+(0,-11)$){%
        {\huge \textit{#2}} % SUBTITLE = #2
    };
    % AUTHOR NAME
    \node[%
        myLColor!5,
        rounded corners,
        minimum height  = 2cm, 
        minimum width   = 0.625*\paperwidth,
        left,
    ] at ($(current page.north east)+(0,-13)$){%
        {\Large \textsc{#3}} % NAME = #3
    };
    % AUTHOR NAME
    \node[%
        myLColor!5,
        rounded corners,
        minimum height  = 2cm, 
        minimum width   = 0.625*\paperwidth,
        left,
    ] at ($(current page.north east)+(0,-14)$){%
        {\Large \textsc{Prakash Srinivasan}} % NAME = #3
    };
    % AUTHOR NAME
    \node[%
        myLColor!5,
        rounded corners,
        minimum height  = 2cm, 
        minimum width   = 0.625*\paperwidth,
        left,
    ] at ($(current page.north east)+(0,-15)$){%
        {\Large \textsc{Ali Asgari}} % NAME = #3
    };
    % YEAR
    \node[%
        regular polygon sides   = 6, 
        rounded corners,
        regular polygon,
        minimum size            = 2.5 cm,
        ultra thick,
        inner sep               = 0,
        fill                    = myLColor!85,
        text                    = myLColor!5,
    ] at ($(current page.west)+(2.5,-5)$) {\LARGE \bfseries \the\year};
    % Institute name
    \node[text = myLColor!5] (Institute) at ($(current page.north)+(0,-4.0)$$) {University of Naples Federico II};
    % University logo
    \node[] at ($(Institute.north)+(0,1.4)$){\includegraphics[width=2.5cm]{University_Logo.png}};
    
\end{tikzpicture}
\end{titlepage}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% NEW ENVIRONMENTS AND NEW COMMANDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This environment was made to produce a box which maintain the width and height of the text inside it.
\newtcolorbox{solution}[1][]{%
    enhanced,
    skin first=enhanced,
    skin middle=enhanced,
    skin last=enhanced,
    before upper={\parindent15pt},
    breakable,
    boxrule = 0pt,
    frame hidden,
    borderline west = {4pt}{0pt}{myDColor},
    colback = myLColor!10,
    coltitle = myLColor!5,
    sharp corners,
    rounded corners = southeast,
    arc is angular,
    arc = 3mm,
    attach boxed title to top left,
    boxed title style = {%
        enhanced,
        colback = myDColor,
        colframe = myDColor,
        top = 0pt,
        bottom = 0pt,
        sharp corners,
        rounded corners = northeast,
        arc is angular,
        arc = 2mm,
        rightrule = 0pt,
        bottomrule = 0pt,
        toprule = 0pt,
    },
    title = {\bfseries\large Solution:}, 
    overlay unbroken={%
        \node[anchor=west, color=black!70] at (title.east) {#1};
        \path[fill = tcbcolback!80!black] 
            ([yshift = 3mm]interior.south east) -- ++(-0.4,-0.1) -- ++(0.1,-0.2);
    },
    overlay first = {%
        \node[anchor=west, color=black!70] at (title.east) {#1};
        \path[fill = tcbcolback!80!black] 
            ([yshift = 3mm]interior.south east) -- ++(-0.4,-0.1) -- ++(0.1,-0.2);
    },
    overlay middle={%
        \path[fill = tcbcolback!80!black] 
            ([yshift = -3mm]interior.north east) -- ++(-0.4,0.1) -- ++(0.1,0.2);
        \path[fill = tcbcolback!80!black] 
            ([yshift = 3mm]interior.south east) -- ++(-0.4,-0.1) -- ++(0.1,-0.2);
    },
    overlay last={%
        \path[fill = tcbcolback!80!black] 
            ([yshift = -3mm]interior.north east) -- ++(-0.4,0.1) -- ++(0.1,0.2);
        \path[fill = tcbcolback!80!black] 
            ([yshift = 3mm]interior.south east) -- ++(-0.4,-0.1) -- ++(0.1,-0.2);
    },
    extras middle and last = { rounded corners = northeast }
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The below commands was made to personalize the align and align* environments to have a orange line between to equalities.
\newcommand*\eqlineset{\pgfqkeys{/eqlines}}
\eqlineset{
  picture/.style={baseline, remember picture},
  line/.style={thick, draw=myLColor, line cap=round},
  node/.style={
    minimum size=+0pt, inner sep=+0pt, outer ysep=+.3333em, anchor=base,
    name=tma\thetikzmarkalign},
}
\newcounter{tikzmarkalign}
\makeatletter
\AtBeginEnvironment{align}{%
  \setcounter{tikzmarkalign}{0}%
  \newcommand*\noeq{\hphantom{={}}}%
  \newcommand*\eq{
    \ifnum\value{tikzmarkalign}=0
      \mathrel{\tikz[/eqlines/picture]\node[/eqlines/node]{$=$};}
    \else
      \mathrel{
        \begin{tikzpicture}[/eqlines/picture]
          \node[/eqlines/node] (tma\thetikzmarkalign) {$=$};
          \unless\ifmeasuring@
            \path[/eqlines/line, overlay] (tma\thetikzmarkalign)
                        -- (tma\pgfinteval{\thetikzmarkalign-1});
          \fi
        \end{tikzpicture}
      }
    \fi
    \stepcounter{tikzmarkalign}
  }%
}
\makeatother
\makeatletter
\AtBeginEnvironment{align*}{%
  \setcounter{tikzmarkalign}{0}%
  \newcommand*\noeq{\hphantom{={}}}%
  \newcommand*\eq{
    \ifnum\value{tikzmarkalign}=0
      \mathrel{\tikz[/eqlines/picture]\node[/eqlines/node]{$=$};}
    \else
      \mathrel{
        \begin{tikzpicture}[/eqlines/picture]
          \node[/eqlines/node] (tma\thetikzmarkalign) {$=$};
          \unless\ifmeasuring@
            \path[/eqlines/line, overlay] (tma\thetikzmarkalign)
                        -- (tma\pgfinteval{\thetikzmarkalign-1});
          \fi
        \end{tikzpicture}
      }
    \fi
    \stepcounter{tikzmarkalign}
  }%
}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command make a simple line to divide texts. The width is adaptable to the text width.
\newcommand{\divider}{\setlength{\parindent}{0pt}\textcolor{myDColor!30}{\rule{\linewidth}{0.6pt}}\smallskip\setlength{\parindent}{1.5em}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command was made to create a box (which can be labeled) to write equations which are answers for a random problem
\NewEnviron{answer}{
\begin{equation}
\tcbhighmath[
         boxrule = 1pt,
         colframe = myLColor,
         colback = black!80,
         sharp corners,
         rounded corners = southeast,
         rounded corners = northeast,
         rounded corners = southwest,
         rounded corners = northwest,
         arc is angular,
         arc = 3mm,
         coltext = white,
     ]{\BODY}\end{equation}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This renewcommand was created to change the arrow notation from vectors to the bold notation of them.
\renewcommand\vec{\boldsymbol}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This command was created to make comments inside the text using the a more beautifull " ".
\newcommand{\Acomment}[1]{\textquotedblleft \textit{#1}\textquotedblright }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The below commands is to maintain the font to the symbol mathbb{1} different and more beauty
\DeclareMathAlphabet{\mathbbold}{U}{bbold}{m}{n}
\newcommand*{\boldone}{\mathbbold{1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE YOUR NEW COMMANDS FROM HERE:
