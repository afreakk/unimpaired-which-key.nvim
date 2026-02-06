local M = {}

local options = function(keyPrefix, namePrefix)
    return {
        { keyPrefix, group = namePrefix },
        { keyPrefix .. "b", desc = namePrefix .. " background" },
        { keyPrefix .. "c", desc = namePrefix .. " cursorline" },
        { keyPrefix .. "d", desc = namePrefix .. " diff" },
        { keyPrefix .. "h", desc = namePrefix .. " hlsearch" },
        { keyPrefix .. "i", desc = namePrefix .. " ignorecase" },
        { keyPrefix .. "l", desc = namePrefix .. " list" },
        { keyPrefix .. "n", desc = namePrefix .. " number" },
        { keyPrefix .. "r", desc = namePrefix .. " relativenumber" },
        { keyPrefix .. "s", desc = namePrefix .. " spell" },
        { keyPrefix .. "t", desc = namePrefix .. " colorcolumn" },
        { keyPrefix .. "u", desc = namePrefix .. " cursorcolumn" },
        { keyPrefix .. "v", desc = namePrefix .. " virtualedit" },
        { keyPrefix .. "w", desc = namePrefix .. " wrap" },
        { keyPrefix .. "x", desc = namePrefix .. " cursorline + cursorcolumn" },
    }
end

local previous = function(keyPrefix, groupName, isPrevious)
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
    local pp = {
        { keyPrefix, group = groupName },
    }
    for k, v in pairs(p) do
        -- make first char in each str uppercase, and wrap in table
        table.insert(pp, { keyPrefix .. k, desc = v:gsub("^%l", string.upper) })
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
        table.insert(decoderMaps, {
            mode = { "n" },
            { "[" .. k .. k, desc = decoderName .. " encode line" },
            { "]" .. k .. k, desc = decoderName .. " decode line" },
        })
        table.insert(decoderMaps, {
            mode = { "v" },
            { "[" .. k, desc = decoderName .. " encode" },
            { "]" .. k, desc = decoderName .. " decode" },
        })
    end
    return decoderMaps
end


local normals = function()
    local normalMaps = {
        mode = { "n" },
    }

    vim.list_extend(normalMaps, {
        { "<P", desc = "Paste before linewise, decreasing indent" },
        { "<p", desc = "Paste after linewise, decreasing indent" },
    })
    vim.list_extend(normalMaps, options("<s", "Enable"))
    vim.list_extend(normalMaps, previous("[", "Previous", true))
    vim.list_extend(normalMaps, options("[o", "Enable"))
    vim.list_extend(normalMaps, previous("]", "Next", false))
    vim.list_extend(normalMaps, options("]o", "Disable"))
    vim.list_extend(normalMaps, {
        { ">P", desc = "Paste before linewise, increasing indent" },
        { ">p", desc = "Paste after linewise, increasing indent" },
    })
    vim.list_extend(normalMaps, options(">s", "Disable"))
    vim.list_extend(normalMaps, options("yo", "Toggle"))
    vim.list_extend(normalMaps, {
        { "=P", desc = "Paste before linewise, reindenting" },
        { "=p", desc = "Paste after linewise, reindenting" },
    })
    vim.list_extend(normalMaps, options("=s", "Toggle"))

    return normalMaps
end

vim.list_extend(M, decoders())
table.insert(M, normals())

-- Recommended triggers for which-key v3.
-- Keys like y, <, >, = are Vim operators, so which-key's <auto> trigger
-- won't intercept them (doing so would break yank, indent, etc.).
-- These multi-character triggers let which-key show the popup after the
-- full prefix is typed, avoiding operator-pending conflicts.
M.triggers = {
    { "yo", mode = "n" },
    { "[o", mode = "n" },
    { "]o", mode = "n" },
    { "<s", mode = "n" },
    { ">s", mode = "n" },
    { "=s", mode = "n" },
}

return M
