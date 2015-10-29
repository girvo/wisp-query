(ns query.query
  "a jquery-inspired functional DOM library"
  (:require [wisp.runtime :refer [nil? keys]]
            [wisp.sequence :refer [count]]))

(defn ^:private nl->array [nl]
  "Converts NodeLists to a raw array"
  (Array.prototype.slice.call nl))

(defn ^:private raw-get [context selector]
  "Internal wrapper around querySelectorAll, allows for infinite chaining"  
  (if (or (nil? context) (identical? (:length context) 0))
    nil ; return null so chaining works without errors
    (let [items (.querySelectorAll context selector)]
      (if (identical? (:length items) 1)
        (aget items 0)
        items))))

(defn ^:private raw-id [id context]
  "Internal selector for $id, uses $get"
  (let [result (raw-get context (+ "#" id))]
    (if (identical? 0 (count (keys result)))
      nil 
      result)))

(defn $get 
  "Returns an element or array of elements"
  {:version "0.1"}
  ([selector]
    (raw-get document selector)) 
  ([selector dom-ele]
    (raw-get dom-ele selector)))

(defn $filter
  "Returns set of dom elements based on result of callback executed on each item"
  {:version "0.1"}
  [cb domset]
  (let [result (.filter (nl->array domset) cb)]
    (if (identical? (:length result) 1)
      (aget result 0)
      result)))

(defn $id
  "Return a single element or nil based on ID given"
  {:version "0.1"}
  ([id]
    (raw-id id document))
  ([id context]
    (raw-id id context)))
