functor ListSetFn (A: sig
  eqtype t
end) : SET with datatype set = Set of t list =
struct

  exception NotImplemented

  type t = A.t
  datatype set = Set of t list

  fun from_list l =
    Set l

  fun empty () = from_list []

  fun is_empty (Set s) = raise NotImplemented
    (*
    length s = 0
     *)

  fun contains (Set s) x = raise NotImplemented
     

  fun length (Set s) = raise NotImplemented
    (*
    Array.length s
     *)

  fun eq a b = raise NotImplemented
    (*
    let
      val (Set a') = a
    in
      length a = length b andalso
      Array.all (contains b) a'
    end
     *)

  fun to_list (Set s) = raise NotImplemented
    (*
    Array.foldr (op ::) [] s
     *)

    (* TODO: Array has no append method.. maybe should just go for a list-based
    * impl for now? *)
  fun insert s x = raise NotImplemented

end
