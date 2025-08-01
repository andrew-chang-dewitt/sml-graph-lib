signature GRAPH_TYPES =
sig

  type node
  type 'a graph
  type 'a adj = 'a * node list
  type 'a context = node list * node * 'a * node list

end
