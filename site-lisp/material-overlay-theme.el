;;
;; material theme overlay
;; customizations to material theme

(deftheme material-overlay)

(custom-theme-set-faces
 'material-overlay
 '(linum             ((t . (:height 0.8 :foreground "#535a6a"))))
 '(rel-linum         ((t . (:inherit (linum) :foreground "#5d6e92"))))
 '(rel-linum-current ((t . (:inherit (linum) :foreground "#587cca")))))

;;

(provide-theme 'material-overlay)
