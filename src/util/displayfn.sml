functor DisplayFn(S: SET): DISPLAY =
struct

  type t = S.set

  fun toString (Set s: t): string =
    let
      fun f []      = ""
        | f [x]     = x
        | f (x::xs) = x ^ ", " ^ (f xs)
    in
      "{ " ^ (f s) ^ " }"
    end

end
