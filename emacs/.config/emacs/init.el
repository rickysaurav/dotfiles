
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq vc-follow-symlinks nil)
(setq gc-cons-threshold 268435456
        gc-cons-percentage 0.5)
;Hack to load org-mode from git using straight
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "straight/build/org/")))
(when (file-readable-p (expand-file-name (concat user-emacs-directory "config.org")))
  (org-babel-load-file (expand-file-name (concat user-emacs-directory "config.org"))))
