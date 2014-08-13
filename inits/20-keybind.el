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

;; 選択部分をいい感じに拡張する
(global-set-key (kbd "C-,") 'er/expand-region)

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

;; sequential-command
(require 'sequential-command-config)

;; c-aを繰り返すとインデント考慮の行頭、行頭への移動を繰り返す。
(define-sequential-command my-seq-home
  back-to-indentation beginning-of-line seq-return)

(global-set-key "\C-a" 'my-seq-home)
;(global-set-key "\C-e" 'seq-end)

(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))

;; window-numbering
(window-numbering-mode)

;; ace-jump-mode
(global-set-key (kbd "C-C SPC") 'ace-jump-mode)

;; anzu-mode
(global-set-key (kbd "M-%") 'anzu-query-replace)
