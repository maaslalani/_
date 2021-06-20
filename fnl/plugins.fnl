(module plugins)

;; nordbuddy
((. (require :colorbuddy) :colorscheme) :nordbuddy)	

;; autopairs
((. (require :nvim-autopairs) :setup))	

;; colorizer
((. (require :colorizer) :setup) ["*"])

;; lualine
((. (require :lualine) :setup) {:options {:theme :nord}})

;; treesitter
((. (require :nvim-treesitter.configs) :setup)
 {:highlight {:enable true}
  :indent {:enable true}})	

;; gitsigns
((. (require :gitsigns) :setup) {:keymaps {}})
