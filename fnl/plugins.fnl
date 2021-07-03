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

;; telescope
(local telescope (require :telescope))
((. telescope :load_extension) :arecibo)

;; gitsigns
((. (require :gitsigns) :setup) {:keymaps {}})

;; neorg
((. (require :neorg) :setup)
 {:load
  {:core.defaults {}
   :core.norg.concealer {}
   :core.keybinds {}
   :core.norg.dirman
   {:config
    {:workspaces
     {:wiki "~/wiki"}
     :autodetect true
     :autochdir true}}}})	

;; nvim-compe
((. (require :compe) :setup)
 {:enabled true
  :autocomplete true
  :debug false
  :preselect :enable
  :throttle_time 80
  :source_timeout 200
  :resolve_timeout 800
  :incomplete_delay 400
  :max_abbr_width 100
  :max_kind_width 100
  :max_menu_width 100
  :documentation true
  :source {:path true :buffer true :nvim_lsp true }})
