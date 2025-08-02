functor DisplaySet(A: sig
                     type t
                   end) =
struct

  structure Assert = SMLUnit.Assert

  fun toString (Set s: S.set): string =
    let
      fun f []      = ""
        | f [x]     = x
        | f (x::xs) = x ^ ", " ^ (f xs)
    in
      "{ " ^ (f s) ^ " }"
    end

end
