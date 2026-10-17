SMODS.Joker({
    key = 'coffee',
    atlas = 'placeholders',
    pos = {
        x = 1,
        y = 0
    },

    config = {
        extra = {
            odds = 2
        }
    },

    loc_txt = {
        name = 'Coffee',
        text = {
            '{C:green}1 in 2{} chance to',
            'retrigger each played card'
        }
    },

    rarity = 2,
    cost = 5,

    calculate = function(self, card, context)
        if context.repetition
            and context.cardarea == G.play
            and not context.retrigger_joker then

            if pseudorandom('aws_coffee') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})