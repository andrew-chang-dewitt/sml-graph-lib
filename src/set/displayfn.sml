functor SetDisplayFn(S: SET): DISPLAY =
struct

  fun toString (Set s: S.set): string =
    let
      fun f []      = ""
        | f [x]     = x
        | f (x::xs) = x ^ ", " ^ (f xs)
    in
      "{ " ^ (f s) ^ " }"
    end

end
