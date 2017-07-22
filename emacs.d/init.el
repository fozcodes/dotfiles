(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'molokai t)

;; Sensible Defaults
(load-file "~/.emacs.d/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)
    (setq evil-want-C-u-scroll t)
    ;; boot evil by default
    (evil-mode 1))
  :config
  (progn
    (global-set-key (kbd "C-k") 'windmove-up)
    (global-set-key (kbd "C-j") 'windmove-down)
    (global-set-key (kbd "C-h") 'windmove-left)
    (global-set-key (kbd "C-l") 'windmove-right)
    (defun my-jk ()
      (interactive)
      (let* ((initial-key ?j)
             (final-key ?k)
             (timeout 0.5)
             (event (read-event nil nil timeout)))
        (if event
          ;; timeout met
          (if (and (characterp event) (= event final-key))
            (evil-normal-state)
            (insert initial-key)
            (push event unread-command-events))
          ;; timeout exceeded
          (insert initial-key))))

    (define-key evil-insert-state-map (kbd "j") 'my-jk)))

(use-package linum-relative
  :ensure t
  :init
  (progn
    (defun my-linum-formatter (line-number)
      (propertize (format linum-relative-format line-number) 'face 'linum))
    (setq linum-format 'my-linum-formatter)
    ;; turn on linum-mode, and make it relative

    ;; emacs mode never shows linum
    (add-hook 'evil-emacs-state-entry-hook (lambda ()
                                             (linum-mode -1)))
    (add-hook 'evil-emacs-state-exit-hook (lambda ()
                                            (linum-mode 1)))

    ;; in normal mode, show relative numbering
    (add-hook 'evil-normal-state-entry-hook (lambda ()
                                              (setq linum-format 'linum-relative)))
    ;; turn off linum-mode, and make it normal again
    (add-hook 'evil-normal-state-exit-hook (lambda ()
                                             (setq linum-format 'my-linum-formatter)))
    )

  :config (setq linum-relative-current-symbol ">>"))

(use-package ace-jump-mode
  :ensure t
  :commands ace-jump-mode
  :init
  (bind-key* "C-c SPC" 'ace-jump-mode))

;; Essential settings.
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

;; ORG mode stuff
(setq org-todo-keywords '((sequence "TODO" "WAITING" "|" "DONE")))

(set-face-attribute 'default nil :height 170)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
