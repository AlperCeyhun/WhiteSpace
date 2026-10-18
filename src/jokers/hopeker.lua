SMODS.Joker({
    key = 'hopeker',
    atlas = 'aws_hopeker',
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            used = false
        }
    },

    loc_txt = {
        name = 'Hopeker',
        text = {
            'On defeat, prevent loss and',
            'destroy this Joker to create',
            'a random {C:red}Rare{} Joker and earn {C:money}$25{}'
        }
    },

    rarity = 3,
    cost = 6,
    blueprint_compat = false,

    calculate = function(self, card, context)
        if context.game_over
            and not context.blueprint
            and not card.ability.extra.used then

            card.ability.extra.used = true

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    -- Remove Hopeker first to free its Joker slot
                    SMODS.destroy_cards(card, {
                        bypass_eternal = true,
                        immediate = true
                    })

                    -- Give the player $25
                    ease_dollars(25)

                    -- Find every eligible Rare Joker
                    local rare_pool = {}
                    local unique_pool = {}
                    local owned_keys = {}

                    -- Record all Jokers currently owned
                    for _, owned_card in ipairs(G.jokers.cards) do
                        if owned_card ~= card
                            and owned_card.config
                            and owned_card.config.center then

                            owned_keys[owned_card.config.center.key] = true
                        end
                    end

                    -- Build the Rare Joker pool, excluding Hopeker
                    for _, center in ipairs(G.P_CENTER_POOLS.Joker) do
                        if center.rarity == 3
                            and center.key ~= 'j_aws_hopeker' then

                            rare_pool[#rare_pool + 1] = center

                            -- Prefer Jokers the player doesn't own
                            if not owned_keys[center.key] then
                                unique_pool[#unique_pool + 1] = center
                            end
                        end
                    end

                    -- Use unique Jokers first; allow duplicates
                    -- only when every eligible Rare is already owned
                    local chosen_pool = #unique_pool > 0
                        and unique_pool
                        or rare_pool

                    if #chosen_pool > 0 then
                        local chosen = pseudorandom_element(
                            chosen_pool,
                            pseudoseed('aws_hopeker')
                        )

                        SMODS.add_card({
                            key = chosen.key,
                            set = 'Joker',
                            area = G.jokers,
                            key_append = 'aws_hopeker'
                        })
                    end

                    return true
                end
            }))

            return {
                saved = true,
                message = 'Hopium!',
                colour = G.C.GREEN
            }
        end
    end
})