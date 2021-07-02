(module variables
  {autoload {nvim aniseed.nvim}})

;; <Space>
(set nvim.g.mapleader " ")

;; diagnostic options
(set nvim.g.diagnostic_auto_popup_while_jump 0)
(set nvim.g.diagnostic_enable_underline 1)
(set nvim.g.diagnostic_enable_virtual_text 1)
(set nvim.g.diagnostic_insert_delay 0)

;; netrw options
(set nvim.g.netrw_banner 0)
(set nvim.g.localcoptydircmd "cp -r")
(set nvim.g.rmdir_cmd "rm -r")

;; completion
(set nvim.g.completion_chain_complete_list
     {:default
      {:comment {}
       :default [{:complete_items [:lsp :snippet]}
                 {:mode :<c-p>}
                 {:mode :<c-n>}]
       :string [{:complete_items [:path]}]}})
