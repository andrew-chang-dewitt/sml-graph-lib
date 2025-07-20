signature HELLO =
sig
  val greet: string -> string
  val world: string
end

structure Hello : HELLO =
struct
  fun greet name = "hello, " ^ name ^ "!"

  val world = "hello, world!"
end
