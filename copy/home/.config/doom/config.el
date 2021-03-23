;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Quark Wei"
      user-mail-address "quark.j.wei@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "/Users/quark/roam")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package tron-legacy-theme
  :config
  ;; (setq tron-legacy-theme-dark-fg-bright-comments t)
  (setq tron-legacy-theme-vivid-cursor t)
  ;; (setq tron-legacy-theme-softer-bg t)
  (load-theme 'tron-legacy t))

;; Roam
;; ("d" "default" plain (function org-roam--capture-get-point)
;;      "%?"
;;      :file-name "%<%Y>/%<%m>/%<%d%H%M%S>-${slug}"
;;      :head "#+title: ${title}\n"
;;      :unnarrowed t)

;; magit
(setq epa-pinentry-mode 'loopback)

;; ;; org-roam
;; (use-package org-roam
;;       :hook
;;       (after-init . org-roam-mode)
;;       :custom
;;       (org-roam-directory "~/roam")
;;       :bind (:map org-roam-mode-map
;;               (("C-c n l" . org-roam)
;;                ("C-c n f" . org-roam-find-file)
;;                ("C-c n g" . org-roam-graph))
;;               :map org-mode-map
;;               (("C-c n i" . org-roam-insert))
;;               (("C-c n I" . org-roam-insert-immediate))))
;; (package! org-roam :pin nil)

;; ;; (use-package! org-roam
;; ;;   :hook (after-init . org-roam-mode))
;; (setq org-id-method 'ts)
;; (setq org-roam-dailies-capture-templates
;;       '(("d" "default" entry
;;          #'org-roam-capture--get-point
;;          "* %?"
;;          :file-name "daily/%<%Y-%m-%d>"
;;          :head "#+title: %<%Y-%m-%d>\n\n"
;;          )
;;         )
;; )

(use-package! nroam
  :after org-roam
  :config
  (add-hook 'org-mode-hook #'nroam-setup-maybe))

(map! :leader

       (:when (featurep! :lang org +roam)
        (:prefix ("r" . "roam")
         :desc "Switch to buffer"              "b" #'org-roam-switch-to-buffer
         :desc "Org Roam Capture"              "c" #'org-roam-capture
         :desc "Find file"                     "f" #'org-roam-find-file
         :desc "Show graph"                    "g" #'org-roam-graph
         :desc "Insert"                        "i" #'org-roam-insert
         :desc "Insert (skipping org-capture)" "I" #'org-roam-insert-immediate
         :desc "Org Roam"                      "r" #'org-roam
         (:prefix ("d" . "by date")
          :desc "Arbitrary date" "d" #'org-roam-dailies-find-date
          :desc "Today"          "t" #'org-roam-dailies-find-today
          :desc "Tomorrow"       "m" #'org-roam-dailies-find-tomorrow
          :desc "Yesterday"      "y" #'org-roam-dailies-find-yesterday)))
;;       (:prefix-map ("r" . "org-roam-2")
;;         :desc "Capture Today" "t" #'org-roam-dailies-capture-today
;;         :desc "Find/Create Node" "n" #'org-roam-node-find
;;         :desc "Insert" "i" #'org-roam-node-insert
;;         )
      )

;; org-roam normal-mode RET for linking

;; (defun my/org-roam-link-word-at-point ()
;;   (interactive)
;;   (when (word-at-point t)
;;     (re-search-backward "\\b")
;;     (mark-word)
;;     (call-interactively #'org-roam-node-insert)))

;; (defun my/org-roam-open-or-link-at-point ()
;;   (interactive)
;;   (let ((context (org-element-context)))
;;     (if (equal (car context) 'link)
;;         (org-open-at-point)
;;         (my/org-roam-link-word-at-point))))

;; (define-minor-mode my/local-org-roam-mode
;;   "Local version of `org-roam-mode'.
;; Does nothing, can be used for local keybindings."
;;   :init-value nil
;;   :global nil
;;   :lighter " OR local"
;;   :keymap  (let ((map (make-sparse-keymap)))
;;              map)
;;   :group 'org-roam
;;   :require 'org-roam
;;   (when my/local-org-roam-mode
;;     (message "Local keybindings for Org Roam enabled")
;;     (winner-mode +1)
;; (define-key winner-mode-map (kbd "<M-left>") #'winner-undo)
;; (define-key winner-mode-map (kbd "<M-right>") #'winner-redo)))

;; ivy config
(setq ivy-wrap nil)
(setq ivy-count-format "(%d/%d) ")
