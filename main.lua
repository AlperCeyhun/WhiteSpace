-- Aubrey's White Space: sounds
assert(SMODS.load_file("src/sounds.lua"))()

-- Aubrey's White Space: Atlases
assert(SMODS.load_file("src/atlases.lua"))()

-- Aubrey's White Space: jokers
local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

-- Aubrey's White Space: monochrome main menu
assert(SMODS.load_file("backgrounds/monochrome.lua"))()

SMODS.current_mod.menu_cards = function()
    return {
        { key = "j_aws_delinquent" }
    }
end