;(el-get 'sync 'helm)
;(el-get 'sync 'helm-ls-git)
;(el-get 'sync 'helm-ag)
(require 'helm)

; for helm-git-project
;(require 'cl)
(require 'helm-config)
(require 'helm-C-x-b)
(require 'helm-files)
(require 'helm-ls-git)
(require 'semantic)

;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))

(custom-set-variables '(helm-mini-default-sources
						'(helm-source-buffers-list
						  ;helm-source-semantic
						  ;helm-source-imenu
						  helm-source-recentf
						  helm-source-ls-git
						  helm-source-buffer-not-found
						  )))
;; ;; List files in git repos
;; (defun helm-c-sources-git-project-for (pwd)
;;   (loop for elt in
;;         '(("Modified files" . "--modified")
;;           ("Untracked files" . "--others --exclude-standard")
;;           ("All controlled files in this project" . nil))
;;         for title  = (format "%s (%s)" (car elt) pwd)
;;         for option = (cdr elt)
;;         for cmd    = (format "git ls-files %s" (or option ""))
;;         collect
;;         `((name . ,title)
;;           (init . (lambda ()
;;                     (unless (and (not ,option) (helm-candidate-buffer))
;;                       (with-current-buffer (helm-candidate-buffer 'global)
;;                         (call-process-shell-command ,cmd nil t nil)))))
;;           (candidates-in-buffer)
;;           (type . file))))

;; (defun helm-git-project-topdir ()
;;   (file-name-as-directory
;;    (replace-regexp-in-string
;;     "\n" ""
;;     (shell-command-to-string "git rev-parse --show-toplevel"))))

;; (defun helm-git-project ()
;;   (interactive)
;;   (let ((topdir (helm-git-project-topdir)))
;;     (unless (file-directory-p topdir)
;;       (error "I'm not in Git Repository!!"))
;;     (let* ((default-directory topdir)
;;            (sources (helm-c-sources-git-project-for default-directory)))
;;       (helm-other-buffer sources
;;                          (format "*helm git project in %s*" default-directory)))))

;(define-key helm-map (kbd "C-h") 'delete-backward-char)
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     ))

(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "C-:") 'helm-resume)
;(global-set-key (kbd "C-M-;") 'helm-resume)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;(global-set-key (kbd "M-C-;") 'helm-git-project)
;(global-set-key (kbd "M-C-;") 'helm-ls-git-ls)
(global-set-key (kbd "M-C-;") 'helm-projectile)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
;(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-C-x-b)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; C-hでバックスペースと同じように文字を削除  
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

(define-key helm-buffer-map (kbd "C-r") 'helm-buffer-revert-persistent)

(global-set-key (kbd "M-o") 'helm-swoop)

;; helm-swoop開始時にカーソル下のシンボルを検索しようとするのをやめる
(setq helm-swoop-pre-input-function
	  (lambda () nil))

; C-u C-M-oで再帰grep
(setq helm-ag-base-command "ag --nocolor --nogroup -S")

(global-set-key (kbd "C-M-o") 'helm-do-grep)
;(global-set-key (kbd "<f3>") 'helm-ag)
(global-set-key (kbd "<f3>") 'helm-ag-project-root)
;(global-set-key (kbd "C-M-o") 'helm-ag)
(global-set-key (kbd "<f8>") 'helm-semantic-or-imenu)
;(global-set-key (kbd "<f8>") 'helm-imenu-anywhere)

;; isearch中にM-oでhelmに移行
(define-key isearch-mode-map (kbd "M-o") 'helm-swoop-from-isearch)

;(setq helm-ag-base-command "/cygdrive/c/Chocolatey/bin/ag.bat")
;(setq helm-ack-base-command "/cygdrive/c/Chocolatey/bin/ack.bat")
;(setq helm-c-ack-use-ack-grep nil)

(global-set-key (kbd "C-z h") 'helm-elscreen)


(require 'helm-bm)
;; migemo対応
(push '(migemo) helm-source-bm)
;; annotationは表示しない
(setq helm-source-bm (delete '(multiline) helm-source-bm))

(global-set-key (kbd "C-x c b") 'helm-bm)
(global-set-key (kbd "C-x c p") 'helm-projectile)
