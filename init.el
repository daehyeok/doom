 ;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

;; Change leader alt key for non-evil mode
(setq doom-leader-alt-key "M-m"
      doom-localleader-alt-key "C-M-m")

(eval-after-load 'package
  '(add-to-list 'package-archives
                '("melpa" . "https://melpa.org/packages/")))

(eval-after-load 'package
  '(add-to-list 'package-archives
                '("org-melpa" . "http://orgmode.org/elpa/")))


;; come from https://github.com/rbutoi/dotfiles/blob/master/emacs/.doom.d/init.el
(defconst
  IS-WORK
   (or IS-LINUX (string-match-p
    "roam" (shell-command-to-string "hostname -f"))))

(defconst IS-PERSONAL (not IS-WORK))

;; load file from doom directory
(defun load-file-from-doomdir (name)
    (load (concat (file-name-as-directory doom-private-dir) name))
)

(if IS-LINUX (load-file-from-doomdir  "init_linux"))

(doom! :input
       :completion
       (company +childframe)             ; the ultimate code completion backend
       (ivy +fuzzy)        ; a search engine for love and life

       :ui
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       hl-todo             ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline            ; snazzy, Atom-inspired modeline, plus API
       nav-flash           ; blink cursor line after big motions
       ophints            ; highlight the region an operation acts on
       (popup +all +defaults)   ; tame sudden yet inevitable temporary windows
       treemacs            ; a project drawer, like neotree but cooler
       unicode             ; extended unicode support for various languages
       vc-gutter           ; vcs diff in the fringe
       vi-tilde-fringe     ; fringe tildes to mark beyond EOB
       workspaces          ; tab emulation, persistence & separate workspaces
       (window-select +numbers)

       :editor
       (:if (not IS-LINUX)
        file-templates)
       fold                ; (nigh) universal code folding
       (format +on-save)
       multiple-cursors    ; editing in many places at once
       snippets            ; my elves. They type so I don't have to

       :emacs
       (dired +icons)      ; making dired pretty [functional]
       electric            ; smarter, keyword-based electric-indent
       (ibuffer +icons)    ; interactive buffer management
       (undo +tree)        ; persistent, smarter undo for your inevitable mistakes
       vc                  ; version-control and Emacs, sitting in a tree

       :term
       vterm               ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget

       :tools
       (:if IS-LINUX
        editorconfig)
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       lsp
       magit               ; a git porcelain for Emacs
       direnv

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       (tty +osc)          ; improve the terminal Emacs experience

       :lang
       (go +lsp)
       (markdown +syntax)            ; writing docs for people to ignore
       (org +pretty +roam2)               ; organize your plain life in plain text
       (python +lsp)
       (sh +syntax)                  ; she sells {ba,z,fi}sh shells on the C xor
       (yaml +syntax)                ; JSON, but readable
       (rust +lsp)
       (cc +lsp)
       (kotlin +lsp)
       (nix +lsp)
       (:if IS-WORK (javascript +lsp))


       :config
       (default +bindings +smartparens))
