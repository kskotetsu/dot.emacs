;
;; C-hはバックスペース
(global-set-key "\C-h" 'delete-backward-char)

(global-set-key '[f2] 'multi-term)
(global-set-key '[f4] 'ff-find-other-file)

;; C-C bfpnでウィンドウ移動
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c k") 'windmove-up)

;; バッファの大きさを広げたり縮めたりする
(global-set-key (kbd "C-M-<up>") 'enlarge-window)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)

;; backspaceキーをインクリメンタルサーチ中のミニバッファで有効にする
(define-key isearch-mode-map [backspace] 'isearch-delete-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

;; =================
;search
;(el-get 'sync 'color-occur)

;;; ここからフォントサイズ変更の設定
; \C-+ で拡大
(global-set-key (kbd "C-+") (lambda () (interactive) (text-scale-increase 1)))
; \C-- で縮小
(global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 1)))
; \C-0 でデフォルトに戻す
(global-set-key (kbd "C-0") (lambda () (interactive) (text-scale-increase 0)))

