;; ------------------------------------------------------------------------
;; org-mode

;; (require 'cl)
;; (defvar installing-package-list
;;   '(
;;     ;; ここに使っているパッケージを書く。
;;     org
;;     ))

;; (let ((not-installed (loop for x in installing-package-list
;;                             when (not (package-installed-p x))
;;                             collect x)))
;;   (when not-installed
;;     (package-refresh-contents)
;;     (dolist (pkg not-installed)
;;         (package-install pkg))))
;(package-install 'org)
;(el-get 'sync 'org)

(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; use org-remember
;(org-remember-insinuate)

(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
;(setq org-agenda-files (concat org-directory "agenda.org"))
(setq org-agenda-files (list
						(concat org-directory "agenda.org")
						(concat org-directory "note.org")
						(concat org-directory "cafe.org")
						))

(setq org-agenda-ndays 7)
(setq org-agenda-span 20)
(setq org-deadline-warning-days 7)
(setq org-agenda-time-grid
      '((daily today require-timed)
		"----------------"
		(800 1000 1200 1400 1600 1800 2000 2200 2400 2600)))

;; (custom-set-faces(defadvice org-agenda (around org-agenda-around)
;;   (let ((system-time-locale "English"))
;;     ad-do-it))

(defadvice org-agenda-redo (around org-agenda-redo-around)
  (let ((system-time-locale "English"))
    ad-do-it))

(custom-set-variables
  '(org-agenda-format-date "%Y/%m/%d (%a)"))

(custom-set-faces
 '(org-agenda-date ((t :weight bold))))

(setq org-todo-keywords
         '((sequence "TODO(t)" "DOING(i)" "ICAL(c)" "|" "DONE(d)")
           (sequence "CHECK(C)" "WAIT(w)" "STOP(s)" "|")
		   ))
 
(setq org-remember-templates
      '(("Todo"		?t "** TODO %?\n   %i\n   %a\n   %t" "~/memo/note.org" "Inbox")
        ("Schedule"	?s "** %?\n   %i\n   %a\n   %U" "~/memo/note.org" "Tasks")
        ("Work"		?w "** TODO %?   :work:\n   %i\n   %a\n   %U" "~/memo/note.org" "Inbox")
        ("Log"		?l "** %t   :log:\n   \n" "~/memo/agenda.org" "Logs")
        ("Home"		?h "** TODO %?   :home:\n   %i\n   %a\n   %U" "~/memo/note.org" "Inbox")
        ("Memo"		?m "** %?\n   %i\n   %a\n   %U" "~/memo/note.org" "Memo")
        ))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-ca" 'org-agenda)

;; org-capture
(setq org-capture-templates
      '(("t" "Todo"		entry (file+headline "~/memo/note.org" "Inbox")	"** TODO %?\n   %i\n   %a  %T")
		("s" "Schedule" entry (file+headline "~/memo/agenda.org" "Tasks")	"** %?  %i  %a  %U")
		("w" "Work"		entry (file+headline "~/memo/note.org" "Inbox")	"** TODO %?   :work:  %i  %a  %U")
		("l" "WorkLog"	entry (file+headline "~/memo/note.org" "Logs")	"** %t   :log:")
		("h" "Home"		entry (file+headline "~/memo/note.org" "Inbox")	"** TODO %?   :home: %i %a %U")
		("m" "Memo"		entry (file+headline "~/memo/note.org"   "Memo")	"** %? %i %a %U")
		))
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cr" 'org-capture)

(setq org-startup-truncated nil)
(defun org-change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))

(custom-set-faces
 '(org-level-1 ((t (:foreground "LightSkyBlue" :height 150))) t)
 '(org-level-2 ((t (:foreground "DarkGoldenrod" :height 100))) t)
 '(org-level-3 ((t (:foreground "DodgerBlue3" :height 100))) t)
 '(org-level-4 ((t (:foreground "chocolate1" :height 100))) t)
 '(org-level-5 ((t (:foreground "PaleGreen" :height 100))) t)
 '(org-level-6 ((t (:foreground "Aquamarine" :height 100) )) t)
 '(org-date ((t (:foreground "DodgerBlue1" :underline t) )) t)
 '(org-link ((t (:foreground "saddle brown" :underline t) )) t)
 )

(setq org-todo-keyword-faces
	  '(("FOCUS"   :foreground "#FF0000")
		("CHECK"   :foreground "#FF9900" :underline t)
		("ICAL"    :foreground "#33CC66")
		("WAIT"    :foreground "#33CC66")
		("DOING"   :foreground "#FF33CC")
		("STOP"    :foreground "#9999CC")))
