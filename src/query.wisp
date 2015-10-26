(ns query.query
  "a jquery-inspired functional DOM library"
  (:require [wisp.runtime :refer [nil?]]))

;(defn $get [selector]
;  (if (identical? (:length (document.querySelectorAll selector)) 1)
;    (aget (document.querySelectorAll selector) 0)
;    (document.querySelectorAll selector)))

(defn ^:private raw-get [context selector]
  (if (nil? context)
    null ; return null so chaining works without errors
    (let [items (.querySelectorAll context selector)]
      (if (identical? (:length items) 1)
        (aget items 0)
        items))))

(defn $get 
  "Returns an element or array of elements"
  {:version "0.1"}
  ([selector]
    (raw-get document selector)) 
  ([selector dom-ele]
    (raw-get dom-ele selector)))
