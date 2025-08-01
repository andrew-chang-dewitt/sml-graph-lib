(* FIXME: make functor of ORD_KEY instead so t can be compared for equality? *)
functor SetTypes (type t) =
struct
  type t = t
  datatype set = Set of t * set | Empty
end
