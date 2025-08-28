functor GraphFn (N: KEY) : GRAPH =
struct

  structure S = ListSetFn(N)

  (* inductive graph type
   *
   * composed of an Empty graph
   * OR successor & predecessor sets of nodes
   *)
  datatype ('node,'adj) graph = Empty
                 | Graph of (('adj * 'node * 'adj) * ('node,'adj) graph)

  structure T = GraphTypes(struct
    type node  = N.t
    type adj   = node set
    type graph = (node,adj) graph
  end)
  open T

  exception NotImplemented

  fun empty () = Empty

  local
    fun ctx_from_node n = (S.empty (), n, S.empty ())
  in
    fun with_node n = Graph ((ctx_from_node n), Empty)

    fun add_node g n = Graph ((ctx_from_node n), g)
  end

  fun add_nodes g []      = g
    | add_nodes g (n::ns) = add_nodes (add_node g n) ns

  fun is_empty (Empty  : graph) = true
    | is_empty (Graph _: graph) = false

  fun nodes g=
    let
      fun f l Empty = l
        | f l (Graph ((_,n,_),gs)) = f (n::l) gs
    in
      f [] g
    end

  (*
  fun succ (node, graph) = raise NotImplemented
  fun pred (node, graph) = raise NotImplemented
  fun ufold f init graph = raise NotImplemented
  fun gfold (ctx, nodes_b) f g init nodes_a graph = raise NotImplemented
   *)

end
