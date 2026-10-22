local original_main_menu = Game.main_menu

function Game:main_menu(change_context)
    -- Create the normal Balatro main menu first
    original_main_menu(self, change_context)
    -- Apply the monochrome splash shader
    if G.SPLASH_BACK then
        G.SPLASH_BACK:define_draw_steps({
            {
                shader = 'splash',
                send = {
                    {
                        name = 'time',
                        ref_table = G.TIMERS,
                        ref_value = 'REAL_SHADER'
                    },
                    {
                        name = 'vort_speed',
                        val = 0.4
                    },
                    {
                        name = 'colour_1',
                        ref_table = G.C,
                        ref_value = 'WHITE'
                    },
                    {
                        name = 'colour_2',
                        ref_table = G.C,
                        ref_value = 'BLACK'
                    },
                    {
                        name = 'mid_flash',
                        val = 0
                    },
                    {
                        name = 'vort_offset',
                        val = 0
                    }
                }
            }
        })
    end
end
