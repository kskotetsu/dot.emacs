;
;; C-hはバックスペース
;(global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)

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

;; 別のウィンドウへ移動
(setq switch-window-shortcut-style 'qwerty)
(global-set-key (kbd "C-'") 'other-window-or-split)
(global-set-key (kbd "C-x o") 'other-window-or-split)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "<home>") 'other-window-or-split)

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
;
(global-set-key "\C-a" 'beginning-of-line)
;(global-set-key "\C-a" 'my-seq-home)
;(global-set-key "\C-e" 'seq-end)

;; c-aを繰り返すと行頭・ヘッダ・上の階層への移動を繰り返す。
(define-sequential-command my-org-seq-home
  beginning-of-line outline-previous-visible-heading outline-up-heading seq-return)

;; c-eを繰り返すと行頭・ヘッダ・下の階層への移動を繰り返す。
(define-sequential-command my-org-seq-end
  end-of-line outline-next-visible-heading outline-down-heading  seq-return)

(when (require 'org nil t)
  ;(define-key org-mode-map "\C-a" 'my-org-seq-home)
  ;(define-key org-mode-map "\C-e" 'my-org-seq-end))
  (define-key org-mode-map "\C-a" 'beginning-of-line)
  (define-key org-mode-map "\C-e" 'end-of-line))

;; window-numbering
(window-numbering-mode)

;; ace-jump-mode
(global-set-key (kbd "M-SPC") 'ace-jump-char-mode)
(global-set-key (kbd "C-.") 'ace-jump-char-mode)

;; anzu-mode
(global-set-key (kbd "M-%") 'anzu-query-replace)

; pythonのcp932エラーをどうするか
;(require 'visual-regexp-steroids)
;(setq vr/engine 'python)
;; ;(setq vr/engine 'pcre2el)               ;elispでPCREから変換
;(global-set-key (kbd "M-%") 'vr/query-replace)
;; ;; multiple-cursorsを使っているならこれで
;; ;(global-set-key (kbd "C-c m") 'vr/mc-mark)
;; ;; 普段の正規表現isearchにも使いたいならこれを
;; (global-set-key (kbd "C-M-r") 'vr/isearch-backward)
;; (global-set-key (kbd "C-M-s") 'vr/isearch-forward)


(defun my-isearch-get-word()
  "カーソル位置の単語をisearch"
  (interactive)
  (isearch-yank-string current-word))

(define-key isearch-mode-map "\C-w" 'my-isearch-get-word)

;(require 'misc)
(global-set-key (kbd "M-z") 'ace-jump-zap-up-to-char)
