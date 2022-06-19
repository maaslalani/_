;; ============================================================================
;; Hammerspoon
;; ============================================================================

;; Spoons
(hs.loadSpoon :SpoonInstall)

;; Password Manager
(local context [{:antialias true
                 :strokeColor {:white 0.8 :alpha 0.6}
                 :fillColor {:alpha 0}}])

(local image (hs.image.imageFromASCII "
· · · · · · · · · ·
· · · · 1 · · · · ·
· · · · · · · · · ·
· · 1 · · · 1 · · ·
· · · · · · · · · ·
· · · · 1 · · · · ·
· · · · · · · · · ·" context))

(local PassChooser (hs.loadSpoon :PassChooser))
(PassChooser:init {:clearAfter 10 :storePath "~/.local/share/pass/" : image})

;; Pop up Style
(set hs.alert.defaultStyle.fillColor {:white 0 :alpha 0.8})
(set hs.alert.defaultStyle.padding 40)
(set hs.alert.defaultStyle.radius 10)
(set hs.alert.defaultStyle.strokeColor {:white 0.2})
(set hs.alert.defaultStyle.strokeWidth 5)
(set hs.alert.defaultStyle.textStyle
     {:font {:name "SF Mono Medium" :size 20 :color {:white 0.8 :alpha 0.8}}
      :paragraphStyle {:lineHeightMultiple 1.25}})

(hs.alert.show "Hammerspoon Loaded" 1)
(set hs.window.animationDuration 0)

;; Grid styles
(hs.grid.setGrid :6x4)
(set hs.grid.ui.cellColor [0 0 0 0.25])
(set hs.grid.ui.cellStrokeColor [0.5 0.5 0.5 0.5])
(set hs.grid.ui.cellStrokeWidth 2)
(set hs.grid.ui.cyclingHighlightColor [0.5 0.5 0.5 0.2])
(set hs.grid.ui.cyclingHighlightStrokeColor [0.5 0.5 0.5 0.5])
(set hs.grid.ui.highlightColor [0.5 0.5 0.5 0.2])
(set hs.grid.ui.highlightStrokeColor [0.5 0.5 0.5 0.5])
(set hs.grid.ui.highlightStrokeWidth 2)
(set hs.grid.ui.selectedColor [0.6 0.6 0.6 0.2])
(set hs.grid.ui.textColor [1 1 1])
(set hs.grid.ui.textFont "SF Mono Medium")
(set hs.grid.ui.textSize 100)

;; Application and URL launchers
(fn launch [application]
  (fn []
    (hs.application.launchOrFocus application)))

(fn openurl [url]
  (fn []
    (hs.urlevent.openURL url)))

;; Menu, inspired by which-key
;; Open the menu with the leader key (ctrl+space)
;; Key sequence (defined by nested table keys) will perform the action
(local menu {:a {:name :Applications
                 :b {:name :Browser :action (launch :Arc)}
                 :c {:name :Calendar :action (launch :Calendar)}
                 :n {:name :Notes :action (launch :Notes)}
                 :r {:name :Reminders :action (launch :Reminders)}
                 :s {:name :Slack :action (launch :Slack)}
                 :t {:name :Terminal :action (launch :Kitty)}}
             :f {:name :Focus
                 :action (fn []
                           (hs.hints.windowHints))}
             :g {:name :Grid
                 :action (fn []
                           (hs.grid.show))}
             :l {:name :Links
                 :g {:name :GitHub
                     :g {:name :Home :action (openurl "https://github.com/")}
                     :n {:name :Notifications
                         :action (openurl "https://github.com/notifications")}
                     :p {:name :Pulls
                         :action (openurl "https://github.com/pulls")}}
                 :s {:name :StackOverflow
                     :action (openurl "https://stackoverflow.com")}
                 :t {:name :Twitter :action (openurl "https://twitter.com")}
                 :y {:name :YouTube :action (openurl "https://youtube.com")}}
             :p {:name :Passwords
                 :action (fn []
                           (PassChooser:start))}
             :r {:name :Reload :action hs.reload}})

;; Leader key (ctrl+space)
(local start (hs.hotkey.modal.new [:ctrl] :space))
(local modalWidth 20)

;; Menu:
;; ┌──────────────────────┐
;; │ a       Applications │
;; │ p          Passwords │
;; │ r             Reload │
;; │ l              Links │
;; │ w             Window │
;; │ f              Focus │
;; │ g               Grid │
;; └──────────────────────┘
;;
;; Pressing the key (left) will either open up another menu
;; or perform an action, key sequences are determined by nested keys
;; in the `menu` table
(fn setup [modal menu]
  (fn modal.exited [self]
    (hs.alert.closeAll))

  (modal:bind {} :escape (fn []
                           (modal:exit)))
  (local display {})
  (each [k v (pairs menu)]
    (when (= (type v) :table)
      (tset display (+ (length display) 1)
            (.. k (string.rep " " (- modalWidth (length v.name))) v.name))
      (var action {})
      (if (not= v.action nil)
          (set action v.action)
          (let [submenu (hs.hotkey.modal.new)]
            (setup submenu v)
            (set action (fn []
                          (submenu:enter)))))
      (modal:bind {} k (fn []
                         (when (not= v.repeatable true)
                           (modal:exit))
                         (action)))))

  (fn modal.entered [self]
    (hs.alert.closeAll)
    (hs.alert (table.concat display "\n") true)))

(setup start menu)
