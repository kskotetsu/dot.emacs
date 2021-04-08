;; Python
;(el-get 'sync 'ac-python)
(require 'epc)
(require 'python)
;(require 'jedi)
;(require 'ac-python)

(defun my:ensure-python.el (&optional branch overwrite)
  "Install python.el from BRANCH.
After the first install happens the file is not overwritten again
unless the optional argument OVERWRITE is non-nil. When called
interactively python.el will always be overwritten with the
latest version."
  (interactive
   (list
	(completing-read "Install python.el from branch: "
					 (list "master" "emacs-24")
					 nil t)
	t))
  (let* ((branch (or branch "master"))
		 (url (format
			   (concat "http://git.savannah.gnu.org/cgit/emacs.git/plain"
					   "/lisp/progmodes/python.el?h=%s") branch))
		 (destination (expand-file-name "python.el" user-emacs-directory))
		 (write (or (not (file-exists-p destination)) overwrite)))
	(when write
	  (with-current-buffer
		  (url-retrieve-synchronously url)
		(delete-region (point-min) (1+ url-http-end-of-headers))
		(write-file destination))
	  (byte-compile-file destination t)
	  destination)))
(my:ensure-python.el)

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(defun my-python-mode-common ()
  (setenv "LANG" "en_US.UTF-8")
  (setq imenu-create-index-function 'python-imenu-create-index)
  (setq indent-tabs-mode nil)
  (setq indent-level 4)
  (setq python-indent 4)
  (setq tab-width 4)
  (setq python-indent-guess-indent-offset nil)
  (flycheck-mode t)
  ;; (jedi:setup)
  ;; (setq jedi:complete-on-dot t)
  ;; (setq jedi:use-shortcuts t)
  ;; (add-hook 'python-mode-hook 'jedi:setup)
  ;; (add-to-list 'company-backends 'company-jedi) ; backendに追加
  ;; (local-set-key (kbd "<f1> j") 'jedi:show-doc)
  ;; (define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)
  )

(defun my-python-mode ()
  (my-python-mode-common)
	
  (setq
   python-shell-interpreter "~/.pyenv/shims/ipython"
   python-shell-interpreter-args ""
   ;python-shell-interpreter "~/.pyenv/shims/ipython"
   python-shell-interpreter-args "--colors linux"
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n" )
  ;(setq py-python-command-args '("--matplotlib" "--colors" "LightBG"))
  ;(setq ansi-color-for-comint-mode t)
  )

(defun my-inferior-python-mode()
  (setenv "LANG" "en_US.UTF-8"))


(add-hook 'python-mode-hook 'my-python-mode)
;(add-hook 'inferior-python-mode-hook 'my-inferior-python-mode)

; for mac
(eval-after-load "jedi"
  '(setq jedi:server-command (list "~/.pyenv/shims/python" jedi:server-script))
  )

