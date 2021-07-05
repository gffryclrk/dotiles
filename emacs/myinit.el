(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq inhibit-splash-screen t)
(tool-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

  ;; Line numbers? Yes plz
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(use-package try
  :ensure t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defalias 'list-buffers 'ibuffer-other-window)

(use-package counsel
  :ensure t
  )
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;; (load-theme 'tsdh-dark t)

;; projectile
(use-package projectile
:ensure t
:config
(projectile-global-mode)
(setq projectile-completion-system 'ivy))

(use-package counsel-projectile
:ensure t
:config
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; Below fixes a weird python shell problem
;; https://github.com/syl20bnr/spacemacs/issues/8797
(setq python-shell-completion-native-enable nil)

(use-package jedi
    :ensure t
    :init
    (add-hook 'python-mode-hook 'jedi:setup)
    (add-hook 'python-mode-hook 'jedi:ac-setup)
    )

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize ))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package iedit
  :ensure t)

(setq elfeed-db-directory "~/.elfeed/elfeeddb/")

(use-package elfeed
    :ensure t

  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury)
              ("m" . elfeed-toggle-star)
              ("M" . elfeed-toggle-star)
              )
  )

(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.elfeed/elfeeddb/elfeed.org")))

(setq elfeed-feeds
      '("https://hnrss.org/frontpage"))

(use-package elfeed-goodies
  :ensure t
  :config
  (elfeed-goodies/setup))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    ))

(defun time-tz-print ()
  "Print current time with timezone in ISO 8601 format."
  (interactive)
  (insert
  (concat
   (format-time-string "%Y-%m-%d %T")
   ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
    (format-time-string "%z")))
    )
  )

(setq org-time-stamp-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %a %H:%M%z>"))

;;(setq org-default-notes-file (concat default-directory "meetings.org"))

;; set keybindg C-c c
(global-set-key (kbd "C-c c") 'org-capture)

;; https://stackoverflow.com/questions/64050011/getting-current-buffer-directory-from-within-org-capture
;; https://emacs.stackexchange.com/questions/38757/cannot-use-concat-within-org-capture-template
(setq org-capture-templates		
      '(("m" "Meeting")
        ("m1" "Meeting to org directory" entry
         (file+headline "~/Documents/org/meetings.org" "Meetings")
         "** %^{Meeting Title:} %U\nSCHEDULED: %^U\n*** Agenda\n*** Attendees\n*** Minutes\n%?\n*** Action Items\n")
        ("m2" "Meeting to this directory" entry
         (function 
          (lambda ()
            (find-file
             (concat (file-name-directory (or (org-capture-get :original-file t) (org-capture-get :original-file))) "meetings.org"))
            ;; (end-of-buffer)
            ) 
          )
         "* %^{Meeting Title:}\nSCHEDULED: %^U\n** Agenda\n** Attendees\n** Minutes\n%?\n** Action Items\n"
         )
        )
      )

(use-package scala-mode
    :interpreter
    ("scala" . scala-mode))

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)))

;;; ob-scala.el --- Babel Functions for Scala        -*- lexical-binding: t; -*-

;; Copyright (C) 2012-2017 Free Software Foundation, Inc.

;; Author: Andrzej Lichnerowicz
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Currently only supports the external execution.  No session support yet.

;;; Requirements:
;; - Scala language :: http://www.scala-lang.org/
;; - Scala major mode :: Can be installed from Scala sources
;;  https://github.com/scala/scala-dist/blob/master/tool-support/src/emacs/scala-mode.el

;;; Code:
(require 'ob)

(defvar org-babel-tangle-lang-exts) ;; Autoloaded
(add-to-list 'org-babel-tangle-lang-exts '("scala" . "scala"))
(defvar org-babel-default-header-args:scala '())
(defvar org-babel-scala-command "scala"
  "Name of the command to use for executing Scala code.")

(defun org-babel-execute:scala (body params)
  "Execute a block of Scala code with org-babel.  This function is
called by `org-babel-execute-src-block'"
  (message "executing Scala source code block")
  (let* ((processed-params (org-babel-process-params params))
         (session (org-babel-scala-initiate-session (nth 0 processed-params)))
         (result-params (nth 2 processed-params))
         (result-type (cdr (assq :result-type params)))
         (full-body (org-babel-expand-body:generic
                     body params))
         (result (org-babel-scala-evaluate
                  session full-body result-type result-params)))

    (org-babel-reassemble-table
     result
     (org-babel-pick-name
      (cdr (assq :colname-names params)) (cdr (assq :colnames params)))
     (org-babel-pick-name
      (cdr (assq :rowname-names params)) (cdr (assq :rownames params))))))

(defvar org-babel-scala-wrapper-method

"var str_result :String = null;

Console.withOut(new java.io.OutputStream() {def write(b: Int){
}}) {
  str_result = {
%s
  }.toString
}

print(str_result)
")


(defun org-babel-scala-evaluate
    (session body &optional result-type result-params)
  "Evaluate BODY in external Scala process.
If RESULT-TYPE equals `output' then return standard output as a string.
If RESULT-TYPE equals `value' then return the value of the last statement
in BODY as elisp."
  (when session (error "Sessions are not (yet) supported for Scala"))
  (pcase result-type
    (`output
     (let ((src-file (org-babel-temp-file "scala-")))
       (with-temp-file src-file (insert body))
       (org-babel-eval
        (concat org-babel-scala-command " " src-file) "")))
    (`value
     (let* ((src-file (org-babel-temp-file "scala-"))
            (wrapper (format org-babel-scala-wrapper-method body)))
       (with-temp-file src-file (insert wrapper))
       (let ((raw (org-babel-eval
                   (concat org-babel-scala-command " " src-file) "")))
         (org-babel-result-cond result-params
           raw
           (org-babel-script-escape raw)))))))


(defun org-babel-prep-session:scala (_session _params)
  "Prepare SESSION according to the header arguments specified in PARAMS."
  (error "Sessions are not (yet) supported for Scala"))

(defun org-babel-scala-initiate-session (&optional _session)
  "If there is not a current inferior-process-buffer in SESSION
then create.  Return the initialized session.  Sessions are not
supported in Scala."
  nil)

(provide 'ob-scala)



;;; ob-scala.el ends here

[[http://www.emacswiki.org/emacs/RecreateScratchBuffer][Recreate Scratch Buffer (emacswiki.org)]]
(defun create-scratch-buffer nil
   "create a scratch buffer"
   (interactive)
   (switch-to-buffer (get-buffer-create "*scratch*"))
   (lisp-interaction-mode))

(setq save-interprogram-paste-before-kill t)

(use-package evil)
(require 'evil)
(evil-mode 0)
