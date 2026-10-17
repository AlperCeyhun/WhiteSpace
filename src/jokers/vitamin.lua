SMODS.Joker({
    key = 'vitamin',
    atlas = 'placeholders',
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            chips = 0,
            mult = 0,
            chip_mod = 10,
            mult_mod = 1
        }
    },

    loc_txt = {
        name = 'Vitamin',
        text = {
            'Gains {C:chips}+10{} Chips and',
            '{C:mult}+1{} Mult after each played hand',
            'Currently {C:chips}+#1#{} Chips',
            'and {C:mult}+#2#{} Mult'
        }
    },

    rarity = 1,
    cost = 4,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)

        -- Apply the accumulated bonuses during scoring
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end

        -- Grow after each played hand
        if context.after and not context.blueprint then
            card.ability.extra.chips =
                card.ability.extra.chips + card.ability.extra.chip_mod

            card.ability.extra.mult =
                card.ability.extra.mult + card.ability.extra.mult_mod

            return {
                message = 'Upgraded!',
                colour = G.C.MULT
            }
        end
    end
})