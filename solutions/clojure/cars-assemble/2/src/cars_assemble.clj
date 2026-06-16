(ns cars-assemble)

(def cars-produced-per-hour 221.0)

(defn success-rate 
  "Returns the assembly line's success rate of production, given its speed"
  [speed]
  (cond (<= speed 0)  0.0
        (<= speed 4)  speed
        (<= speed 8)  (* 0.9  speed)
        (=  speed 9)  (* 0.8  speed)
        (= speed 10)  (* 0.77 speed)    
    )
  )

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (*  cars-produced-per-hour (success-rate speed))
  )

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60))
  )
