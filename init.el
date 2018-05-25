;;;; emacs configuration file

;;; my default preferences -------------------------------

(tool-bar-mode -1)

(blink-cursor-mode -1)

(add-to-list 'default-frame-alist
   '(fullscreen . maximized))

(setq-default
    indent-tabs-mode nil ; replace tabs with spaces
    show-trailing-whitespace t ; whitespace minor mode
    truncate-lines 1) ; word wrap off

(setq inhibit-startup-screen t
      initial-scratch-message ";; ready\n\n"
      package-enable-at-startup nil
      package-user-dir "~/.emacs.d/elpa/"
      make-backup-files nil) ; stop creating backup '~*.*' files

(set-frame-font "DejaVu Sans Mono-14" nil t)

;;; hooks for all programming modes -------------------------

(add-hook 'prog-mode-hook #'hs-minor-mode) ; hide/show hs-minor-mode mode
(add-hook 'prog-mode-hook #'linum-mode) ; linum mode (show line numbers)

;;; init for non 'built-in' packages ------------------------

(require 'package)

(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(setq my-required-packages-list
    '( use-package
        diminish
        undo-tree
	iedit
	neotree
        lsp-ui
        company
        company-quickhelp
        company-lsp
        cquery
        bind-key))

(mapc #'package-install my-required-packages-list)

(mapc #'require my-required-packages-list)

;;; theme -----------------------------------------------

(use-package darkokai-theme
  :ensure t
  :config (load-theme 'darkokai t))

;;; non built-in packages -------------------------------

;; diminish

;; undo-tree
(global-undo-tree-mode 1)

;; iedit

;; neotree

;; lsp-ui
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; company
(global-company-mode)

;; company-quickhelp (popup)
(company-quickhelp-mode 1)

;; company-lsp
(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)

;; cquery
(setq cquery-executable "~/dev/cquery/build/cquery")
(setq cquery-extra-init-params
    '(:index (:comments 2)
      :cacheFormat "msgpack"
      :completion (:detailedLabel t)))

(add-hook 'c-mode-common-hook 'lsp-cquery-enable)
;;(setq cquery-extra-init-params '(:extraClangArguments ("--driver-mode=cl"))


;; my prefered (controversial?!) key remap
(bind-keys*
    ;; file operations
    ("C-o" . find-file)         ; Open file
    ("C-s" . save-buffer)       ; Save file
    ("C-S-s" . write-file)      ; Save as
    ("M-Q" . kill-this-buffer)  ; close file
    ;; folder tree
    ("C-d" . neotree-toggle)  ; toggle hide/show folder tree
    ;; buffer content operations
    ("C-a" . mark-whole-buffer) ; Select all
    ("C-f" . highlight-phrase)    ; find in file and highlight
    ("C-S-f" . unhighlight-regexp) ; exit highlight mode
    ("C-z" . undo-tree-undo)    ; undo
    ("C-S-z" . undo-tree-redo)  ; redo
    ("C-c" . kill-ring-save)    ; Copy
    ("C-x" . kill-region)       ; Cut
    ("C-v" . yank)              ; Paste
    ;; Pane/buffer switching
    ("M-1" . other-window)      ; toggle pane
    ("M-2" . previous-buffer)   ; previous file in pane
    ("M-3" . next-buffer)       ; next file in pane
    ("<M-down>" . split-window-vertically)
    ("<M-right>" . split-window-horizontally)
    ("M-q" . delete-window)     ; close window
    ;; font size
    ("C-+" . text-scale-increase)
    ("C--" . text-scale-decrease)
    ;; launch sub-process
    ("M-0" . term) ; terminal
    ("M-9" . eww) ; browser
    ;; code folding
    ("M-e" . hs-show-block)
    ("M-E" . hs-hide-block)
    ("M-h" . hs-hide-all))

;; c-mode
(setq c-default-style "gnu")
(setq c-basic-offset 4)

;; prevent emacs from injecting autogenerated code into this file. for 'customized' package-selected-packages configuration
(setq custom-file "~/.emacs.d/package-selected-packages.el")
(load custom-file)
