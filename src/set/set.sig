signature SET =
sig

  include SET_TYPES
  
  val empty: unit -> set
  val from_list: t list -> set

  val is_empty: set -> bool
  val length: set -> int
  val contains: set -> t -> bool
  val eq: set -> set -> bool

  val insert: set -> t -> set

  val to_list: set -> t list

end
