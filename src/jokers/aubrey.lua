SMODS.Joker({
    key = 'aubrey',
    atlas = 'aws_placeholders',
    pos = {
        x = 2,
        y = 0
    },

    rarity = 3,
    cost = 6,

    loc_txt = {
        name = 'Aubrey',
        text = {
            'Gain {X:mult,C:white}X0.5{} Mult',
            'for every {C:money}$5{} below {C:money}$25{}',
            '{C:inactive}Currently {X:mult,C:white}X#1#{} {C:inactive}Mult'
        }
    },

    loc_vars = function(self, info_queue, card)
        local dollars = G.GAME and G.GAME.dollars or 0
        local steps = math.max(0, math.floor((25 - dollars) / 5))
        local x_mult = 1 + steps * 0.5

        return {
            vars = { x_mult }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local dollars = G.GAME.dollars or 0
            local steps = math.max(0, math.floor((25 - dollars) / 5))
            local x_mult = 1 + steps * 0.5

            if x_mult > 1 then
                return {
                    x_mult = x_mult
                }
            end
        end
    end
})