signature GRAPH =
sig

  include EXCEPTIONS
  include GRAPH_TYPES

  val empty : 'a graph

  val nodes : 'a graph -> node list
  val isEmpty : 'a graph -> bool
  
  val succ : node * 'a graph -> node list
  val pred : node * 'a graph -> node list
  val ufold : ('a context * 'b -> 'b) -> 'b -> 'a graph -> 'b
  val gfold : ('a context * node list) -> ('a * 'b -> 'c) ->
              ('c * 'b -> 'b) -> 'b -> node list -> 'a graph -> 'b

end
