(setq inhibit-startup-screen t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; non-specific functionality
(setq vc-follow-symlinks t)
(add-to-list 'default-frame-alist
                       '(font . "DejaVu Sans Mono-10"))

(use-package atom-one-dark-theme :ensure t)

(use-package erlang :ensure t)

(use-package org-trello :ensure t)

(use-package rotate :ensure t)

;; custom functions & variables

(defun minibuffer-keyboard-quit ()
"Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))

(defun switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

;; this may need to be moved into the helm use-package section.
(defun helm-save-and-paste ()
  (interactive)
  (kill-new (x-get-clipboard))
  (helm-show-kill-ring))

(defun save-all-buffers ()
  (interactive)
  (save-some-buffers t)
  )

(defun new-shell (name)
  "Opens a new shell buffer with the given name in
asterisks (*name*) in the current directory with and changes the
prompt to name>."
  (interactive "sName: ")
  (when (equal name "")
    (setq name (file-name-base (directory-file-name default-directory))))
  (pop-to-buffer (concat "<*" name "*>"))
  (unless (eq major-mode 'shell-mode)
    (shell (current-buffer))
    (sleep-for 0 200)
    (delete-region (point-min) (point-max))
    (comint-simple-send (get-buffer-process (current-buffer))
                      (concat "export PS1=\"\033[33m" name "\033[0m:\033[35m\\W\033[0m>\""))))

(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(setq python-shell-interpreter "ipython")

;; move this somewhere more useful...
(global-set-key (kbd "C-c s") 'new-shell)
(global-set-key (kbd "M-p") 'helm-save-and-paste)

(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(winner-mode)
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-w <left>")  'windmove-left)
    (define-key map (kbd "C-w <right>") 'windmove-right)
    (define-key map (kbd "C-w <up>")    'windmove-up)
    (define-key map (kbd "C-w <down>")  'windmove-down)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

(add-hook 'java-mode-hook
          (lambda ()
            (setq c-basic-offset 2
                  evil-shift-width 2
            )))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq c-basic-offset 2
                  evil-shift-width 2
                  )))

(add-hook 'magit-mode-hook
          (lambda ()
            (save-all-buffers)))


;; use display-buffer-alist instead of display-buffer-function if the following line won't work

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )

(use-package smart-tabs-mode
  :ensure t
  :config
  (smart-tabs-insinuate 'python 'javascript)
  (add-hook 'python-mode-hook
    (lambda ()
        (smart-tabs-advice python-indent-line-1 python-indent)
        (setq indent-tabs-mode t)
        (setq tab-width 4))
    )

  (add-hook 'js2-mode-hook
    (lambda ()
        (smart-tabs-advice js2-indent-line js2-basic-offset)
        (setq indent-tabs-mode t)
        (setq tab-width 2))
    )

  (add-hook 'rsjx-mode-hook
    (lambda ()
        (setq c-basic-offset 2
              indent-tabs-mode t
              tab-width 2
              evil-shift-width 2)))

  (add-hook 'fish-mode-hook
    (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2))
    )

  (add-hook 'css-mode-hook
    (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2))
    )
  )

(use-package json-mode
  :ensure t
  :config
  (add-hook 'json-mode-hook #'flycheck-mode)
  )

(use-package js2-mode
  :ensure t
  :config
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override t)
  )

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  )

(use-package scala-mode
  :ensure t
  :interpreter
  ("scala" . scala-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  )


(use-package magit
  :ensure t
  :config
  )

(use-package evil-magit
  :ensure t
  )


(use-package better-defaults :ensure t)

;; custom keybindings
(let ((map (make-sparse-keymap)))
  (define-key map "gs" 'magit-status)
  (define-key map "/" 'helm-projectile-ag)
  (define-key map "bs" 'switch-to-scratch)
  ;; bind to Meta-Space
  (define-key global-map (kbd "M-SPC") map))


(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode t)
  (evil-leader/set-leader "<SPC>" "C-")
  (evil-leader/set-key
    ;; toggles
    "tt"  'whitespace-mode
    "q"   'delete-frame
    "bd"  'kill-this-buffer
    "w"   'save-buffer
    "W"   'save-all-buffers
    "TAB" 'mode-line-other-buffer
    "pb"  'helm-projectile-switch-to-buffer
    "pf"  'helm-projectile-find-file
    "pp"  'helm-projectile-switch-project
    "bb"  'helm-buffers-list
    "f"   'helm-mini
    "bs"  'switch-to-scratch
    "oo"  'other-frame
    "kb"  'kill-buffer
    "gs"  'magit-status
    "gb"  'magit-blame
    "/"   'helm-projectile-ag
    ";"   'comment-dwim
    "ss"  'ssh-tunnels
    "ks"  'kubernetes-overview
    "a"   'winner-undo
    "d"   'winner-redo
    "<right>"   'org-shiftright
    "<left>"    'org-shiftleft
    )
  )

(use-package evil
  :ensure t
  :config
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (global-set-key [escape] 'keyboard-quit)
  (evil-set-initial-state 'ssh-tunnels-mode 'emacs)
  (evil-set-initial-state 'haskell-error-mode 'emacs)
  (evil-mode 1))

;; (use-package swiper
;;   :ensure t
;;   :config
;;   (global-set-key "\C-s" 'swiper))

(use-package helm-swoop
  :ensure t
  :config
  (global-set-key "\C-s" 'helm-swoop)
  (setq helm-swoop-speed-or-color t)
  (setq helm-swoop-pre-input-function (lambda () ""))
  )

(use-package idle-highlight-mode :ensure t)

(use-package paredit
  :ensure t
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))

(use-package scpaste :ensure t)

(use-package helm
  :config
  (helm-mode)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (define-key helm-map (kbd "<tab>") 'helm-next-line)
  )

(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 50)
(run-at-time nil (* 5 60) 'recentf-save-list)

(use-package helm-ag
  :ensure t)

(use-package helm-projectile
  :ensure t
  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(use-package projectile
  :ensure t
  :config
  (projectile-mode))

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-to-list 'company-backends 'company-anaconda)
  (eval-after-load 'company
    '(progn
      (define-key company-active-map (kbd "TAB") 'company-select-next)
      (define-key company-active-map [tab] 'company-select-next)
      (setq company-selection-wrap-around t)
      ))
  )

(use-package pyvenv
  :ensure t
  )


(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(setq tramp-default-method "ssh")

;; start the server
;; (server-start)
(global-undo-tree-mode t)

;; language specific configs
(use-package go-mode
  :no-require t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


(use-package org
  :config
    (setq org-agenda-files '("~/org/"))
  :ensure t)

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (setq venv-location "$HOME/.virtualenvs/envs"))

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  )

(use-package company-anaconda
  :ensure t
  )

(use-package yaml-mode
  :ensure t
  :config
  (add-hook 'yaml-mode-hook
            (lambda ()
              (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(use-package dockerfile-mode
  :ensure t)

(use-package nix-mode :ensure t)

(defun my-haskell-interactive-switch ()
  (save-buffer)
  (haskell-interactive-switch)
  )

(use-package haskell-mode
  :ensure t
  :config
  (add-hook 'haskell-mode-hook
            (lambda ()
              (interactive-haskell-mode)
            )
  ))

;; (define-key interactive-haskell-mode-map "C-c C-z" 'my-haskell-interactive-switch))

(use-package powerline-evil
  :ensure t
  :config
  (defun powerline-minor-modes (a b) "") ;; hacky af
  ;; (defun powerline-selected-window-active () t)
  )

(use-package airline-themes
  :ensure t
  :config
  (load-theme 'airline-ubaryd t)
  (setq airline-shortened-directory-length 15)
  (defun airline-shorten-directory (dir max-length) (sml/do-shorten-directory dir max-length))
  )

(use-package smart-mode-line :ensure t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (set-face-attribute 'org-level-1 nil :height 1.4)
  (set-face-attribute 'org-level-2 nil :height 1.3)
  (set-face-attribute 'org-level-3 nil :height 1.2)
  (setq org-bullets-bullet-list '("☯" "☢" "✸" "•"))
  )

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  )

(use-package kubernetes-evil :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "2a739405edf418b8581dcd176aaf695d319f99e3488224a3c495cb0f9fd814e3" default)))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(package-selected-packages
   (quote
    (rotate erlang erlang-mode multi-term pyvenv anaconda-mode org-trello itail json-mode kubernetes-evil kubernetes nix-sandbox ssh-tunnels helm-swoop shell-here org-bullets company flycheck zenburn-theme yaml-mode use-package swiper smart-tabs-mode smart-mode-line scpaste scala-mode rjsx-mode rainbow-delimiters powerline-evil paredit nix-mode markdown-mode idle-highlight-mode helm-projectile helm-ag haskell-mode evil-magit evil-leader dockerfile-mode better-defaults airline-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
