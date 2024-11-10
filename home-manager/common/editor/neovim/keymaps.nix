{
  programs.nixvim.keymaps = let
    map = mode: key: action: desc: {
      inherit mode key action;
      options.desc = desc;
    };
  in [
    # Clear search with ESC
    (map ["n" "i"] "<esc>" "<cmd>noh<cr><esc>" "Clear Search")

    # Cut/Paste without saving to register
    (map ["v"] "<leader>ep" "[[\"_dP]]" "Paste w/o register")
    (map ["n"] "<leader>ed" "[[viw\"_d]]" "Delete word w/o register")
    (map ["v"] "<leader>ed" "[[\"_d]]" "Delete w/o register")

    # Move to the beginning or end of line with H and L
    (map ["n" "v"] "H" "^" "Move beginning of line")
    (map ["n"] "L" "$" "Move end of line")
    (map ["v"] "L" "g_" "Move end of line")

    # Center cursor after jumps
    (map ["n"] "<C-d>" "<C-d>zz" "Center cursor after jump")
    (map ["n"] "<C-u>" "<C-u>zz" "Center cursor after jump")
    (map ["n"] "n" "nzzzv" "Center cursor after jump")
    (map ["n"] "N" "Nzzzv" "Center cursor after jump")

    # Add conceallevel toggle
    (
      map ["n"] "<leader>tu" ''
        function()
          local winnr = vim.api.nvim_get_current_win()
          local conceallevel = vim.api.nvim_win_get_option(winnr, "conceallevel")
          local newconceallevel = math.fmod(conceallevel + 1, 4)
          vim.opt.conceallevel = newconceallevel
        end
      '' "Toggle 'conceallevel'"
    )
  ];
}
