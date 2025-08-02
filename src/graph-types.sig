signature GRAPH_TYPES =
sig

  type node
  type graph
  type adj
  type ctx        = adj * node * adj
  type decomp     = ctx * graph
  type fwd_decomp = adj * graph

end
