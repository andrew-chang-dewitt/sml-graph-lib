functor ArrSetFn (A: sig
  type t
  val compare: t * t -> order
end) : SET =
struct

  exception NotImplemented

  type t = A.t
  datatype set = Set of t array

  fun from_list l =
    Set (Array.fromList l)

  fun empty () = from_list []

  fun is_empty (Set s) =
    Array.length s = 0

  fun contains (Set s) x =
    let
      fun f (y: t) =
        case A.compare (y,x) of
            EQUAL => true
          | _     => false
    in
      Array.exists f s
    end

  fun length (Set s) =
    Array.length s

  fun eq a b =
    let
      val (Set a') = a
    in
      length a = length b andalso
      Array.all (contains b) a'
    end

  fun to_list (Set s) =
    Array.foldr (op ::) [] s

  fun insert s x = raise NotImplemented

end
