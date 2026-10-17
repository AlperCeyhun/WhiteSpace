-- Aubrey's White Space: Attlases

SMODS.Atlas({
    key = 'vitamins',
    path = 'vitamins_placeholder.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'placeholders',
    path = 'placeholders.png',
    px = 71,
    py = 95
})

-- Aubrey's White Space: jokers
local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end


-- Aubrey's White Space: monochrome main menu
assert(SMODS.load_file("backgrounds/monochrome.lua"))()