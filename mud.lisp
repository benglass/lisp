(setf *map* '((living-room 
               (you are in the living-room of a wizards house.
                the wizard is sleeping on the couch)
               (west door garden) 
               (upstairs stairway attic)
              )
              (garden
               (you are in a beautiful garden. there is a well
                in front of you)
               (east door living-room) 
              )
              (attic
               (you are in the attic of the wizards house.
                there is a giant welding torch in the corner)
               (downstairs stairway living-room)
              )))

(setf *objects* '(whiskey-bottle bucket chain frog))

(setf *object-locations* '((whiskey-bottle living-room)
                           (bucket living-room)
                           (chain garden)
                           (frog garden)))

(setf *location* 'living-room)

(defun describe-location (location map)
  (second (assoc location map)))

(defun describe-path (path)
  `(there is a ,(second path) going ,(first path) from here.))

(defun describe-paths (location map)
  (apply #'append (mapcar #'describe-path (cddr (assoc location map)))))

(defun is-at (obj loc obj-loc)
  (eq (second (assoc obj obj-loc)) loc))

(defun describe-floor (loc objs obj-loc)
  (apply #'append (mapcar (lambda (x)
                             `(you see a ,x on the floor.))
                           (remove-if-not (lambda (x)
                                            (is-at x loc obj-loc))
                                          objs))))

(defun look ()
  (append (describe-location *location* *map*)
          (describe-paths *location* *map*)
          (describe-floor *location* *objects* *object-locations*)))

; (describe-location 'living-room *map*)
; (describe-paths 'living-room *map*)
; (is-at 'whiskey-bottle 'living-room *object-locations*)
; (describe-floor 'living-room *objects* *object-locations*)
; (look)
