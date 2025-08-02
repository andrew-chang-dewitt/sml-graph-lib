functor GraphTypes (A: sig
                         type node
                         type adj
                         type graph
                       end): GRAPH_TYPES =
struct

  type node       = A.node
  type graph      = A.graph
  type adj        = A.adj
  type ctx        = adj * node * adj
  type decomp     = ctx * graph
  type fwd_decomp = adj * graph

end
