local M = {}

local options = function(prefix)
    return {
        b = prefix .. " background",
        c = prefix .. " cursorline",
        d = prefix .. " diff",
        h = prefix .. " hlsearch",
        i = prefix .. " ignorecase",
        l = prefix .. " list",
        n = prefix .. " number",
        r = prefix .. " relativenumber",
        s = prefix .. " spell",
        t = prefix .. " colorcolumn",
        u = prefix .. " cursorcolumn",
        v = prefix .. " virtualedit",
        w = prefix .. " wrap",
        x = prefix .. " cursorline + cursorcolumn",
    }
end

local previous = function(isPrevious)
    local above = isPrevious and "above" or "below"
    local prev = isPrevious and "prev" or "next"
    local first = isPrevious and "first" or "last"
    local last = isPrevious and "last" or "first"
    local p = {
        p = "put " .. above,
        P = "put " .. above,
        a = prev .. " file in argument list", --next
        A = first .. " file in the argument list.", --last
        q = prev .. " quickfix entry", --cnext
        Q = first .. " quickfix entry", --clast
        t = prev .. " matching tag", --tnext
        T = first .. " matching tag", --tlast
        l = prev .. " locationlist entry", --lnext
        L = first .. " locationlist entry", --llast
        b = prev .. " buffer in buffer list", --bnext
        B = first .. " buffer in buffer list", --blast
        f = prev .. " file in directory",
        n = prev .. " prev conflict/diff/hunk",
        e = "exchange line with lines " .. above,
        ["<Space>"] = "add blank lines " .. above,
        ["<C-L>"] = last .. " entry in " .. prev .. " file in locationlist", --lnfile
        ["<C-Q>"] = last .. " entry in " .. prev .. " file in quickfixlist", --cnfile
        ["<C-T>"] = prev .. " matching tag in preview window", --ptnext
    }
    local pp = {}
    for k, v in pairs(p) do
        -- make first char in each str uppercase, and wrap in table
        pp[k] = v:gsub("^%l", string.upper)
    end
    return pp
end

local decoders = function()
    local keyDecoderName = {
        u = "URL",
        x = "XML",
        C = "C String",
        y = "C String",
    }
    local decoderMaps = {}
    for k, decoderName in pairs(keyDecoderName) do
        decoderMaps["[" .. k] = decoderName .. " encode"
        decoderMaps["[" .. k .. k] = decoderName .. " encode line"
        decoderMaps["]" .. k] = decoderName .. " decode"
        decoderMaps["]" .. k .. k] = decoderName .. " decode line"
    end
    return decoderMaps
end

M.normal_and_visual_mode = decoders()

M.normal_mode = {
    ["<lt>"] = { -- cant use <
        P = "Paste before linewise, decreasing indent",
        p = "Paste after linewise, decreasing indent",
        s = vim.tbl_extend("error", options("Enable"), { name = "+Enable" })
    },
    ["["]    = vim.tbl_extend("error", previous(true), {
        name = "+Previous",
        o = vim.tbl_extend("error", options("Enable"), { name = "+Enable" })
    }),
    ["]"]    = vim.tbl_extend("error", previous(false), {
        name = "+Next",
        o = vim.tbl_extend("error", options("Disable"), { name = "+Disable" })
    }),
    [">"]    = {
        P = "Paste before linewise, increasing indent",
        p = "Paste after linewise, increasing indent",
        s = vim.tbl_extend("error", options("Disable"), { name = "+Disable" }),
    },
    y        = {
        o = vim.tbl_extend("error", options("Toggle"), { name = "+Toggle" }),
    },
    ["="]    = {
        P = "Paste before linewise, reindenting",
        p = "Paste after linewise, reindenting",
        s = vim.tbl_extend("error", options("Toggle"), { name = "+Toggle" })
    },
}

return M
