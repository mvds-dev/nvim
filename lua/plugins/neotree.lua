return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", 
        "MunifTanjim/nui.nvim",
    },
    opts = function()
        vim.keymap.set('n','<leader>e',':Neotree toggle<CR>', {silent = true, noremap=true})
        require('neo-tree').setup({
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                }
            }
        })

    end
}

