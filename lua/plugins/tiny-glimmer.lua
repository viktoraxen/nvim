return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  priority = 10,
  opts = {
    overwrite = {
      yank = {
        enabled = true,
        default_animation = "fade",
      },

      search = {
        enabled = true,
        default_animation = "pulse",
        next_mapping = "n", -- Key for next match
        prev_mapping = "N", -- Key for previous match
      },

      paste = {
        enabled = true,
        default_animation = "fade",
        paste_mapping = "p", -- Paste after cursor
        Paste_mapping = "P", -- Paste before cursor
      },

      undo = {
        enabled = true,
        default_animation = {
          name = "fade",
          settings = {
            from_color = "DiffDelete",
            max_duration = 500,
            min_duration = 500,
          },
        },
        undo_mapping = "u",
      },

      redo = {
        enabled = true,
        default_animation = {
          name = "fade",
          settings = {
            from_color = "DiffAdd",
            max_duration = 500,
            min_duration = 500,
          },
        },
        redo_mapping = "<c-r>",
      },
    },

    -- Override background color for animations (for transparent backgrounds)
    transparency_color = nil,

    animations = {
      fade = {
        max_duration = 400, -- Maximum animation duration in ms
        min_duration = 300, -- Minimum animation duration in ms
        easing = "outQuad", -- Easing function
        chars_for_max_duration = 10, -- Character count for max duration
        from_color = "FadeStart", -- Start color (highlight group or hex)
        to_color = "Normal", -- End color (highlight group or hex)
      },
      reverse_fade = {
        max_duration = 380,
        min_duration = 300,
        easing = "outBack",
        chars_for_max_duration = 10,
        from_color = "Visual",
        to_color = "Normal",
      },
      bounce = {
        max_duration = 500,
        min_duration = 400,
        chars_for_max_duration = 20,
        oscillation_count = 1, -- Number of bounces
        from_color = "Visual",
        to_color = "Normal",
      },
      left_to_right = {
        max_duration = 350,
        min_duration = 350,
        min_progress = 0.85,
        chars_for_max_duration = 25,
        lingering_time = 50, -- Time to linger after completion
        from_color = "FadeStart",
        to_color = "Normal",
      },
      pulse = {
        max_duration = 600,
        min_duration = 400,
        chars_for_max_duration = 15,
        pulse_count = 2, -- Number of pulses
        intensity = 1.2, -- Pulse intensity
        from_color = "Visual",
        to_color = "Normal",
      },

      -- Custom animation example
      custom = {
        max_duration = 350,
        chars_for_max_duration = 40,
        color = "#ff0000", -- Custom property

        -- Custom effect function
        -- @param self table - The effect object with settings
        -- @param progress number - Animation progress [0, 1]
        -- @return string color - Hex color or highlight group
        -- @return number progress - How much of the animation to draw
        effect = function(self, progress)
          return self.settings.color, progress
        end,
      },
    },

    hijack_ft_disabled = {
      "alpha",
      "snacks_dashboard",
    },
  },
  config = function(_, opts)
    require("tiny-glimmer").setup(opts)

    require("highlights-nvim").add({
      customizations = {
        FadeStart = { bg = "#CBA6F7" },
      },
    })
  end,
}
