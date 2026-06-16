(ns cars-assemble)

(def base-rate 221.0)

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (* (cond (<= speed 0)   0.0
           (<= speed 4)  speed
           (<= speed 8)  (* 0.9  speed)
           (=  speed 9)  (* 0.8  speed)
           (= speed 10)  (* 0.77 speed)    
    ) base-rate)
  )

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60))
  )
