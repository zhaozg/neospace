std = "luajit"
codes = true
max_line_length = 120
max_comment_line_length = false

self = false

read_globals = {
    "vim"
}

globals = {
    vim = {
        fields = {
            "g"
        }
    }
}

-- special files {{{
files["lua/neospace/fun.lua"] = {
    ignore = {"211", "212", "213", "411", "412", "421", "422"}
}
files["lua/impatient.lua"] = { ignore={"121"} }
files["lua/impatient"] = { ignore={"121", "122"} }
-- special files }}}

-- vim: set ft=lua ts=2 sw=2 et
