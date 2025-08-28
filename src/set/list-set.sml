datatype 't set = Set of 't list

functor ListSetFn (K: KEY) : SET where type set = K.key set =
struct

  type node = K.key
  type set = node set

  fun from_list l =
    Set l

  fun empty () = from_list []

  fun length (Set s) = List.length s

  fun is_empty s = length s = 0

  fun contains (Set s) x =
    List.exists (fn y => K.eq y x) s

  fun all f (Set s) = List.all f s

  fun eq a b = length a = length b andalso all (contains b) a

  fun insert s x =
    if (contains s x)
    then s
    else
      let
        val (Set l) = s
      in
        Set (x::l)
      end

  fun to_list (Set s) = s

end
