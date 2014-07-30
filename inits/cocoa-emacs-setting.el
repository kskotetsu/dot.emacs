;; (when (eq system-type 'darwin)	     ; もし、システムが Mac のとき
;;   (setq mac-command-key-is-meta nil) ; コマンドキーをメタにしない
;;   (setq mac-option-modifier 'meta)   ; オプションキーをメタに
;;   (setq mac-command-modifier 'super) ; コマンドキーを Super に
;;   (setq mac-pass-control-to-system t)) ; コントロールキーを Mac ではなく Emacs に渡す

;; (define-key global-map [(super a)] 'anything)

;;--------------------------------------------------------------------;
;; commandキーをメタにする(for mac)
;;--------------------------------------------------------------------
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; 新規フレームを作らない
(setq ns-pop-up-frames nil)

;; ファイルをドロップしたときにはインサートじゃなくて開く
(define-key global-map [ns-drag-file] 'ns-find-file)

(setq mac-allow-anti-aliasing t)

;;--------------------------------------------------------------------
;; IME
;;--------------------------------------------------------------------
(setq default-input-method "MacOSX")
; (mac-setup-inline-input-method)

; for ime-patch
(global-set-key (kbd "M-¥") (lambda () (interactive) (insert "¥")))

(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")
;; カーソルの色
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `cursor-color "red")
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.Roman" `cursor-color "white")
(mac-set-input-method-parameter "com.apple.keylayout.US" 'cursor-color "white")

;; backslash を優先
(mac-translate-from-yen-to-backslash)

;;--------------------------------------------------------------------
;; font
;;--------------------------------------------------------------------
(create-fontset-from-ascii-font "Menlo-11:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 11)
                  nil
                  'append)

;; (create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
;; (set-fontset-font "fontset-menlokakugo"
;;                   'unicode
;;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
;;                   nil
;;                   'append)

(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

(add-to-list 'default-frame-alist '(alpha . (100 100)))

;; (create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
;; (set-fontset-font "fontset-menlokakugo"
;;                   'unicode
;;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
;;                   nil
;;                   'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;(add-to-list 'auto-mode-alist '("\\.mm?$" . objc-mode))
;(add-to-list 'auto-mode-alist '("\\.h$" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(ffap-bindings)
;; 探すパスは ffap-c-path で設定する
;; (setq ffap-c-path
;;     '("/usr/include" "/usr/local/include"))
;; 新規ファイルの場合には確認する
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path で展開するパスの深さ
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
     '(("\\.mm?$" (".h"))
       ("\\.cc$"  (".hh" ".h"))
       ("\\.hh$"  (".cc" ".C"))

       ("\\.c$"   (".h"))
       ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

       ("\\.C$"   (".H"  ".hh" ".h"))
       ("\\.H$"   (".C"  ".CC"))

       ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
       ("\\.HH$"  (".CC"))

       ("\\.cxx$" (".hh" ".h"))
       ("\\.cpp$" (".hpp" ".hh" ".h"))

       ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
         (lambda ()
           (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
         ))

;; --------------------------------------------------------------------------------
;; xcodeで開く
(defun open-in-xcode ()
  (interactive)
  (setq filename (buffer-file-name (current-buffer)))
  (setq offset (format "%d" (point)))
  (call-process "~/bin/open_in_xcode.py" nil t nil filename offset))  ;; open_in_xcode.pyを叩く

(global-set-key "\C-cx" 'open-in-xcode)

;; シミュレータ起動スクリプトをelispでラップ
(defun xcode-debug ()
  (interactive)
  (call-process "~/bin/xcode_debug.py" nil t nil))

;; キーの割当
(global-set-key "\C-cg" 'xcode-debug)

;; ビルド
(defun xcode-build ()
  (interactive)
  (call-process "~/bin/xcode_build.py" nil t nil))

;; キーの割当
(global-set-key "\C-cb" 'xcode-build)

;; (require 'anything-apple-docset)
;; ;; 違うバッファで開きたければ
;; (setq anything-apple-docset-open-w3m-other-buffer t) 
;; ;; docsetのフルパス
;; (setq anything-apple-docset-path
;; "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone3_1.iPhoneLibrary.docset")

;; ;; 初期化処理
;; (anything-apple-docset-init)
;; ;; キーバインドはお好みで変更してください
;; (global-set-key (kbd "\C-c d") 'anything-apple-docset)


;; (require 'xcode-document-viewer)
;; (setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone3_1.iPhoneLibrary.docset")
;; (setq xcdoc:open-w3m-other-buffer t) ;if you like

;; フルスクリーン
(defun my-toggle-fullscreen ()
  "Toggle fullscreen."
  (interactive)
  (if (eq (frame-parameter nil 'fullscreen) 'fullboth)
      (progn
        (set-frame-parameter nil 'fullscreen nil)
        (display-time-mode 0))
    (set-frame-parameter nil 'fullscreen 'fullboth)
    (display-time-mode 1)))

(global-set-key '[f6] 'my-toggle-fullscreen)


;shell for bash
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; packageではなくemacs-jpの最新を使う
(el-get 'sync 'migemo) 
;(package-install 'migemo)

;(setq load-path (cons "~/.emacs.d/migemo/" load-path))
;(require 'migemo)
(setq migemo-command "/usr/local/bin/cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)

;パスをシェルから持ってくる。windowsはこれをいれるとpath=$PATHになる？
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

