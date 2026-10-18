SMODS.Joker({
    key = 'caffeine',
    atlas = 'aws_caffeine',
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            odds = 2
        }
    },

    loc_txt = {
        name = 'Caffeine',
        text = {
            '{C:green}#1# in #2#{} chance to',
            'retrigger each played {C:spades}Spade{} card'
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                SMODS.get_probability_vars(
                    card,
                    1,
                    card.ability.extra.odds,
                    'aws_caffeine'
                )
            }
        }
    end,

    rarity = 2,
    cost = 5,

    calculate = function(self, card, context)
        if context.repetition
            and context.cardarea == G.play
            and not context.retrigger_joker
            and context.other_card
            and context.other_card:is_suit('Spades') then

            if pseudorandom('aws_caffeine') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})