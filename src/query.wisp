(ns query.query
  "a jquery-inspired functional DOM library"
  (:require [wisp.runtime :refer [nil?]]))

(defn ^:private raw-get [context selector]
  "Internal wrapper around querySelectorAll, allows for infinite chaining"  
  (if (or (nil? context) (identical? (:length context) 0))
    nil ; return null so chaining works without errors
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
