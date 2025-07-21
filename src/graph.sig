signature GRAPH =
sig

  type Node
  type 'b Adj = ('b * Node) list
  type ('a, 'b) Context = 'b Adj * 't Node * 'a * 'b Adj

  datatype ('a, 'b) Graph = nil | ('a, 'b) Context * ('a, 'b) Graph
  
  val test: int -> int -> int
end
