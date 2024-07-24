-- Abbreviations used in this article and the LuaSnip docs
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

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
  return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
  return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
  return tex_utils.in_env('tikzpicture')
end

return {
  -- Example: italic font implementing visual selection
  s({
    trig="ti",
    -- snippetType="autosnippet",
    priority=99
  },
    fmta("\\textit{<>}",
      {
        d(1, get_visual),
      })
  ),
  s({
    trig="tt",
    -- snippetType="autosnippet",
    priority=99
  },
    fmta("\\texttt{<>}",
      {
        d(1, get_visual),
      })
  ),
  s({
    trig="mr",
    snippetType="autosnippet",
    priority=99
  },
    fmta("\\mathrm{<>}",
      {
        d(1, get_visual),
      }),
    {condition=tex_utils.in_mathzone}
  ),
  s({
    trig="mb",
    snippetType="autosnippet",
    priority=99
  },
    fmta("\\mathbf{<>}",
      {
        d(1, get_visual),
      }),
    {condition=tex_utils.in_mathzone}
  ),
  s({
    trig="dx",
    snippetType="autosnippet",
    priority=99
  },
    fmta("\\mathrm{d}<>",
      {
        d(1, get_visual),
      }),
    {condition=tex_utils.in_mathzone}
  ),
  s({
    trig="tb",
    -- snippetType="autosnippet",
    priority=99
  },
    fmta("\\textbf{<>}",
      {
        d(1, get_visual),
      })
  ),
  s({
    trig="sec",
    -- snippetType="autosnippet",
    priority=99
  },
    fmta([[
    \section*{<>}
    ]],
      {
        i(1),
      })
  ),
  s({
    trig="ssec",
    -- snippetType="autosnippet",
    priority=99
  },
    fmta([[
    \subsection*{<>}
    ]],
      {
        i(1),
      })
  ),
  s({
    trig="ff",
    -- snippetType="autosnippet",
    priority=99
  },
    fmta([[
\begin{figure}[H]
\centering 
\includegraphics[width=0.8\textwidth]{<>} 
\caption{<>} 
\label{<>} 
\end{figure}
  ]],{
        i(1),i(2),i(3)}
    )
  ),
  s({
    trig="tpl",
    snippetType="autosnippet",
    priority=99
  },fmta([[
\documentclass[UTF8, 12pt]{ctexart} % 设置默认字体大小为 12pt

% 使用更适合论文的数学包和字体设置
\usepackage{amsmath, amssymb, amsthm}
\usepackage{mathtools} % 提供 amsmath 的扩展
\usepackage{mathrsfs} % 提供花体字体

% 设置页面几何结构
\usepackage[a4paper, margin=1in]{geometry}

% 设置算法环境
\usepackage{algorithm}
\usepackage[noend]{algorithmic} % 去掉end关键字，更简洁

% 设置颜色和代码高亮
\usepackage[dvipsnames]{xcolor}
\usepackage{listings}

% 图形支持
\usepackage{graphicx}

% 超链接
\usepackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,
    urlcolor=cyan,
    pdftitle={Overleaf Example},
    pdfpagemode=FullScreen,
}

% 定理环境
\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{proposition}[theorem]{Proposition}

\renewcommand{\proofname}{\textbf{Proof}}

% 自定义命令
\newcommand{\E}{\mathbb{E}}
\newcommand{\Var}{\mathrm{Var}}
\newcommand{\Cov}{\mathrm{Cov}}
\newcommand{\Prob}{\mathbb{P}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}

% 设置代码样式
\lstset{
    language=C++, % 设置语言
    basicstyle=\ttfamily\footnotesize, % 设置字体族和大小
    breaklines=true, % 自动换行
    keywordstyle=\bfseries\color{NavyBlue}, % 设置关键字为粗体，颜色为 NavyBlue
    morekeywords={}, % 设置更多的关键字，用逗号分隔
    emph={self}, % 指定强调词，如果有多个，用逗号隔开
    emphstyle=\bfseries\color{Rhodamine}, % 强调词样式设置
    commentstyle=\itshape\color{black!50!white}, % 设置注释样式，斜体，浅灰色
    stringstyle=\bfseries\color{PineGreen!90!black}, % 设置字符串样式
    columns=flexible,
    numbers=left, % 显示行号在左边
    numbersep=5pt, % 设置行号的具体位置
    numberstyle=\tiny\color{gray}, % 缩小行号并设置颜色
    frame=single, % 边框
    framesep=1em % 设置代码与边框的距离
}

% 设置行距
\usepackage{setspace}
\onehalfspacing % 1.5倍行距

% 文章信息
\title{<>}
\author{Zhaienhe Zhou \\ \texttt{zehzhou@mail.ustc.edu.cn}}
\date{}
\begin{document}
\maketitle
<>
\end{document}
  ]],{i(1),i(0)}))
}
