local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local utils = require("luasnip-latex-snippets.util.utils")
local pipe, no_backslash = utils.pipe, utils.no_backslash

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1))
    end
end

local tex_utils = {}
tex_utils.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()
    return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
tex_utils.in_equation = function()
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()
    return tex_utils.in_env('tikzpicture')
end

local math_nobackslash = pipe({ tex_utils.in_mathzone, no_backslash })

return {
    s({ trig = "ti", priority = 99 },
        fmta("\\textit{<>}", { d(1, get_visual) }),
        { condition = no_backslash }
    ),
    s({ trig = "tt", priority = 99 },
        fmta("\\texttt{<>}", { d(1, get_visual) }),
        { condition = no_backslash }
    ),
    s({ trig = "mr", snippetType = "autosnippet", priority = 99 },
        fmta("\\mathrm{<>}", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "mb", snippetType = "autosnippet", priority = 99 },
        fmta("\\mathbf{<>}", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "opn", snippetType = "autosnippet", priority = 99 },
        fmta("\\operatorname{<>}", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "dx", snippetType = "autosnippet", priority = 99 },
        fmta("\\mathrm{d}<>", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "+-", snippetType = "autosnippet", priority = 99 },
        fmta("\\pm<>", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "land", snippetType = "autosnippet", priority = 99 },
        fmta("\\land<>", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "lor", snippetType = "autosnippet", priority = 99 },
        fmta("\\lor<>", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "xor", snippetType = "autosnippet", priority = 99 },
        fmta("\\oplus<>", { d(1, get_visual) }),
        { condition = math_nobackslash }
    ),
    s({ trig = "tb", priority = 99 },
        fmta("\\textbf{<>}", { d(1, get_visual) })
    ),
    s({ trig = "sec", priority = 99 },
        fmta("\\section*{<>}", { i(1) })
    ),
    s({ trig = "ssec", priority = 99 },
        fmta("\\subsection*{<>}", { i(1) })
    ),
    s({ trig = "ff", priority = 99 },
        fmta([[
\begin{figure}[H]
\centering
\includegraphics[width=0.8\textwidth]{<>}
\caption{<>}
\label{<>}
\end{figure}
]], { i(1), i(2), i(3) })
    ),
    s({ trig = "tpl", snippetType = "autosnippet", priority = 99 },
        fmta([[
\documentclass[UTF8, 12pt]{ctexart}

\usepackage{amsmath, amssymb, amsthm}
\usepackage{mathtools}
\usepackage{mathrsfs}

\usepackage[a4paper, margin=1in]{geometry}

\usepackage{algorithm}
\usepackage[noend]{algorithmic}

\usepackage[dvipsnames]{xcolor}
\usepackage{listings}

\usepackage{graphicx}

\usepackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,
    urlcolor=cyan,
    pdftitle={Overleaf Example},
    pdfpagemode=FullScreen,
}

\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{proposition}[theorem]{Proposition}

\renewcommand{\proofname}{\textbf{Proof}}

\newcommand{\E}{\mathbb{E}}
\newcommand{\Var}{\mathrm{Var}}
\newcommand{\Cov}{\mathrm{Cov}}
\newcommand{\Prob}{\mathbb{P}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}

\lstset{
    language=C++,
    basicstyle=\ttfamily\footnotesize,
    breaklines=true,
    keywordstyle=\bfseries\color{NavyBlue},
    morekeywords={},
    emph={self},
    emphstyle=\bfseries\color{Rhodamine},
    commentstyle=\itshape\color{black!50!white},
    stringstyle=\bfseries\color{PineGreen!90!black},
    columns=flexible,
    numbers=left,
    numbersep=5pt,
    numberstyle=\tiny\color{gray},
    frame=single,
    framesep=1em
}

\usepackage{setspace}
\onehalfspacing

\title{<>}
\author{Zhaienhe Zhou \\ \texttt{zehzhou@mail.ustc.edu.cn}}
\date{}
\begin{document}
\maketitle
<>
\end{document}
]], { i(1), i(0) })
    )
}
