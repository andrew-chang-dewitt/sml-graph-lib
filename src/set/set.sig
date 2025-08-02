signature SET =
sig

  include SET_TYPES
  
  val empty: unit -> set
  val from_list: node list -> set

  val length: set -> int
  val is_empty: set -> bool
  val contains: set -> node -> bool
  val all: (node -> bool) -> set -> bool
  val eq: set -> set -> bool

  val insert: set -> node -> set

  val foldr: ('a * node -> 'a) -> 'a -> set -> 'a
  val to_list: set -> node list

end
