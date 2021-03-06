;(el-get 'sync 'popwin)

(when (require 'popwin)
  (setq helm-samewindow nil)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:special-display-config '(("*compilatoin*" :noselect t)
										("*Help*" :height 20)
										("*guide-key*" :height 20)
;										("*Helm Completions*" :height 20)
										("^\*[Hh]elm .+\*$" :regexp t :height 30)
										("*grep*" :noselect t)
										("*Org Agenda*" :noselect t :height 25)
										(" *Org todo*" :noselect t)
										(" *Agenda Commands*" :noselect t)
                                        ("helm" :regexp t :height 0.6)
										("robe-doc*" :noselect t :height 0.3)
										("*ruby*" :noselect t :height 0.3)
                                        )))

;; popwin:close-popup-window-timer: error: (error Variable binding depth exceeds max-specpdl-size)対策
(setq popwin:close-popup-window-timer-interval 0.5)
