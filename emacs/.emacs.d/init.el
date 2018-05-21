
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq vc-follow-symlinks t)
(when (file-readable-p "~/.emacs.d/config.org")
  (org-babel-load-file (expand-file-name (concat user-emacs-directory "config.org"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(jdecomp-mode t)
 '(package-selected-packages
   (quote
    (lsp-java jdecomp rainbow-delimeters company-flx rainbow-mode hungry-delete irony-eldoc yasnippet-snippets yasnippet company-quickhelp irony company evil-nerd-commenter try sudo-edit general evil-easymotion dashboard avy diminish which-key use-package telephone-line spacemacs-theme smartparens rainbow-delimiters org-bullets linum-relative helm-projectile flycheck evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
