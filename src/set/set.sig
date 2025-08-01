signature SET =
sig

  include SET_TYPES
  
  val empty: unit -> set
  val from_list: t list -> set

  val length: set -> int
  val is_empty: set -> bool
  val contains: set -> t -> bool

  val all: (t -> bool) -> set -> bool
  val eq: set -> set -> bool

  val insert: set -> t -> set

  val to_list: set -> t list

end
