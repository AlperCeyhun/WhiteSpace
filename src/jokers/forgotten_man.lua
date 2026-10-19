SMODS.Joker({
    key = 'forgotten_man',
    atlas = 'aws_forgotten_man',
    pos = { x = 0, y = 0 },

    rarity = 3,
    cost = 10,

    config = {
        extra = {
            bought_egg = false,
            last_ante = nil
        }
    },

    loc_txt = {
        name = 'Forgotten Man',
        text = {
            'Create an {C:attention}Egg{} when purchased',
            'and at the start of each {C:attention}Ante{}',
            '{C:inactive}There is not a man there..{}'
        }
    },

    calculate = function(self, card, context)
        local extra = card.ability.extra

        if context.buying_card
            and context.card == card
            and not extra.bought_egg then

            extra.bought_egg = true
            extra.last_ante = G.GAME.round_resets.ante

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    SMODS.add_card({
                        set = 'Joker',
                        key = 'j_egg',
                        area = G.jokers
                    })
                    return true
                end
            }))

            return {
                message = 'Egg!',
                colour = G.C.ORANGE
            }
        end

        if context.ante_change
            and context.ante_end
            and not context.blueprint
            and extra.last_ante ~= G.GAME.round_resets.ante then

            extra.last_ante = G.GAME.round_resets.ante

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    SMODS.add_card({
                        set = 'Joker',
                        key = 'j_egg',
                        area = G.jokers
                    })
                    return true
                end
            }))

            return {
                message = 'Egg!',
                colour = G.C.ORANGE
            }
        end
    end
})