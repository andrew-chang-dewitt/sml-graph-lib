functor Graph (A: GRAPH_ARGS) : GRAPH =
struct

  structure N = A.Node

  (*
  structure F = A.FArr
  structure Stamp = StampUtil (struct structure FunArray = F; structure Node = N; end )
  open Stamp A.FArr UTuple UList
   *)

  open Exceptions

  (* inductive graph type composed of an Empty graph*)
  datatype 'a graph =
      Empty
    | Graph of N.t list * 'a * N.t list

  structure T = GraphTypes (struct
                              type 'a graph = 'a graph
                              structure Node = N
                            end)
  open T

  val empty = Empty

  fun nodes graph = raise NotImplemented
  fun isEmpty Empty = true
    | isEmpty _     = false
  fun succ (node, graph) = raise NotImplemented
  fun pred (node, graph) = raise NotImplemented
  fun ufold f init graph = raise NotImplemented
  fun gfold (ctx, nodes_b) f g init nodes_a graph = raise NotImplemented

end
