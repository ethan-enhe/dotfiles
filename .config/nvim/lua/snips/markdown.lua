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
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

local math_nobackslash = pipe({ utils.with_opts(utils.is_math, true), no_backslash })

return {
	s({ trig = "ti", priority = 99 }, fmta("\\textit{<>}", { d(1, get_visual) }), { condition = math_nobackslash }),
	s({ trig = "tt", priority = 99 }, fmta("\\texttt{<>}", { d(1, get_visual) }), { condition = math_nobackslash }),
	s(
		{ trig = "mr", snippetType = "autosnippet", priority = 99 },
		fmta("\\mathrm{<>}", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "mb", snippetType = "autosnippet", priority = 99 },
		fmta("\\mathbf{<>}", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "opn", snippetType = "autosnippet", priority = 99 },
		fmta("\\operatorname{<>}", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "dx", snippetType = "autosnippet", priority = 99 },
		fmta("\\mathrm{d}<>", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "+-", snippetType = "autosnippet", priority = 99 },
		fmta("\\pm<>", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "land", snippetType = "autosnippet", priority = 99 },
		fmta("\\land<>", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "lor", snippetType = "autosnippet", priority = 99 },
		fmta("\\lor<>", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s(
		{ trig = "xor", snippetType = "autosnippet", priority = 99 },
		fmta("\\oplus<>", { d(1, get_visual) }),
		{ condition = math_nobackslash }
	),
	s({ trig = "tb", priority = 99 }, fmta("\\textbf{<>}", { d(1, get_visual) })),
	s({ trig = "a", dscr = "Link" }, fmta("[<>](<>)", { i(1, "text"), i(2, "url") })),
	s({ trig = "lem", dscr = "Lemma" }, fmta("**Lemma**: <>", { d(1, get_visual) })),
	s({ trig = "thm", dscr = "Theorem" }, fmta("**Theorem**: <>", { d(1, get_visual) })),
	s({ trig = "cor", dscr = "Corollary" }, fmta("**Corollary**: <>", { d(1, get_visual) })),
	s({ trig = "prop", dscr = "Proposition" }, fmta("**Proposition**: <>", { d(1, get_visual) })),
	s({ trig = "def", dscr = "Definition" }, fmta("**Definition**: <>", { d(1, get_visual) })),
	s({ trig = "proof", dscr = "Proof" }, fmta("**Proof**: <>", { d(1, get_visual) })),
	s({ trig = "ex", dscr = "Example" }, fmta("**Example**: <>", { d(1, get_visual) })),
	s({ trig = "rem", dscr = "Remark" }, fmta("**Remark**: <>", { d(1, get_visual) })),
}
