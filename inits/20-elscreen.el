(elscreen-start)
(elscreen-persist-mode 1)

;; タブの×ボタンを非表示に
(setq elscreen-tab-display-kill-screen nil)
;; 左端のコントロールボタンを非表示
(setq elscreen-tab-display-control nil)

(copy-face 'mode-line-inactive 'elscreen-tab-background-face)
(copy-face 'mode-line-inactive 'elscreen-tab-control-face)

(copy-face 'mode-line 'elscreen-tab-current-screen-face)
(copy-face 'mode-line-inactive 'elscreen-tab-other-screen-face)

;; 簡単にスクリーンの移動
(global-set-key [(C-tab)] 'elscreen-next)
(global-set-key [(C-S-tab)] 'elscreen-previous)

;(set-face-foreground 'elscreen-tab-background-face "gray10")

;(set-face-foreground 'elscreen-tab-control-face "gray20")
;(set-face-background 'elscreen-tab-control-face "gray70")

;(set-face-foreground 'elscreen-tab-current-screen-face "gray50")
;(set-face-background 'elscreen-tab-current-screen-face "gray10")

;(set-face-foreground 'elscreen-tab-other-screen-face "gray20")
;(set-face-background 'elscreen-tab-other-screen-face "gray50")


