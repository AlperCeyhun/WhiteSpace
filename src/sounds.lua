SMODS.Sound({
    key = "music_main_theme",
    path = "aws_main_theme.ogg",
    volume = 0.6,
    pitch = 1,
    select_music_track = function(self)
        if G.STAGE == G.STAGES.MAIN_MENU then
            return 100
        end
        return nil
    end
})