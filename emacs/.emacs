;; -*- mode: elisp -*-
 
;; Disable the splash screen (to enable it agin, replace the t with 0)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Stuff from Zamansky
(org-babel-load-file (expand-file-name "~/.dotfiles/emacs/myinit.org"))
;; End of Zamansky


(setq inhibit-splash-screen t)
(tool-bar-mode -1)

;; Enable transient mark mode
(transient-mark-mode 1)
 
;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
 
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "CANCELLED" "DONE")))
 
;; org minor modes
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-startup-folded (quote content))
 '(package-selected-packages
   (quote
    (pinentry scala-mode ace-window counsel-projectile projectile elpy elfeed-goodies elfeed-org elfeed iedit expand-region evil yasnippet-snippets yasnippet exec-path-from-shell jedi flycheck htmlize ox-reveal zenburn-theme auto-complete counsel swiper which-key try use-package))))
 
;; Vim Emulation
;; (add-to-list 'load-path "c:/Users/s6624656/tools/evil")
;; (require 'evil)
;; (evil-mode 1)
 
;; active Babel languages
;;(org-babel-do-load-languages
;;'org-babel-load-languages
;;'((python . t)
;;   (emacs-lisp . nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
