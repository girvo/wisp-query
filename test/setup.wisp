(ns query.test.setup
  "test setup macro for other test cases"
  (:require [jsdom :refer [jsdom]]))

; sets up jsdom for our tests
(defn setup-tests [domstring]
  (do
    (set! global.doc (jsdom domstring))
    (set! global.window doc.defaultView)
    (set! global.document window.document)
    null))
