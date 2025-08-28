functor Util(S: SET) =
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

  fun assertEqualSet l r =
    if (S.eq l r)
    then ()
    else raise Assert.Fail (Assert.NotEqualFailure ((toString l), (toString r)))

end
