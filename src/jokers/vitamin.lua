
SMODS.Joker({
    key = 'vitamins',
    atlas = 'aws_vitamins',
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            chips = 100,
            mult = 20,
            chip_mod = 5,
            mult_mod = 1,
            consumed = false
        }
    },

    loc_txt = {
        name = 'Vitamins',
        text = {
            '{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult',
            'Loses {C:chips}5{} Chips and {C:mult}1{} Mult',
            'after each played hand'
        }
    },
    rarity = 1,
    cost = 6,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        local extra = card.ability.extra

        -- Apply current bonuses during scoring
        if context.joker_main then
            return {
                chips = extra.chips,
                mult = extra.mult
            }
        end

        -- Deplete after each played hand
        if context.after
            and context.main_eval
            and not context.blueprint
            and not extra.consumed then

            extra.chips = math.max(0, extra.chips - extra.chip_mod)
            extra.mult = math.max(0, extra.mult - extra.mult_mod)

            -- Remove Vitamins when both stats reach zero
            if extra.chips <= 0 and extra.mult <= 0 then
                extra.consumed = true

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        SMODS.destroy_cards(card, {
                            bypass_eternal = true
                        })
                        return true
                    end
                }))

                return {
                    message = 'Consumed!',
                    colour = G.C.RED
                }
            end

            return {
                message = 'Taken!',
                colour = G.C.MULT
            }
        end
    end
})