(set hs.alert.defaultStyle.fillColor {:white 0 :alpha 0.8})
(set hs.alert.defaultStyle.padding 22)
(set hs.alert.defaultStyle.radius 2)
(set hs.alert.defaultStyle.strokeColor {:white 1 :alpha 0.25})
(set hs.alert.defaultStyle.strokeWidth 5)
(set hs.alert.defaultStyle.textColor {:white 1 :alpha 0.8})
(set hs.alert.defaultStyle.textFont :Menlo)
(set hs.alert.defaultStyle.textSize 18)

(hs.alert.show "Hammerspoon Loaded" 1)

(set hs.window.animationDuration 0)

(hs.grid.setGrid :6x4)

(set hs.grid.ui.cellColor [0 0 0 0.25])
(set hs.grid.ui.cellStrokeColor [0.2 0.2 0.2])
(set hs.grid.ui.cellStrokeWidth 5)
(set hs.grid.ui.cyclingHighlightColor [0.2 0.2 0.2 0.5])
(set hs.grid.ui.cyclingHighlightStrokeColor [0.2 0.2 0.2 1])
(set hs.grid.ui.highlightColor [0.2 0.2 0.2 0.5])
(set hs.grid.ui.highlightStrokeColor [0.8 0.8 0.8 1])
(set hs.grid.ui.highlightStrokeWidth 10)
(set hs.grid.ui.selectedColor [0.6 0.6 0.6 0.2])
(set hs.grid.ui.textColor [1 1 1])
(set hs.grid.ui.textSize 150)

(fn launch [application]
  (fn []
    (hs.application.launchOrFocus application)))

(fn openurl [url]
  (fn []
    (hs.urlevent.openURL url)))

(local menu
  {:a {:name :Applications
       :a {:name :Alacritty :action (launch :Alacritty)}
       :b {:name :Brave :action (launch "Brave Browser")}
       :c {:name :Calendar :action (launch :Calendar)}
       :p {:name :1Password :action (launch "1Password 7")}
       :r {:name :Reminders :action (launch :Reminders)}
       :s {:name :Slack :action (launch :Slack)}
       :t {:name :Tuple :action (launch :Tuple)}
       :n {:name :Notes :action (launch :Notes)}}
   :l {:name :Links
       :g {:name :GitHub
           :g {:name :Home :action (openurl :https://github.com/)}
           :n {:name :Notifications :action (openurl :https://github.com/notifications)}
           :p {:name :Pulls :action (openurl :https://github.com/pulls)}}
       :t {:name :Twitter :action (openurl :https://twitter.com)}
       :y {:name :YouTube :action (openurl :https://youtube.com)}
       :y {:name :YouTube :action (openurl :https://youtube.com)}
       }
   :g {:name :Grid :action (fn [] (hs.grid.show))}
   :f {:name :Focus :action (fn [] (hs.hints.windowHints))}
   :r {:name :Reload :action hs.reload}
   :s {:name :Search :action (fn [] (spoon.HSearch.toggleShow))}
   :w {:name :Window
       :h {:name :Left
           :repeatable true
           :action (fn [] (hs.window:moveOneScreenWest))}
       :j {:name :Down
           :repeatable true
           :action (fn [] (hs.window:moveOneScreenSouth))}
       :k {:name :Up
           :repeatable true
           :action (fn [] (hs.window:moveOneScreenNorth))}
       :l {:name :Right
           :repeatable true
           :action (fn [] (hs.window:moveOneScreenEast))}}})

(local start (hs.hotkey.modal.new [:ctrl] :space))

(fn setup [modal menu]
  (fn modal.exited [self]
    (hs.alert.closeAll))
  (modal:bind {} :escape
              (fn []
                (modal:exit)))
  (local display {})
  (each [k v (pairs menu)]
    (when (= (type v) :table)
      (tset display (+ (length display) 1) (.. k "   " v.name))
      (var action {})
      (if (not= v.action nil) (set action v.action)
        (let [submenu (hs.hotkey.modal.new)]
          (setup submenu v)
          (set action
               (fn []
                 (submenu:enter)))))
      (modal:bind {} k
                  (fn []
                    (when (not= v.repeatable true)
                      (modal:exit))
                    (action)))))

  (fn modal.entered [self]
    (hs.alert.closeAll)
    (hs.alert (table.concat display "\n") true)))

(setup start menu)
(hs.loadSpoon :SpoonInstall)
(spoon.SpoonInstall:andUse :HSearch)	
